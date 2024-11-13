Return-Path: <linux-kernel+bounces-408032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A09C792F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D394D285C56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B8516A94A;
	Wed, 13 Nov 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETD9WU0o"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40F139D19
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516343; cv=none; b=ko3zGNmWZNNpFUOrZC2KBucVJsMtuI6ThBaqPvxKTh7Co/CJKWDySv4b/YyHbZeY2Fb7kjHQDaOkjTB9jxITojSJGjM3bTcx1tJsn0dbpwuIYpFLP8x5wC/Y84zuNVeADaUF+J52xq6xwBsZjTDFKP98xb41KT8ukrV0ZvFReiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516343; c=relaxed/simple;
	bh=QTPjno+2Co8ClCqdkv3+r5AS/3KRpmu8xbiZeVLi6lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkRajU8DTskF04aQ6WbtQYIsV4yKmblfH2i0aqvRpYxbaI1RGHJa1fniLHwGEKvSF+bdxzUpN64n3+WEp/PwIR0/+eWtZ0VRHyQJtIlOy0L7WSR/cuY3O6isSGTyuvRcUXFqTjKFmla/i37Q5rHV/OgvpP4lDF9IIq4Qeqk7hVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ETD9WU0o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so61093225e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731516339; x=1732121139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1op2LOAlj+eAirTUXFxolzNN0nAw5qrpfB/86rSjz4=;
        b=ETD9WU0oroDs0hR+otuzxRWi4Ojl4kUEduwIN7I5Ueyq51m4xwohN5jpsE/DrQqbg3
         pjSxSjp2rlVS0nRlFlDbS5FnqfbNpwpCWr0MG8zEBipWLK9N9A9vo6qli6ge4qNK/LXG
         P8KYCFo5pbbwzKF6tuyXZ67Y1wOnr9HnN8yqx95FsK6rvujNCOBvZxoeSSbtWgnlpiN7
         XPKwHUvZ+b1i48sC6vO1cICxuF5SwZ+62gn0hAOyHlYJuBFA+egEG71yUJJfD20GRV3t
         HG/TKUI/0JZVz3ES9vHtwqvNDRCvp7wyIfq/VGPcC8f7cfUSPQ9Ut75DF4scN2+cg1mk
         LqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516339; x=1732121139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1op2LOAlj+eAirTUXFxolzNN0nAw5qrpfB/86rSjz4=;
        b=bMiCVMYfG1D4Lx2+aZfo55k5SGJ3YzH2FsQByzuGXsl1xU2wOkSCMpJJ/v3F/x/PqO
         m6ivM53V8TCFa23rYrMYoaA+tQvaC1CETUh2Clx9MCrqeAoIjmXpQuFLjpHUEKk3ue6f
         5yMDyq188TeGl9SbrBiLrlrPdERIzj/Q6tQH4ENfnVIeHDZOIzCv3O4KrBBYpoLkBP3t
         kddA7NpLzsZruBL3Vzwixx7fePFPfl88u3t+Scuz3vst8X4V4WTinxUwpS9ANgNgaqHw
         gWzljRlxOhZbnW8FXi2YGhrK27cRdT5lW8N/y1h7ixkbMszFlbUSCdpc2GUBX9Cpa+h/
         ahnA==
X-Forwarded-Encrypted: i=1; AJvYcCUZHAK2DftfifYOjRFm/YCsR9Zks/vzYkvIcbSjQoPnf7Le3xrzIKKNSHQztZVDOjStByQGkD2gH6eUYRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Me58c+trMs8BYaQfEsUTuK+XRQ21OVxlF3OQ855A7xFuG70W
	xNaW5SrgjpIkRiqXo6ZT0FVBF54CRcpIGVQMD8cowlSQNOTH+6tWCx/N17oezVo=
X-Google-Smtp-Source: AGHT+IHqqp0aFwxKahmkIFeK1sHiHkIAg+CVabKxaL5zjVLCGxDgxZwCgkjrpVMDOnlIOoeDiEBSiQ==
X-Received: by 2002:a05:600c:5107:b0:426:64a2:5362 with SMTP id 5b1f17b1804b1-432b7503dc6mr185962055e9.8.1731516339363;
        Wed, 13 Nov 2024 08:45:39 -0800 (PST)
Received: from [192.168.0.48] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f82cdsm31026715e9.14.2024.11.13.08.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:45:38 -0800 (PST)
Message-ID: <dd5a8b15-8560-497a-b969-d293c63b8bd9@linaro.org>
Date: Wed, 13 Nov 2024 16:45:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: add venus node for the qcs615
To: Renjiang Han <quic_renjiang@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241112-add-venus-for-qcs615-v2-0-e67947f957af@quicinc.com>
 <20241112-add-venus-for-qcs615-v2-3-e67947f957af@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241112-add-venus-for-qcs615-v2-3-e67947f957af@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 11:47, Renjiang Han wrote:
> Add venus node into devicetree for the qcs615 video.
> 
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


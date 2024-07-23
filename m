Return-Path: <linux-kernel+bounces-259906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C20C939F96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1B81C21EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619314F9EB;
	Tue, 23 Jul 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5jU+Izu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33FB14EC58
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733519; cv=none; b=MbIQZfbe/2NIqlYn2SKrLnnjg5Ff80SkzJcep45duldcmg06Y/Z89yvp4O8FrnyF5Tpu9SYoo4SFuywQz9NgRcdpMqB8bakRF8w/WP0xYvM5htH6rhuIwIGpL9K3R7QLVbKPN+McOyd+7/K+p0q7UEcQqF3d8Ut4yjvKi5DfXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733519; c=relaxed/simple;
	bh=kCsFk5C2xPxba/SRvpms2TUS40hZzgN+rLq9Pet846U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMPnS3PGbu71Mt3s2lrB6+bb19YLoNJiffZthpgGbOzZnW4BdTlD3dXNkvmyLrr1DellJZ0A+9XcmrNJjGq75yfD7K0LedBdNVVJma7TMcnM+vHV6g4I/CeealMqQWEO53YRq4p4GTHkfoSMTwZ+xbs6hnguth6MM7tu9vXdN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5jU+Izu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e7420697so83355966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721733515; x=1722338315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K8pz/FAf9Y2J7AWsrfobX5Hrf5irrouEfWs4xbMtYH8=;
        b=S5jU+Izuu3DPEjwciHJbablBfksXS7drgKlefX1d4vQ2vuvuTGO1UIG3vuBo3e4bDS
         ph5HV67tz3/fIFVgz18oPcSl5vQMxyNqeOnGBbSs/9PhReKQR3jHinCM5EPIN/XaV03F
         M+RaMrLfOIR8+50V3duhHH0a6r8gY3Eiy1y12cH356T1IG5XJATtn3cLFT7g5gBYetgo
         Mwdj9Y5xnCT7BuEm4SIPxB/ns0PJ7letG/lJpUIrYY6JHPv4EmoVcE6kvVgZ+36WzGei
         ahHGneTi5ymZ+/j6pxM+lzaXWsBLHtJTvE484Z+FOlg3MrZ9RsyFBG1O4Mi3MgXLUcKP
         wuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721733515; x=1722338315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8pz/FAf9Y2J7AWsrfobX5Hrf5irrouEfWs4xbMtYH8=;
        b=EvhSiL6O/QrZmPGaqaioQxgfdgv/M/namIUaSkoz5B7jordPQZ201QT6AGi0UiZlNL
         hGBoXJxRifvKbnec0/slhMdEWs2LMyaGpb6jZlAzSu2D0j1Q4UPIg4MZaHDX6aTs+v8/
         GnG3u5NgBz0ml3NrkraZk86EuquJkK2YdEyhn5gZYhP6IHEn8/sbyRbubwAsI37LmfYz
         HLYRwmGgUvQnFD3A44e8ebStGjfGRvEjZvDZVk4hlfxmjVqmnAtWYsZ4j9mt9GgUys90
         /GAgZu6aiftgP87Wwb6KIJKbyGd3w35eM52Nz/ORc8pap+V8PwhGcdkiL2w8cUR7++pE
         W3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXZoCw0VS+UOmho7/9Ow6Dw4MIQAhwmjl4eqJruaSfrH6JTIe2KMxj8c+WeriRmXTEa1tqLpAjbfrpBdsMSMyMr3f7vuerLptr7lu1a
X-Gm-Message-State: AOJu0YwFQF3ZknEDoMcBulg7JixoIZWLE4KyzDT4eDo9TOyCxsE+PfUV
	9ae0h73VlGKmc2usWtN2Sa1G09/G+iJStmRt6bBbtVqWFLGthVGm7Dz7c6AX40k=
X-Google-Smtp-Source: AGHT+IH+nAkhVaUuFpy0eYD4Hkm0wvZYu/TgIVWiiE/k5Ra+9jejRzLV7ZCLoUoz8xpoEdWHoADa0w==
X-Received: by 2002:a17:907:9714:b0:a77:c26c:a570 with SMTP id a640c23a62f3a-a7a87e35d7amr196478266b.36.1721733514925;
        Tue, 23 Jul 2024 04:18:34 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa450c188sm15632966b.34.2024.07.23.04.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:18:34 -0700 (PDT)
Message-ID: <9932bf45-f0e6-49c4-9d46-e55f66fee556@linaro.org>
Date: Tue, 23 Jul 2024 13:18:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers: drm/msm/a6xx_catalog: Add A642L speedbin
 (0x81)
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
 dmitry.baryshkov@linaro.org, marijn.suijten@somainline.org,
 airlied@gmail.com, daniel@ffwll.ch, fekz115@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, cros-qcom-dts-watchers@chromium.org
References: <20240722184314.36510-1-danila@jiaxyga.com>
 <20240722184314.36510-2-danila@jiaxyga.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722184314.36510-2-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 8:43 PM, Danila Tikhonov wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> According to downstream, A642L's speedbin is 129 and uses 4 as index
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


Return-Path: <linux-kernel+bounces-523407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B28A3D664
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F13F3B49A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B5E1EF080;
	Thu, 20 Feb 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="io+mADwx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0E1F03FA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046911; cv=none; b=ftkCtC4iVpIbkp9HkMxcHa1iqT60aGVAwaqSgweUSr0kZFfCIDbZjcTwKXYAIfW3/xfa6la/WNjjF+JA+qj42f0IKhPpaWi7fmR0g6fK9aW/v1v3t3y70vY/+b0j4xi7mb5RQfA0SkOi6PyS+hnvGwnPrglHAK7Okqly8wl0g4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046911; c=relaxed/simple;
	bh=XyjhOm+xipVatReiVlaqfkvcUF7Q4BsxkUSTUiAPmkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGcufOQfefU+nRcBhAPaThU1e3nQHciahWVr0SDKmVGW6UQLpnPFssjy08GkPCWzwf9/RwRBzG01DchFsluWbL0SQlsIZIS2k5hPld13bgwYsmwUu2Sn1Xyn4X6g6tUAttV8DF/Nw93zAU1DQ28sWWj1QL3QY4Re9n0bsmccs/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=io+mADwx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f2b7ce2e5so395760f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740046908; x=1740651708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyjhOm+xipVatReiVlaqfkvcUF7Q4BsxkUSTUiAPmkI=;
        b=io+mADwxYj5mfgYstriE/1LDSuMmkolzx+kmoWkt9ThNdfP8y96nmzjWAlgS0YyR1U
         pwlXMlI+H/bs/pIMXwF3UJKlXVsuNxKywKUX6DXYPQbFBDJK3me/p4Nw5poip2j+ng6h
         UynduJhfKmWzuD2o0+FBY/In1JbYh84/cCBlFDA7tFy+D6nAayHlLax3PZYQMR/fxjf7
         TWyQNQd6wW40lzDomg+UoZdIVT80IvY1wZ0smTNzOAAbBVekxnAP/Mxen7Z9BjY00Rbu
         Oy21V0+WCdaSDiDaxPCdGSGdVw1hvr6WsVw5/jQYs9/h3QEQ70z/5DMTAAdvXCTuJR4J
         pE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046908; x=1740651708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XyjhOm+xipVatReiVlaqfkvcUF7Q4BsxkUSTUiAPmkI=;
        b=TMDZ0tgZ1q2RCbJ7kbro+rFjVsgI9BvFaMeKLxkltJmGcZmKj4nQH0a8w9ETKw9Xut
         J0U3wgZAdq9B3dFN2dkEQxV5WfFhPkv1mif8DPVHU1vtBuWjimTHNnT9nT+Rs78ChStt
         uMZGDdlDUM3oYMJ1/YdJEhn4luFBSK8Sh95/RZN3uLnLXKMYSxacBKoubew/R6LkBxmO
         y2KHTIwTXc/AFSTjR+WTCUoQ2eee+B8uLp5islzjqMuq63N9i09IGKJvMIM1tsvvy/Qz
         lJgs7WugRHK9b/18J6s2cIyI60Gvp8WEbpeJN1f3PHBGoYdOXJ1MlhHsSetayl8l3Y4K
         TbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYvcEQzkGK7331zOz593V91oSVmZ0dfT/ixGovpLW0ApHsUEtkcxcR3vHrqIr8eLpCaC9nC6N+lmrxNi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Q7xaQuahel4q8ggUOZM9cNWS+LvWKkej+vGaKYCQEVSQJqTt
	7HDHqJDCY8Dfjnt7OZ8WUxzosbBpm8tWEehHhaaQQ7yEyfLcYIK/+URbdOWoToU=
X-Gm-Gg: ASbGncsBhwER+0v/Ifovm8UnpFFTQxY/1gLydnBYlsTe7qqGhtyjVzapfX2yFh9W27d
	QzXPL9sn9nhUIE2dTjwxKqSHgEaoxXa0WSYgEaeDJ88zJo1kzL9lf1UZAH2GD7HScNnCwmS7RoJ
	eCJfdNtB3ml5YzOWgGXBn+0JFjVBgNYbekE2f1Nw498T4c9lcCzRxHYZr4igFR/fzWS6HNf3mYr
	qf4OqiFFwnRNqFYrWw0a+mFJDZNTlBaIeMJ3/MMu/SqEiZX6hzcBTooveJOfq7IzcMVcNzyBmxd
	opZZI37xBiQIc+9S/mc3AGrnsBnTJuFyd03xseyyUo8HqtDqHl8xg0/g
X-Google-Smtp-Source: AGHT+IGafOD/Cz8KqZYx4HICrpiF57Ud5vJOpTpVhxH4dNw5EJOWaBQJT2VOVYJ5ILbnw6i7UI13wg==
X-Received: by 2002:a05:6000:108d:b0:38a:418e:21c7 with SMTP id ffacd0b85a97d-38f34171577mr17647798f8f.53.1740046908464;
        Thu, 20 Feb 2025 02:21:48 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7987sm19856657f8f.87.2025.02.20.02.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:21:48 -0800 (PST)
Message-ID: <5a86cb82-e313-4f50-a6ff-17181a2dd274@linaro.org>
Date: Thu, 20 Feb 2025 10:21:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
 <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
 <huluiiaqmunvmffoqadrhssd3kl2toutqtcw7rzamv3sqdglsf@7lz66x4sj3gv>
 <d4c4ecf0-9094-4341-8711-78a48e5d1344@linaro.org>
 <d444f1fb-42a0-48ef-83bc-d5aab9282b22@quicinc.com>
 <gzjyyl2kzv52zsewn5zf6ei65fymyi4pspvsmsjaqj5sklfxvc@bkg46saulni5>
 <fcc31cc7-67bd-4102-a53f-ebe66b4fd1a7@linaro.org>
 <3da96df2-1127-49bf-8114-282cc488c194@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <3da96df2-1127-49bf-8114-282cc488c194@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/02/2025 07:15, Jagadeesh Kona wrote:
>> Yes, its logically the same just done in core code.
>>
> Yes, this code attaches domains before configuring the PLLs, but it attaches PDs after get_sync()
> is called on device. As I mentioned in other patch earlier, if we attach PDS after get_sync() is
> already called on device, then power domains are not getting enabled during the probe, leading to
> the same improper PLL configuration issue. But the current patch series posted will fix this issue

That's not what I see.

The PLLs start and the GDSCs which depend also start.

Perhaps you could give the code a try and comment ?

---
bod


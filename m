Return-Path: <linux-kernel+bounces-576195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF632A70C40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F54189ABFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4217269CE1;
	Tue, 25 Mar 2025 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrY6guO4"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C3269B03
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938749; cv=none; b=CJt8mvqPjkfqi4tz+Bw5FPTvDEshsbYiijJD5Hj0J0ISCM3HN8yeXIQ9rz4WlTrYw+HB6HXaR0teCOgLAheygvBz9vcb5XU42tjJGU/ZFxuZIb88d/rmDMLmdYyvvjbfGnmx93FMn16+lHOD/BMZMftJqq0xBD2qHF98DOOvfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938749; c=relaxed/simple;
	bh=/Av7Cs+KayrhjqQVeFvAhc1FGTigGOhOF01svNTvIus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTorhO/U07AttzXSP6rcV2aL6R8n1oUD5ilwQvDAczundfns+NyrcaouvjBh0MCn3VxjeOE2+01JHPYmz4d8P/BqZvlMC3j3na8i/sxB8PmUzjF4YLxwbmgu4S8H6EqqaA6p/LIvzU0ceot1iu8YzeVdxuk9ak3G8nXrqlXt3U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QrY6guO4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so45626585e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742938745; x=1743543545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnMQy1sIVhjqG8H+P2Ah/U7DzsWvzK3schCpJEGDS6w=;
        b=QrY6guO4MSCbhtUAsvnLTopZBN1hnxhvumdYrSzzhufCRIld1u4Kfeqy6uLt10OewQ
         TPYAl3cQ16TAsE2qxnmpMb/aZDbBDMW0K1V7AFkvgjDSBmHMqPbulTcXck6UI4YeiyuF
         fInFIWgAHwdidLH83pEU7sht+PCrC20dNuQ9U4hOdi8fH6cm1Lo2VjoUIsEg/3LJdhcH
         ocDM6MGsUJjAO8n1k4H/xU0e6ymGApVRs+oQQ1hRsuoYkQ+XA23C119iGk9BuRYcfQ3A
         KwW0dhtfnlYSJ2bH6jQUlocQvCTRKF35qdUkODREzNdcvqMfsWhZQYl8Qp3chcb4baKU
         zsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938745; x=1743543545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnMQy1sIVhjqG8H+P2Ah/U7DzsWvzK3schCpJEGDS6w=;
        b=w2UWQxGLWVmI/k/4O+Qi5VBFLAW4wmeBO41kwdRCnz+Ke1I4vH2nT8GiCl/TvfsRNC
         A0M3wG9xLOWgnFpVM3X3TMOnPLUv2G01/ztK/Lp65BVtfhRLPDSdc8OOypdZFLoBtiPE
         mdBMBCAiYPKaW2qzZC4cGkqCEZ9xCaN6UKOwwNKmNxd4QX1B8J1JfJum2sjw6zcrh7j3
         096mMusDQM+JH2ekT0M1+f37K7jne0YjdZ57gfxlAjDB+CgSt9fNypd2K6NL/uQH6Urc
         gHNVX1HK76wTizYjeL5v5NWUjoxZFgkF+SP63QstkRWyOh7JCoe0tq/mPIL8e0h3ndDJ
         JuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmPlrZohAbZlQwshjNV/G9SQCGPfW+MMLes0A5aJhjkj+9sLz+Oi44/QrJZZ4/BZCNIy4Oezqm1hygowE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2UeEu/B/YPlNkSGRLiCWSDYjSSmhEPq9lEbLwJpKEgUR+btZ4
	8fWCOThuMgK8kqVrwDId6V/2P61loB531l6LxQElzW+34qrVwffqfEG03U/+c64=
X-Gm-Gg: ASbGncvfHIUh8t8QhpgPY5CuZ/9XitqatzkZPQVR3dsUqsN7vg+4skYx+/rOyxWxz9s
	yplRG7U58anw6ErRbjUkxbQ2xNw9ESer+Q62h/IsH8MOrMoPV6HJxdsDv3h2CBP3CLSnWtlsG6h
	exQ/3QdCfctccm72HbrxWx73t1/TifKM4R1ZB2Ry02nmmK+FhNkQ2nUW4jjy/bslpofD3OCg7VV
	IxpsdH6QNo59HEvh/yBE7KIMRv2QovIyKoXdCA5hc+o0B104GpkQADXnfn0wBgNdu1gMj5IblYu
	dqWIqPq4RhMqEvF7f7lIRrBdMGy8zjXLjdVF/HGz0xj7jMjoB71UgSoxsqTw4J4=
X-Google-Smtp-Source: AGHT+IEyyd8PC7FCDHlQIj4U+vOvGRq0sCf16YMi7BW8ixBJXbdk2VE9H7MgdgqHwWDw9UD6p4dY2Q==
X-Received: by 2002:a05:600c:1ca4:b0:43c:ec28:d301 with SMTP id 5b1f17b1804b1-43d50a3c7b5mr147764445e9.26.1742938745377;
        Tue, 25 Mar 2025 14:39:05 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d43f332cfsm216861645e9.6.2025.03.25.14.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 14:39:04 -0700 (PDT)
Message-ID: <b993c7a4-ff3e-4e79-bde8-2b5bdf3f2fff@linaro.org>
Date: Tue, 25 Mar 2025 21:39:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Peter Rosin <peda@axentia.se>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, andersson@kernel.org, krzk+dt@kernel.org,
 ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
 Christopher Obbard <christopher.obbard@linaro.org>
References: <20250325114058.12083-1-srinivas.kandagatla@linaro.org>
 <20250325114058.12083-6-srinivas.kandagatla@linaro.org>
 <vmhrs62ygu2xozcabc6tgy37ta5qskeyks5j3ldponzfijicl4@nudcmxonq7qj>
 <4654f21b-bf61-4b41-b073-407fab4bff6a@linaro.org>
 <14b7f2cb-6f40-f8b8-b3de-fe99080e6e40@axentia.se>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <14b7f2cb-6f40-f8b8-b3de-fe99080e6e40@axentia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Peter,

On 25/03/2025 20:13, Peter Rosin wrote:
> Hi!
> 
> 2025-03-25 at 19:04, Srinivas Kandagatla wrote:
>> I wish we could be taken care in mux-core or even in the deselect api
> 
> It is not easily done. A mux is a shared resource. How can the mux core
> know if it is consumer A or consumer B that deselects the mux if both
> ignore failures when calling select? Mux select is backed by a semaphore
> and there is no guarantee that a consumer selects/deselects from the
> same thread or anything like that. The onus is on the consumer to get
> this right and only deselect when select is successful.

Should deselect fail if there was no previous mux selected?

> 
> I believe the documentation is clear on this topic: "do not call
> mux_control_deselect() if mux_control_select() fails".

True, the documentation is pretty clear about this behavior.
> 
> One thing can be done from the mux core, and that is to provide a new
> API where consumers get a mux that is exclusive so that the consumer
> can call select/deselect without involving a lock in the core. There
> need not even be a requirement to call deselect between selects in that
> case. Such an API is what many consumers want, I think, but it is of
> course not really compatible with the existing API, which is totally
> focused on the need to share a mux among multiple consumers.
> 
exclusive apis would simplify the consumer side of code for sure.

> And, of course, someone has to do it.

Yes, I can give it a go and see how it will turn out.

--srini
> 
> Cheers,
> Peter


Return-Path: <linux-kernel+bounces-259907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9288C939F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120421F2304D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D514EC58;
	Tue, 23 Jul 2024 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOI8VeqX"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6E14A4DA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721733532; cv=none; b=GbOAWFwZm+0uxC+333sGtoGH9LRq7ADXjLz8aW7szVjESo2Ap9RftpqtAdoOVHbkJ7VRjE85ChIWzn9CnSk6mWSqLCp9hUJKm4X+tdMKYPikt8flpbAHT7u7GcCBP5HVV4tGOf43H5snN58SIryraypf8bJ/HaQuOfQlRgnhqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721733532; c=relaxed/simple;
	bh=Vp7V3IF/Ot0z3Bm7uzFIPNRfMYgFXd2y7cZ6zfqBK74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxGlqF3//Y7hcPpl6e0yvwUQkRdX31Ej3UYHjloC5zgQ2+KZnrndIgzzchXVbXB6KbGLon8Y6FigbdWTdSctAtn6skNgtHhDwEsNWXmQG1OtrMYZZeqzNSO2NJHARuaEVpFwrLiHYcjWvqCj68fwI1Ufb6Ol/BUk9eAaLit/DNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOI8VeqX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso24366541fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721733529; x=1722338329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kFolGW5KvoLUbpFl88RtzAVsMtpA+UoJdah8t87Ny1E=;
        b=ZOI8VeqXf7zGeOmBalIM7eKmBb0PALrK4HZH63/bQ0glFDZe3RktQ7Sa+IU/RQsujm
         fXZzd8JmhFiGrzgDHPln3tyZ1wUD5SOyYEr1jIK7/Jh7czSjbJHHki/guQgzADSG3aoH
         mm6GVPwR2xo4om7qWrhKnq2fUhQB0MuXlcS+558ll37938Z1dNNxBpWOYtLAAcF/7LnR
         JB5JO+vQO7lvdss4dBoTY5l8vN1ddYPMVVXsGv+tpdlx59FRM7CIqr+n2uJrLkQv0Klc
         RZcySPwoOutkC1wgqk/jT0AgG+DPIxTdK4PkHRHx6wh277KX4+SJk6GbDoaarWQRIF8c
         CR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721733529; x=1722338329;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFolGW5KvoLUbpFl88RtzAVsMtpA+UoJdah8t87Ny1E=;
        b=moEvWYSrhLboe4axtiKGqgBQ0Aa/diGa1u8H7pMvMH49tAN4T6HlpXsVRrx635rh3e
         jYXmcI91HMGkYXkFP+XrjCo26sqq9ptgmFeiBixuSz0WoF2vRWDP1zYRWkpp1l29dLVD
         eJ5gY3tZokpGZYWgq2dC9QJNNYpr4sdA91XShCSS8Yo9dHazhabUAmTONZuxwbFlqgC0
         dyfotIH4SBylvfUbTMJ+unGUCcl2bsW8aRc7iiMXN5L/6RLOT8viIVnjirCcTqCU5LdH
         FVLs82CyVy/0J9pqB8LBIbdKec+Ayoo8cuYNY2k7C3cG35FTfeTlyc+Ef61Koq6753Uc
         w+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUARHiRSn7HZfhMloQJQRafVoRgE3kW7T4vkdGYLrEPc1E9efdwsQpNztp+YXmq9ar/1C/cv/UdmKvK3eZm8w+H7Xp1IWZ3/gQ9OxnI
X-Gm-Message-State: AOJu0YwCZJXTXfPW87F2SPktqTu/tXmoBI28Z5PdXaTuLnUmwcTgdm2u
	KLs5tP7bRVIzplM8+HcYBR73hAjLy+MMzhpq817loI96tJCXQiAqR68noXbjQ8c=
X-Google-Smtp-Source: AGHT+IGh8ROLZYy+YmkLstU1pE8fBMI6VzD2hNGUxS476G6ZpE+5Khphj8l5y5mfEcxQaVxTwFRgzg==
X-Received: by 2002:a05:651c:104d:b0:2ef:2247:9881 with SMTP id 38308e7fff4ca-2ef22479eb3mr68564041fa.31.1721733529173;
        Tue, 23 Jul 2024 04:18:49 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a7661b26c4sm3497845a12.26.2024.07.23.04.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:18:48 -0700 (PDT)
Message-ID: <47fb662f-cff7-4b88-b960-af9733feab45@linaro.org>
Date: Tue, 23 Jul 2024 13:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add 0x81 Adreno speed bin
To: Danila Tikhonov <danila@jiaxyga.com>, andersson@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
 dmitry.baryshkov@linaro.org, marijn.suijten@somainline.org,
 airlied@gmail.com, daniel@ffwll.ch, fekz115@gmail.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, cros-qcom-dts-watchers@chromium.org
References: <20240722184314.36510-1-danila@jiaxyga.com>
 <20240722184314.36510-3-danila@jiaxyga.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722184314.36510-3-danila@jiaxyga.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 8:43 PM, Danila Tikhonov wrote:
> From: Eugene Lepshy <fekz115@gmail.com>
> 
> A642L (speedbin 0x81) uses index 4, so this commit
> sets the fourth bit for A642L supported opps.
> 
> Signed-off-by: Eugene Lepshy <fekz115@gmail.com>
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


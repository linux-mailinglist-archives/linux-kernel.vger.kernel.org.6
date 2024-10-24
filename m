Return-Path: <linux-kernel+bounces-379823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE1D9AE447
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F008DB23A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F01D357A;
	Thu, 24 Oct 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAlEuUI3"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59331D174F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771083; cv=none; b=qe+TpKgbJJP87P4qmjQImAIt+ii7txM+VMFCtKBp2LI9xwh5fLUd34aCBsXiOHqN1P57jgrAAlinpICihY8EoZJtI5I9GlBqDEy5cy42swYXWUxIHWsDkVODYNAV/wJwMHwd0faNLXoBsMYDvRLmhR3MZnPfG3dmKLTc/M5Nqz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771083; c=relaxed/simple;
	bh=TMwKFmIXmqzS5x4W1yplBkSZ7GLBkQ+WVVyIQYanxFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HF3EIEmugHrXDZQ8L20CAjihhgmMtx3u3DUEvTaM34LKw54IesrEcZ48xcxV1RjcH1gSbukokKZqA0VJ/NRzD9TRdQeYtLalye4x/xV8xN1zBWlR1sS/zvN6zsXOzZa2AE4H1f3PB0GfwR9UMX/36nTLMCAdA9KWP6tOUD3dQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAlEuUI3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d518f9abcso584279f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729771080; x=1730375880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMUh089hk0TDYl3i02fhUTGpVWWZ8Xi7jhCcIpeuQK4=;
        b=CAlEuUI3V7QKOaG9Qzp+wOZsa7Z7cPB9yx/+o4/ID6JRyop2mG29Vv2drIhKy5uRNr
         D/BCIyhiBpccj3qIViCuMdBRX5dA/JXI2qAUCviRGSAvlzwdUvDJA5i/m1atS+L8Lptm
         E0YkxtKj7ORgVuWkRodKMc/MyK1/PAwKkmTTi7lXQKL0w4IVPN2yLvyiy1AVKtt92Qj3
         M/Q90Bd6bjIWKOCrRa9hZgBvl3K0cO1qpzKxicky5wXqYRRBVsVqvt59K+PBwSLZMXJJ
         Almt1l5t3MZFNhdhvIcCZqknYZgWEn2+69hanW/LQWH6tVduUq3k6aM48MYZ1gqvXWAd
         qQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771080; x=1730375880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMUh089hk0TDYl3i02fhUTGpVWWZ8Xi7jhCcIpeuQK4=;
        b=AyGNzNxkFfPUmMhEVrvcrfLwUlLmqaIGymRfb148KxwrZtdfxj5at7d7aRnf/P7yHJ
         g428nc0I8/jmKhkkRK5JRJ/mx8gfcQCEgAK0Xwtw27tRx08+lNaavjhqbSNJi6hDJ8lL
         w6zsxvxnaOTjMrZZ6bGa11Z4UjCLQzngPr4drIn03gZCMbrFdYZZHFduPCq0Xy+DilWJ
         k8aWudxDUzfISnIZ53CvcJHTWs+v8sROiqEzQngSaSsvrGm0UKgERE7GUF4Fx3RtOgt5
         Zukc3JhuQ3xZbqz/0TFDx0P5Pu+QWoyZ4rxHHG9UzCGgvO4hSBhssNIw6z2FbWjYGsq/
         bj0A==
X-Forwarded-Encrypted: i=1; AJvYcCWEtIOrulzVYj6A3t/GOlpqN6MFctGR8kIukrqYB1oqPWorGemAMtSZI4g2vRmJAeAGjupGuG0KiES2W6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6HNH+2jihGwfd8hFMOjUrC99mVDnJGsGrOywwDZz21crkg1t
	99wJ6EnPKZMqZNqWYYRFDU16l98clthY/qDbdk3cT5hxPgYJ2idGhOJeN+aIApk=
X-Google-Smtp-Source: AGHT+IHwlD/N8thxGFMjsqeo2hByECDuXyX4BJqwX5km4H1c7VJRNHwwg6KxA9EAfXdb3TGB+VJIYQ==
X-Received: by 2002:adf:e848:0:b0:37d:398f:44f9 with SMTP id ffacd0b85a97d-38045898b4emr1354687f8f.32.1729771079896;
        Thu, 24 Oct 2024 04:57:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b4dsm11109750f8f.18.2024.10.24.04.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 04:57:59 -0700 (PDT)
Message-ID: <d7a2ddee-42c5-415f-8b7f-b7c21aa373a4@linaro.org>
Date: Thu, 24 Oct 2024 13:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/lib/thermal: Rm thermal.h soft link.
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240912045031.18426-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240912045031.18426-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/09/2024 06:50, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Run "make -C tools thermal" can create a soft link
> for thermal.h in tools/include/uapi/linux.
> Just rm it when make clean.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


Return-Path: <linux-kernel+bounces-550618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83CA56211
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689867A62FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF81A9B2B;
	Fri,  7 Mar 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G85GjxPh"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA61632C8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334046; cv=none; b=LQT6Q5A8DSJgNTe1a95Y8dTe+uki5U8WQ121IB2H9TtxOvZVP5a/AkHMS/dFAbHHFvk+9kKU1AAkjgHASCTjtrArMRoSOwEQTVbEWBmCsYoD6uWfEYm1yqmXeJ4oUab7QdqwAwU2y70m/u9WsnsmkfFAelYZegBx9hLn9EP5hW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334046; c=relaxed/simple;
	bh=pR/IPm52Dmzz7euqedDIW/qKpLuxfuVEAfUk0HQW4Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNVtYAMqzx/EANTkXxC9OqXK9bFOUsmEOrkiac+Dpmm6ZYyTm5oOwqwmbs2QHeYM73I7CwDzXBA8plXbVrVysK1XUTOUTokd4zs/vThq77Cb+rErBLpXtQlNcXTa4+YkDTvpTvp+v1DRDluN3UaSOePWj5BALtM/fPRBMYgjzSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G85GjxPh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390effd3e85so1401608f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741334043; x=1741938843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jivBZbbpeUpC37vr59Lus7C69ZvI+/qcef+nWtlt/Z8=;
        b=G85GjxPh5tBYTBULDd+1PWFUqSKDOztUofZZ8JaXfCDtb2YYHOLX2UyhWmTV2aH8Ih
         h808l+8d80Y/hsLWUDoVF2mEZk1GjgpeMTrDVSqtpDlz3woDrWVVGCzLaScaqxoiZkF2
         COkxStDyBJ+X6/EArc+56pSyuP5jnu2JxFwiw6fcp4jFA+QoJ4hsM7++0sIm+eZnLInp
         sJO7iDbYGbeghHBek/f3lSI73yabZD+G9UwRL1mjYRcHgw/jjUIXlVXbQP5FvU4S3qgj
         OIWVIfBkasMmMDTCfImFWW3/PbHZ83tbPqU5dXnJKTitAel1DytQPf7NI61nQaoGVKP9
         mcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741334043; x=1741938843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jivBZbbpeUpC37vr59Lus7C69ZvI+/qcef+nWtlt/Z8=;
        b=tjoiACuWoMYyx+/e4JdvovBi/354uE5BJR2GYnodX4IE0tbOl7+itdugpDkoTZCVpI
         v6Td4MS/vfwbRNJvgbn/OXTkwLk0hGJ0hPnyzaiEyKBWqY4rEebcdnk9qn9IzKdYAuim
         0OaIdAYvj87cc1g8WNR3jDsq9NaKsSkHjOxLBD/1wSe/4jQAw8lKSdR3FxufGd1xiB3Y
         2u9oISp/Pgghap/+4SEd8tXRcLYBGeOs8qc2cgQuUZVw9Akust8Gy2ZQ44aPkugcOP2d
         nLFxrYU21gyhpMRJAPfxIkAVMySZ7zUvP5trqAOaEC2c9q/mK7JNQn5bmnMWiEXCXFzg
         2+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq2JryR7rhaAGFKwbGsq47FX6J2a8Lfy9hLncxCALv3JrnvmfSMj5dJo/v1uq3L82MLjODg+ihe2ghYjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTW7bCMAhXobUvfebLYaDi2OtRq8QJ9p/6hCDmcZrsq5qZ8Ve
	f4pIp3GuYEhVcbkL8xQ44L9CsjqqWACSo1pq4SipmaSdG7zyVl8UYrLXgDn/HK4=
X-Gm-Gg: ASbGnctBdkujxnJR5Oxx5EbIpkUgGsT9QoWPaQN0qBAZ0qM3POvXt4pjylf2RO5gGcg
	seyGpJmNuugcxhVqB/pCtTCgMdu5DA8dIU+tOd8bZliGimNKkXWjGrXEJ7D9z7xQaAVDCzU/oto
	PH0t8dHPfuv69acEMsujhZKOucrhzUKaVroljf3qJPly0R6RM3Xc0x0s5olSznqy2U4bFhzzQBz
	F/A78gFkTtYR+EjFG9LFTRNj/6SHeaZBFkuDRM02JbywQ1ENsShSzTyY29N8puGLjpdx5phLstK
	Qpj561GGsXrfxLDRw2dkUfOnoqtXSSzN8jv2pqNGnygY1AE4hJEoVJ5jdIMYbO4d5VPiytL+yEy
	C7ZMmMbW4
X-Google-Smtp-Source: AGHT+IF84dx46mQjSLVGU2fwl0MIMB+9teoe3MWhOKYeBMQn9a4+JteyS3aCEq/ZWOCktwprXzRy4w==
X-Received: by 2002:a05:6000:1884:b0:390:df83:1f5d with SMTP id ffacd0b85a97d-39132dbb4efmr1337542f8f.35.1741334043195;
        Thu, 06 Mar 2025 23:54:03 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm4579617f8f.35.2025.03.06.23.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 23:54:02 -0800 (PST)
Message-ID: <b651acf3-ae10-4f70-a879-3b5d6ff39b02@linaro.org>
Date: Fri, 7 Mar 2025 08:54:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: stm32-lptimer: use wakeup capable instead
 of init wakeup
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, tglx@linutronix.de
Cc: stable@vger.kernel.org, alexandre.torgue@foss.st.com,
 olivier.moysan@foss.st.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250306102501.2980153-1-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250306102501.2980153-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2025 11:25, Fabrice Gasnier wrote:
> From: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> "wakeup-source" property describes a device which has wakeup capability
> but should not force this device as a wakeup source.
> 
> Fixes: 48b41c5e2de6 ("clocksource: Add Low Power STM32 timers driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


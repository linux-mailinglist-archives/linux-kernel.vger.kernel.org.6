Return-Path: <linux-kernel+bounces-512394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B9A338B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BE616855A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6622080D2;
	Thu, 13 Feb 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nr6PcTii"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD022080EE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431227; cv=none; b=nCKQS+EPxTigw6wF6eukp5Tdloo2Mo9bPWCKqHrVi88vSyyI01ElqcLgCjUgFVxZgbbh9IAl6z60ZnoJvbnUMeLyA8uSNBEDf3WMj2e2bInVH5AFd4yimf09bAfgh/8IqYdoWhRS54iQ8LvcmNFzW456Wjg1lwksdCEVB1Z7v4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431227; c=relaxed/simple;
	bh=kUlydEpuFrGUrydFPT1DYlM8hxRj3C3viQCBSEEaXH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=buk5YW4un2MObQFB06NLpsqoBbzQwOmalR48/REu6ZNTFIiWwSjnycSCe5ovdZ/tOHAcTdpC8B+kougk5kD2YNaOrN4PwGjRumikzNUdU+ctCeAV4vnSbgKZvooGf8CPbak90RxUu6Gie/vBW9agxY0m1t41XjaKS14qKjM4YiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nr6PcTii; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so1070050a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739431224; x=1740036024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kUlydEpuFrGUrydFPT1DYlM8hxRj3C3viQCBSEEaXH0=;
        b=Nr6PcTiiRkAnY7LZWY3BD7ITa0OAQ63nPuWz8zsBbFTLOPUNrsIkYqvF8X8k1HYn5B
         s69fmWAKB0t19xG6FosNmmz0VdH9/ZQodTieQOqpwyL3OVp0MA2V22E3Q+P92iT/t+HO
         gkvf3Xkun79sCueZhRPPUsKCCIfK8ly7iTKpBGiCiaqt1dDoo3SLLoAWh78N7SSUBgN5
         LYO7BaVph6XbiwvB9u5Mu/pImu8QHLCU9jSsjM3deK4yqEWC7g2tTVfmh9FpANWHwDbh
         ZHbrnF6TnHXgpd1wOSvH+j3QSxTmxIIfm3qCclLVh9IdxDTE4ilDlRucH0ZUBka1oAPh
         roYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431224; x=1740036024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUlydEpuFrGUrydFPT1DYlM8hxRj3C3viQCBSEEaXH0=;
        b=G7lBLxBagnzF1sdBKvJi4mfpBQqvRzSZyfhLRx2LCdqM5xddU62Y7iO2stpfvpbzJc
         SphkyW8NdPOMOKkUz3UNiJ4i83UCBmZN9X7etdY0Y6U1XpjOGgXxm/2avRQ1plZeSvU5
         ln//QDmw7AUptE1UQhb0+Agz4xWPgeevNQwOzHe5WYYKtmjMup+kUAfuhV9rzdbOuiiu
         3ghet1iIM7vgsrPAhsda8qVW7Boy8T3d5IGK8g1PciNvGrpM77q3TUGnQxUmES1GKpOz
         1CAT7YpOhZfBClgmLn1Z6t3JKuuEN9rMBcgg02GR9nqAaYI9+S+RJ0ATKMkBlnH4L3tF
         4EEg==
X-Forwarded-Encrypted: i=1; AJvYcCUjwBDtZuJRaYed3RSGlrLv4npElNgCMjAuVxtSSpjlYaXOlyVaNthdEzGVI2E34umDRgUhNMNmngy0H1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmp0hGxY5VtoM9ze9b6OLNRtQilSWULncU13XRhBJMWdAhXNGq
	tOEnxHCQ1KEoxmbgUPAW3NlQIOIO381QKm18zR4u1HKFHMkiXwvCjC3ww5/SGBU=
X-Gm-Gg: ASbGnctikhsQgO8MnKrWsN/Vruu3lsGM97//wRGZtN3g/DwocjOZoLpITgy2d0DhCOX
	jPyb8Lyv/WoY00HXhcvgjRBfUX/47NY2dvvIuHClWn3Ke2wh+0uNXJqhs5FWfXr98N+5HKUPapS
	fmofOPyuPUeZh2qWYtfvX84g6qtbt+FEhL5eFNMsm0jr1FbTrdo+KxrrAVIbM6cFgYlKVhUfl5E
	IVwiDYtc7jDn0sE2TGHpJclxwNQfPdMaHsjC9OT6dOu2NryilPcQ2J5n7Y7slAbEyrstzW7nqpQ
	CFSn8zWcFURrkAYqAshoyJOB
X-Google-Smtp-Source: AGHT+IGhPxIg59b6w0WCU7iMGOfAb73XGY1LMG+4SX9yxgvaUCg2qqNEqVjigzMYlqAJgEcHDBCS0w==
X-Received: by 2002:a05:6402:458c:b0:5dc:abe4:9d8d with SMTP id 4fb4d7f45d1cf-5decba62fcdmr1363256a12.9.1739431224388;
        Wed, 12 Feb 2025 23:20:24 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4687sm674664a12.22.2025.02.12.23.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:20:23 -0800 (PST)
Message-ID: <fc341dbf-3add-4728-9ec5-7291ad3bcbe9@linaro.org>
Date: Thu, 13 Feb 2025 07:20:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] dt-bindings: serial: samsung: add Exynos990
 compatible
To: Denzeel Oliva <wachiturroxd150@gmail.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, semen.protsenko@linaro.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20250212234034.284-1-wachiturroxd150@gmail.com>
 <20250212234034.284-3-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250212234034.284-3-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/12/25 11:40 PM, Denzeel Oliva wrote:
> Add samsung,exynos990-uart compatible. It falls back to
> samsung,exynos8895-uart since FIFO size is defined in DT.

doesn't the 32 bit register restriction apply to uart as it applies to
SPI? If so, you shall probably fallback to gs101.


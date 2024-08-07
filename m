Return-Path: <linux-kernel+bounces-277770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4095894A641
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01232812FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C81DD396;
	Wed,  7 Aug 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWfDEtyM"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7D1B9B43
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027797; cv=none; b=Av+eD22L+bOiSvCPADTX+C+bQ0WUKXFeFklhGPaH60xzb6SwWNEUx2uZpWI1yZ1pct6EOLATjXceJEG4VF8H+QXycWxK8PP6mID+j5ZITAyudQRW3OgdCspXk+5LDhjgiXGDvF5lYLshon8m4P8qYJevVLo0X1eRq/7PU+EUnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027797; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ltX0qohz4lNpQ66Rlk8nJ74/emNP7Kxxhdz5PdLvmQvCMQpbzIF6f1iW3eIx6INgWCfBDRO47PfSciWUi3Of19A6omeS++lXEAClwJBBs3Fz4cEzz9CMr7h3162NdRH6uoGkOx7UQSGZsB0VYB2vmzqGQR2uu7c/TtXlasBK29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWfDEtyM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so1115701a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723027793; x=1723632593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=wWfDEtyM/beeCPTbINvS4LR/qV0buUOnoBe/Qe95we9QrBT9LxnKyy9LB3UAi6Nm1q
         rq9uQq3q8TafQo6UAUJX2twF5mqjs5vuW2rb/w5YX6kZKJdwJLjPknZmC+rav6Lq2g2T
         Cz4eiZVXy1PCEjH8D07J2R7wCK1Z3c/w1LwEnVjlVvAZahXo0rRF+nb+7FIa5ifgvvMP
         sk8KoQKLwByVMUMAhu4crfSHGDoT3LIP9egLDkUKCCUv0F7ajeXjNq2MqLqTCNBpLJqr
         iZ7yEWOEYiJvVzk0l449gHdSwJGx1qf1qx6sMhyvaeMQ+8VlhDKw9DGzXOe0SOLvfPBC
         0Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723027793; x=1723632593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=ekjJGVz5Q1b06j6kM1pLleeTNyRna94uD1/cqwuI4sZumRzimiYLSHEl5C9Vv9BVSv
         gqwogqXytW+emVc9Et8uZr0eC3hCBCGRMh1FAU/9mNzPRT/ggh0M3sh1G3JTL6NPvyFy
         Mavsf2dHUoPAkLoaPOyrFp2MH4QlmkrO+fmZ1ArKEYsbUaS/m3Hs7Bo3nu1Ixigv9Y0+
         HAKeuzyidts3ElfwU/KBes9+r6d7RgBXgNwZBl+KLmpMPSvzIKHkfdj0xXFF4EUGSFfN
         XFQZLL/jqp9OnSGXR1mpaEEBNElSzXaIMW0zTsh6fo2OcUJs0vooq2u56dhaDpS524Xv
         vJug==
X-Forwarded-Encrypted: i=1; AJvYcCV+x84MdilG9GI5p9NtWLKOw3SmEKtOq0vBQo4ZrEpBXaG8QeeeffKE71R65ovQ3qxOuhup/rV7MVjVNLQUSAGUFXxrET4Qf0XT/v6Y
X-Gm-Message-State: AOJu0Ywcop5C6oBjHNajW6CUDCTf+cjL0DQMZTx2cwmcQdWX/VldDxLG
	kZdPs7Ydrz0M7PayeRq0YlRFarDdHfcbd/2SgxMe2Eci4XDIQQHhabzIt6KnBHQ=
X-Google-Smtp-Source: AGHT+IGNiGCq3xQ9xD/+A6JIjYRH2TLuxM8b00m6SfTS7ooJvqyRwtUE/xU52X3j9tq8YE70TwQltQ==
X-Received: by 2002:aa7:cc90:0:b0:5a1:a36a:58ba with SMTP id 4fb4d7f45d1cf-5b7f40a92d6mr13263700a12.20.1723027793303;
        Wed, 07 Aug 2024 03:49:53 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839716490sm6940820a12.5.2024.08.07.03.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:49:52 -0700 (PDT)
Message-ID: <7e18004d-e721-4223-a0b8-1f7453cc99cd@linaro.org>
Date: Wed, 7 Aug 2024 11:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tty: serial: samsung_tty: cast the interrupt's void
 *id just once
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
 <20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


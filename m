Return-Path: <linux-kernel+bounces-194158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102478D3797
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A311C23A00
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912A12B82;
	Wed, 29 May 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cwHVbGQL"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3112B73
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989330; cv=none; b=A4Onwtmqp8mBDSMbNXwdQzBCjGTwVZGRh8fjje75KwLQeKnsyjojlJF9zGMnvQZg1fDVE6Uw7/hlIm1aHACRGTW/6eo0JWAoJQgaeoo+GrU+lX2KLyKD+U2C5o9OVj08WQiqAO4KabJ+flcFYzQSUPCVAusr+cv02WW+HJtQtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989330; c=relaxed/simple;
	bh=p/oqckoilHDd3nwrPNG90Eb/yDiE/NNkxmvgpHkUi5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opw3WRw3lcHkVxhBfRiwq635+8HnN7MuoreEnPV7qnD6/8c1VAHkH4ggzEGj1JGY0InzRGI9opkuavdHxVP9quQ8jH9TFDrNPooezzsB7YsAfw/Hs0Q1gxiHFLq2PMBzwljqCrOdgmKazsvdKPGTNcZ7ZWa0qfTN2qCXn+sgDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cwHVbGQL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b03d66861so719960e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716989325; x=1717594125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXmr6j/tvonQwkWDxBgodd8VSD2h8lNR4zZeNwuG1Go=;
        b=cwHVbGQLaqYTIG4lMoUvO1wDmxJfptHMbRaLZk4qRpM+vykkzSaisTuxasbv4eolYV
         Yl4PbA05EptI3p81+l3dZceaYg7neUy1Tg3FPKAiPvrVR5IvMLyWDuIZ/9+oHYun4BP/
         kSuZ8C/7QxC5oNdA2F9NK9Zi3PgDW16KAKp1NvHyy/siY9sTBdi8kQmyyQcbfplwoRYV
         fFvYK0TZ9R2XoGls/yn57iZpi4786uTY8lj8JdptEAbxuJc4W8GG1XmdgKmuoi0H86nL
         DqMQdl1sJOJo1D5iRxfGWZS0l5B5mxxOzzncJV4pNVd/cWyna5M7CutjKNEdokFNZD9r
         mCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716989325; x=1717594125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXmr6j/tvonQwkWDxBgodd8VSD2h8lNR4zZeNwuG1Go=;
        b=v5rzZV55ClmJRBNUdsYbtQyq2l2JcaSKdKtBACd3wAO44PQTGZ9Y5sijGuQcXWxHLa
         dbQ97M2dFC5ZREGDdFZBC2oEQbh6bGRCtBvQmYM6FzPJhlgymSMsWbaRikMqeOPuz0Gd
         te42539QohbH9FzhWDddGQ5nWhd3QbcuKbH9K0hT9osKHhbzb+XSlfEuchOCSjX7cp82
         sjKX9pkfCmwIgsHssX1JpAOuHRYJTbBruA+cqNbDosN9MA6X0uhZVYESOea1CTB1JQuf
         +4gpNpViDH9fEtmiYC/G1UNtkOCZohESA2q4sdTQSOOD2cbS5UM8j9bC8pxd+hjcP//O
         Nhyg==
X-Forwarded-Encrypted: i=1; AJvYcCUjP7Tl1zspo4I2j/EJ9MfR19kHCuxsIjmxvXANcHCRz2R//jnutluF0YS5PU89E5GKwdaVtt2gskWis9gusJs+U/a++eNMylmajWqd
X-Gm-Message-State: AOJu0Yw+xeVqQ3ACMRZDFNOse+dq+RPpfTHDLqXx5r1hXvvbB1VzjClV
	GdEIKldIWUUd8Gv0AhkjW7rEQu/zkaSZrmGmK02oSwdbnGnREVhX3WMp+ZRb7ek=
X-Google-Smtp-Source: AGHT+IEq5J35jp5oyjSaT4U2EpNtDbrlLRiwcYvKIzo9K+RuuN07fUdxYFnLzwmPTjwExZKBrEuQig==
X-Received: by 2002:a05:6512:1042:b0:529:a389:f6a6 with SMTP id 2adb3069b0e04-529a389f747mr9715451e87.67.1716989325376;
        Wed, 29 May 2024 06:28:45 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7276d95sm3726512a12.78.2024.05.29.06.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 06:28:45 -0700 (PDT)
Message-ID: <2095a4a2-7db5-4de6-9609-d8e6a5adf27f@suse.com>
Date: Wed, 29 May 2024 15:28:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/xenbus: handle pointer to NULL in alloc/free_pdev
To: yskelg@gmail.com, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: skhan@linuxfoundation.org, sj@kernel.org,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20240529131926.29590-1-yskelg@gmail.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240529131926.29590-1-yskelg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.05.24 15:19, yskelg@gmail.com wrote:
> From: Yunseong Kim <yskelg@gmail.com>
> 
> Modify 'alloc_pdev()' to set 'pdev->xdev' to NULL
> if 'xen_pcibk_init_devices()' fails. This ensures that 'pdev->xdev' does
> not point to 'xdev' when 'pdev' is freed.
> And modify 'free_pdev()' to set 'pdev' to NULL.
> 
> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
> ---
>   drivers/xen/xen-pciback/xenbus.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
> index b11e401f1b1e..f1709b8e284a 100644
> --- a/drivers/xen/xen-pciback/xenbus.c
> +++ b/drivers/xen/xen-pciback/xenbus.c
> @@ -54,6 +54,7 @@ static struct xen_pcibk_device *alloc_pdev(struct xenbus_device *xdev)
>   	INIT_WORK(&pdev->op_work, xen_pcibk_do_op);
>   
>   	if (xen_pcibk_init_devices(pdev)) {
> +		pdev->xdev = NULL;
>   		kfree(pdev);
>   		pdev = NULL;
>   	}
> @@ -102,6 +103,7 @@ static void free_pdev(struct xen_pcibk_device *pdev)
>   	pdev->xdev = NULL;
>   
>   	kfree(pdev);
> +	pdev = NULL;
>   }
>   
>   static int xen_pcibk_do_attach(struct xen_pcibk_device *pdev, int gnt_ref,

NAK!

Please stop that nonsense. NULL-ing pointers which have no chance to be used any
more is just adding code for no purpose at all.

Please don't send other iterations of this patch. You are wasting review
bandwidth.


Juergen


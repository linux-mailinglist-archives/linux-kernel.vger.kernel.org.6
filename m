Return-Path: <linux-kernel+bounces-304360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F57961EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301CDB21C49
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8571547DC;
	Wed, 28 Aug 2024 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAolvH82"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1091509B3
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824560; cv=none; b=k5UGa+ilPfbihQdAppB+3CFamZ3tV/BNJDw4hBTeJhUjD3ZGcdC2kTehXU+uj+zG2eirFro68V1Ld7w0EJvllVIYryMhf99uCCtnez8j4sm3U/pccAZrDh+zIc8Sff+hi/fDO8s0VqSUEoU9yFydgzMeBqscgaDeFCGgtPxJrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824560; c=relaxed/simple;
	bh=UVN+iYH2WQrOD2OctMCFlNawZqXMHfymX92W0VyAxo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrMmBF+FkO5dGAPCu6OQGlX7EzwuS+43nfdS4uCXHyrgQOPO3VqMLxnv8AT5qDP5H+C5kQK6cIZP97eafPyVqHSajYff7mak9d/qEwD/7Y2TjGgXwgxOLbq6UaPdbwVo3aN+uux7hwuSEaRICw/HOV31maHWbrys0i5dS8H3QcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAolvH82; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5344ab30508so258698e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724824557; x=1725429357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eMAPujVjIzNJoCg2Hmkt9ZNH3A5xa/QzR9XKYRq7+Q=;
        b=BAolvH82xLyJ/hnhLxQutvXuGZURV7Y35etGw+tkb9Q3/hJnR9du3oGxAtJkaQ2AC2
         GFJvizVbE3o8IZs4jeXl0jkoKzFEym6f1qfBO5jLXyNBH9iDx8mZ1f5QwiqJXUrsXncl
         bADMZzvzDVfk8oXpejJ2p5At7RNhHhzyBnQqb1skAwKrSWnvYRt2nTTRywiOst2bd8qy
         LoTpcnT5Iizbs3tX7bKPACiEcIBQtgCXwa7hWhnKrgVppcO4Rp1JKgtWPSoKG+BO9RPS
         vHi7L71OoaxfHJ5wlbmAShYU2iaXdmppOIpz9/gttS7eAgR0Z5NS+f++5k7bFRYe5He9
         SBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824557; x=1725429357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eMAPujVjIzNJoCg2Hmkt9ZNH3A5xa/QzR9XKYRq7+Q=;
        b=SAWDE0UTb7VCU3O582l4QE5XoOszhcYADkiReAPT4/2BS4bgk3+Z2Jseh/p83zvFc8
         YDW2+IoPc4I+aMXoA4LEnuYNkpk/uwIRj7jYt9hu/r1Z8G5uH8nEKhsonN9Gjdl5cmgo
         oCAwyBB3KEWc7IjWXtmRxPkJ8e2nr4f/pKpIW1q9UrJziGy1FPltPw4Js+64CQ5QAM7w
         yVuAQ/iKDpdGMS9tDfaxeZ70RH3k8pmgf0OERUPyNbr5WcnMFwqB/L0Ml+DFGto8Or+R
         LZa3Ol8GwM6isuv7um7vQu4JthWaxxrw7eoopS1P1IwTZuu9M7YI8dl37Ax6+2+N222H
         oJCA==
X-Gm-Message-State: AOJu0Yw0w/6iNWRwPTKnoxVquT90sy5HM3mv/H1eZCoMX6A6HXgAKN+a
	7bwTUMFFmZABiC4V38ve5XR2yUqirSQaeU47hOnqAttUl9rWVads
X-Google-Smtp-Source: AGHT+IHLCZAOJjWElySp8JEXrvbmLmeovvriYJon0+DczkPtrRmYrQz3ey7AqASv84VXWON5fCak/g==
X-Received: by 2002:a05:6512:33c8:b0:52c:f38b:41b2 with SMTP id 2adb3069b0e04-53456748664mr306516e87.17.1724824556413;
        Tue, 27 Aug 2024 22:55:56 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d2dbsm2047675e87.195.2024.08.27.22.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 22:55:55 -0700 (PDT)
Message-ID: <e341240e-1c1f-49a2-91cd-440888fdbda0@gmail.com>
Date: Wed, 28 Aug 2024 08:55:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] regulator: irq_helpers: Add missing "Return"
 kerneldoc section
To: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240827095550.675018-1-wenst@chromium.org>
 <20240827095550.675018-9-wenst@chromium.org>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240827095550.675018-9-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/24 12:55, Chen-Yu Tsai wrote:
> kernel-doc complains about missing "Return" section for the function
> regulator_irq_map_event_simple().
> 
> Add a "Return" section for it based on its behavior.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Thank You for improving this! I appreciate it :)

> ---
>   drivers/regulator/irq_helpers.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
> index 5ab1a0befe12..5803ef016b7d 100644
> --- a/drivers/regulator/irq_helpers.c
> +++ b/drivers/regulator/irq_helpers.c
> @@ -414,6 +414,10 @@ EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);
>    * notification helperk. Exactly one rdev and exactly one error (in

I just noticed (an existing) typo "helperk". I wonder if it was Ok to 
fix it while anyways changing the doc. It's not strictly speaking 
related to the return values though :)

>    * "common_errs"-field) can be given at IRQ helper registration for
>    * regulator_irq_map_event_simple() to be viable.
> + *
> + * Return: 0
> + *
Anyways, I agree with Andy about not needing the blank line here - but 
other than that:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> + * Actual regulator error and notification are passed back through @rid.
>    */
>   int regulator_irq_map_event_simple(int irq, struct regulator_irq_data *rid,
>   			    unsigned long *dev_mask)

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~



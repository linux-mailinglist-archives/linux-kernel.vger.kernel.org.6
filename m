Return-Path: <linux-kernel+bounces-211944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F780905939
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670EE1C21511
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D6181CE7;
	Wed, 12 Jun 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QvZReln7"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028F181B9F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211276; cv=none; b=KPCizDQ6IydoSQTOavmcfqXwN0rCe/bngVoTS3RNnlKBzQF10Ostvf2P2cq/RL4kcJsUPASm2TsMVsit+SXdQwNxRt44z91cntiWIoV/CTft1pQDTpokj5Je2VNLKizb6VHwo2059YQ8hfvsNJUh7/hP8F/1qhZ2XoEtLJpPjwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211276; c=relaxed/simple;
	bh=1thz6tnKYh4W3UTSkm0UIqpLg3cHhFT9lD2SEIdOi/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+vfUqxO+mIgnagYAzVzyd6OlUUCJ3txhxG5YEtrSEWRra5YbZBb8pw9bLZHS1Tc4RGtk4b8WrJ89yyry9/UdhiqcN38wsaCSR1W+9qBdDkFFm9wet81V2XGx/hJBqn5FXite1atKR367cXLfDouTk+UhKnfeKpN7wb+llcsUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QvZReln7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d21cb38362so196964b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718211271; x=1718816071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auZ0CYhLHHpQv2x9Ok7hNHgDuK+aHHonoO28jfXMPus=;
        b=QvZReln7r68NLkOTDgHWwJzHAQIaTsk73QqqpzeSsyWy9AnHX+yyVgR8Xyqsi1ONlq
         ZOpBOXgInNueyYB0WcyfSiemEW4DOwt7zufFeo5hGm8/zK5dMobj2NA7dvxc+TQw5kDZ
         WLLlSYNBg2CjYVjgTma+bHZMCcPGleDq2Js8a5IhB6GPTWiIg5xffaSiF4w6QsWtaxvg
         IklMz9JCxAXj5+bz1z1hZaEOPQyr9YbcY+s5UYn5HcXZjyo0jwywp/F8x3cyPjw7hsWh
         HJAVakPnbicQKlt1F0nyXLohZWLy5BZ9TzGsdTeuicjDAkJGZ5kF65kllaFO3g2Yf0R4
         PC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718211271; x=1718816071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auZ0CYhLHHpQv2x9Ok7hNHgDuK+aHHonoO28jfXMPus=;
        b=S7CBdVCNssCqG12icIRCGUBEYn+dZv1sjY96H4+l4dQRG7nfAvkG5ED9sDQwjprneD
         z0cR8Xz+H92oZSeeV6htV3E4bgO/IWJEEzA7Ey1uJF7qnsqNl2ir1X9RTyFSDhpWp2QE
         TECY/I5ZfMk0bv8cpH4LzGO3YCRYcFUzh5Kvuci8iJaSGUnW/YWdP1rP9LObmSruUC6q
         lKubbWhQRCMHuJmEuFwbG4nk/UL/H7BJvO8jBsEmAJWRtPxwA5JzrvQnKZAfFFGJOr7r
         C32wNxNu2dXXI6WF/XcG39Oz06pawt3peBPWYTsNFTH9fhq2FduIzxCyqZw3kAjzin3K
         ezWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo5ApFzCjgh6hlzrp+Y2HXYanNqWX5wOXjipT4NivpYh12YOe3Xz8Kadxl6Kg0Luj+qCuYnD50e7OJlbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHaYISUy8WivtlD6hI99lqDP5GBv48q7lxlc0YkX0xd8aAo/MZ
	dk4FLTvBWbOGFZgghgSotPkOQuXl0RT0Gos3QWAFHR3cSQS0VNtc/IKIiEY35IQ=
X-Google-Smtp-Source: AGHT+IFJcbrN0mfMMLSdZ99zjcbKdGCqyR/7L8hjEBh1nwrgjfG7Nv1hKm/yTAjp6qCBcgUqV8S5Zg==
X-Received: by 2002:a05:6808:1520:b0:3d2:1b8a:be6f with SMTP id 5614622812f47-3d23e1841d5mr2768358b6e.4.1718211271170;
        Wed, 12 Jun 2024 09:54:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2219a6274sm1434752b6e.37.2024.06.12.09.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 09:54:30 -0700 (PDT)
Message-ID: <795edef9-2bd7-413f-bba2-04d569da63b6@kernel.dk>
Date: Wed, 12 Jun 2024 10:54:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aoe: consolidate flags update to prevent race condition
To: Gui-Dong Han <hanguidong02@outlook.com>, justin@coraid.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
References: <ME3P282MB3617DAD141ACDD21170355E0C0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ME3P282MB3617DAD141ACDD21170355E0C0C72@ME3P282MB3617.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 9:52 PM, Gui-Dong Han wrote:
> In aoecmd_sleepwork, there is a race condition caused by two consecutive
> writes to the 'flags' variable within a critical section. If a read 
> operation occurs between these writes, an intermediate state may be 
> read, potentially causing bugs.
> 
> To address this issue, the 'flags' variable should be updated in a 
> single operation to ensure atomicity and prevent any intermediate state
> from being read.
> 
> Fixes: 3ae1c24e395b ("[PATCH] aoe [2/8]: support dynamic resizing of AoE devices")
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> ---
>  drivers/block/aoe/aoecmd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
> index cc9077b588d7..37d556f019c0 100644
> --- a/drivers/block/aoe/aoecmd.c
> +++ b/drivers/block/aoe/aoecmd.c
> @@ -897,8 +897,7 @@ aoecmd_sleepwork(struct work_struct *work)
>  		set_capacity_and_notify(d->gd, d->ssize);
>  
>  		spin_lock_irq(&d->lock);
> -		d->flags |= DEVFL_UP;
> -		d->flags &= ~DEVFL_NEWSIZE;
> +		d->flags = (d->flags | DEVFL_UP) & ~DEVFL_NEWSIZE;
>  		spin_unlock_irq(&d->lock);
>  	}

It's modified under the lock, and any reader should do so as well. If
not, there's a race regardless of your change or not.

-- 
Jens Axboe



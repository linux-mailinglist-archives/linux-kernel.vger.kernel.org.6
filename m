Return-Path: <linux-kernel+bounces-535466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D80A47344
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67233AFF53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE18154425;
	Thu, 27 Feb 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZgOeYWDj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D5182BD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625498; cv=none; b=u/C9HBcbIoS0G31j7B60x2qYsz9fX246kiuL1FPf9+3nsLUGZSQgKADWqPXwwVB0JK5y5Yj0lfwveT5ExuvXrJnNT9kUt5BO9KqbF+iUpPYThJDPi+3bNLrY20YcW5+p3UlaIX2wNaDyDvM0yDMixEhXlf/hVU/341uWh5qtS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625498; c=relaxed/simple;
	bh=sApeOFUm9vtPmXsAcHKHmqVM5ydqSgewslfuqqLoT7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iu8y12KFShZIFITfOyl6kwDiPCuM6M3ghdTPi/shJoxYFeXi+U91naSAfNq5KCeaemQ7FCtehQF3WS8yA4IjijRTkz0fxhb3a8845x1bt3Dw+vAm4+0ZrI95Ah/+XKqmGAvx99otqmsYP2zYxJqOzr2/IjE0TLQOfuEmpZLqK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZgOeYWDj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ecbdb4c2so9899915ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740625496; x=1741230296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQVKWv0Ome4K7rsB2kB3GKRybp0+6cMBrnmVUw1MVXM=;
        b=ZgOeYWDjmGzoWh1HVuwgTeophpHzetR/UJvQr92vP9sCpN2ZbceS8DuWbWvvnnyg4f
         W+P/HOOgbgtN4VBzxRsgYmrNzKBgGiHePtItN0QusM0Lb1v4QxZfv/IesLpxwFE3i0sC
         oWP00N6m2bi7VP/VDCODXM9BASO1cnEkQnHbfAwX+PUcOMBHx5muWfPg0EnX4Ka2w76y
         OmeeN0KvwvSiNpCDgRvzsgSVa5oMQQfECc0Y/q9IMwRIU/usBMagUPvKdZQcPqLocZDJ
         L2J5bWhgzJJFG5OLBsWJbCBgOeXYV8Gj9s4ATaJObJjM5nw1zZ5k2xEMwUOYk3MNhKB7
         bqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740625496; x=1741230296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQVKWv0Ome4K7rsB2kB3GKRybp0+6cMBrnmVUw1MVXM=;
        b=fBTVM2UlKicq9z6Pw8FH0w2ZT1KAXrGHEqbKlGP8RAlWRDbQYnIyuJzAeDyMm1vhPI
         Tw1jN/i0VfrHlfRNOFKtOkQ1NgrzLjsZfO0/IFUs2xu5cJ13BXVy2cninxsfiUbZyUFM
         ixzBgm0H2BW3Sxl78jsBiuQQrVFbwlgCveapuxV+uhwaBiG1QUlu9wbcv7ZZK4GLsR6U
         XsGqcdog+m59Zs/eRHxyWXrEBhB4o7wAlnVCwhT19AI823+TlJcM3j2ZQSkiVfgiGsuS
         iHJWDh7hYiSzZUOerwf6ht5T3WkbM8WscYnDUKHSs0I/1mUDRB9LPDKUnpm3VuVv9Qmb
         3Wag==
X-Forwarded-Encrypted: i=1; AJvYcCV2mPeB04uM9ASzfP73TUTXSLFZGruDPfxQTB58jVM1SgcO6dlcvvUkAaCtreOAmu11mADjrCSC+34KM9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGm9sB5iv6mww/VWAESdjQwScX+5y9WE900wmXaMbESombn8/e
	nbnea4eG8zs6yw1an37jlPhLQk+4gUrdnMRFSGtyBvxbCoj897OGNbH0A3pdY8YvQrLIWLA1SPF
	vXJE=
X-Gm-Gg: ASbGncuX1pzjEPDuqvZtNfO894couVdwqkVbZGv9JbWWqBGCazpXOXIPqkurts3hSE0
	FlnBNkxZo4S8TsoyPGs7J5n3EOOzWx63qoeKITbB67OnjMrWwjghnbhNzrfXcmo5DVKySrrd7UB
	kKdF40ziHfPJPbg8tucBQmHbMlix8mANqRjGJsncONqlGG0MU2AfRyMfdZ9onnSmeZnGNED9qQ7
	S7aXym6E/JLJ65N3VIvfOjqafSwNdm9/jOTb0CEkfDvu0YA6qy0FfB18oaYG1ZLv2SIAw0FNq8K
	CgTEFaIMfQUWoR1/0zLhTk+TEHrzvNQ1Gvb/KBxjJJZpgYVkQg==
X-Google-Smtp-Source: AGHT+IFXdHw6V94ujYF/Y7q0TUGZj+lZtIenRxWAiQyN/0z1I1NpUoGEdoEWZTJZ0/gdQ8Q5Uzj+wg==
X-Received: by 2002:a05:6a21:8801:b0:1f0:e3b9:6b17 with SMTP id adf61e73a8af0-1f0e3b96b1amr20800701637.26.1740625495721;
        Wed, 26 Feb 2025 19:04:55 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de1a4absm310575a12.26.2025.02.26.19.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 19:04:55 -0800 (PST)
Message-ID: <a77923d3-ce26-4e29-bb98-b908ce2355c2@bytedance.com>
Date: Thu, 27 Feb 2025 11:04:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_PT_RECLAIM
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250226183013.GB1042@cmpxchg.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250226183013.GB1042@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

On 2/27/25 2:30 AM, Johannes Weiner wrote:
> Does PT_RECLAIM need to be configurable by the user?

The PT_RECLAIM will select MMU_GATHER_RCU_TABLE_FREE, but not all archs
support MMU_GATHER_RCU_TABLE_FREE, and even before Rik's a37259732a7dc 
("x86/mm: Make MMU_GATHER_RCU_TABLE_FREE unconditional"), x86 only
supports MMU_GATHER_RCU_TABLE_FREE in the case of PARAVIRT.

Therefore, PT_RECLAIM also implies the meaning of enabling
MMU_GATHER_RCU_TABLE_FREE, so I made it user-configurable. And I just
thought that as a new feature, it would be better to give users the
ability to turn it on and off.

> 
> Why not always try to free the page tables if the arch supports it?

If so, maybe changing

select MMU_GATHER_RCU_TABLE_FREE

to

depends on MMU_GATHER_RCU_TABLE_FREE

would be better?

> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 2761098dbc1a..99383c93db33 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1309,16 +1309,9 @@ config ARCH_SUPPORTS_PT_RECLAIM
>   	def_bool n
>   
>   config PT_RECLAIM
> -	bool "reclaim empty user page table pages"
> -	default y
> +	def_bool y
>   	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>   	select MMU_GATHER_RCU_TABLE_FREE
> -	help
> -	  Try to reclaim empty user page table pages in paths other than munmap
> -	  and exit_mmap path.
> -
> -	  Note: now only empty user PTE page table pages will be reclaimed.
> -

Maybe keep the help information?

Thanks,
Qi

>   
>   source "mm/damon/Kconfig"
>   



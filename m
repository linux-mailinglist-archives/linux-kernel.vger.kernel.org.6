Return-Path: <linux-kernel+bounces-335182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8FE97E250
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA612811ED
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF415E90;
	Sun, 22 Sep 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG8Pwffs"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E164173;
	Sun, 22 Sep 2024 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727019586; cv=none; b=SAqvjS5KJlUvA9AOer1XwE5tZzzSwFmtRuwCskbsRnKCcomOsqRelt84hz+FsXtlqgIoSrbvtuprXYE6uEbwFfodwgakv4iSts7r/+AQzVBlJiOhurVEZ5yLHMzYKG2/kCId8Zjvtwuu/BO/usT52BT1fs/Uvqe/rFOSRfzwi4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727019586; c=relaxed/simple;
	bh=CN3hLeFDGUVp1dRS/7XLTo0K1b3/vHRucAHDWECMOTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJJK7MDFQmFMJWpdeT1SvLONx3n2djbkx7ehRzsV6ImMk4Ovc7jQXoeb6SN/YZlaI/cZ50M9bXegJ8vYoQTKBdbly0PrKRl8wMV8P4MeU6mtZ1zFgYiO/kgDscKLk4go3myNz6oyV8AHi2v9+rXDLkL3EMpOenj8zNrFMad0jR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG8Pwffs; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7124352ecc3so2294976a34.3;
        Sun, 22 Sep 2024 08:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727019583; x=1727624383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWbcG1vzrobExXrgYknsKKk0srxZ7bivpSWpm7ltSSA=;
        b=bG8PwffsKXmbQkI2ei9QZso+jpRIK5UlyKl2fZSMiaQ/F978SlQ/tMeKRbaySVbEHM
         tJAYa6FBxkbas8dYwohytVN4mRCsNyI4nfXy4LQqP3GyyiYgHQm/IXU5zXYgISPMJ9WW
         eVNWGhR1xmhbJEeXT3CwO83u6dYDAeCBuPY64BZvFAuHkHWUKREKxAGLGI/NodPAh65T
         zmW3/N9xire2rLi+76627TQ7cGfOueMkVIJf2t3f7I+MvnqoacOacaEu9PWBPWdLpf/C
         poW7GzjJy8vwN9muQIKJF4M9n/Yi7xr9nsZsEu/JqnKctEXP0OCdcnbz960BiiWxKBtf
         8gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727019583; x=1727624383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWbcG1vzrobExXrgYknsKKk0srxZ7bivpSWpm7ltSSA=;
        b=S4wxm4bGB7c9tYGhfpY5h6CWl47WjoqsKMP6wo4wFpwci/jZKGrrrRlYmwzKdclOuW
         t04WTLeKDd+41ul9u0CrJJ2aByZkXFw6M66gEC3RS1Emo9x6auXlN6U5e0baLTiIKQ7Z
         /iZloHVtt2Rsc6HpRrOJdBUiv+pofPh5qKehMASwc2zTp7w4qW0K/3VgPMAqchgmVKET
         7bOvG7v58H52bCgCe+BNRtKCe5rDCl8UZk5Ev6Nc6ASG1HYS60APvoGjpWIgUQuXYY6y
         4H6eJ0GUJg5PMqUR3oIYUxPcs0PH3i4khl84akLl8u34gSXdCoiozn+6gl+SHcadB+pB
         ZPig==
X-Forwarded-Encrypted: i=1; AJvYcCUdA7SxnBHhCZdAaAWdpqOxDts22Q+SDZq0o06uUECr/NGw8MEkLs8/FiCDmhympVeLVh/4pYouu7k=@vger.kernel.org, AJvYcCUjlJYMQC83+H9A/d2EbVpydnai88+8krinMQ9mzEnPMd6XGr/oaU9R9fFkcP1Zl5jRMWFPpiB+GiUCTvGosgU=@vger.kernel.org, AJvYcCV3NabZjtSDqlB+/1QW6JDm8fePMnRjX5ZVT9EXKTvzZDcKdMRbO7oFn0nb+4K5ShrlXSiOSMSlaHT+E8rm@vger.kernel.org, AJvYcCVvGJc8Cqld3WgREUrwfA80Nu8Xa60VVDaF09MaH6OEQS2nwBVBimo8kG43liyOstW5su11WmuXmnyZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTaWJT8SdoJ8t56phsMsmF1rbUGWIeQA105C206LLEcT3EG3U8
	i7/bFjzP7ZJXIOdYw6ojsG16hDF/7zgupQ8vYzLqRPWKjQWaSjJM
X-Google-Smtp-Source: AGHT+IFkUo7yn2lMHnZqmx2tSJGY/manmEcf4F/hxbVa3XuFTh72zi4vRvDHIpsnEJSWCy4ApFX6Sg==
X-Received: by 2002:a05:6870:169c:b0:27c:a414:b907 with SMTP id 586e51a60fabf-2803d0e8d3dmr4967987fac.33.1727019583492;
        Sun, 22 Sep 2024 08:39:43 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27d0b44eb48sm2375042fac.25.2024.09.22.08.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 08:39:42 -0700 (PDT)
Message-ID: <c91396bf-4ed1-45b4-8a52-68ac1fea2e2d@gmail.com>
Date: Sun, 22 Sep 2024 10:39:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-docs: Add new section for Rust learning materials
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, bilbao@vt.edu
References: <20240911185931.16971-1-carlos.bilbao.osdev@gmail.com>
 <CANiq72nVp=xMQHBbKwayD0e8PpysbVz8eegx+meGqqw3y5HTtA@mail.gmail.com>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <CANiq72nVp=xMQHBbKwayD0e8PpysbVz8eegx+meGqqw3y5HTtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Miguel,

On 9/16/24 03:39, Miguel Ojeda wrote:
> On Wed, Sep 11, 2024 at 8:59 PM Carlos Bilbao
> <carlos.bilbao.osdev@gmail.com> wrote:
>> Include a new section in the Index of Further Kernel Documentation with
>> resources to learn Rust. Reference it in the Rust index.
> Thanks for this, Carlos! It would be nice to mention that this came
> out of a session of Kangrejos with suggestions from people in the room
> (or who suggested it).


Sure, I'll mention in the v3 commit that this is the product of a survey
among Kangrejos'24 assistants.


>
> Did you rank/filter them in some way? i.e. my plan was to perhaps make
> a poll or something in Zulip and then pick the best ones.


No filter, I thought the more the better. I'd be willing to read reasons
to remove entries if anyone objects to any resource in the future.


>
> A few extra that got mentioned: https://rust-book.cs.brown.edu
> (perhaps could go into the Rust book entry somehow; having said that,
> I am not sure if it is being updated, and it is part of an
> "experiment"), https://newrustacean.com, the reference,
> https://github.com/rust-lang/opsem-team/blob/main/fcps.md...


Will add in v3.


>
>> +    * Name: **Linux Plumbers (LPC) Rust presentations**
> I wonder if listing individual talks may be a bit too much, compared
> to other entries in the file that link to the overall resource.
> Perhaps LPC should be in a different section as a "global" resource,
> perhaps with links to the few latest years' full schedules?


I thought adding each LPC talk as a separate item was too much. But,
adding them at the end of the list, for those who venture deep enough into
the Rust rabbit hole, I think is good. Honestly, we should be doing more to
take advantage of the documentation generated in LPCs.


>
>> +    * Name: **The Rustacean Station Podcast**
> By the way, are these sorted in any particular way?


The rest of the resource index is chronologically sorted. But, for this
heterogeneous collection of blog posts, talks, etc. I didn't see the point
of that. As the project grows, we'll need to categorize Rust resources and
index them for easier access.


>
> Cheers,
> Miguel


Thanks, Carlos



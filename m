Return-Path: <linux-kernel+bounces-169089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A938BC2FC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 20:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FB01F214DA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA466CDBD;
	Sun,  5 May 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w4/h85cP"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5E2B9BE
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714932286; cv=none; b=BPTDZ7BYjUHn6TRKAEAu+NfzTGxqpsIQeI8QdTHTY3ejvmP29emumGjwSYIpygOIH9eg3rCv6trHs+zwMZgKHUTyVrLftqU7gSrmJrwLnTbSE0z8NrEWJ00rAodUGvYp2J9lIRXLkC1RcufxzCOGnz/4GEYTL0L508oUIMIc2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714932286; c=relaxed/simple;
	bh=MvgFEIdHJtRnDvyKBZhufXdImvNjTp+dD0weVzheZjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YB1mRI8zyOWUUpoH4B/PlqFJilrNbKMhstz0grUW/0RK28AOTV6MApBlx63DbzCAvIKzvI88UrOTdwiNVnMTn/isvGvJ7yWDb4QnmS71XUwzqn1Pj0f9k6RO9zjkPR0cInF5DJMH48MlSPpHVT1U+Abso3aWtwISgUul0T4Q8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w4/h85cP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec4f928c57so3928565ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714932283; x=1715537083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mE6ET/wemNoj1wnsoN5H46vn2H9jFrdPiFfXm3O1q/E=;
        b=w4/h85cPoz9JrKVApFfzhwqyTk3hafzehD2XG7NNtSIJkUN6u2EfIyUUtNpf9SG2yL
         W6rdALus2jNJXXvwjvuJ2YTV3zYJdblncEoF1uPLQnao+u8nh1XX1PhOUsQmFsR14I4W
         MC1Umr7tv0fgbJv1+sUuAzexxKG8j0Uj6G57/BMOdrmG69VYAhAmV/BbzdpOTlDReEkf
         mJx+YNH5SKRZWCOs6stpErBvVEiEsfx7qfzIwwNWCG07N+gsyJtt+usEjJaQFxA8kU3P
         lZftFf0JTUkH9nuom4Fw3Va4yeUEtyb+U356wx0/ujdiep7C/KvDYPIRxp/cZcrzb9Hy
         bvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714932283; x=1715537083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mE6ET/wemNoj1wnsoN5H46vn2H9jFrdPiFfXm3O1q/E=;
        b=NISlWAX1DhyJLtgbmuq2ptuwdnuBjrgM3gGMLzN9En+wVHXjlJkuvPOCnM9EUveT9V
         LI0X0GSCoRkUoXBMun9ovfCHBv2WCEcc8VzTDu3TUkOBQgsuPFrp/4TVNuwwkFKRngry
         Vn9kHYM6aXYLApb1N47K0rLpE4tIIKnbRGI3h5Ic4FCjeQM/v+8qwninZ34UuUjIA6Iv
         fENevnzrrFPD/tUhGxcjq+6U+pGWDpJF3AGIHwMwbNgnPt5oMasxwVgf9pRsY4f+nwEo
         p0WDFkx1ZfV4AW1McZNBLH4tAkFG7KSFCMPmOaeCJnyQk/+SVVHGUeglqEoSz7pKE7Zo
         2tog==
X-Forwarded-Encrypted: i=1; AJvYcCXlaGzzzzHBWez1lt0y9MC8rNt/Gv5mIMwoA24GcfyjJtGhoaV6D5hXI5w/uL/sF2f4XPcTMMqkqrb86fF/SN3b9OqJJj68ay0x7Xyf
X-Gm-Message-State: AOJu0YwRgQHwEcjkxV+EVS6FOth3Yja8wuQk1KcNTQ9Msn4HxDCt99Nc
	YBnGHwOYg97EC8TdbCuwuqwWLcMGyZAv4gqtz1rTSIN9kwR7ySWokKUDHHHGeIs=
X-Google-Smtp-Source: AGHT+IGWjfUE/TDqZn5+tc9zv5WMH1AwiF3VlKR+EV8RVaOEHMWP8GFvz9bqpeX6sGO+oAr45ebqrg==
X-Received: by 2002:a17:902:d2d0:b0:1e8:4063:6ded with SMTP id n16-20020a170902d2d000b001e840636dedmr11260813plc.1.1714932282996;
        Sun, 05 May 2024 11:04:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b001eb03a2bb0asm6700128plh.53.2024.05.05.11.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 11:04:42 -0700 (PDT)
Message-ID: <be4fe24b-daa4-40af-806b-40db570e37b2@kernel.dk>
Date: Sun, 5 May 2024 12:04:40 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] epoll: be better about file lifetimes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, jack@suse.cz,
 keescook@chromium.org, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, minhquangbui99@gmail.com,
 sumit.semwal@linaro.org,
 syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <CAHk-=wgMzzfPwKc=8yBdXwSkxoZMZroTCiLZTYESYD3BC_7rhQ@mail.gmail.com>
 <20240505175556.1213266-2-torvalds@linux-foundation.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240505175556.1213266-2-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/24 11:55 AM, Linus Torvalds wrote:
> epoll can call out to vfs_poll() with a file pointer that may race with
> the last 'fput()'. That would make f_count go down to zero, and while
> the ep->mtx locking means that the resulting file pointer tear-down will
> be blocked until the poll returns, it means that f_count is already
> dead, and any use of it won't actually get a reference to the file any
> more: it's dead regardless.
> 
> Make sure we have a valid ref on the file pointer before we call down to
> vfs_poll() from the epoll routines.
> 
> Link: https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/
> Reported-by: syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> Changes since v1:
> 
>  - add Link, Reported-by, and Jens' reviewed-by. And sign off on it
>    because it looks fine to me and we have some testing now.
> 
>  - move epi_fget() closer to the user
> 
>  - more comments about the background
> 
>  - remove the rcu_read_lock(), with the comment explaining why it's not
>    needed
> 
>  - note about returning zero rather than something like EPOLLERR|POLLHUP
>    for a file that is going away

I did look at that 0 return as well and agreed this is the right choice,
but adding the comment is a good idea.

Anyway, patch still looks fine to me. I'd word wrap the comment section
above epi_fget() wider, but that's just a stylistic choice...

-- 
Jens Axboe



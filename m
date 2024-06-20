Return-Path: <linux-kernel+bounces-223143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72A910E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B331C20AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22741B3F3C;
	Thu, 20 Jun 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h3ZGZNKl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CCA1AF6A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904356; cv=none; b=tnHadxchViVIrIcQ0SnVdQz8ahikJ3cbF5diDhTPP/IN3DAIUQgF9WmHNajg7GyxDGAZu4l718w/W5YQlGm55VdNOvtmCiajyUCFpyCJCLhqrp+ZLstCfO0if55bV/TXPStIQMxYYq+HpQiTBCPrFWpL688G3WmM5M7R/la55pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904356; c=relaxed/simple;
	bh=8dccsjcVOV2fX5Uk3UXiobDORTq2f/wq5FQct7x7GkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPef2y84P9lBV+C5kUPhIyPxUtOT5fGV8cMdhz7nQWJrmidrse1g2/iCw3s44pVbpLbk9ERqaynebr91Hyc0jerEXRDM8/kPty5GZ80qYY6YpP2V3MU+kDLxZaV4XIP2FNu/+BvlIc1sKDOz0ILV/7CeUOl9I/Tjk3uhxTHdj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h3ZGZNKl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so13816511fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718904353; x=1719509153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lNL9JASXnLGdYr/1kKgzyo4AtEHujMDElp9Dkk/0Lc=;
        b=h3ZGZNKlQnYTRgpQrAlv1m8An4gaaF97XLQHM1SkaMqHj5uOotiN4WOjKb+MOC7vaU
         fY9U2o6eAI6/EKCFE4fN6dsckqXCwiTGaPQHX9FgnQXB+5eS9cMiqYR5hKKbJSlcGfr3
         brrvpFtxRYpRU12JbXdTSi4XJQGLGbKnhLtCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718904353; x=1719509153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lNL9JASXnLGdYr/1kKgzyo4AtEHujMDElp9Dkk/0Lc=;
        b=FqpZYSwY7H6SRV3h9AaosYybz4kUPcWt2xQ+VnuEpfIk6QA1iDX4kfKVUnrGAnQpda
         jR2JbPnpkoeBBmk9l7PJOhAjiPL9b40pqnJ/m4/rvqprAvf5tdppPmJUBUFmDknP0XCR
         FMpJsRcPQvFaL3T9LXgffTtWKgWRELSs8XrjThysAxLRmglolx7RtuRZ7pEeR2Zkitgg
         0Bwo3P156nzrthhUpUO/HhhCQ1/5ErFLPnZ2dUh4B/aEIIhYzSIKRvBuWOfN7GBGfAin
         IMysoLSSOWmfguhZT4DNcKvjq0fOZ1VM6CHXRfNIGMVw9y57rIa2VlKHfU/Gp+XlRYxa
         fgMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZIKSJAZbWfq+e0r47on4UU113ZEonR8HlnaBtUSbfAvXHbqHnBPOeeidWycktuDKHzrUxvNLNnYFUOHhXhPSYdgXtEZ5lRqNYVJ4
X-Gm-Message-State: AOJu0Yz7ToOmd2nnv0FI7oVAbT7AiP7zFbS4SkJibvGBO6DFHCe5p7pC
	8Tg9R1zjfi1L29Romgv22VNz6HRfglQK7kZnorVzuGyjxo0GLbRr0QOg8sTZCYmRax0TQYNkItk
	ZveiL8w==
X-Google-Smtp-Source: AGHT+IEjakRbTED5zQDrhwmgs6yOdzbBZw1yad/rwCJFZvMfDpMVKZqOQMZy/YWXqKExrO4sCBRo3g==
X-Received: by 2002:a2e:9612:0:b0:2ec:eee:f199 with SMTP id 38308e7fff4ca-2ec3cfe9a82mr39802001fa.32.1718904352783;
        Thu, 20 Jun 2024 10:25:52 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d06b64749sm2097586a12.61.2024.06.20.10.25.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:25:51 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso1377032a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:25:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwou1BCE8WiHMUIlUvnL+Xe4E4ucGI9o2yrtYft4GytLw0OCjSeWuhnPb+60lz5NcT8HzXjT1ZkDlMW9UtvAQOhPwMY8EjOI1VR+4G
X-Received: by 2002:a17:907:a80a:b0:a6f:6659:a54 with SMTP id
 a640c23a62f3a-a6fab607137mr441965166b.6.1718904351308; Thu, 20 Jun 2024
 10:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <90b46873-f60f-4ece-bef6-b8eed3b68ac1@app.fastmail.com>
In-Reply-To: <90b46873-f60f-4ece-bef6-b8eed3b68ac1@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 10:25:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6OHJKArnC2SMY-GEcMfncer0A6ELM4ZAnaRdbi12kdw@mail.gmail.com>
Message-ID: <CAHk-=wg6OHJKArnC2SMY-GEcMfncer0A6ELM4ZAnaRdbi12kdw@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 00:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't mind making the bit that makes the untagging
> unconditional, and I can see how this improves code
> generation. I've tried comparing your version against
> the more conventional
>
> static inline int access_ok(const void __user *p, unsigned long size)
> {
>         return likely(__access_ok(untagged_addr(p), size));
> }

Oh, I'd be ok with that.

That "access_ok()" thing was actually the first thing I did, before
doing all the asm goto fixes and making the arm64 "unsafe" user access
functions work. I may have gone a bit overboard when compensating for
all the other crap the generated code had.

That said, the size check really is of dubious value, and the bit
games did make the code nice and efficient.

But yeah, maybe I made it a bit *too* subtle in the process.

> On a related note, I see that there is one caller of
> __access_ok() in common code, and this was added in
> d319f344561d ("mm: Fix copy_from_user_nofault().").

Hmm. That _is_ ugly. But I do think that the untagging is very much a
per-thread state (well, it *should* be per-VM, but that is a whole
other discussion), and so the rationale for _why_ that code doesn't do
untagging is still very very true.

Yes, the x86 code no longer has a WARN for that case, but the arm64
code really *would* be horrible broken if the code just untagged based
on random thread data.

Of course, in the end that's just one more reason to consider the
current arm64 tagging model completely broken.

But my point is: copy_from_user_nofault() can be called from random
contexts, and as long as that is the case - and as long as we still
make the untagging some per-thread thing - that code must not do
untagging because it's in the wrong context to actually do that
correctly.

And no, the way the arm64 hardware setup works, none of this matters.
The arm64 untagging really *is* unconditional on a hw setup level,
which took me by surprise.

              Linus


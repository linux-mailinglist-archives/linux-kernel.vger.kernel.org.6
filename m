Return-Path: <linux-kernel+bounces-411817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718439CFFF0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 17:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD5284113
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 16:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F30183CCA;
	Sat, 16 Nov 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g9dbDe+E"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABE74421
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731775801; cv=none; b=oTf1rouiA7DDBY55ZjWSpjDuPF5r0lkiEKGVz3PABu5W9BVwr+WPr20XAWAR9sLDryJg1AA8AWJA2u1Kwnc1T76u6TGrz1ESE+T1OnxW5NF+sXgRVvVjEeZE4N/Hfjb4alFuRWAPqjqmUJs34vn7jvyLFOL9DVffeFStJzJytQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731775801; c=relaxed/simple;
	bh=E/Tuo/db8iOWp7eoMWkOygfOn+4wOFvSZJleOrdzNZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbxzW8DuQSPzS3U5nPCr6w7jJZh/VwusOeBIoWLiOyUDkJV9lunJi9MdufrVu+LXcqkdwJ7RxWmI76/Dgq/oorYDaQxqh2eo0BF8IclOOFs6bTBgYFhQFl0fx3E+sd52TXMGGch79JRPgdfwZRRFOwTq9Bmpj4EHgxInzbxdPNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g9dbDe+E; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so3599217a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731775798; x=1732380598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EVggJ+HrFs+M+88omfFvZ5m4gN340mphxc1eGqJLQ9E=;
        b=g9dbDe+EhDuKbiRUMWnVdm5zFPhGbAe5n2wkfprqLuZqBnhPqQ9/kDyaZwV9/YEmMG
         acvzsP30MZ90qYEXrOC88aYwoDn82bzxtW8qadmKAW5lFfyV08cHwQogmt08yT5Tu4W3
         rQTX/4yMc2VHEPUEuoslS4xq5dgG6nuc8J7rM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731775798; x=1732380598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVggJ+HrFs+M+88omfFvZ5m4gN340mphxc1eGqJLQ9E=;
        b=TfSUAwunwAYj1U63k3o0gUIMxzQ61eIp3aH9sETm1Fj8ulU8tquk4/PnZVuh2qnb0J
         bIMjY4oC9oOfyMNOxiOc4rExKJPRqVCcXgaaqS1J7cCyifRDzr0SN/bukgDLYCAvakK/
         FNawZ1ep8xJpIR0h+QBAKTKV1JaQBfGEHiDNGJ40B9Ak7DnCy+eJv01+aiQ2bU+F1g+y
         rEDCarsMu9/qA7dtwqMLZnw5oS3wBKA8zQxJMKStKUg7hxWSTjpe6q7hErajUKlqk1z+
         /c9wXpKMLgVBVzBzeOmRZrkFJiPXeK7u1CG+Rr2LK7TNk4b28sEu4B4xhV95YI8zLqVi
         UMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHUifxkXsqXDQUFNYiiZCKK8bPDA9SUa2QcW90bT9P6LYz2Zk5ngbnuNegUSHzm94r4aMU/MBL6k7FxTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3s1rXG6pDghWa2TuDmWUZVB0KrQyM/YWZAPPwnTfY/9EGoIiE
	VbL2AN3EYZXtEJRdjlBIkfBG9eU81RVLWZVy7i8YDmS/ieVp2/PcJUb9F00hczrIlaIunhdoorw
	EXCM=
X-Google-Smtp-Source: AGHT+IFdllFJ7sO1uVvB4Ru2ongC1afeRfdBXfxvsCiDSa/gVhouIv7q0Sgjwjw5eh97KCZxtCPm9A==
X-Received: by 2002:a17:907:7290:b0:aa1:f73b:be43 with SMTP id a640c23a62f3a-aa483488d6amr695374666b.32.1731775797948;
        Sat, 16 Nov 2024 08:49:57 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcd4sm322127666b.98.2024.11.16.08.49.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 08:49:56 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cfaa02c716so766007a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:49:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGqsEz2bb+z6CvIpcEp5lIr2+w3hWS06bOE4F6O5AYI5tl+cBglaq4lUAJZWszj9rIAHrX2E0LYx6eFqE=@vger.kernel.org
X-Received: by 2002:a17:907:a0e:b0:a9a:4d1:c628 with SMTP id
 a640c23a62f3a-aa48352c0f5mr617966166b.45.1731775796094; Sat, 16 Nov 2024
 08:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116061258.GA216473@lichtman.org> <20241116072804.GA3387508@ZenIV>
In-Reply-To: <20241116072804.GA3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Nov 2024 08:49:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
Message-ID: <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
Subject: Re: [PATCH v2] exec: make printable macro more concise
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nir Lichtman <nir@lichtman.org>, ebiederm@xmission.com, kees@kernel.org, 
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 23:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Now, whether that logics makes sense is a separate story;
> that's before my time (1.3.60), so...

Bah. The whole ctype stuff is a mess, partly because it's
fundamentally a broken concept and depends on locale.

The original ctype array was US-ASCII only, and at some point in the
random past it got changed to be based on Latin1. Maybe indeed 1.3.60
as you say, I didn't go digging around.

And Latin1 is not only what I used to use, it's the "low range of
unicode". So it makes *some* sense, but not a whole lot.

It might be good to go back to US-ASCII just as a true lowest common
denominator, because people who use the ctype macros almost certainly
don't actually do it on unicode characters, they do it on bytes, and
then UTF-8 will not actually DTRT with anything but US-ASCII anyway.

And this fs/exec.c code is really confused. It explicitly doesn't use
our ctype, probably exactly *because* of high-bit issues, but then it
calls '\t' and '\n' is "printable", makes little sense.

What that code seems to basically want to do is to check that
'bprm->buf' is some binary data, not text, and using "printable()" as
a name for that is actively misleading and wrong.

So I really think that all it does is try to protect from even
*trying* to execute a text-file or script as a binary.

Anyway, the fs/exec.c "printable()" code most definitely shouldn't use
the ctype stuff. I'm not sure it should exist at all, and if it should
exist it probably should be renamed. Because it has *nothing* to do
with "isprint()".

> Looks like module-init-tools used to put (completely useless by that time,
> due to the printf format change from %hd to %04x) aliases for binfmt_aout
> into /etc/modprobe.d/aliases.conf:
>         alias binfmt-204 binfmt_aout
>         alias binfmt-263 binfmt_aout
>         alias binfmt-264 binfmt_aout
>         alias binfmt-267 binfmt_aout
>         alias binfmt-387 binfmt_aout
> until 2011, when it had been put out of its misery.

What a crock. Yeah, that code seems to be entirely dead.

The "two first bytes" thing only makes sense for a.out, and those
numbers are odd. The first four ones make sense (QMAGIC, OMAGIC,
NMAGIC and ZMAGIC respectively), but 387 doesn't even seem to match
any a.out magic number

Oh, it's CMAGIC. Which is a core file. That you should never try to
execute. So it's just insane.

Very strange.

Anyway, a.out support is dead, so I think this code is pure historical
leftovers and should be removed.

           Linus


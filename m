Return-Path: <linux-kernel+bounces-382030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C4B9B080D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DEE281142
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820AC165EE3;
	Fri, 25 Oct 2024 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCfXenP4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6B21A4DE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869694; cv=none; b=SAeA1XgJqNFfi9cIpxFPh/q8DmLOYRaCCrwOSZ4J0S8xKql5Cm/e/eOatBDXAYCBqpMuh7i2wtIgVWs9hrIvdQpgsu5BOi6Wp1qO99Q0/G6Ceb7tuo3r2mSaGrLkrOiBAImJA3z0APSiAnCYDwRTuNmhQUb/4NxdAYF+CTZWEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869694; c=relaxed/simple;
	bh=WfGVJHkjby/sDylyYIOucRttjmywo3StXZcNpeKwnww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TD+TIkYzj5X87545Vx+Ya5ZfKeZIYYvNX7U07mFRoW0W2zOI7lx0K1gNnqHxxX3WBgu4yYEy11xpA8QEQT+7nvLfR6Yyb57lgMGU7AWDwYAMAgyXCewsXzlwW7q1IWpBPZRlo3YzTmBZdhDbGNaYxjUDtj+kXc0dK/FOceTe3Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCfXenP4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so242405e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729869691; x=1730474491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9AJS/J4QubIDUNRMib8hknd43k7UlEr1REupaDva6c=;
        b=tCfXenP4PzlJf6DOEVUf7BVfj8f+9wfxNEz0YFi8ZUtG8Yt7mcMMU17kEYGoaxhDco
         kWGKez+UMYAdJlmgBD7Dr06ZHg9JhsOXxvMWFAWibV29pkPUTDvFFBaepMA/ckza6i7q
         QDqOu8zkHpuiqlbEFWnJ9/1oCJfQSdCLDpWjYqh7v2LX0qI/rlDaLfaquwhmlNRXeUeR
         qmupYmtoDx6iOAm5iC/yOwfRFvPF+mzj+6OXVmjO5y9koRyPcTZwePr3wtaL4t4+AmL3
         BZbHfFfoO6AkMxyoCCUBv+q4aIlql74CNmxjPvUsVy9SCcdxc1HU+7Rls1bpqsC4qIgY
         djrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869691; x=1730474491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9AJS/J4QubIDUNRMib8hknd43k7UlEr1REupaDva6c=;
        b=c+x9PcfDnSyDCvB4Vfrl3PuKuIVGF3Qm5PXB07Ya+QBlEtVz4nqMLo2P0cZ8s6+J7d
         +Xm+PpvO4fMDk/RJIbALf9VJC5rNt1oTCCoEgCv1AvhU/dl6k4MDadrShl0hI9zfiIMm
         BJ5oIngGyAkSlCOxFUOUhXgkAdP8R+Ovj3kuVvZo5OtLVRGY0aByuDkDU5BU/oX914pX
         Jh//5udMg4KJwfqxwIzsSIkNlbHtwgxOXg7skYjoigbBKzpmxq2cxaQm6LfklLyGXXyV
         hXKcJRzsO6pFlH1HRjyr/fqA3OzXE9TX6wxITziv4ZxZEsAIhpR/7GbzQrRYZPQ0vv4X
         HDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVuJKUjfuVgTQIa4EGU9OQQv+TUY71lI64cWnPyvzbwvGWsFI0Rwzjy7cZSA90anCu0lV/f345u/lz3dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0P7vEqO+n0+0qHmzSeuLMzWSyTqMbI9QAL7mKWAaOygwbYNf/
	T6T1pwXOY6JQ0JAp1hyW9ToVWtVVXDXH2mbcxuTbJw0Z6gS24Un0RHKDT8xe1qD0moz7vsrnK3M
	i5b8xrP6xksStONja/jKTJNBJ2JeFGN2A6j5E
X-Google-Smtp-Source: AGHT+IF8THsb2wXUWrQi/D1S4TzCOI1qytUeBb9QnU2xNlDnWEvJQNfuwMXJJZLZG1BicrLdftQVMdA6xmzVUJwrZNg=
X-Received: by 2002:a05:600c:5013:b0:426:6edd:61a7 with SMTP id
 5b1f17b1804b1-43192ece940mr3856365e9.7.1729869690704; Fri, 25 Oct 2024
 08:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <671b7fb2.050a0220.2e773.0000.GAE@google.com> <832afb0c-98b7-4d29-8436-1ff6a65133b8@lucifer.local>
In-Reply-To: <832afb0c-98b7-4d29-8436-1ff6a65133b8@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Oct 2024 17:20:52 +0200
Message-ID: <CAG48ez3c=KS68hnLu26mw2qwkaT8__4cvFw8vdzK=R3QHv7XeQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in vms_complete_munmap_vmas
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 1:37=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Oct 25, 2024 at 04:23:30AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    c6d9e43954bf Merge 6.12-rc4 into usb-next
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/=
usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D139f225f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4a2bb21f91d=
75c65
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D0ca979b86eaec=
7337a89
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D179f225f9=
80000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3bf4a453ec2f/d=
isk-c6d9e439.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/e4a2db2a5d95/vmli=
nux-c6d9e439.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/8eb8e481b288=
/bzImage-c6d9e439.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+0ca979b86eaec7337a89@syzkaller.appspotmail.com
> >
>
> Isn't this just the same thing as [0]?
>
> Again I think we're just happening to hit a stall in the unmap logic rath=
er than
> this being an mm thing.
>
> We retried that one a few times and it didn't hit any mm code after the
> first time.

Random side comment: It would be nice if the kernel was able to report
hangs in two steps; somehow scan and mark the stack in a first pass,
then wait another minute or so, then scan the stack again to see which
functions we haven't returned out of within that minute, or something
along those lines...


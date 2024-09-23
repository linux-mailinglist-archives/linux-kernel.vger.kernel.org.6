Return-Path: <linux-kernel+bounces-335819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101E97EB28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F6B1F21D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139D82866;
	Mon, 23 Sep 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RSP8KH8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF180038
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092716; cv=none; b=DX31yT7zuBjZU7GTHVXNLOwJPZsDQ7CaqTzUXMule6uhKd52sk6dlu6GnnEMD0/Z0jcZ7IrzlM90p84ilrUCFtrPGP2LsTCMWwA7nfDFGWm1ZvM7i3RPVmQIxG2mIYMYQD9SHWexrlkG9YA0nUZTrQw4FXBrmEkO/5Gf8IJAi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092716; c=relaxed/simple;
	bh=hWZwMchaC4TXp1eEhqyp4M9gw+HjqgluYttHycUn+zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBZk92/Tmy2WxpE1LwGpI2125U38jTAJGXo6jqV8dIJIlujp7FWL+8Pc6oTtcp0a8E/UFSx92r3B+roy3twO4Ki2EtOGn3D6ufclAV97CV7uia4ppHlyNdwZxg5V3Ht1LFd7A+OD23NksdTqV9OQbiqbSwBJfwOkVAG1+QeVmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RSP8KH8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718da0821cbso3226247b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727092714; x=1727697514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iOy3F5UhYdO07lOzBiN5XGBdBxeYkWOi12G5NHF9q4U=;
        b=1RSP8KH8NsBjzhYadI+MeJe4I4fV7TJkJI7edypmGkTy1heWl93OOkyWkmc00fGpQj
         Gnm7mLGX/AWmyGGFxohML48vpw7a+fsWMpkF8PjPMpEeaWsF5oxz3XwlPprXHM4jvl8O
         C1Ot2I38T1dZXnGwqfLI0npjqJ0W1b+PdFzKJyg68+82YCsO45i9E2aJIzg8jUCtAuvJ
         WC05Kv9wxbdjoPT1wcEhBaZxz3LPDcIZy1kzQsrWjG7z4PNgnZqcJ3BRWvcZdyMM0jI3
         ZeOvsvnltfx6vT1/+AtWwZL9erxe3rTqh5sr3Gp4bfVXR9Ld96jJTA/SQNGOmFgNN2ki
         7b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092714; x=1727697514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOy3F5UhYdO07lOzBiN5XGBdBxeYkWOi12G5NHF9q4U=;
        b=Zq4WeSxgSXDAsUqbpD3ier/hD2Tb5BxpZcoOVdFYScQdm9sigCi+8VwfQQ3S5nztb8
         y4v8MvcYKEiaDPMCKzSslKFjio/bTynV1EyJMBwwSj8UQP7mBWXN7Be0acTT1V/1xVu8
         TPaT/butJ/Dx9Kzr+77x1oxVOHIFW4zDq6lOvfrY3U8xE+6m59vllzJZGIRP5QknM7q0
         +bxyVaKBRBoxztaBr0QbCtr+GLTT0BQMeWWLKIBr4KodCgDwyzG0FhtGmGI1Dk1fvqKw
         pJ2M2HfrQhl2g3T8gLLxa8XNI+vno/sKYKgvRichP4gwlvD7tYGAFUJYgaIX0q/tMHlj
         agfg==
X-Forwarded-Encrypted: i=1; AJvYcCUDPvzvJj24Tu6nDB5d1wbiaIJIs/kbDmaP1Eva33UnS+WCNVgp4VrtKC6TSFaR7EN3oA+wFYwGfXGvuL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gmY7S0TRhwTndYGgWSgUJkQtHGqCNrX+/FzFZ3ufVn9F3lku
	1HDt2YayfrBDd21Xw9k086SZg+y2wAhKXzwHjlev7fR2yyLlRY69prKfwQquVWlsniUSHXiyaby
	liDW2YuDiTgzkLZcq6JNp0cGw+ddDwNVm5aqV
X-Google-Smtp-Source: AGHT+IGIFobrvHy+AXM4qlo3wITiio8U/9zcHky3RTDkeEk0vlFYGkf2d/eaT8VNYEdS9qlTVubA/rTK6i98CSYi410=
X-Received: by 2002:a05:6a00:2d91:b0:717:fd98:4a6 with SMTP id
 d2e1a72fcca58-7199c990e08mr16661821b3a.11.1727092713634; Mon, 23 Sep 2024
 04:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f12f17.050a0220.3eed3.000b.GAE@google.com> <53e80bb1-9d26-4885-81fd-6fe816b4980b@lucifer.local>
In-Reply-To: <53e80bb1-9d26-4885-81fd-6fe816b4980b@lucifer.local>
From: Marco Elver <elver@google.com>
Date: Mon, 23 Sep 2024 13:57:55 +0200
Message-ID: <CANpmjNMJWLq2H-Wdrx5SjPjc566V4siqod2Gy6-Dms2sn2+8PQ@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in mas_wr_store_entry / mtree_range_walk
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 11:44, 'Lorenzo Stoakes' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, Sep 23, 2024 at 02:04:23AM GMT, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1237ec27980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e6702f5f2b8ed242
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e01fa33e67abb0b3b3bb
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
>
> Thanks for the report, investigating.
>
> > Unfortunately, I don't have any reproducer for this issue yet.
>
> I suspect given this is so timing-specific, a reproducer might be difficult.

FWIW, syzbot currently does not try to find reproducers for KCSAN,
because it's too non-deterministic.

The best strategy would be for a developer who has an intuition for
what might be going on to create a stress-test to reproduce.

> This suggests we are failing to acquire an RCU lock on mmap() (though we
> have the write mmap lock).
>
> Maybe we missed an RCU lock at some point, but I'm a little baffled as to
> what could have changed in recent series to adjust this.
>
> I will dig into this and see what's going on.

Thanks!


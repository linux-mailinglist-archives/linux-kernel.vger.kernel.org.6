Return-Path: <linux-kernel+bounces-574632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D9A6E7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3593B2D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC58635D;
	Tue, 25 Mar 2025 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PeaXWw7L"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580A38382
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864388; cv=none; b=iwLaaeklDJY/c5Yc9g1YWONl6wBgFtP2YoIx6dBsUmXnuTgH2KLxqt0nZXG9AyYOyQLgaQCldfhBdgWvGxz5PtDdq6SoyyiMkHJFIsa/UlxzVc6YCS+eKc9WaJPrNhoJKTNet52dJs16qOWhPRh0KABd+5Jib2igNyegNofo7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864388; c=relaxed/simple;
	bh=NRvCakT7kAG319KdmclAAReKTYEyw7BaU+1e0n7zU1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBrVgoJ+VKvxWiGx9YghaFRF64STfMBIpOu1GnpyAlS14XXHZR5bwXMnAo8qCiNUuFlt609OC4EJygTqXahWoR/+iSdbfLDsmqfrF3S87c8B86otfS225DnaBNkze1ZpqiO7x0NUIrgFJGsSee/VwX2IbI+0rxAw+67mQ/1bFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PeaXWw7L; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2263428c8baso70225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742864386; x=1743469186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNkoA68URmsmnPHd0iqdzahmpjI3XdQNzLYFV9zmrgI=;
        b=PeaXWw7LCT+j5BsXBp721q9940F3q7yV2wJViLFIzqppeZCL0VXlgs77/dYFzL7PBG
         NQ1VTDE+mjvBhm36CnZPyTU7wyiz6k9IO/JfK/qmlboY3eyNO/JUdxGsJ86/0+blfx5A
         CDALmTnpy4wxUxmxN073tPZiQHR4Hzpqp4HCUEF15jLjAOpyqciQ1Q4FbDBUSWwauivD
         N7H4ftHnCeblIaPSoAemxNl947sPp9tTJmffH4I0Yxiioxusxabx/8xaNiSPNQOoGtHC
         0nMuZHkDGUZxCSnpOevQyYjIqap1+TTk+0kugCSTROWw400IKN7PWgXKKirsU9vizG2T
         Q/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864386; x=1743469186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNkoA68URmsmnPHd0iqdzahmpjI3XdQNzLYFV9zmrgI=;
        b=EXPi4CRF8UVSCvnir3B5zeGnNqD4RflrvCzLbqbKcDtM+hsqC6l+jbAot7oq3XcbVU
         GO4b0eoEwnSlOkD8maNMIgepdGjjKuYKDXAzHrcXyzM7IDty07VKbyxF/DKpmsPonXYP
         94fzQjgOFcqg1t3CiMMD8ejaR9W1Tg+E4iSQjDhWkEa+/1Kx8eg4RA94ijHl2MQY0vWj
         S5b7DCartWkskwQcmlZyU3fkyY/9mHpQqz/3n+ggOngdT9ouGbbxs/IMYLhxjAq+1RBr
         Bz0weKro1xRNUbgZ1Xdds6YibrFn198lwi1BXCc2qlP6KF86dZuE7IeIi+ZMBrJMib0a
         H0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy3ADfmsb4OfNUqS3S2zpyJYhxorFGTqr5QaISpgH4Hlo1u+9pHlE090IpaGQCdQBBERV1jc1zFaDOsAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNpyCXEwIj1AV72acGAwENsGyFAYXxdF1rfuern3kthhQW/Sp
	DMRxlJHqCy+L3jRcylxShgsphsr/WFr8Put7trBB7HmsOHw6NyxrET8LJ8v/lg==
X-Gm-Gg: ASbGnct8XXd9VJImUov71J8wWm/YtW96istJfoucTgbaRbeOG737/4b6OXPhf2q4shA
	57b5totXkDrRJvsYCjPz37Z0aqeZyQ1NghVNleFQSFM4votg6ykkiBwWenYkdttp7Yr/T6FrpYb
	YKAkJqhBPKdo6dav9gu3OOXr3eX3zKDlTn+HlvwOU5H8P7EKCCMQm7TO2h8oLfq4NA/lTQnw4UD
	pVefN14fiaBT/KxiA82fl80I6IWtCdrjfxY0NjGIEeD6z6HCyHXOyhTDaASuwzcZKqahs8qFCUS
	EY8B/dOyZukZZyywtSTf/nts8/bhbBkZelvpAIn80GsdDD6CgBbpHs5Sxe/GG6WUFxbdDpNh0ED
	WB5N0
X-Google-Smtp-Source: AGHT+IH/k2S6mch9DLFU6boCk6QbwFm9xBLB2a81hMFlXsPO45Q7g7ZxY3/B1q7/ufDmPasC1WzLfA==
X-Received: by 2002:a17:903:32c6:b0:21d:dba1:dd72 with SMTP id d9443c01a7336-22799f471cemr5581645ad.15.1742864385945;
        Mon, 24 Mar 2025 17:59:45 -0700 (PDT)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390614de5fsm8676901b3a.127.2025.03.24.17.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:59:45 -0700 (PDT)
Date: Tue, 25 Mar 2025 00:59:41 +0000
From: Carlos Llamas <cmllamas@google.com>
To: syzbot <syzbot+810b8555076779a07399@syzkaller.appspotmail.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	maco@android.com, surenb@google.com,
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Write in
 binder_add_device
Message-ID: <Z-H__dbcSB4htqUZ@google.com>
References: <Z-H9q5X8e6uYiaF0@google.com>
 <67e1fdb1.050a0220.a7ebc.0033.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e1fdb1.050a0220.a7ebc.0033.GAE@google.com>

On Mon, Mar 24, 2025 at 05:49:53PM -0700, syzbot wrote:
> > On Sun, Mar 16, 2025 at 03:51:27PM -0700, syzbot wrote:
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    b7f94fcf5546 Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=134f303f980000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc24cb631dc9bc4
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=810b8555076779a07399
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >
> > #syz test
> 
> This crash does not have a reproducer. I cannot test it.

This is likely another version of this report:
https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
where access to the binder_devices list is unprotected.

#syz dup: slab-use-after-free Write in binderfs_evict_inode


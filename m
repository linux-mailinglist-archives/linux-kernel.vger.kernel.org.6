Return-Path: <linux-kernel+bounces-290192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD04955092
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCF1B233C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23521C37B0;
	Fri, 16 Aug 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8udlA3U"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1B1C233D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831836; cv=none; b=Cw16gkPlJc56xZ7hyPfZkc2GsKojlzrljnnC981j1pkLyXJyPstywfT9ZSlgeD+nGcsh+IHs3q9Df6WceGp43at+b2tOMJF4BYOAAGTZlxAwhtWgRQNMUy3j4g4Pziays2EwED0tijP8ozgL27tvT7HyTphVOUJX4XBcAtDRcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831836; c=relaxed/simple;
	bh=xHQoPuqd+D9OllJ85LC8A6kuHS0jVMOrx5MVSJ99RK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r4cBlL4rEXsuDeivYY8gEnYukvTeKc/yePeDdbleU/vQHaNn88DHhEMeeyvOz0G+DUW7ujULW0kOy284h44eWDQdZdfFDuyrkY82hX1wySePmB+tMWpgyxF7htlyNLTkmI8z/k+mvY9ak5NNMh4VBi7xDaVM1DsAvXf+9DKHp5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8udlA3U; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ad78c1a019so2067384a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723831834; x=1724436634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKLhc9rN0MWqFTzo18sKWvguSCEcuhqaVkCHFGI4wZg=;
        b=w8udlA3ULp5tWe6SGZmCUaSiCpmZTliz/JYbXR1G93R4/wBxSOHGxe7M+lXRHAdBf6
         g0IE6tmr2tJ1yQ2EKPOGAeiZ0HqnGkNP0gj7beeQqR5HSpb4JZR9XJ8V8rX+btNh24Ke
         hloKUv8zxJeb+EpEb9Gh4auD36pgEVY72MY73dFYOHY61Xvkcjp8CoC1Fo60ocIOcBCG
         gTr22uTVA5XG3BikPNWleefD3XlOglH7UHp8jqCN3son1Koia/1ATOQjCf/Hg11KXd7m
         gfEgc2VTBYDghAmulz29Ug7WMOmstGWjxIGV3Lpt+o10oooJpSFneWK/x8m4q/z/tt5O
         /ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723831834; x=1724436634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKLhc9rN0MWqFTzo18sKWvguSCEcuhqaVkCHFGI4wZg=;
        b=VLTculJh0jf/sCdjZSqvfw/Ne+IHPIl9wprxpGx1SwtwAvG/f4Fno5P/G/S8kH1JTZ
         23FOoosENPLsSvursDJZmtmzD1f4OHbB6py2xvqv+YZOc16wbXaiscBBlr4r9v+T36cA
         V73ewdbE0pBUyyD3W0QTX3soR+PkV7fWxRRvePyDoOamRd/hf/sZnyK74cBKTeyemE+f
         D0hQQtpaaBcNB3mRYjAiUWqyfsjLLRu65l2tMFDUYV+Obh6wr+0WocKCKsFOzxbRV6M2
         WsFm5WAyXx8jaYAU8ru2k2f2zqU/vxceigwdogXEtgmv947vxEG9A/o/Y3U7MXijrbMA
         Zxeg==
X-Forwarded-Encrypted: i=1; AJvYcCV1p1Ip06I6Wa6lOawx5agn+YdLh9c4bxIglQe5LtSPNm2DF7AdaLlORFtKXLGlq8+/NhaaSYUTp/VXB6OQimWnJrAsXLYzwQERdZZw
X-Gm-Message-State: AOJu0YyEXM52c15lthA5i0hjq7ZqwG2Y6iDmW8fBgNzOnLVVjToLMlsW
	IjjQnO3A5UgzseR/HWMWA6WhqU/LgYdG65UlaVw6vCzGXM+fkacUsXGrARoSfJHCbCl+RxwMwFt
	v0Q==
X-Google-Smtp-Source: AGHT+IETDCf7j3tWXi0l8Zbb8sKAD0O6am89PjJGOYdyX0iluckeLErw8vyRXlL+vHPvSkgy+0M3cMXJJsI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:622:b0:7c6:b68e:de7e with SMTP id
 41be03b00d2f7-7c97ad6bbd0mr6141a12.6.1723831834162; Fri, 16 Aug 2024 11:10:34
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:10:32 -0700
In-Reply-To: <000000000000fd6343061fd0d012@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zr-VGSRrn0PDafoF@google.com> <000000000000fd6343061fd0d012@google.com>
Message-ID: <Zr-WGJtLd3eAJTTW@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com>
Cc: eperezma@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 16, 2024, syzbot wrote:
> > On Wed, May 29, 2024, syzbot wrote:
> >> Hello,
> >> 
> >> syzbot found the following issue on:
> >> 
> >> HEAD commit:    9b62e02e6336 Merge tag 'mm-hotfixes-stable-2024-05-25-09-1..
> >> git tree:       upstream
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16cb0eec980000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e73beba72b96506
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >> 
> >> Unfortunately, I don't have any reproducer for this issue yet.
> >> 
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/61b507f6e56c/disk-9b62e02e.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/6991f1313243/vmlinux-9b62e02e.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/65f88b96d046/bzImage-9b62e02e.xz
> >> 
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+7f3bbe59e8dd2328a990@syzkaller.appspotmail.com
> >
> > #syz unset kvm
> 
> The following labels did not exist: kvm

Hrm, looks like there's no unset for a single subsytem, so:

#syz set subsystems: net,virt


Return-Path: <linux-kernel+bounces-290209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B69550C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550E7286E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6281C37BF;
	Fri, 16 Aug 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5/8dXii"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F371C0DCF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832679; cv=none; b=U+iVvl6qVUlBb2oHncCTFQIMIwcQwS9cHAjKNTYtR0XxqNTe3tMAO56o8DmGuo0PsymnTAZIkuuBOJ2Bb7pBAr1W+qfBJVBW97HRLKlN6fBW+l38CtZj7+BDXpUFMHpqf/qiceCSBGs836flL0gNI1P19YFX8bWAmY0Ttv8B434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832679; c=relaxed/simple;
	bh=KfdgmwNQlJhITu85hViAhQH2m912GxeX0PW2gdRLWZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dHPxVsst+fNeeCylUGWJ4IKxgobvdtB2yzNbtuYGahmbuL6cmH51eiExi2sCCnW8sSRCUbzB64iPHPKwsfwGhUBS7kFMsp6t5u2EI5RvhLNvkz1bT7X3oSoOVl/RzYss8lI5hJmZJzdeY+JwXf5vARJosWXrcpt3sjcMLafWu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5/8dXii; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d3f948347eso418288a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723832677; x=1724437477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RwvB+WPYoDnWK8A0tq8EiazLJfKL2CtNS7fQiVukC0=;
        b=e5/8dXiiuMVZ22VqZ7YcGmesNeG11fTVq1KX2B9gjOPL0XSpPiiErM3Nm55y+QCGTF
         t+3p+o2v7oEPv89Z/okNk0MYa6gM3qRVYkM+9dRnP5E16MfQaIUN8/IWrBBm4mJbZ7KE
         oWSjvlszLq/bp/C2PEAgsAgyMtD5WhnoDpWOZp53HjvfisDMl6h6O3cFaPjLYs7QcVUN
         HgsNZNW0TpApEDjjA/eczHPr/eksgTFMpAVX3uLEUHc0jfnIp4plgyN4LaK8isA6ESR3
         DdqNEgBIJ1YUFyBSOox0fHT1WJEMnH8L55RZ90xgSTWdTDV3GypoQhQE35cm4vhCQG6c
         Q0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832677; x=1724437477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RwvB+WPYoDnWK8A0tq8EiazLJfKL2CtNS7fQiVukC0=;
        b=YLldgj0v6ITcwQK4udLT7oZqUX9IfAM/90guobks2XIyDV/YHnSiRvjr3E1mkHJ5vN
         /+kC52CetgH6efigjbpSht1NZVBeD9xWZ7ff40gEq+6DxwuNEbmMVFH4uHSpsbIXN9DW
         RaWzoUGumHGPIHvo37NLLssvSibwHsFVE1kCHYIro1AHLTao0XXM/FZRDw3gl7dzr+j6
         Z+ha//KyJIqergY3D4hNX53WCVtvfBk6jhHQKT6t0gOXnhH6QyqE/btxiDubWU0s4McY
         GSYtHQ/jkhE1xnjas4Mipw6w0HiD5qWDdv4uoDi5HUbjGtIxRRKUkxMdXnrFZnETZwtY
         EnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQNGr6P6FTrVnWq8Qnd9Su5F1Mz9CX7HfeoZISGwmjadQNRouZ89wPJ6JAfOIDZv9OaYwMfwGqDIeSbTR8Iea5inv6UVHLK/FeuKgr
X-Gm-Message-State: AOJu0YwMIOAyucUAch+1Z/vb2eHtyxad3vFg0H6uyQoBrax3cgzsmkUc
	edwu9HrQvXSU1lebKnNxwn0G5Z4qQ9TGCe8o3YKyyshXb3O4nglGIra/Ss0E2rxlYhLEnve2WBx
	iLA==
X-Google-Smtp-Source: AGHT+IFTs6mafYXYQyMdbVzMHx30DteW5lbCrThkaAk8B3G1fl2Zt7Rvnd8UnKlKrq/X37xDttudYA8SWrg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1906:b0:2c9:5ca5:4d20 with SMTP id
 98e67ed59e1d1-2d3c3723c6amr46011a91.0.1723832677231; Fri, 16 Aug 2024
 11:24:37 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:24:35 -0700
In-Reply-To: <0000000000006eb03a061b20c079@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0000000000006eb03a061b20c079@google.com>
Message-ID: <Zr-ZY8HSGfVuoQpl@google.com>
Subject: Re: [syzbot] [kvm?] general protection fault in get_work_pool (2)
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+0dc211bc2adb944e1fd6@syzkaller.appspotmail.com>
Cc: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 17, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16f23146980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
> dashboard link: https://syzkaller.appspot.com/bug?extid=0dc211bc2adb944e1fd6
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0dc211bc2adb944e1fd6@syzkaller.appspotmail.com

See https://lore.kernel.org/all/Zr-Ydj8FBpiqmY_c@google.com for an explanation.

#syz invalid


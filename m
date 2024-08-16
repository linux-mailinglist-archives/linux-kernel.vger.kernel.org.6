Return-Path: <linux-kernel+bounces-290206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC79550B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9704C1C210A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CE21C379A;
	Fri, 16 Aug 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyiR2xY0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35892F43
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832582; cv=none; b=Hojtqc/e9hzM5F6MiWTtddxDP1EnLF3yg3L8aRLy3QhTuM0WOtaIy8k94Lsa/9nlI7vykGlyyXd9zlMgIeYw6wgIHCzsoakrTTEsw4dnbLRj1zg1Ucs7fIdq30scF4lGC1XLDpWonKoDyh92D6PiPQhC7XIHdPzkEcvlnDP5muU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832582; c=relaxed/simple;
	bh=C/KPVQOdL61r1aj+fFYyQJ8nYW6G4L9oj+F7eqj0zxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIwc0EpHY+nGcdVuwQLBmi1DF98sK4jk+K6n4/VjeovLXq23VliEFuDyoBJkQwSEXzII3yYYDXUo6i/1HWRNN5f56m8V5Huo0aCYcXmgdPdk15hml2jlDV/zXRn6toRjWgZ6vhsI6jx9jiVTMhwltFtLd42njVS+4fypTtz+wn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CyiR2xY0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6acf8ac7569so43561667b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723832579; x=1724437379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Da+yOGUnAi9BrtxeKlOOzLVm+rCdCeLa2u69ZA1xPsY=;
        b=CyiR2xY0EqnCnwW5KUW0XZybvLPrnwZhEQH2T8zpbM7G6dOFUC92b0Jkj34jFfgJdI
         shYO1g0lX15CFBxLsw8nduXNJhHJDSEvuE8/fU/L7SZWPZyzDjo3Z+ZIf4YtL2tXkbl+
         eg9halxd/w28aSUXWxtXdXMG61yHN/ltToZ8//GQ8qDZBQ8qJsZaszW0dSSzdbFtvGgi
         gAAEsL2tQowcv1uxVbLPtNaBJEl9imscdeaUdzLH1yvOGeBjF5O+2haPHNxwD+PTi8ek
         7Immfc4GWmnzClq1y2mT2WSHYTpZSOu7+yPswSYz1t7O+Mj1QR+1Nn4CqJbgFx7E5IzU
         vrbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832579; x=1724437379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Da+yOGUnAi9BrtxeKlOOzLVm+rCdCeLa2u69ZA1xPsY=;
        b=ubGH6WLDzXvlksM7I/MAjUNdRf4H7MbZF2WavPzJLoTaBsGCsLOKu0eDj+2/GoEzHV
         L+McijGQ7Td8T8kzkuN6zCu4JMM0G14JlP60AYv9124qKZzJe0jeXFSvXd7LiIHdWIHp
         +aidTydH5RgPCEgpb37XgLfnjqUVPlamr3xR7dj/pE7LKgSV6REs9LXWHoXAQoteBVZ3
         Hvu8pZixH0axaxGtVdrj2+kJ11b5hXF5bzin7UX5bQrscYjklJnWcVyV49MseWBW/Pp3
         /ArVpcawy0c3I5Y8e3dVOfgsCDT+BWgs2ygJ9ku1eLERcrYEekWPGDceVAedy7VaCNmV
         XwTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXen8a3bIsr2JuwzzPjwsikXFCPqlhYOWXJihTRxhr+BGMlOOWd3GN/dVad4gvz7fKZOhlHjiEiKHuSao2ZKQ2cbh7/j16L15f2Lb9
X-Gm-Message-State: AOJu0YzDm4O1Kjxue8YJz9N/6JmOBBgq8SLWKrvirYS5n+V5mY5FM76a
	Vezj+6HFGKfRmMFWz+/qi7syLHQWrnQWL37g8UVMzAbda9Sor+GqJ1Mcp5r11gHdRKOmciuKIqP
	n1w==
X-Google-Smtp-Source: AGHT+IFfcTETiulkEGd1KSTGEzd2S0thNDH+lgRaKyP+72dCCah4oHM6tDo0fs41jUmb4XdaXCTSKTwY22o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:68ca:0:b0:e03:3cfa:1aa7 with SMTP id
 3f1490d57ef6-e1180e4a917mr5430276.1.1723832579587; Fri, 16 Aug 2024 11:22:59
 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:22:58 -0700
In-Reply-To: <000000000000fbce8506178da1e8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000fbce8506178da1e8@google.com>
Message-ID: <Zr-ZAsFVFiQuys7K@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in cleanup_srcu_struct (4)
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+6cf577c8ed4e23fe436b@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 03, 2024, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14004498980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
> dashboard link: https://syzkaller.appspot.com/bug?extid=6cf577c8ed4e23fe436b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1b4deeb2639b/disk-f03359bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f3c3d98db8ef/vmlinux-f03359bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6f79ee1ae20f/bzImage-f03359bc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6cf577c8ed4e23fe436b@syzkaller.appspotmail.com

See https://lore.kernel.org/all/Zr-Ydj8FBpiqmY_c@google.com for an explanation.

#syz invalid


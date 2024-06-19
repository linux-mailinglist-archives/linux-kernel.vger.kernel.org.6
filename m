Return-Path: <linux-kernel+bounces-221078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A80C90EB88
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E347F1F2157C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79A1494A6;
	Wed, 19 Jun 2024 12:58:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3754A14885B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801885; cv=none; b=EpghpWYD28kc/TY4/grcE6eZ7wlZbrGT9By+8cfTZSJ1E0MiCbKn3u0bqqdSpHc9tKq1iRJkC/N2ueZWKUX8iuQ0WhSze75utxqTt4D8gW3fYho2PcGULBS/m9rn/G9OcdFpelbgOqeZYxqGIfmNXUKtu0JMuTf64hsclAHpJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801885; c=relaxed/simple;
	bh=m8aBRy4mN7j0EJLvGv+Yo8UhHdWcXxl9dBdQ+FIgQW8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qXFHMOW93+B/iHTRtB2fk7pGWc+SnIIYMEu+c5rThjM3Imlpj3Eg4O3v/d/eqzUS/mf8yohymntqM+Swl7mVuune7IXczcC7hfKPZP70pS4/Lg5iMwRBW/4Y5xiDeLsQ3jMtnNRbXgnZBsxVtq0qtXU95gNyGUQT8uFzeReT5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-376210a881dso6662825ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801883; x=1719406683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8jzsiNVNmCEzQlIhhbY2JRnB5eogtT9dfAbl4/eOdI=;
        b=WX2hiqt6ZUe1N/gFwc81uB1s+JYhXj+e9eCBRW4bk27LjRpT7XNHoMOewQg3sEe04c
         n6omNZpcyLEB5ZtOt2w3GhZSJhxjVzdfHovmKp9kS/YL2HaeAvGR7VhXU7SbMDoUjtSr
         LSycv1TV6X5cTOgXpmY+8I413h7WmJ92tY2j32nrv0Jl9hxyWY++JsWmqNVAAd9syDLF
         mzyGLCG/TIMwQ0u+FrG4loP1WpNmJ2U68bz6CpnbDm7AWLRzzF8GnFiIhitV85mYzVGd
         3+j08IVDCPaCNxVALLekfacoAWpb/yU07XHYw7PNiGzIkymJVV9bVIIlyGyh37kuJvuq
         KmXA==
X-Forwarded-Encrypted: i=1; AJvYcCVRNY7NUWCosUZxpfGWhqS3z1ySXZjU8/i2ulylQKj88sA75ehi3f6bX8HKfgYNca/0rbOcol+7ecm3zf7g6tKoDpuDqj11BGFZh/XJ
X-Gm-Message-State: AOJu0YwRwjpFCo2dGe32r4XbPLHF33uGOA+53SRPPbwYaaioPCb6HCEE
	Ml3TFtlaPimv7g0NYKyS82R/MWUptwqYM22eNst3ogif9Urq51knHgJy9tK+YU1iLfZwI52mRLi
	XGz2Yr7CfpEOTs2RZv94TbQjQdbOFPCcYb1fPR7L8zHcv01clNUBv0F4=
X-Google-Smtp-Source: AGHT+IHTQIMxF+lQgOg1yHEDktEZ/PM05w6V64nO7cHwtlcmnV6MAhPR7wP5+8W6eggyZfvXdsxU4hOAyMM61IJh6uSVuwle4fD5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:375:8f93:bbb1 with SMTP id
 e9e14a558f8ab-3761d789e2amr1304505ab.5.1718801883332; Wed, 19 Jun 2024
 05:58:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 05:58:03 -0700
In-Reply-To: <tencent_E56D8C9494EB5EEE52CDB8797A6E742CA10A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2148d061b3dbf55@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16b60a61980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11174ada980000

Note: testing is done by a robot and is best-effort only.


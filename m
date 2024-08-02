Return-Path: <linux-kernel+bounces-272027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A9945601
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8DBB2862FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E81C156;
	Fri,  2 Aug 2024 01:33:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE123BE
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562384; cv=none; b=tPZ4+VnVQRMAeFU5NskhaRykJvwC7SpJcCJOoA0m/j6CQ7SHfYH/AEJtETzONP3bew/qM/6MJJqm8CanKdKgiHopxVOP3DSIdV4Ssqa3nVJ8tU1k+VdmR1fLmb8YKaDFCXglt+GwoWpUjMUX58POb17CzZFOHmAClAVxbCeY0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562384; c=relaxed/simple;
	bh=PL5Nf2s/bxZYkjOAlNDiWzj66DoP6+dy347uDvyKhhc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OPrm46qoELkndcHhuGfx+QQM0aAyKUgRevOvBnINfJtWHOxngY0APczQrbg7Si/TTn2jocRaFZtG2wAEOE63LColA8OgsEQjJUnbCxoc0q927WQLY9vaSgBYbeyMCS93MCwt9iZy/LouSMEH+ApFU4NJC1v9+FOlT7try6Pb0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8edd7370so1080110339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722562382; x=1723167182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dEYVPTjkN/3FRfllg5LDzDPtxAcrxwS6d/sfLVK1TSM=;
        b=uTxlZIGTcSwrqlRsbJ3tyOCuX+6FaGo85MJlNak8rYdPOlHDcVOm1d2Jg2rwRBWhbQ
         GwgN0tzbndD4jyGFCVO8gbD5WOpH1/axsbb08PslZQnPGHv2QgVqSQK3oWMPNX6e3kQZ
         jKpjXEdFcwZWqrdBUdn+S6vDacLGj93c5YKqSfSiSH00w/pkzcxT7gNJoOSlC7x7P13F
         WdL7BkSD8Ht8+0It8S+7hai4AkqE2pxZUxnKkRoepgFP190JylD3EIlEgp6eSNf6JVO/
         yUdhmL1V+UxKWl/SXRrMUNfmNwFrvZq6PXRz4ER27GUP3mtIEyRBzhwrsoWe2vYvuGPR
         er1Q==
X-Gm-Message-State: AOJu0YxLBwLqCn8/3KRTuqVtSZm9gs59hKOwEC7qn3cyXDDDOCfaBBNx
	FjcZNTVNmyYQoRfCUc/YrkgLnzWJnd3oQlbyV/6jCYzudqzQd//1IMG4cUKvXB1c9K+nJF/dx2+
	ixwMGUTjR0qj9hptNi4vWzH6Iq/UYr1ogg7behtjj397Sd+IXwGP7ejU=
X-Google-Smtp-Source: AGHT+IF6Juf2LI/f7e9UHjLQIBBmOQc2di0BVEZCIvE4IR/xQLTNJAsfHRwFOmqN5CrJPDFnR5eEiaE0PY/kY5Mgh7kKCvCCnbgd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8910:b0:4c0:9380:a262 with SMTP id
 8926c6da1cb9f-4c8d55ec1ecmr91174173.1.1722562382138; Thu, 01 Aug 2024
 18:33:02 -0700 (PDT)
Date: Thu, 01 Aug 2024 18:33:02 -0700
In-Reply-To: <20240802010252.214842-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e41ffa061ea94eb0@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com

Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1503c1c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=114d6745980000

Note: testing is done by a robot and is best-effort only.


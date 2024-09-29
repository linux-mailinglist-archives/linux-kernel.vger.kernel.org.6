Return-Path: <linux-kernel+bounces-342930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B49894EC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0302840F5
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4E15C150;
	Sun, 29 Sep 2024 10:55:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADF1E4B2
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727607305; cv=none; b=vA9cBX1TXKUzTZUexAoGhTpj0auAtnQz3U0pDaI5msKszRh67lJ7bYbXMhb912mhopVoN6RQdpYXd/GbXNiKRfxRHdUJa82cjcZB2aI+58VdaIe/0HehrQeC4/Vu/RMpvMdgCrNxH7pMUk5ZyJpiARyGdzoF1Kr0gMUkx0vkHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727607305; c=relaxed/simple;
	bh=/88c3EWDKIcN85mQHHqnMZiNmK1V3kJiTObYzxI2T6E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YEfFnpuQmQHS9N2GryqsvJPryzVKJfSZLWCKmrSxr15H23NLk7W6ZoURd2J5M8iUk0g/6nzEjN7FTPax/+6bBXBH2TQXkzHa90SyGepIVQ9WA9sOHMFEjFtw6XRqQh5YH0d3wInlssPKRfunjFv5Dg45a30MAbIlxMuO/GT0e9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so31306005ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727607303; x=1728212103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5u94XrfD0qF60dxVtPwcFy3wEBx21NlWZVWjT6EBtk=;
        b=ew/Z175KezhTrasiXbaAFMIBWPLC+ssGrHZF7PKh8EO+1LLPPiHeI44Z3G1V88nx9F
         5TJMWpEoAqmr9savoo8wON04Bo5yAUmFjvkdwg2zNpkAH+uJ8sPBVtREcmhqyC3T2ssz
         yjywWJC9/HA5CjvrysLVictjJwP1XRLpRc4/ZywGcfiV1XSvWgA8FvpsutLWFyQerh6X
         hXK+K0kKmMAB/9WSXppQncKEIGRLY+66LqRqIlWbwl7ujYXwLxGRzXgITNyLsoOfs5VY
         u1vAIS1VT9xvL9HUFl1/XJ7vHkcykSb+PDZe812DJfJKqV6vqHcHzW7CrhA+pKIEjS3A
         BROw==
X-Forwarded-Encrypted: i=1; AJvYcCUDE/5BJE3HYnL7RFeacj4Rizd0DAJex06z3NDRhh2mPTlVpBkldta1Q3Q4JpWuN6jDX4kViqyZkr12KO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB4Jhf3TwnJLPkOE5fu1DX3ZuaN96tiAzvrORIJ/4Yb7ezWp5M
	rBid4myFfRP6THj5oxGzLSjKBpkCPCWLeAmyqsf3ERA+2AJABn1VL8uKGUhJUKp1bg6ZVRs6cNZ
	sVlNLdTOxuKawlImBXtVQNzJA56eriok21miisOYfmLtR1BNcZ+2/Z2g=
X-Google-Smtp-Source: AGHT+IGb6eqm2e/Nafs9qXG21JCulCOFqMIbxU5HBTswWLOD8Qt9aldgKqefVwudu6EFYwjJWCi7OHGgX1LS2mMSnSsgMDr30XbF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:3a0:c23f:9647 with SMTP id
 e9e14a558f8ab-3a34514afc2mr74313435ab.1.1727607303477; Sun, 29 Sep 2024
 03:55:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 03:55:03 -0700
In-Reply-To: <20240929092855.205447-1-dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f93207.050a0220.aab67.0019.GAE@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
Tested-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com

Tested on:

commit:         c824deb1 cxgb4: clip_tbl: Fix spelling mistake "wont" ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1609cd9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f49dd07427b3bf8
dashboard link: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fff6a9980000

Note: testing is done by a robot and is best-effort only.


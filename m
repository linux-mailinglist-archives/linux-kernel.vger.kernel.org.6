Return-Path: <linux-kernel+bounces-316158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12896CBEA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2591C22AE5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2AF522F;
	Thu,  5 Sep 2024 00:46:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784824C80
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725497163; cv=none; b=DJUe+UzLpjhSPzVOJNjmCRP01jUuw5kFU3BZ83Dd+1YPbqdHaPraF6xi33vqEd3Lv/B/BpbGMM7kRFAoZWqtP1XhIcZg7r//oMUxStV+854h32VcUPD2FvMt0JzM0gTfxbBJmGbB3Tyzlo5yPG7LqCpWgo4ijFIfYMM+jqUmIo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725497163; c=relaxed/simple;
	bh=BCTJWFiI1kTcNvNsTjEv0xIwOct//wMSdFUsUMQ87Io=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HdH8jsjjF5STs6pvfk5eThah0hwr7NiWx2lnJu/ZJ0/2WP/3yBCqdyhSbgMvLykwvUqc3HNJVS5HDzBxvcH/enkChjG9jt/r8xP/X17midd/SlJavws7CDEl2Qx5jMtQta4rXLtMBR+iTnFB6iHLSeW53UE7ExHMQtnOc6n0qB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a3754a02bso30392439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725497161; x=1726101961;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv/KgTUMSE0H7eXd5Uo2YCrcHJ2lsuQ0OfCcJ4tqu3k=;
        b=Kl+osIWDJQMIp+TOx4RAGHqw/Dn/AqclCblvSdX/sRmwibqZx4SDkOpGmM1Fo0UpAI
         DpNscAVJ9vtoxEf/vsQQ2yI/NLTA1ujo3WFkgq8jrJJ06LqnK7elQeofQNIOei1LYbuy
         /OIDvhocXaI39WOSWnrV7lZYCJm4mP3/iyIPZpKoJJ4x30LM4oJ5QUfSpxwEu8CPA1tp
         /nGbySyQQJ2Suw6ED8bRcXaN5nik1bYp94wvZzvnaa1pf39TskQH1Q6LmISmsmF5vQwU
         Ul26D+M+zZPR4O+rCavvOsxbtnPDr96SdbUUGLaF4qBz3tnoxiXMkmUeJta4NSRmHFL/
         HCiA==
X-Gm-Message-State: AOJu0YyDKbVTkDwrhOnCZlvLmXoQlEf/SXQxAim1l4sZP2yKwda/ZoIy
	AX4fmLpC9ii1NU1T5EM2dS/mHSHxSyU+E1QP3hAuGqgsAe4bOl1HMWXkWAPwtiyrLL6Kqv2zEpe
	M3LG/2Jyi96z/fwEG3JKz/W53tKwvDXpdzFnJCUjb/OVMy2zyU3Y9SXE=
X-Google-Smtp-Source: AGHT+IGRqWOkJx2uuBFVfxv33je/LLQ6d6jFHOJ/htCnE27xiS4Ah4e5GhBYAJ+eO/6zJ32E0jl+0IfL1HWIa1OwnrzRPV/FWtnC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1316:b0:4c0:ac4e:3295 with SMTP id
 8926c6da1cb9f-4d017f15954mr1152966173.6.1725497161525; Wed, 04 Sep 2024
 17:46:01 -0700 (PDT)
Date: Wed, 04 Sep 2024 17:46:01 -0700
In-Reply-To: <20240904170517.237863-2-matttbe@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005fbd530621549d2c@google.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
From: syzbot <syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, matttbe@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com

Tested on:

commit:         c763c433 Merge tag 'bcachefs-2024-09-04' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ca0563980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11da4e8f980000

Note: testing is done by a robot and is best-effort only.


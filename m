Return-Path: <linux-kernel+bounces-293869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4C958600
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75891F240F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9659D18E75F;
	Tue, 20 Aug 2024 11:42:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA518E74F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154127; cv=none; b=tFwCJ0ssE3CCwGD93kWFPQITFi/8pOIqR+o0pYtg+OCRgwDILlDNejDX71Ex/U3M9uTiqV/Q/Zsnz8lleo2Do8gsjS71zPcr9pfghLw5OJ+hI0KSil+++qW1vJvEN2Dln8T/yTQRjDv9pCJJ2vLZAGUAInkdb+dVwe4mT83Mv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154127; c=relaxed/simple;
	bh=tGz0CFUpVz2XMmR3DZodz9LNNboiS2c4O6AY0YJbFVM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oLDhCTUgWcPaSGP8d3ifpOAc0UMQYEzBrkL4eE0YWEGJTRC1EIsDYR1XMpQMZbmL4oaz6F47UyvIn/hk9FQoH7YpfPGlGAtOK0LlocLSOi7wPhsaYLbjsqT6YvHJGk9qHvXGyjx/gzSMK4SVGnrKFZdq2YlPa76Zjb745+BzXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81fc0896188so525397339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724154125; x=1724758925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP+rrcaUj2pjmXYdxoX0IqYzciBafa45rW89d9lEwvs=;
        b=SEHC0nPVVge4aCCImm8SyANR8EYG4zW2yoz15DBmb7KgiVIhGGjpb+SubhL+GaDLDm
         r/9N5eSJKKrVumWMHKKkAK1yEN7q1xA7O8nZ1M1uTYT8JZdlCWQR4DgOOLinfMOxAEoT
         uFAmCr3DJz7oeg0NtFRLxRvLVrF0LoRCjc1EOo1njLCxKEkcnLyPfVepnkU/RFkC/yxQ
         vaJefO9GLRW/FlY8v3T6NyMJmfbbl4ud3DHw/PIEO86WH6j4d2bjiZ43GrjUoWNlayeK
         gvq97aDCfC8/1hOD9mU2n3BVVeyH0zJ/6fL9a2dKHYKioNaMJx9qhTvSkdVEknLqy1+v
         HL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzgDj0MYaM1Vfzlcc3qIivxIT64sAV9sbZJZn0EqGKpbTHQDeESAK2eaPAPHchu0kETCrXqpXO81j6gAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KS1N6WacWDGCQIBvxK9MYqaWKK718ETs5K5b+kqpQYv1ORoE
	jMsVV59riiWo2BsKcuHdLaoObNlgu2Mie126SXZiKRwYVTZmwLPy17es6qGzWhbBTX4WKLS8A/f
	ic/3v0Hes+UjM37CbTvgi6iaBg/VoxVihbqTm/uWW/aXvFzLOuuf5vPk=
X-Google-Smtp-Source: AGHT+IE79W/VMO1o2pdJVO+5dY6B30MzvtsxKxCPjHgfdpr0CDC05Rd9epPtPmgOvCbyHLkW8Ob/kzgilgljgruFNhuo5R47/S4W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410e:b0:4c0:9a05:44c4 with SMTP id
 8926c6da1cb9f-4cce13e9a9fmr610344173.0.1724154124900; Tue, 20 Aug 2024
 04:42:04 -0700 (PDT)
Date: Tue, 20 Aug 2024 04:42:04 -0700
In-Reply-To: <tencent_152025FEBA06BB5533C69ED71B124BA11B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002732eb06201beaf7@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
From: syzbot <syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com>
To: eadavis@qq.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com
Tested-by: syzbot+5a64828fcc4c2ad9b04f@syzkaller.appspotmail.com

Tested on:

commit:         b0da6408 Merge tag 'printk-for-6.11-rc5' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15c8a7c5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=5a64828fcc4c2ad9b04f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e4dbd3980000

Note: testing is done by a robot and is best-effort only.


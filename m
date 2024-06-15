Return-Path: <linux-kernel+bounces-215681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E189095CE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 05:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A06282853
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84F4C2C6;
	Sat, 15 Jun 2024 03:06:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208104400
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718420765; cv=none; b=dMi3AdozpK/4Tynr/9LL/7n53B263a9v6CfGlttfEyWeuOYIgYQqGcFA02g1VnxCmxetWCH+5mfEe6YX7vzzOfraopZftfhi5HGQUABsExKifckg5d3EwQHwhK6d2c4ZRQu1sLUibqCEUnY6HXDuqXfOcyGGHEnxjjX/23lJoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718420765; c=relaxed/simple;
	bh=xVS5WCjnd+8td+V7CdrmihD1Cg7GgF3VsW+B/TqTg0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=figTitYmmMtrYs2dEhrsqVocsRFRedPGNRY1flKlPs6eCw8ZUETvBzM9QQkIDaexDi7RPARPBivALN4eVbGzZwRut85KhZ9yPc6N1LdEO+P5sHkSEfb/t9Zhy2mhzouUAfR6I2Zc19NjZYC5VTE0OSJ+VYOlaaWc6Ly0B2ZoIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37597adfab4so25002065ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718420763; x=1719025563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nd/kXNETteKn6H/yoXdWVP/RCM9yzNWB/d4YfIQxd/Y=;
        b=w/URTmAVL2XqxIKx/zRku62TTvgZCQkHzKxplwVeHyjQ/jctI2r8Nz1J49lTAtqSNn
         DND9+i/1CXRPOtgBJP4SQ44IPJOq9G3bwwVwCJRy1Ovhxw52qoMVlWle0ZVQUDRvFsjN
         bKSH4lVUxl74keINtQw/Qt1h4SxK4ay9+oOMRreZcPNASH+gSQS/M/wnv4LhQExMuJvm
         s8t6wsr7NOFZ6h26f4TezD1tONhrwzz8PVf2izSTVKSucke2nX5H4ji3owUAsEAQIYIk
         qoK0ea+ab5r/Sflt6MfF+9KrSxpnoqPiwQroL1WekMBXx+5U8rbqaGcaGSCXjs1ymKEj
         hFEQ==
X-Gm-Message-State: AOJu0YxEl61k8Brm4pnkH1vZPtgI9pbgIadJFf04ekYgbFHrCE99GuoB
	+wbh1NYV+319Kj2Ug961bHNX2bJWRsQUocn20MZc8+s3W66WbVcBfHs1VPWLp/OO/nQIYu4quT9
	p6aFI3+au4sU2pO+U+a/D/9+hyRazM31OUSoSDjndTVtjp+VviGbyiUE=
X-Google-Smtp-Source: AGHT+IHnk9GPeezxgXw+ZaC0rMzHsGwp/dKN7Gk1MfC+FnfE8HdtDksW8z/Kp3+9gnB+ypOlGWy3Q00ja7FpGrwqjqTXRvlTgCgC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:375:a56d:7719 with SMTP id
 e9e14a558f8ab-375e0e03811mr2457495ab.1.1718420763345; Fri, 14 Jun 2024
 20:06:03 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:06:03 -0700
In-Reply-To: <PN2PR01MB4891074E7F291A7643F61A84FCC22@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c90e4061ae503fc@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com

Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=1345c141980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ad6a8768920dd4b
dashboard link: https://syzkaller.appspot.com/bug?extid=1971e47e5210c718db3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126193e2980000

Note: testing is done by a robot and is best-effort only.


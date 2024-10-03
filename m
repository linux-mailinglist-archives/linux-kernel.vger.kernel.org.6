Return-Path: <linux-kernel+bounces-349426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FD198F5D4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3E41C2146D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD61AAE3F;
	Thu,  3 Oct 2024 18:09:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414C1AAE2B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978945; cv=none; b=coB0BeW52k2J7PMzkMBAuMTcHTd4HSUNLjYti/ICjraO1xwdF/MAHyhQPij4LelQY1eIepdG5JVCXXVgMWiTVS23Un7YzfeZvMakIanIjQCgoVCjyr1/VsFRnjJhcRiO+SEOimboWOSnNPMaERej5gjh6r1FYI7o8RNMmIYeCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978945; c=relaxed/simple;
	bh=urBkFxlXnq1Z08ilkoKAUfigKudoEKrfTvGxDhJiMg4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q8DQAcx2tByuL8alUoVPUFky+NLH1uD+Gp+tNku/FTA6cO4YcAjz9Ob+7r5vom/W4wEfLi5CyzXkZ4Nl5Eqm02ul4peXoiBRAC9dg/jjqHkbGw3ZvJjcWPoe2Blsk1Vga66VGUrNZJXQ422VNfPirvuctVM3iP/+Mkj/Fqk4Ako=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a36a8fa836so10543685ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727978942; x=1728583742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=km+N1AnjVrlxg5/sqw7D6CQ33vpycH3YU1CzawvWyKY=;
        b=M2RZV3T48WkVjjNDvAHJ5L8G/SuUJ4E6lALis9lxW6QJ/QRwEQlSllyFJkJzR9LmwJ
         1NKm/fVlwF4PLv2GxV5/9iF5HQtgAp3CkPXJvyM5+9/cq02WTQDRZZznZ6ik0g//Q5P6
         yqhReNyK0vP5nDOAD/FDLPVAaznWZMbE7BJ2HCXxhrwB7XkFSuQ6hCUI0TQyZ26xMTM2
         GQj4Umv3dbLajAu4cILPYw+GG1af9ytGeF49g49VfwB8QTuo1rjl7uAU+eggrtjLJ9E7
         JAYtNkPV4qgMc5zPhZrJqLpEel8rZZtumEQLDSs2wL4iKaO46cBNyRtY/P0TZw9rEmtq
         saqA==
X-Forwarded-Encrypted: i=1; AJvYcCVziPsK6qpZqwAH4wT5TKZnTPhLK7LGt/DfymqgPLAOjJqWgFkRcYD3/gQx9VH6AiiCzsO8AzRON4FTPqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLrVvU66ySxg70HxpoG1Vfj4iGb4a8swnGis68maEDFn+3AGm
	5o2PV9+o9gYcDmSYfeITuwpsel9SYhmKnjZIOtnJHprGGMVHWbIUaHDdxZntsnGhFfbSyin1SaG
	i+RE+Q2PUUqkAGxLksO3MxFS1t36lWc28KLk0K2xnAeYDAQL3kb5b664=
X-Google-Smtp-Source: AGHT+IGZjMI+iBKB50tZNPYiYW14XvOsMp9BsvK4g369kG8eEMyKHM5SI488Cy8a7s6LQUbb1LvG87VDeSiW9NH9a5EyTJl59/UT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1541:b0:3a0:aac2:a0a4 with SMTP id
 e9e14a558f8ab-3a37599f0c3mr810265ab.9.1727978942186; Thu, 03 Oct 2024
 11:09:02 -0700 (PDT)
Date: Thu, 03 Oct 2024 11:09:02 -0700
In-Reply-To: <20241003173925.127880-1-dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66feddbe.050a0220.9ec68.0054.GAE@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in sk_skb_reason_drop
From: syzbot <syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Tested-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com

Tested on:

commit:         7ec46210 Merge tag 'pull-work.unaligned' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12ff5527980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ee84829c35501a2
dashboard link: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e66307980000

Note: testing is done by a robot and is best-effort only.


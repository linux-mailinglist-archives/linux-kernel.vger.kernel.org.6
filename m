Return-Path: <linux-kernel+bounces-411959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C059D01BE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E151F22AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3B58F7D;
	Sun, 17 Nov 2024 00:37:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C861392
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803828; cv=none; b=UqnNdt+QJi0kZHUn94GRauOQcFVWO50TW+hi2fHArS7ZOaphin3dFoN6d0DTEpiuGwC87aIBiTwbYM7gWSJswJLQcb8W9B+UrpeZE+zKCY7xHcMJwbiwbc6D0MPziaAmVf/M8NQCVUFhW1BBDRaZSMuaZtpwMsvCcwWOXr32/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803828; c=relaxed/simple;
	bh=90KsV0rRIXVLcshJQW4l6mMhXt38alpIMTuGs8odQeU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E9rgSxfdRkUUvutuMpDTXJeR2Jy7ZRiNAmXgS7W8hSCFD5jXnzM3lJOriN2skml0nBC4/gEWaNbG5s8ttbz2ET2txCjz/N0KX+8Eru/XAS44lBvwiVYKI0d5r1crCFbDnh3ErntSwzUJd1Io/rK9W8Fy6+Jpvag4AJQtdIUN4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so36253735ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 16:37:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731803826; x=1732408626;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91k3LD0111RhfjoOAEnJA18VfRp5RkcFq3tbVNWtrD0=;
        b=dgU19ojSDapAUxs3gdN5CTZ1vzkYjVJXWoi/DbJx7a6tDjUmFG9QvovzaSmIkxeZ3n
         VCAfHf1dTwZtnKg/2fFZdQMUW3tUWN/x26qD1fn7msljoW9146E1BxRyNDjjSkatZXt6
         BKoOhyKT6gzJPeGa1sInLLzpejJYaA9IEG1byvofBSuVuJxHJaXJbstdT7mtELbEuTCQ
         fGWl90dnVM7m8gFu7D1v+HEQn0RhZBss0DjUzVmT2MKrVOefN6Tu8j4p9untk+rV7Bgy
         2NGVCY97tcjVfnkHfbfBGsGnPreTQhipmz91olpYjBLR/xHH0pm7bQz2H5vY0+OQ89VI
         3TJw==
X-Forwarded-Encrypted: i=1; AJvYcCVAwYhwm4a0vg+A50j8lF2LJsJ5qHIvcH2P383rf7/k1BdwaF5al96TFxC6omO8eORODXO2Fqv/i81p5pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyztHDLub5/WBEQbu19qLbrkRf2f2RqMMMT7GLAsSA3fLzg8GKQ
	+RTKOiSLHFK3UaQRe225TOb3hyjMt3IKGCQAOJGIzacbO7So1uYlbKarL6hK1fTLBQ0tghLm96Q
	5GEx6YqByuvUfwFnOhMkmTso6XcsYgS3MP9juQeGHNcEwC79jGkDe4So=
X-Google-Smtp-Source: AGHT+IEemr6dN5obvd1896FAG7oaFtXNvNRgn0vfoZsuT5I9xRE0GVaDtL2+aY9m7ZqSbAauhFP3DzD1V7dP2dpvMussgeuURZcy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b45:b0:3a7:45b4:47d8 with SMTP id
 e9e14a558f8ab-3a7480218b2mr74825475ab.9.1731803826185; Sat, 16 Nov 2024
 16:37:06 -0800 (PST)
Date: Sat, 16 Nov 2024 16:37:06 -0800
In-Reply-To: <20241117001814.1342-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67393ab2.050a0220.e8d8d.016e.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (4)
From: syzbot <syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Tested-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com

Tested on:

commit:         4a5df379 Merge tag 'mm-hotfixes-stable-2024-11-16-15-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17dc52e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fca5d6b7cd3e6f
dashboard link: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16cc52e8580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-260522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF1693AA84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DD15B20AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E436FC2;
	Wed, 24 Jul 2024 01:18:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82428C138
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783885; cv=none; b=J9Ks0GVZ7j8z8g9jifdw8MmBBff36VJk8risQtMFnokjvRjlTYzJQgPvOHkPK4AzoKYkuA5fzgoGrV3F6ZKZqKNO4krbi9UxO0cJkh+kLw4WAhH53XfD9JaWiZHNASgdFi6uztMyQirELs5+7NY+G2msqNF33+HjfVdhUBqyjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783885; c=relaxed/simple;
	bh=Cx1P/71uIE9TaLD65WsH5COR2TmUW4DSRP+yaNTMl74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pxbkQ/8OvNXMK+EDPFkcOTv+PrQQZ6Kh2YREb+jjZ+n4uPc+FCZ/ZTU16pmplLuMouUv31PNQsYuh3J0uNKAf8/Svxy5mCbYGtTGxZgKNr0fOQJBgS9ctE3ZaF0h9gGwBGDvHcLb+zyETTGcbdcE4rjyGeVifq/0R7Dhwen05mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a17513a7eso8258765ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721783883; x=1722388683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUEy7Gh79UQSaEZWpYo5xpudphwIEFY4AyauSkqQ0cI=;
        b=ERCfwLptD1ky73+5cs/QC+A/2PP/EnYnRn2v+EstLXxV89NLjoVrChNkLwDuFAW2nW
         kpcRxHo199TpgwVxozwo8jOA9wLI8ilu5l4ePn6s9j4i83wZ2GdxtQpjOffHVk1fM2Gl
         pUz8p1Y3A6SapH/Med9pmwO9Dftkjz6b8LdkBClXM7kp42+VUyuAR3otXeCI5sq1lvbX
         X97W94k9dBWiX4bQtsPxVQzaJWiqRulmWFxOvsV9s1nkevYU/8vQ/kt9Co/f3rWNL5vd
         cOfVOORYWTDepFC6pOQ1rz9Bq1pkS7kWDPaoV9BerkXmip8dy9m2F7NPY2W5w0ueeNVG
         y77A==
X-Gm-Message-State: AOJu0Yx7b6VBRGSEIhHh3zVRycO0S+n3E/y3DVAdhtZYYxuk1Ivrm18/
	Z8Zd4Yt8bWKEya4wTOxe5MoyG2v6YdiOz4YkrDLxYhpBzUz5lZdgVqZF3O3Amy7ci9bLqcNCfee
	QMBNrw2MlrGQ/65W5J8Ru30SIqjpr4pHfBXdGLzhGVGWkgtdam05+2pE=
X-Google-Smtp-Source: AGHT+IFTgAXI6mwPdTFgeKVAcqwYnr6Rn/v3eb+tv1nmY+MHgJMuLp9aUK+5WeYiJMC5uPJda7Is0ry3WBSH3gBbDX45MOeqz0PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2195:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-39a194c4737mr635645ab.3.1721783883576; Tue, 23 Jul 2024
 18:18:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 18:18:03 -0700
In-Reply-To: <e2e6488596dd837eb65ed14adefe361e8fa413fc.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2cb01061df40c8c@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_delete_cat
From: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, simeddon@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Tested-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com

Tested on:

commit:         5ad7ff87 Merge tag 'f2fs-for-6.11-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ab68a1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d25e3de7a86b5ce
dashboard link: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16868eb1980000

Note: testing is done by a robot and is best-effort only.


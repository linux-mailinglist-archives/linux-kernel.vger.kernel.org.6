Return-Path: <linux-kernel+bounces-362702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C6699B83E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 06:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B0C1C20CA1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3A433B0;
	Sun, 13 Oct 2024 04:49:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468063D6A
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 04:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728794944; cv=none; b=iaJyGeTTYTmgvdRBxbFPV3sdwVv1n0Clxu34F/qNgIHChviorF3D9M3HyCfgPoX/SqfUCFkafDRUh165jvHDV2GhKZMMjzjnsC+jT/c2S/oSfOTrti3qK6GEfWjkMrYxaioEy1MZq2JdqBJozqMB9QEGoWWq1NZSUj6VjKbnm6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728794944; c=relaxed/simple;
	bh=GcegNvK08WPc0IbdNLVoUTDQYPD3a5To+9faUyNvjeg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NBFCvtxDqi8Ko+T44KBpnk2V7md+QnWWZv7g1Q7v211ozbDvhYcEZ+MrzNWlpIdMyrdSZ+9WmZOpzLe/rIZPlQlc+8B9GRjJFTX6XuPS/NS1kDGc7bg5TgKkz8zK98akZNmMdXP8jiyTVxcbUnGXqT7eGDqEjKJtjLuJoC4nPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8377e901e67so349300039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 21:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728794942; x=1729399742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ljVEo86yJP/c4o4FA//3yfRYuSBIbWPd1BmvVY9tXU=;
        b=OL6WqQMHs1Mfcc9pSvkeRyHBMo7iu/RnFMBVsP6lUEzwWGUUNW3qXvxKWGEpnJiPJy
         TdJhLyM1yHtItDLBmZiEYLmFI7JOoAjlsRA5A3ty/PpLSJ5DpSvZB86Y6U5alFeJi41+
         H4xO899B7KxPMKJBE9x0JTLPE8hjSBIdhmUfOMwg2cKpEukE5Zr8Wb6Yx7o0vNxzzRqK
         QWKHeMycm4W6QDNsRPLEGcuUS3NwPE8znc6I6KIV9TkmqXmscJB6TkvNkcBLKhXIzqqj
         ZZJY+HoCEgBFeXtUN3pzSbyi/meKrsx9rKABTMABJrq7KDojIaPHcQ7tOeuJYBlOJ4TJ
         rAkg==
X-Forwarded-Encrypted: i=1; AJvYcCXzPccNn6IBcQg4AB/Dnn9IAqZN0PWk3ZQwuqqs7vab51A9aV1WU9uPs8EvWo+seQPUtpSD4+HiJogXNwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTdlEkNzyrP4WEtEISwNEqzdc0oXrCNpF1a3pWVuFRdX+zVc3
	2J/J1ZFpQbkzuEPDTM3ymeSmsbMOeZvGDMuOQiHDfuO3AYKAL5FOzOa5na8UhP4ttfh2Hexx/tP
	8jehAv7Oefb6fWJlSeyhT7TbRya2Mo7bP8XotcrVWw953QrMbhbDgjYs=
X-Google-Smtp-Source: AGHT+IFv0UdvNsYdyrNjpzTJDtM0TSFV6oUxVg9831YnAFaEylTartxyF072bX14/YOmWNXqYHJjOSxHRR/dorkuIAvekwfQmsHe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a3:b1c4:8197 with SMTP id
 e9e14a558f8ab-3a3b6053e14mr54866705ab.23.1728794942256; Sat, 12 Oct 2024
 21:49:02 -0700 (PDT)
Date: Sat, 12 Oct 2024 21:49:02 -0700
In-Reply-To: <Zws-so-6TnY_FUFH@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670b513e.050a0220.3e960.0033.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: use-after-free Read in jfs_lazycommit
From: syzbot <syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	qianqiang.liu@163.com, shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com
Tested-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com

Tested on:

commit:         36c25451 Merge tag 'powerpc-6.12-4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d1bfd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=885a4f3281b8d99c48d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10951087980000

Note: testing is done by a robot and is best-effort only.


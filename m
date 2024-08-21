Return-Path: <linux-kernel+bounces-295310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28B959990
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF892812AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E31C4EF0;
	Wed, 21 Aug 2024 10:07:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490A620B326
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234826; cv=none; b=YTlvwT7ILNLtCdmg1TZsoToUzpQMfUEF4zr/t8RvFsBcwrO6o/8gQRpOzaoCoqvtOx3KlTtznX0tVL87DeidmZT43683n0sLG7AOBnnOlAC0CvZpL3jhBzapkDNfXU4O/l6Nv17sbvmOfAPhN6M1qGVEST3ULpbBFapCQEZGaCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234826; c=relaxed/simple;
	bh=WVD+a5t4JKnRd0bd2ZHtirYT5BsuFkW8yH4Nfegncwg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vCvp2YvC6dbmYTWbHSo7j0ZUAwEGJxlvsdTxophwyHe2WNQTr9bcHdd3IQLYAN6fp/OdZV2EdKyQ2aQhIxeqxfdN2hesMGp9nHisd3nm8eDZ4gAvfqt791Kj6yzl3DylOPggTMLSP0pG/hgEs9cTz1eYXq9RU7i80T9Gd+S9D2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so36108035ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724234824; x=1724839624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZ6TWlDbtMhTAjbnhH670EKsjBLH8OsCUfg8Uw0BwxI=;
        b=p5pey1h3QT9blAJ9erpDyoPOCcOmYaw7cHdwS9DoN4P6hx/DnBSQYCI11VC4GeeoGS
         bEOkB2uf7EKDprOoQGfmsxhr9SlbjDAYQVXgcSmMrhiztvNM6J5hV0F5uQUwJTO66dsb
         16EAtUWndvHyRRYUEkJG7EE1FKpIULgelW39pBJ0wkDpDmpT/wKZ9yZ5wehTFrWmlBEz
         NQzUbqUFRs+Nxc4zhaBA0lhZUH66hQbStzXq2vK2FY3zSMVY0EOuhy6O/AjqluMpQhHc
         fs7d3pPC8kqIpsgvPOCuISpjmdU9gs+q5Wzc4htgS1pD68/FJ9sffBI8qORs5YuYrcZE
         cjTg==
X-Forwarded-Encrypted: i=1; AJvYcCW+N+1Yz02T8vdsbl64SlJPpwsW2la/FD9TyyNBhxsNGUBaYkNVkKH6YEYssGYgx5sab8DZfgUZwYNGpYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu95KFFAaoIzWNKNeineK1gjgZPnVVEShD/n2GxSIYMhLQG/ga
	tOrltWymhVvxZltCttaugYmlg23PQ2bt9qfgO/g5Qe3SLEWBtOqXsA+m0lB+uQmpgLYbflpJm4E
	2Af4L3U+FwMeYQtNsleXpZ4jVYbvk8toWahFHa+J+LV2xrvT/BN/I60g=
X-Google-Smtp-Source: AGHT+IELMAzFxyRYHJ8oL+wi+H/ddHKO+SeHrKQMpVy4z+spNap8RXM8maC/UN4CNL38h16vv+0UzLZZLVR+7hURhE2iqvCCndZw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:39a:eb81:ffa8 with SMTP id
 e9e14a558f8ab-39d6c5d63c8mr1699405ab.6.1724234824491; Wed, 21 Aug 2024
 03:07:04 -0700 (PDT)
Date: Wed, 21 Aug 2024 03:07:04 -0700
In-Reply-To: <tencent_51A2970236A44ACA743376A9662E3C833609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039389806202eb46a@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_setattr
From: syzbot <syzbot+d78497256d53041ee229@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d78497256d53041ee229@syzkaller.appspotmail.com
Tested-by: syzbot+d78497256d53041ee229@syzkaller.appspotmail.com

Tested on:

commit:         521b1e7f Merge tag 'cxl-fixes-6.11-rc5' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=143dc36b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=d78497256d53041ee229
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=103a87e5980000

Note: testing is done by a robot and is best-effort only.


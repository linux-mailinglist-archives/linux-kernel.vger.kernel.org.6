Return-Path: <linux-kernel+bounces-357194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29CE996D56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974E62842BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3703199FB0;
	Wed,  9 Oct 2024 14:11:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D38190059
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483066; cv=none; b=lWixX5CtJ1QCee4CH5VlPs8u7kV2mw57xm5GMwTXOsKCch5+XI6xfUdipR6VfkAgNFO1KhtZaLYVB8bzImOeOQIFUaIslytEDk9Xac9q5TWkiZkRiS+/KGxXglubGHz/Rre0qInUqu/JQ5BHg2dl/9agMVEeAtjCJQKInKvajBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483066; c=relaxed/simple;
	bh=E5VlqSK5Yy5eCZCXGBIXuXrYZYLY8dv4qDK2ZJ2suZQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eiFOJ0Qp+rdb5yeuyFDJXFX2tNYrYNmKM2zlWOUhUf7g1AQoc0dDtuXdsPJVT57Mp5l/TYQvKnsPEvqLrjPVI9QOw8PWvdVAW3wEms3LkSpsMpvGymBtsCSUyhG+D9fYGnzdZG0jT+8UbUdu8VRYx957Ul/g2S1O3RzvpoEKbjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a8b992d3so8033245ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728483063; x=1729087863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1nZyo7VbE3Qv+IxUbo0n80jVbJCFKyUqITSpcktzNc=;
        b=Sd4IrZEwVVePaHqmDoUEDjqBikRz6ZtGd0PHQGRI1KaWo5kW+DRDhnsFQlPpovz5ru
         fTcAMob/qFNd1h+r/n9wQx8wLuUJTafLntq8aGwHt8TTV77aIhomceOr5Ofn4pKjf19q
         t2qWGUtU8dFRCgb82ELZwk0W5JfzaY+8WFDZjNGglpjRAOl+vEMBHV0vamD3J90DWW7K
         qZTZWrnsAYRSDfJT2CxVVQy1HFLVMg0Dg5sHPO1itM8zpAwoGOtpmLyuKwdVxxPgIDMm
         Hyh2E8744UUnAWfs/vCGrVFF4KJQAHWN5PXXnGcRTI8xhErqIGb9NlcmMi8n7sLlvhuS
         KyYw==
X-Forwarded-Encrypted: i=1; AJvYcCWOX2xd1u7JgWHNScHGATNgBgQz5eEJijoF3zyZt3Cb/rZA+sH0r8EmGwDe6T/H8bBFSevtpoE9rmH4Jxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPb92Z1jWFigNzsOFHEbWeY76z/yHUqBXLaBTbBr9Hnh2jzI/
	a/CCre55Qw1xY0c8dtjECQ8nWRr2OqaDdPi7WNlykKTper3Zh6yge8wlstzbGQpWgKJ6ixERFho
	GGFJvpTtmv+2iRhEXMifCz8fNNrqvLKT6WqjE7Azku97uaryb73LmgMA=
X-Google-Smtp-Source: AGHT+IE+ZykMCQTpL/RnyU1NUHCey1wwJP5n5CXtJ6e0BjTYsGNs3GZkFjIzfNNIUVKOtByYxRSovKlh1PjeW6+LIOMnSdcE8dym
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:3a1:f6ac:621e with SMTP id
 e9e14a558f8ab-3a3974fe61dmr21633515ab.7.1728483063110; Wed, 09 Oct 2024
 07:11:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 07:11:03 -0700
In-Reply-To: <tencent_11642C456F589720E8CEEC46CD2879666E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67068ef7.050a0220.1139e6.0001.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_inline
From: syzbot <syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com
Tested-by: syzbot+81092778aac03460d6b7@syzkaller.appspotmail.com

Tested on:

commit:         75b607fa Merge tag 'sched_ext-for-6.12-rc2-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11060f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=81092778aac03460d6b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142c5780580000

Note: testing is done by a robot and is best-effort only.


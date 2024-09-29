Return-Path: <linux-kernel+bounces-342985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4AB989585
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD0AB21B43
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDB1791ED;
	Sun, 29 Sep 2024 12:53:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9B614F100
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727614385; cv=none; b=XGZsrOoWxYFFiI64zaHVjowOeONLpoxiFKQ8Jc9C9GIyFVJUvRpKlAMtv+bShZRmxUgteFM8AUWzOjDuOLPXT9cnnW9wWjN0U7DA8JLZIXGY+nInqrN2lVZ7/BbW2UAJKDg5uOWBfgJJLAQND/sz6drnnB6WNVsOJD/3kc3u8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727614385; c=relaxed/simple;
	bh=pZFS2WlX3TQsRnRE7MgXAWhVFJWP9+AbPR7JNH3ONSc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Sg98tnRfbXY3zlbb+Whs731MAR2xodeyu8nu0oJWrwPVvz4WfoqTQ8SPRhfzrHYxoY3e1UKzKOie2Bq89VfIS4XcsTh5Sp5ygwiYlMuj8qv9sYLlQN2R/OUxsSD/ns4LXf5zrIlrPBxjeiLrIKBW0eW7ZjiAlQaUPRR71THh5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82b930cd6b2so491346539f.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 05:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727614383; x=1728219183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yg4cabrsjfZ4/xtQzX+9Qv+fchyVzeYGa5QY4s5PviA=;
        b=lZRAp9KV5+GJzcggCGtcHf4NGBHGAayECqCQmV/3USUiTcPTroKlvGOKPv/CHSBDly
         sDv6bhNcE0IuH1iKb14Yjn0BlzcEL6cGK9Y4wKMewho6rCupeu4kwoytaXMZ9YydswBF
         yZmYZvMpCHhXFfoGWWqLHu3Ga0Ci3XGuZ3HyP3hkycZl8XpBYvdVctQL3va7DExzyySc
         B/ZnDr3C8wj+Of+/7Jb6dAFn/Jd/kwgZiihT+tEx/Cgxul/mToN8I5UzkzxrU6bJ8795
         HBWtJP7CGUpM2AsK2rGgxfeCKUtOFYeRcXsBJ+iEtibSv6wVm9ERm6PDAOQkoPXD9fe0
         n30A==
X-Gm-Message-State: AOJu0YyrQm8nk9vlfzrWISKOrxhwkShghEdHY5LE4sR3BgQXOGgJZ6T5
	er8pTwl6wy5nFdTyrrp2CyvetYcT33rWPZSUO4PML0+LBMr50CPSaTxQkzZdRPlFieEXE+9RHNU
	FDfKxbCt6afJBsySKURUfALBBk11NxZGx46hNiqeV/EAvvTRL/kdldMI=
X-Google-Smtp-Source: AGHT+IGTUc4dRkQsL2iGuSvOofI9E8FM617uu96o3E45TmMDTk8rdyoy1zXU2/mtH5DaAmXSmIga4yh++bcKZIv/BFP3msOxd20/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:3a0:bd91:3842 with SMTP id
 e9e14a558f8ab-3a3452b8bc8mr64419365ab.24.1727614383488; Sun, 29 Sep 2024
 05:53:03 -0700 (PDT)
Date: Sun, 29 Sep 2024 05:53:03 -0700
In-Reply-To: <xpml2-IAWMWixV5X5cC9OKV2DxavafGOxt8q-Eb4WHzCouS859S5es04-mWaB3XnS4EP1QA3p4h3bITh3KKaTJELJsUyN8uKYhaCcPoVdyk=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f94daf.050a0220.6bad9.0012.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_pos_to_text
From: syzbot <syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: Bad rss-counter state

bcachefs (loop0): flushing journal and stopping allocators complete, journal seq 8
bcachefs (loop0): unshutdown complete, journal seq 9
bcachefs (loop0): done going read-only, filesystem not clean
bcachefs (loop0): shutdown complete
BUG: Bad rss-counter state mm:ffff888011da8980 type:MM_SWAPENTS val:11
bcachefs (loop0): shutting down
bcachefs (loop0): going read-only
bcachefs (loop0): finished waiting for writes to stop
bcachefs (loop0): flushing journal and stopping allocators, journal seq 8
bcachefs (loop0): flushing journal and stopping allocators complete, journal seq 8
bcachefs (loop0): unshutdown complete, journal seq 9
bcachefs (loop0): done going read-only, filesystem not clean
bcachefs (loop0): shutdown complete
bcachefs (loop0): shutting down
bcachefs (loop0): going read-only
bcachefs (loop0): finished waiting for writes to stop
bcachefs (loop0): flushing journal and stopping allocators, journal seq 8
bcachefs (loop0): flushing journal and stopping allocators complete, journal seq 8
bcachefs (loop0): unshutdown complete, journal seq 9
bcachefs (loop0): done going read-only, filesystem not clean
bcachefs (loop0): shutdown complete
bcachefs (loop0): shutting down
bcachefs (loop0): going read-only
bcachefs (loop0): finished waiting for writes to stop
bcachefs (loop0): flushing journal and stopping allocators, journal seq 8
bcachefs (loop0): flushing journal and stopping allocators complete, journal seq 8
bcachefs (loop0): unshutdown complete, journal seq 9
bcachefs (loop0): done going read-only, filesystem not clean
bcachefs (loop0): shutdown complete
bcachefs (loop0): shutting down
bcachefs (loop0): going read-only
bcachefs (loop0): finished waiting for writes to stop
bcachefs (loop0): flushing journal and stopping allocators, journal seq 8
bcachefs (loop0): flushing journal and stopping allocators complete, journal seq 8
bcachefs (loop0): unshutdown complete, journal seq 9
bcachefs (loop0): done going read-only, filesystem not clean
bcachefs (loop0): shutdown complete
bcachefs (loop0): shutting down
bcachefs (loop0): going read-only
bcachefs (loop0): finished waiting for writes to stop
bcachefs (loop0): flushing journal and stopping allocators, journal seq 8
bcachefs (loop0): flushing journal and stopping allocators complete, journal seq 8
bcachefs (loop0): unshutdown complete, journal seq 9
bcachefs (loop0): done going read-only, filesystem not clean
bcachefs (loop0): shutdown complete


Tested on:

commit:         3efc5736 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11360ea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=cf7b2215b5d70600ec00
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a03e80580000



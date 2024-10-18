Return-Path: <linux-kernel+bounces-371929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B33B9A423F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EB61C208DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E586202637;
	Fri, 18 Oct 2024 15:23:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE920262E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264985; cv=none; b=keaf7/v+J9g53ugugqtD+yQUR/Pt1/jtrrd7IjdF7yhyGRJd1MJ0z7mSw3cDoTIy0CCQn1K+tXXUupusGIfno2l0aBOR9GX5iD4EHGJJnzIkCtdNK3KAsYcj6Zl7Da8Eo1lml7sZIUkH4xlKmBy/GPkqNy4lDeVtzSczdRGj4FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264985; c=relaxed/simple;
	bh=S2b8raoKO2jpMm+bStWmIYHe9iT0SxSMwT/23htQqKU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tyqfwcJrXqTv6mr0Gvnd7A4RMrdlcwYhktHEnPE0qxSXHfyG6uZLkZoUwppYDIGdQlE/R0ke7w6nfigI8jqkkZl4jtOPVhkE9qZFVtPP3uDwLXBdr9no/ZAZ7dlxmdQExSNMC08vcCgN8TbJZm9XCmb56dBYi4xvol69Vk4CBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so23223215ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729264983; x=1729869783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMasKnrStJmhL2WrAjeBgpPgH9uRvlMVH0mRvvyx83E=;
        b=iC9GabVHBA1C7tmxnOK1uQg6GN9yomFGxKgDaTOEeghN7VwVpPtXErhx+EG4BeYq/N
         OI6XESgRJ+/K047BkoLcRGHbsoJLtlu7Es+5S98adWfq3WefQLHUPsJE4r7MkwDI7pyC
         1rhju/TL5W7yDEkEGJ6Wt6GFHyha6jYhzC+i9ZOW1LWN2YaQFgkgfLuQfcDn7tpzVBYG
         jwCh7pbYG0chCKRyBQ5MKZ3ukEybM51feJRKrIG5Rh9M3R5XEId+ZBYwqi0jFzIXIAWc
         7sZD174Qe9krER7KhoOxUb/ZNG0DgIOgL5yVqy+LCObor08svGO74MNPAEDlkIm92BeM
         X/ug==
X-Forwarded-Encrypted: i=1; AJvYcCWoKBiq5w7eredbP7PoBLczv0MF+yozAqbuiyBHgwtasXPcJ2EJLoEdZa3TXOfXqVysT+OFscMQ+6WT9eA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8uRVN+7C1OWTeEglvzWpk5LjLi31MU3t3rl3UY94WLeZDWWx
	KWavxgvMwhkgCUcQrNpIlJjqp4Dyg3DL7ktN6GrytEwbwii4Frz5WEUwuiaXUeP2GUR8LisSxb2
	LiDxbY9PcyBglg15WzE0oEiEMIu5PPzUh3UaEYKjQvhA7fUGXj08O9Hc=
X-Google-Smtp-Source: AGHT+IFaa43STGFMHe0/hOCzeExl2B3M5A5tpOKNGOU/pV3YF8Pp+q0cS6YasT/jYWn8gro3UAO0r1Ann3dOBmvYjNAqMsS6YWOP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144a:b0:3a3:3e17:993f with SMTP id
 e9e14a558f8ab-3a3f405d064mr29660255ab.8.1729264982842; Fri, 18 Oct 2024
 08:23:02 -0700 (PDT)
Date: Fri, 18 Oct 2024 08:23:02 -0700
In-Reply-To: <46d8cfe7db6f381c99455159bff1c2220dff4aed.camel@huaweicloud.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67127d56.050a0220.10f4f4.0016.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] possible deadlock in
 process_measurement (4)
From: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	ebpqwerty472123@gmail.com, eric.snowberg@oracle.com, hughd@google.com, 
	jmorris@namei.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Tested-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com

Tested on:

commit:         31063ab7 mm: Split locks in remap_file_pages()
git tree:       https://github.com/robertosassu/linux.git remap-file-pages-locking-v1
console output: https://syzkaller.appspot.com/x/log.txt?x=15502240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b6f5c91e13aedf5
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


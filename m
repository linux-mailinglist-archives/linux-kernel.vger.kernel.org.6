Return-Path: <linux-kernel+bounces-324118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFB974817
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7917B1C24D39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A709A29CE6;
	Wed, 11 Sep 2024 02:12:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58723E479
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020724; cv=none; b=lcgsCzcrlBcY70w36N/RHE8AF4cq5BtHd9KbxAh9jAFehflgvCMDiDJZTO/eXM5MwUTQKK8N3cXVYD9EpcaWEV7p5QpBdj6Wa4V6v2puJWuITT5lZXi9ozxvUP7vc7t1iJ/9Wlj+g4U3wp+DRyN7E4957fIv3E23q+9wkbnpgwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020724; c=relaxed/simple;
	bh=Uik71iTs+REqXna/yMneBWwOGbOEHEX7ilNKdV6o1O4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nw8CVi+XihYis91LP9gL6bmSNNPrUBOA+V/CPZJvfSis26u8aw6aHjNtQFKaGCy7zL+q+Os2Hq4Z5SycRQ2KDWLol63mmkaX9Gm6fbJpeHJbVvAp4gZt8cTKQ6W1S5uY7slhE0jbpFAhinS4H3WBZnYkplGX9+wsZDONSzStFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a678fbd0dso197103039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726020722; x=1726625522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAb6PrucaF3wYrRP+7jKeLaHRcrUdHKeMrEXsjelCv4=;
        b=FbbBviysd2nWXK9RSiqSnzcUHjY5gS+C4lpvL+dgli+Ph6tRZpIRX03ighhyROofNQ
         79WQnkNxZhAkQ4g6QgknW4Gw0rY9GTM1TcncfxyCtLv9f6bcRf0eNVxOP4XhW24fYBdU
         KqC0olFCRUML88c9xwdFG7721r54gFgDt/d+FyQcQP0XzD5JpoCWKWiFGBq2B8O+vnRU
         MFJqJuUYjpWMh6L9x2lt50kHwMSHgHGKpDj7eijLtgT1+AVqfCb6QTI3RNcyN+WxWDsw
         TXWp7pqzvBmDIVXLwauF97qiiWGpOJmLVq9mmvg3h0hmPsrwzbDTDlmlOZoBTZp+Z0s8
         bBqg==
X-Forwarded-Encrypted: i=1; AJvYcCXijXwOPhUhqZIJue1CSEzLGcGM4rgVGACa/0byxePIJZUFmMVFOqU45lgs4x0X6jluCTvyFZUw5NUFUlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm17VwRjrOxkN8ijUOvrQqpDvwAy8PUBOQ2Me0KDSHpijH8G+C
	kmBn7C+MCvWtuTvJG+uGO1qGkYgGt7HgTOcphCwgPE3iIJ8w9vLgO7y6lTFAi8k3Jn8BKbWOSOb
	e+CO8zDN4MLl1E/lEGAq3OEDkovniaC9lsiSF/NMITIGvh59e0TODhSs=
X-Google-Smtp-Source: AGHT+IG8OnDxIx8zhynaeNrH9ZWBpxv85d4tUS50j5wGR/JJmwJu4dQH1js3aFIsJEZk1GEdjvAevNdyH7TIe6YwroIGKCIDGD5Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:3a0:57b5:72e6 with SMTP id
 e9e14a558f8ab-3a057b57348mr49780205ab.7.1726020722026; Tue, 10 Sep 2024
 19:12:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 19:12:02 -0700
In-Reply-To: <2fba030d-bd24-4a3d-852e-e10a484feaaf@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002f8e20621ce84e3@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
From: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, jack@suse.cz, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
Tested-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com

Tested on:

commit:         f3815bfb f2fs: fix to tag STATX_DIOALIGN only if inode..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=1319e807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


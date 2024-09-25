Return-Path: <linux-kernel+bounces-339108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE1986161
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87081B2B379
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948117C232;
	Wed, 25 Sep 2024 12:53:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576C1865E6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268784; cv=none; b=OWwihC1tO1nobjQ0Qf4pdPUdslaOmIC1i9XGiwgY4jVqVcvGK9sAbdNxPqKVZCnnmymfRkWl327JuY+e7zvuLagAqkJ5jhWr9T58tvWHF+C604vHB+ctUJwMWy/Bhbdc2fknjxB0HisNvIoquJTRkgImWpErCAcRolClfTws5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268784; c=relaxed/simple;
	bh=Uvv1m1Qvn/2uoZztHZLxqYC/wLs1aV0Jv9MZBQNjKTk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SpoOshd/AWfDYpayIFEu1dsnC+RE0sdhKmMQCnfahYCu7yyKyThrnkLVlwyJCCCDrL1CGd8Xffb02+5kK8xqoz8dMJYurrA/etNyQ2DIwlH3jWO+ICxtXMV6oUW1BiSlCQo4qaBTw8F/Hg+GHCR4BjVkpT/d0ngvOXJokPLe6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f4e119c57so66271765ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268782; x=1727873582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6Dx+KXZsKZ0PaHE7VgMazItFW1s/sffvpPbBWE2Q9A=;
        b=fF1TxNyBJSy/bpKwgLejj+mXEHdzfOYuiWvvaPWiTO5eNzqnK5x9v+6AlwwBmFdZut
         W7GT++mUmC6H3uXqAh0y/CNrom9ME24J51qUM/An7/u12SJlmCPmv7i9R/hKihurTGqo
         K/2MylVfOqNvJ+OWhJXtGxYvyJzb0QmSvq0yPOBZX1PisGZz+Vh1Wf2+MGvcZ5M60hk/
         TWhozUKsrV7lf7VsPSnAJKPSvZbL9ArtXZbzj4JzP4t4epfc3mpkJoJP4M+TfTYfxGmo
         HclokAIjEClZMY1SVhSHrBJAuVj/sAael0ElKavkXOPRC1OlntMqQJPmCGu9j62dJDEt
         7aDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs4uRYyu5dvrbqlQtg+eXihHcIxd7w6IExMFvSYR4m9YGjXsTBvEgoypzg8QWbCfazSEYmAMDG8G5Z5eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFL24drlamrCMxcOVu3UKUuinXBenYNAHJzP9jpjmj2wh6ha3U
	g7TZz1G80g664WS5D+oPN806YHdhC+8mPodhryqpeYLfQ9/ll/+mQzU3Er7BIaD6NE1cNzFetlf
	TVtxYgPVm0+l/0qEKB/ynKa5eP8qrcK1bzgSwVrgRHm0mW+kYNsqvoIM=
X-Google-Smtp-Source: AGHT+IHvh+70In+NkKlH/xOu7+R9gos20QXbfQHrMia4uBtXH65t+ADYKrbl15Eajc8LRH2B20kvDw9Nd/P192Jzq3sX5PBs8v5w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2e:b0:3a0:9aff:5047 with SMTP id
 e9e14a558f8ab-3a26d7b0177mr22555025ab.22.1727268782662; Wed, 25 Sep 2024
 05:53:02 -0700 (PDT)
Date: Wed, 25 Sep 2024 05:53:02 -0700
In-Reply-To: <tencent_5C26C693770376096443A5A440F760776D05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f407ae.050a0220.211276.002c.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/bcachefs/btree_node_scan.c:289:13: error: use of undeclared identifier 't'
fs/bcachefs/btree_node_scan.c:290:18: error: use of undeclared identifier 't'


Tested on:

commit:         684a64bf Merge tag 'nfs-for-6.12-1' of git://git.linux..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a8d627980000



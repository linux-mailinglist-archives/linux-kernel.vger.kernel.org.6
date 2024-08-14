Return-Path: <linux-kernel+bounces-285716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89A9511AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15B51F24E41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6116182B9;
	Wed, 14 Aug 2024 01:52:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C9311717
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600325; cv=none; b=AlngEMfuiewirXVcE+5V16jZ4SAjg/5qma7Vtf7xiW33p33KQXn14JXt+bXao9wdPKfhNdnauyXJXyZTIB0j4pgeeiRWSGEQfXWf6zdvgaVl0KUnSAwAcYwG1FyXA0EOJXPhS+wdOoZrLnDj7IsCljDn3S6bDZmhZ/nVILXVKHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600325; c=relaxed/simple;
	bh=XS64JM0hwmruJ5LzbhBhtv42zVcLYE4v1woMxuH4eBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EgIVgDWJbdNPacTXJbMyEae8oBg/eDpTAyPMB8hg4W662UvdijEywHKHlwGyxmlifdC/ydShtnGGX9RAVCTg9oTUzMIM2WCIq4RwJk8N4A1vk0xzGbYh4ivX8XN3Y7f/R/ko0VI1xUMh/h6AC0fQm5VsoI9GCHzWJCCs4SlPZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3994393abd5so72464125ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600323; x=1724205123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr1FQrSlLyHIR7bKJ+Sj2PnGw3Onv4oXfRLT0nBQKHc=;
        b=KqYqCNipZ74n1I8n+dTjuTHWMVTvTutFIL++uzG7o+fRas5t8ViypUFFC2wp8Sh8Nr
         Lvzl1kmJ/qxScnctppiaTCpUcwuNHHXhL5fgzj36jKt2QDdGxB0ysguemxUAFH6Pv++5
         a30J2x0l86UrxAzeyyY0gicZook6jcHKCbuFa9gvWqdA5wgIi9wjcr0yFPykMU1bnh5z
         Z6gavz1aDVcR0Zv7GhoYXJggaMGrcaUUVg87rliwjO1lMCS13vtj9E7H8BYF0eG/Egp0
         /9SqKZD0r65E9bi5xdQ0eqWxIWSa9QmDJrgQrI4ecQC8SL1axujalu8Q3cvi1neqKYl3
         Wm3w==
X-Forwarded-Encrypted: i=1; AJvYcCXB2s4u4cvXLNzQXEr2c4qQm1Rnq+SiwKuyirXgQaOr/8zQcF4ix4IYCpFQz3OYfFnFSjYY13hkrgGnbSka8HY6vZIMjJzL4NdjUv+Q
X-Gm-Message-State: AOJu0Yy+pRtOz4pCTOeeQCFCIWKRhvuTxF0AYZ6jy2cU2b6O//f90jFs
	jg68EtK26JRRkxJRLkaLMFiWsHEWMbLlBfa2p2255fPypi50qBcJ8bDYxLOPmKrF6YZWH0PA2QO
	E1ORPoaiHHoFZnEU7JEETOsfyGM7yy+Bf56yznKqFEvRPJLmpnMv+3eQ=
X-Google-Smtp-Source: AGHT+IHqA7pQnyMrXho0mD+TUeP2QWjKbV97KrYXUIJ4iXmGLDZf88mj/5QXqkKGVrs9YdSyU79x/lDrUXmH2JEGZiTj/x3sLYfc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214e:b0:398:36c0:796e with SMTP id
 e9e14a558f8ab-39d124564a7mr1332345ab.1.1723600322958; Tue, 13 Aug 2024
 18:52:02 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:52:02 -0700
In-Reply-To: <tencent_0F27C706CC52D386584988EECBEEC0CCA206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc26b3061f9af819@google.com>
Subject: Re: [syzbot] [ext4?] divide error in ext4_mb_regular_allocator
From: syzbot <syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com

Tested on:

commit:         ee9a43b7 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12dedb5d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fd71ed980000

Note: testing is done by a robot and is best-effort only.


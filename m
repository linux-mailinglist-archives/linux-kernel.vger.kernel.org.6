Return-Path: <linux-kernel+bounces-242716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89510928C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0841C22214
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727116CD3D;
	Fri,  5 Jul 2024 16:10:14 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A93148FFB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195813; cv=none; b=h63MH01Z8MBCe1v43ZVMXwTs1bEvaJFRVNJ1To0uNmW+afytZr0bvl0AuXuos6svQqfmlXAicNEu3BxOC32YpRD/JzsPUytMNspq4t3pUxFeM3NP/ACt/kB25oLKiOWvXH6kJ4MX32YmHcKtkY4Be86yCld9m6Zjcy/NpTfFp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195813; c=relaxed/simple;
	bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ryXUodWS3I9AAOUijRDf4n7WHCq+7s35ZNL/h2wxMbjE0Io2IQyirUMmQmvMXjKAzfR6zrzXcm5RPLlpYLI3lpj5Trfh15GdGNfMlzclXaZJC1q+owp9m0D3L6DEG3nfn8G/JxZbg7DwW7n46ZYX5L1xd5cmQDHt/I6+OVHihnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3c9711ce9so203720339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720195811; x=1720800611;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
        b=ahc3J+73i9ulQbzRotWtV9+kz7+4HYXcOW1YT7b6dNxrcRWKAceHQmF5qreY46lU8n
         ZBVSVaTrNnzuuNTd6R3mF4u2vAS/gIWjFK4OnHNCSA6eUWhECQ4f63vQEwR+XxE/60Yk
         p856F/ZQQ2bi0mL3oIoW6tlNxtdU/e3d9srCIO1tM3ur7dVqzQJ1B274aIcuA/V8Jqjr
         eM/BwvAxN0yrkhxCZcvIR2GfYrhzwePWEc/7YVs7/MfYw6YrkR3cE0/aDukV2Tit/+OT
         G4ypVulzMZH+/h22Jm3kPY96200gGbGn3D5SZVEqZjRjBV+GOdRanAWaKUigQ2MBpuEL
         3lbA==
X-Forwarded-Encrypted: i=1; AJvYcCWpLoCQa8yHY7jTK5feuM25J1BMBOqgCaNAnP79dbYAt81zsoKnInilFLpFzqKBWtj78bZQhzmyrGmRNAm3LmIvgatkObMzAV5X6Z/j
X-Gm-Message-State: AOJu0YyXBqQBQmWcJ3wsH6xvhiY1L4kS+z4Q4AoCGIwchving0gKsATF
	B9SRFeGyC82Zd+OxnDZ0GAjbVztozWU8OQ0iYRQjQHgnmWraqJOBk+UJqnVQDXje2UHFG6URzHd
	FNvL0cJb5StGosXCCqAZXfKbB5L2/LgWe3YHIHciUh1PF32xMghyeCkM=
X-Google-Smtp-Source: AGHT+IGSb7TpnqwSGCGG28cxOnmiYIYpNyGtivf/GP/iiw46L6LH7vg1rhVfG7Dg4wxZ2pDxT68+pEWQYfQW0zHeNj5kV1nBtByR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:da06:0:b0:376:46d5:6596 with SMTP id
 e9e14a558f8ab-3839b57598cmr1242545ab.4.1720195811576; Fri, 05 Jul 2024
 09:10:11 -0700 (PDT)
Date: Fri, 05 Jul 2024 09:10:11 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b19f7061c824c9c@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos


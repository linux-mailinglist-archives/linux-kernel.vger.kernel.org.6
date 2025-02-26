Return-Path: <linux-kernel+bounces-533111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C08A455C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D783AC3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2D2698AD;
	Wed, 26 Feb 2025 06:38:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E295269896
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551890; cv=none; b=TeR6yqWGF+9FlS3aKTepX8n1Us7a9V4lueN0fO4pspGdixAsOueRuolNo1WStr6kEroCwi9jC0dI7XtWVTAnPHh7aKlCR5h7VXybcJnem/kFAVMx2aTPMRtBIHmoJKvxcaZ6q7PFMkLj1BmAuGP7lzQ5ba/P8+l9zFA0WA22kbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551890; c=relaxed/simple;
	bh=guiF0Wi7P0ZzC1Ced0aQ6A0N70jYk5WtLawsVVcMeSg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QIUYyRK75VdnOimKY/xAUtKUYni27lv5NAmh0NNMQ6ub6P2QxOWtlCb0KEdTjrT0DJEP8YmdR8GFYxGDff3xVW1kTo8jfJPv8r6JZKLxrOwQFDLhOZd5ZOGDGSKgxbMpyxLc+k4GQgJpoUmq3ENRA+qlQh2tv4WS8zrXQSi1RN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-851a991cf8bso40584939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551887; x=1741156687;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2Sd3OH8n0uNJj8VT5Bq1G6tV5mGRmXD3SIdjLiVvUw=;
        b=KjkmZHhnATtB+ReZOvhuUNC5BDvqjXeMFmstdE1aZnPL46vLuiCYWE5s7m/bmXrfQI
         Qry/GWXdLDnsG0XrDGbCTgterrtCeE8yX0XUsY1Pw51D/djjq5b0UfRNwU+mzs/p1yYt
         tLAWANQuCWszuOzEYZL/Dwsosxrf9NJGyLKWONc71oMCgKrUGwT17Zltuys/3tq+xN5/
         pfPZqKfCSaiutb0xJEPtU5mzwrMOG3Vv/oiSXnay5e96xbej2ptULLlMsEDQb2Vjgncy
         nEwr0dejhIlwcZ/IzR35pYCw3/osEbr7U7mxrr04hT7omnr9PcSo37rwkY/F6xqmgnhl
         2log==
X-Forwarded-Encrypted: i=1; AJvYcCVxZY+Zc3O413RMAh4R5zshhlAZxmcda12Gn/ZUKRLTTtD4NTbZgdvWYfbcnFpVUa1b4Ha7M6Knnm9Aa9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0uSuhuv9W2TW3KOl/2Qwl+WcrOB5tU0cTxVztSQ5ObsvGwa+Z
	HdowpfTK2eXzxxn8KQ5RPxcM2NHX1QLSEi+BbHtVt8c7FQvB/co2Ncq3gGPkd79R2gB5VZgT7mX
	1aez8Qat146jcYbC+yRbS/A8GmbpbVxWdjq8ugKzJWAYZDmXPg1ODsoA=
X-Google-Smtp-Source: AGHT+IFNIqlmmdkyElIfBgTMksbFAvD3UKgEmB0dGWiHR2hbc3WlCha1vSR4JlQ0eyJwK/IiVVxa+1etEqawYHKhoVPYLv5Za64d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3286:b0:3d1:5f67:f0e6 with SMTP id
 e9e14a558f8ab-3d2cac94fb3mr193538655ab.1.1740551887676; Tue, 25 Feb 2025
 22:38:07 -0800 (PST)
Date: Tue, 25 Feb 2025 22:38:07 -0800
In-Reply-To: <674c6006.050a0220.ad585.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67beb6cf.050a0220.38b081.0003.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_xattr_ibody_find
From: syzbot <syzbot+2471d99ca242f0f7a2a3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	rgoldwyn@suse.com, sandeen@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 9be53fe697eccf45e5c37e10ffd399eeca5eb489
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Mon Oct 28 14:41:15 2024 +0000

    ocfs2: convert to the new mount API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fdffdf980000
start commit:   9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c4096b0d467a682
dashboard link: https://syzkaller.appspot.com/bug?extid=2471d99ca242f0f7a2a3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172412f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12155adf980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: convert to the new mount API

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


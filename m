Return-Path: <linux-kernel+bounces-223707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8955911730
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F52834B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A92B1366;
	Fri, 21 Jun 2024 00:16:19 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3D394
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718928978; cv=none; b=K85ckH6n2T9vIrEYatLp8ui6If5VXscV5S/WrjOm8FX2fe8HcbF43fbQnIxbXBjmHkkM21Os7toKH97IR6UZnzKRaXr9Qw1e9v+8FD4dRKicEOeKnyBM8CjTPi6Ry7p4Aw/pQC00Ttqp8nG+R6vCBJxs/RbGE3Q9Ba2Z3hqjXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718928978; c=relaxed/simple;
	bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cuYuIKGGP8p8C4B4KJ2iJKATmUHKFcmgVv0TuR122G5MqGJopEpTbaNMWmgtWwkGuwAmyXhlBos+QB7wUBVo/bm6NIDnmNVk7KLvR/USyWv5R0UBvZaYqEKaSXbXR/dfJZVGZ9nf2YZDpojMuLZ17OBZuL0qyqYT4lf45264wO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3737b6fc28fso21689285ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718928976; x=1719533776;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
        b=w/FHAaRnMlGvzkGwKPPdfdn9RiFQxDDZ5lEyYQw779BQKPdvVGMXjqNqeYHutWPl0W
         DWH1Kn6j1Hj5HSoytTGlM9EzGB5vq5XU6SwbWboFduNmdmASweXnN6BPbfNqHA42OVyf
         pPDZiXCpEUsey5wBLv3fg+MhCILHXeDyfGwE/C9zqnTt3cLfqP+g0yFXOi8aNrUukW2q
         9s3BI+QW+gIj3GX1ynLQ3u5f7M2lO9f2r95dixS5ibU6I0Mrz/yLrt0vqvciL9BY/4Mk
         Od4I17dMAYdOuevw5bG7cDpuuneMiOzhjiWT6AHVyYsf6nD0wZRqQJ2X+iW+136/bL/4
         ETFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoam0d7hN61gTXa8RJqmMnQyPc7wbrJii1PM3A5iLwmwnS1er5P7l+DIdygz1EugieFIKwQrkt1U/qpTy0U9emoQERw9isR9qFgy/V
X-Gm-Message-State: AOJu0Yzm27fgQelu5m2+JnHj0bLebjYMiFB1+bdn5kA+rDRztyHkT+JL
	7IolGOr5VMW1lE4LP4VFqSKA17k6py9kDmCPT6d4xfogKt70RNllsqS+fsde/v+4WhF2QRxmBch
	NXpV2U88j0pY6Z/nQGtAHkHTt0FiQrr2B1L3HOqImtNA8ALTM5QotC6s=
X-Google-Smtp-Source: AGHT+IG89JAyn/NY9M/Hy78bC+ISEzcD5xhsyf833dKnYvd1Hw1ejNIzlzrpDi2XnWamhjOzKzSs1NIbkg2FI3422oAvKYuK7+dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d90:b0:375:8a14:1012 with SMTP id
 e9e14a558f8ab-3760951edd3mr3427405ab.2.1718928976587; Thu, 20 Jun 2024
 17:16:16 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:16:16 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b3e69061b5b5762@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
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


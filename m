Return-Path: <linux-kernel+bounces-233332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1657091B592
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C007E1F22543
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C5224D2;
	Fri, 28 Jun 2024 03:48:13 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BD2914
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546493; cv=none; b=U+Me4Y8odM+RKFCeVQrhcR77LhW8yzCl5vWla4eDTpJfZjPhnrOqKyd6QhZ7ueTpT/IgeiLMsG8V0ZjvYdYDEQ9isoitb32q19Rw+z2wKcZ6Ck30/VE2fABU/JnCVbkRhs4QRTBcHVay/6cruw1jemKXplmNElFI5mhHpqewmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546493; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l9Mx+T2AP6txNPfOfH2ixvj5ElgQHLL0WtlWDiDRZjpcEFtbFa4qf5yt3Vc1dTXe1UwVuSy6VfZTmb+aYlapM6HRLBwefcaJVB2+LabaullmOOXy+vtpzQIGSWTN6W4oRnXLA2QKUw0cRNFr6+gc15ZX5UbIns0+FxXOSVBfLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso22337139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719546491; x=1720151291;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=JDV47vhR439utjSWRaCfoYG9IwLfNTjLlB990tmzkebssqcmMub/rv8aO6JEMSG4L5
         JZ9Ge/DYw+2RvpEn9STFKcFMjtCMEnFonS2DG3uMC2VxHPfh91e8mOSMOBaJdygK1N2z
         yw7QnHL0EBo+vVVm0VvvUohB5H8XtUf3+Pvvy4ZvcrlDBjwklBQrdfOyXE1gqPIPqkWi
         g1RIwyp2uOkj1n0a3PBzFIJxidH572TKAuZ8gicDUUV0N24P6Sf7gwj25oGNq/o2tsPg
         +Wr/JARN9B+PG++5yBS3xfy3fcWbVtqjy0CJ76KGxUGwkypDBcylhZBC2WFpLJ4CiZwV
         4hBw==
X-Forwarded-Encrypted: i=1; AJvYcCUDbZI+P2ydf1q3ZH4l3eFDK6D8Qa+nb3XLN/aOjoRbQ3fxkouYNZ02xSai4JygLRobQCP5gRW6Zew55E3qxO2vRR+K1e7D7voRDNxv
X-Gm-Message-State: AOJu0YwJ5B/SMUL/epAfKMtnMd+DDO7sB/GADcSUcDA9UqpscZ0A2K+U
	v9iVPNLOtdgNKZFlZUhLF6MCV4rcVgWmsyeXukg0bQvWpMe53pM385RE5PrmewDlS93WUrf3vX2
	QmgpGkr3SAd7cxbz1594FqfsSqJdgUj3SDKG+oS5e0mj1O48ML137NA8=
X-Google-Smtp-Source: AGHT+IEBBqgISQtup2Pw/1uKpqjKjFEX4D7SLDczK0UdOyHzAXI7q0Lb5rMjDMzvhSNoR5lytn2LnreFrukLoL+dlECHsYSSKav0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9611:b0:4b9:bdfd:f15b with SMTP id
 8926c6da1cb9f-4b9ece1ba70mr1423229173.4.1719546491126; Thu, 27 Jun 2024
 20:48:11 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:48:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7587c061beb1db5@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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


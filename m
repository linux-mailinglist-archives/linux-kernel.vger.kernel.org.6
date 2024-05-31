Return-Path: <linux-kernel+bounces-196226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BD8D591E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4113B217EC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879A79B9C;
	Fri, 31 May 2024 03:46:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF7187578
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127182; cv=none; b=lfQayyU33fi/crhZX6AY2P3sy4t+v2ns7KpxdUd7bvRweMcI1uJIBY+6yYrckfm7c2dbmN3Yo/e8aTD5lc7j7e1w+3kC4nsDuVmo/enKrhFXXNKOFd561RxHshyBaflqHaHj2r+8SEs9ieqxI6nohXoFi4kVtnK6FHuM7CkVAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127182; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q5Z9TkrUfTFqafZ+X542JBau9WM+uaObtOAyZBEpCslKaBddBl3Rc1/NgCiqVLjF2na7jpXDa3Kwg+LJgPeXjf9MS3qrM5ZfGwgGTCMoulcxi3lFmUrm6u8gcfFG1DQmWV1Ng9pywqqtMV9/aIoONjyFHZtkktNeiupKEzznjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b4129deso13333135ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717127180; x=1717731980;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=xU0i2Ddh7FPhrotaG2bJ2vBQpuz2kS34c4/kmEdXTzrByHZ0pGtCNP+UjQJvjenPxS
         fBDboz4hA7a9zmRT0+bXzfxT3DE6KdzFKbOMa+1ShLcfF1OYVJBIVGoLVvBSvk1/cR01
         Pw5YGZXqMPLTTKsm+Sa8jaYzQuKlXMbR9WRO5wVI5bizvjqUgdhuZbdxVFDOncAexWTW
         fIhOHtBmWQOV6C8av/Wu4uIi9kmC7F7ubuM76xxrB8W6iFLGLgsLReCC1wUCcuXIDsFb
         tPMWpRipm/lGUQbxqHEQoaL5ubucCtru5YwiM5UhDuI0YTscnDId++J1Nd8HLkBVUryz
         B3qA==
X-Forwarded-Encrypted: i=1; AJvYcCUOCeP121w0469QIMLQAKj3tRF+ildN9Bp4d7ICnuKgyfRI/Sit9IU7aCiU3hp6LG/ix/S4F4n8VerzCub9Alez/Rj6+5PgAY4JT1WR
X-Gm-Message-State: AOJu0YxDpV+pYA6U3ubyiJhUBCWp9zZVomnyJHFmY5LLeGKOg60/9e1N
	N+Vq/6tnnEDATxdBEKjPD7D0RSLfar1KSI+XhDW2CE/QN08N8minFdcfhSKIDyTMa7CI3QMRslp
	R2nD68Am1U2qb/kiRiUC3er9JFUBIgctytcYBn0kb7KbbRC5cgWsfk94=
X-Google-Smtp-Source: AGHT+IFAlsDFvycw9GtdEcUnKblFYVUmsufEcUGHjOdczoQb273MFgKPjf2HsqU/ULaiNL0DiWQF9DvncnFTP9/cEgX9Dm6AepsC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c4:b0:373:fed2:d934 with SMTP id
 e9e14a558f8ab-3748b96aa5amr863735ab.1.1717127180409; Thu, 30 May 2024
 20:46:20 -0700 (PDT)
Date: Thu, 30 May 2024 20:46:20 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f6f220619b7d3a8@google.com>
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

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos


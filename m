Return-Path: <linux-kernel+bounces-188171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 017D18CDED4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8E51F21045
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC3219E4;
	Fri, 24 May 2024 00:14:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC771D52C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716509661; cv=none; b=efp7zVP8z7syTv8EVdmsfOsvH95SnhsarJLnKC2JoDAaoXHP+nqWXa9uNhRfWg2sZsfliUAHp58BiahGIpBoeEnuGMUzXsHi/QmPGKw2cnhiC/rSM0mQw3+Bw5Bc39Aizto1jjYqvvm4ZdbWQk4m4louARUXk1avoHscz7wHZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716509661; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u3QAPRMduHUsLzWPc+fWM/eSwgUgVb69NCmTcoqMa5t2nzuJuzOWJme9fvCDOo5eYtOqzWeTpDpes5HpziH3fWfuWPjD9QCYcNyz5SIZcW1Yocv5zK43LoQpnfctVY3PH0wTa47LYsrTK8uDDhFdAG+http2sRb1P05yzWAWAjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e6ff0120a5so235112239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716509659; x=1717114459;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=Jtsq6Jf1sOl6L0rwFSdCvslyQqvS2TeV0Yl2nG1r3NiLLsIGLyihx0YOoCgbeUVwAW
         XzJJ3duA2LNGR055l8689sTYjVEM7bEMp1z1R9LeHRt7437dqgqGQfXv0NGFt8dZp0kw
         7YR0DVGGDxNXFX0Nmg/d9vinOuWGytfQEQkpXz3y5th79Op8EdsxpfWqV5CUhaS20Vae
         gKwr6WnzTvRHr5hJilYm9XvEX9ZFpJPD0m3jGQ3MgyUzqHhR2O9Z4Q3vCMfVtmgTlhBb
         5I0i4tljKFb7EZxCD5RO9MixQ8R/oLHfWXsSg8HANEWAuBAapjmFZ8j2kV0k2XtoVNIJ
         OZkg==
X-Forwarded-Encrypted: i=1; AJvYcCXQwx0gqWW0UuflSOJlKu73lCtpgKT8uznb4ZD3pzWV4XPry8NjBf0QNXz0BD6qATmYDoXDoMh84VvFXpNm2S84MCWJyZspa3hjX5NL
X-Gm-Message-State: AOJu0YzfbkHncnvBSAIVSlhYe4BCE2w3Vyq9haP2m4qRttxEd1F3x6ib
	YFRaXcdMeSE3EAm6a9VoufNcdlmzY4eFVs40JOe9wcEX2JFfU6aX8BoCj/1tARUs641wRYLw51M
	5cf8liI5gnUOiG4ujCQKPj7aXKje82+lkOYbOmD+vLTaOsBo0XlHXvGo=
X-Google-Smtp-Source: AGHT+IHbMNv4QrOVDaPbt0DMHRVnsIeb7pwVv/vXpXSR1EvGYuLgqGIPPSr+J8t+usGOEUQRDrWUJM7L3Ss9ZVQi6jn3N8DgkSy+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cd0a:0:b0:488:f465:f4cd with SMTP id
 8926c6da1cb9f-4b03f520d78mr13470173.1.1716509659531; Thu, 23 May 2024
 17:14:19 -0700 (PDT)
Date: Thu, 23 May 2024 17:14:19 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000829fbc0619280c85@google.com>
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

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos


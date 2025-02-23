Return-Path: <linux-kernel+bounces-527802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A7A40FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 16:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B278A16B655
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DB70813;
	Sun, 23 Feb 2025 15:58:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52442AAF
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740326287; cv=none; b=BiEGSL2YJMo9Zj+7aiXuM0pngCU4aN+bbZ6H87grqkqm7hoYCjY3B+Nkjfrx502dEN7IoRex7HJKNk6BLMAUJAlDzvMvsIV2mx2gjVbBQCsVjiy0Wd2vrBLVljbnlr5UK6ApFDN8gVUXIIgQz7U4oXCMgUClM2OVFMBPEcmXGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740326287; c=relaxed/simple;
	bh=CEvphsc2E/R5iTREyGDwJ+DBlFN5f9hpVolHGcFMNQo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BKwenNrlLi/L9BjsvsTKyEN8qOIJGL6VYL8BIFLX5+UyHVso/P4ioa1iLntPGZ+ohMzFqZ4of9xZY4OmigBb3RGQtTaOsI0Jrau8hZYGg2EhyWjfYeiD39rxAb6iF9s03b5xTtKf+U5cxvK/BHm+23WHllv3KsbwXeb4uIm1RDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2b1e1e89fso27497625ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 07:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740326285; x=1740931085;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgB9+fNCSp76PfETamdpndoQ+g56KwwlJiC9JLaUFxY=;
        b=NMchcUZAv72OOhFsBgdvxEWPYcDJQR9MQh43+Z/vwQsEagV6BJjdgKhLBlK1p8FwYn
         qpZ3OupBxFMsyebpqeU6TCY9zcrztA/IHJ+J56XQFgjaiXGMeMHSSsdJ2j60VbTii094
         tTl0fUaKHxF32eWJ/qFIOs8c7DB/P2eUi99zgr2ilO+z93xXcqnx9Qz056Uf/dOJxpWh
         HU+G8QkWXncnNCQ+UX43A5FEBZ/9JnxExnJHy7jlXcPuigc3K1eEfoiQmFQFFdr7+Ysv
         ueELXqEm/MeNbUec1qzm+cW968X8h1dusGpVD+3AWlYAbCon9XrbYeqhOGhaWJmAB6e3
         Dkvw==
X-Forwarded-Encrypted: i=1; AJvYcCXAu0f5R8odSNlfqJERHuKUuWLp40kUcaaJUKwAvg5ij8CDvNO7fPknOyHzlXEv3YBKckWMAi+kD95pyoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmw+RRE8PRvNlFaPtWP789h4Pf6QKrjK8sN8+0/DPoSl5X0zZ
	dFydDjt8ym1rrmIrMORddAOe+RqGVVpXBkJUQ0+1DtCXGc4ljjr4qx1EsPt7a1BFAOrq9gflgvn
	ZeGJ5MNm+Ju//C+c3pL5Gfm9akKuagXKRM9/RcLIu+wC/UdMO6k1QIAU=
X-Google-Smtp-Source: AGHT+IEf48EhhTca6NrDfMe6cgbGuj+dvNOVO9lGR88kP0GA1oZuJvG6WTTigu5HZaNxLPIiiaFOqJNHzdrbAeoRcCdqQPRZ48UX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3d1:9992:bf11 with SMTP id
 e9e14a558f8ab-3d2cb52e5a5mr100678235ab.21.1740326285480; Sun, 23 Feb 2025
 07:58:05 -0800 (PST)
Date: Sun, 23 Feb 2025 07:58:05 -0800
In-Reply-To: <CAMj1kXG1mhe1_eB0oeWukpA_FMTzH5F6zFFszpDTr_x2smvzig@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb458d.050a0220.bbfd1.0031.GAE@google.com>
Subject: Re: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request
 in efivarfs_pm_notify
From: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/efivarfs/super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         a1c24ab8 Merge branch 'for-next/el2-enable-feat-pmuv3p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6b108de97771157
dashboard link: https://syzkaller.appspot.com/bug?extid=00d13e505ef530a45100
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17fe06e4580000



Return-Path: <linux-kernel+bounces-303831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE5896158C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4B92819B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBD81CFEBA;
	Tue, 27 Aug 2024 17:35:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BE254767
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780104; cv=none; b=eNlBBTu1Uj1JAUjvGDfy+Fg6BSXLqOAiFTy9uTEjCXbdIJWAqY4WeLwF+XJO5YtMT3AO3fs+Ku58vJ/5ZBurFeiWY/sT1rt6xZLg+CBnkjHvxE5Ofj3v2M4rvv1pva7B0E2svzWTOwJRtzriCYXl+euOuzX8iOyYDBzPjag224g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780104; c=relaxed/simple;
	bh=dUBtKcV2V8TL7EJss05VC37jXhzg2d1/8LxC2u2EZ6Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XeU0oTtVD30icfnvhbH0JX+bAq1nf2z8zzqpWpesf9NEd1THFt4L+0TA78Im5PcUosF+Uu104d4g+lJvYHuDcq68oVIqr+HKSdOwc7w4BP0qYBENAWRvkXjIE2QI1PjNrI8IYbeUfYJSDOqtXdIWGYIOApl1ErNJR7pZ1OoI/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d415635e6so75795645ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780102; x=1725384902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJGc5Enw/bVWRyXascE5qNPrIcv3PbxOBAdwgY/izR0=;
        b=F9QQiMKZn4cv2PPmDZbj06zZhn08pZajCN3EcsI5tfdzo60nSmyNKAKn63UrZ7Ufwx
         4iorN0I6y3vLQgjW+1W4mmS4WY4kmvPsxvqZRdKTi6i96M5V57hwTqTLl92O7RNYISYm
         Y/aWtWpphzoPhxZL+vycNSxwkVxW2ioTxEsm+Oo7SqXBE/Zxx/UDrWKYanNt8HW7mETL
         7+geB+xTyT/BPPaZ+Z9YKvmU3Xc3nmfC8wa43k2RlbQRu4AJN78hLFs7td6JjAugTS/I
         luj7KNPOBRihJmksfNt+A/og/YZI33+OPgxMdOv0tg8vENyCc1y15TgP5rIcBg2BB9bU
         hJ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVt0M8/R3KUkYNUAW3+LpZgsFMshxCIktrqL9OzyoyxQVfwuvPQZrkRfpwii5nUy5DAmS/zqQgiXHBEpiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZspERSjMs8//xoklEEVfnX1+yqtGncTvyKAhkLpFtK+oKniHL
	EGSwyY9QL0gbEXkALrik1Sn10nxd+uMt2FOpM79VyCglcW/ZbRPd81E65NzMcFXw2//o0LEnV/k
	GBmBt+Gb8+wz+La1qgyNDrzSmhJmsM23ZWesf0T2S9LTfFAkrytlYvJA=
X-Google-Smtp-Source: AGHT+IGJdtk6y14M5H64Ux1WfRPa7/IjvWVp/4R9r665mNBnM5QlORVpu2ddVdURKXgMAmcEEzSv2SGFGmNc+dFiEVpuAJtxM3lL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:39b:2133:8ee5 with SMTP id
 e9e14a558f8ab-39e3c97c238mr13113665ab.1.1724780102121; Tue, 27 Aug 2024
 10:35:02 -0700 (PDT)
Date: Tue, 27 Aug 2024 10:35:02 -0700
In-Reply-To: <33ba315adf774817843093e3916393b3@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d8a290620ada95d@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com
Tested-by: syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com

Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11655393980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73cfef0bb39c7afa
dashboard link: https://syzkaller.appspot.com/bug?extid=5b6ed16da1077f45bc8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


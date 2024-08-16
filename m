Return-Path: <linux-kernel+bounces-289056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A614C9541A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5851F217EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5E80045;
	Fri, 16 Aug 2024 06:23:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A210E6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789386; cv=none; b=uYwUkuIrvgCnkwzV2xC1CFwMx5XE8OslV+1Ia1HNMD+SlsUqkcYizyDOp5lbuzGkHfp5ZB6Wjc04+HDpf2rXQ6llzD0wk1TlLE0flq+lVRhJ9Ia9fJ8mSxwfksrTx1CYGk7Ro0iJUmNsySlAoO+TMOLOBxLv0BGU+cwWJyXY368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789386; c=relaxed/simple;
	bh=VAZr77K3DpeVmF5rZsbz+0vXvS3OrvUSACABlM42ycc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VO3dIVHZ5K5Zx7z7WDkZBXg2Cw9yTx2Nx81BR80RCoOXeDJdKWg/YN7SHpUmyT7rNDojmlRkYL13oeThSs3dwPeSPnvGBhz+fNLUjh5LZnq1zWdzokWwkxvjSqpllmAk9LL0yHBnjCeFA4YNS9mrPuzp4iUuTTV5MAKgAPR8OWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d244820edso11091905ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723789383; x=1724394183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9obx0888loJh6S82jNJRsT62Bnobgbfq82pcsMeyn0=;
        b=Wus1RFeFNXWKF26IqP2tQdv+M1+cBzfJ8ns1RUR0OzgG6pkkPVTpwahQegoiSpHyVq
         bVHOFTug+Ma3030aonzrI0hdAvdV+PK9x3j+Vi3XcNIyk7UJAKr18mK93S8FLYuo60k4
         f3PThJi1RoNhjrORYLNLdNWVbxo/rMtdcepcRqegQ8BuaKqdjguPhgMIbH19QJIMBrVg
         zMBeIFkZVq6UeH3+fvWa+bmdaQqRpDWYQ2cgJEeKeoGlUE/psq/3hTFIS5cGJLGk+KBh
         1oCIylZxaGLTDg8ze7JYeXvXKBlQJSCETNbCpJo684JsXovS/5tA8ZYNhxC68bxJlgqH
         YoPA==
X-Gm-Message-State: AOJu0YzByUSGP9AABpgi7zG81EAFEXxNcAwdRPBzDdy4GccI5/q+TaYQ
	hzKHt4UZPOzxVir7QbR8yA6uNDHGEbj+qcLzoJLTgOcTNcRQwgBxEeKqdjx1q27Hm6Ueug6jb8k
	nZLCBzwuy9W1iXlTAgu9QhFd9r14fLEkgaYCbCXAVasrOxKDmW1hUmHM=
X-Google-Smtp-Source: AGHT+IFbTKE3GEBEE5Gc/ab+dJxwlILRNSXwgQxSghAEARQgG9kmscNGLS0W4WjhYouFDTpW3Ntt9k2Gj2I8sXulow3TtHmZVz75
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2c:b0:39d:1144:e784 with SMTP id
 e9e14a558f8ab-39d26d6ee1emr1175535ab.4.1723789382768; Thu, 15 Aug 2024
 23:23:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 23:23:02 -0700
In-Reply-To: <20240816061835.50652-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3eb64061fc6fd21@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_iget
From: syzbot <syzbot+5bdd4953bc58c8fbd6eb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/buffer_head.h:414:10: error: no member named 'i_state' in 'struct buffer_head'; did you mean 'b_state'?In file included from 
./include/linux/buffer_head.h:414:10: error: no member named 'i_state' in 'struct buffer_head'; did you mean 'b_state'?


Tested on:

commit:         d07b4328 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=5bdd4953bc58c8fbd6eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f5e18d980000



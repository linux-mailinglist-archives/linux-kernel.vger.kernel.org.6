Return-Path: <linux-kernel+bounces-423565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D029DA9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A872281945
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96391FE46F;
	Wed, 27 Nov 2024 14:15:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94121FE470
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716905; cv=none; b=jHE57ZkymmrNOyymM5SPwvBoCIDACQXnaA0So6L4krXFh91OFnvA+kkmVC7rdYbRqFZlN1YTQU+wtHYsgChcdtu5yEtwCFThpXkyhAeEp/58xO5wIhchFqUgAddkizz6awZUFKYuaTJAuYQbUAf3Gniy17vvAry396FqhwYlv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716905; c=relaxed/simple;
	bh=E3Ewg/fB4LivoFdD6HxC+DmVw+Mfq/VMCl8i8OyIWZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z+qyHKSjnXc/34+gZz0k/dwSJlIpeNY7mddKYy0A7TXyb6oDZ/W2lYHkkrWKx+bPDLFxtZB1Rbwa5RpX+NvHQLD4nxJmiZ9qHy/tEhxujJqQpJH0BRh05EB4Trvb4ROvf81HjG6a8XV0BAF1FEtPWP3EdUIwzRIGM+m8cls/e0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a76690f813so81151165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716903; x=1733321703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dq1NinhyziTFGk/D+sZ4MANHxtzj3cmies1kLnJ9Oc=;
        b=YtBtPpPpNnErNYYur9t0Z2c7zlvmUsdVjNXDO9AL5cAdCAgeP/SlyRoXJGaHFULk6Q
         WCGU9lJ0rYdxHyG9IF9MdCCF4EEoDkB9qLanOCUsjsciM4igzsQkepttQzELqPOkWvfi
         wPh2/3eEvPKxupKHjleI8Sn3G6INFJZS2gFx1t19f7ix7viu9CouZOG9qOT9Gxk7LXPN
         Xe6g5bXaQH8Dj+6ahggMS0f5KzBeV9FcrYL6nbZkBU1w2mHgbaQ2nIv2smjKP4wL/iQA
         mERKCBuinFefNybOXfPc/TK41q8X1ARh45aOUEv2iB8KeT7/lSF3wLko5udfmsS0Z22p
         ergw==
X-Forwarded-Encrypted: i=1; AJvYcCUHTrdkomdpwSB0NCnx9qWOQkYPgvCkidPTr0+WJSor1OUVMKECn7bXemLzEl2nbYXZP8ZcBMImEV/I8O4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13V7QY+lmtPy1jkxJ8YNChHX09MUd6Ytd+/ApmuTQeeDfsvv/
	EgdfrAZsSRki2OlnLMBJZgM4f8HDfObXgRJ0o6Glg++ghLbC7jOBowPpsXqlEUoHVB6KUyP2lpL
	OQbvydUwuyTlKNPLaVJHq0Iutw3SN3TogbWDJFj829iEK3UZFGP8s60A=
X-Google-Smtp-Source: AGHT+IE9u94DXLRApZGRt/9Nywi1mzoRq27bbLgjeEKFUt2Vrczf+GJqbng8lttZtPu2piaRWIJCCoNWzhVaM1gLpf8gWP3+Eqse
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a7c5540a5dmr39101015ab.6.1732716903041; Wed, 27 Nov 2024
 06:15:03 -0800 (PST)
Date: Wed, 27 Nov 2024 06:15:03 -0800
In-Reply-To: <tencent_30014B511B63257EBA56BB6633809E931B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67472967.050a0220.1286eb.0032.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfs_bnode_read
From: syzbot <syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com
Tested-by: syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com

Tested on:

commit:         b46eb5a1 hfs: check key length before reading
git tree:       https://github.com/ea1davis/linux hfs/syz
console output: https://syzkaller.appspot.com/x/log.txt?x=16a943c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4d3ea4873b22763
dashboard link: https://syzkaller.appspot.com/bug?extid=c6811fc2262cec1e6266
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


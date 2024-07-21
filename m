Return-Path: <linux-kernel+bounces-258244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A140938572
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972F01F2116E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39F167D8C;
	Sun, 21 Jul 2024 16:09:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3806944E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721578145; cv=none; b=j/AdMUpxqXPrK3qJCFbjyLg6jnoYKI7FxW1ekrh3P8t7Lju2EGehggwxEPub+B4baAKBrpwOT1lSCdeUdamAqLRTFoIPwazx3Qt9GqNy4SLjwprtW0jWn28wB6pyYG4Mm2WZ/z+wEcoI3R7kKJUMQkj6MeetAxZmwv3mGFgqagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721578145; c=relaxed/simple;
	bh=uutlHtpugxrUEzrSKhcL4w2YHPl3bxP3dJc/TLMud9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xvp2Sm1UwyNI4QitoKnpgBST5GICLlbK4hdbNJtdIPHAg6n9MudAgQuthiVcMQgyS5qTrAPQ5pV8G80S3kiozOC8s2KTZd2NAmL3gNtxeQ0lUeLj+hq3ln390pFEFpe3+sRNGKf6c1iHeX9UGcKjOIIDujh3aGt2SdLx9EtpjoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so565466239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721578143; x=1722182943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJiOeOZH6lwZIU2UFIW7g7UStPAbl0g/tDPLbD04+Nw=;
        b=ZCmzYsq2dGyYBMawT1Wj+qgZmrOUXoLZaqJiqcAu6OI7/LjreLjdocwPXEymbhqtH0
         RBo7QDfJkocp82AjtQo6G0XsClgUvPzYV5TQb6gdsVuhL+aiXpcd3pdjgfwR49CvAGGy
         PFyJo9ToOlRSvVAPKDX4t4kw/GuQyCJfyaF/yED/LFzjD5B57flCpTfr34mcWqUah3Sp
         ofLN8AozvnEUv2x8s7fYG+b6eiYAHKpIj8gRb2o1S29ry6PEDteaEPUEQnvAJ6rBDvXW
         bdgq5RvA/ZH+18ptYl51ePYp+InMzoZ8aWtPO0EQzEiPwD5IIKaxPEbKa480NfnbSNFS
         iMCg==
X-Forwarded-Encrypted: i=1; AJvYcCVh+IkVz2rCqlcz2lgpynrauT/CWaktxFxPTDdZhJk9pZ/kR/t/3e4nDlBejTSFp1BdZJOVOQ5O6kjcMYQmkZcHKA4+lBgimD2Z0t8F
X-Gm-Message-State: AOJu0Yw1T9gRwsmQmAkbhjc700UVQmiZ5Z4/e5MeM4GLmLOBiUpKa3fP
	z6zg1EkhPf85ZR65auXLqW2H9cHEmCHRdIBxFLV61DS34mikMW7TbmDElyQR2XVnGo9P9esWNQ/
	L3AViYVmRwPDOYsbd/Wi8vWOWJK+0YFNe6bZOvr7O+4s8RObXOgaCMV4=
X-Google-Smtp-Source: AGHT+IGTzKT94iXMz24AdBgqm/H1yAAddJ/Vib79Ds9BCjtTnITbXJq9s7E4RvZw5rL6HY5MrS1HXi98f/IqJ/mFUEaUc7+c6OYH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c9:b0:4bb:ae73:2783 with SMTP id
 8926c6da1cb9f-4c23fdae429mr163980173.2.1721578142298; Sun, 21 Jul 2024
 09:09:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 09:09:02 -0700
In-Reply-To: <20240721151344.269717-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a00561061dc425dd@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com
Tested-by: syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com

Tested on:

commit:         d839a731 net: Optimize xdp_do_flush() with bpf_net_con..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17b493e9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0559deea039729f
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


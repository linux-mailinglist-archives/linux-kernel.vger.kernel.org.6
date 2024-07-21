Return-Path: <linux-kernel+bounces-258233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1094B938555
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98DD280EE4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190B168497;
	Sun, 21 Jul 2024 15:45:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6D150980
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721576704; cv=none; b=eOl6oL2JKQK3ZyxdthCWfhBDCucIJNA3dpFXLCvdUUV83PGB2nhvUQYK6ksR7Ne/ZsUjnuffDJLxOWaDI4HmGH01Zm+8s+pEJorlJj+lh4gyPJAHcfqMV0v3E3WG2QDfiMxvAiA7pKufxxqP3qGTCraOUs/nt59MadrD6f9RSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721576704; c=relaxed/simple;
	bh=Z/joUD2L5nQhDJ20QpvfIPP+wuIWy0Zyxa36xx7Ebpc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iF6fY1wZdSYQCxgJOuxpReph+UPfRgKo50gF0yD+DBKIUBR13HbPDT/9MksC4X/ohtP84X42h4wTJ7U0DMDqB637k3QKDSRbr1zCgjzKuA6uzk6REihe7cO8wgo/I6cSNkHI28SGwc437+FKXU+UhSdjWDMIY1R7JmLgIATi3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-807b123d985so670174239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721576702; x=1722181502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/gp15HMMxNcRvYTKDgaBAEi57+GyA6IiT+Z88vpCU4=;
        b=Nk3ULNe/WMN7rX153jyMsxDhnB31g08DSBlw3AH5k7Fh7jNtm7DxKCsRaH07QReZ86
         c5hdXXuEXi41PoW7eXU8cKSmCFsNuyJzlVnnErruOEBr4rYtJ7y7OE/BZ48P2A70MhNL
         bDC5TNaDJ9O1stdh4FHGdr4TBvDvwEON0gLrasfJnUU3NGlBpSPBVEXwPZ9M/Wm0h7/o
         DimPlSDmFNs7W9gJje1nsuAEoghKxrwQxHutINvFI6A/9kp55c+nacMs5C9iQZMzxLpK
         XmnguZOjXbBpsAsSiRpxj/Abcu2W6mV+xYx3siY8kWI7bzQmFPc3oV285iXJUUuoCE8M
         TBRA==
X-Forwarded-Encrypted: i=1; AJvYcCXfCRXEIkZoaAvMTzxFnRSBqQ5/GFl7Jd3h7Limtz4BNVnPPOjhEZuzFRChlg38qG2fX2rw2zTdMelzBprKe/x93ReK2y+Q2CaCoX4y
X-Gm-Message-State: AOJu0YwsUb/58sa8OdHaeePZRFV7eO+uLxfJfXxXoG9brtHmp++zqYpW
	N8GUxZsYIvgq416UZ2brdxFVoH6MCwn0mMq5QjVrETgprlnRKjyo5l845rQz+kRvkRoi4wZnSnp
	wyxLlHF0gqgtxuHdA//WyEz3/AfQMcYx//6twLbHnzlZzApQLnFp4dyM=
X-Google-Smtp-Source: AGHT+IGVYoKSm8U4F50UyRDKTNxdvw71xwnwL5mipKDBTDLY7EilhbFcEpAtOhFD5yj14mF0HNOZFUbg97K49qJtXfSOzLdJ9+9j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8715:b0:4b7:c9b5:6765 with SMTP id
 8926c6da1cb9f-4c23feb73f3mr376978173.5.1721576702353; Sun, 21 Jul 2024
 08:45:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 08:45:02 -0700
In-Reply-To: <20240721150446.269633-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc3466061dc3cf31@google.com>
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

commit:         3f9fe37d net: Move per-CPU flush-lists to bpf_net_cont..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116bd2e6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0b82937c5cd6774
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-212333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90566905EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 00:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D6E1F2259E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3ED12C47D;
	Wed, 12 Jun 2024 22:41:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02521360
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718232086; cv=none; b=fB3kiK/OoUGexyUgvdEV4MDCdVyaWKF0SiQ1Kxt7THHf+5TvoCiUz6w4hQAXDFnfZrZbY6A+K1FPFJToxtxZikkXCQCeoEjUiQaAyOhheZ361zVTAscGYxgAPvwDAZBJaG4OrS0GF4P7/jUy1A0IX4w2191fq80lkYOm5S//94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718232086; c=relaxed/simple;
	bh=K5YyxLA11PLGZeCHK78EvOq9cPOFvcvbwQR+YdwCToQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fGFwOgBDmC+ix2O49jKZ0pYd/T3ZvPH0s0cv0u6SJlb1YLMvLDAhIEzACCItj5uR3ofPwFf8gEPg4e+EryQlsxn0La4UFG1MQRD1IIwQj4CHXBTXcubnebz7H+QiknpF5h4GVBekMmP7e2pEC1NqVW26ib99Xq5mAVu37BCwYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb6fd69f7cso29958639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718232084; x=1718836884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mufdid0kgCdbIFQobNxZ/g3ngSfNEOwaNWumRTzbMmU=;
        b=jmn2ZybxGHg6lGziKnOYMDF3gqDAvnAWvlkra2NIgHdkc+dmfCdII0lTn+EBp91HSf
         tWIkb7VOc+IhXCY6Zj+dZj5vwkOWT1nsHGdfLopw8AH7qqygVwvNpavM0HhSNpHKOJrq
         ESIq8TW8d4ESRchjrOCf5wkpvtVCKp+lJjrJootH0ApPDxWUl4Uu8qe+5mOlfO9nnqcF
         IrNGZJLCaQVlF713q5aSHHt44Ab5132jFTekaSyd35wFudRKRqZdkO5xqEUl0mCxUUe6
         lHgYS0UgmYnXPJRVaso7tryhDMHl7RO9ieZzWsdIWeSo1wvxhcW2RpNRXEF62oXOaecW
         249A==
X-Forwarded-Encrypted: i=1; AJvYcCWRQccdRx2xq1EfyrvpnhsS0/Y1CU24z+9dI8DZLBMDsJ5SurRb4XK7UOuuH1YIR1tk6FHB82OlefLC1qiVpj6vgAsh5+3xdcROOYMO
X-Gm-Message-State: AOJu0YyEsUBm9SwMZ3b9axweeqlSBGrv7wF7dxs/Lu1QDAJtrx9xNPhA
	ULd0RZxyWuc41ynFcuXOk2vzI5swvsMBHdJVWwwJ/wRnuRmICwmgpvQ1NxKRNMgl/l8IYFqmcL3
	4LhbX8sY75LQ1MUlsY0BphAxXdMGjE4FvRoWRmZl3oFsmprUqua7X4MY=
X-Google-Smtp-Source: AGHT+IFgpLRRkr2wzJHWMlnK27XuzjJnL09Ay4Thz8yHDVR8sRNFRo/3Lm1ePX560qyFI0J/dEcZUeNph6CSKJoX53M041Ww+eiI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641f:b0:7eb:b36f:b4de with SMTP id
 ca18e2360f4ac-7ebcd189081mr13866939f.3.1718232084315; Wed, 12 Jun 2024
 15:41:24 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:41:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000072aaa061ab9153c@google.com>
Subject: [syzbot] Monthly bpf report (Jun 2024)
From: syzbot <syzbot+list6bc05ebaf8f2eae6ce86@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 11 new issues were detected and 4 were fixed.
In total, 53 issues are still open and 252 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  8630    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<2>  8113    Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<3>  869     Yes   possible deadlock in sock_map_delete_elem
                   https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
<4>  733     Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<5>  385     Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<6>  165     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<7>  153     Yes   general protection fault in dev_map_enqueue (2)
                   https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
<8>  136     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<9>  89      Yes   WARNING in __xdp_reg_mem_model
                   https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
<10> 88      Yes   BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg
                   https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


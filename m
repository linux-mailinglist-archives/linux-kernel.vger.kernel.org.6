Return-Path: <linux-kernel+bounces-286450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53125951B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA8282A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3FA1B0128;
	Wed, 14 Aug 2024 12:43:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71811B1409
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639406; cv=none; b=XqgKnPWBdsipGBIgihH0C1qMNQOPcllia6zsS902AlZiepibTyXirzSDd6zqRoYuRpywxTZeqmLsUzkCE2JS4L5YwiyAYtl+SNaBybPlMLZA3Y8Usw2mhuUq6Xdh3yZIuLeNK8tJa+VN9za0LN6JIs26wQNfPv9jvZc6tH/s0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639406; c=relaxed/simple;
	bh=RuBfvE/W9BI7mVERMpAQtsW56y6ZI/QxMSfLfnONHrc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TZHfV8IeAlVj/VA0uoZ6k0/V6NqFTcOfTAmoWibmyCu+/EY8pPByR0029Ee0Fst++7sGRwkptAYW40T9zVd3e9KJWpqfu0HnmQEDQTpWY7OVJHhxJAevyfogA6Shetk2p4k9m7KiFRTXqsBnxjNINs5NX3MfLtId4LjteRMVKXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3d98c318so81110475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723639404; x=1724244204;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDJmLsEquh5f4ZcvIw4RcS1IgBdOTTkxgLTeAPJZD0c=;
        b=HY+DNbF9R0doKJza6rPuSvaQOfQyVqXMfWm8cvdYK6liCBbNNF0NozBX5iJe0rGgvy
         WSfH12fbmO2pwzCw8JPPbuuNDOdFX88PyReQ6sVZ4wyV7fBLqEQT3QzK2AdfLBWvGuqz
         Tz2Z5Ofpr5L1hz6VJyVhHImrBCNAB4J2NGV+i6gxjrdWKtLWpU2onjLE4BZwOUPfaFmf
         sf+K2KVt1/2HYfdKaUyjz2h2+HAOQFzIPYW4g9Pcy3d1jpIO4oQeYVAQjX2/wJqCS4k/
         3l8rnfGBTkodzwhlyuOmoJJGbKNz02F57dBwHEdOKoFFMpbbD3CHqohbkKSFJ5RAgivc
         QRsw==
X-Forwarded-Encrypted: i=1; AJvYcCW8lTxcM6NEdsLMH9J87xUgjUiRc1nzjGiRCymvx1bmDu3gjF+3KYFpwOM82cPUKOpTFY1yAoY0M6vfuYlSub4G3ItuDNZpEm32QXBO
X-Gm-Message-State: AOJu0Yz8+Gkr1lHAOVv+HmBfETkLuD6o4hEdWq3fbCSG3Na7yErrusJi
	iiVX1pVfGZpV0uphYnV2mfITe/bJIpyr9P5Jtfh4XKszbfj+rhUhpmG1CLszxL5uwcPzoysHw7T
	qSZS4C51c7pn88yXVXwQ3klRc6p9m68OyEmbosOQDNbafaclzV+GnJAY=
X-Google-Smtp-Source: AGHT+IEpMs7mc0JKJw9xhHzszN6yeUc3B71RtVaVQ07Q1BBvXw33euB7RINDfUlsEBCCFTnY/9HOc89J2Bods7UkB0i0l7ZHcxoq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:380:9233:96e6 with SMTP id
 e9e14a558f8ab-39d124d4ee0mr1961145ab.4.1723639403849; Wed, 14 Aug 2024
 05:43:23 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:43:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000633cf1061fa4125b@google.com>
Subject: [syzbot] Monthly bpf report (Aug 2024)
From: syzbot <syzbot+list2edbf5245474e3beec7a@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 2 new issues were detected and 6 were fixed.
In total, 48 issues are still open and 269 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19123   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  13875   Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<3>  8937    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<4>  1885    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<5>  1371    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<6>  336     Yes   general protection fault in dev_map_enqueue (2)
                   https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
<7>  199     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<8>  147     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<9>  102     No    possible deadlock in trie_update_elem
                   https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf
<10> 77      Yes   INFO: rcu detected stall in sys_openat (3)
                   https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


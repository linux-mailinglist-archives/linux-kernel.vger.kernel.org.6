Return-Path: <linux-kernel+bounces-329398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88099790CC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 14:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3984D284178
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742621CF5F4;
	Sat, 14 Sep 2024 12:53:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B41993B0
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726318408; cv=none; b=oV4saHzr5N6VmkwZOsF+3QM3cEeS3zbgn0sK/fvXdkvYWRGZRKqeHn1jP9ur2mXRGEM/Jn8810ZU2bLeyAeUb0Qt4JUTYTKGcoka3LcHxOl3muz3cO1LUiqLvspQ904RVmf2G+GNcC20adSsagGnPwCGkY+DXtf/NgrYQX5hje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726318408; c=relaxed/simple;
	bh=x1c/B9JEwm9g84doycaGXlC6PcXPJ3MueHEJYFHIOPw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WVNrS9i1orJ4k44WX0++wu6ncmQu0MdmTdbhO/S20kzl1R/X5zovQ4mb8BiGNCI+470npBnLMgvdvHw35pWLWqv3PEKwh9g/C/sF4UNZ9QVNPVqX8b3hsW2WrNTxcDBYXOfariAb5STTIWcrb+yvXLg9oNh+7A4CKg3pWB8dbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa8af04feso615565939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726318406; x=1726923206;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0IaeqC0xzTKfLcN35IGn0kAeoUdvSRjq4JfhcPM5Uk=;
        b=XOMsvb49yqRBiQ9aZubXdZzmfXeP8oFk/KejaIOHxEzJBYmac0uO3PpHyPwOJhZ6dT
         adP9VLCjdDmXI3L7FRvNWsOA9Rowo6y23/KcGB61nlvaUN2bJ3/IWcadZSqmC1hIvmAK
         IXOUIf3MPv4Lc8Z/llmhZu02GeQxmR0TFf8vMmzqyW/sL5JlsoldH0hFlCfjqQAtvqnZ
         l1qdFtB+Itkz/CE1wNCCAjuxij3F56uesUgxuvovCvNt89qLkRHKrjCCOIdgFa3uxCXr
         0NvI4QhOp/Q2Cty8Wuh/rMlJ4GU6GgPWf12Lp0e9tPSRjU2Rv269Za6II9r56sBPsWMx
         ntYA==
X-Forwarded-Encrypted: i=1; AJvYcCUvqMedUDV+YLOzYvdrxtrA4A1anra2B6+9I0HKzVOTItoCzunc1PIGITyjFoftAqz+d8/6DJCn/s32xHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7er+UPIH08saiGRqMmgj3sPElXK9fV5dK+I/JlE5RjBYTvmM
	zrsi0W59LhLeQ6/uQo57icnslsmMy0kba3AC9z8yAP+GASU0gg4mS2xi/C3DOG+J3ByRqFWTWFz
	xBOqROhLfAfZptR4k67socoQgHdahnM3RE/aRAS+llD+m7dtVqWPysh4=
X-Google-Smtp-Source: AGHT+IHUvMWY5osWpQCXP6DIiRrQsd6q7ToBzRZ7Azunv0aziNlR2h7wY8X0/TeDUwAboqJiREUQZMWa7WIhr5d5ms7mJYrFcrAP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a2:b0:39f:6180:afca with SMTP id
 e9e14a558f8ab-3a08491196bmr122016345ab.13.1726318405792; Sat, 14 Sep 2024
 05:53:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 05:53:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058c9de062213d3ad@google.com>
Subject: [syzbot] Monthly bpf report (Sep 2024)
From: syzbot <syzbot+list124fe6638bb6df321a31@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 7 new issues were detected and 0 were fixed.
In total, 45 issues are still open and 270 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19833   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  15949   Yes   KASAN: slab-out-of-bounds Read in btf_datasec_check_meta
                   https://syzkaller.appspot.com/bug?extid=cc32304f6487ebff9b70
<3>  9068    Yes   possible deadlock in task_fork_fair
                   https://syzkaller.appspot.com/bug?extid=1a93ee5d329e97cfbaff
<4>  1539    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<5>  230     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<6>  155     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<7>  132     No    possible deadlock in trie_update_elem
                   https://syzkaller.appspot.com/bug?extid=ea624e536fee669a05cf
<8>  50      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<9>  49      Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<10> 44      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


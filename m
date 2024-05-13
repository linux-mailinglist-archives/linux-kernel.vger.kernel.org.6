Return-Path: <linux-kernel+bounces-177564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA548C40D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5734282C31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E243E14F9FF;
	Mon, 13 May 2024 12:35:44 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B7145B10
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603744; cv=none; b=T3tgdU50Y9b5qUrZYTvVRHwf36FlVvTUq/0SpkEGCD+3rW5VrnukShBX5Jz0MPFkw9dFs2LPNRYRF7470/5JMnOROiLI0WN9WXv97VmbACVIBll5H2gNxmi+/xEf2IFA4rxtXku+LiZjfKEY9O9p2ogmIluQ9HnW/v6OKC4GvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603744; c=relaxed/simple;
	bh=oKLIKN/LA2qP/A7K2H7b69maMhrft+dHWN05c1P/Iyo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qil5hyUIBc03VIntPf4Ak1NZ7tOs5p0FPtB+IqQXGyB/BDu5EhATpTEO9/pwQborHZ96xmfakdm9lSWmkn7XuLeTNrZakM032pLawUhGJuEYa2VVXZXuhrLkuqP941K1XpSKvACqVnmR9UxD/H3F/OwaEGx36HrY9s1ZVFRTOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so441959439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715603742; x=1716208542;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=if8T46urbQNJN85WrRQs2gBhlpb+FKzcO0gmp2dH/G4=;
        b=INQ2jnjGwbJ7bMGN8Vfti1coQq/b61dK7/COjH7OOJBwGq0EORL2DSqZIKVmlHPWtn
         cbuMANlpHPgoywh/M3OeCUQNk4LvIDxq4FOyq83ky+mNwOlfrhleM2kLx25K4/W2qaQy
         ce5PmK2yTUefkCi1LqoWg/q+VJ3nMtuc/PR01JbWvyH+E/NURYH+Q5vA8GZTeZv5ZiEp
         +JP2F/IPoW8h5Rsz0zEbcEz/XKABU9ewoE9CSFx7HPJd5Oaqo7PY1S8H1/FUtGhwvC3L
         Rf7gZ6GILN7wVlBcuUsmbUtJFarhCebnc0lf9NL/hsJoy47ZkmGuyQSYJ2cX0pPw1bF+
         nasQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe5MHo0LDYIqHt0jlcMAO5kEV7ml9zs59iBl2sNTumIOtupEofR6biJCjGMQnpm4jPdy2vf64fWsIWkCWUC9eN1Qz2sbzVoTxi/M86
X-Gm-Message-State: AOJu0YzpfXXY16Z1TCylLZR79O6tk1zd1QutT29LmAiNh15vIzDo2bP+
	U/kl0N/txUme5lx6D/bDjNhdiNEARqMc0IlQXDC5EY7GDWGxMdeaF2Fu+sZjWJ3/4Mo+g3f+fI7
	td0fu72Ct9jYBYLc4qk7zWYqcrbz967vm0xVQr7JDtjwxEfpfqxXctaM=
X-Google-Smtp-Source: AGHT+IFkOcJUfGNBMFnhw7AOqZk0zhwbG26hU/3puD3J78jqgbti4ZnaCFmJdXfhI7EHPYytA9urrqbsM+pNjJd3CFgGDktBFTfo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8427:b0:488:7838:5aba with SMTP id
 8926c6da1cb9f-4895868b41amr921226173.2.1715603742333; Mon, 13 May 2024
 05:35:42 -0700 (PDT)
Date: Mon, 13 May 2024 05:35:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a330cc0618551f1d@google.com>
Subject: [syzbot] Monthly kvm report (May 2024)
From: syzbot <syzbot+listae8e7effb4763866f80d@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 116 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 147     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<2> 4       Yes   WARNING in vmx_handle_exit
                  https://syzkaller.appspot.com/bug?extid=988d9efcdf137bc05f66
<3> 1       No    WARNING in kvm_mmu_notifier_invalidate_range_start (4)
                  https://syzkaller.appspot.com/bug?extid=30d8503d558f3d50306b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


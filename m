Return-Path: <linux-kernel+bounces-396073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61B9BC79E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949A81C20940
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358861FEFB8;
	Tue,  5 Nov 2024 07:58:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968E282F1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730793486; cv=none; b=VFtEz2IkeYRsB+rqf9iaUImJUsKA9R6/MYMI9T10nUCc15P6g8s7A/eNhG9/qXkq9KD6sec7aLuMYkcWFw2XQmVzfBfLO8663yhoI4AJxQWyS4hWwWqfQ3q7UOvFeW+l76Lx73s2pRBJTUBz778HnvXoQqV98nY2etrwMbHiiyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730793486; c=relaxed/simple;
	bh=azZXxtr3X9ucm6FpIxDdwthQTEnhdex8BBxFlVmHV5w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vFvfURqp6SaaNlvQrbOJvglAPjTJGcxGWcb2qEYZ3dpPUgmhUmEQqY8sghZBy8Xxo1wLyurkYq6PXsxygrqzQspMHU4fkuFzVwGtUXdCZ9s6flrH8EIEi4by++aOXiBciNcZR2aUh48tlTLSxiByv732/HhPeVXJlmtJfRgE/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aecd993faso439466839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 23:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730793483; x=1731398283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz0PnaLXXeh33Vto5Qgmk6rptED8mC9ZDGwkI2x8mNU=;
        b=PBMwOIKLR15h7ZFrrJiST6t7zX1FvBDbQVY0K5JFon31xtFsawd9O4KA18kAB8ODrG
         +G+v9pqJQOmHBjBoO4br13oW/ZJtFwoAn5gfbyDivj6/eYEDp0Uz4ml2mrQGvOzQBc6v
         NsjAZ4Vuakg6Cjk30GSJgL1sZt6P0SEBhrkkR2tedN8iA4AIaasepGnf7hS8a/Skyr9N
         WlOz4r8Ubob9lpLH3yAsmahFogY3azR7MWTU4VWxEo4S91n6MZLGdHlLQA409pKbwy5B
         PzPsLReDm3QFTII0xjFFG/wLtVvMSLQTd5JMnqilNuWTgudEFg8uoK7M4BhENOOh+eEP
         UAYg==
X-Forwarded-Encrypted: i=1; AJvYcCWd4OQiQx0Qsf50E8qgR0bTLsFmZDHWChoc9+T4QyM7+ErTwCCQRJtg82hjerpRAUyPKx4ShqA+slucE34=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpDTLJJ+NiKd4wgSJM+UkTk45pPcjS+rDLzdG/DJLs7cC0fBce
	cwoXYFAGMtGu5j5eJH1EKssqd0StAhuo0wRXZKruTfAyzsb3TD6PGYOj42Zf5m7ZWGAxnzOfkm5
	TPDPNywffpqwf6GYIevVcBg987QsFcdUmJwObsCMV8OkNW2AHUACQAxk=
X-Google-Smtp-Source: AGHT+IE6SM64gzQV+G2MzftNe/1kj7WQmgNm514nrfiz0SAat/XyvtmpAkJyCjJ8V+p528xsPUnXmuwoDEPK3qHvphotnmTrmxdM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c08c:0:b0:3a6:ac4e:4d with SMTP id e9e14a558f8ab-3a6afeef2c1mr129996055ab.7.1730793483476;
 Mon, 04 Nov 2024 23:58:03 -0800 (PST)
Date: Mon, 04 Nov 2024 23:58:03 -0800
In-Reply-To: <67251dc6.050a0220.529b6.015e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729d00b.050a0220.2edce.1505.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] WARNING: locking bug in kernfs_path_from_node
From: syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, longman@redhat.com, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 560af5dc839eef08a273908f390cfefefb82aa04
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Oct 9 15:45:03 2024 +0000

    lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d13587980000
start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d13587980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d13587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea37e2e6ffccf41a7e6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13119340580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d56630580000

Reported-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Fixes: 560af5dc839e ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


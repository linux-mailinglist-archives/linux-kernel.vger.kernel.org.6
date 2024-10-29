Return-Path: <linux-kernel+bounces-386832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57E19B486C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C5F1C2312F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A571205148;
	Tue, 29 Oct 2024 11:37:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C727464
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201825; cv=none; b=W6p6X2WtAfL1Cyhd4sv5A1Ipi5Gvn8SY5g+H3Lu0xvhgSFU1Pc75SBRv92s3CriOjEi1FOQYgm/A3Q4rnO8/AyYAh+w2D7RXfFVxJn7s7rV5ud8HVJdwyd72ySkCsPNpOnJ+/Xvo/WkQ43LGgP8AKj637t1ID1/QPnhDbn/b7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201825; c=relaxed/simple;
	bh=Ve/T7iRtyGZXu535IGCbAILZSyBmoufUyqUyNP5viMk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oolxaqvKAhhNCAUtzRBv8v7Sw3CcAh7mxWBXEBq8bDdfdYwxu2z39XyWUhB6zlPTS2zq7TljtfxwHH4JTrgUhuBR2ujMUkwt0UiRK8/t1y+Fzpj5FvgN0pm/ih/nT0DrUpUhWTZIaSV7u32tXbl92Bxz6TKWxR1H6yYLinmUmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4ee7817b3so26197665ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201823; x=1730806623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dM2lgnHTRXyr4BSRIoO9tHi9P/rFe55ozJ8KLwxJlB0=;
        b=mzVcBmaU5vWve7THPL3up449v99qNXEYuKRa+v08xPAKovML9UXqH7x8aXAKg2mfkV
         vi6yv0kBUCMPVlWDmv4r8NtW+kTLQYvALe/PrfD4Vm84FfH4KiQuALs8/4X3/JAie+pZ
         4d+/0vu80+XspuvlmH4QgiMttBTt7Qna/UhsUDdc5A1T9J2q4NKDrw3LayNANRrZHsbw
         1t76c8a5BSRjeGZo8uMay839Vzz/uQ8UTMdYBZS+5sE8l8dZGaBmGAfW8suKJbgYqDtY
         VYIdgvlgrVSAh3nqf7Z8OkSF2o+IVp/KSQaLwD3C/Dcs247SslEwKCvJnA+xNXJixEz0
         Ou9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ/NQJ6pHBsN/Mp59Ndcwie+MPSlG1TtY0wbJzUDjD/dHO+fjcOb8XIrv2bzrJ7rP8fF9xzcXRttAXJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJzea+NlQ6WogEkg2Qqmt65wsGAt71oqIRa0p7vbTGswW/E+I
	ifjfL+WmZS+v4kdsBNNxeyQjd4Ut+mNK1BYOyJbItNObAhf9M40RiWOkHTFuPt9RQgkqc8iCBGf
	AY9M5ZYvNvy088Jr4VS046KlBWWUJiwpehpBtk8/2nc9Luc4uzkpK7Mo=
X-Google-Smtp-Source: AGHT+IE0544kb11y88W9ylafTtRX7dqt4hxvzZCcSMXBAw4ptQHJbRmXCvfjVNbx43rB5SZMSFnT0vaVN4c3fPG9y4BpzS/37/l7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:3a3:f897:198d with SMTP id
 e9e14a558f8ab-3a4ed2b1887mr105526895ab.14.1730201823136; Tue, 29 Oct 2024
 04:37:03 -0700 (PDT)
Date: Tue, 29 Oct 2024 04:37:03 -0700
In-Reply-To: <c120bafe-224b-4ec8-b622-b90998117851@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720c8df.050a0220.4735a.025a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in ocfs2_file_read_iter
From: syzbot <syzbot+a73e253cca4f0230a5a5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ocfs2/aops.h
patch: **** malformed patch at line 8: diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c




Tested on:

commit:         e42b1a9a Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0a45c444eedcbdb
dashboard link: https://syzkaller.appspot.com/bug?extid=a73e253cca4f0230a5a5
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15db015f980000



Return-Path: <linux-kernel+bounces-419011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BC39D6887
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766D9B21851
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9ED183CA9;
	Sat, 23 Nov 2024 10:02:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3894204B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732356145; cv=none; b=bAFRBSEpsjupeWv+sRCtFQM8Jno85DTewtws5coDeuYFxfxMCaFlOkXvfgkRyOMHjNDll0vdL2Fbtvo8m+ysiYEmSDDvZzNMzl3XZSdljaB097sunZHGpK/0123125IlpMRBgtk6qXwvYQfbag40DnGPYUNcd9+2yoNtw1X1fKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732356145; c=relaxed/simple;
	bh=eIKYcVCQQjJFBkH1lJcvxgr2iA+FCk76ApgQpF0yQlw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XGZzUHJsxYWJOCo03nr4Tv3J06JGXpz2gTOm6P4zsx6DAgkMiOeJy4zUgOxeQkd2VRo3nIlD9qv11kVCLlpBnIjx3pmA1YZ7z2VyWJi7s5Q5CjxDsIvdfaRGnDJKwE2JdfcE8ZcaTYyz8vEiFhS/gSWpqtUCl6F2hB2YlwQNWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a76ba215b2so31124235ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 02:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732356143; x=1732960943;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=se6nHRVLma2x6ELMn9VIGQomPTv3OczUsSGNoxBdl3s=;
        b=nah6RlZD7SnzJpY9tne+G8makuRNH0jc+jRf9XlrYYCjPCU6UD7c5Qc6amqIEGaoeD
         Mw9rMUdzywtU+bfUmsNUwc+ML4D57EtJDscSXF0iKG0RNsCUaRxVNErcDa3kgC/2fLhR
         pspdvP+ftYMBaNSHBpitMLqqkTBtWAqO+9KskWvFC2dKs3DvuG8a1BNPkiuqU4QjqIoC
         D4m2qdRNo0MeKzm9qPAG9i3wAeiS/1qfx4RY502uPPqaXO6gdvu75IVJd5qjP3avyu9S
         /vvtMtvTOvoboYhZdHhgJl6cbcmvNxRhRN8O5PcHGzNG//iv1OPq17lnWzMD5NRVoJC/
         wjBA==
X-Gm-Message-State: AOJu0YxulTJznnlUwccuv2beczDFUcOMpzjoYtVzlPjp2d5mASB/vgdI
	xGtd4iagbltXVTvm3UjJWhbNgQ4MpyJDhZGVlyl7R13EYy80+LtBpNPyAnEeGBYrZd8jX1onkpw
	ZhHjrA8uuhXwmZYvxTE2wP+tnwMgKqiLCBmfCEe7OhGjTwgz9oRZIhRk=
X-Google-Smtp-Source: AGHT+IEFZw7X4VqDou46tA28UccIR9yRsRnvS4wmHsZzCcqCTVT2/cdmvQKE/N6OdTIpVcedJAC3mB3B3UpAXE1iPILHsb6Aa/Af
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:3a7:8720:9de5 with SMTP id
 e9e14a558f8ab-3a79acfb902mr90618525ab.1.1732356143548; Sat, 23 Nov 2024
 02:02:23 -0800 (PST)
Date: Sat, 23 Nov 2024 02:02:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741a82f.050a0220.1cc393.0004.GAE@google.com>
Subject: [syzbot] Monthly lsm report (Nov 2024)
From: syzbot <syzbot+list403996b4777f311516dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 409     No    INFO: task hung in process_measurement (2)
                  https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
<2> 56      Yes   WARNING in current_check_refer_path
                  https://syzkaller.appspot.com/bug?extid=34b68f850391452207df
<3> 29      Yes   KMSAN: uninit-value in ima_add_template_entry (2)
                  https://syzkaller.appspot.com/bug?extid=91ae49e1c1a2634d20c0
<4> 7       Yes   WARNING in get_mode_access
                  https://syzkaller.appspot.com/bug?extid=360866a59e3c80510a62
<5> 2       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


Return-Path: <linux-kernel+bounces-364658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EDC99D78D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246231C2290D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA71CC893;
	Mon, 14 Oct 2024 19:37:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4CC1C8776
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934649; cv=none; b=NsduT5tkc2eOEzqW8RCouXunubu0Cx8mo7U2qNHeDJDrye8G4RgouEy9/uCOuRN5q487ls2OpjDM8SBtK9Gb3c3+MtIKsjtMjwfWUrvNiBuYGrzGPcGVW3/kIUL9EwBuMBwrE1O/MXL0VQp+cAF/L0T2BxsbkiB7uiEKMu1UqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934649; c=relaxed/simple;
	bh=dkWprYV06yBPj2Ha6asytNuUnKevf8LMQ5Bu9plBsdQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QZzqe2dMpM4PKholCdlN44PyPUFnF5RystFWL5r9WovA2CTAHMB2nOB9TbL574S2Q3HHltkWXEGjTfpWl30/hI1C8I+eqjV3g89BkHVmq/q4eu0M5T+xDrQ+hb0lusjXqALMXtgIcOKoyykn8pSO7j1Rh79gVxqGHOqAcxugfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so35904845ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934647; x=1729539447;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6zhfEcmvR8LP5RK+N2RnIo+SojN5GzY1Y3M0H1jhJ8=;
        b=qHhYYOox/oRcZT6Bcm3wW9mk8VXs1hRrvcVN1j7hsNr5yW7vSKf21RZHN59xN2iIfB
         TK6TWQrPHPrsoB/3KNumjs7y57ycUlp2YMkLcJYAJhDlh/6ucEKzNjpf/tzO4FzE2avf
         8Slj9OI0m3/c/aiRzDzkIFM+Uj2cn9WoQKlOc+HljdIENmIacGTk2p0gJ2RY1E1453DI
         KJdr8jArJVfrjjO5BQxTo2jOJBk8qSYtkBE/w69Sfvk9bi/omN4Wom/G2zDsD8uwCzb7
         AKK5JLKKQv/FaUIGNq8QcEOIQpwwFqzP6Q7N7lZv7SHK+3iEGkWAZoskbst835NdCHWr
         DcyA==
X-Forwarded-Encrypted: i=1; AJvYcCVBHQZOv9RaZ+Hi6vrb3tRAQIGInFiycNgZGK1SKyXiQcVNP6VYU60PdPOUPCpWFeBPZ+gztbf09DIcHS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU+S8TVtMMpacbxTo31xqcj4dg8bIiLb6jkCb2TYMmTvCu+eeN
	wLLGpNpe4pD/HhPkXfBCfSXWhWgkcYWbqiKDemrlj/OjjTDPdZqhrWnkdyL6jI1REblv106L6dl
	E8+rhPuKEwQV4+sfJ3Y0TFrkg83JjLEFnhWUwfvEtgTHt3bFZit8tlzs=
X-Google-Smtp-Source: AGHT+IGKwTJp0LfjG357DzLfqB9veonEo++LAW2nl8riHWqn/umiza2bLxlvwyRdvGk5DLnw4oRolR1EktgSsZsFliZ03tnrf4LQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:3a0:aa6c:8a51 with SMTP id
 e9e14a558f8ab-3a3b5f294b4mr90390205ab.8.1728934647042; Mon, 14 Oct 2024
 12:37:27 -0700 (PDT)
Date: Mon, 14 Oct 2024 12:37:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d72f7.050a0220.3e960.00da.GAE@google.com>
Subject: [syzbot] Monthly hams report (Oct 2024)
From: syzbot <syzbot+list35935b20563268355f33@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1181    Yes   WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<2> 334     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<3> 18      Yes   KMSAN: uninit-value in nr_route_frame
                  https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


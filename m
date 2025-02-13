Return-Path: <linux-kernel+bounces-512917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC87A33F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751BC188C70D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624AE221729;
	Thu, 13 Feb 2025 12:34:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824020D4F0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450066; cv=none; b=DMtb71LOXOG0gCQ81DmS+5TTnQ8DEU4DWzKBoA9KxxLuFtbWQ7uralCxkKidtWL11RoTUYGGXkCgis0K7tSrV/eMRvBfnSTOAbF9ivI2azTrAw4UW+Io5mPwpK6SySTNWhK5uUAlPT8dgZ6V7Qu4oTd2KWP1KE/KGBdm9h72Eag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450066; c=relaxed/simple;
	bh=ePBw36xOQ9kV2kk6Q8SBQyHHmbT6ZlhvGX8MnQsLOfQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TKHrb0YS8zuUtPReWdXNWjIzCe/s/TU8Zvn4/+zOkgtVD9q9Bvub2V9sLVjqPMzFy0kuDIiPgZDCyCA6VqSxqRnD7dKKBQMDH4zSemOiQztxLzCpJdE+ud+lTlj6WfsmkUJwbVx3Z98hohUvCKOoQ8BB4239x0r9HWCxsCd+aG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce7a0ec1easo4778665ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739450063; x=1740054863;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWhPb7k4w08B3afNYcRqEv3V9whBDzgEmIzDh912tx0=;
        b=q7pJ7kG02j0U43udzzSxLl2qGM4oHggjtr6beOYtlCrE20+K9bkV9911gWp19sk6E6
         iLDfT1mb3jHWVMQq9odbF2kEKD4RpcAoHpHjJ5TdVPB8eKEPejiBDamg4ikyrgf7YNA3
         xntSkaQLY5YbRnLeMpVl1QqSeBxX2W5ZRNir1Lpswx9Io7I1HvCMhQQYUdfSzaZpUmwB
         0ktuzVv7ZzEe+8635EPQXPheG2uCsKSfiJcgaF9CrQkxR96GE75544WbtJTsfDP9pVmT
         yHE8pKmsSNt254lNCN1I/RBmPsjqWmE74ejIcejOg/OFuQtgEISXVlljZL6VrB4opmAU
         0EYw==
X-Gm-Message-State: AOJu0YxYBNNwpTe2tfb33WTWpN50rjp77zg1oD1rpV5IDj80/sr4JzxQ
	TOUJ0f+7Mvvv+PlosHLz4RUvqPIKY1TjDsVwKjaDb7AYtjpHf2uSBCajYZsgl7QuhP5N3fEOq4m
	xluWRQrv03VndNPtcMPhjT3WDBBUoGWFbuP70PVyliHtHqMtj/ys1k/4=
X-Google-Smtp-Source: AGHT+IGOGymSwQ2QQqFPfP1S9F9q1u4lFGssMmBhhhZK4qhYAZqlNMcClPqYsB2s35iqsUzCqCzSj+4f7i259pQBIACQFcpZL4gX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3889:b0:3d1:79ec:bef2 with SMTP id
 e9e14a558f8ab-3d18c22b107mr24664365ab.6.1739450063488; Thu, 13 Feb 2025
 04:34:23 -0800 (PST)
Date: Thu, 13 Feb 2025 04:34:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ade6cf.050a0220.110943.005c.GAE@google.com>
Subject: [syzbot] Monthly trace report (Feb 2025)
From: syzbot <syzbot+lista00272578215cac56980@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 0 new issues were detected and 1 were fixed.
In total, 15 issues are still open and 42 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1458    Yes   WARNING in format_decode (3)
                  https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
<2> 157     Yes   WARNING in bpf_get_stack_raw_tp
                  https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652
<3> 35      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<4> 29      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<5> 15      Yes   WARNING in get_probe_ref
                  https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
<6> 11      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


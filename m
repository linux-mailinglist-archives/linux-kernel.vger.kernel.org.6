Return-Path: <linux-kernel+bounces-432759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E04D9E4FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C20188063D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15041D416A;
	Thu,  5 Dec 2024 08:38:32 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846771B1D65
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387912; cv=none; b=POAUAVdNSFsfGXZJpXtJnjU9VK2EnjTXzlyso7jXn6haDc452z7ZmFpNtT77Fvwex9db8FC1VWGaJQoJR2sRhMwTT5yIMoP8GLoT+wUHVOgJrWENxwGlmvZgf6wIq0Zi4tnTYNjAoTgN3qh1oNlHMNYoiXwreBJEUeN+lya6Av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387912; c=relaxed/simple;
	bh=jLVygDBn1jJJDyI/td3pC8phqo6G5Rh3oqfY0tTBHqQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z5bu2kXxG8arDWgnDxSus6AoqqeERluSGEyQyKsdXLixqqklM5TKr8mpZPlrA7XmKlUpK/O3wJIeKg6Jjh9Umh9Qau808GtML5P6iC17gWseUDWr7BKto30BB4LGIlMgfoh56/Mk/un9L/NBc1FD87PtcPMjiAjJZAD67PqHvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso11610565ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387909; x=1733992709;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P36ZWJkqqA4FzcSAHHFTCrGAELr3+Ab1FBfvulbueYs=;
        b=GCUuGoGFu1zZzL9Sy2PKMHvuRZhPn8hMGeQlYWW3VRVeoYHabDAAO/xol4Xt1xISy4
         dtcNb6HP3HKAKoknA0GmaYe+8kqvDNGYt+i8QrElGpuVHBJnJUgmF3mBlu3+4tM67CEM
         Vjev2EotaGHbnncnEmHqlmxXA20WzI5JfctE9geqjHJCOlIhE5kgvSjjO4QDy9jhP1Si
         n3yTWB4aAXBB513h9gzqLaaBMWqrolo2AiZW8AmlUWHq3ntvB4mgP26D9BVmGXyKpu41
         LSxRm4QHpRx++Vah8cKA0i/rVpRQ8qMKUOu+A7USPgmeekcWEFQ/1Ms2g3FmuSHTEm6I
         FguA==
X-Gm-Message-State: AOJu0YxEGcTvs96glr53J/pPNZh43DzkQXq4cFsfI3D+Gkcx/yGKNmT1
	DrIMg3pdgpdaNcWJXoWH3fkBhlfTDbwlGgEiAaUPjd52hezieh40NhAxfaTGprAALu9BJdfP4Kc
	EpwF+afD4V94kG8VDd8j6ANLQz3ufHeDA6mvdTCA/nYgteKXq5LyEpRV8eg==
X-Google-Smtp-Source: AGHT+IGllrQa8Bh7YlaJ9RqR1e/cRBqRSCMp39seAQ1rs/zvYKzJlu34uDgByEZec0OlsjYdZT68LfuUKSNLAdd1YAVoIsyJjLlm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b03:b0:3a7:6e72:fbb3 with SMTP id
 e9e14a558f8ab-3a7fecb13bfmr85351905ab.4.1733387909675; Thu, 05 Dec 2024
 00:38:29 -0800 (PST)
Date: Thu, 05 Dec 2024 00:38:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516685.050a0220.17bd51.008c.GAE@google.com>
Subject: [syzbot] WARNING: `SYZ.NUM.NUM' USES NUM-BIT CAPABILITIES (LEGACY
 SUPPORT IN USE)
From: syzbot <syzbot+b3c08bda38b11fb7a6a0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D125da330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6851fe4f6179203=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3Db3c08bda38b11fb7a=
6a0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7fe=
b34a89c2a/non_bootable_disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9751e7030ea/vmlinux-=
feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f7bf928b44d6/bzI=
mage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+b3c08bda38b11fb7a6a0@syzkaller.appspotmail.com

DEC  4 15:29:08 SYZKALLER KERN.INFO KERNEL: [   77.863093][    T8] IPVS: ST=
ARTING ESTIMATOR THREAD 0...
DEC  4 15:29:08 SYZKALLER KERN.INFO KERNEL: [   77.897775][ T8011] CAPABILI=
TY: WARNING: `SYZ.2.644' USES 32-BIT CAPABILITIES (LEGACY SUPPORT IN USE)
DEC  4 15:29:08 SYZKALLER KERN.INFO KERNEL: [   77.956610][ T8007] IPVS: US=
ING MAX 39 ESTS PER CHAIN, 93600 PER KTHREAD
DEC  4 15:29:09 SYZKALLER KERN.WARN KERNEL: [   77.991570][ T8023] SELINUX:=
 UNRECOGNIZED NETLINK MESSAGE: PROTOCOL=3D0 NLMSG_TYPE=3D0 SCLASS=3DNETLINK=
_ROUTE_SOCKET PID=3D8023 COMM=3DSYZ.0.647
DEC  4 15:29:14 SYZKALLER DAEMON.ERR DHCPCD[8024]: PS_BPF_START_BPF: BPF_OP=
EN: INVALID ARGUMENT
DEC  4 15:29:14 SYZKALLER DAEMON.ERR DHCPCD[8024]: PS_ROOT_RECVMSG: INVALID=
 ARGUMENT
DEC  4 15:29:14 SYZKALLER KERN.WARN KERNEL: [   83.080206][   T39] KAUDITD_=
PRINTK_SKB: 1103 CALLBACKS SUPPRESSED
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.080219][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.083:3132): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.105246][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.103:3133): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.124798][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.123:3134): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.147813][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.143:3135): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.196065][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.193:3136): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.239782][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.243:3137): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.291565][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.293:3138): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.332978][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.333:3139): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.373209][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.373:3140): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:14 SYZKALLER KERN.NOTICE KERNEL: [   83.411641][   T39] AUDIT:=
 TYPE=3D1400 AUDIT(1733326154.413:3141): AVC:  DENIED  { READ } FOR  PID=3D=
5331 COMM=3D"SYSLOGD" NAME=3D"LOG" DEV=3D"SDA1" INO=3D1915 SCONTEXT=3DSYSTE=
M_U:SYSTEM_R:SYSLOGD_T TCONTEXT=3DSYSTEM_U:OBJECT_R:VAR_T TCLASS=3D
DEC  4 15:29:15 SYZKALLER DAEMON.ERR DHCPCD[8025]: PS_BPF_START_BPF: BPF_OP=
EN: INVALID ARGUMENT
DEC  4 15:29:15 SYZKALLER DAEMON.ERR DHCPCD[8025]: PS_ROOT_RECVMSG: INVALID=
 ARGUMENT
DEC  4 15:29:16 SYZKALLER DAEMON.ERR DHCPCD[8026]: PS_BPF_START_BPF: BPF_OP=
EN: INVALID ARGUMENT
DEC  4 15:29:16 SYZKALLER DAEMON.ERR DHCPCD[8026]: PS_ROOT_RECVMSG: INVALID=
 ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8027]: PS_BPF_START_BPF: BPF_OP=
EN: INVALID ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8027]: PS_ROOT_RECVMSG: INVALID=
 ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8028]: PS_BPF_START_BPF: BPF_OP=
EN: INVALID ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8028]: PS_ROOT_RECVMSG: INVALID=
 ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8029]: PS_BPF_START_BPF: BPF_OP=
EN: INVALID ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8029]: PS_ROOT_RECVMSG: INVALID=
 ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8030]: PS_BPF_START_BPF: BPF_OP=
EN: INVALID ARGUMENT
DEC  4 15:29:17 SYZKALLER DAEMON.ERR DHCPCD[8030]: PS_ROOT_RECVMSG: INVALID=
 ARGUMENT


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


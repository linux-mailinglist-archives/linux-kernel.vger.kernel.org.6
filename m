Return-Path: <linux-kernel+bounces-196369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDAB8D5AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B81C21F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FF80055;
	Fri, 31 May 2024 06:50:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509112E68
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138234; cv=none; b=iaEtdaTsTnvvJKCIRL63SZicG0ULYuHe4tp6tdtWYlYSYOONYvsdHP1RIdCnPCROUrwUdMy+52rnMUz4HOnbJO14nhsUjrGspgf4W3KBML0xMuVEm+Z75vtnPdS6sYwurkdvoR5Kn18o4XiO9MAbcM/MlTLHWox6AcZ9yf8JbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138234; c=relaxed/simple;
	bh=gGJbGSR/N792/+vRgnYR6DcUVCVb0sPywL2SKvw7uM4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a3c3ItvTiPsAFe8R93UlJYuo6UaxEgwRWMnESQQEBW7Q0doUTc5DEhNqWkF96WHFe2xADgoNKPD4/tFhYH6dM2CMGm1XErAnJTRtKWkrkVMla5L2ZmIoqsv7DAbdUK5no3A3669SznjM6o3yO7ImJjp3VAIvJA3GvYF2Z8EGVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ead3d6a782so168251239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138232; x=1717743032;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sc3g6UrT7A597ALx3U+UBitjnNHUSqXI6PnX1pUGuyY=;
        b=D6T1BmJuKPzL7c+nJHDgzZd3vPT9UvNKFuV8Ch96ApXIUi7M9Cx/HUZFYWdLhn+T3F
         9oSSgbF5lObD1yCA4md2kLGGz+NmprDZ/7bgofkehpvTBfrNYTpeKf5xd28VjO266sgd
         yjW2NiD/3frcD2EYC43/B66nfi8ojM3XDFSDa4ItrNfGm6TlBPQnkd13O+ZeJthUUhvU
         K48YuY7Qq4cJha80vJviqjEbs0jQL4ugOzKzh2mo4qvcxX8D1aTipbW0yp+2KvJB7Zxw
         f8qcUpJLsVIRprXUBP4YA09QTJM4djiSdnY+OmYjS9EOaiHZEKhzvg2o+0M/h69gSaIz
         EFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Nq8UYGvFsrpsJXQ2ECQsNOevp4/mAL51laCXebFSB9T6VesoYI5yC42qHrjRvGmpQNmsnXQTKT3XICg7OftoeZLKPNYDhTkHnVrv
X-Gm-Message-State: AOJu0YxonLoqWjoOy+im8gerEuqhDn2+s9QxGE0Ff6/3KnDOLAo3JaMW
	+gHq5rjj5O3jLn5CYRnQLCE2LdwnzMf/ihVsMQCL03pNwVhjxtmWbu2UIfT96l/iTgu5AdcbSFH
	W3NiYPfS32ZcWT7palArA+NgLTWWRYUgQADRL19CvRGB4OhQ/4/vvuQI=
X-Google-Smtp-Source: AGHT+IGRw2pGtokGfiME5cOoy8yKiVDV/WEdK6bjoNiudvtCaj3JkZL12jBJXIL+P3s/iKgQmU2Stg1M/+/RqxSqyyB2+9bQcuTQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f95:b0:7da:19cb:1c7f with SMTP id
 ca18e2360f4ac-7eaffdd311cmr8146439f.0.1717138232252; Thu, 30 May 2024
 23:50:32 -0700 (PDT)
Date: Thu, 30 May 2024 23:50:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d24800619ba6690@google.com>
Subject: [syzbot] Monthly arm report (May 2024)
From: syzbot <syzbot+list78cd9cc56f271304ce72@syzkaller.appspotmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello arm maintainers/developers,

This is a 31-day syzbot report for the arm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/arm

During the period, 3 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 4 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 737     Yes   INFO: task hung in lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<2> 46      No    WARNING in delayed_work_timer_fn
                  https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
<3> 38      Yes   BUG: unable to handle kernel paging request in trans_pgd_create_copy
                  https://syzkaller.appspot.com/bug?extid=2d1f5a94167d430a3bd7
<4> 2       Yes   KASAN: slab-use-after-free Read in neon_poly1305_update
                  https://syzkaller.appspot.com/bug?extid=6d3021bf0c4cb4ffac17

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


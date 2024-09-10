Return-Path: <linux-kernel+bounces-323716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4A97426A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD07EB219A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F901A4F36;
	Tue, 10 Sep 2024 18:43:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE77195FF0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993785; cv=none; b=kDlf3V3uV/XtyakVw+BznH1yzkXJ3FT1Y7ry18TW+xsKvq7S8wmwwPmek1memmEqC12cIvNbBpgO2M0kWYuSWHhE+zGpzBIYHA5qZZzB3SypWIiMDzePGamiW9EHjKEksuClFlu7qYCRM+O+F+V7tB/Ix4+TlIJOenbMFrZVKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993785; c=relaxed/simple;
	bh=QJz2+qd9pwzdqTsO888vAe1TULrvaPskQI/SG+nCCEQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dx+j/eexK/6cOja1B6bGQffHE59Xs2phBL1/E+PNS3n+yqvxdf87T8v07yywo6UJMOVPWwmyzBXCFBaJFZBfmSPZ6wKFlF8cfBZUEViV25sD8j297S3VwBMqsAkIVxPq/1TDW7vj/7xaoVa8dIMOlgEGLwOyAEc8BCnKGPzsvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a047cb2e7dso19485085ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993783; x=1726598583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLBAk3ypWdU8hGWOq8zDO/0cDlT1FvBQWx+mS/lVnI4=;
        b=kR+VhWIRHeTB1VwnkKQLV3xMWlhCstZq1ZUWTwPXRqdGjDhdLampyPTTnLztJz9oD8
         Ae7GqKmT5yo+IPQUpPAg7pPASb/Y7TrFTFmsIPNM/t8jW9H9Dgo35ZoPaNYd5MnaKlcT
         v7fAoED426vrJN0UE3Vv3lwDc7BS6etA+pypDpmf9z1Slfreyem+3jLqvDuOb+53swhg
         +gW8tIIkaXWpl2lBeSMYZsjbY1T/kdW7+GDoCwOVwl4xSCAdiR74D+fg5XNUua7Bu4l2
         wo9YYn+4gHwEs1yXHhyuNjuC3GskxargZ6EItd0kKAS/ccGNwCyBGkTlWxoZk652w934
         SM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPSV7ucQ4u/PePksDUDInFfwrMcftQWYG68Z0ivlZ+XZTwPzVAbkUrnp/Q1LXXTTPcO4w48j6ISDFk/8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2PyWE7wf6F3gmRV5X43b/ESlNEGwG80yDoO279A+L9Xnt/Kb1
	55QbKlXuwVmqeWmZE8rc8YFIwaw1YWAN2ilr8nNQAtMZRc8J7V3OJspUjOQUqJtRqJTrGVbEBuP
	GFdPZFR5/ykgz9hKO3TBzoLmAwf1XgNHT3sCrlI2pDvhSYGiuwgYCED0=
X-Google-Smtp-Source: AGHT+IG7GcQYG1RoCoerkBdfw2Sd5+jf8sy9YrgrCZJM2ThdZn0e3G8MdGnv1is+AGVrLtEfbfbGSdpYxxTicFF6bkfT3u7PzbOX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:39d:254c:ece5 with SMTP id
 e9e14a558f8ab-3a074296270mr9157985ab.16.1725993783232; Tue, 10 Sep 2024
 11:43:03 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:43:03 -0700
In-Reply-To: <000000000000d8f51a061ba88d22@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000559c060621c83e97@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5af1f84ed13a416297ab9ced7537f4d5ae7f329a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Aug 3 18:04:51 2023 +0000

    Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12477bc7980000
start commit:   788220eee30d Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11477bc7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16477bc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11da6f29980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1304189f980000

Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Fixes: 5af1f84ed13a ("Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


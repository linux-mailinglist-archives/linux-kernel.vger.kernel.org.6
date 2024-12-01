Return-Path: <linux-kernel+bounces-426725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CD89DF708
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5AB2816B1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9F1D86EC;
	Sun,  1 Dec 2024 20:03:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1974D8A3
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733083387; cv=none; b=Eq0Iupa3LEhmJz30aY3iPrGLPxhtG3IIVtCW306Sm5UtoPlMHAc0hNZ7bVIjbo5duCTSyFgmeah4VomNHV31HC4EItwa9oab7MyZjmZpON5nP9lIIoDaVzWC2ToZOpF25yF75ofNEMsF18p+l6UmdVSsXEtC4ba+D+NZIqFg1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733083387; c=relaxed/simple;
	bh=dSsObhGUS8r1GhwLvZW7tZZh6u1pc/CKc749V17IzvY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jO031V3/rQYpkEHuVW7rD6QUik5ykqKYfEvroBrBQPnxLZDIImJ+ATZYXQxS9AI2/OZoKKIgM8WUECAVJa63/gOPdUm7GAAJybVTXmaq4PG001WgnLRoR2x1QWmk+ayi2Sl5uBFrL/4urLwbZoy/qjq1ThhnzXxhS+4DtJ64LaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso18462065ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 12:03:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733083385; x=1733688185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaPPX1s8VAm+XGS2IFc62d3wok0VBUCA33fGXk3UaTo=;
        b=XLFsyhJpbTObGvl9YjVJVUxJEeauLA4o1BjectpBBSWCVSvtglq5kLuZfNmuqNZfz7
         dbe2GpKtfFqJYbQPCI4fpQ4/SQjYmOmxV7D/fvf3swHb8dkJHBMepUdJuL+/hKQJzfI3
         vP38zTzP4KOyGrVNOQZCNPwlfqdHNhXJ4v87SRLP9tBWS3FzQSJdCXVOK3Xr52ekyHf4
         Lf2Rto/lpffVuAQ+4IAOGWERCY6K9y8Meyqwlp33S0bCZ0Ys++jqqb2UjeDwW43MTwKR
         5ieu+4v43j05HP2bcJr9OrgXfcmmde8UMjdjZlW4vWiJ7in0unNcA4EeP8pqC1ivvWZc
         8hkg==
X-Forwarded-Encrypted: i=1; AJvYcCVkY2eTqaR0h5Wu7T8iuneS+Q6INNcxf4IxVwGq+cK3F2dJ85YR8hMlTZwy8MAO9mU2OMeP7AQ1tUilDbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwXA8CvMb40s4gHqzJGyn0aV2akpPiz/RgqQmxvrkWUSRMMNY
	19v5w4UM8qCNryfLce3fD/TGTKQeFUL3iNqxe8tX0H5/au8AuaqV2cQ37beaWVlEkkJwBo2yPun
	6sICasZBnull/C2SyKJ8QqDJY63hhboRwHiElUBeAgIbQ19SAL2Fojm8=
X-Google-Smtp-Source: AGHT+IG1BsJDeDY+txAfsLEoO3aZBCIBBviJggagFT7PDbeJHoJDMx+EKxelgiGE9E+lChmAz9PfQRqFKHPAiGfA12SlL2xiBjhn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca07:0:b0:3a7:ca83:3f9 with SMTP id
 e9e14a558f8ab-3a7cbd14e14mr125608935ab.4.1733083385204; Sun, 01 Dec 2024
 12:03:05 -0800 (PST)
Date: Sun, 01 Dec 2024 12:03:05 -0800
In-Reply-To: <6716e2ac.050a0220.1e4b4d.0064.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674cc0f9.050a0220.48a03.0012.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING: locking bug in rcu_pending_exit
From: syzbot <syzbot+8d7226784b8fcb4c9d04@syzkaller.appspotmail.com>
To: anton.ivanov@cambridgegreys.com, axboe@kernel.dk, bp@alien8.de, 
	dave.hansen@linux.intel.com, hch@lst.de, hpa@zytor.com, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5db755fbb1a0de4a4cfd5d5edfaa19853b9c56e6
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri May 31 07:47:56 2024 +0000

    ubd: refactor the interrupt handler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1739bf78580000
start commit:   2ba9f676d0a2 Merge tag 'drm-next-2024-11-29' of https://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14b9bf78580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b9bf78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a857d0dac7fee57c
dashboard link: https://syzkaller.appspot.com/bug?extid=8d7226784b8fcb4c9d04
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1037f9e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155d1d30580000

Reported-by: syzbot+8d7226784b8fcb4c9d04@syzkaller.appspotmail.com
Fixes: 5db755fbb1a0 ("ubd: refactor the interrupt handler")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


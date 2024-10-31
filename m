Return-Path: <linux-kernel+bounces-390950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D0F9B8061
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E70B22642
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F111BCA1B;
	Thu, 31 Oct 2024 16:41:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FFC1BBBD8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392865; cv=none; b=JZqezJiApCLRsVRZ0Cblz3jxiKrmrzaY5jSRIdVgIMl36kPPphXxMqIgLqZvM9xJsmwxofE+jI7RsYlZ8eSYt2xVpB6c0fUGrklmsv1y7Xm1dZW3L/pF53ZHe+ftHcelb2Lq1DkCnOVokMDBh+Dx3F5xlqHU/o7TSFZhduv4SHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392865; c=relaxed/simple;
	bh=+T8lN1gLzbQbrwa76oDCjzsFDN/dUBtdXM0uxc+LlPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ROZTGbhtvgZTHAe3ckzQgZKb0HM6LqmuRVhrPA8EM6y6CinwB5/BPuZpk/KngVefv+7nq3MyM8UmQXiFi/hY9oiPcjzDrpvMi9H6RK3vaaSuEre8bqYWWt8U242VL4C/vSJpQ/XnqjfR3Bs/c0oRRfBxCTGifCeLORAjfgL1EK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so9153455ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392863; x=1730997663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5kf59B9cpnpRcxM0Wk+olT2viW8x/tZqSOwO5xKyJ8=;
        b=tEx2KwGbFxZ+26tNjLwG+0h2oKd/gHu4uDSMcvSWczdyLwloyKC6KVcfz01Z3swPMx
         72h/dcSsqBKZvVFE12QaDGtWEVbe4lPLvUWfD/yT/UmjTKIhJybg7f5b5IMG1zcWIepw
         rLmLNQyYHWLO+vTl80Jwd3R6S8xmqovF/03ww/ibQ9I4WGygi57/veU7MZP8MyNKCve+
         4t1FZ4a5emEKJrlBDckYVW8NCO5ssdSXm9PYX4f2kCnClA43nXfv9IOnTna7PVNkZJa2
         0wtvt4A1yuu+Il0RAVuTn2hiFhRDd8BkVpHFfc0DMoNG+sYZkTc2RUJnmjhBWc86IV0d
         +Llw==
X-Forwarded-Encrypted: i=1; AJvYcCUvAmTEZRevFRD+9mXYmmzJn7C87HJ3aEjHQ4miuryJeKMDepl5X3OCVK7N+tDtGye68CCW8s7cu+tXw60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpKrNLbtaEKzTCwqgq7ri7d2h9G4WoHyPznsdOzaG9FvfmeISX
	AabzlJddTx2V17Y2Av4MGv83krsAY77Wkd+gcy36gOYEBV2DMnLzs9kOvvOF5KLQZQr6brwQiq5
	3HLwKwb5JR1Xn5kUdK8akb7HHlK8u2Ql/fY+Fv882kT8ZTZqr36nBnhE=
X-Google-Smtp-Source: AGHT+IF7vDX78RdpCp96aKe/0IDWhbKJMsM8GMsk5dPvk8HvTRPiy3lCOgNmo7/5JinNDCI88x1azOXCsGSpofcokwYdSk67hVPQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160b:b0:3a4:d94f:5b53 with SMTP id
 e9e14a558f8ab-3a6b0384ea3mr6044505ab.19.1730392862708; Thu, 31 Oct 2024
 09:41:02 -0700 (PDT)
Date: Thu, 31 Oct 2024 09:41:02 -0700
In-Reply-To: <c6b63e97-6839-4beb-bb94-e5914837a041@lucifer.local>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6723b31e.050a0220.35b515.0165.GAE@google.com>
Subject: Re: [syzbot] [mm?] [input?] [usb?] INFO: rcu detected stall in brk (2)
From: syzbot <syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-usb@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com
Tested-by: syzbot+7402e6c8042635c93ead@syzkaller.appspotmail.com

Tested on:

commit:         cffcc47b mm/mlock: set the correct prev on failure
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=1304a630580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6648774f7c39d413
dashboard link: https://syzkaller.appspot.com/bug?extid=7402e6c8042635c93ead
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-335391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E62497E4F0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901C81C20FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591379DC;
	Mon, 23 Sep 2024 03:12:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABDF15D1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727061126; cv=none; b=cn0OW4bIfB5/MjT+WC9u/CmJkSP5qW3Z3yTJpxROU7oU58TRvZXXetezrg2Mk7mItN39jEbyPcXJ/aDWg4WAREz3/3caCSs3fPpm7IzQNKVc15CUZpFLk5JT0z1AJtgdnZNcg1GN8Wy2MXWPflECdkO6SrXvgcZPUwAvmC2KNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727061126; c=relaxed/simple;
	bh=UiDk7CchyH/rlVjD+AjlwAsTaELukHkNHA5+eG3bIno=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fo5jj/f6An1mqvWLBx2EChHCAD/uLFhiQoEJE+ug/tNHY5w8nft9uKtWIMhUF0SWrigKceFTSZ96c00dk+J334EoIM75385FmdwKkZm0eEHavsEvHxgiRAzaX7PFVTKuPtYa27cpeRwUb1eo38JoEwNs1CD5rcxYxEd/6r5uHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aac437083so331457639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 20:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727061124; x=1727665924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMUXi0RdmLy+WqjnhOSGYPK9NupKpP4dbWbiPd/HDSk=;
        b=P42xXEOEwe3tTHT08apEPuY4QkoLzXn5HiEtgt75Pkjh7NXnoJMBFKAyu8DTlaonkH
         8CSaE2+EO/IyJX2wwBmstilMx9Rvlauhdk7go0/tgXKI0wukC9cToMdytArSMYf0LW+t
         06N2JGpzDLpBN6UZsCvuy1+/QeEvKiSgJLBtdw2+8skhPHSF78AuLNxLQsfk40nreSci
         OLCywVQ5mMXf9+21RAzDLjN47ptkuleLV119t2sLnm1jktlnZ1XrJjiP1a7hX4VzDFH9
         GfciSPiAnxOP9zLiUJxVqJdLWLYBpAcPWTPUdZCc3PPItZMXlgRFUEgH+Y+LxFhTY0lk
         BTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9sYXh4SMRYN2JTPYo2HlglkqWkcBrYStzUwpnz8A8RFTaRRlNyBxM4Gfydhuc0iEZGBIbsa7ZVXo2xL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPPaKxHXajJYXLLLmsy6Ag0x52bIZKPFBc4LSzSyPfNWtsMFwt
	Ov1BNdrD/E/Adr7OuTTOABz3CAiJdxvdFE7tk7s9FVSWiLibWHB/tsZPcL2oc07ZJl/VJKVBnCA
	syyJX41JB0MysFf6nIz7qr2n23/IbBDixaWsCLH2RTZf37WG3U7GfhBY=
X-Google-Smtp-Source: AGHT+IGCL90H8XWrGrH2f1VGNR+/I4WV1yMWg2qhTE0U7ngSgbruvUiSmYZXtRtPwjjvZOlVJFrdbfipwTUnz0HjBlVbJKlMCe2/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c261:0:b0:3a0:4d72:7f5e with SMTP id
 e9e14a558f8ab-3a0c8ca4694mr87850785ab.7.1727061124141; Sun, 22 Sep 2024
 20:12:04 -0700 (PDT)
Date: Sun, 22 Sep 2024 20:12:04 -0700
In-Reply-To: <000000000000a41b82060e875721@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f0dc84.050a0220.3eed3.0001.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in signal_wake_up_state
From: syzbot <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@kernel.org, mhocko@suse.com, michael.christie@oracle.com, mst@redhat.com, 
	oleg@redhat.com, pasha.tatashin@soleen.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tandersen@netflix.com, tglx@linutronix.de, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 240a1853b4d2bce51e5cac9ba65cd646152ab6d6
Author: Mike Christie <michael.christie@oracle.com>
Date:   Sat Mar 16 00:47:07 2024 +0000

    kernel: Remove signal hacks for vhost_tasks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13212480580000
start commit:   e88c4cfcb7b8 Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d438f2d77f96cae7c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152442ef180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138c3d30980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: kernel: Remove signal hacks for vhost_tasks

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


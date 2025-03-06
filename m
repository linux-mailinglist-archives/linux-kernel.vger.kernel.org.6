Return-Path: <linux-kernel+bounces-549426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3C9A5526B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46CF616DF14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E525C6EC;
	Thu,  6 Mar 2025 17:09:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AD25A62E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741280944; cv=none; b=QVJs5ioemk7KbdBS/jhGj7oUoxaov3cHyqV5I0bwhgCBbe68+nN2FR4NN1soBBN21VTB4xWD/mRW26frsXiHxQUYfSwfgdJtV/i/mtKNZStNQfA0TNP1gyrSlTqF4PYYwz1lXv4haQ3yF9e5enyS69rONm53GjrdN1RE15XjxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741280944; c=relaxed/simple;
	bh=0S+1lCQx1kTZA4bG5Gj5ODnY9L3DS+L6keI8KNBTmSg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QnzRzYYnB5L7mkx8LoZX+AWMPhlkFj0BoerKEUhL2X09hPtEHvLniuzyq/0IvpBNYfGFOYhPcMYfjVwQ5xhPhwf8Z/NMdGoodTkzb8S2vatQAXD2ZqHjFqQlhPD4TAUL3MPlK/FAbFr2BSmSoNwbbQPIEMuEe5q69tUlIcphzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so18213485ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741280942; x=1741885742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4nLQSw420ybtW2kRIdx22c3Jume3TqtRHI8enXJf+U=;
        b=oqFyZds5/vE7pxaB+ZpqS1GrSNI4bhNCijOA8PzDVkd7JVE3bd8ph0kBiLQtrCoNmO
         MYg1JusiYLRAC+L2Wd2N5hMoPth95Fiw3ZyLidJw2oA81popCtNmrn7MAMVAN4T7mtCD
         nvdMZKADKG97NNIV2D/t1nr39XmiGhboyz9FC02q58YuRB1P3VT7HQz5g973aA2bhoZ2
         DOw7TzjrnYk74N/cksW0ohEpgMNs2O3XKhWbLb95r8hlvqZyFEq02VHHL2ZdyR6Ktl7j
         ObDVbvlWrpWp5i8nyaifrxpfDEsXHhNHl4OmWJ57UtYOXxwVqvrTyUeR/sE5LOt91vIf
         TG3w==
X-Forwarded-Encrypted: i=1; AJvYcCVpXSqmbc5CTv0V1CVOIfAnZdXHcmZ4QUhHRC13wtKIb5bER3svxbzS6zzkVPLxNVxT/bbfxiFX2zEbsQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQvUJnRg+Kb1ION5wAqOvuBa1X5ByfGJIB+Nui9RXEZwXxM3k7
	5aMz8+IKj31CjLWjMEp0FtfpJ4pOzTYzS/MAd5nwJD0rfjRSFecY13+K4qHXnuVsNU/G6O1vJ9n
	/qyVZcFDN5fG0NNTPPMPWDINKoUjWCaExuGCh929rDF0xO5a6TyJuynw=
X-Google-Smtp-Source: AGHT+IFSlWmY7RBkXfYTHzez26gr6XDSYt6SfsTmGP6W7py0kz6AjDNq7sw0S4nAJBjatKuGiYVt1jXM0SDBO0SDA13G1X6sS3jC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:3d0:4c9c:965f with SMTP id
 e9e14a558f8ab-3d441a13ademr3387865ab.20.1741280941982; Thu, 06 Mar 2025
 09:09:01 -0800 (PST)
Date: Thu, 06 Mar 2025 09:09:01 -0800
In-Reply-To: <674db1c7.050a0220.ad585.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c9d6ad.050a0220.15b4b9.0039.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in vfs_unlink (5)
From: syzbot <syzbot+6983c03a6a28616e362f@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, andy.wu@sony.com, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.cz, 
	kent.overstreet@linux.dev, linkinjeon@kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, viro@zeniv.linux.org.uk, 
	wataru.aoyama@sony.com, x86@kernel.org, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f55c096f62f100aa9f5f48d86e1b6846ecbd67e7
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Tue May 30 09:35:00 2023 +0000

    exfat: do not zero the extended part

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1356fda8580000
start commit:   bb2281fb05e5 Merge tag 'x86_microcode_for_v6.14_rc6' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d6fda8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1756fda8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12cf7078580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10197da8580000

Reported-by: syzbot+6983c03a6a28616e362f@syzkaller.appspotmail.com
Fixes: f55c096f62f1 ("exfat: do not zero the extended part")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


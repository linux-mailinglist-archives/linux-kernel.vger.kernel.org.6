Return-Path: <linux-kernel+bounces-399612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB329C0196
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E36B1C21C92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBC1E7658;
	Thu,  7 Nov 2024 09:53:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72A1E5712
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973185; cv=none; b=aNrCvMzxFNfWjZ1g0mX2oAu0XKEtu/GMNcGaEsYQ1/dow4qZvQ+gHhjqmlwaWtAGniuS7h7vpCoEIIv/4i9MwDYGA0CV0bmQW5+Cqqg4RZ5T2OFc6K4FBalvdzAxJHxljVg1tmjRCegnvSzJu6nKLgCz15eVghYsMLrwvVCbNyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973185; c=relaxed/simple;
	bh=XMDBIwYQPHd5R9vNyekV6iYp1B/CaSl+IarBgLeMKVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FfV23fYUkHKhbn5y4Vgcd3fFKMlLF9/JYqhFVmDmzOk4TskzuNZNAlm5OBYEciXLaGnV1zijl01EYZ3NKBJG7HIac4rbgPljfZcGtlrFMpWoQoHrpO7WtwMCW8uJusb7TFhukf7B5yJ5M/wlTeItelPaW+wM8IJGqOjFW/uu8AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so8984415ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 01:53:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973183; x=1731577983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXKnU3fR/5+OR/SypBfoX+HPT3kYxkoDPoQi2n6BjU4=;
        b=IwnloTlnSBP4Lp3wq3IHj0aOABWudLqTjA4jOE16V0yqjMDt48pfcRoIko4Yg3eVps
         Ev5GZ13GnXZQp4ML9evr7GRdBPaa5eUNlYzP4K7gNitNvJjMo+Riw8wLWEuDNTqpsiqo
         O5EAstovmO2GM4giFxSJ3OkGQKAlxqaC9t0prRIEN5srT2lZ9aDhb380xTaD+Dzn7AUe
         FdRBpxEa7ZT1tPGF3gUSjFNOc2kuGf5NW2BvQit73nFpRSAWPgCudQL/k0uanzVEBIjN
         44agi+Ys1riOsjLVDUdjLd/KqNmmsjnHPMcgofuBRAlPC2XQ90cdWeIKuC0TOCEu1b8H
         LOVg==
X-Gm-Message-State: AOJu0YzYtOAA02PmJL8ipQMSsYxgM5O1YgMA8EVvpHtidgrwG7xbQyFB
	EZtEqRCcNU+uIJYQfN7oowD0MCAwU7/1V7ED9WAZUZoWGH8HVEGcYInz/yw29SDoh+pqqtixOsf
	dHTdsYsFXDSIVsZ8mDjdn/OV4OTiDvDY/F1RMNqXffJrH5kF4zCL7w0U=
X-Google-Smtp-Source: AGHT+IHmtmFU6faUropQaLtHq5hsNsjBvGNoAaUDecIB/auxcoEm67KbRmeFY7NAEmBYucO8xv6pzDo0LSteFTIzsaScLTK2act9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3a0:9cd5:92f7 with SMTP id
 e9e14a558f8ab-3a6b0384e88mr251728705ab.17.1730973183339; Thu, 07 Nov 2024
 01:53:03 -0800 (PST)
Date: Thu, 07 Nov 2024 01:53:03 -0800
In-Reply-To: <20241107093553.135565-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c8dff.050a0220.49393.0176.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel panic: corrupted stack end in corrupted

subreq: ffff88802e249680, 1async: 0, r: ffff888023be2d80, transed: 4096, sub req length: 16777088, retry times: 47, subreq consume: 0, subreq list empty: 0, netfs_read_subreq_terminated
subreq: ffff88802e249680, err: 0, total: 0, transfed: 4096, v9fs_issue_read
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 1 UID: 0 PID: 19770 Comm: syz.0.14673 Not tainted 6.12.0-rc6-syzkaller-gff7afaeca1a1-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>


Tested on:

commit:         ff7afaec Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1195bd5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b00ea7980000



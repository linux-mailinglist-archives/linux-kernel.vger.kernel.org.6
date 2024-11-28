Return-Path: <linux-kernel+bounces-424859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F97C9DBA5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0390B23418
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7F01A9B2F;
	Thu, 28 Nov 2024 15:19:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17DB199253
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807145; cv=none; b=DZucQdUoBgVOTV+0HdA4NHhJbQbA8pT4MrMWt/Lqp3Nfxlh9ErO4i0xTRnF1HPcUXTcAxvnKhc9fKo19lVlxfRNbax/2LSW6+GBCWpk/jIWQ1R0O82XVVJkbcfkRpczJIVrqXmI4qZRhtrB/sXqSm2IlNyLp22SeKyXmqn7T1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807145; c=relaxed/simple;
	bh=Bg2AOzz6Q2ajwSSSOm+D8LiI76zEynE1xpkVqyC8LdE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mOTeD8AY8bd/guvBFCFsjTD0iYPyccEtUv/dre6dq1jiVxKP0DZrA9reLxREhPy4dq+lEN9P7KaMKBnR5dVMTJVzUXIco4i9w1/9vqc2MR3AbAKskf+FllnZVMB2Fc0l+vLDrGtNcVs5dy2PT11T+PRhI1I3efuzvZsYtZEAxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8419aa81d6aso73885239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732807143; x=1733411943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khP65dqifF17oRSR9jBugIaYZGtwT4nQ2geEa+vkDf4=;
        b=EXLjCjeUPgc7caa7Nt2V/Q6CWMRPVfkcgshvVAconZhGjluz7lzQJzYLoeGdN1tkQi
         XpytLIQtf4ScBA/T6uCK8hNFNIQQK8luFiMTp5PvtQ24/Nsrs7nnno8VGw4zr2t1K2Qz
         elions9GnYKk+qF6kKiTIs7EeiKGu1IusaXgvbbV3ToRowkv/et0estDy//khzQ21Z88
         rtJttqkAbDGvDyhhrIT5pAPzCJGkSS2h2OGjwv4/WUogliJULzFMMta4CeaYqBeBbNZe
         Xt0arbYUCV3qqoFSJIQKetlZIA2Kn+WnLNbTmYsVWea4HfMLB4RPqNeFatmxNDF8hhf9
         LFJw==
X-Forwarded-Encrypted: i=1; AJvYcCWbwQNcMHvyV2BCte2G9P5bAhf8TDkU0E5HU8VBjA7Pa0q+HNLNnIXgcQo+KGfVd8Z+VL3Hmqz8iQTpRrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TIYThwoJf8ds4iewXaz3FkYGwW0Ko/onTa0nLLn/gse0f50t
	wbDRUa8EermcDa61JZFGvCspp1B/TYS9lbzZ/FJ2ukC9vGx/9zqnsydF4ZPpQ0wPwRVZ9VcHwPr
	ftcIQQpzKUDFj4RtfjZn1Tt5DQ9UGrMPSUmfxMdOU3qDNEnilovROGuk=
X-Google-Smtp-Source: AGHT+IHE+etgiWaFQHshnhqwlvmlD5lYei9zdL3Kj2TztZ3FFLbA7zNE91PmEDsfiPM2IKw4IbZQGnykvixPv4oFV72pEGCf5ccF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3a7c552677amr88926105ab.5.1732807143226; Thu, 28 Nov 2024
 07:19:03 -0800 (PST)
Date: Thu, 28 Nov 2024 07:19:03 -0800
In-Reply-To: <20241128144314.KVCl8%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674889e7.050a0220.253251.0089.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] KMSAN: uninit-value in gfs2_quota_init (2)
From: syzbot <syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com
Tested-by: syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com

Tested on:

commit:         b86545e0 Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16544f78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4aa348d53e96cc1
dashboard link: https://syzkaller.appspot.com/bug?extid=9fb37b567267511a9e11
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111463c0580000

Note: testing is done by a robot and is best-effort only.


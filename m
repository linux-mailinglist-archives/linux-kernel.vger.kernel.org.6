Return-Path: <linux-kernel+bounces-346877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5474398CA20
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66617B22C31
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37517464;
	Wed,  2 Oct 2024 00:44:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C01539A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829844; cv=none; b=jSl4jmlYYtSzaZTTneEmmNprwhrYz3iShV/ZZfzLMuN0zRUSlwBP4OP8f3YgezMM75qKVnvezg+Yj8V92peQ5/j3hFCCExX/+unQw32wzSXDdVYUXSXkJ/wU+vzOgpLuK8f4dWE6tiORLdkU/JPYHHD/VMdtpStQzDe9XQ9/Iz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829844; c=relaxed/simple;
	bh=hLNid/QMxiwHeFdrhKCKS5jCIRCMAF0RUMFZdJ+lEUo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PhkPS5Ji//o1UIFZi3nj7AEcSGDUY/DjJc2KtAKwpe8lb8xnVP3KyxrV+t2+9hJM3r3S/un0QbcC3e1FH1nXa8fZL1KrEx00l+kjz9YOS6oZnscCN0Vboy8cyup2tPuB5bCeVO/kAz9+HIJDwMPbOKKp0uuR9I57Izwae/uJ25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso3596505ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 17:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727829842; x=1728434642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpCdUVBu5kPAfuQEh17nsKijrGPNGT4FzTeZ37CCXzA=;
        b=CgULf87JlsbR9XVfCEu34SHGQwqimzO2sjb4Tv+bxlAbeLJnsRDBcmGQWMpZz5Sjvb
         JCTYU54/s71looq227Kqy2c2V6KIpu3jWA/z0hv/6WRiFrSWZgWrgdShi6iknYBW1rgP
         j2aawESMbM1cONRS8J60GmRT9hXjMq7g4rIlvphGbr6LGr5wR5VrxeoyRUsODHgG1V3q
         LHbmwUWO8iSKxmk8SqTDeCErnDEMd92K7mDynMgbbkS9vSBFHowKl7BpwFJjLyhSDQbc
         MILE5thgj43+JuxmV+dTGwbcYlDpFxYwAjlaG5GpNwTYLn13127MFzseKspOBpbxlpZz
         cXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz5icE15sqK81whkBDk0B9JcJa/foEFGlorWd1lPOOomsXJCs2tgcZ30E7DBhPlx8Juj2Mh/6Qx+T3+u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMynl8EwP2qAE1wz4vLNHoolTBtdf8aSenCB4zmdq6n6ZqH/a5
	CS2F3mSDjQjORCYYq4u2WMUXW0Mdzn/GbVmQXh8g/sNHxOMH7ysT3vnnK45yNNM1wpI8hQN8Qa2
	46nsJVC6sp1noT+iWkKm/2T7BeuG9jY5qtp8Ez5E9eBAxXf6LSa/fInc=
X-Google-Smtp-Source: AGHT+IHBIP0LHG/u9BrXQjP5bcVA/cj/O75aMcdZEZgorjUTVw+RlRQ/Am2N3PtoLY2sLH/cdVqsJ6+6nAMsKLqJsRAAj60lIaUW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:3a0:9238:d3c with SMTP id
 e9e14a558f8ab-3a3655ffb5fmr12592675ab.3.1727829842245; Tue, 01 Oct 2024
 17:44:02 -0700 (PDT)
Date: Tue, 01 Oct 2024 17:44:02 -0700
In-Reply-To: <CAGiJo8TV9=biSzsVUHLrdUq8A2fk_DDue-05ELTPUV7MHmdoxg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc9752.050a0220.f28ec.04dd.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Tested-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145f2580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1fd45f2013d812f
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1516939f980000

Note: testing is done by a robot and is best-effort only.


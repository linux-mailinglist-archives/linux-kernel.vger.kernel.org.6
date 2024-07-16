Return-Path: <linux-kernel+bounces-253702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2943B93258B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D925D2887BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E3E1990CE;
	Tue, 16 Jul 2024 11:25:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7907CF16
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129105; cv=none; b=i29ZGS6P/CB58MubI2JpEbpq7/06receyuFXZW1HnJNUJrRn1dp9Xx2OwkwLySUhY7rUwzdZY9Zxhzr9siD6iBMVHiYWTacrEQyLdVYjq97kK95InqPPDwsykr7mSPGHKcVkpRvJ8sBQidIc/rbAeH0lgBJ4bk0QY6m3DFAMfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129105; c=relaxed/simple;
	bh=fU+0QWuvzFMOwbGG9mtgnYs01JSXrEnfIdqKMlVAkcU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SERiTJmHt32AbvT5amhUXtQaKgD/EDSKO1w6Gzen0a3YCm2++TVFn3AENuonFTny+5Nyjw+d12lMoKNx/6jKfCWJKHpMwba801+6E3Q5FS4/PRGaMVCaES/fpAmIn+3UDrQCNoZitSYgg1SQiTqeNsl2cm2wDPSPdyT+/O/RqAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so656598039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129103; x=1721733903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOrsMjVn3DWq/rhbiMm7+uu7hIq6TYKiEfEAHQkqVLw=;
        b=ieoe7DaNNKTRMKs2KYRTmKdpE2M/7+zid+FJU4jX96EpbRPCW75IYuDkp3dbKUIJbP
         p+6+6Hts7njSW60dCmJm5djkuTIc4xdoWNfhQ3dsWYl5LpLlKEwljDXzlC3SZWY0KM4D
         /FtJwXLfKaFpR+/rk3wfyYIegi2bB8zLiynf6mtCvr5Uqlt5L6b4y7z40xtTNxJWeGxD
         9Boq8A/TVgm81nQF74ui0bliSeZyVJa2z9ZtHDNKP8+ou1RAdyanpG4C83l/qvMs14ds
         9XgN4xjLS0CxG+9/0997bVl4EYFDfvXZu7Nm1jCE/pb4870sdzYbVgJUTuVws1jIhaWN
         PPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxqS2n8d0om2Tkxkg9k81dfifB9+dmx2P6JlraY5fByKO7uXKIFPkVRVumkmIg7060T7Kw/usE4etnPkrVFXD3wzbxoI1CAyAAY+k3
X-Gm-Message-State: AOJu0Yz3E6aMrZVsaEDOasAkeEBTPSnf+hjqfAcLIJnrQlEkGZgPzVzp
	T2x2NztJojszSiSOohZp7Iwc0f22/AxUjrhHxgcQLWM4HToQR6yzQpIYwCTo9vW2K2elg4Oz0PL
	0Ngcz5PGCc1ZGx1eiF6mu8/qa+LwEdFzYVTJB0qopxNjGZQpKvr9Uz1g=
X-Google-Smtp-Source: AGHT+IGypo2PRjAuwgL1uwN4QtMNJHFUx4HmXji2KMSB37gVKuGgINk43XmIycDVqeJW1QmKefPn+hUapFB4eNodm52VX+BtH/Cz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1495:b0:4b9:afd1:d4f8 with SMTP id
 8926c6da1cb9f-4c20461afc9mr115257173.2.1721129103373; Tue, 16 Jul 2024
 04:25:03 -0700 (PDT)
Date: Tue, 16 Jul 2024 04:25:03 -0700
In-Reply-To: <tencent_5FFE6CF02F716D549514EB16EC6ACC3C780A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1c83d061d5b9886@google.com>
Subject: Re: [syzbot] [sound?] [usb?] UBSAN: shift-out-of-bounds in parse_audio_unit
From: syzbot <syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+78d5b129a762182225aa@syzkaller.appspotmail.com

Tested on:

commit:         a19ea421 Merge tag 'platform-drivers-x86-v6.10-6' of g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1606be59980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63b35269462a0e0
dashboard link: https://syzkaller.appspot.com/bug?extid=78d5b129a762182225aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14967149980000

Note: testing is done by a robot and is best-effort only.


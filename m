Return-Path: <linux-kernel+bounces-444406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77C9F0643
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCF5281EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4E1A8F97;
	Fri, 13 Dec 2024 08:23:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5431A8F8A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078187; cv=none; b=owiUR5W81qVeMrLxEUmDxjPMH2hvUUoaEvKnzBRaNkPwtdqyIskjQEvWZRO6fJWjhvx/z7HRpFJvDXx7UNCSNwTtCOZ6ACcY8DRw6Q4FZZ1/yuSdzBHuqbKbeGlWS0jyMV5aNFSO3a73F1Eir/Hh8CR6uuw2886+ae9Igca5bkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078187; c=relaxed/simple;
	bh=jSNbz4w1RnsH9lZjWCrMKo/BVlUNHfe20Q27JoZwBQM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZsjUppJnCn1H8RvaBVRt9Ve2KSgffN/KazKhbmToq+4g1/n3RUqbvb8xVxRu4aqCa++OolaNugJQy44WAUAeiEI1jq7/+OTIMMowk2hgFSG8zY2qPWZrbfjQYX5+baFMpT8dUfK/sugHRP2OHfbXNJA+vvuB+1hxtuiUWvxOaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844dfe8dad5so209698739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734078185; x=1734682985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmT0etUyYtnF74EwDW8OfaDP2mJIR/g0z7goUVA0tFE=;
        b=mJUWPtVNZrT5Cb6uPLyZEDTekFKNDDtJr9ziGorKqPktZkmbAFlu2C+r32QR51FCoB
         1+Lt4Upey3taw5CcbYw/8nly7rG5y2LoiVoc5bZL+1j8DhQDdoMwDvvW9EjzzP6Krrn8
         TB45kw+aOAZRCBNiVkii5gi6hoF/BT2KdVxrwjZ8woJEIa7MlSaO5yEXH3DJuEPwbreV
         CzmaHkft1MKbG/cFEDVIOJxRQbVWItSYNam18m5VoC20cyksgqqwQeFXZU5DX3Q03XgW
         V+gCnhVfr2DtwD2eANdpK4/VjavN8MNW+kY4FuT4iP9kcMNMr9+lgGGP0AuGOhSlmtBu
         vjRw==
X-Forwarded-Encrypted: i=1; AJvYcCWglp9nu0ZJwQX9mVmUKxALjopdnZdD0qWnGoxjsW2CDvlPTMi2rzR1fSI9eHrseag87y90Ld3UH+nyxqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVsWpO+g2BIERA81s1GNdFQNc9GoAx1cqTmezs8SLuVKKjhCk
	KrHOKrqHjho4XQIOLg3WUN98vt3cZb1/rsCNLqReE7NUC0sBucD+5P1MUwGHhO0BLiNyif4bVKO
	JBFARmQBb/+shIempQDiAWXTGlUBtLJuDFk8HH+3UHYq/KSYwkLuGdhU=
X-Google-Smtp-Source: AGHT+IFDwGMIWC1iR1sN8gL9Qtg88GQWTe0UGzFyZY6cOGt1QZYevlntalMOaO9d7PMXhbqJ1e65GQo4UWMrzlvOPmvIPrH7ZZZf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3886:b0:3a7:2204:c83e with SMTP id
 e9e14a558f8ab-3aff50b5931mr21720655ab.10.1734078185380; Fri, 13 Dec 2024
 00:23:05 -0800 (PST)
Date: Fri, 13 Dec 2024 00:23:05 -0800
In-Reply-To: <PUZPR04MB631683FE95D7335DAC257CCB81382@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675beee9.050a0220.cd16f.0043.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
From: syzbot <syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com
Tested-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com

Tested on:

commit:         f932fb9b Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13af6a0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16738730580000

Note: testing is done by a robot and is best-effort only.


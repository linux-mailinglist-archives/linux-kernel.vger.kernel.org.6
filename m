Return-Path: <linux-kernel+bounces-407045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0569C67D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95465B2B5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A1516DEA2;
	Wed, 13 Nov 2024 03:24:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247216C695
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468246; cv=none; b=NFxYxdk1+2gmy8SMacVWdv+OeINErvEa6Y2L7wQTloLJA5yyGThjFqRT+1EEzdvFjubJQL5p2d+LL6361WAZ/ms6Xiobdy7EKIxTB+pW6iG+Bx73z8YwUpsRKhlar40NkNw+kFbbxQALTyrmuZOEsRiLP+qnyhxNi1wF9YGrje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468246; c=relaxed/simple;
	bh=uoXUQvL+voe2BXfiNcHQ7JcNqzm8pU1Hl/H6jGCeW/E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NGr1YsxBWE2sdQu9XgWgIbkh4TtjkgYfzBmssruSSlCRSRKray2Qz9Qz4wDZ2HB2k9X6xZQ53P0lFcw4WzbaCkpZRPuo4GmuAX7hPG7lW2Whe8pUKcYZgAXdl6GwmPGfv7+xIo8rzLYh60RnlVGjAEqlf0eF6CD3BH1X5p2o24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7162d1485so4233535ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731468244; x=1732073044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8endzVnlVtBMxDaxFxSUROkn9xiEPXwSq8voUGBPm8=;
        b=KiuQMl4CyN1BF1AUuVbpjrviTZbgYCIPaQAjDzttACKmE3eLPdc5VKm2Lkm1oGEglZ
         p0zH0AI2TYs8K+5Nj5huqcxMCmrPDLSUrIClRWGq1qqjtqiZcynO4n2BgPqgEtRyk93+
         w4xOFnE7EgOp9l5cZT8tKsokfMHcJyGtsO2XT86tNqTqNSRJP43jRgVxLCoPc2laXEt9
         1h5zr7loLs+Tjyv6kFW/CY12APJCxIZjbItM75DoFYbj1MbSqIVpqVZTTcEUNvN2QXnI
         ynqRLQed9/2ihO0ixBtk+YmfWYgjJNqq4ijOgvTVpBMZsBIxRJ1Lmvla1hjZEpvJnhLS
         3WOg==
X-Forwarded-Encrypted: i=1; AJvYcCXn/x9niJuqy3zlUN6WHw/FP6EQZOdtOH7D11BnRlMlIgAxX/jB/wtL2G/D/LssScYh9PlVOjuDZmvXDLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx8RUHWynK23ubwUoXXCJvsJe9ucDHnRuLh6G3v47pII3db0gd
	9HCc1h0G93ze/78AwwgP5uGKwsPa6DUw0SOmJkGNTkgM4MU6awNilCLX2EVPPhQ2tlDb6gD6Fdm
	/2eIZXYDptRRNnPMva7lROkhX9Hi+qALmxNS6cj7YpJxmBb8DxEnJS9U=
X-Google-Smtp-Source: AGHT+IGzyhjyVJhB43FFws0PG/tZKlTDvFBkWagHkCFnw6jxQjPpF/H3tfWnxkb6iQf+/8BawXI0NIMy77MJbCM04WSWfcYJmaTV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:3a6:acdf:1a19 with SMTP id
 e9e14a558f8ab-3a6f1a22195mr198754015ab.18.1731468244414; Tue, 12 Nov 2024
 19:24:04 -0800 (PST)
Date: Tue, 12 Nov 2024 19:24:04 -0800
In-Reply-To: <20241113.120420.319092919822964048.konishi.ryusuke@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67341bd4.050a0220.1324f8.0001.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_find_entry
From: syzbot <syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com
Tested-by: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com

Tested on:

commit:         f1b785f4 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121ba4c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=96d5d14c47d97015c624
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11464ce8580000

Note: testing is done by a robot and is best-effort only.


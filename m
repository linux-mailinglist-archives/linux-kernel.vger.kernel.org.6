Return-Path: <linux-kernel+bounces-401271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA39C1802
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C71C22E0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE311E0DDC;
	Fri,  8 Nov 2024 08:32:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3841E0DCF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054727; cv=none; b=CT8OQqNg66PmRjfkTtfyEu7FLW0b/BBSQtvzkFNlvWuJfsKRxgETcbP6m/GO+iR92wYgqgjo+bto8n2dMyNI8EwKg+TC4enZpFZbKlFpRZXpQFt66ei9BXYlTO3BHeMlxBmByZkNEd+byrZc3TYzDi3ynbrycizGlx3yz+ro62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054727; c=relaxed/simple;
	bh=Rm0YFbV1ihXi3unKqNfM73W4xvis0g0BmY2Pig1bCWg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jYND7usZgayHuFumqYpbcbJ5bwFCZVa7Sv4ICMmrs2Z5lYv40KB4FIzW4DQA7q0enS0/xYcCtkWck5HfDRNJzUcqrgEKI2pAZNVoC6ps/Wi0CQSJmJemTjNneERIhc4C2g4RlzX62zXHtUMyl2pKMN/Webr/iCpMJRDKDyvyI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ab4cadf05so214582939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731054725; x=1731659525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=En35RkSFP+N4KhU3zZX+pzIviofsp+4kHxXWac8Zo6w=;
        b=oZjkhSa6ATijugQ4nv3QzJYYq7DMZZj6bMBC8h8uU3Wir/RNbR0aAk2q/MBoi5t6As
         2Gqke3smzbHQ5pxtMrpXxs/MV2BoQBfL9Xe/cxlQ6EO5rFy9uP5HAXDFmBR74Z+n4ARW
         VI/LxyTVwrB+MfXFtihvjza1ClDNJtQnyV3JJUiKy4MQTKppruP7i4Isun3UWO2bpLzk
         afb8GIA7x0RaRb/zXvVF6ssWWKp2GC7CR7Minrod5lpARJvs1gHuRltCdTRdoQ0RLnVN
         mPW9yxWUyYennsvdt5cSQD35e0k/5ziNLd7K2E0bbNRNoREgRj504vWwZj5KsUkSLUIJ
         cY0g==
X-Gm-Message-State: AOJu0YzC0WgXV6hrkq8GY6M6pk3ejHuC9SkMPlDrRnGsjqbY/UKLSImd
	WxtPPLruPL3lrBqvkNAcn617m446DEVOqfGCc3z1k3GBEJTNT6+pDnQZQg10DCXgRRYfHyoBvHJ
	5nh6tdwAdT6jtFRqbbyxAjBEb6prqdYdY9RXcLgp4xHq/TgC53gy4Gsk=
X-Google-Smtp-Source: AGHT+IHloS3im+s6w55LxzSubtEr8eN/awVE/WFenfi2WUOthEVIsBz3r2lhRKc/mKj+hENBKwrDL+PJLyJKfIlP6BR6sZSHR5t5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:3a4:da7a:15a2 with SMTP id
 e9e14a558f8ab-3a6f19ca711mr26903495ab.5.1731054725181; Fri, 08 Nov 2024
 00:32:05 -0800 (PST)
Date: Fri, 08 Nov 2024 00:32:05 -0800
In-Reply-To: <20241108071820.840738-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dcc85.050a0220.69327.0005.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1208cea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11174ea7980000

Note: testing is done by a robot and is best-effort only.


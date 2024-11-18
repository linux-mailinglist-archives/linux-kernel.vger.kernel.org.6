Return-Path: <linux-kernel+bounces-412740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0609D0E83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713DE1F21047
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E96192D80;
	Mon, 18 Nov 2024 10:28:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B702E3EB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925684; cv=none; b=ttbR+13xrVjaBj/NTraDhzm2JhsJf6Ku8TOYthJXVGLpA1JfYX8GldsSwcqMGII9tRniyVGNE2dsm4k9kco/LY2MG7WoXkq9vLLYQ2M/9s5eTk1PxgaVpd7WEy1nhFFzn5LYs/h0Pe+cYPJQEDaKd0BbSsKvxJpBnl96ZENkUZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925684; c=relaxed/simple;
	bh=qo40HOKA18Z7zJ4g15+O39uLlo0p2RELfMI9i7YYsus=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=amJfQpdJsyPW4SxDTWwQhu+ShYRW5+zVEYYjBr7waWx1/Xo9y4lyi8XyqF4s2YYj6ByqWIh89dfYdBT/kKeVVdqLvW6jBPQ7YmScJqxa2G5BZxG5V7RFAF5Sp3Z/ojoXrWH5nZwE3NMl7+c5H+IZo9gQnVzaWoiu7xHtyeFItT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abf9b6bfaso156530739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731925682; x=1732530482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqdQoErLaNZPOQ1Y+uA2OIFhsvp64EzHV3LQlPaIi10=;
        b=eEaUZwESuRWMOR/mSGg8lool7jeHIKOCrrsCHBOhln8J8n0SmcumjVg29kmpBiOsNO
         NCi104vDRo9UdzXCcPZH+rKeoMJUwY2MrU5aSVOEKxEIKLxXRcVJztZ1X0QwCaIKVVnk
         r8ou6vnD+moIxSvqRpcl9zOGlLZU+otfuZxhcf4gZFDStAPGGALkEvMT0sukXb4VCbgY
         4iW6AWVL5prWtesiD1IDKV4JJVFhKPNrO8dRk2L/DtZKlZJGYMAtcI6Hx8kdS976YefA
         tRQokszAlniXf1CE/oGZku7xdBS9b86q4/jkJwpNEdGv8UXA7VlSIJz26sWGCKDkBgIL
         Hu+A==
X-Forwarded-Encrypted: i=1; AJvYcCWjoZXvvORMMggTW+AvVs7V5fntUgvxKKWQHmPG55uRXfm1lgdNa+LPJ91MdcwKhZMMfL4TD2Yeokl9hMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9uXFsBlDzq49B/E4VmsiUW4rupLyyoA9nKoTWTlYXYU6yK7Q
	eX8D26iB3Qg0E2XJop0Ynh1ykR5FVzn5bqFpuTo4L6RZS4nsLR+MdaK9/L/za2LDqE05EDB+tj/
	ZI0fErDCrXdMo+MgRLq7hu/HasjZoxUc0nTEnXbSkeECBXZ7asTtT3AQ=
X-Google-Smtp-Source: AGHT+IFGS+D1mNuzzA5nxRz0RdalLWroqJcWcrXhsnH001fhktW3xBYuWy/u3Ra7LuPcuQIdeS8bfdsdXyuBWVEsarCCHk3sNmrU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:3a7:1bd9:ec46 with SMTP id
 e9e14a558f8ab-3a747f2c3d1mr102338615ab.0.1731925682494; Mon, 18 Nov 2024
 02:28:02 -0800 (PST)
Date: Mon, 18 Nov 2024 02:28:02 -0800
In-Reply-To: <20241118100620.q9i7t%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b16b2.050a0220.87769.002a.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in jfs_error (2)
From: syzbot <syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com
Tested-by: syzbot+5f0d7af0e45fae10edd1@syzkaller.appspotmail.com

Tested on:

commit:         adc21867 Linux 6.12
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1140b378580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31661728c1a4027
dashboard link: https://syzkaller.appspot.com/bug?extid=5f0d7af0e45fae10edd1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175f3378580000

Note: testing is done by a robot and is best-effort only.


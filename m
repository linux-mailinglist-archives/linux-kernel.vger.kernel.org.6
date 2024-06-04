Return-Path: <linux-kernel+bounces-200936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1668FB6C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9EF1C224DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E415613D2B6;
	Tue,  4 Jun 2024 15:18:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A9D30B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514286; cv=none; b=nbE8YUuTJzrYpKnelOdXDcGPEhow+oZ0RkH/LcHSPoPMHzhL3vj8NBG6I5z7z8qh3SFBY0zPtARl02fvGCYBm37IDwyoNo+j7kAvZ6ZFPlvkJXtxTOCYFt0/bxF42xz/EDnDIZoDSU5n4UCWn81ujFeYRXMcwnhpRFm4f5oHHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514286; c=relaxed/simple;
	bh=tpfkNgTZfcuH+VTfOn91EPfqnUg6JbERugDkeEYrt5A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Icd6lykEhA0r+BeQ43R6TvL+ZmmSFmhiNoYGaaN8WvO4a3SjU/yXfzqptD1sr41KLLMeMBKhe9Z34bDRUlCI2DRrpaivg7Cxy2nS08vN+Ly4ex1Gjxk2dWCeoSllcRv4V4ohZlAM1gQoBfCfNI2tPezUjVLZNEOOtKk2FTcFOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37497fe0362so29572435ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717514284; x=1718119084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOzCTNHICNLa8r7l1K030oTI8NwjqIBvUy4yex2WErw=;
        b=XeQO3L/TurttyaQ1ckqG9MVQiSCC+nxmvIoLLCqnZQITZYk5KLdx4D7my1z/mGGL8z
         gNZlDQTWRw1VNvc9PbqjVBlEP6pwV2zac258GRM7+ufTIIHYu0eGfZLKvxiSBktxDlsl
         2TqBUntGpLCr14KdXMSysG46jRSJwhEXZd709+rxnjK59PovkK7L+KP12zrsqLxNf9UQ
         x0eCy7MCKqGN8baatE56PCLNXhnXjNK2s0i23tEK6BFyqAhCbiBoTKjKxLreagM2kdQj
         YU8e/i2Q/RoW7elHhC1MgRh0KqQW1HolGuk4qTdzPDHIHxaMIC2RaJJAQJYe36UkuGzb
         srAg==
X-Forwarded-Encrypted: i=1; AJvYcCWT0yIpxaZ6Y+cKVEdE78gtp2vS9VHZB2avzdjuKqgSU/uFQBZ6s3b/CTTvo1n+aXMEOkYQZVtr0yZujBDBhKu8R2tQkNJquH8oPlVm
X-Gm-Message-State: AOJu0YxvNcQQmTsdIpYUKbOMr3wUt1t9c4zAhKHKufzPxOYCqVJ2vq52
	dE2JXqYpiz4f2iHeQMlMTtuv4/VXzmTMAIzzT3v9RIXtr5R8XaxmjUmZ9MKKwypX0PO/GmlewQg
	v20I6cOo5ljF2FsVboEMtc/S4OXC8g9vLhbdQ+3nHRUP+aZM/qK+uNOk=
X-Google-Smtp-Source: AGHT+IEc+y/vX0hgXVTa79rvG2pXkFnykeX6p1ndZh1+Zm75/ZC5/DBkVL90QW5i8WSQ2aylTwUbzTPubz6DLLZsTcLJUBuaYkGB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:373:89cf:c491 with SMTP id
 e9e14a558f8ab-3748b8f3693mr8474465ab.0.1717514284336; Tue, 04 Jun 2024
 08:18:04 -0700 (PDT)
Date: Tue, 04 Jun 2024 08:18:04 -0700
In-Reply-To: <ifehf7xjxklocicvvbsidy65zidgtkfofc34s7y7eopbkokpmn@or2u6znvtren>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d09b25061a11f454@google.com>
Subject: Re: [syzbot] [maple-tree?] BUG: unable to handle kernel paging
 request in mas_walk
From: syzbot <syzbot+c67d06ab25a9bc4adf35@syzkaller.appspotmail.com>
To: liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in corrupted

Unable to handle kernel paging request at virtual address 007f8000826099b8
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[007f8000826099b8] address between user and kernel address ranges


Tested on:

commit:         63ab6007 maple_tree: Check dead node in mas_walk() whe..
git tree:       git://git.infradead.org/users/jedix/linux-maple.git syz_20240603
console output: https://syzkaller.appspot.com/x/log.txt?x=14842a16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd6024aedb15e15c
dashboard link: https://syzkaller.appspot.com/bug?extid=c67d06ab25a9bc4adf35
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.


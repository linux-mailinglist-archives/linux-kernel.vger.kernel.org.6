Return-Path: <linux-kernel+bounces-541630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD7A4BF65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331B13A8AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298B20B81D;
	Mon,  3 Mar 2025 11:50:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E75202C2A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002608; cv=none; b=SkAjQ7wLQ/HeVl2RuNfXvcOhSUjXj/bVkuBeU1sc8w4pgtxIDHblGJLo9Nwv2nevggLwgIRa4u+K/rUtTtju4Rdv5wdWVg/HiPAjunnSYJcuG4ERodfb2SNW3S7oAurkBVxFvg1BSgQNgp8krDndp8ijmIPbBN/+GLk60pI9REc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002608; c=relaxed/simple;
	bh=pyUxOQ8voYnSQSn+WTgxKYn28ShZB+FO2FPGow2EwqE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fp/g76HTNjiAhQB8mTvKpU1pI2ra4GA5GGImv2uXzdX0VbrxeSS3GXO+oCHskQY6ugHXGCL7gFS1Dpwl2J9T/YIuX+3SBKf1h2D1l4Oe+A59Z+bFw3PLkZM0vXdnH2fFO0XsbBujxbh0Ls7PKy54MHdzo1QcysWtItTz7t9DPII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b3a2f2d4so95331515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002605; x=1741607405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQSbFsHQUvuELpLK9pk63qVFardhqZS6Gato/tQajBs=;
        b=bHWeg+SLWjhysUWFluiDHqXLmAEE03fwKXIb+LfdmWByxLwaaK4ZHI0knRUgMp+0f4
         4ypAPT38ubEX5r+op8v5AYFuQ4Ay2s6DRhyiVXewzPGYs055+4hf12uWJhOHYaOT49so
         oRFsYtWsQcpXK0kJCEOfGKyFlTJV3hukX4DwkkJbE6U3xk3XvHJHCs6SEAXFK2cOavZe
         aaVtTqFn4SpbduPdcvLlYLy+Tp2eVDoWfqRoK4n9YeFQViCKE/BxjKhzOIbNOMftPaT2
         jB4qaZkBdL7tWZNuy73VfDdagz7S6s9dCPgh4G+cwFrn6XMuWWgmcxxLMQ2XXBIoso4s
         PXwA==
X-Forwarded-Encrypted: i=1; AJvYcCUFqHSd2sgK03qaDHcKkP/o9JlXk4Vg5kFPQMFUTzoQ9NN1umEezB8QE20XqHzGKwrlcgsry5IAT1vWHlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHxzwNqgdHhp/+Muq11dAUUbpd0NVLZxTVIF6cb/e4KOFOCX8
	F6jj73TDEUWum5ov/673JbNb+od/ldDsdJyhCR2iSHSE/kPznITQabc+gJid84HVrXx59NoXUBT
	vBL3vFzE1T/jT3UHMfwc3M1/tGDlmGBbGE6CaNo9uJ7ccmyR7Xr2l5OQ=
X-Google-Smtp-Source: AGHT+IFOEOVO9WgdlmGE1C0HVaOePeXbjQLlYZIIK2xALqak8RrxDq2/zwAmBuaDIZ2nhcskePB/y8O1yhmm4YjoDc0iMNIMvdEe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:3d0:19c6:c9e1 with SMTP id
 e9e14a558f8ab-3d3e6e9122fmr115067805ab.13.1741002604892; Mon, 03 Mar 2025
 03:50:04 -0800 (PST)
Date: Mon, 03 Mar 2025 03:50:04 -0800
In-Reply-To: <20250303113013.2959-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c5976c.050a0220.1dee4d.0131.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in
 nf_tables_trans_destroy_work (2)
From: syzbot <syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com
Tested-by: syzbot+5d8c5789c8cb076b2c25@syzkaller.appspotmail.com

Tested on:

commit:         7eb17214 Linux 6.14-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123f27a0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da4b04ae798b7ef6
dashboard link: https://syzkaller.appspot.com/bug?extid=5d8c5789c8cb076b2c25
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160f27a0580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-428634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404459E1199
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122C3163F51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C4154C0B;
	Tue,  3 Dec 2024 03:10:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACB53307B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195404; cv=none; b=YTTZj2Xad4Yg1k0X7c2kSq8YzisXxwaT2omNstweUjgtYqdsPU2hWEXyRtqaw8dKizEFY8gaBsAzi1/D0NW8/cFm/4urr7IEbzkTSdCuyxm3On0la3yk8NmGE+jqDrUjEnc7T2yamI1ixFC1rRwdDgpIIteGtUPoO/egirgc1w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195404; c=relaxed/simple;
	bh=dUJO12D9XJ50QVcP4tnHZQjEgG7fwLFweIIApvfiUiQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DmBIiJAFWU/D56wXo7HSuer2ER/H5l3AJ9gPvI1aqL/BuI9sz2rxkRrgWgfV/47frfGCiCgQXlqgvkedNVvBS+rOYV/ojSZee89FHFz7yrrEpXWH5Co8QeqUICf6RJqXHm15Bs5q5761c7pgVejiz/iiCQmYhgsTSbFEWekGcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so39135415ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733195402; x=1733800202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsqlgTS+ltLHskkFc17ghIGhtDEg6fOZTOy6NapKTYA=;
        b=Xxg5G6xRi4csKACUqKWe/6glKOYMniwCDRfKlLnFgZLnIUxfiuOSQCPYn7XBKs/AlM
         RNrYB3YAkuMcBFkW5CILpZD3n7S1Ky0baFz2Md0f9nNvSbkVSMd0m9bur0hl4NYBN2ac
         X1iPEbqTfAGthrDPCNKjK8U0Rz6SUCZQgYfArewzDxIZd713D4cIUWBmj0DpfoUSZ5LA
         MhxVimo4SrdQ2+KaaD63KIsJKcjn5XRY1kpAz/jRBUPN9KwOrHv9cpdMztOWj94/pgxu
         CjNRCDSVjcfEcGCW+x7TV4ZQ+JEZO0fdypx6V3+y7/tV5bx2NTcnczLjh+OXQn1D9kSO
         8MMg==
X-Forwarded-Encrypted: i=1; AJvYcCV4nmbna1DRZUs6a6D6PSvVNTxJag3xSilXyydEC3GQVW8IB3GMNijyBTDpqAb8HmmSk6Y+4rN6L6BlsSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuF1V6wwE0PtRFpTqNiXFU5hpgHPlCLpyqm7y/ZHTkafnLUT2V
	jYhbLGn9KXP8QiFA+wWMRxwpghGTsozty+374HLRGNdBCmSxzK7+dc6x5X+y/sQfcE7vblZXEyW
	ocFDYCLCdGkckqN//ab+V+1rjlCICYLEIKyByCGibgXtPPi7Zt8WK8qs=
X-Google-Smtp-Source: AGHT+IEmvwdk/IWR1IE9jKRTNexDguMVmLfjZ3Mzl//VCSLA5eIjz6/kjzGkRs4NOg0HaUH9YEKoELKu26Ww5mB8VnmBoXt3h7Pk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a7:7ded:5219 with SMTP id
 e9e14a558f8ab-3a7f9aa3b72mr13967695ab.21.1733195402426; Mon, 02 Dec 2024
 19:10:02 -0800 (PST)
Date: Mon, 02 Dec 2024 19:10:02 -0800
In-Reply-To: <PUZPR04MB63168009E64846094D5BE10B81362@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674e768a.050a0220.48a03.002b.GAE@google.com>
Subject: Re: [syzbot] [exfat?] general protection fault in exfat_init_ext_entry
From: syzbot <syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
Tested-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com

Tested on:

commit:         f486c8aa Add linux-next specific files for 20241128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14eab0df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=6f6c9397e0078ef60bce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e30330580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-260995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E6B93B14F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC7B1B242AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0215A87A;
	Wed, 24 Jul 2024 13:02:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58761E890
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826128; cv=none; b=VDXBt3buyDDuJubw2beOnY/fpIjknvl3wj3txlaaSzfCgnVQmgr89Bv63geELXUzMUikL1FbJR2zWmO3vXnBy9NP3BGU9n2h0+4lS6yskdoVjzys37umtzCCq287YYK4YGO4R+8c/aRovpXFugud8sXX6z5d8kwWyTWTMdoHGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826128; c=relaxed/simple;
	bh=B+/CQ7Ujdc6sOVtFYfGWfFZAmwM4Oru8PgbMnMShQ4Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KGNf8/cEhbQQkCOhkOo4WIlNwmxk0j32VzcheKDU6ThnDoj1mXhxJA1n/Xf5BNVTFeXpLFkxDU7ITtdZ73wEf6lO0PSkTmuSQ8SPbYLHSdWQ4nT96TuUicuhJymDntRTa/89BCIm8hjPP7Rh9eYXJU/EMQd42wLqvRKouhK41Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-397e0efded3so98552285ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721826125; x=1722430925;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcGiBEDI+Zz6rd9Izdew3/JfQicsv3PWsW8N1VH1Wrs=;
        b=CQhqLdDWY6g0jdf0dMEwizXnIQD1Xsfpd+8RiHuErpgmjasCGBXkyDQXrYTRFYy6DX
         Uc8Su56CxMspJtTOxkG/IcNRFW4bIpuEr1SgSzeeJBBvzBNkqOxFVE1Tfa5sa+vtawIf
         Ac2Grjk0Ly9eepYpZ37assveMuUfH5OcjvT4i7w6JpEhc1I6wtxDYrZEdkQMH+0S13Kg
         6IYct6fQP3RCQVsqGRpscpHnqCFKyxDC9I6LL2SSfsEEdmQXNeGYsb3hYyIgvWm4NY1I
         7vRqlleLhjUQMmknIQ4YJYmtBC1cMWQOuHqRuuQGQql+2j3vJRhadQpvlsioICxIYKYd
         X1TA==
X-Forwarded-Encrypted: i=1; AJvYcCUiHkbVDJMVX0TDRr2OAW6tTy7YoLYSXrVilj+FuZLLRd1mZaZHaqu808bD1PueSf4NaHWD4+4c2n8/LIBatCj05REh0eb3zL2wkQ5L
X-Gm-Message-State: AOJu0YzbRqjUvq85rlrYnSbl1ELFdETJlYfZr4duD0hxx+eQuiv9DN6k
	yF3iq2ZgSmNNBXHlUBaXKwXw5Fxk9Ur3QZTI6EdmjTRCPZoWus+eUSe14TNrfqSAUqZmNgQJzmU
	GOrNRi4pKFVJ24m7ecGkmMjUE7fZoeUNvy+SogK4OzrrF646rrO/X5O0=
X-Google-Smtp-Source: AGHT+IHLQqOLX7IS3FpvvWrTJy/t6bMB+xt4Ir6MuzL+BE5Vi46kAn8fmDNJyE/8bKSGkMRVVe7rTSVy6N37pBfQqOeH2i54cI5d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9b:b0:381:c5f0:20ef with SMTP id
 e9e14a558f8ab-398e19988fcmr9419845ab.0.1721826125512; Wed, 24 Jul 2024
 06:02:05 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:02:05 -0700
In-Reply-To: <20240724122756.9572-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009390f2061dfde2d7@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
Tested-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com

Tested on:

commit:         786c8248 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167af1f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47beaba1a1054668
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174a58e3980000

Note: testing is done by a robot and is best-effort only.


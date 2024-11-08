Return-Path: <linux-kernel+bounces-401583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0369C1C89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361E21F23F87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F71E3DF8;
	Fri,  8 Nov 2024 12:01:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4138DC8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067267; cv=none; b=DEz+EIKJgR/a+v1SX0/+Ch8v//9PAlZxg+Xf/6e4ZF70Oe2/TmmjLMxXH40Tkebp8Yz03L2XAplkZMwfF9uwg0l1zYxZm0FZ3f0DiC1cXY2dH6wJNkfBZHPmaVVDzG+dawcqNk6vSuRXNl/bkJvxgMy+8JrboXT/sE2ymbTqxIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067267; c=relaxed/simple;
	bh=gGGpa9APEvKWe6/+osxtbTumOfFPvIJb5VPOQl5J+fQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iVE2kwjAOPGCGJJQ/M4nYyrTE8oxbXXxlXFaRn+wtQMy9869TpdgMy6Ut4pecbtSOicJhnr2no3aWNTmW0NmncSNJHXUAMBRFpt8GtRNMs642CuTHaE6n0gTmAMVy5yTjJ/bXYLLPqUAk9YRatTHmnPvpFwBAIer5aaYZ9fNScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bf539ceaso27203465ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 04:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731067263; x=1731672063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vZsLGLvQf1rJSaKtZ8AcsbzCt3P3MO7ycUC2xGPBJQ=;
        b=g6r8x6qL9ZzvVBqFFuBkYt3kLXLd1XrnwspAyfzwe42aoUljP7sUYsZgtmp0isD3Wz
         6Dq8nSvspXB01iWl05oJ65EPNsM4cY9JRpCke60YCh56DLz9PvMV3Io8yBn5pCBiQi+6
         N8ZvB3UF82Cb9I0tF9+KpFro7mE9vFNpFT+Oq0IJeqbzhS5VoVovjpPbEjOMSgtLsdMs
         UVw6HbrkDAY3Q1HAA/9Bz2vPs7nmyCxkFCb1OCzVI7EsO2pB2BZuejkw07TasNUWXWnR
         bmW1SZWIDuPbg2KRmbqcg53OugbqPvZNF05xxO+0j+0ueDDcwILZEkwh2Ni5gVZzwJRE
         cxcQ==
X-Gm-Message-State: AOJu0Yz6hbV2uLUp1LW0F24Kaxg2S1S5dMzlqOdZRTR9w9TlL4G324Rw
	VuMBsgrAxb3wJGL3UigSnVwWLHyGpqQ+J2AJWn5B0TaqtFZdDLuDbBK5+t5esLggrrccKFKj70o
	0JPI8KiURtd4axHaxTRXGg7m88s64muElYj6PKWD25er09xHOi1RKubw=
X-Google-Smtp-Source: AGHT+IEWajE6Um9LJw0YlKpH5ADK2kfLhaGuwVM7nKYq62ug7FFllwzArn68iVpM41643KqFGtmhxHSmxHJfa45bfaVN0wSkAzUk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:7308:0:b0:3a6:c6d1:8c4b with SMTP id
 e9e14a558f8ab-3a6f114b1e0mr25701885ab.3.1731067263124; Fri, 08 Nov 2024
 04:01:03 -0800 (PST)
Date: Fri, 08 Nov 2024 04:01:03 -0800
In-Reply-To: <20241108112441.1869858-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dfd7f.050a0220.69fce.0013.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1641cea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a1ee30580000

Note: testing is done by a robot and is best-effort only.


Return-Path: <linux-kernel+bounces-379059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8EF9AD91D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C801F22F04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1C208D7;
	Thu, 24 Oct 2024 01:14:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3ECEEA6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732445; cv=none; b=MbZbLUURY15364i9WHZ06htyWxkSJfNHmWJ5lEt2nIzkLsittMoxWmU/TezRlxDKs2xpw5d7/xjCvCOqyox6/aXQiFDOE6BQEr6hmtTzmygANXKIpc1ImehvoTipyqRCF7L6UkyKU4CLXvAIAx6cVnpGdtkVpz4/ZxMCBtw/IUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732445; c=relaxed/simple;
	bh=oOTXP4abm4ueYSiN9+MAFcLLCMz2MfGNhVTUqdkNFBI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=geFYg93fDBlvCtGdk3qnDV7wY1zTYeK0XcvGsGOWWBkJLh+cXEwJCnpX9kDRloCiMBeOrwSJgSfryEQuhcixMsWdkPjoHwm5Y6pwffYCnxMu/LE3RCDAb0+CEKH6qKHfkifnyMWSmICdnYHi8BcTMegMseRhnJRPgYERnI0q1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83a8c0df400so35734239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729732443; x=1730337243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vORZyEvjECSbN9YQylsTzds9PyoJBBXgL2X+MVyjIsk=;
        b=nu+vWyzH1m7kDUUZnfyh3WvGPKeta4ySdqDQ5VC5wNYGvWEqyjxOtcNNI+DmGrNDUq
         M1wa2+L4xARl3SNS777UMp4rtTB2epDGXWVAPz5UwF+Z2a3Z06q9LfyzlXFYLe9eZ3o0
         bxlvUYaMPFKQTHSewwV8KMleVxCHaLD2UvNcYAhf+AHm22zuSSS2gQkOYLZRzzjiVu1O
         sDzKB5UpNDV+MLvbN8IFPpIu469Jw3XfP/9CD1kpMb+b44RZhrL01p8dABVGAzKIyGeD
         rrwKD1pKsHS07RCTpwbcqrzZjk56nyb/dXuTkTMHBAser9TboIs/7H1xbSigOmwoe8eC
         CZRQ==
X-Gm-Message-State: AOJu0YycHh84cc4pus3BfjxtmXEaySYHTuyGAptvib5Zlip+pp8Aes8K
	etL2Y6kKs0SZqaEBIQhbt6YLliYfKKdgULCmZHS5XsJ5ujQiQbD1mr9OtQjI7q5V0eaTpc1SJ/8
	WNnGro0LfMGlvKruahvhjB9FJpvuNYd4QfkAQ87jb966c4MaRXiAklEk=
X-Google-Smtp-Source: AGHT+IFfHiEml4csObwGnNCVNADLCNOlXRnf6fwCDO7Ib9+Tp4xHZBANzOJ+T5czmPX/rBP+23LuHa4XEZYKxrlExqLsGczIiBuE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198a:b0:3a3:af94:461f with SMTP id
 e9e14a558f8ab-3a4d592f281mr50397315ab.1.1729732442965; Wed, 23 Oct 2024
 18:14:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 18:14:02 -0700
In-Reply-To: <671907d4.050a0220.1e4b4d.008f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67199f5a.050a0220.10f4f4.01d6.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read
 in bch2_reconstruct_alloc
From: syzbot <syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
Author: lizhi.xu@windriver.com


#syz test: upstream master

diff --git a/fs/bcachefs/recovery.c b/fs/bcachefs/recovery.c
index 55e1504a8130..717c1a80de20 100644
--- a/fs/bcachefs/recovery.c
+++ b/fs/bcachefs/recovery.c
@@ -95,9 +95,9 @@ static void bch2_reconstruct_alloc(struct bch_fs *c)
 	c->sb.compat &= ~(1ULL << BCH_COMPAT_alloc_info);
 
 	bch2_write_super(c);
-	mutex_unlock(&c->sb_lock);
 
 	c->opts.recovery_passes |= bch2_recovery_passes_from_stable(le64_to_cpu(ext->recovery_passes_required[0]));
+	mutex_unlock(&c->sb_lock);
 
 
 	bch2_shoot_down_journal_keys(c, BTREE_ID_alloc,


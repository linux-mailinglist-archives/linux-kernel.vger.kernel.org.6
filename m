Return-Path: <linux-kernel+bounces-442754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0839EE12A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAAF2834D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901A20CCF6;
	Thu, 12 Dec 2024 08:22:37 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47620C491
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991756; cv=none; b=tO6Ay99goDiWdZfWpr4y30p+7gG+R0vlDAjw7uhRpj9mRDtx8p6Zr8Sg0G8R3Pa78Y4PGQYxUb6wa8XWN5vUS0cCwpsQRUvMjKP/3eOyTxq9bOsDHH13ZCD3Wpd07bkC5GcobwkndqXh/JD83ALk8DUEW1T0j4xU3fLgXkEGInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991756; c=relaxed/simple;
	bh=PhGq18nzYMSBTDMTbNGpAYmympEoHWQY2Dag48ZP8uQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fsmchT7HjFoh0DiqO96wVhEyGXiNdrY3CYDZrWRsFioLIe1VV3D6eXFkupm1/gh1lBEfhaHxEPtJgGWV8T+DCP+/G60ZzX2Vm7iHIMmmiesF9iZSKXM6/m20wwVSTOQ+12SxGcWK52bv9Nv6vRLHBVHM4TrKlw7TK6JUpYTCs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-844dfe8dad5so36645139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733991754; x=1734596554;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtOOIcnxJ+Mj13bnw/HJxyJB2w9A8masx1lR466c5Xs=;
        b=CIvtTD95yW5WCY9voJXwYll4s3pJF0d3wB0fr5qAacGHzsYXT6O8MVGMeYM+ntc6oq
         piYJrDqbOBkEcFOID44vGw53MJ1GVYuNlBHkftNMfNH1wgXNcs37Y9Qy3+eBFfm6fKPO
         QcHOlchDfsrnuiB5NV7hoBgIV5cfDqQ4SJQoReRrLgrOmY++RdAloL/K1OnrvR2R8m+N
         LSLd4WMzT+2Y5D8IxcsZt6ZeWt2ltET+gxQvR7xttxMQujmBS1E9s9lPOPobDp+kuoG9
         /qiZ8QDf6AUohlX5IaLCk8AQhZC0RfFQ0wpBOz+WZxhPKZ+1uGUVPBvbi+uuY9em3W9b
         ycrg==
X-Gm-Message-State: AOJu0YwuVhPoyzYwqD+eDOqKGUhBE/mLb5LVujcgj0BVsAibmeNTdIAp
	0DJvmwfRe4Upx0/nK5f0Y/jVk88+baClbx5SJem//Om4Z5elXusXRzT8F4dybZzgzCNoV2CsF4H
	GGYSSBH4FqcKOBnP2sFhPBGSHCMeU/taIg9xE/yyZ2qWnspVPtkOfAJk=
X-Google-Smtp-Source: AGHT+IGiQUFV4e9gisUlJuPAldAzzWKk//yAe5fw7mjhJIvEzmdpEf5x8+1ZQa8CFxfXrCc3wXEPURwwNpB6EjjU3aZLLA7AWXc+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa4:b0:3a9:e2f3:8dc4 with SMTP id
 e9e14a558f8ab-3ac4c8715ccmr27623005ab.20.1733991754494; Thu, 12 Dec 2024
 00:22:34 -0800 (PST)
Date: Thu, 12 Dec 2024 00:22:34 -0800
In-Reply-To: <0000000000001db56d06076f6861@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a9d4a.050a0220.17f54a.007f.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in hfsplus_rename_cat()
From: syzbot <syzbot+93f4402297a457fc6895@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in hfsplus_rename_cat()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 231825b2e1ff6ba799c5eaf396d3ab2354e37c6b

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 948b8aaee33e..9352efbbf736 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -360,6 +360,12 @@ static int hfsplus_reconfigure(struct fs_context *fc)
 			pr_warn("filesystem is marked journaled, leaving read-only.\n");
 			sb->s_flags |= SB_RDONLY;
 			fc->sb_flags |= SB_RDONLY;
+		} else {
+			pr_err("remount from read-ony to read-write "
+			       "is not supported, leaving read-only.\n");
+			sb->s_flags |= SB_RDONLY;
+			fc->sb_flags |= SB_RDONLY;
+			return -ENOSYS;
 		}
 	}
 	return 0;


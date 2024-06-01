Return-Path: <linux-kernel+bounces-197618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472E28D6D28
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91F4B25BDC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 00:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB781860;
	Sat,  1 Jun 2024 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tq7t/fYJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A717CD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717201787; cv=none; b=hQkso75Bi+hRl4vT15tk2Eu7AhZwLcGjahSnV332MhlFbT4rYRExyrkIJRwRlxpbtBGCHw/fEKAW9We1V33Vb5YLUyK+aOan9dszg9u3LcqkfEMSfWBTAI16b4N5JG9ZmfTUlA8XhCtdWQyju72jO2JtSseVEwn4JmktRo1Kv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717201787; c=relaxed/simple;
	bh=qv6/IpC1VDWNK2+IKFOunbwInfRR2ZUEIGvqOR25Ods=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Za+9+7tbiGdlJCcltI5t3egvhZ1fRix+dFCeLjsIcuZa/Ir+YaYkKpR/OFc57AEjaQEOEfmcnkTyc8u1dtnGC00NOnn960wMMN7lNj9fm5S86a8UX+qyVsa26v09cY4gNyXkrWJTNvQuTNTeD9NpZUZjN6HSrFK90NWHyZhL7kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tq7t/fYJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so26703435e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717201784; x=1717806584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/DaJAvlAh/evryMn6v18BL5WWQj0E49Xgs9bgovJI8=;
        b=Tq7t/fYJQlCEhTA2npo8JxcRyoqvpmYk4GEtdfgtma3iywq+179PgFtVT5R9RYowBR
         d06YkgoCbfAVt/wmFpEMmry9DM1UICEsLYTwkKCbgCMgNKoIXhvUerhsIehT+5zHHo/4
         3gxSG705XRdZMhyqIvrFM1gwaR3xc13wMfQryFsyQlhBLWGtXb+Oo6xcsRluQLdW20Pa
         xL4tBGxE50/admmLsXc66Giwvi8Ct7vPMFcKcmKp/4uxO9D6gS01oU+dHy60JfdVvaPK
         11CjS46wJ69cRVZs9YglzSd+NE8fAcVEFBROhjMJlKLvYcNOZz5o9YrN7dahzdCE+TFm
         pF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717201784; x=1717806584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/DaJAvlAh/evryMn6v18BL5WWQj0E49Xgs9bgovJI8=;
        b=PpBLn1EDEctR9CaqvmI0Ln3qz5N+ZvN7obpxuOScaGNff39anyN4i1v3u6i2fU9WoM
         GR1fq4F6q72P4IorpDda8EjjgfUYkkI/AknUkYfKQbJN3CfyXuYCHu6cjz6LeHLtpATW
         4yBos7jceWmx4RhGXpOvzVqEn8ldiSQDctTFckSO3P6xzjfVArRdflUV1wadLBT3hfjI
         W2hTFotZFy+9bu4nnyXKoXDDXigo/GKMgoGmm1PG0jyrINkMV6S15WlP/KbXbVQGBN6n
         NcXas/Iv6GXL9h+LXQFtuxmGtI3EBrxacRZATBsfEIYTUOm/nv0t5VuovHGJ2X1faSj+
         BtbA==
X-Forwarded-Encrypted: i=1; AJvYcCXppIbsmHQKcziBsUTzcrLv/WLFZG/SbFXmEtUA3wHIcmt1sq3Iamihqwierr2ldctByyPKWEq7ZJkEk7qCKE6bYP4NZgKltROBPhFO
X-Gm-Message-State: AOJu0Yyf//4f7sgq4IdYGUeO+ASCv+JcSa+z4yhBz4Elvf+4Kxr4FCFC
	QAepRL65n5HZYcb2Rn/0p6i7RLCE49Une6ypgra1yjx5r6EiGf+6gT5JJ3hNh5MxKzNR9Zd+efD
	Ba5aBriuoyfQsO3SxyrMjhWhAAIc=
X-Google-Smtp-Source: AGHT+IHDvkWHDFi3JxZ5vLTPdAw+pEcMPkt5HdsuJTtEWYpJX8JPqVOv6CccILcPHMXSu3kWv9s0xWIqx6kt4aKaSJE=
X-Received: by 2002:a05:600c:6ca:b0:41a:b961:9495 with SMTP id
 5b1f17b1804b1-4212e09cc32mr28877925e9.25.1717201784329; Fri, 31 May 2024
 17:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002e9eb506178cdd71@google.com> <20240531110652.8845-1-aha310510@gmail.com>
In-Reply-To: <20240531110652.8845-1-aha310510@gmail.com>
From: Changheon LEE <darklight2357@gmail.com>
Date: Sat, 1 Jun 2024 09:29:34 +0900
Message-ID: <CAJDnv3bHUUPT10O6_M64vNXXKuvAQMGEpzQs1XQvEHpGXS0zCQ@mail.gmail.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello, park.

Your proposed patch seems to have some glaring flaws, which I'd like
to quickly point out and then suggest a simpler and clearer patch.

The part of the source code that is the subject of your patch performs
a function that checks for free space in the block map and returns
-ENOSPC if there is no free space.

Also, based on the stack trace, it is clear that this issue is caused
by using a shift exponent (128) that is too large for S64.

Your proposed patch doesn't check the shift exponent, but rather makes
it return -ENOSPC if 'bmp->db_maxfreebud' is greater than 0 and less
than 63, which is causing a logical error to return -ENOSPC when there
is actually no free space.

Also, it seems like it would be better to separate checking for free
space in the block map from checking the range of the shift index.

Based on the suggestions above, I propose the following patch for this issue.

---.
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
Index 63d21822d309..b1a2c3d4e5f6 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -315,6 +315,10 @@ extBalloc(struct inode *ip, s64 hint, s64 *
nblocks, s64 * blkno)
         Returns -ENOSPC;

+ /* Check if the shift exponent is within a valid range */.
+ if (bmp->db_maxfreebud >= sizeof(s64) * 8)
+ return -EINVAL; /* Invalid index */ + }
+ }
     max = (s64) 1 << bmp->db_maxfreebud;
     if (*nblocks >= max && *nblocks > nbperpage)
         nb = nblks = (max > nbperpage) ? max : nbperpage;
     else
---

best regards.

Changheon Lee.


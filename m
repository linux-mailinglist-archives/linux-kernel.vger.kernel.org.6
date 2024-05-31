Return-Path: <linux-kernel+bounces-196712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34E8D6049
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A3E1F24D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830B1156F5E;
	Fri, 31 May 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5PHFtuN"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E420153BC1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717153683; cv=none; b=UuOMrwPbkMGBn0E/lsZK6OObJ+JnZIkKPzZR0mLMW5f810MkxTQiRzMFetT6g6nHiHmpAv1VO2d6vcmqiS5o/S+B+cXD+DAoTLsZdevFEWp/uEGdJRIWwENAz0qvMng8xgyvtgFHVeH0og9JMY5o7/3YbH/+SjxFzOEcTNtnv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717153683; c=relaxed/simple;
	bh=V0W74umqosJk+Q0ab9ICo5mOJb9mZvEjBzoHrcWtInM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJH0OC61ciL4SOaq6EMVrAXI8SM8kZYK/6RfjT6r2WEseJzNtlvfS2ktr5fRc4i0IVbH8wKSD8JfWY53akPL9NVhSyRfUOWzWAq5kal5604/DDqrEOvJzvLY5aVzuPCasazj7YQDT6zgQd78jOW5cW5tvY06uoIdp4kw6IDOULU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5PHFtuN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f48b825d8cso15382855ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717153682; x=1717758482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3ULV3/Us1S/kvjlIJKT4c/3M0IhQDC0lcYh+ONVGQA=;
        b=A5PHFtuNX/IDlPhgH82OwOd1fNm93AnT/pQcHbYfLeQ3CcxA5wldsMDePu7BECMVhN
         MctLSeP8Di7Rgtp8SDUfie+dzRU6JG5ETxR3ZRcVhBezXq6b7bPGIzEkqjiVbLd1eBo9
         GOlqz63LTrhzSQwgaDHsY2unUm383DBpfg7Y7HgxKUWOhIsg0crwwP113UabR7TUEREk
         U0bdmAzWqhIpy9ZjMnUmuzlOZRzHfNQGUNwkU3V5f9QGamLfqG1+NeJWhuCUjzdvH33k
         3h8ECkirpJ5rP9uEJ6SBwnZXytlFcW4PnGydQjMXNlHET2hP6IoMUlYqnb8BGU9i2G59
         VfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717153682; x=1717758482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3ULV3/Us1S/kvjlIJKT4c/3M0IhQDC0lcYh+ONVGQA=;
        b=AuDQV1aeZ7XtagjelbCFZlClH6mrS1xRFP/n8HVYMxlUlOWd7zY3GViOr9ZcbUCLxt
         pzkkbfzhopZNjrr97M6FRjcCshgtI7domN3blc8ghcykOaFY/K3STebWkB+RIc7ZBmAz
         CJEU7BHPVOMS/s53yFKLBlTR5VOpywZ/3lirclFxa6zn/PBj5AcvrJdV8Gj6F1mMt8x3
         RZ5c8bK8fqcdqsKRxquAvxaHJuKJnL5mGSTpHjtOUaNS3sANzs2HSjcZDQFC15bAtsPW
         CzoSRuPJwgZbD/1QWxT+omtCPQRFcdfiQ7J9trQFJfPHqzXq1MFv3WWPp6Dyo0xfEgDD
         M2Fw==
X-Gm-Message-State: AOJu0YxTGregsofotJsQLwznp5Eu9FsChvQQnRyTq0RZZiGE7GTDC2NH
	dXz/YcH8HwnsjUvNGoatJPlK3GczPqXF80LxddIsEuKOQNwcV5MpW9imJN9R
X-Google-Smtp-Source: AGHT+IE9WZaevmfwAySeBSRBfFki5lIekR2VAMSFaJiEhrgvbCwGmOakH8WK32wt7YM/CUQtYWShhA==
X-Received: by 2002:a17:903:32c4:b0:1f6:344a:4915 with SMTP id d9443c01a7336-1f636ffe6c8mr18224945ad.6.1717153681748;
        Fri, 31 May 2024 04:08:01 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232e0d2sm13849195ad.40.2024.05.31.04.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 04:08:01 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
Date: Fri, 31 May 2024 20:06:52 +0900
Message-Id: <20240531110652.8845-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000002e9eb506178cdd71@google.com>
References: <0000000000002e9eb506178cdd71@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test shift-out-of-bounds in extAlloc

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 fs/jfs/jfs_extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 63d21822d309..7701159422a1 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -313,7 +313,7 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
         */
 
        /* give up if no space left */
-       if (bmp->db_maxfreebud == -1)
+       if (bmp->db_maxfreebud >= 0 && bmp->db_maxfreebud < 63)
                return -ENOSPC;
 
        max = (s64) 1 << bmp->db_maxfreebud;
-- 
2.34.1


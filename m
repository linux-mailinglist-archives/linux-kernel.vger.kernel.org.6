Return-Path: <linux-kernel+bounces-342404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B946F988E84
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BCF1C20F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379CC19DFB8;
	Sat, 28 Sep 2024 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAhP1jk6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8FF15A8
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727512674; cv=none; b=N6Mocuv+MnYZuJs+Z8dUlTkAlXBqsHbPHsMnPHQMPZ2N3xlAvi0xENlfX7q4l5MW1KT2k6iUMH88lA215UbwqApumY/+MC3sXhI4HJdBU8CUXJmxHpjGnf7L8ciJnqmS3FEKUjofzLJzmkDKqTUtjy7J7hd2o9UYAzWUhQ+Ko5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727512674; c=relaxed/simple;
	bh=qFcd+4PYx5IColANo9inWair5yCSHvdQxLborWwJsVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mKg6I3sDxY0t3wFMiYH1GFWSoMbi7B7e6LCEPKrq2ToLQMq1QvYhI/ouQuX/txYQJQ4ihyC5sIMLNcp0JlZEcPkUqL21gYq4xRPn6SjOeyuM7Y1QY1vY/lQHLnDO3uQFTBGLmWxextQRyA3W4EgTTaSuNiLmvF8AymmViWBZJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAhP1jk6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-206aee40676so24953995ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727512672; x=1728117472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7jYH2F1hiaN1WlCy/B6tx6x8U7coXSLbe0ZEW+Tt4Y=;
        b=YAhP1jk62sYtMB69PJDnBveMltzFnBz5NUqc55oig/3qPDhDVX34Am22hnNXTSasQk
         RqE6OFgGdMTuf+F4sukqdvZW5irwIcN73ETjBpSyZbFX5FGIEFXrJOGPe+8OwsDK7MPC
         yFe7ScEJUHkKQeXly7bjrnM/8FErSeGkLD7rrAyDLXqjiIMI4EhmWtL2vYvC2AJBrkne
         JFQrmAG63o0urv+bvvoZmE5WQ42z7Tpz3msEIQw3A0zWQEkfu7sr0515gHn2+yYBFM5L
         sp893KAYhQjOo/IE/3ry0QkLRIKmeCXId5iHtVU5OTXI/yrhY2XWCiP2X9l9wNQuXI65
         /PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727512672; x=1728117472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7jYH2F1hiaN1WlCy/B6tx6x8U7coXSLbe0ZEW+Tt4Y=;
        b=YG+hUb2LQBf27nCYbYcMTdpDy4O4f9VWFNKbf/qd7wvujmMJmGa8jECkbna0mFudiM
         1guOGRi9oKDdET5JpCI/xSAnn0W9zm85EwVaNtuxGaONEE/b5Lb0bb4BOJssg6Uyxa0+
         zSCkew4Xy/TKQfIEv+tZaoQyyOsOjk+j9WLtX/UbYGHHYVoShJ9d9LDg0EZK+n/nCKLo
         2EdA2xc2rcxxl9W9LZzzoaVWRcSRaR14ZS/GpUrK5BF7RU5f4UP+p3zHajk5VdET/QS6
         plehnbqpT0h5xKNQBs3/SfKKSwyXFG11cYkHtGI6wmTzn8ZqJ+tFHqF+v0hNM4QY5+vo
         1ZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTtKojlRYca7Qax7633zLyCiQ/c2mARmz/TlFexzQW/Ii6qCkZETj7Drs32pTgfr3+kP4G+/hJVufzz8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzfSU2s0LsJ7Awfe0x1eyZmi3Wbrl0W9z80HmQKSCyrkImrHA
	+BCM9pUlpCfB80nrLhn+BVi2zh75gxwjAzpUVFVOhRhTerPd8+Gbo9MsPXnyl2o=
X-Google-Smtp-Source: AGHT+IFxgQrwS/b0lmsVc0Fb1h1wdOH3E7LcKyUuxG3bTAwOb+qBjrH7bbUr7E1YGq/4ZUJeLUyC0w==
X-Received: by 2002:a17:902:d4cc:b0:202:4640:cc68 with SMTP id d9443c01a7336-20b37bb7919mr73605265ad.59.1727512672348;
        Sat, 28 Sep 2024 01:37:52 -0700 (PDT)
Received: from dell-xps.. ([2405:201:3036:a902:fe6e:a336:2d50:3660])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2927d3sm2815845a12.3.2024.09.28.01.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 01:37:52 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: shaggy@kernel.org,
	eadavis@qq.com,
	ghandatmanas@gmail.com,
	osmtendev@gmail.com,
	ghanshyam1898@gmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com,
	syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com
Subject: [PATCH] jfs: array-index-out-of-bounds fix in dtReadFirst
Date: Sat, 28 Sep 2024 14:07:22 +0530
Message-Id: <20240928083722.2317029-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of stbl can be sometimes out of bounds due
to a bad filesystem. Added a check with appopriate return
of error code in that case.

Reported-by: syzbot+65fa06e29859e41a83f3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=65fa06e29859e41a83f3
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/jfs/jfs_dtree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 5d3127ca68a4..69fd936fbdb3 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -3086,6 +3086,13 @@ static int dtReadFirst(struct inode *ip, struct btstack * btstack)
 
 		/* get the leftmost entry */
 		stbl = DT_GETSTBL(p);
+
+		if (stbl[0] < 0 || stbl[0] > 127) {
+			DT_PUTPAGE(mp);
+			jfs_error(ip->i_sb, "stbl[0] out of bound\n");
+			return -EIO;
+		}
+
 		xd = (pxd_t *) & p->slot[stbl[0]];
 
 		/* get the child page block address */
-- 
2.34.1



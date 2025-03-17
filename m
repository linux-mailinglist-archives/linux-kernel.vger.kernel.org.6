Return-Path: <linux-kernel+bounces-564955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43DA65D90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB473ACBEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF81E1E11;
	Mon, 17 Mar 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxYW9r53"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710681C5F3F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238498; cv=none; b=n2pszy9tr5C0/WfMPb4yTew/0VeUGsXQS07mlV3oh9v4cXf2WgxELHO+3sE4o86EsZhTsBsZ07HBuKJvhgx1LuReSHDA+puoZNhgOa0gwd//1ejnx47XsP8oyPSapBiB+MFgdm/ap8/9IF+t82Q1bo1/NgJ6RB6XZvip9IJQBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238498; c=relaxed/simple;
	bh=VaVRrczqhYe3NnqKIsRurjNwDra9cga9SptFeqkgSBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pstqy313/ewGquzGvUzpKmYqNu9y2P+r4nIq2WEORrdSOfm5xIJy5lqu14OYzln87QbkyVcVnXTufcfwxLxQaLW0hkxqn7bUBAI9Kj5R/VjGsgR6c2FYLegI/Gh++GpVIOCdf/XScM2RIehGZftbMuV7BecFOUQ+xHtWobMCSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxYW9r53; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2260c915749so22060845ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742238495; x=1742843295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1l7OENO6CAVnXbGvPoQ7HrLqsZWkXzyndkdOD1l60Kw=;
        b=UxYW9r53YE40vRwxhX3ahRgl2aVOJLTtulQ7SfmYYwR8TnyMZ3T4AJYrEKt3IxtRtj
         FQhoLUtZ6MQ7LowdMGwtW1r53M2s59HGlqawinebyEbD5xY2h3dZXXsa5onFJTTMHKKn
         2DBO64o4rFAD7A9ZOWxskqdX91P/DwqqhfJOf3dd/jcHB9kpKhV5qj/Tc1arKBEnSlBp
         eOP5dN9lLPp4gdCdSawYktOG+g2zYZR24wZ3WsnXAVTJ7wC3EZ8yXHHMiHv8yOo6KBoC
         kec5WhQv6l/flMB/2F6qpsGNHoivQk/mjoldk/WGkKNA0GRkulCgjgAh5/5Xsy/38SA8
         jWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742238495; x=1742843295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1l7OENO6CAVnXbGvPoQ7HrLqsZWkXzyndkdOD1l60Kw=;
        b=b+fkmdG1DV8l6BrjvPD5VzDDtpUHb7a92Pz3fqkfrDN2dlT9+XZuV2PoTPd2uKcGTN
         SzOGFkO19acjy4xoXodbbzYV+eXPXKiG7FmvN5SiXR6d/tXPtnxB6nP28/Qy09F8OiMd
         2Wf5wM1ZHFNmz/I8yiJhfGI5N40aDuvZrDyfWjpRdAYaiMbzHZGGedqFZSZT2N1S6Iig
         PBsDvIUXZjFlrE+63lhDCQilKiBwlUtZXCuVXFwxK3mx+A+EV/jgq3PK5Sp5TKEuHWvH
         5V+he7ZAnHMyKV6qLEINhYahg5L18nHm7OV7ImshS7i7jwPmfvMSo4yphkYyEY9LQPDs
         z7Hg==
X-Gm-Message-State: AOJu0Yzjs5yJ2mdqhJXSxmc3uleR2DtT3DmsLtr2h1yYN/vIGUEmOcJK
	nODtteuG0bCDl3MrPbxqrRO6zKjgMKHDJM0gy2gQWPaY0Zrcot/5MlUbZQ==
X-Gm-Gg: ASbGncsMlQFwqd9/D0juWsMuY7+G1QVLAHoHdQKg/fVg/PEZeqN4YfdwcpmqsRvwXKV
	bqi4bXkvMPAmcXLMzGaFZ1a6fvYBV4UnZ2On4PsgrdNdFH1WIqE2iU+nQGTgnfOOg1doB467fLO
	TktsKX0rLmQoxxuktlROXzUo2UJh8uf7vW/5Qe0mBeLRVY4f9fdE16v4TfBF+5eF4HxB/zzfwBv
	ZLz4asAIX2sUbHUegEnJxpC2A8Fz8WTuPLZSOY2WQLxAX12KxiKtivI3sUkEDtb1+YeH54BZV06
	Y5ZoJWqBmpjj/mR7IG7+qN3ECyPYKS1A10Yvid6soyNcw9U+/0QEDsUhPK9mq6wA1fgf46qm2jG
	9mRHzAxFcFSm+NBHdYZnyoJoHdkCkbZVzMLMs
X-Google-Smtp-Source: AGHT+IH3JPWOS0DLUyil1b34ustc0utkRSOtQC29MhKAdtiTZ/plXyMqVBnoKcCCExOEimHEpotgew==
X-Received: by 2002:a05:6a00:92a3:b0:736:4abf:2961 with SMTP id d2e1a72fcca58-737223e8ef3mr14365320b3a.17.1742238495369;
        Mon, 17 Mar 2025 12:08:15 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:c666:1585:cbfe:4666])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea041e7sm6298349a12.44.2025.03.17.12.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 12:08:15 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: support zero sized file truncate for device aliasing files
Date: Mon, 17 Mar 2025 12:08:09 -0700
Message-ID: <20250317190809.678626-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

support a file truncation to zero size for device aliasing files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f92a9fba9991..7ae5a5af5ed9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1036,7 +1036,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if ((attr->ia_valid & ATTR_SIZE)) {
 		if (!f2fs_is_compress_backend_ready(inode) ||
-				IS_DEVICE_ALIASING(inode))
+				(IS_DEVICE_ALIASING(inode) && attr->ia_size))
 			return -EOPNOTSUPP;
 		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
 			!IS_ALIGNED(attr->ia_size,
@@ -1117,6 +1117,9 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (err)
 			return err;
 
+		if (IS_DEVICE_ALIASING(inode))
+			f2fs_destroy_extent_tree(inode);
+
 		spin_lock(&fi->i_size_lock);
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		fi->last_disk_size = i_size_read(inode);
-- 
2.49.0.rc1.451.g8f38331e32-goog



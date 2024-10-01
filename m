Return-Path: <linux-kernel+bounces-345285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4AF98B418
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB2D283054
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29C1BBBE2;
	Tue,  1 Oct 2024 06:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtrdDxZ+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC403201
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762767; cv=none; b=C6i3XliJSjpfFzO4YTiDNnUsvxcAkkHB4p7ejigufmdubhem7c3y6U89eb/lRMRDDSofmAG/otzzVEgFnIUAzjK1MmJEeUoQf7rKtkppoyHBEadqnN1uOia93M36mhS/bT9EF5LDgIUf/VP3cHThJ5akf8CnnCnES1mr13cyUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762767; c=relaxed/simple;
	bh=xBnSAWMwOG7gxrp85jGbAeVXXQtp7LtuPhe1hy8Gu4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HLgTZJltC1RC4yreZBF75OsgEN7o/5luZkCMtw98MNhudUmYV5F+9i9U0FBo7ByELkCVmv5vKNcfIeTbU8vAm/uQmwCpR2rUaCuG3vk4i0dGiAzLbGIgWSG33Y+vjbEWTc5IafHg3UT6UUcObriKb2pLRqkzfmTNb22B/VJpEzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtrdDxZ+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717934728adso3958047b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762765; x=1728367565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3JnPQ592saNCClwG2EAIaq+vjHVmf3dkbYasmw5RK0=;
        b=CtrdDxZ+IbKTiMPS5QyFmU5cVYAGYqI6ihmj7QAAyLvF7hjAhpf54+z1k2j4uyk9KM
         eXTYkuh4He5O69uOQap+BPhb7zt29/Skk99tQgGLDFlHJDRDwvhRhtLKHnTWqlDXrj/i
         OzZ2+uv5TMEwqVl4Y3ZVqXNyzxLjxYFz9HejQWQVMQbB86XyR+AmmJIXn97Jt5srD4vy
         OjGJL2Eioc30lmE14/TTK3hDwJtAPQRvZmkBykTz+RMt0h54M/vzOfnyx8Ji8tvPe/F/
         KsFWVKzhLR13eyR24z8DAaHHdsl+1Ymk8IvG2FpDCPFk53BYHJrUwdzgjd/jUuMsAcHm
         Za6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762765; x=1728367565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3JnPQ592saNCClwG2EAIaq+vjHVmf3dkbYasmw5RK0=;
        b=iqXjwUC6OhiNt0H+kOKyEsydJfrX0hYAxJVg0iKn6yAsV+oHMSQSmmD3SkwtSQWkmd
         bUiAhAuY2biyvY0devzhCNxbz8HTABZgnsFnNPsB3n5C5YjFCet1YJjFPZYEJyWfS3uv
         sy+80QixesjaOu6MKSDTZsOkWKDs/uLVYfVECANgmIerhqlKiABltSdBy2qgfgqlh9z1
         pQ5xyxfyec2RBj5NH3NHFM7xKf6wtBJGySSv/Mg65e3Un58GNt727Q0sO6OFePv4fMm0
         N7D9yw/Zvh/ebTB4XBkx4Up7+opPDjOy0xBtJmaqv6Lv0mF6Lxm+qV1GmeMQFEcH64rq
         x5BA==
X-Forwarded-Encrypted: i=1; AJvYcCVaklU/k4/wUwI1yZvd9AXl0r+wCIskBCrGGNhxFhAG6zO2JdGCm8BQZ72E093VhcZGVTvm6+QGs+araUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuvb9m+u/DrJNCL1HO8vuWIBYibs7hDKz7pfpo5r/G6g+sYd0Z
	ir5pXyhQ85NScysM0N3JFDfPiqtHKB7oxzRVGN6PixPahqzFQzZjnBxySu9gXJOOng==
X-Google-Smtp-Source: AGHT+IFzh2uSZT0RhPv2Tnh/OMQvJbm6z27RebTeTUBWaAplciMMLoSvwWnHda+XCtUlhuYcyU1eow==
X-Received: by 2002:a05:6a21:164a:b0:1d3:d40:2060 with SMTP id adf61e73a8af0-1d4fa64d7ebmr20122127637.5.1727762765014;
        Mon, 30 Sep 2024 23:06:05 -0700 (PDT)
Received: from dell-xps.. ([2405:201:3036:a902:b102:83da:252:ac85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e421f0sm62963435ad.212.2024.09.30.23.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:06:04 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: shaggy@kernel.org,
	eadavis@qq.com,
	osmtendev@gmail.com,
	ghandatmanas@gmail.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix array-index-out-of-bounds in jfs_readdir
Date: Tue,  1 Oct 2024 11:35:47 +0530
Message-Id: <20241001060548.3090738-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stbl might contain some invalid values. Added a check to
return error code in that case.

Reported-by: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0315f8fe99120601ba88
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/jfs/jfs_dtree.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 5d3127ca68a4..c8f6e51ac047 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -2891,6 +2891,14 @@ int jfs_readdir(struct file *file, struct dir_context *ctx)
 		stbl = DT_GETSTBL(p);
 
 		for (i = index; i < p->header.nextindex; i++) {
+			if (stbl[i] < 0 || stbl[i] > 127) {
+				DT_PUTPAGE(mp);
+				free_page(dirent_buf);
+				jfs_err("JFS: Invalid stbl[%d] = %d for inode %ld, block = %lld",
+				i, stbl[i], (long)ip->i_ino, (long long)bn);
+				return -EIO;
+			}
+
 			d = (struct ldtentry *) & p->slot[stbl[i]];
 
 			if (((long) jfs_dirent + d->namlen + 1) >
-- 
2.34.1



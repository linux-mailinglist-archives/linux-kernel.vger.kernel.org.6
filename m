Return-Path: <linux-kernel+bounces-291418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5FC956252
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C6A1F22317
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D207316E;
	Mon, 19 Aug 2024 04:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpC1Qv5h"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D948801
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040353; cv=none; b=JfpC9JZmMp/antdyl74tyDgbZhSidLhuJMzkgxXx8wEwH5RebPvn92WnfS1dUdb7cxKbfQXdbtUvQSwc9ABIu9VRGrPglAjp7XWgOG7J3KBFwd8i+aL9U/YhJiTAise6ltALbEsWnpnM4WX5c7DXCumDMUKtju8FSAkyzuz4rF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040353; c=relaxed/simple;
	bh=xQtrGjfhwIWJr12DH43PXIzRgVl9floq8Ftm+aYmDb4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JgzNsxKq5kzZUdkXrCJCTqkOIF5Oq43ou+I2JNsvK5HowTloFcs13FNVaiVRQnhcotaJCXgsm4l37BoKpaNiHdguhmNKVfv3H6G2UCBUzBtLncRCcqWmcABC+Kspe5QwuqgDppTt8c2vi7JsZAPfiG1Tdkd4+fp2ttwZoFrF8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpC1Qv5h; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39b06af1974so15319015ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 21:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724040351; x=1724645151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4LdY4h9yDY+hKUVhC9nqU4DzmhWAha2389eTWEX1II=;
        b=LpC1Qv5hPUPqi3tLRIUqhboI182eNifvao3tC4XrqorbSCtkR8/43dOCaDyfYBV9Vw
         Ye1UyWlY7upcUWInV6k6XIrY7LupoAXFuezDU9hL82tKNexE8IT12eYF3JiVGIFUWmiG
         ka2PN5lNbjcz+s/i0ehxvH9tzwA5YUunqRDx51rQcV+NtvDSRtDQfEFqzARm5gKzptd9
         S9O8Q/xiRZ4nh2xO5OOODU9rg3Xt2RWWUpNdUNxfPgg+Z+5pbZt9VIRFsboRKgRGZLCE
         k8fSePsegMYyXBe3hWSmj60A9fVt4WQK/PKnZv9IzWz4vfAtNXR95cTaY38339Om39L0
         fcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724040351; x=1724645151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4LdY4h9yDY+hKUVhC9nqU4DzmhWAha2389eTWEX1II=;
        b=lVjas4d7tIypSwW7D39PpXlad8aDM8yA0i0upTg714t/8MvFQwRV8EbBDLIRcAiNqt
         2JEYfUXLUUj0Z/xvtW7rh/8wZaN1fu+WRIs/s8nsws1AXdcd6btU8JqiSxuxuh6qUE47
         5KW9RWr5v7qgwbHWALFDk+dIISZWAL5uaWeHN2bBFMfmEHBrrsQ6HRk9vt31u0fok46X
         EUNnGV6BEaUgn6gdXx2GSDcNnR3yVina1QaTsdWEhjbvwSSPvZuNmXkhjioJRRGgEZg3
         W3XSdZ3+Bw4zX4VnhLtJIREl5btR4+EKU/vjfb91HxPMm8A/cO1bt8AVPbea9hZAQiuE
         Ex6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXApk3xcLuBWOho8SvmaZziILZCVZOC7SDVjQqB2cv773XA/Gz8LbfF8b7NfY0ILPKI/08GUhogHA650TgMNtFSoNRsIBvAt8oMQPOF
X-Gm-Message-State: AOJu0Yyj7RtVDz5IbjX8068ZACxEqOZqNXLesi5UjAlIkWKVZFVX41eG
	oIWLI6Y4VAj8J4kCJxvjnWrhqlHF7DMszBzUZ2sCh3CootYzWaQSzBAnhlTZ
X-Google-Smtp-Source: AGHT+IEAjUCYT3zvHCA5MNy3LVXViK+m5Io+GneJY2cR8IqEQqYk4M3N0sbqa1ZdqpP75SHBKW+CiA==
X-Received: by 2002:a05:6e02:1a41:b0:39a:ebcd:f2fa with SMTP id e9e14a558f8ab-39d26d64460mr124287575ab.20.1724040351297;
        Sun, 18 Aug 2024 21:05:51 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0e246sm5855581b3a.70.2024.08.18.21.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 21:05:50 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: shaggy@kernel.org,
	dave.kleikamp@oracle.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] jfs: fix out-of-bounds in dbNextAG() and diAlloc()
Date: Mon, 19 Aug 2024 13:05:46 +0900
Message-Id: <20240819040546.182577-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dbNextAG() , there is no check for the case where bmp->db_numag is 
greater or same than MAXAG due to a polluted image, which causes an 
out-of-bounds. Therefore, a bounds check should be added in dbMount().

And in dbNextAG(), a check for the case where agpref is greater than 
bmp->db_numag should be added, so an out-of-bounds exception should be 
prevented.

Additionally, a check for the case where agno is greater or same than 
MAXAG should be added in diAlloc() to prevent out-of-bounds.

Reported-by: Jeongjun Park <aha310510@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/jfs/jfs_dmap.c | 4 ++--
 fs/jfs/jfs_imap.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 5713994328cb..0625d1c0d064 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -187,7 +187,7 @@ int dbMount(struct inode *ipbmap)
 	}
 
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag) {
+	if (!bmp->db_numag || bmp->db_numag >= MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
@@ -652,7 +652,7 @@ int dbNextAG(struct inode *ipbmap)
 	 * average free space.
 	 */
 	for (i = 0 ; i < bmp->db_numag; i++, agpref++) {
-		if (agpref == bmp->db_numag)
+		if (agpref >= bmp->db_numag)
 			agpref = 0;
 
 		if (atomic_read(&bmp->db_active[agpref]))
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 1407feccbc2d..a360b24ed320 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -1360,7 +1360,7 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
 	/* get the ag number of this iag */
 	agno = BLKTOAG(JFS_IP(pip)->agstart, JFS_SBI(pip->i_sb));
 	dn_numag = JFS_SBI(pip->i_sb)->bmap->db_numag;
-	if (agno < 0 || agno > dn_numag)
+	if (agno < 0 || agno > dn_numag || agno >= MAXAG)
 		return -EIO;
 
 	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
--


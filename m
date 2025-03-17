Return-Path: <linux-kernel+bounces-564257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFBBA6515C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63562188B08D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E123ED6C;
	Mon, 17 Mar 2025 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfSYYJuZ"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0523C8CB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218587; cv=none; b=TxEhNY11hGdvXsg9/MFw01V6jOQTe9E7VAgpSKiAUHF5EMadwmAe7GYuf41CaGWDkKo/jvpu4tTMW0UMo2ANycLpyCya0SPqN56h4u4s7NzUXkOHenodkX/g+kl4C8gVN2cvgLW4hwgfTpf8zAJZ2bUDr4bYIP6RijBHB4UpvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218587; c=relaxed/simple;
	bh=QYlOTvKnAot+q08w8OjAMKOdsROqMI06qgSpvcn5inA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o36Rmx85+7dYEBY7yL++xSn4T82FfvuS4ihZuzAJ+clAJjpvd61YOYOx8dAcKUbd6jfTJvDcZPFOquBl7kKvqyZs+LhBDt5JUdAZng0LgB1R2Cw4OKCm4i1cC2v1OqwTQq8bH94Fztr1oEkZ64MwlYlCOTOh40iLLHQ2EWCb1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfSYYJuZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225df540edcso50866085ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742218585; x=1742823385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tu5yq+Z5UcezHFhkLMRIHBy3lHCFGUdQJWiAN9EoyBw=;
        b=FfSYYJuZ8mV640OOjMvSILg7aNWJJw16Cy0qnf6IuVkeDbj9Je88YSRQYrP3BR2txE
         UuQLF96zgpC7yHiISetvBMxjdcwqXtNyZEvgr2ysdFwwDRdasMcm1IYbsNX4QXDlc1O+
         ALgRnQPjrOzgOU6Ol2VgNHmXivOOCWHuMOHu4wDWujnBnPuFQ3qa6ZIKGRT9WNJXgNI8
         7fUp06LI11SngM2J/9Ciz5RZO+YXNl/DmGZAAmYcl5YG+VI//Nwvmdt2Zv7Z5YGTzvPC
         KNT4WuXAN/qBTSm4cd1m4ywB1siYYe7VS1vSCAs32MOCkQ7d+/t/7Z4Oq/IKdgvSRT4P
         flnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218585; x=1742823385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tu5yq+Z5UcezHFhkLMRIHBy3lHCFGUdQJWiAN9EoyBw=;
        b=edc7+JOeisIxrEIkhb+sJch9WfdvSSDYPzqLOA5tgFBt9X3Uqu10tezD+EjnYyIwXR
         NvNM8b7sfeiZcqE3sDakpsHE97mojkwwl8oOIhi12M59o8eoDrM+Ifpmgx/ELtV4BtbU
         vrtrSPcS7c1LhjKCc+OgmukCdwsKUP+5tptPR6yKd9VgC5K6e2pGDjlnZiQoFpEhEGy0
         IMyD21QXrAGQlJTQKWNTgmHlCRRMW30pouGegb8/NzpqST2mdGm0lYUv5RwViN2h4Ps+
         Xum3/2BQq/CBrzlv2xU406is5I109BAIrq8ALhxqGMDq8cSRKyD9LOIW75i4+z7zVLdS
         M63w==
X-Forwarded-Encrypted: i=1; AJvYcCWoU4qWVkiBkeNS4qDSMgcZIfrnYz25fVN7T61rQIjR6h5TbsynVxGY6y5fJ5yugGFsFUgScxRpMb09CQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweVgbgvxu3uCKxP/7c3Rc4I61Yvc41HTvdDzaC5Ti8TjQmfvzg
	vW21QKpI7Oc0Mu9l5IFv8RvTuPw+dgSnQyeHl1U3RGttQKDXDtk7
X-Gm-Gg: ASbGncsJqo7zB/Rv2SHebq/8LcPrEXoqMrOiU0LwyHv90wjBjfWMy/yiEgDml6rtKml
	Ji5XbHhMvkV73z27OdPsC0nvhWvx0oV5kq+JSQz4ysHYfcyMhypVpnJBi8cHYq7h+M/2jNdSzss
	QP+mJ5h7dOQccAbRi+p6jkXMOg4PmAg1TliZTKYnlYGxH0yP0Z8oKwqnNA9/enr45aBP9QrLvuj
	SSWR+AaLw2xMtX9V74hlHpelTfMmzgl3I25Kyt95BOckxvtxmN0fGudJZSpGiP4/8zs02/CQbQP
	W+CTV4qwtDbsTaIseCQ+a22TV2CpJ5ulJ8eXkAddHFfqB0n1AIGNcOJ3svpzSxvsqjSunw0ykw=
	=
X-Google-Smtp-Source: AGHT+IFgvFfnyg29CPjz6eKDVq+RV53imLzWb6rAEgagFVoPaeWhCJCLeWZOmRdniuqFt62X1T+5jA==
X-Received: by 2002:a05:6a00:1255:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-737106d1ca8mr22103745b3a.1.1742218584658;
        Mon, 17 Mar 2025 06:36:24 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7daddsm7193397a12.54.2025.03.17.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:36:24 -0700 (PDT)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH v2] f2fs: optimize f2fs DIO overwrites
Date: Mon, 17 Mar 2025 22:36:11 +0900
Message-Id: <20250317133611.457-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this is unnecessary when we know we are overwriting already allocated
blocks and the overhead of starting a transaction can be significant
especially for multithreaded workloads doing small writes.

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d872f785a996..d99ec9370b1d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4181,7 +4181,13 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
-	if (flags & IOMAP_WRITE)
+
+	/*
+	 * If the blocks being overwritten are already allocated,
+	 * f2fs_map_lock and f2fs_balance_fs are not necessary.
+	 */
+	if ((flags & IOMAP_WRITE) &&
+		!f2fs_overwrite_io(inode, offset, length))
 		map.m_may_create = true;
 
 	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
-- 
2.25.1



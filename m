Return-Path: <linux-kernel+bounces-557830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6AEA5DE54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC213B01E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAAF24BBEB;
	Wed, 12 Mar 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOk37F15"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EA24A05A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787293; cv=none; b=QRPj2hjMsf9jhlNREgEg0RcDq3d/fTQax1HKO/fRYcc/GBwgzzcoIXO9iTKGtqWgiQliJPvG5k5lMRnBhtMZvRFSG8wPoMYB4cCzVruaropEgSS4E2Yz1TRCNbPB3awmdMAc9QoJwr6Gt4dvU6GUUncUeASLRM0DGcLoOJ/Z1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787293; c=relaxed/simple;
	bh=IKEIP4fJTqTXMvwxjbKhs9aEDZULEhMuo2mc4NOJOSI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKeLxlQlyg3q2Rsns/8FFENwepGbiDugYAcpxp2BZSQRN1n+anRGC4nvBWif0u/3s5nYeW1CiNrqiFqArzYvgpfA6sOaPPqoDyRJuQ6kDzBcyJHOaS7upRFDeTSevJnfZo2euZDsvznvbXpZo0mlFVP7D1qulQBDTQwROv3+Bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOk37F15; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22337bc9ac3so127800395ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741787291; x=1742392091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSwDKAAj0pO9DLdE+iZ6p68KGUCERNcDNq7Ff/vTm8I=;
        b=kOk37F15Po2OOP/wNwiGFQXmH5wSRULk1uFXBK1Zk/hsDJ0qUvC+dRUEZGrfuth3ME
         nowRfYgrYruNZ93naPVAbrBLQvA3W5LRD18u8TUvhEPDAhZikQbJoJb6+p0F8Ubz5Vb6
         uYwZL3q0LknP2j3CDKj8+AtOR870XCnXnfjMRprfFd3lVxjQSOj3ViPWSqKUlxiT47q3
         itYuGpzt/lViry7YfPyY7ZEVHH6c2R8pGgLaV2s5Q1b2s1w6RdhVH9mdk093VnqU5dQc
         P7e96G4Fi7duXZrUFT1w6S18xB7nlPMrRTSdQ1STYnQ4zTC4HRf/NHq4LpGqEQdnzr/8
         zU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741787291; x=1742392091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSwDKAAj0pO9DLdE+iZ6p68KGUCERNcDNq7Ff/vTm8I=;
        b=MbdqRwf9hv5ZprNJYOXJpFYmm7uoQVru/SGSa7iCQIzaWpBxG2LfGUVAzscVTe6+jv
         pxVMFemximaxYLhplQiiWDPUixWbdOjvnB878iaVu2JeDmSYDq01ayom1T9uwWZspRzn
         4cOfafx7db+HBFvf1PWDNoCVsapEWyaJ+neexormR8qs+qImlhaPycWMMAXYCcl6rBNh
         I4fXWLpFMCN/I59ELHMdUqt3RK8BQloP8awS4MlQ8DWzw2djOJT3vcND1RgUEBR4kNb7
         slMaMI51Q0z1XiUv+oRNu4EHxDhyqGnqlcOdiqiZxHe9j52lSV25erip9jTRo1vwSV3K
         lFkw==
X-Forwarded-Encrypted: i=1; AJvYcCVTgQP/noURzVt8DG097nWXjIfgkYYecoissUEdQhWL0CB6+knqsd4d2h/k8okVpxstBqmsLH2KBLUUuFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSgpFVPfUDH7VobwF4zqkKiFVd3P2KHeih96ZSO235QroSpD/
	Mt+oy6V8tsAHSJjntzm5PAbA3xz1ebpmSEuaXib9mZ4ObxCVSgcx
X-Gm-Gg: ASbGncuOodvG8GLsTq4CYcimtWCd9LxNYMtC7wkkCSCJZh5FOcMRkaP5rTOx/JlvVzJ
	o8WbWzO0IKCMPb2y1dYIbwkuQz4A7ak2IaxrTeakyGtjv6irCh3xra2GDoyCBisTxyH46zS735C
	ZzCen0vGuA4AqgT7pMhGXMM0m2igSYBrSXqJBXafmAYo6xKsqSzeWxN0VCOM+A2nRY19+mey71r
	3pJKnSyJz373DwM8eeSBHQF8loZFlNlP0Y8alUh9cNytLemYr/rXSssoXhlbtcSv6VLTv/rt0iu
	KZDtu0kwu4mVfp2AldIt9+v+lrxVI50BcCghobWLnmQAT/M1Xsac8vBlLCyBjhwsvUqW7FcoQg=
	=
X-Google-Smtp-Source: AGHT+IGIq/cWnHt3emJsrqyh44YzFU/yOq7HRAOXl+9E6iIw03sZKbZ0/BJgI36js0tMzooij4tuWg==
X-Received: by 2002:a17:903:2308:b0:220:ce37:e31f with SMTP id d9443c01a7336-22592e2cb8emr105011415ad.17.1741787291606;
        Wed, 12 Mar 2025 06:48:11 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f9e0sm115591195ad.113.2025.03.12.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:48:11 -0700 (PDT)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH v1] f2fs: optimize f2fs DIO overwrites
Date: Wed, 12 Mar 2025 22:48:05 +0900
Message-Id: <20250312134805.362-1-yohan.joung@sk.com>
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
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d872f785a996..b55d253f7be9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4181,7 +4181,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
-	if (flags & IOMAP_WRITE)
+	if ((flags & IOMAP_WRITE) &&
+		!f2fs_overwrite_io(inode, offset, length))
 		map.m_may_create = true;
 
 	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
-- 
2.25.1



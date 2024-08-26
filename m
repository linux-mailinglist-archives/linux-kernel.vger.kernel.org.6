Return-Path: <linux-kernel+bounces-301671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB15995F3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBDD6B21470
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF5B18C907;
	Mon, 26 Aug 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Qtk8/oNd"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAE188934
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724682500; cv=none; b=ckQIuXwntYpTtXL10w8z7Dkgp8SHzblzRf5hDqWs6QdfsC0DnzM17kuufQWmhtionL2rXcuu9z8Ibtw5UxwTodigNTYejwtCAVCVJ+Q61y18B+72fY+wJHb+VExASjXGeqzFFWF9yy8Q8LDVFONgepqHh3cX1jNoG3/PB46vD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724682500; c=relaxed/simple;
	bh=RKnVRf/nil6QQnV4ahq6WMo7sI1Rs57zGSIKSR5JaL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcVKPp0QpdhSv+lb1IRMhaXPo4kE4HD/wVPz1jR3iVdVZX3y1U0vN41PTrIj0HtCTBJdaUyPNgWL46b4EUvuuUc9zh3Ev2SBBEHfIroxJvIya23ZbCxRcHsyeMn9A+BXPwgnlJMlMbnH0Rw8VNQyvo33019/9SNRwLEXsPs6hdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Qtk8/oNd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bebcdc75e9so752746a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724682497; x=1725287297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3HQX3W+V5qFpoRZmybHNvK82qQ8mjp2N+L1Kl096Fk=;
        b=Qtk8/oNdDb/oJo/rEnAR+d+mPVsyf3FRF4hDTgw23LteSj0Wl/U1NJ7KGkVWxyVEun
         sNb5laGlmRGfaASOIVYtmb9MeVm2RDcJvrq8z5gZkKF59SEqG0a17jxqicqFNWE8e5/U
         7DxpcPG90LqRSyRXW2+sBjnIko0L1+Wp4GKkZ5ju04E3Vn/4NuNcSWSbvq3LEsN4hSdB
         cBxqKSh66qBzILqo2MJSqAVDXDUyOf2/01Dqdoo7aoo2m0MxeUebRVq5xfyDed/iiz/X
         pGsLO+hBB8MPGJZZgUUi9NmUSxu1Ohji0SGypE4aujFR+HW/3aYVwZhIxduwhoBu2lFy
         o/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724682497; x=1725287297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3HQX3W+V5qFpoRZmybHNvK82qQ8mjp2N+L1Kl096Fk=;
        b=cedw63L2lWaDyGaO+2NmBesgkN/1/yKVtzBnecc2sBRdosq5tufO21HGK16Sg6h3eh
         1TcGj0hTN+r7mIG9quKD7xXMyGxZNLBmEMEymN/B6Iengh8C8nmGRGwHdQaSeYdfDAFi
         a9bOGhoawfx1EmP6GuodPSL8y8NELNUR4ugQl7Ex3I2qIqvV6ntUvdS841VeAntA/e7N
         W69v63INhH4NgbhOWbWPqa2XIt8NRsTveUOWVU8dT1JWN6+EV+qO1Z5fRpY5hdOqY/71
         hfARNRI8U4n+t/njgGblz/GDDrbHf4+o/ydZXWAcKTc3QwR5ZLe60kVLKW0+nFYp2W/w
         cenQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdjXM0PYZNMVukT67Q4rQ7e9QW/9isJnFONjkl+uuS7v+OxMDyWmqUELEUFpD1RgeI6N0IX0z5NR2t1iM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95bl78YafUjepiCvVN6bvT7Cz5oQJW1IHCgwRjQupJ2ZmYTrY
	KO0I61dpZ/kSVEHBDSZMD3Dp71hWvujDLP4jVhsQOvWMSC6hIxCsyvuSs2hpKfM=
X-Google-Smtp-Source: AGHT+IFwJaZG3S7tk1ysm4uwHbvobVf83RisE4PJjZcv6t3t0iyRMBmhEYrAbSzdsWXktT9+qUBb+A==
X-Received: by 2002:a17:907:7d91:b0:a80:ed7e:8468 with SMTP id a640c23a62f3a-a86a4e5897fmr401349066b.0.1724682496652;
        Mon, 26 Aug 2024 07:28:16 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f43795asm677885066b.98.2024.08.26.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:28:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dsterba@suse.com,
	gustavoars@kernel.org,
	kees@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] affs: Remove unused struct members in affs_root_head
Date: Mon, 26 Aug 2024 16:27:36 +0200
Message-ID: <20240826142735.64490-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only ptype is actually used. Remove the other struct members.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/affs/amigaffs.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
index 1b973a669d23..9b40ae618852 100644
--- a/fs/affs/amigaffs.h
+++ b/fs/affs/amigaffs.h
@@ -49,12 +49,6 @@ struct affs_short_date {
 
 struct affs_root_head {
 	__be32 ptype;
-	__be32 spare1;
-	__be32 spare2;
-	__be32 hash_size;
-	__be32 spare3;
-	__be32 checksum;
-	__be32 hashtable[1];
 };
 
 struct affs_root_tail {
-- 
2.46.0



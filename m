Return-Path: <linux-kernel+bounces-543162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 968ADA4D244
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA54A1709BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F21EF0BC;
	Tue,  4 Mar 2025 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="kf8oUeo+"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D383BA38
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061155; cv=none; b=oa9Uo6iQhcob2EXF2tUQz+AvlVt6sxKDH9WtFQn6FUHVy0mMy30kuro58/zn2aLOCo/Y0TeLAa4MSN/xA2b8q71P0TtHt7a3ccK8nnRMXrpX9Zo5Ztxt5K/zzqOe8nVmkjBksQhuf+j44alycX/5BmEaP6aiuim7xGOt7JdjI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061155; c=relaxed/simple;
	bh=VM2t+jylxMB2T771kmAuUS21X4Kndc0vcr8ru3CPI6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HrBknjIlk4333M6CqANIpFBTdlr6vQomHD7dp0VUIAvc+z5OtDiAlNdzpBiZDfFK5OltpNc23BNtHYpFgr1X0Cs8b8zHNCWOM/6zIjRmTY9bngrChA5kxnkOgeC0WFiUPw0A7vQeQbXwcznvF+o0Tn6UEgmtN0xTi1/7IXOyHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=kf8oUeo+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2234e5347e2so104170725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 20:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741061151; x=1741665951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6B/YlsPCXj6yKOA081X5xsFxPwPhBIXGZLI0eUqTn/8=;
        b=kf8oUeo+5qa4Cznd4VFeIEG7KCYX0fdo/U+qYHxo5clvZqupfNntRZ8Tan80q8aFrm
         P+pF/rHS0CUNDuN5We3eoxrCLAbXPP14cVR6nuC03aU3v/tyknQX6fmb0u8XhflYS1od
         be0kZ6hIX/RfZxwtUWO8EGGFlfED/PKYSFexFIdM98p3nR715WcW36B7s3bhokeaDXcN
         UkycbRQV1oTcX/6TpsQaXJ46grIJ/NKXyDSoJBLdbPZy72zkaLo/fYC5jTW8SnmcCDup
         lcxyUxi/GqoJibO3P3mJ3THG2AhdmCZywGc7T/kdQn9HX28EFGLWkELbTCfcfitYU9vr
         d5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741061151; x=1741665951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6B/YlsPCXj6yKOA081X5xsFxPwPhBIXGZLI0eUqTn/8=;
        b=fMMv8x8jYw+XbF90UI9ZGMqp932Y2LA5jKNtGhP8lL1D9kTUXPSCyEbaD/g+QskMcR
         MByUcDp2DXytXvuWjNK7MIX0K/OozMEj06XVz5lyupzGO5ZBH/KgTCBz4CA+F69C8RR2
         JYH8A5bAR77XJGZ2ctTGyQjd67Aflg6fQeOyCjZlZ72tbV73GaFWKI/oyqWPa/WAjVei
         QI49v6hCQlGyPqyqC57SjY0vAa0EnQyruRT9DhxFyKuQZYlpzE4NrFwa+2dnZUu0sENY
         2sumF5ayG7Dp3PQMsDfPP7IGKaa+DdV5UH6CxtewmIsfcfH8hARabRkxoA48SjGbbRw0
         Zp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnYCJUjWuDMW13ZlVhdL/0gx/tHhQMP8Un6uH2GDBvI8E/tAtN8DLGdpZyhp1qFKmINGD6bvVH9UlFdnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23Qwj8qNP8NeEce94xR/IcZ7y5Vw3kUMbJOYE5jVFJcdWn1+e
	/UN9dUX8MICJZZgR0R81Kmnn28f/64bKPa3mGCIFIzLL1pcE5zW+Zn+9mPNi5h4=
X-Gm-Gg: ASbGncsW8/gHSb44qsnruF6bVFxHCwJI26ygXMh2QhK8C2wx2mtHlc4HlpHKSCNrVKX
	4XYyn+NqOsX865eBvufz/chEJrKaaZi+TeqO3nbWFRpFHRfmnPWlPAlKv0/EIVWS6oCMPDgmhVi
	2gcQzeLsJSEhqzMuM9malk8ZP+ho95VkNER7opKqHIF/mDfC7rhfgS2E/VK7xH2osdlYhApg/bm
	Oue0o9GVP1rtbasNNbiWYIClnclqDRGCNB6wrS+mEZvov2tAkmnmD25RslewGNFadbCBrcbaGr1
	iRtcbqmqd3m3+XiaZ40SVoipn1BIMg8sCq15PuxbJuJQ37Ag1u6itNKzyeovmdggJ2g6vAv0xQg
	v/g==
X-Google-Smtp-Source: AGHT+IGfCVdejojVJj2Py5zdVgtTo9BZmtMnWbj/yAlgz1ojCDYJf/ViDIO5m5g6t94u2uNmzJB8Yg==
X-Received: by 2002:a17:903:f84:b0:221:7e04:d791 with SMTP id d9443c01a7336-22368fc97f7mr243723755ad.31.1741061151198;
        Mon, 03 Mar 2025 20:05:51 -0800 (PST)
Received: from MS03-CEO-004.yan.office.furiosa.vpn ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050fdafsm85296075ad.214.2025.03.03.20.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 20:05:50 -0800 (PST)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: rust-for-linux@vger.kernel.org
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] rust: add cdev for rust bindings helper
Date: Tue,  4 Mar 2025 13:04:49 +0900
Message-Id: <20250304040450.697235-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds cdev rust bindings.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/cdev.c             | 3 +++
 rust/helpers/helpers.c          | 1 +
 3 files changed, 5 insertions(+)
 create mode 100644 rust/helpers/cdev.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f46cf3bb7069..07145905bc10 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/cdev.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
 #include <linux/errname.h>
diff --git a/rust/helpers/cdev.c b/rust/helpers/cdev.c
new file mode 100644
index 000000000000..929aa5359a47
--- /dev/null
+++ b/rust/helpers/cdev.c
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cdev.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..6aa69761409e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "cdev.c"
 #include "cred.c"
 #include "device.c"
 #include "err.c"
-- 
2.34.1



Return-Path: <linux-kernel+bounces-570673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07F4A6B34F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456974A11AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEC21E7C3A;
	Fri, 21 Mar 2025 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oa2qWL4w"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D521E573F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742527599; cv=none; b=E/etDnF5Pj2RPohVx5LS3wNsfuMh8Do4cgV+MbPWDdbrtmXWS3Sq2K2wLBiDaWDbEh3Q3XNIIWd7kw79INaI0JX+dc5vvfjE+/1hRj5Jl0HbsgYUzsB+8GzjIjQ/0mrxuoWbrDqD9v+s2S24y0NhWyQMvar5QNk7m5beh+lKZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742527599; c=relaxed/simple;
	bh=9sel/TGeOHPtzGs+DixKN/Yb9nNk82f1qhbomy1ogYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNwlwmI7D7N4ONV325Gu5aY03QMDSnWxndK0qZdTayP+C/Zjc+guL1TDP6zjl7bXymPPRrdZ2QR2ZqxeW1PmrE+7JETFM5XbV28Ul1i0zlnl86b5HjooyYm64lVcdgaPpAaVwI71pG5Ko2PzacQ52EJyzRmOzo/E3vcIfkn6Q2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oa2qWL4w; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dbe706f94fso302004a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742527594; x=1743132394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ9H8QEyhvsXOExXNy9mh7yGjSUNG99AQ7uN7DVOsts=;
        b=Oa2qWL4w5KZGDu5n01O41VMTddhVeNA6B4wVGCTW5eLYHjjBBxLXg6JJA99m1sJ2qw
         6J49NWt1uz3varfwF3Uu8HW+gHXjU3gEt5jgolx59o59teK4KTver9CJJjRkMsDITly8
         BAIBnGDd+iHTWGVi+c4/NS5OgsgAKof4roQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742527594; x=1743132394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ9H8QEyhvsXOExXNy9mh7yGjSUNG99AQ7uN7DVOsts=;
        b=DRqYjgrbVtyLM07YGLPAnlIj+RrkWVRT3RrziBR7nJ2BXMw0/g0LbrrzlG79sQR6SX
         UU/Mkrpp1ga0giSUH4MMmcU5OKI5cVq/xjduzmr2KwPaRlpUilomsteVlB46Jm1X3/V0
         Of1vhVfQMkD/tcMTcb6JDZrr/xYdfx9n2TZbp7AOqvpLhutJjmY5E6KKEk4nLFDNCFId
         o33e+kugrvITL2yPxky4HvnCxzfwXf1hrEuiTW4HNR37SlE77IEzYb5RC2TpCbFBPF1E
         GhHnOsxD5zfcPOIEqavdPdGMmN7G5Lvh4FY9H3YZzK1h+nT3uRU/GkciBw7fbRj4/8LF
         1e/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLRN2tkY7LslPgX8LJi+HPdS5V50TXgtteKaKTWuT0s+ZiTO6bpSuboaNQcC8A1EAAMDlFrgIDYCvk2jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkL9X4rj+EqTX+ISnftIUZ0RdDgYGjcXYd4WI4NA+6H6BIYzUi
	j3VQxYamaM5xOxaEqjCSGrpHQA5cqLRk4Svam0ZZdhdgb+1zYmAgM2k4rQrlkg==
X-Gm-Gg: ASbGncs/tOZ8GbddP0paVhJClqcA4FwfD/xw5cy/idKQ4BHdhQ+fMUKodE0agIntPmu
	divIQbtzZdPkpMg+VS3WQmp9Tmmpw1YBJkYxC/HgxtySKdyjzN+nDUHPlR91upoNBtMC1YMWJg3
	AP1OmY5CcukgxLJrj8DssONkGxgP8YQnFfzcmBEYpeWmW0TUoZ7eB+GtFisb0LsC3lKSFgm4HHh
	OddrckgMFZGtG5tHfRwB/4T643i7dI6uxwzXw3p7oXBx7bTaps7L35c5xNUSYnK9mEbnUA+tJUs
	RhNT7rgdLA44B9U2Q60JfUxTLZ/anJXAN+hRdZu/Mvil0M50iAvFwz9HDeBBuzfLXObLmT5arQ0
	y
X-Google-Smtp-Source: AGHT+IHEiM4USR8v0yKc9mvlnlKTy1FjH278fWhQq4k3JCHnkCEvuH56Kwg39a1beQcxRMNG/fRxMg==
X-Received: by 2002:a17:907:d84c:b0:ac3:bd68:24f1 with SMTP id a640c23a62f3a-ac3f24cddfbmr63031866b.8.1742527594590;
        Thu, 20 Mar 2025 20:26:34 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d3f24sm68463366b.57.2025.03.20.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 20:26:34 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@chromium.org
Cc: Liam.Howlett@oracle.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	borntraeger@linux.ibm.com,
	edumazet@google.com,
	geert@linux-m68k.org,
	gor@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	hca@linux.ibm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	m-malladi@ti.com,
	svens@linux.ibm.com,
	thomas.weissschuh@linutronix.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v2 1/1] mseal sysmap: add arch-support txt
Date: Fri, 21 Mar 2025 03:26:27 +0000
Message-ID: <20250321032627.4147562-2-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250321032627.4147562-1-jeffxu@google.com>
References: <20250321032627.4147562-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
new file mode 100644
index 000000000000..433c71a2d007
--- /dev/null
+++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
@@ -0,0 +1,30 @@
+#
+# Feature name:          mseal-system-mappings
+#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+#         description:   arch supports mseal system mappings
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: |  N/A |
+    |       arm64: |  ok  |
+    |        csky: | TODO |
+    |     hexagon: |  N/A |
+    |   loongarch: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: |  N/A |
+    |        mips: | TODO |
+    |       nios2: | TODO |
+    |    openrisc: |  N/A |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: |  N/A |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
-- 
2.49.0.395.g12beb8f557-goog



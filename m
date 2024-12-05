Return-Path: <linux-kernel+bounces-432989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB3A9E529C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1243D16999F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE7B206F3F;
	Thu,  5 Dec 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GKbOJGor"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AB207641
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395146; cv=none; b=lLy3VfUpX9mE7oKloP9il0qexSvvrPTK9zEy9uqu/QySPrBzYmthhwidp5bCL/MODlJ88XwC5dSdcnpK1XlhhiIvSBiA4cGTf7u8cwEZ7rjldzpgU3cuCE0nEHZJS3i/WwU28XvLHZIOf6RoL6LjmOWaDbX4AXG4TVtWe6aJdUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395146; c=relaxed/simple;
	bh=U36m+IR6a76y9eKhACyf0YSUXrTJZS7C34HEKpBkfgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4ngkSZMK+Wvjpbv0VQPvk7DsECyDRnvVNVl1S0wZN/IeUNwGyxQvnw3qb/gpi0qscvHDuYTeDwFLrF8uauEInVFqKXd+F/EjkjvX4Uk41jTRguvkUQlLSXFiOSthwJlRiM3xuzG0ibWYAtZAcDK5BoW1VaKFS2QNzB5KOxoojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GKbOJGor; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea8de14848so538363a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395144; x=1733999944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDBjWSESYKBIcxm/6NEJ0fQX3zIek6Dl7/vbsKDZ5GU=;
        b=GKbOJGor1wcBGJZwL9QcDfKDLmhE2PvOUAbkSSqywM3Zs1mysvDAetn4+pyiuPskZ1
         d8q/MOyq4ryj4OWGodv1iTfdfcq7A8c4z2KmTFKI2qSU/XjjRCgbcev4gqZwiP9LbUM1
         Ls65SSMdRCY7vKa4YRKvgx6IUWod+WvnAHmvIjTTdiiidoRgZTMhlaOv8QXTRGGqq91r
         +2yK3a94JhXgXWsmsYO2gKdVCOeQROQGFTare3p3rx7ZlryQim3e6En7iBkQKR/qLvPN
         6GPixlwBK7ioVKXRcDHJgGZIComZwvDpS7/Xrh2LZ4AleyriUH0CRrGXZqyCwBwuM1Hq
         ZUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395144; x=1733999944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDBjWSESYKBIcxm/6NEJ0fQX3zIek6Dl7/vbsKDZ5GU=;
        b=F3OtxMp5YG3F8DiFWDDkSu+6NWtQJfQ0ztNvtbO/fsb7S/6HL5Bj3y5m7EOGegLlsh
         1V1lURhbpNKKeMTqe70CqFBK/zGngSNXdE6xSulsFa6nsAUJKwYX3bbhUyRhay6MVSxF
         7jwtHCF4OgnGK8DVmHf/J1fSsvywze/1Dk3y8cJTNLod450PwTMVDMwcDtVgTSB4pBzP
         g3FgpYdGFldLfQoLzcfxZKZ5R4ATdwlSwRYt32iOZlxPjj+pXTb+0R5LXvVrkmjjj0wc
         /6ZaogfobFOuTDkqhzCDKzSkLyk4fgMLP7PLRNFdYsqRLX5JOaddZYFQE7r4YYny06WE
         vOUw==
X-Forwarded-Encrypted: i=1; AJvYcCXOwryA74KHPzkfTpbByrtzUofm6VzuVMImJTwg9SOHgGvFN/5mK3X0Q86bnaMJuxppoBjY/pm5jvDdNB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoabZ+xM9yiUMADcnXcnKXVsTprQKSBxEnMU3vUllvLE+9hgvO
	5XcwX/M6VjzhsanD44elHSpQ3a5a8Xb/87mpkHoZ2woAO7UAlFelP8xIG36r/tI=
X-Gm-Gg: ASbGncufbP20u+W6mGpZhQ6w0r5Iy5eZ4GiYV93h52JNAStP7jGktlITCUZL6LUJoxQ
	zxrJSruUEtktlZoOnAGnve6YhSMqoeay1qhWIfFCwR2SmgjFsrV9bi4ZCy4j1XJz1YKGnfeoO54
	7G9OR9wFopSgU4qO2gWaGcyNhtts1WosjPxi+033un6X3etNH6pbsezpDwXqP0nKbW1/3j2WxJE
	q1Jz0RiIBW6cA5RFH2xps4/DmFq0YBZzqvbQFaLuA/Cya+LkGkb8He6fh2GAW09ivueCQKKqxUy
	mPOXeAFO4Gl/f6cl9/TpVaDI3pWkzXcA
X-Google-Smtp-Source: AGHT+IHKuqD7zayvSRrPEZJa2a5jeQV4cpoc2Wz2fLw8d8qFILc/CQ/vzSdEu/3MiaJEA8awaTzYNQ==
X-Received: by 2002:a05:6a20:3d87:b0:1db:d8a5:7c82 with SMTP id adf61e73a8af0-1e16539f381mr15601577637.5.1733395144181;
        Thu, 05 Dec 2024 02:39:04 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.39.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:39:03 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 21/21] riscv: mm: Update EXEC_PAGESIZE for 64K Page
Date: Thu,  5 Dec 2024 18:37:29 +0800
Message-Id: <20241205103729.14798-22-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/uapi/asm/param.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/riscv/include/uapi/asm/param.h

diff --git a/arch/riscv/include/uapi/asm/param.h b/arch/riscv/include/uapi/asm/param.h
new file mode 100644
index 000000000000..1221e570a077
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/param.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2024 RISCV Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef __ASM_PARAM_H
+#define __ASM_PARAM_H
+
+#define EXEC_PAGESIZE	65536
+
+#include <asm-generic/param.h>
+
+#endif
-- 
2.20.1



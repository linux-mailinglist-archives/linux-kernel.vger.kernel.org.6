Return-Path: <linux-kernel+bounces-573920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24312A6DE04
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26FA3B645E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524725FA2D;
	Mon, 24 Mar 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CoS+TXhR"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364325F997
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829346; cv=none; b=FvWhLZD1mosGvpVzkrNsnYhx8IvpZmWBPFYs8E6EiW7SVwJtS4zx8saS4anZoQEJU0Xs+ixGj1W0SokXxbPVqlf2FGpZJFHfSuQTE0QhqPrfDEKyFEd0UIUu6Dg9lXS67BkmyzWY0DLvU4uXKi08bW/nxGUDCZsTn8osnRy/+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829346; c=relaxed/simple;
	bh=R9p4HopsfUp3wpovdf/h1JN6c0xM35xOI/JSZ+P4yMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JleEbwSVzjh3AuZ9fHYCJZ+Vb6FAQadDNM0na8P+VAhFMNA1vKTkojgzj3B8WSExXmJ11mIBD4orNvKGFwwBaYuP0xtB86P0epZH2pMNSkTi/TrxWYmD/kPnf4xh5+swiswE4cPC05n5lK0TwBNOtEDCPPreDkyS5s12IUn8YMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CoS+TXhR; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e68e0290a2so812354a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742829343; x=1743434143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7obI0LNNDPiSwITZnRWtGg2CX+MRFMK+Uou8aGQuCw4=;
        b=CoS+TXhRdzkF91p/nlsHD0+DUaTaZ5Kw1vVWprtUYA0eEX9bnS9QoIpga+w/60Cc+u
         +zYFW4VlaAApSuKRq7MBij9TWWGHOteyiTAOoYeS2NdGvlXw9wRgJYTnd3940cdxaK9Q
         HV15jSynuDUfShtCSZViuWEVIvdCubhYtPIng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829343; x=1743434143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7obI0LNNDPiSwITZnRWtGg2CX+MRFMK+Uou8aGQuCw4=;
        b=pt+rweIq6nrU/8PeUG3sMxWCfDoA/KpOZ451YbWrhIFgrKJwbI/xrprfSohM1PzIII
         KOC1x0mRfUFoH134mIXH2EZJV6eBAJo/bAVanvmlpEAUKsZgnP4hAi4L7Q0wza0BW4J2
         KriHlnJ522cxqKWDGCy5QtRu/UNgutsZhTAGxX9gthjYtEvUdLuH0NF6TnNYX/h3Qtzo
         U9qZpOi1hP5Z51gb+I7KpoUhAfv527fhzzPHt/v0B76ugdbLrpbB17J56FTIyPpPvz3J
         IRdyTQK8eU4P5661mP5zojFpPVwck3iu6kFDww7RBcybXwidAyAk5tO/LVV67SjgCZ6B
         YerA==
X-Forwarded-Encrypted: i=1; AJvYcCXf/7qiS5da8lOPQ1rRy+jmH0BlQ7mGrSUL/w/c0tkKD8oIAIQIiSoXa9DJLQaRdEEcSjVVcEKVRvkNpOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzihVW6GH5EgofkvBIjR4mgCRF2PUq93H6zWVgspt77FpeXlrq
	/ehoxFN45txlNkd3+ojJ+D59Nc+hT74n9mjVQc4qAX7vk/EIlgcOFxCfq/Lp+Q==
X-Gm-Gg: ASbGncu06xP7GOZomXen6BGWXPnCYBb4WJSMheTqcS8He08dBIRtD96ihOogtDC5Soq
	jmQQyNbh0WlzbRZLnEy/2vE06CQ0VFFxUOlMc1GxSeex5e4WA8CHkkII3hN3WekUp5Jw1XaOKEc
	BCoeq8w0BzrTJFBj8qnKQctolnaXnq3oTTFlcvqwJEeYKT8lPZId3Tyd/PFfDYmEP1JSxy31YvB
	YkTunXbw8jN5ZSh4po7+PXyXJ7E300F28Iz+rLZSbV3038/1IU78xDV5S+BwlfqxPiYNMhC6c4O
	RBALmrm+2OR78PqZh4Sv5ih9VhNi034fp2tNUA718dE0f7P97MsUnGiSmnVNUIQ6AO8uRO3M5jY
	HiId5Qndism0=
X-Google-Smtp-Source: AGHT+IF6vjRW4hwldbWDEgvxc9zWWSrLi5hTa/SgxyA9/Gh5lCSQxVCvgMmxMlKBxhqC0vvdkUQkQw==
X-Received: by 2002:a17:907:7212:b0:ac2:6d40:1307 with SMTP id a640c23a62f3a-ac3f267549emr507917166b.13.1742829342589;
        Mon, 24 Mar 2025 08:15:42 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8d39basm689698466b.44.2025.03.24.08.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:15:42 -0700 (PDT)
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
Subject: [PATCH v3 1/1] mseal sysmap: add arch-support txt
Date: Mon, 24 Mar 2025 15:15:37 +0000
Message-ID: <20250324151537.1106542-2-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250324151537.1106542-1-jeffxu@google.com>
References: <20250324151537.1106542-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add Documentation/features/core/mseal_sys_mappings/arch-support.txt

N/A: the arch is 32bits only and mseal is not supported in 32 bits,
     therefore N/A (until mseal is available in 32 bits kernel).

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../core/mseal_sys_mappings/arch-support.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/features/core/mseal_sys_mappings/arch-support.txt

diff --git a/Documentation/features/core/mseal_sys_mappings/arch-support.txt b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
new file mode 100644
index 000000000000..c6cab9760d57
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
+    |         arc: |  N/A |
+    |         arm: |  N/A |
+    |       arm64: |  ok  |
+    |        csky: |  N/A |
+    |     hexagon: |  N/A |
+    |   loongarch: | TODO |
+    |        m68k: |  N/A |
+    |  microblaze: |  N/A |
+    |        mips: | TODO |
+    |       nios2: |  N/A |
+    |    openrisc: |  N/A |
+    |      parisc: | TODO |
+    |     powerpc: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: |  N/A |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: |  N/A |
+    -----------------------
-- 
2.49.0.395.g12beb8f557-goog



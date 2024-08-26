Return-Path: <linux-kernel+bounces-300849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FC95E93F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25E9B20A94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE28289E;
	Mon, 26 Aug 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="p9EeorMJ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F74EB2B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655168; cv=none; b=SH7AvE96CJtZRkeA0/QLG2DcGNT6Q1pfL6I7bxqu/bbOL+OuRRrOoMG1+JZmgMrgkll+m+ncuBChei4aNqwt1Rlgw7UP8Imc3YUgxggTcK0wSrh/UFiifX3a8OkYA+pzXzi8F4fklyn5yC6GJNqztlkQLGZ/vksAmUO68Cx92tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655168; c=relaxed/simple;
	bh=/eA4i7PR6yMnPoZKmrEEgJ9lcAJFeu/J1g3NfzxBqkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzjRZDLpC1CFDdVBLNgMWLcAscsalvbPbbQPPqwMaUjn0V/3jNX3VPmQUYjcWbfHnVUaiSPn5rWB0G7bMEGV0dd71kNxfLfQYNtveG3P49SMoxiBFZz53rL5h+QrYXy4DwuAgSTwTdlgjDETmKJW+OzxPbP3BMoC2VjBnxcm1Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=p9EeorMJ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA1D33F453
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724655158;
	bh=asTw9btpC4r8oJmQ5fgUFJi1d1/GY3upIlP0o+wvCJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=p9EeorMJanp5b8MhTaSguZLNrKbr5CH5lGMpe3DJRNGuqAMmoPLvpHS/SIyuxA/Pj
	 0kyilzLJ9cY6ICqMYwrhJGVupVZsDFFlk2U+tZrWItxSDI7atNeXI+kEesf7rHOzP8
	 Qyb8P3fgtGzOuEznckBM0AqswySJOncVNFrZFBHuvzLWg58FbnAgQxn8blplLjSGmw
	 yXsGBNOiMJYjz4rPeXtvCc0BUcI0fzpiOZA3RvFFLKVgHcQ8TQ9Wsl4WF9wDZvMfEQ
	 XqFyYCs36gI1NduN+2ASTLwU1mxS2BzeDuHvMBC4UzVJjvEOJ3N+hLMbBCMVNaf6yJ
	 A9Zz1UnLdXiGA==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7143d66b510so4320704b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 23:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724655157; x=1725259957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asTw9btpC4r8oJmQ5fgUFJi1d1/GY3upIlP0o+wvCJA=;
        b=ERNhsZMPtyLpMhN2BcknCLZwkvLEExi+RPjzRfFQIvgdlBKljUU6IsNUPEDx3vzhIg
         OxujYykkxFWQzV8VWEYxLMMyl23x6xfNu5+EmxkjqreiWcqS0H7NffO2kKTw8VwS9hpI
         HCgmCyDKpenI3N8s95zeslPetVkFlF8tJU39ktw/v2mmXSC5MdIQrPPTTxNkie3XVNMO
         l5QcBD4JfwvWC1+jcanKd7tjy85lhwbbDRXmSAFgZQGRqBhmOYrCcUsOUlWyRw/aQs7v
         H3QMI21bsqERX0vQKmwiB8Pny4MY0Es7kKJGW1m7f4mYgp6lt1DsxvOFA1Y3BPvsufO8
         89KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhw4sIeGdtta95iVI0rzf3JujqCk5WSJUE1XRYLmzq1YsyzSLT605SDW3GLtHNE79mKOgcE7phpi92T8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9punhHAd3d0V2XdkqIgeY/2BNzf1GWKBCZrFb3r8EBduDxQv
	2Y37JW0LQx9L4Lp0wJugvE/bUdbojKn4+SVFJo1vtrxY1eoDWlpSjFKHEtuM85NlNb5sGVZA7EF
	KsBQbPI+eNZVopQgX8Kz9/Y641YIziGx41tQgoufzZdTsXVacxNezQAeKNPdP0b+cy2zUF0JX5W
	Z2ilQ7XDTcDA==
X-Received: by 2002:a05:6a20:2d13:b0:1c6:ed5e:24f with SMTP id adf61e73a8af0-1cc89d7dde9mr10964922637.23.1724655156907;
        Sun, 25 Aug 2024 23:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFshnr0yWWoq+ZC7FQTS4oA6OR3ojKB+L5NDCHocR3E+oUvuPt3+dFTL8nGph077xQHw8MRMQ==
X-Received: by 2002:a05:6a20:2d13:b0:1c6:ed5e:24f with SMTP id adf61e73a8af0-1cc89d7dde9mr10964901637.23.1724655156256;
        Sun, 25 Aug 2024 23:52:36 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e09c3sm6472207b3a.122.2024.08.25.23.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 23:52:36 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in vmcoreinfo
Date: Mon, 26 Aug 2024 14:52:02 +0800
Message-ID: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since arm64 supports 5-level page tables, we need to add this
information to vmcoreinfo to make debug tools know if 5-level
page table is enabled or not.

Missing this information will break the debug tool like crash [1].

[1] https://github.com/crash-utility/crash

Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
 arch/arm64/kernel/vmcore_info.c                | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 0f714fc945ac..557a1cbe5098 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -466,6 +466,12 @@ Used to get the correct ranges:
 	VMALLOC_START ~ VMALLOC_END-1 : vmalloc() / ioremap() space.
 	VMEMMAP_START ~ VMEMMAP_END-1 : vmemmap region, used for struct page array.
 
+pgtable_l5_enabled
+------------------
+
+User-space tools need to know whether the crash kernel was in 5-level
+paging mode.
+
 arm
 ===
 
diff --git a/arch/arm64/kernel/vmcore_info.c b/arch/arm64/kernel/vmcore_info.c
index b19d5d6cb8b3..be65d664bdb7 100644
--- a/arch/arm64/kernel/vmcore_info.c
+++ b/arch/arm64/kernel/vmcore_info.c
@@ -7,6 +7,7 @@
 #include <linux/vmcore_info.h>
 #include <asm/cpufeature.h>
 #include <asm/memory.h>
+#include <asm/pgtable.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pointer_auth.h>
 
@@ -36,4 +37,6 @@ void arch_crash_save_vmcoreinfo(void)
 	vmcoreinfo_append_str("NUMBER(KERNELPACMASK)=0x%llx\n",
 						system_supports_address_auth() ?
 						ptrauth_kernel_pac_mask() : 0);
+	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
+						pgtable_l5_enabled());
 }
-- 
2.43.0



Return-Path: <linux-kernel+bounces-220645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4690890E4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623291C21E96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0113E77111;
	Wed, 19 Jun 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="u01Bj4zE"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADD78C84
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783391; cv=none; b=kJvHcGjIZOW6NAUDoIaUSjDd5PeC9wNThIfnKoBGS/Kfqg4ZsTxQuwjTxaYKcfXKuAHIG3omuDCwMfiGMwMEqL2WAa07WKQUzNIuRNrsqwWYuORJqXnwS9p4B6vH+q9fy3n4KeDRSLVTCpe6XTAxVzRPjOmpEb1NGQVC38GEOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783391; c=relaxed/simple;
	bh=lE6RVt5F/zXmRYramnrICz1Q4yZz8whpVeQQr9/NL9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QYqVtAM/2miGnJYhLfQ5Wrdyy01+vc9gALi3Mm0uju7icC/+QVGeDCmBWMcfx8YRl6UfNuCOyHDX0PcuHNGLiYH4ezMlyusuAfVTo74qvYRuoNIovkZ4dU5EQWWMBCZCu8oUYJWf0YNN7tW5UO0YHQzSMubYLGzBIBWnLmWlp4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=u01Bj4zE; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1EB993F2B3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718783388;
	bh=3Ah02osWSKxjYX+LIDMgTigloGH2VX07SWnwSlI81uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=u01Bj4zEOhhNc1KdS70Enb95fFl19Ymix4exLToMwhcd/tcgJF0LtemK0hzu7klz5
	 VtptqM+3t5IKp2+E94E/nmlL72YZ17JCEl+VsKnqUkYdcRBDlppZFn+EfGC1uyOJQX
	 a4gxMhQHXsyCW1lM2AK9B26oLUSq2AkLjZV+1gQagRVyFQSf1G7q0skKoz1lBrKtj6
	 Wp9BG58NyGkaZ4kSza6tUzj7SnCQ5Y19RaFCGGwr7oD91CYEhygkZAo3Cha7elddfb
	 sdi6OeT9ydj6QnCEEXYmV75p4RRhH+Thn5Gk3xaYpj6X/BSka2Jxt7aOmmth+OzkaM
	 +Sg8WJb1cRqog==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-701c82dadc6so5790262b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783387; x=1719388187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ah02osWSKxjYX+LIDMgTigloGH2VX07SWnwSlI81uk=;
        b=J21u543mHtbbNDsUWtawMrXtkyg08m4I1D5RlejpSBEegPQFLv6rb1eMAPOFw01Djq
         GMuu6Iulbd/SFUj2jDD8kCrZYydSVRioWmGv3QFtzfyRQINZZdEkTvmgFWk7U4uZQqKe
         fszA5aF05XtdFVoAxZGPbXR5/m3HQsCrAuXiDykOAgVyaPFIYrM88EZvMEHYGsNbZM/C
         yHlJKEp/00ps8pIwbp6/AQc8bWBiMQC8RLwPp2USkLSggWE7yd/lPPqA0t1ur/H3FZLz
         hLINTYyPH/yxxCTlgYasSudDOIDV2yi/6eZD2auROaZvW67MHs1tjPRmn2Pmq82ojQ+n
         VQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvzFWOOOW8EeJxL9RLGcMuA+jXyijH+RxYPbTevlrsOJTySguc5/GyiqpobMuMEZm66iQD7NIIVU9b8JIeF9FLuNODeBHiUB+agt4B
X-Gm-Message-State: AOJu0YxR+fYD9ISCt8q+h54k2jzBr5RxuJkMCkMt2SjGU0Fq5VrnRiMG
	cZrRoGaXbWueYSLFu1O9pqmkymq9YSldijdaDsRKZQw+8VzbvWQt9OC+XYQxciYx4c9s7uCA/Ac
	sOLsBJcyiNcnxrasalpADZOIxsoyr6V7wLJWL86TQsSXrZTz12TQVGitMPF5Hpn2b/VXEaMO0aj
	hc5g==
X-Received: by 2002:a62:ae1a:0:b0:704:16ec:4669 with SMTP id d2e1a72fcca58-70629c14fe2mr1657543b3a.6.1718783386859;
        Wed, 19 Jun 2024 00:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0rN6YZTz94hdqcDgk8EAa6XjBgKmH0rULofVtMvz/AXKqwgcKzr4E+OVq+bIe48UJo1uPZg==
X-Received: by 2002:a62:ae1a:0:b0:704:16ec:4669 with SMTP id d2e1a72fcca58-70629c14fe2mr1657509b3a.6.1718783385529;
        Wed, 19 Jun 2024 00:49:45 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cdc6sm10076908b3a.138.2024.06.19.00.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:49:45 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] scripts/gdb: change VA_BITS_MIN when we use 16K page
Date: Wed, 19 Jun 2024 15:49:10 +0800
Message-Id: <20240619074911.100434-6-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
References: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change VA_BITS_MIN when we use 16K page.

Fixes: 9684ec186f8f ("arm64: Enable LPA2 at boot if supported by the system")
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/mm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index 200def0e4b9a..7571aebbe650 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -47,7 +47,10 @@ class aarch64_page_ops():
 
         self.VA_BITS = constants.LX_CONFIG_ARM64_VA_BITS
         if self.VA_BITS > 48:
-            self.VA_BITS_MIN = 48
+            if constants.LX_CONFIG_ARM64_16K_PAGES:
+                self.VA_BITS_MIN = 47
+            else:
+                self.VA_BITS_MIN = 48
             tcr_el1 = gdb.execute("info registers $TCR_EL1", to_string=True)
             tcr_el1 = int(tcr_el1.split()[1], 16)
             self.vabits_actual = 64 - ((tcr_el1 >> 16) & 63)
-- 
2.34.1



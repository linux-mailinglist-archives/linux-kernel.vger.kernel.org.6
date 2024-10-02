Return-Path: <linux-kernel+bounces-347284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D6B98D079
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42391F225A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141091E631D;
	Wed,  2 Oct 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="AqYJY3z0"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7F1E202C
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862753; cv=none; b=oHs5ysWDDXXxKMOenUOA5zWtcLOwriH7uyyALbIUJWAis7NYIvhRuM2p3b1GsA8WpSvZBfSCaolzYFMKiXx2uL+52Ouho0ojcoHdAQYF/hxtkm3LTNddc+f/fqPJ5Ko/q95Qh+65etQH+TCpqrdt+ctabGS+mY9EwN+YH42SrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862753; c=relaxed/simple;
	bh=LeE109g1WHFYsWZifrEIS4z6YMZyLiamaRRfz8Qo9Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMvZeLGcW58HXKRgzDTZUrhxwgrJ5TbTHFlDStrNnT15EH1Y+CSTiklxd2NQ26UKqUpsbCBqgxDyLTdISa9vLo529TjDNix1Go7rhpuYfrxD+V+zO3/vw1KVzjnxXnutwvK1LZhKibuGI0nBY5/1aHAK7JGohf9+lySVHMmGr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=AqYJY3z0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso53243535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862750; x=1728467550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGzVt9uDHCNj4raUIpx4cJGNorylfoQJHMWgGOzAC6g=;
        b=AqYJY3z09SHBieIUBVs+y52zTUkvZLc29YMfVxgR+9n1oS86hgK2yL7hniiLTcjQUo
         umVwLo2RSLzIZNVKgutoOSCDBHnLBljQTU1wGqxkl42eOw9vgfc5tE+oVmZ+mbBNEFwK
         7fzpzU/Q1cFz+2H2PJMOR12vBNPgcBD7g5S3rUKrkIe4XvjOMU4Wzp7WcOAOG19Ct5pl
         kf3HyqaAr5Omgqhq6iT96aUuh3U1j8Bsq9GKN48JqZ9cUZpeQhgsCFR072vmQje1TIsj
         YeuWJ9D8tjjyLy9Kqy6cTMR8iQVZJSKP0+KsSggLQoQmCM9ZsamdFiibqiNgR642NS2P
         +Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862750; x=1728467550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGzVt9uDHCNj4raUIpx4cJGNorylfoQJHMWgGOzAC6g=;
        b=Asq0dDhGX10sMY9m9DgcrxM9m21t7QXSh7IsUoDzMXPm2dZW/RWsT++nNGKnl7uxKo
         SSY2JtUKMJTlGv507l00cXcG7b6zcelYt1aznf9UmNbYhcAL7pg5ddpprdAiGZOwbS3x
         3Nv2MwivV9PNUa4ARBrVehA2AgScIr4ly2TyvXZ3BfSZhQTO1uULjt+Fy2BfHgPboiwK
         yixkKKUQTjDokTKv8fsP9htS4JmC+P8Ri4IJwkW/6j/QckiJ7F1pNymUwcm1ePZbtPJV
         JHBd+e9dISiYW4usGAHt1DC+oJ9Ixw/TWz2e+T3lBbFP2msphCEHXA6vqP8NNXY4IDZX
         L/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXcVfHpydCXxysUHKwPGXzOJ7jaByMRrv0ZW+/OWd38FFzMR65HrqPf30x/KozVBmcSeFiN40f52LsfQU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsjs5BL+ZfMWexYQmWMcjOWDlJs51FPzs8zqsjTcLjYulLQiLi
	LXppRYMPxVCdOoh7IuQCtkYOnTd5nTmRagVCOaUOYX09Cj9frc9ebgr1Pbw5B8E=
X-Google-Smtp-Source: AGHT+IHSw/6Pq75nH1P7Bm7rhK35eZRs91mzVmO5xB76+Gr6jkwKWjgveLC7LaZ1ZUM6rmWrzvtKxw==
X-Received: by 2002:a5d:4fca:0:b0:37c:cbd0:8d94 with SMTP id ffacd0b85a97d-37cfba20777mr1320272f8f.57.1727862750360;
        Wed, 02 Oct 2024 02:52:30 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:52:29 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Wed,  2 Oct 2024 11:47:15 +0200
Message-ID: <20241002094832.24933-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 common/Kconfig |  1 +
 lib/Kconfig    | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index e1b8557e0c..09ead61817 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1076,6 +1076,7 @@ config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
 	default 0x0 if BLOBLIST_PASSAGE
+	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	help
 	  Sets the size of the bloblist in bytes after relocation. Since U-Boot
 	  has a lot more memory available then, it is possible to use a larger
diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a12..ea444354eb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -983,12 +983,15 @@ menu "System tables"
 
 config BLOBLIST_TABLES
 	bool "Put tables in a bloblist"
-	depends on X86 && BLOBLIST
-	help
-	  Normally tables are placed at address 0xf0000 and can be up to 64KB
-	  long. With this option, tables are instead placed in the bloblist
-	  with a pointer from 0xf0000. The size can then be larger and the
-	  tables can be placed high in memory.
+	depends on BLOBLIST
+	default y if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
+	default n
+	help
+	  On x86 normally tables are placed at address 0xf0000 and can be up
+	  to 64KB long. With this option, tables are instead placed in the
+	  bloblist with a pointer from 0xf0000. The size can then be larger
+	  and the tables can be placed high in memory.
+	  On other architectures the tables are always placed in high memory.
 
 config GENERATE_SMBIOS_TABLE
 	bool "Generate an SMBIOS (System Management BIOS) table"
-- 
2.46.2



Return-Path: <linux-kernel+bounces-367342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5CA9A0125
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99461F25272
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB7918C93B;
	Wed, 16 Oct 2024 06:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="V1darrvP"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A218C913
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059202; cv=none; b=ug0e9kwtkAT51U0b6NttUnv41Y8DfNW9lPslavvJZCB4U/tPHbKSmlJKY3laMhamnipTCsr66P8J8+zax10pz8fwyZPQHxGsN+cxNWShuGWX+M3XWeqxUl017WBed2szJmSnmKFF467mrDmfqyJm/iCervJp3kJ2CHlS5Ofg1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059202; c=relaxed/simple;
	bh=khkGnSEfuQW3yAyh12GYukhojLea4zVI49aOFaTB4Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4PXSEyCl4OtmKlMe6QaU81U1n0+utLi8ryqD0wcClQBCoVeDe6yUYdJ91G4pZYHWJMPDnOkg7hFqWQKn1Qb+tlvt4pcbt85L6Noe5x73XqwjRMqVOymD0zVRoizEp3LdpGKnZrqDevHy+myN56k2uk/8SRRe0VQPBfnGrHaf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=V1darrvP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99eb8b607aso501869366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059199; x=1729663999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xcSEsG4P1EbTSisKnf1P6Gzou9rCQHuXJkRJa2SjG4=;
        b=V1darrvPTiUE3vn+tlHgmonzZ7An1BO6Afhq4XOKBpWWwfVURyhHqFRdQM5mnuy5Cm
         wWtojg1O9FKPo5xf/F/h2nX5HZAFBOS4ndKZCdvNQ7T5sxIDE4nfSIWy09pRUdTNGkl9
         V5HzZnx9TD99cbys/B+RqrCCCblBS2i/s5SOE53azBbI2/JRNmmcDvaseBKveiVBeyg/
         9E3wdXYayhTanNQy0kq0e8jAnxzXoU+26ZTlEsOn7BOlFw3n8nk9qn6mHeg8gDrAKEry
         OjjFmatBux+mR8qmNe67W3DMAdcp4xlyhh3dUfFcwR0vS1StIRxSlDy7xM/UEGAjEsSu
         008Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059199; x=1729663999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xcSEsG4P1EbTSisKnf1P6Gzou9rCQHuXJkRJa2SjG4=;
        b=Wd5fYUpKgwR3GxQEuUgEAi4pky9USd6ZCO81utx5yrvD8zByGWJUyjGGXbcGPG9UaT
         bt1kqrd+nb84Y783z3JgnXsm2t5PZcmwsnjs5fkkgDu4SSGp53mFe33scbixS7/emAQ+
         OCSjPD3oHF1Tt3ZFu+VmfidSe2Y7o/81pWVVNZIDhkdWqSgkrLpRgOZ+mUrjGkkqWmry
         t8xJgVY0Sv+D87QZIJUR9ketR3+XVx6uKsyrMtTUVG9XCW3S62Z+9C4GWwg08Ge5LImN
         n3xaSt0u3UDAhbRdwAhs+m3gZIuGl4nOs3d6R6a4tbBUkN0KNjmNjlPyQl/bNdlKzoZj
         HcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOGmMKfFfHyO7P1NtDh8QF2E6mWwiR4DEtGxlI2nsYG1SXP9+CAZwBmVBagA9ppHAJbqQQXBxi/GDEs6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EV160JlyP0iLbcTjl3QVdtCLUMV3Hpq4rrf1+zhQcE8FsDFI
	RCa8eSkoEx1D4V6ZZRm2DhCnQ4z7dQSSESw2ZoOUOBBTM9UBiLyV9xhzaOZouFA=
X-Google-Smtp-Source: AGHT+IGhJstM1G3IolOuRFnAAEXy+t9dTjpjAT3eUWyAidF57E8OZpkcbd6jJMBGA2Hu9IpDUGurpg==
X-Received: by 2002:a17:907:f19a:b0:a99:f7df:b20a with SMTP id a640c23a62f3a-a9a34e88843mr195145066b.62.1729059198867;
        Tue, 15 Oct 2024 23:13:18 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:18 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 16 Oct 2024 08:04:10 +0200
Message-ID: <20241016060523.888804-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v9:
- default to BLOBLIST_ALLOC on arm
- Move default for BLOBLIST_SIZE_RELOC up
---
 common/Kconfig |  2 ++
 lib/Kconfig    | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 957de0c5c0..9ceca8a2f5 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1035,6 +1035,7 @@ if BLOBLIST
 
 choice
 	prompt "Bloblist location"
+	default BLOBLIST_ALLOC if ARM
 	help
 	  Select the location of the bloblist, via various means.
 
@@ -1075,6 +1076,7 @@ config BLOBLIST_SIZE
 
 config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
+	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
 	default 0x0 if BLOBLIST_PASSAGE
 	help
diff --git a/lib/Kconfig b/lib/Kconfig
index 1dd4f27159..2e0fc1bc8f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -984,12 +984,15 @@ menu "System tables"
 
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



Return-Path: <linux-kernel+bounces-360932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD18D99A17B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0DA282ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926121502D;
	Fri, 11 Oct 2024 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gZWpD6wx"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18431E5020
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642914; cv=none; b=oaN660LYFVM0MMfoOEjhsbjd6p9nAsXxMMLvp9oTGFGAZKfRN7cazwS/5Rjrs84mbaCJ62pmmG7C7AgKeqN75UXMlha3+jP3yRy81+nhahm0DJ5JKNxHtJJ2li2KWmJBBpybyXXvDKJsZYu0E1PIRRw5PeAa2DXiuiY6PsUk+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642914; c=relaxed/simple;
	bh=3yt9sJH/9oLpIC8Fb4GIaJE8+9dMvy6T3k4Q2vtH+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENn9sHkmtquus2T3r9ZMzHWFgmXb3//ifdNLtjcIcJ7crK2aJ8uPs1NUoX1FZZL/7kGyhBIEFc7mDJiqg7g0ElsBfeT35UaWD1GU6mg9n5fjU5ztvvP/LGRefdGDJP0Jnl/Pj8orsHTd8AfrGgj/Pqxhs6QNrI9OFhg+GMVXm8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gZWpD6wx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so2377535a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642911; x=1729247711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
        b=gZWpD6wxLD8ZrXXJ+5F6WSotBYPMP40FiKsryrHBVmQk62rxOVEoud8BJ+WJOEAQR+
         k6s1QvpAeqJhd2vnNCZEE5sLViEkWAbcE5TsmqlL2ThTEqeuSYrJ4nPomWKOUV1Af65P
         kaekntVYTyXmsv92tiP5eS5WFoHPV7oqqdpVpggBnP5+XCIdbH87CfXOEJAUKdGggymL
         uBMuMTsRpUAAoh0XHVSr1CvQDxxJOYxkb1e1BX1JC2pLm4U4wx2UCN2OrfOu84l8YqmH
         y13I6ZUZzypQRadKOuvPaGdVkcAX1wQPid580IpzgPAs++G9rEb5Cn9SD8+yB+w+n4X6
         RqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642911; x=1729247711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
        b=mgwqupFP7EQcearMiypy5CcEc+cIKT1dwFPpByDRUWbOHjkl/CPCPQep9sYgCY2D4D
         MBlQi5XcZrTJKRnuNXAPNFj8uioL8fYB1hDfUY50weUWyZ60eN6w7s3JTKBu2w8GGkA2
         N4k8deVOLeiR7cxUwybCqRrE9ih9Aqt0cz9GXi2/M3Ubl5rS9ebMV/bjmwKZjTTvvm93
         3ZW1UAtJ2AsZDTfhEm/Xng7C/dI7EuzDmqgfwXIfAgQQ0wlH6CK9tuGczq1N+YrLWG64
         ykJ91/ZMBQAax6OAkeItRTpjCXo8srVQclyTlkaCJwwMQXjzHVRMvtmzSzHq9OZp3cmr
         6JaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjMvdlVfNJCuz1fU3nUNmD6IcqFr/cW5MatP14IM1ALUxy4hkdOIMinHoFRMUpVj13dIfDdaDnCKhc6ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+URmV5EiNPXr+Wt28g3gBramy9+WKATp3LhIdIJkR125+O0+
	Xr1PCL3M9YV9LRvG6ND0hZ9H5YDqSMVXOxTJjRrEBO7Xi5kKvB+N6673MkldxSA=
X-Google-Smtp-Source: AGHT+IHuZs5UeXyca+Hfa861pkuMuGUOnx1ioWgclW5/P1mOXjWGJlYEoMCF/pFiUjJCtvwvz+QO6A==
X-Received: by 2002:a17:907:f14c:b0:a99:7e95:49ac with SMTP id a640c23a62f3a-a99b941b43emr200086666b.1.1728642910779;
        Fri, 11 Oct 2024 03:35:10 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:35:10 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Fri, 11 Oct 2024 12:23:05 +0200
Message-ID: <20241011102419.12523-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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
index 957de0c5c0..c3a68e33de 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1077,6 +1077,7 @@ config BLOBLIST_SIZE_RELOC
 	hex "Size of bloblist after relocation"
 	default BLOBLIST_SIZE if BLOBLIST_FIXED || BLOBLIST_ALLOC
 	default 0x0 if BLOBLIST_PASSAGE
+	default 0x20000 if (ARM && EFI_LOADER && GENERATE_ACPI_TABLE)
 	help
 	  Sets the size of the bloblist in bytes after relocation. Since U-Boot
 	  has a lot more memory available then, it is possible to use a larger
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



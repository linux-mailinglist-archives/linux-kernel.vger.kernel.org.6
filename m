Return-Path: <linux-kernel+bounces-332767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D31D697BE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B31C2149C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD0D1C9DDC;
	Wed, 18 Sep 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="PdS2eEQR"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B41BAEF4
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672968; cv=none; b=lDa0zotrh6gzi6MWK3l7G9WVzHvrWNajQiJ28TqGoQg7t1FA0fITtI8aFeUmZillFcVHDF+u7QqXx3/NCZQtMVWS+I+t7n/MGegc87W3gPGM57fP0sDT/Q30zAxASu6pR2wuk/yd4UPGEK4QHIFOneEZQTZv7YG4b5K4jmcUIhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672968; c=relaxed/simple;
	bh=gs274pY2934N6eCn/HG3ZNcfONPQaJ6kbHTBH2vA0LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYXFmvhtXHUcd30fUMIHcMnjU7XYKwsz9p+/jTCKOo11nsQerQNFSIRcmQM5KZl4+gBc/e1HoeosTni87m/BnmtA4hNl6NTHqI550Y1h3RoGwGeMWlydIE5SHDs9cnHXqWwztjdsZrDNv+oKtfTZR7ahgJt47A7aI0rLctKOhC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=PdS2eEQR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so756274366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726672965; x=1727277765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKzDi9As5SUTRNf+iP2eQJ0dVtOM33ZHfoAYE4hPG48=;
        b=PdS2eEQRMMW260UBkMy8Zb9RrKLFIYwbL8x3hI2/AlxVmJxnDOKoXj7PsQTpadKJVi
         ECdg1SiuWYKwlosIqC5sZsH8ff7bFiP85shjdI8cG9K3BoTonZoS/0ffbIfU3QO36v/4
         L3sRrPQldqoP/VkGFUO0ixXHIKkwVsO9k6PJOeB5mDb9nLa7Rvyv1e7cm5Yv2MFSJ2Hu
         FxWvfug20yPHGl+JjysCPcZDS6wpWqWDkJ+VTl99ZjgdpDnAh28wG9SgZo0HYVVL+VQF
         Fr0T3calplZZ7HneJbpZqq5b4T6BlNpACbPkNfsJ/o7v2+xp88u3/IuF+qEb4FTJmqq8
         Kv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672965; x=1727277765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKzDi9As5SUTRNf+iP2eQJ0dVtOM33ZHfoAYE4hPG48=;
        b=siftmfIwE10SKEZ1l+QBXkOHmDt0ee/9n0eUURPXmQc1zhzPGCF6hkjfltYK+kG1ba
         Se2eOeTXqgURxdxlD4QpQ4HJuqng9G7b1+xybpTd4tk/eF30vOeF4zeI61u4ey0etXyG
         Rg6X8TwtDA2kaZOEJi9LCqVMpxkKa5VQPV3nz5ZzdKjPzjT8m81i4voQnnkHukdxKcLA
         26NkH263IwkF310VC0QD+1mMYBWHTgPJkiWFM9GLOpEn2V3z+gv98v+iSvMWMZ0yMzeJ
         3jB6zdVPmV0aMD/KbSOfvARbgtnWHXYst2J8+t9dYp8yHLdXgYUrpooYg11KY7uGVCAr
         1QKg==
X-Forwarded-Encrypted: i=1; AJvYcCU8sOMys1/FHbSwmcgESyEf4DuODrX0ezZXZsgqdAi9bDWzH5k8k+Sd8aP+qtHMcc7VYbhh+w2R4GtTZbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4SNOnejxKZOmVELeRdplVKooPncf3gRUSCjU8/ohKlkzSKIQ
	h2YaccW+9xTK5aMccV4vyOvYq2MHZHOoOtQJQvTciEcQO6rO906e0KVIA+7WsrE=
X-Google-Smtp-Source: AGHT+IEJwbSpH6xC598WivXDw6t9Z/FFISmG1rm+OMvFZi/JFAgAxSCVLybIpE0/09+AVkQ/ueow0A==
X-Received: by 2002:a17:907:e647:b0:a8b:5dcf:493e with SMTP id a640c23a62f3a-a90480cd286mr1852782266b.58.1726672964818;
        Wed, 18 Sep 2024 08:22:44 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 08:22:44 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 24/35] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 18 Sep 2024 17:20:28 +0200
Message-ID: <20240918152136.3395170-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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
2.46.0



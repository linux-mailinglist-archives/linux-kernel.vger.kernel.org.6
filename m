Return-Path: <linux-kernel+bounces-340088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7579986E75
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E760B1C226C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E161E1A42AD;
	Thu, 26 Sep 2024 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fuemRAYT"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02B613D638
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337791; cv=none; b=OERjZugK4IHovZpTVCWz/jQ5rAndr0l3nM35oPkdQ8fzmKlDm150qgOK1+qUBd3i+BNaTdITDeh4viWZ40SlKadkcjCJJcqaauSktuDgdnLuJcmnXpMwES/8eE5wnU9X3lSZvmGlO0wY0EEQTYCRIQxAkDV/W1DZZ+eZ0Qbih/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337791; c=relaxed/simple;
	bh=VaQ8rCZ5i6SIS3oR8WijE10GN+M7XjF0u8PRnbCqvCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLhNzsS4OTAlFrLVicfkwMgtSQB+euf8wDvQRqxPglwgJaDiQUAdLNUOufcimgNOmzMp6Yx+vSuU/oPRX/Ap1hC6E1cKInr6chGgri+y6eommRMuzUgUIvjERcLmoXa+gVXcoZR0Fcu5Vp2LrEmNw4s7UBYL0DS3jsoP/SVMefc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fuemRAYT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso3237111a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727337788; x=1727942588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoGNb8D2jp0vg8w7EjureeDuV1GbKu4z4O+1Dbpryzs=;
        b=fuemRAYT6Os+kANd1ILuU57nsjA4/KWIQvNdZiZnwC4NLkRg5G4CH9Aj1WSeCjz4F5
         FpN8VjvAj22uT/GRZZsr47nCDxB05KIPI4N2LuP5G4637xocz3ydotBlkUDlz45zV4ow
         rViywoReqMBiOi9TtZd8zeglnU+QCKwfkPi7ThqHV4ZGpuy3KKtgH2VS6ir+h8FqRFf8
         pRCkfBLmMr6bQiyU5iERWJOfIV/NDQg7seDHJc2INSMtIxYNqYqymqGH5Y5HaJ2M8Sbn
         GPwkddEhLhxep6oZXwftUiUk47bwqdXqpnSeulgBsBRW9bM2Vu87xrR9XMTOR19W/+CA
         vCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337788; x=1727942588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoGNb8D2jp0vg8w7EjureeDuV1GbKu4z4O+1Dbpryzs=;
        b=rnt+TktPD38phUF+SQZlhPsFOKUPopr9n19qB0DHbbL+8CRKR/ggwISXbDPv5v0ZdF
         H4b0IHUBk4GvZdsIsaECydgk6qNsFxSaUWE/ilQWubIV9Owpkinkrkx3x97+hsnRuQwm
         YSoLAHhGXIIOIVg7TR68hWPvkLOWJz3a5zCvXLFT5hHd7SnJEJbJaaYmv7mhXfMFHRK6
         AncAdHVNhGUR5i7TyIVBOv47CdagFDPhQFL9FWk/MtUztWnu2BsXU+JCZsZnRkV/CumH
         jA+9o1iv8NFBjFwuaMhpMQWKOzMw984CFl4MppHZJOXV5kzqLufcpO0UmVKbTPD7O6PU
         IOjg==
X-Forwarded-Encrypted: i=1; AJvYcCVT/DI8GLnPAblM2vM6+w3jtvlYYQLd9tRWKIMSZfGt9wsiMyf5c9N+vdbUu2UhCMRvwYQvmRQ0LcZRXjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxWiroFc356uJ168aFxmjRtXpFfNDwEKXfK8hr0zIpfWaGxWS
	XpWDNe9Ju46XtE7RAlA5mXM65h8cfDTlYtJAGS9Py8h6pwW5Gou3j+cIC9lGwcE=
X-Google-Smtp-Source: AGHT+IHuSP0G6BD3F/+MIjvUx76NvIigv57icrWSPhPo3Se3+kCgP3xPSEmTpVdcvx/p27sGNlBVMA==
X-Received: by 2002:a05:6402:354e:b0:5c5:cda5:9328 with SMTP id 4fb4d7f45d1cf-5c8777af7demr2284418a12.4.1727337787709;
        Thu, 26 Sep 2024 01:03:07 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:03:07 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 24/36] common: Enable BLOBLIST_TABLES on arm
Date: Thu, 26 Sep 2024 09:59:12 +0200
Message-ID: <20240926080021.148031-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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
2.46.0



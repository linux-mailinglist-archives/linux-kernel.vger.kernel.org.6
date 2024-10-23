Return-Path: <linux-kernel+bounces-378091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BD9ACB36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22EF1C21352
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAAB1BF80C;
	Wed, 23 Oct 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DpjcYyhH"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98F1B5ED0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690161; cv=none; b=l4wS02SYP6EwTQgB9gj2IhzokeQhxtEfYUXK3AynP81+cJvSZ7BKImQHGZHw12sgIrxIGuDMLK1laDId+0CuUmNXBQKf4NvawaHlLszuTKXf9M/JqbU+Er7UUBdm9eVyfbIRNNsXo17TwOPyl5YmTCc3Kbn+xE5GxbxLWVkibXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690161; c=relaxed/simple;
	bh=T74P9J66AESKIYwh0YDGEi9jqG/5eYlIR6R56sum6gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ2Ot2H4UmcBOxUDWIbpfOK32C/hiwQa/gHckvK2lLWz2331WJgz9ReI6bE5Q676yiFb3bfCGdpG7skOFvI/9N6bkQip9v1A8GwO52wXAZ4+TVRKnMg7zK6U7eFYzwPlCtOayyJ337Bfoxnx+2EnanrUhXzXS37csMU9E8krjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=DpjcYyhH; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4fd00574so630446f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690155; x=1730294955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwKTa2EBAz4I04/nwNCkYGEwdnLhNaFfCA7k8RayRf0=;
        b=DpjcYyhHDPP7RRLgMvf3fy5ZdVR3JWrB8zEheEgMQKXnz4kbMGgLYfX7GJQyqILLk6
         ATFffNBBcIGou+JoRwYv/eHCBPuqiTAxoFcGqnnuCPna1cJaptAxnFYjexce7PYpu+xG
         Gw/OcR6f0WW+kdiySoRzOODfghNp+a2f9OxGKm9duDE065gEtUBv/AmmREisBYQDw37d
         nxLvvW1+91DxUQp07Vbd+YeQ6MQRX8rvYIFyaeH1fsRbZ+9+xck0Um44hTvt3xs9Ybk/
         l3oISRqgrv0sTi6Y7CzKKOP1E5oOtpdoQzbTd+4SB3WL3f7T9Mw+1KImgBQLkKQqJh5Y
         ENxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690155; x=1730294955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwKTa2EBAz4I04/nwNCkYGEwdnLhNaFfCA7k8RayRf0=;
        b=EoPLn0ftVUCczeV4kuKpkhI0zKIjcQ6V//2SQy7OaCZbJ4CmSVFDhD5sDTnwyTYe8q
         iH9/kXYtZU6LhB5FeVhkS22A98gJg/rtpYY7JlTYDruCuAIywgLrxeOz+Pa+orEy3d76
         dmRLQDiAkiyRtpH6jqgKYgRGCVZfNFXqR9rvDrOlAysD/Pmy/KIUX2J8BISqnxEse0rx
         S8Sn6Q1qf3bs2/KBbkI1slsh0Ar8uee8jw+UwPx2GzkTTPgDy2w9RuYgZ6AKfXezObZF
         hGeOUxzehlxkpdLpx6byN+v2JgswjXa/6iqdE1U8RxZdz3F14QlBzkkhVU/OWIGP7Pj+
         Gkjg==
X-Forwarded-Encrypted: i=1; AJvYcCXDNX8nOZ21/TXyA7nxoL4YVIk+g/TuA3JwHfp6GNhFix4pMSpxxWwQeMxtmT6tZaiW78/FlS4FA8V2DWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5V1HDgvtnb1nOCQTsd+PvGpXCh9Gm93QjpjI3VqbR8LMgpPM
	J4kbHl4CQAykSjwRBgk9fR5OclW5pyOFx8KcRvZ5XpzlEDTukF7BtP/RmLexFycM9qe9rAMvVJP
	9
X-Google-Smtp-Source: AGHT+IFeBXTIINucHYCMJsW2SG5ZTFaZ8ZRlD5SIIa0gW1Uc7vsZmPgLhyH/1hWliCZd9umIKYkMOA==
X-Received: by 2002:adf:e88d:0:b0:37d:47eb:b586 with SMTP id ffacd0b85a97d-37ef12592e5mr4733714f8f.4.1729690154047;
        Wed, 23 Oct 2024 06:29:14 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:13 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 23 Oct 2024 15:20:07 +0200
Message-ID: <20241023132116.970117-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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
Changelog v9:
- default to BLOBLIST_ALLOC on arm
- Move default for BLOBLIST_SIZE_RELOC up
Changelog v10:
- Revert changes done in v9 and use revision v8
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



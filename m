Return-Path: <linux-kernel+bounces-364115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC299CB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7B61C22317
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931B1B4F3E;
	Mon, 14 Oct 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="HtIKbbMQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E61AC8AE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911572; cv=none; b=jT5BSQazWDORkRZesfOF8zS7l2DR4l05xc3LjpQhs6sB8b9sr+OtPCBJszr8xXWzY2Bn3D1kUKA1axq5zfLW+UO/J9ybOI5/fgUwXSnyp0ByztRNb6uhJdfjkSwsvKhO/QAFbXgLoc6pFz6R4oEaw7c18qNvzeVQDX/+OBejMRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911572; c=relaxed/simple;
	bh=3yt9sJH/9oLpIC8Fb4GIaJE8+9dMvy6T3k4Q2vtH+Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcCjJ7Wy8NLuSJY9GQpdhvETVBHQHP2/3AVp2gff5edND2fla1CL3f66I69xY0irngDWb0xykwq/ZbWdEoF7PNn81Amv29X2zT9UtUesReuOUbyS84o9ZO5GQMLFTMBd8TF0bIfDXkpL5oZ0o9WlZBDeUPrkD/B2Cw0EOrDcqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=HtIKbbMQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so31934095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911569; x=1729516369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
        b=HtIKbbMQCgXpVfD/r78JVebLv0UPsPeq2TKP+FLZ6K5hxV9J6MDYUcKYtYUokOkM7G
         jpSBQaRELIaeSA+ESPf5iUusdTnBHvT9X7edwZVbI1mlrZeqylXe4e1RKxG1D3JIEYTN
         GEiGp/OZZgaNz+vZqD8nceW1f0JunSmFDZYQC23HhROKaFExLuL5hxS+8Cz6n8CDDg9G
         8Djsl3ratpVWK+Umb/wRi6sPYB7/XYTLw9HZhf7VQfpQY+KFWgBQFpy0oJrlc+tKikCy
         Brr8NsVy+QnPOyO19ZW5kVsSVfRb4A/eaZQXrgUytu/qo6iwoNkD4Q5HcucLADujCVkd
         AXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911569; x=1729516369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHk1S7ioKa/xx6F4o5jh9aZ+NMbLzhqCIFe2FGWUJzY=;
        b=v9K23qgAXF+2VvX918as/mG4XQLbLWaPUOtoVa0XkBykG8jvJ7FfKtwTk3+0vCQXBb
         ij4HqnMBi5L+vYOb/+SSewEXpAoPeqICxHV/WJ1bKl5zcE1FB4kGvTc/JxMCM4XsaNEM
         wZTntJMgC8FPdsAwFq7N9sksrw2AGCYkZ/CwD1HAwScT4tesfzH+6iPZ8aoKjuE+BwQx
         M9niilau42mE2o0f2bYj7y9UbTFpRFcrGl/xBf1rLaaCTwzlEkgRJ89BQB4uEC0sCkPP
         PE2zVBNOZDv8ONW2H+qTw0EEAntBAyRN8F8mOhSDhhkUYBAW27HRC99UuP6TdO0r4hBV
         pEDA==
X-Forwarded-Encrypted: i=1; AJvYcCVw+JSuyX68WEk6oNLWwzDf/4ieww763hZJQ1WLLPfdbcR6U74MbvywFf14F75z3rJ/B/WvT+7i4xcsq7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOgDRlwmoY8RktJJFhQQc9DcF62Z7M3d5bdsldOIVx04AEKj+Z
	ssv+O0o/9ShJkgGJm4qnjJ8gq+8r3JNXjxwOo7oe02rB9KlYUc9g1KVIKpMggZE=
X-Google-Smtp-Source: AGHT+IF/d+WE/MeRjaosnkmdNP8BiGsTmbrZNxyhg8fFyxEDtMhDCDiMMDuN7sgVFSQ5P5cyhDkF3g==
X-Received: by 2002:a05:600c:3b19:b0:430:54a4:5b03 with SMTP id 5b1f17b1804b1-4311deba4bbmr95672635e9.6.1728911568647;
        Mon, 14 Oct 2024 06:12:48 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:12:48 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 24/37] common: Enable BLOBLIST_TABLES on arm
Date: Mon, 14 Oct 2024 15:10:40 +0200
Message-ID: <20241014131152.267405-25-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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



Return-Path: <linux-kernel+bounces-324261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B98974A62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120CE1F272A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34213AD37;
	Wed, 11 Sep 2024 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="LM7Zq84P"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629F13A265
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726035960; cv=none; b=WCpNl1K466R+zXUboLA0QcQG9azjMYwwUuijVHntceeUFxBIe6xohgnVyDUHwnl7f63PchwYJSCGnLREhh9/1xbso6Bma18vCk3goiWOWzDREYEvYStySdVrl7KTV48ghVwXkqwmpxiM8kzfeFdUCTtiJxKu6kLTfNQhj4eAVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726035960; c=relaxed/simple;
	bh=JLwZF8fKjEFyGNIiMKD9zhbkIncE0D0RoCBtmtx0iug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0nRI61W5A7O8eRw8CkrsOAJeyZwahXUBLk4fdWyg7qNg1OSXQel3V+EmAKaADy4uORvT043MditXP1UMnbzVW2BZM1jQqZC4VHQ6DXWcO4ZLUrVQ5+VZh8BMuVjQIPMn3U/zi5dQo9aLNFr6nO1CGTKTEs33DYGgLbI0EmcVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=LM7Zq84P; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a81bd549eso174585066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726035957; x=1726640757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxCFxz2bLoFRC2x/WPEy3sUdM3u3vLiqPM2r7g97edM=;
        b=LM7Zq84P6GWLzf5Fe8J/YmGMqHgBJlEaQbZnNdG/Su9wYZOY6lbMmeLrX2oVWrFeTz
         vMmNi8sSRzmsp7si5a35/ESYdbUz/Y2ugXQrbNO1fJkYNBC2kk1snNx4zBhzSD+f5OQH
         cjX9wIJICUxlqVaPYD1j/TR4QOxcYpn/AvD9beGS0g8yj2nHPDtWJ8u24qu5lAd6xx4S
         A36w+kcUitJb66gCK6OXifdWpjw2PdDv69eEQIIWQT6sq227hV4utuLg4e4KAAH05wv4
         56+EyzzGocppHh29rEHowF3TykYiDWjC/oe41a75wpA3/bBxRg2eA7DRni5gbsIp5BOv
         xMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726035957; x=1726640757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxCFxz2bLoFRC2x/WPEy3sUdM3u3vLiqPM2r7g97edM=;
        b=VkSHt2zI8zb9PAKVLVocFmr5GrCQKU8Ht17rhp9Cj4xJ5uuDNzivuOW/VuxvYYejgm
         YAB3Adgro0UgOO/JCLlz0UUKAsYYFXWXK2zl0TCYMcpx/L7wNdr/XSpB0dck5VahGaov
         0VxBs2lBfZdkOBbky7IAmAltZ9tQA/yJYMhMnHw9tMIe9txwgQGzEo9oEjULc1CQG7F/
         lnUBt9jMuomHXrHyVYRyqvU+OqgdxwQ5AE4B8gJ3Dfe+0eGEDjyslFZOiHgl3Pcrx3vI
         8Yjq0jMawFYSeO5HrWbxRtz8B+rF0NZClaAO309+JRB5EPA2ZEaK2ak/OBn4rwjT92mx
         bgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxDUBFzoUzMxRnvdkH81Z7COvxhkky2ecL4lCzAEcfutIKvbWKkkfAtxieh59npI5JHp+uGnr50rSf0Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/Lgzwj+XwQGQjtYWh7Dd6DCHlxht8E/TkfvIrv7quNGP1G82
	Vdy5e33p3oGczgD2NZuayHlp87U2BS72OZ96ZIEJ+EkQUVlUk/+ja9QifBWgGEU=
X-Google-Smtp-Source: AGHT+IHnbhD/epd2XJEWZ+EEx+VenyGemZ45EKiZLjhS6pJY20qH6Hh1VfnRnfCiyKiurj+UK5qLhA==
X-Received: by 2002:a17:907:e2d4:b0:a7a:bcbc:f7e1 with SMTP id a640c23a62f3a-a900482ff26mr201137866b.15.1726035956825;
        Tue, 10 Sep 2024 23:25:56 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 23:25:56 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 21/30] common: Enable BLOBLIST_TABLES on arm
Date: Wed, 11 Sep 2024 08:24:11 +0200
Message-ID: <20240911062511.494855-22-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
index 83c81edac2..a864e24508 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1075,6 +1075,7 @@ config BLOBLIST_SIZE_RELOC
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



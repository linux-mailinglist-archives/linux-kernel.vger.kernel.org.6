Return-Path: <linux-kernel+bounces-282451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E9B94E44C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53B8281E11
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5C17556;
	Mon, 12 Aug 2024 01:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="GNNcUdik"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1117BAA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424415; cv=none; b=CyqtyeSEzt8KHvHUSS4Xw3W3niFiTAjUnhMKHhle/LoEyWMscHOorrwC+cyOoniaKrEa9eRJNVfp/+ECzB/KQkIO76xRawTCuhsgBYEpOfwtp6+9PJH3KWKoYQUZvCbqqV2oqh6qRRct7BdI1lWB/vUvTMYIotuY4TClo4HHTXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424415; c=relaxed/simple;
	bh=Vcq+n8JQdTk3vmf6hqmLO7PiXIRS5Btk4ojcnv75rJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIb8CXr42zScDRh2ARxaYFhDEGYSrZWx4CvxOnuv2WeIkra0IKEq6HOoEdK/84AQvebPlnjACyxpVoSRtCsI4EihmEfKAJLM1gPbY9aAnB2TTTHbxVDoMgKt2iiV/SHLfeLqsnLECi/s3Ny0WanaFBJfy4ZqZKkrN6UaA22mKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=GNNcUdik; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd65aaac27so32127405ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424413; x=1724029213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJwTiJ9RwivJpxYHWXKjwIEWKuv7B7ooXczAECPccKA=;
        b=GNNcUdikKsWtnzLHTFz4yF7DfWuZtjqDRc4cvfjQsyu9qRcL6ZZ/E3rb2eYGfkYqsW
         YIHPfeeKa6vTZ7dgD2cFQGACQ1NW+HJDBzy6oF8tKpPTH5DOCatpknaOLwF6Ou9ifKU9
         6k1KkH0H44jFAf30Cm/xocA8PLZRq87DmXRpD+4dehf5/btReVM/vB37uhP++Uk/Cg6D
         yuICpdolKl4tx4kAp0xrpahfBGbOg9Wp52GtMVl2tfXuJCkAXRNIaDnnOic37FmSukMi
         9ysjltXUN8vGKVCwzWQGLnCZlqRZyXQXfUWnEYu9eGRQkTtQX9aEqliJrQed6OuRopJa
         nQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424413; x=1724029213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJwTiJ9RwivJpxYHWXKjwIEWKuv7B7ooXczAECPccKA=;
        b=eqPj+XZTJqUu7S4dN70B+GuheRoOUX9ZZF1a7Jb8+f6oUtH9UxK2R10AR+g8p9+NOo
         HiLHPvWIZ2qJi+ZMman14u03Gk0Ox6XAqVcGfn8DAJ5jJBv+OieU+yPssEWvzETPL1w8
         b1HcFKBUtmelHQ9jCtwk/e4gBVgUEVKHV7XZ68pvKpigNOlf2O536tm8hVd6UA015J8c
         nW2ufyjD2YCulGTFstOyz729vsw6iH5+rzFN+m3VaKWxb/HLtJjtOVKecjO6Pn3Rmd9o
         o2FcGbJSrX2Wb460tzAqwHHdu37GBIvKm4M5+8R5kuyBDfhI9Ot27qztm/n9qZoqboFp
         L5fA==
X-Gm-Message-State: AOJu0YyZojFGjbsj0TPp+903k6hbGVj2w+cArBz0wutmKwskOitOPul7
	hnl9BUBvuMyuNf7bEtzBjwim+BUxsNVlgQIlFI2k86jBC3saf8XxU1EOxzwgBe0/2oCe1Z8OpP/
	ioiZesA==
X-Google-Smtp-Source: AGHT+IEe5Qz6cd7b/1zBihHx5AlfGtYBeT8sDhSQ+DFn35gv+sWFK8VgaNh+IQbBrU4whiezDiQL7g==
X-Received: by 2002:a17:902:e5c2:b0:1fd:8f7b:1e88 with SMTP id d9443c01a7336-2009681bff6mr206131935ad.12.1723424412492;
        Sun, 11 Aug 2024 18:00:12 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:12 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 05/17] ACPI: scan: Add RISC-V interrupt controllers to honor list
Date: Mon, 12 Aug 2024 06:29:17 +0530
Message-ID: <20240812005929.113499-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

RISC-V PLIC and APLIC will have dependency from devices using GSI. So, add
these devices to the honor list.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 374cae4aef78..39b3ccae9f79 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -861,6 +861,8 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
+	"RSCV0001", /* RISC-V PLIC */
+	"RSCV0002", /* RISC-V APLIC */
 	NULL
 };
 
-- 
2.43.0



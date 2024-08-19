Return-Path: <linux-kernel+bounces-291288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8E956078
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14F391C20FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646171870;
	Mon, 19 Aug 2024 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="A3JTKx2z"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4FEC2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724026333; cv=none; b=uFASkuzPIskK8LgXe/81lNgIAd/2FmNlGQORSALG06KMMNpwTO+4+C02NuP7m8MUsz9DyiVHLFUdpGx/j6IGWDNtxb+JwbLAU9w3fj53+PYzXFeIEEH4nRTVShxIc+5Rr+Be8MyvUvAYvu3y7hTn9qCzgbr5DnMzmwmOdhqevkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724026333; c=relaxed/simple;
	bh=EIEZR07uodfT7SZBF1KToNEzaAQAyGnquvtZtykYcrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwO6RaPs5noZyFFig0KqewIrOV2Ny11Wz3ei+eAtpAgyAaLJbpIfdT38Ks+tmlL5BJrppOhcb4oKyp1oHt33NB8VkvVLqtadwk3y6Pc7mMWd78c7mVmXU5UBz2ZLT8dlkNwwW5eyqH9A8N2DkLQ0fbOAoUDBw9nnZmcWT3JOWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=A3JTKx2z; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-492959b906eso1442390137.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1724026330; x=1724631130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkS98moYkgQs8n0Vsl0Kteo3XEop/tJMuQlKicdiPAI=;
        b=A3JTKx2zMuPcCJL19GbZo4oHA6haYePMabhu8RO2phQ3wkSerFxbJLbCzCqTdLcZ1K
         cUzo3Le0uvUk9kSm9j4YeLD3tBoZfwY1lW98PLj5nzdwqA9eJ/e9R5n6Xb6K4Zlym9Sv
         rcqvwiOrfo5R12ehZ6ENykv3usHHHmKY85vBk4iJy3qjz2rBoNIk3KYfOYw3Hi+e40PC
         JvQnYdo9rDjsppeJL5fkWcLwjwsHJkrK7a6DhG5wzhWTlLNh6oS6/QSaWvE6omMAfX2j
         Naayv7sl+izMs6eDkgFYXO2mL8mgjD7lIKJgA7IUylXJrgrQJBdcgWz0P6gwNhNG2riq
         nwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724026330; x=1724631130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkS98moYkgQs8n0Vsl0Kteo3XEop/tJMuQlKicdiPAI=;
        b=LAp/Kyn991H/L5DByd5DWaw61yWJggYQdzYLlGE8tEoT2XPgbchBwHks2xGbNtbN/h
         LMyjF9LY5P3an/lvOmDMOjgBhIYDodeIo1/1M1M7hpmARbRaF8ORmFUyfoxkFC5kOfST
         MftFFPNGC4haM1bYasde7xec5qgpdjH9P3oP7z81tAWBI+gtaYRz3KddRRnaEM3uIBqQ
         x3auf2vMvHUKCwyVEXBIh0tW3AIalSg4HUAEEtFudIE7SAGdWjvmV3PGzx4rY6/BvzoD
         otooDSTjkiMHHKxv7s1yq/XI0CmNwxB3k6+y/95ahkxtsTNSi4KyFXk12Vjaki3UH7eK
         aF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHrMUHETBe/qdRKyBMzZdtCn0BRARkEP6/pIHCXrOJhHlBDTYv2qC8z4g1pRFcKwE6oyTQeEah20gPjgckhO9bane2ImcmGHtKLJaL
X-Gm-Message-State: AOJu0YwE23ZoO2Nf9fkVSKtHj8aTVNM3hQ8HRYbghK6ifdUufHVm2Vy2
	TEpcCYELZop2CzLyueX+8o3qSvP7mUv5TEAIDNNAffR69GahcbsyMAWJ5AVAciA=
X-Google-Smtp-Source: AGHT+IFNwqE0FRDwqV4ZC/3rm2t54kHlJ65+y7J2QjdvQY70UkSDeWgraa6RRshDx6EHOAFF4wlMfA==
X-Received: by 2002:a05:6102:dce:b0:48f:95aa:ae2b with SMTP id ada2fe7eead31-4978859e54cmr8133396137.28.1724026329844;
        Sun, 18 Aug 2024 17:12:09 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.local.tenstorrent.com ([38.104.49.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02c888sm387055685a.20.2024.08.18.17.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 17:12:09 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anton Blanchard <antonb@tenstorrent.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH] riscv: Fix toolchain vector detection
Date: Mon, 19 Aug 2024 00:11:31 +0000
Message-Id: <20240819001131.1738806-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change to gcc flags rv64iv as no longer valid:

   cc1: sorry, unimplemented: Currently the 'V' implementation
   requires the 'M' extension

and as a result vector support is disabled. Fix this by adding m
to our toolchain vector detection code.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 arch/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..939ea7f6a228 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -552,8 +552,8 @@ config RISCV_ISA_SVPBMT
 config TOOLCHAIN_HAS_V
 	bool
 	default y
-	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64iv)
-	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32iv)
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64imv)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32imv)
 	depends on LLD_VERSION >= 140000 || LD_VERSION >= 23800
 	depends on AS_HAS_OPTION_ARCH
 
-- 
2.34.1



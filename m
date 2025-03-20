Return-Path: <linux-kernel+bounces-570513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E77A6B1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5D33B4F83
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3422A819;
	Thu, 20 Mar 2025 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaSTqBvV"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6C22A4FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513287; cv=none; b=OZYzn6dpL7CVs3tHkJNY+aV9A1yvS7gEhXUkgIASjWPm2GeTpoMqsNQIZzfelLPEFjCLPyXIP3GBl9FpMSUjLMcz5mgCscyyUgOYu0xnMw3aN5Mm1GrcVfmpMB4l+D7pCLDrOwVHdhruF9Oe3vHQJDo3HChifKtCunoBX0mSbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513287; c=relaxed/simple;
	bh=sTzT5PtwQSPHGFOm3VurrDvsdk8Mjq6EUX9qB/8ft9M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Q3KyRNYLZVWpUxc8BbcNWo3jHXFTwozGEU2PTQfKc7joJ7tb+QN+6y2DyttWHtzPKwmmrpd/S5F5R5IMseAmdDC1KJ+35tu0A4c2XKG53UvZuVmX5Nx2zVAoqe/AOO5pA7i7+FBbi8KdBxHGiWlVrmDn8ybUcQ+jQqKRQE3IjsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaSTqBvV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso3053936a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742513284; x=1743118084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kzKhceJYkAUqAvfvyFb46En6N7ik17gmHG0Ft959/Ys=;
        b=MaSTqBvVlvd8QmrxkuM4IcrQwPmDyczMhD4BOENlrUXSO7ORTweuil9G5IkpK8Z4yO
         QX7iP93UA/RXBSgAK0BETlkZuJR6XBjLJxj9N2oq+es+/xgxiSFewfEyKLIVNDVIHOM+
         2v18BjEpsCqjHU2lFMgia5rSn5iqn3haADyl9AENK+GUdXTEz3PYPKOlw0rLAJkhl+w9
         zrpzSbj0rCt0iQJgamPhz5iE4saJqL1L4yI+01FjKA9Un/UMHlf9FYYdHG1uiNXf0oBW
         G/HUERmg5OLRSxTneZElq6VH8UHs+ThHQ3Qgd3lyk9INqBZwjNgfWR6xcKWW5nOwp7s/
         B7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513284; x=1743118084;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzKhceJYkAUqAvfvyFb46En6N7ik17gmHG0Ft959/Ys=;
        b=xG4gvA2GPrDZEfjea5v+ONz8gHBnofFmVBzsXdwy4cukppzJFamX2ruQT6/SOHD6iM
         arx6IeYMHx6k32l39EzXkMa7s9MMZl8WsWWDWf2jCWEd9QEVKcX+ABt8MnDkm+dhhdul
         3V2AUHMRGaoTaSWpqbjdGQUyblxM+I1G7Ld+EKwf2NW0/KxJdh1hk79o0/tNvU/DkX0H
         LdRLLczXrO/afXg8zFNH8UgS7kN1Iq0rLIeSloBux3X1d+cSltEGOLJlqqnnWUKm1MH3
         wdxME7+0ucGAfvlowrUlNmqkYlJUuSLxhSx9aCYCsN6fFTfVhwkHwk+E2tMNSukbm7Fe
         UhSw==
X-Forwarded-Encrypted: i=1; AJvYcCUwtqZzSnVkdbOgytmPeVUBjebptbzpzNa+iTISnpjljci+zHKQgKoH8OpJVDjrIXxlf3GIHZGdZH8+Fa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElXp9olbyGjNTIvYXtjNAnHAMT2QYr7zsTPXY8gZ6PsLT0XJL
	w9V0e6ZIzggYdpEuOLSWS8071iHhQjhYmcvZAz+7MbsGudPuzLWQmaxdERRJvLNyvkNES6kb0fy
	bYNOB79uSWz0x8JFlzO/HhR5Szw==
X-Google-Smtp-Source: AGHT+IHnAupWokYIK22X9v/qMVPuyMFNnXuVjx1FMSGpF61YwN2ljJRb873YXI9hUKxhoK14+Ih+q/r8UQu7GQopifg=
X-Received: from pjbpq9.prod.google.com ([2002:a17:90b:3d89:b0:2fa:a101:755])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2551:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-3030fe595c0mr2031878a91.7.1742513283758;
 Thu, 20 Mar 2025 16:28:03 -0700 (PDT)
Date: Thu, 20 Mar 2025 23:27:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=samitolvanen@google.com;
 h=from:subject; bh=sTzT5PtwQSPHGFOm3VurrDvsdk8Mjq6EUX9qB/8ft9M=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOl3ltT2hVutY8g1/PDl6u6AP4GND2d9CpBU873Zs17EK
 yOh9uTmjlIWBjEOBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjCRskiG/9F5Px3Ot6o136w5
 fDv7eqJv8iR3w0YZT3Nv0Xldn2/su8LIcJpxm8H6V2m6thEKRncv5XZu3y67Qsar1+CK8aGe+Xw beQA=
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320232757.2283956-2-samitolvanen@google.com>
Subject: [PATCH] kbuild: Require pahole >v1.29 with GENDWARFKSYMS and BTF on X86
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Paolo Pisati <paolo.pisati@canonical.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr variables are added
to the kernel in EXPORT_SYMBOL() to ensure DWARF type information
is available for exported symbols in the TUs where they're actually
exported. These symbols are dropped when linking vmlinux, but
dangling references to them remain in DWARF.

With CONFIG_DEBUG_INFO_BTF enabled on X86, pahole versions
before commit 9810758003ce ("btf_encoder: Verify 0 address
DWARF variables are in ELF section") place these symbols in the
.data..percpu section, which results in an "Invalid offset" error in
btf_datasec_check_meta() during boot, as all the variables are at
zero offset and have non-zero size. If CONFIG_DEBUG_INFO_BTF_MODULES
is enabled, this also results in a failure to load modules with:

  failed to validate module [$module] BTF: -22

The pahole commit that adds 0 address DWARF variable verification
was merged after v1.29 was released, so later versions of pahole
shouldn't have this issue. Require pahole >v1.29 when GENDWARFKSYMS
is enabled with DEBUG_INFO_BTF on X86.

Reported-by: Paolo Pisati <paolo.pisati@canonical.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/module/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index d7762ef5949a..7c75832aa1af 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -192,6 +192,10 @@ config GENDWARFKSYMS
 	depends on !DEBUG_INFO_REDUCED && !DEBUG_INFO_SPLIT
 	# Requires ELF object files.
 	depends on !LTO
+	# Requires pahole commit 9810758003ce ("btf_encoder: Verify 0 address
+	# DWARF variables are in ELF section") on X86 to avoid conflicts with
+	# __gendwarfksyms_ptr symbols.
+	depends on !X86 || !DEBUG_INFO_BTF || PAHOLE_VERSION > 129
 	help
 	  Calculate symbol versions from DWARF debugging information using
 	  gendwarfksyms. Requires DEBUG_INFO to be enabled.

base-commit: 4701f33a10702d5fc577c32434eb62adde0a1ae1
-- 
2.49.0.395.g12beb8f557-goog



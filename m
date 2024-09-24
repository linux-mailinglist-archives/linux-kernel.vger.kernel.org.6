Return-Path: <linux-kernel+bounces-337336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2659848CC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956992831DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0881AB537;
	Tue, 24 Sep 2024 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R50Ve7K2"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110CE42065
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727192534; cv=none; b=X9RdJRE7qXoTv4kaOUuX2FZZv8mEpLJMgD0IZFfNFAVKNrIJRNr5KRdA32xF8yPfoAzvzacYzjYnd4apx4McFUmYQiAknnW1Z3fUYV6vmffhTydX4hFLdtptUzRCS6wy8Xes2/LFz/3/oWhDKp7DA8WjKwlJWIQCsXytHRop6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727192534; c=relaxed/simple;
	bh=kSfyFx8YIOeGgaLCpeXNoNyRaaRrvq6kOs9KcfMnowg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBNm+NHONI2mzE3JxD6lZSdGvuc76fGy1L31FEfQPFETUa47eHsm0g7aY0QLWSHe0Hhl/hRVVKphtvSwQEYXprhKfO0tqvGck09or/Jci2ZLYx4gEn6EzIhhCvC9zlnGNptwKnaHLsj9IZiky5S9GVA/hE3TTEow9Poz41+WXRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R50Ve7K2; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e033e37bc9so2046839b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727192532; x=1727797332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ixG4ZDMzlyFb54v95QvHKMCeLFRVK54R0LPeEeUbegM=;
        b=R50Ve7K29+cV0iMFlUonSajJlx8o1j5031zC3Hruqhqs42lQA15MoqyLsiJSMyfWlA
         eHiVi35b4Rg+A43O+uUnQH5P/ilxWrrfBPLx1s+HwqYOuyN9Ti+VR0M9LU0VfDuCvJEt
         eIwNrJkh5cvqqw6mMI/9oeclFS4yO3pKMJa8yQNDTyGp4y4EmcgZi1ijgLlLm3nrKc5M
         91G7tYvngmQxGN8Nh7b5Wcin47pTu4scab4jZXrDq8oBr3XY9XClUJUe8gO1IAvX/+KQ
         iPUolm9/+alK9zK0lRabAhpNqu7Z21ICu7DULLA6seSGMOKm8OIzqPWRs5xqqZHoBNDi
         6gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727192532; x=1727797332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixG4ZDMzlyFb54v95QvHKMCeLFRVK54R0LPeEeUbegM=;
        b=o29vRHj5fyKjfgRTd33b4vrlzbhQ/xaLSWXtIWAuilgNUVSmBVgNbwnpnNlshDrRL5
         1REPoWef49WU7YV2Y3C4r0eLbXHRRdGE2N754Jplz/nCj9hokhGm6GEzHLP84TRkTOhO
         /okc1WTwFLEmEkZWvIPT6KxdBiI2B3vTUxGdT7cq/VYaha0fNdOdICp+bv6nI6MDQIo1
         Nsl8srxGtb9MF8II0mn64ZNc1aPDuvO65N1G2DQ5kL2OWRnKGqiCrqASWPTWkuyHqosa
         a/LxnxEpEQYZeq+6eBFrQDU6DUQ9XhrlZnGXOZ6OkeQJ8FThJczX0zQ67acq7/FsNXFb
         9iUg==
X-Forwarded-Encrypted: i=1; AJvYcCUsjG6hdUTidG1AfY+fPazz6a3feryxGpz/FlEpq+MC/Cd+YuFVzZ71zUY7w+mnELVpANr8Sc0UpyZsGD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/peF0oX8z+ljYx4HWodyGk4QshGPP8gby9+sHr5Qrtbury9d
	zVTNwv1WyzhvyPVESvPHz+5Ia/tOAuFVipLqICtGOnXQmd5INTF9vsu5uw==
X-Google-Smtp-Source: AGHT+IE+4oss++7wD3iX/wU5uMQRYlB9EgVM04UXG3m9krNJWRpmzDKONTiHTanuM1LlFyp5S+aFDg==
X-Received: by 2002:a05:6871:112:b0:270:5320:2d6d with SMTP id 586e51a60fabf-2803a8d5e31mr8435467fac.47.1727192532170;
        Tue, 24 Sep 2024 08:42:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c308efsm1343612a12.1.2024.09.24.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:42:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	David Hildenbrand <david@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] mm: Make SPLIT_PTE_PTLOCKS depend on SMP
Date: Tue, 24 Sep 2024 08:42:05 -0700
Message-ID: <20240924154205.1491376-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SPLIT_PTE_PTLOCKS depends on "NR_CPUS >= 4". Unfortunately, that evaluates
to true if there is no NR_CPUS configuration option. This results in
CONFIG_SPLIT_PTE_PTLOCKS=y for mac_defconfig. This in turn causes the m68k
"q800" and "virt" machines to crash in qemu if debugging options are
enabled.

Making CONFIG_SPLIT_PTE_PTLOCKS dependent on the existence of NR_CPUS
does not work since a dependency on the existence of a numeric Kconfig
entry always evaluates to false. Example:

config HAVE_NO_NR_CPUS
       def_bool y
       depends on !NR_CPUS

After adding this to a Kconfig file, "make defconfig" includes:
$ grep NR_CPUS .config
CONFIG_NR_CPUS=64
CONFIG_HAVE_NO_NR_CPUS=y

Defining NR_CPUS for m68k does not help either since many architectures
define NR_CPUS only for SMP configurations.

Make SPLIT_PTE_PTLOCKS depend on SMP instead to solve the problem.

Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options")
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Make SPLIT_PTE_PTLOCKS depend on SMP instead of defining NR_CPUS
    for m68k.
    Drop David's Acked-by: tag.

v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the 
    existence of NR_CPUS, define NR_CPUS for m68k.
    https://lore.kernel.org/lkml/20240923235617.1584056-1-linux@roeck-us.net/

v1: https://lore.kernel.org/lkml/20240923142533.1197982-1-linux@roeck-us.net/

 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index e85164c2812b..33fa51d608dc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -595,6 +595,7 @@ config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 config SPLIT_PTE_PTLOCKS
 	def_bool y
 	depends on MMU
+	depends on SMP
 	depends on NR_CPUS >= 4
 	depends on !ARM || CPU_CACHE_VIPT
 	depends on !PARISC || PA20
-- 
2.45.2



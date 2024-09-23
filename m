Return-Path: <linux-kernel+bounces-336411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D88B4983A87
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340C9B20D96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41888132106;
	Mon, 23 Sep 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeGNU8kX"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B7558A5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135782; cv=none; b=rU1UNcuh49n0nJUuWGzzuIAJTsQVl97/XDmt52DX7QnTSD3PmNLr/XV2oH3iCAeLY0MBSNJRO86M/XQrHwH0rOWou9xH0k9mXOOdJssRB4xAPzJwj0oBp8sXdrtaod9f251Pwkyu9gNlTu21SsCHIvwjkmR6o7eatzNzetjriLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135782; c=relaxed/simple;
	bh=GubX7HNiNPGqZwTFgnbAHBHpyKU0GeQ7/76qRjIJnlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7CCMXGnCT300DpgrBsrWi6ylcwGJ/p0MC3cQjLMwOaHe4IEQMh3/eW1Bza8UNjSSph5mq6TSjGsCiYT7EGOva0wXDYEe5Wf1vBNCTFSFMpjptdJ/2MFQgeWOcJilCvLzhTaYO6CYeUzLkTb/jZ5/Y3IEtd3l3R9yMS1SpuqOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeGNU8kX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7191f58054aso3678592b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727135780; x=1727740580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Lsiix1AZouLwNVfdcdY6F4P4euU9juLa/FjJUtcM2Y0=;
        b=JeGNU8kX8cnTRATy4NBKcpR02iWQJsd1acb53Vqe7PpgerQYQILFreHklnin9kzrge
         84YOtGQ6YA0MwHApFQaXz3qtOJY3KEkA9A/s0P5QPkfJuOev9mNoZ0kCXJQDp0V6uHlJ
         L5QEUqvFLvxVdSC5CDQXHZxh9WVEWQtF91IIfOrINtuiGB3ZEpKQegTrof+qsJVmYWlv
         B/pdqFDbsYxXaWFFNs1+iiN+D6aDx+Zeas7NFxpXwO1iI9BGSrKK33i/XXZ2dyJ9O9mQ
         VfMT+6mim1X6kPAkqQoNs/Ue2K0HSx5+tjFaKfuKV2IDjyBJ/7DMwcgdG0Vwuj3dZuID
         w50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727135780; x=1727740580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lsiix1AZouLwNVfdcdY6F4P4euU9juLa/FjJUtcM2Y0=;
        b=pnva5RdgpkeRC+wXnT7Z0ajG4GGoeVxVlvR0uvA8yjJ4L60I50tJtu09WxSNp72cql
         9yNfq+Eh228USvFY3/tOAjE9w7QhAJHRkL7sdzhIzTFHKqt3Taf9fPeA+uA6hbJVPL/O
         aAHF7MtVDUXFV70iYZfym2O9TPf6HCMqJpDP1PfSU1gBOhMheLY0RKHJ6scurkjwtRh5
         nn0Lu/1etz97VMXEV4Jg/CZjhofeXGr6OmJOxuMf0l+4ZvtQ+XyIchY1mt2qIYVqOqTk
         l9l48MZAl4QFeKa7Z8fT9hLhmB9dCnZhc9NXzpdLpHnHhW0mbtDh0XyARxzOS5ApxM+G
         3g1w==
X-Gm-Message-State: AOJu0YymfDybAdmTFyJgK+7rSAtbT7ug23/Dr8hPDlYyroHfrAcLzGJb
	g980wgSqqkUUDVTocfqT/t6v8rNvt7PBjEVkyX9eRo2f6jImEVma
X-Google-Smtp-Source: AGHT+IHLfQ5xUTK61QHlkYP+KcDvKOKkE0Gu12DmjoUm7AROJH61aTOqurK/aSnyCwW/TSTdUl761w==
X-Received: by 2002:a05:6a00:c81:b0:70d:2cf6:5e6 with SMTP id d2e1a72fcca58-7199c9765bfmr16943619b3a.15.1727135780251;
        Mon, 23 Sep 2024 16:56:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc9390adsm156191b3a.134.2024.09.23.16.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 16:56:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] m68k: Define NR_CPUS
Date: Mon, 23 Sep 2024 16:56:17 -0700
Message-ID: <20240923235617.1584056-1-linux@roeck-us.net>
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

Define NR_CPUS for m68k instead to solve the problem.

Fixes: 394290cba966 ("mm: turn USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options")
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the 
    existence of NR_CPUS, define NR_CPUS for m68k.

v1: https://lore.kernel.org/lkml/202409240546.SJwj9tUj-lkp@intel.com/T/#t

 arch/m68k/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index cc26df907bfe..53e4058d2e3c 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -76,6 +76,10 @@ config PGTABLE_LEVELS
 	default 2 if SUN3 || COLDFIRE
 	default 3
 
+config NR_CPUS
+	int
+	default "1"
+
 config MMU
 	bool "MMU-based Paged Memory Management Support"
 	default y
-- 
2.45.2



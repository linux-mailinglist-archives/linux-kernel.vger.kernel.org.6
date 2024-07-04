Return-Path: <linux-kernel+bounces-240383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8F1926D1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D681EB21851
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579E2C2ED;
	Thu,  4 Jul 2024 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZWn0lli"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C85C13C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720056571; cv=none; b=XLOvZNMxWMOX2z3SmDjK5551e2/lEVzfavUP+hPdkglwyHoAY7IgIyLxoFV/f3RpOXs3MohZ7+ctbQIegAjnaCLRCUC0ycp/yQ/fjXU84c5VmNHdVqcs2dF/CHq5anOtYpDfEjYYGLfgQffC8kAkEw6M/PIhijj+vHrKM9aZ0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720056571; c=relaxed/simple;
	bh=1LLigQzRJcZ7jTodrMY3Nqf5PRQqvpWiqzUgy6EV33M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbCY546sdWIqM4Ht0mRJzVMFobAmcRJanGy3n/UjbSjl6PMyN5nBu8kHf7ELv4JlVXzi7GXV8/jUrXLcfvKc2DljvTGotcjUwolaEic4DcoS3g8B8OVtct7CFfNGKcMj5ZpPaLfPeWu6shpUunz93sHDZfmlVMKQqAgt4dW0vA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZWn0lli; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb0d88fdc8so357935ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720056569; x=1720661369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2zTWVQnMIKGjMTvK0RHwj0LBB/WZaUJ/hC6BYDoEtU=;
        b=IZWn0lliBXQ+DMluQ5ZrU+5EQJvvSr3ZHDbG5AQT5YnOUMD99F3vCKnwVKwf/chVCy
         m61RZVrK1POo9Vj/LYRBaV3LSiW/OjyYT46Tf4xGJzi6p0rJy+lkYwG/6jQxLiaSlnez
         40FO++fAirJCU0odBfmRWsUaAShKq+ozubN8434yx1afgRbKVuUGzbZf+EZOatT5zlUb
         T5V15fiPitXUHPV7h0zSAuOpkiCY6uGcSXCeKeIfG2uR8U25mgr6Odv4eKlX6NElshXx
         IQU2SadzHK7uahYdaUcolbMr+8UGZiRLcNF/PeIShinw1Kq1X2vY99dVNqd2ASS2wdJM
         wbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720056569; x=1720661369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2zTWVQnMIKGjMTvK0RHwj0LBB/WZaUJ/hC6BYDoEtU=;
        b=LfvH5gPMoJ+b9N8gEVFXlByhPQU3c58tHURbIV39l5oF1/B+9Hx60TrkSPpjEUanN6
         r89pMOMYnx6/VgtIA4afsPbxL4YJzmiagzOal5Xb7qTABApAG3yFNgadrTS1Xjbuyovs
         44BIKccQ/nFL6uWhSChNrHpEvdug25zgZrICxuOYBNoN96X5jevAM/y2I4J4weOm67U7
         TfawziTFsNCU4M/j4sk8m9CoLWZGPCPB982F4ZHQ80fU17/vT5FTfwidB8zYVgEySKPz
         l5gfoZp8HCYCYwDNPYj5m64HO85DH9JOiREYG6YtN+KL05epVIRHUVDhEAgmsp0vMjwC
         scTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbM3kNo9FeYlYBLjCukov4YxLRC5NoOTH+9mKS4vZ4AkvrfZ+I8JWcAuz7YJ/ZoLIK5agAhRv/aBPm0Op5Jp0i4IZx/ubyNOoD2R/D
X-Gm-Message-State: AOJu0Yw1PH1a5fNacmkw7Q84aYiRliUBJfM/LkKMAzZJLhjHZzev8Kdr
	SpMR7iuARpDrXL4DVXQCIsNOn+eFSuQmI/3gHQHOgx9NdpYdMkWq8TUEg4BlzhA=
X-Google-Smtp-Source: AGHT+IFk8sUO3gZ4OE83nufv5PWvkhVcaMyMcCFBxB+4LU28n+00ozyhyHdSki+6s2j6yMQcng0nUQ==
X-Received: by 2002:a17:902:dac8:b0:1fb:ee0:d996 with SMTP id d9443c01a7336-1fb33e9414amr2782235ad.38.1720056569387;
        Wed, 03 Jul 2024 18:29:29 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac153767dsm110162735ad.148.2024.07.03.18.29.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jul 2024 18:29:28 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: dj456119@gmail.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	libang.li@antgroup.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v3 0/2] mm: introduce per-order mTHP split counters
Date: Thu,  4 Jul 2024 09:29:03 +0800
Message-ID: <20240704012905.42971-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

At present, the split counters in THP statistics no longer include
PTE-mapped mTHP. Therefore, we want to introduce per-order mTHP split
counters to monitor the frequency of mTHP splits. This will assist
developers in better analyzing and optimizing system performance.

/sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
        split
        split_failed
        split_deferred

---

Changes since v2 [2]
====================
 - mm: add per-order mTHP split counters
   - Pick AB from Barry - thanks!
   - Pick RB from Baolin - thanks!
   - Pick RB from Ryan - thanks!
   - Make things more readable (per Barry and Baolin)
 - mm: add docs for per-order mTHP split counters
   - Pick RB from Barry - thanks!
   - Improve the doc as suggested by Ryan
   - Remove the outdated note (per Ryan)

Changes since v1 [1]
====================
 - mm: add per-order mTHP split counters
   - Update the changelog
   - Drop '_page' from mTHP split counter names (per David and Ryan)
   - Store the order of the folio in a variable and reuse it later
     (per Bang)
 - mm: add docs for per-order mTHP split counters
   - Improve the doc as suggested by Ryan

[1] https://lore.kernel.org/linux-mm/20240424135148.30422-1-ioworker0@gmail.com
[2] https://lore.kernel.org/linux-mm/20240628130750.73097-1-ioworker0@gmail.com

Lance Yang (2):
  mm: add per-order mTHP split counters
  mm: add docs for per-order mTHP split counters

 Documentation/admin-guide/mm/transhuge.rst | 20 ++++++++++++++++----
 include/linux/huge_mm.h                    |  3 +++
 mm/huge_memory.c                           | 12 ++++++++++--
 3 files changed, 29 insertions(+), 6 deletions(-)


base-commit: ec34ecf3924f09a694e5c7d8d7e785b82f67f9f0
-- 
2.45.2



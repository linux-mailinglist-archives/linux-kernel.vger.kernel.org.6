Return-Path: <linux-kernel+bounces-368619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4579A1270
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A641C21B19
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D52144B8;
	Wed, 16 Oct 2024 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="cvkobwFk"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B223A212EF9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106715; cv=none; b=ahcfuLjIfay/ZbC0s7Q6WiMtDXNX65wbp+t2HujdvQ6lAddFkWybgLbVktedR/L62mpEJqqqgXWgBmL76O7QDbW9qg98cHFBGGOSXFJ0vDrTfgB8ln3XtBlxDwIJ8dMhhjg4+0r4ce1K7ZiZtrvR2urs1oumMdOKTXrnsRHJyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106715; c=relaxed/simple;
	bh=aydxmUkA63wDYnemWtt5D14565/Yn90YGLFSu5WU2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L22vOi5St+8LtGqZbLbqghnVsFtw8UJh9Ip7ziiIQL2gdJnvaQNsYNKJ8YeE0WMrsglPw1UIdFkmGGNsigzKq9g5CzNssApml50fGfx+APIPTQEuTG5AjOyWz/vyfkSg98gNz0KjzruIZqqAO/m2wiDPKHOd/1QpaKlUwoijImc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=cvkobwFk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4603f64ef17so1510821cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729106712; x=1729711512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnTj8Lsaioq+rT9KMPtZOlgLCzamtAdxNe82cXp5oXQ=;
        b=cvkobwFkVgJ5o65CeWrDcr2Barp5oM6cNqMHxJGn4myixLz3+TAwYws/vxY+2Dfjgr
         GS3YKlVQuJkRzVZ59uMgsG7SeC9gX/f3nT7MPZXK0sJi1Pkq7D71xTpM/mReYJs5KYVp
         5kXzFUMSYP/K++CZpGcXhc+RG97hJlWMlR921RRUAKQui72keQ5SBkklOuEiLMKxuZjk
         9e7833sfRmJh3IhcLjwviFeG83s+3Xr8McljJ0KnTa82/UpY+4H/LTAM+CN552Ss6REB
         j2XvokVGGtRSoBJPS2/7A86rtVvaSm7jNs42k7GZGalq+IlPW07Vk/GU6YA+oqtdr3gq
         TEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729106712; x=1729711512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnTj8Lsaioq+rT9KMPtZOlgLCzamtAdxNe82cXp5oXQ=;
        b=X4BJSwm0hx0P39iLIT6U592jd23xrIJAKvJvhUSBNKXm2d+1JrlX0pRbHmYWbPa+IJ
         WlC0gYBGqBDG4pfpA939u+321DmflqG0udRpcL3wN5HY+oQEtR8+rdH5tgdQwlK7hBYq
         7yaYZJxajy8zxzozJw8+zFiPH6WOLUykJxbfMwqFz1ZJWY+/5obupeK0kFu+2YChRvIY
         3QFUUyci39IimiCJoqyTTjGiDQAPHTI8gNO8l/Zb89Ku+FoTZQRMkH9Jv+Ggo4lC4mZl
         o+TExQChp7jwt+0PyCi3Rv0AJMvlMK0Ucll7hCg1R1bBtGFyKDnzd16v88noOQLHv6XH
         TyxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8O8OnccfM0ZLMTxmG4nLRNagoTH1k5dNhJtM5Bs5FWlf7LTTAU8P9LRV+6g7ZVAIwgdUUvuKyrf9P3s8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZz1xOutaBDlyQITVZdmVF31ThCUXoSv3hQRvE5sf6LQ9r+1EN
	9a3C0hHBgo4bAtJIe2TzmEIULXPejzQSv2NO1fCH2X+dTyaxtCLV4KbIYVm75EM=
X-Google-Smtp-Source: AGHT+IFLVilbKzRtR60hRVdAb2iSSymL1i+DXwV1S5+mgYdi39fcAJXLybQT7kl4t9CDE81sORKOAQ==
X-Received: by 2002:a05:622a:551a:b0:45f:890c:5f49 with SMTP id d75a77b69052e-4609b4e7150mr13277981cf.24.1729106712569;
        Wed, 16 Oct 2024 12:25:12 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b38ce69sm20271651cf.90.2024.10.16.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:25:11 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	david@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	rrichter@amd.com,
	ytcoode@gmail.com,
	haibo1.xu@intel.com,
	dave.jiang@intel.com
Subject: [PATCH v2 0/3] mm/memblock,x86,acpi: hotplug memory alignment advisement
Date: Wed, 16 Oct 2024 15:24:42 -0400
Message-ID: <20241016192445.3118-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When physical address regions are not aligned to memory block size,
the misaligned portion is lost (stranded capacity).

Block size (min/max/selected) is architecture defined. Most architectures
tend to use the minimum block size or some simplistic heurist. On x86,
memory block size increases up to 2GB, and is otherwise fitted to the
alignment of non-hotplug (special purpose memory).

CXL exposes its memory for management through the ACPI CEDT (CXL Early
Detection Table) in a field called the CXL Fixed Memory Window.  Per
the CXL specification, this memory must be aligned to at least 256MB.

When a CFMW aligns on a size less than the block size, this causes a
loss of up to 2GB per CFMW on x86.  It is not uncommon for CFMW to be
allocated per-device - though this behavior is BIOS defined.

This patch set provides 3 things:
 1) implement advise/probe functions in mm/memblock.c to report/probe
    architecture agnostic hotplug memory alignment advice.
 2) update x86 memblock size logic to consider the hotplug advice
 3) add code in acpi/numa/srat.c to report CFMW alignment advice

The advisement interfaces are design to be called during arch_init
code prior to allocator and smp_init.  start_kernel will call these
through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
prior to mm_core_init and smp_init - so no need for atomics.

There's an attempt to signal callers to advise() that probe has already
occurred, but this is predicated on the notion that probe() actually
occurs (which presently only happens on x86). This is to assist debugging
future users who may mistakenly call this after allocator or smp init.

Likewise, if probe() occurs more than once, we return -EBUSY to prevent
inconsistent values from being reported - i.e. this interaction should
happen exactly once, and all other behavior is an error / the probed
value should be acquired via memory_block_size_bytes() instead.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (3):
  mm/memblock: implement memblock_advise_size_order and probe functions
  x86: probe memblock size advisement value during mm init
  acpi,srat: reduce memory block size if CFMWS has a smaller alignment

 arch/x86/mm/init_64.c    | 16 +++++++++++++
 drivers/acpi/numa/srat.c | 42 ++++++++++++++++++++++++++++++++++
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

-- 
2.43.0



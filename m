Return-Path: <linux-kernel+bounces-387585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09F9B5343
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF811C20DAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA957207A01;
	Tue, 29 Oct 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="RbrF8sVR"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE38192B74
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233247; cv=none; b=kqobTyDIHwdIpYiQ47ke3qCXZgHVayeNzb4rWVd37Qm8xQ/MAK5dZvMQd7EGsYE2mCi/5RiQV8mRddgka8MhrkuMx4yiXRZY4NHkSAdPVUvoRAh2G7KQElIQQaGIXZ0SaBYia5YTAGhGvsdPZu51o0Wbm0odQMZf3EwQOk+Qxyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233247; c=relaxed/simple;
	bh=Ucd3s/9b+8TGInMrdzoquuqthAVcxKlayW6XKMofkMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nieqdi0dltk4W/2OtZPM209kZ8Ibtm/IKQh4Z9lw3Qp/DjfjD21lvQ1fwePhpb1SGOyKdBQpPlTsJTPls+zpiOkWyo/MdUqBwANziiWf6jwu87e7m7EynSiBh++u7SRShiUIJh7EpNSSJxm9W9HmM3J16mgz1Df7AS35h5aPTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=RbrF8sVR; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460c2418e37so43983921cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730233243; x=1730838043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPsMQe02LYzk6AvqbJXX4CMDFW9tZF0F106go5mNZqA=;
        b=RbrF8sVRPlOYR8G2qNhhxlz9aqHIkyA+UiAJYbJq8SUHfcGM0Eaq3oOKT0mI9p/Nvz
         oq4Y0EhaXWhFtOhTgnvs2WmlfP93v14C7Cg8SfomCPML8tT6j6nlqfsZrfU4MExmQ8Fl
         k1L8x5AYpPm7HZ6C8MeOpB2ZZjKXq9kVluQL7Psz3SMZyXEWou10YB4nXzKU38snmDFr
         nXsKlPBkW1G8gPvsLf4D/9+AerEoAxOON60258ULqA6eHHErf7HIwQ1xHUQG+T6Cy+Y2
         c4hksesEPNQkU0ApnoJbfWxQZZ0fiondaeCFEbZ/jIxSXRK9QSpBxCTaQA5PnbVe6kZw
         PRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233243; x=1730838043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPsMQe02LYzk6AvqbJXX4CMDFW9tZF0F106go5mNZqA=;
        b=eylJJ6NHO+DQg74g2O+ccvaJ3cvn19w5rF8kcDSSijx3CF+3nhlsrqzeey15K0Afx5
         kZmqE8vWEjD/vBZISf4gikMKlQinqwzUUxtfVjaUArQGLqhLl2B9Aamb6ZG+dDPBvhr5
         PB3BoN7ixTxEun/GgYlWVE7/PHafag95hma3QzDK0cg1U+DOEbWIuq55pmzA0JaRKAA1
         J4kUs30Bw2hbrgi7YQ4jBIxvJxsfqowY4f5uTyRwiFRt9g/z3zp71M8GEHvsMy4C0jyF
         7542UG+spSbKOlQOmfery1pOzTbBGsjAuGvHh80TH7rJIWtaegzCZxOUBPYarrlg+Kng
         14Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWdirCzDKL2bEkD4W+BNMDkWzewvZU0/OFt09Y9xNz0tjP/gyrARjF+ZNmkO6brLtIaaAC/w9EF+RyRQfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUlpFboiz55PEc5copwjyH1bCBXZPDsyEfEek3XJtYtv5xwVK
	guGvFqGjqVET4pSzOi0nIFICvQbt7kRPSOK1e3qjhcDueE7vjr1+rm8S4L0Ja7w=
X-Google-Smtp-Source: AGHT+IHs/aqZSL7TzZKT8I7dCZ/v2av91ER/O1QkY1vmriHGsVXlOik6zNWxN4zfTbxPZu6qWBjKLw==
X-Received: by 2002:a05:622a:1890:b0:460:a313:28bf with SMTP id d75a77b69052e-4613c00dc97mr182051421cf.23.1730233243008;
        Tue, 29 Oct 2024 13:20:43 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm45071796d6.54.2024.10.29.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:20:42 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v4 0/3] memory,x86,acpi: hotplug memory alignment advisement
Date: Tue, 29 Oct 2024 16:20:38 -0400
Message-ID: <20241029202041.25334-1-gourry@gourry.net>
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
 1) implement advise/query functions in driverse/base/memory.c to
    report/query architecture agnostic hotplug block alignment advice.
 2) update x86 memblock size logic to consider the hotplug advice
 3) add code in acpi/numa/srat.c to report CFMW alignment advice

The advisement interfaces are design to be called during arch_init
code prior to allocator and smp_init.  start_kernel will call these
through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
prior to mm_core_init and smp_init - so no need for atomics.

There's an attempt to signal callers to advise() that probe has already
occurred, but this is predicated on the notion that query actually
occurs (which presently only happens on x86 and acpi logic). This is
to assist debugging future users.

Once probe is called the first time, it will always return the same value.

Interfaces return -EBUSY and 0 respectively on systems without hotplug.

v4:
- nits and renames
- consolidate srat logic into existing iterator
- remove lock-in call from srat code

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (3):
  memory: implement memory_block_advise/probe_max_size
  x86: probe memory block size advisement value during mm init
  acpi,srat: give memory block size advice based on CFMWS alignment

 arch/x86/mm/init_64.c    | 16 +++++++++-----
 drivers/acpi/numa/srat.c | 19 ++++++++++++++--
 drivers/base/memory.c    | 48 ++++++++++++++++++++++++++++++++++++++++
 include/linux/memory.h   | 10 +++++++++
 4 files changed, 85 insertions(+), 8 deletions(-)

-- 
2.43.0



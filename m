Return-Path: <linux-kernel+bounces-306410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ADF963EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C465E1F263B2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA818C026;
	Thu, 29 Aug 2024 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgB+Lh0w"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2B15AD9E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920445; cv=none; b=SvKadM2idac2PW7YHmF1/+ovJPtFqgMcs3JIQLvAMiSROFUxh/QdeFad93ZH7Lq8MdLDDjVrSma5dRI8ttAlRQCWNcEe+kSWdOrwZe+MhfDTDSO1zrGksXZFKNhNDKWQdOJNxcmXv+UmMNmBzfMQOEkWgzIoDZQHDxdvZEG3NpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920445; c=relaxed/simple;
	bh=xnO6Vk/kr83JqD3+FgZr+ybVhaKA2iYaHmoGntXHCUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VIe3o/3zcePhyKvU/5hTtH11azNnPH3Qvle80Wl8wX6Ctx4ztQsiUir3dRdyh0fi7ItrMEx/gNFI6M82VNqON7Aq8ldFCEpW0IsUe6e1i3k3Gsit+iL//0JRBzb7QcOUBVPdupydPn3r5OZFUcb6Zujvh0SR41Hlv43maAEpDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgB+Lh0w; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6b44dd520ceso4180237b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724920442; x=1725525242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZH8C/6+CJkUjQ49MDGAsBNiI4/0rHnzfSpqasFYyAQ=;
        b=fgB+Lh0wZxyTq7CQJjJKH2ef1eDI+7bc1DEBAfL6qX5OlM00JUVg4g5c98AmkhuZWM
         Y2imeY6VFJmu06XkdRTbobKbVJvsBzyP9oxzC+vceO/oIapuCxp5PBTJdXWC+XDuhNSp
         Cot5T2oxdm7B011pOml4BDyIr95TkSn9RrjezQNEScruLEswEU0//BKVd6+j5X19RPq1
         ZCZQWZjNH1+V6ox3/TvvLFM9kda8V+LFsmp/N3w5+XH/1HtNacz/AZqTWABRVfNHbQ8q
         4V8/nJiIy1KFMrJJlRfURxaAki9pkryrddyjmXyQjixk7mFxyy6C3XIAYdKY2WM5NsOu
         tFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724920442; x=1725525242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZH8C/6+CJkUjQ49MDGAsBNiI4/0rHnzfSpqasFYyAQ=;
        b=Oc2gu9G9nRIAujA0H0ROAp2pS9Brlk+D9wOqv2QMq8GasxM0tCTSMvCJGPSI0WUYAd
         M2V1XxClH4M3ZSpqjgGtEPvDEU8ntNzTSWibC1Q/UaLCf3wvzIdhNwHEnsKjZPth8Svu
         pO90prK6Dhh4VjBZpqOj3JqQ2Xs6Oxmy26rqo8MDjGtghK374mkjFydXS3m7hG8z+JOb
         xJzKwrg5cA2Fpejl+WdzhLVGX0X2Dl/7xAzRtwLrEmRSu9cHCgzANw/FRMoebirzbTks
         XM10vMKwl+CLnSyP1maYxRaIGoPoyFvZCkZKGZabycXKT1pVKqXyNVduSA4mTE7Jj3jt
         m+YA==
X-Forwarded-Encrypted: i=1; AJvYcCUzXSaiYo+kq0PpMk9lnqmWEjmofley+FeEpDCqYCvjAr5fL9qZMl8LxYa+3rtunI/yQEN3Hn5pYZHm1VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9t7QdjJ+U/iUP8kTliQ24qMHI0Q+EShH2s3gm9gDKqe5kstsP
	rwBjkeylX7HQfkeyKA4Rwd+uq+mzGkGfMxWf6SAHWgbGAScOcRW5mccOKU8aC7mMEfstjY8HEWh
	tZH4Q8N+cTW9bEKUZ2HpeDG/EXr0=
X-Google-Smtp-Source: AGHT+IFIIJBgW3DmgTVJDmDJspPS4/uQxe5thXeBxoW8qdyKIaXW/D3gCaAHqkLJr6InbrRLPMRAFDNFKsLa8HWjQDk=
X-Received: by 2002:a05:690c:a96:b0:664:5957:f7a with SMTP id
 00721157ae682-6d27620cb1fmr23909667b3.15.1724920442069; Thu, 29 Aug 2024
 01:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
 <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CAOcK=CN3-v=dgMC9XTbh-h0zaD01uatOZKjvSF7ocofTCOGp7Q@mail.gmail.com>
 <CAOcK=CPi1TokgySF77X+zuQ10kxfsfCXekYVanPhF51+Ow1XRg@mail.gmail.com> <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
In-Reply-To: <CAOcK=CM4Poawy2AN3f6C2ooPdoT=dg4J9Bg1Fu=gsFjvkrBpQw@mail.gmail.com>
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 10:33:50 +0200
Message-ID: <CAOcK=COEd0njBPGhJ8idaLbaqvATr_zSB1O9dyzwi+fbU8GhqA@mail.gmail.com>
Subject: Re: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>
Content-Type: text/plain; charset="UTF-8"

With respect to my previous comment I tested to fix it myself (I am
not a kernel hacker and do not know anything about iommu etc.).

After applying the following change to the v6.11-rc5 it seems to fix my problem.
I can connect, disconnect and connect the dock and USB is working and
no DMAR error.




From 5f621c079f0f8bce9895ae05a9cd81b001a58089 Mon Sep 17 00:00:00 2001
From: Markus Rathgeb <maggu2810@gmail.com>
Date: Thu, 29 Aug 2024 09:37:17 +0200
Subject: [PATCH] fix: iommu/vt-d: Add helper to flush caches for context
 change

Signed-off-by: Markus Rathgeb <maggu2810@gmail.com>
---
 drivers/iommu/intel/iommu.c | 7 +++++--
 drivers/iommu/intel/iommu.h | 3 ++-
 drivers/iommu/intel/pasid.c | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9ff8b83c19a3..e92e06e604b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1944,6 +1944,7 @@ static void domain_context_clear_one(struct
device_domain_info *info, u8 bus, u8
 {
     struct intel_iommu *iommu = info->iommu;
     struct context_entry *context;
+    u16 did_old;

     spin_lock(&iommu->lock);
     context = iommu_context_addr(iommu, bus, devfn, 0);
@@ -1952,10 +1953,12 @@ static void domain_context_clear_one(struct
device_domain_info *info, u8 bus, u8
         return;
     }

+    did_old = context_domain_id(context);
+
     context_clear_entry(context);
     __iommu_flush_cache(iommu, context, sizeof(*context));
     spin_unlock(&iommu->lock);
-    intel_context_flush_present(info, context, true);
+    intel_context_flush_present(info, context, did_old, true);
 }

 static int domain_setup_first_level(struct intel_iommu *iommu,
@@ -4269,7 +4272,7 @@ static int context_flip_pri(struct
device_domain_info *info, bool enable)

     if (!ecap_coherent(iommu->ecap))
         clflush_cache_range(context, sizeof(*context));
-    intel_context_flush_present(info, context, true);
+    intel_context_flush_present(info, context,
context_domain_id(context), true);
     spin_unlock(&iommu->lock);

     return 0;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b67c14da1240..0a4ce98faa60 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -988,7 +988,7 @@ static inline int context_domain_id(struct context_entry *c)
     return((c->hi >> 8) & 0xffff);
 }

-static inline void context_clear_entry(struct context_entry *context)
+static inline void     context_clear_entry(struct context_entry *context)
 {
     context->lo = 0;
     context->hi = 0;
@@ -1154,6 +1154,7 @@ void cache_tag_flush_range_np(struct dmar_domain
*domain, unsigned long start,

 void intel_context_flush_present(struct device_domain_info *info,
                  struct context_entry *context,
+                 u16 did,
                  bool affect_domains);

 #ifdef CONFIG_INTEL_IOMMU_SVM
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5792c817cefa..cb4bbb45ac2a 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -694,7 +694,7 @@ static void device_pasid_table_teardown(struct
device *dev, u8 bus, u8 devfn)
     context_clear_entry(context);
     __iommu_flush_cache(iommu, context, sizeof(*context));
     spin_unlock(&iommu->lock);
-    intel_context_flush_present(info, context, false);
+    intel_context_flush_present(info, context,
context_domain_id(context), false);
 }

 static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias,
void *data)
@@ -885,10 +885,10 @@ static void __context_flush_dev_iotlb(struct
device_domain_info *info)
  */
 void intel_context_flush_present(struct device_domain_info *info,
                  struct context_entry *context,
+                 u16 did,
                  bool flush_domains)
 {
     struct intel_iommu *iommu = info->iommu;
-    u16 did = context_domain_id(context);
     struct pasid_entry *pte;
     int i;

-- 
2.46.0


Return-Path: <linux-kernel+bounces-306807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECFB9643E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6671F23192
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB841946DF;
	Thu, 29 Aug 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2duJyNK"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39120191F82
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933113; cv=none; b=MMoY1/qwDGSU1iMuriNHpcsPv2GrNSVweOAQF8qdNezOBhQwsSBL+RsprzpBLUeRud4ApcVWx+sa5whC8XUtKVPDHCx8Tb0P4Cty14kpmL75Yi6uvmif736C/Mpe1sP/kmsl7FGYAgbhOx7NYpjyIMlWX2kE+g1L7iNaOZ+sEiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933113; c=relaxed/simple;
	bh=nBoN1yavaittbk+d7DraufNBYnZMycnA9WfuTETAQTE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dt+uu1lMesXKeDSoX5/7mnm7wU1B71MnWSw6ZYW6S5BhRMUxLOL1JiZRusM9hfA9GjciKtU8bbo1YuhRZmqszCzq59voRq+rAU2A8QG4Pnxx7cp8HmBW6XDSP9vhX3KCL0qHzhJtihTGM9VSTenfs6sPx0MpqcqOL2Np9W0Huss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sachinparekh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2duJyNK; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sachinparekh.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb1669so932653276.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724933111; x=1725537911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0mys/2tQCcs3OTEBY7NrCgOPWFXZx1s1qQWQxRmqLc=;
        b=i2duJyNKlHbR6KfftaGr+4v9eiegyxy3iCCRt/BppemE1yuyn3LMdFEDbL4bLTvRIA
         Id133M30G4Ce7/YZK7hHED7mRQ90YsjMaWDEAYWt+e0Dcoeo3JV0+LExIkNQ/f487rnM
         eL0m+GxDFhrTsBYNa2w1WBpzxWi0uN4yZN9Kf72Yi4b9M7qjp8sGDJVjcflafTpdmSOi
         lK1Q+a5uqtLvRZ4ltX5GJP9kSPfwmO0jj7gPtUeD+se9m3JAtk3ZCqWRLpGIO6jg7yUX
         iWbq1PzmPjPCGKvk8jFAoBux7S4gUCIPElB+T+yx0zDLunzrwxIlcW3qZaRQzyeDeOUU
         ZeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724933111; x=1725537911;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L0mys/2tQCcs3OTEBY7NrCgOPWFXZx1s1qQWQxRmqLc=;
        b=Dfb3N6/N4uTXBPhkbk65f/HgTbM73+IZpixy+y4efy9hJNfEeXZzaqZaFPJjnxYNPX
         enQAQ6vb0cS4nvOxaOQ0IIoVMaULGKkTQhPAcIEsaKLmf/MHm2fdbCxWImyakcyPGd4U
         JQvVVjQZW7LYIy+2pwhMxxvor2JlKo0Z1J016NxMzk0UjO9X7tjn+QZ55B6VOBV6G9fw
         BnMEn7mVywvZN5J+KXtwELQDP7AJaEGvEmYcYTcIbFpwRVivGBKuCuSpoIovo8cvoqkw
         G270Nop8lc2a9DczNIeMDODPOkgb33P0ARJfE7zObeZKkiILBNYCQzUlPLx7/D8errot
         xnhA==
X-Forwarded-Encrypted: i=1; AJvYcCWdh67AwIKF9KNA35g/NwaWyGgpvVCS08a/CIMzLdZUcgdd1C4L4ewuyibOtT8cIWRAfZtqsoyekpvDnds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo/cyd4MeV+oa8Ar7MIirf3GQtZptHWAa/SAxvs/k3gKQkhWqR
	yN8BG6h7UkgKLhWqVv9RZHNcU4KcVE4NxXtBuGJ40KFwy9mXW/tFo/GtLA+yazEXaYBkyQTAEM/
	LYixQvDgdd+OtxSS12bVg0Rr/2A==
X-Google-Smtp-Source: AGHT+IEIajcciXNXA9eAeI82KfBygYUO7hs4LPpXBbMDBnoip8dz1YA1Le2XY66UJM87v8KnyRRyKfiIMLUeWk2hEcQ=
X-Received: from sachinparekh.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:596d])
 (user=sachinparekh job=sendgmr) by 2002:a25:29c4:0:b0:e0b:cce3:45c7 with SMTP
 id 3f1490d57ef6-e1a5ae0d8e5mr3845276.9.1724933111089; Thu, 29 Aug 2024
 05:05:11 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:05:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240829120504.2976612-1-sachinparekh@google.com>
Subject: [RFC PATCH] driver core: platform: Call iommu_release_device in dma_cleanup
From: Sachin Parekh <sachinparekh@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, will@kernel.org, 
	robin.murphy@arm.com
Cc: sachinparekh@google.com, lokeshvutla@google.com, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Installing a kernel module that has an iommu node in its
device tree increments corresponding iommu kernel module
reference count during driver_register.
Removing the same kernel module doesn't decrement the
iommu reference count resulting in error while
removing the iommu kernel module

    $ modprobe arm-smmu-v3
    $ modprobe test_module
    $ modprobe -r test_module
    $ modprobe -r arm-smmu-v3
    modprobe: can't unload module arm_smmu_v3: Resource temporarily unavailable

Cause:
    platform_driver_register
        ...
        -> platform_dma_configure
            ...
            -> iommu_probe_device (Increments reference count)

    platform_driver_unregister
        ...
        -> platform_dma_cleanup
            ...
            -> No corresponding iommu_release_device call

Fix:
    Call iommu_release_device in platform_dma_cleanup to remove the
    iommu from the corresponding kernel module

Signed-off-by: Sachin Parekh <sachinparekh@google.com>
---
 drivers/base/platform.c | 3 +++
 drivers/iommu/iommu.c   | 3 +--
 include/linux/iommu.h   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4c3ee6521ba5..c8125325a5e9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1467,6 +1467,9 @@ static void platform_dma_cleanup(struct device *dev)
 
 	if (!drv->driver_managed_dma)
 		iommu_device_unuse_default_domain(dev);
+
+	if (dev_of_node(dev))
+		iommu_release_device(dev);
 }
 
 static const struct dev_pm_ops platform_dev_pm_ops = {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..495f548fd4b9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -92,7 +92,6 @@ static const char * const iommu_group_resv_type_string[] = {
 
 static int iommu_bus_notifier(struct notifier_block *nb,
 			      unsigned long action, void *data);
-static void iommu_release_device(struct device *dev);
 static struct iommu_domain *
 __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type);
 static int __iommu_attach_device(struct iommu_domain *domain,
@@ -663,7 +662,7 @@ static void __iommu_group_remove_device(struct device *dev)
 	iommu_group_put(group);
 }
 
-static void iommu_release_device(struct device *dev)
+void iommu_release_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04cbdae0052e..2f9cb7d9dadf 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1049,6 +1049,7 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
 
 extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
+void iommu_release_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
-- 
2.46.0.295.g3b9ea8a38a-goog



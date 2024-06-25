Return-Path: <linux-kernel+bounces-228985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B4916965
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A13E1F2198A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0A0161915;
	Tue, 25 Jun 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4EU/FMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4A13BC2F;
	Tue, 25 Jun 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323477; cv=none; b=HVJO7PxBevqV7YJnTBSQjM6pBmC4hI5TTTTdkIb9lDwBJs9W3YO5fprTOzFV52FLMXoUVN1TyA80QdSLlWqJpv/Fpjbb75jw7GD6gsGWSb7/81N6v8BnpWJBsveI/6EphIcu5xi3MhmQ6jblTwhaZE/LcFgHH7Kao9L9KMrBnps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323477; c=relaxed/simple;
	bh=q/n3/6op+yhTcPT/pheshsDsolvSjuhhh2ShF391PQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fq72ONzKZzpaORiFe2Enaz18LvjJBjF4p6lfIYdAZuw5zi1ZRYnIEUSXrMjAVY7Pd6C+dVI5Ybq9BwPfWDWFr4YnFP2fgbIyptcDxJZ9r3dr7BGiLD9a5WOrvvK+RnivOdfUDv0gjh/cp2D8PelYxsiEfMnK3u1NNuXmQXm92mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4EU/FMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E2E4C32781;
	Tue, 25 Jun 2024 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323476;
	bh=q/n3/6op+yhTcPT/pheshsDsolvSjuhhh2ShF391PQw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Z4EU/FMGm/kMmEwQ5i4CvfRb+9uwMbxo1nb1IEWkXnGzk4znQCoE+fMpxM+r4HafW
	 Zhk2LO43ZZWYcar2pBJr0Ex062UfCPPSqVpT0zcVzt3cPloT+VSouOH8CjC4cjt+Zg
	 L9Bg5wh/+skwzJts/RjwgsofNIm5bDHQQDb8AgHFq/dqmOzXxtgrEl91c9FXi0DFOo
	 FdrYpOMZz94u8yCi5RjnCwJNL5z9Yn9G5hnl8y9DiFED6oDtFN7w61dBjy9quO65sA
	 Sbrb2WpUMTQBZLUXe12kksvMv+R+DPJJ5MpyzT3+WCdUOznbvwB7pIkuDvQHD1g53L
	 GvnHO10AbyOBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4BEC2BBCA;
	Tue, 25 Jun 2024 13:51:16 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 25 Jun 2024 15:49:31 +0200
Subject: [PATCH] iommu/intel: Enable pci capabilities before assigning
 cache tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-jag-ats_cache_tag_fix-v1-1-67f956e3fa93@samsung.com>
X-B4-Tracking: v=1; b=H4sIAOrKemYC/x2MQQqAIBAAvxJ7TjCxjL4SIZuuth0qNCKI/p50n
 IGZBzIlpgxD9UCiizPvW4GmrsAtuEUS7AuDkkrLTrVixSjwzNahW8ieGG3gW3ijzTzL0HrdQ2m
 PREX/33F63w9DoIeeZwAAAA==
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2524;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=ZAV4AO+ksfC2IKBwiprCzqazgh+/Mze5UH1MvGeac1M=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZ6y1KZp8Fnhxly/H95r0cXWxFevDnL64nWk
 8KgwIAI87YOK4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmestSAAoJELqXzVK3
 lkFPgR4L/1Wqva641Q9H+7bm7Eebei8C9OZ7UwJ37Q7XQBrHjd7Fr4SXIeFPpIEoCSBqjWloTs8
 p53C4mZYNu4WTdd6u6OOeCnkmY3xZm8JBAUxa9QTzI2ufcTcD0I0E/h39rquDStpsb3S9G7q+eS
 0x3L1V8SIMxEnTqZgMPsr1VhveV9sW1+zRm09hR5o1qePtHLrtfbllCn1cLWVtr2NvZlunOAZpZ
 sFFcEdOJuFjpMqEX3+oelrAHGeKHIZ2Ff1V0AMl23oTUseGwlGPoQUspVDlPY3gq4sEuZIGXdm+
 VSPR2bvQYyBYoqrFDUkWSLuIs7vwwmVMkqbKkesGpQNvd7ZqenKNhshXZh/0cj1tOLZScMBYXnN
 R1FxdnQGrRiQ8mIrNeeqXAYY95nD7BrcHIbmmGhTvmm7rILpxm5SS1y6OPVxXnApPFFqZvuxdZT
 UQ5BX7DppjXtrAOPwVBdm/jS8MWWVSUJcmcRQb7d2lo4QJTozAHlofbFDX7Te8uTHdozi7ABxm5
 Z4=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Enable the pci capabilities by calling iommu_enable_pci_caps before we
assign a cache tag. The cache_tag_assign_domain call in
dmar_domain_attach_device uses the device_domain_info->ats_enabled
element to decide on the cache_tag_type value. Therefore ats_enabled
needs to be evaluated before the call to the tag cache assignment.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
The "what" and "why" are included in the commit message.

Tried to place cache_tag_assign_domain before the early return in
"if(dev_is_real_dma_subdevice(dev))". This means that the call to
iommu_enable_pci_caps landed before the setup functions [1] which is not
an issue as they seem to be orthogonal (I would like to be proven wrong
here).

An alternative to this patch would be to use a different way of checking
if the device is ATS enabled in __cache_tag_assign_domain.

Comments greatly appreciated

Best

joel

[1] setup functions: domain_context_mapping,
    intel_pasid_setup_pass_through, domain_setup_first_level and
    intel_pasid_setup_second_level.
---
 drivers/iommu/intel/iommu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e9811bf2a4e..ecd79741e67c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2114,17 +2114,20 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		return ret;
 
-	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
-	if (ret) {
-		domain_detach_iommu(domain, iommu);
-		return ret;
-	}
-
 	info->domain = domain;
 	spin_lock_irqsave(&domain->lock, flags);
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&domain->lock, flags);
 
+	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
+		iommu_enable_pci_caps(info);
+
+	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
+	if (ret) {
+		domain_detach_iommu(domain, iommu);
+		return ret;
+	}
+
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
@@ -2142,9 +2145,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		return ret;
 	}
 
-	if (sm_supported(info->iommu) || !domain_type_is_si(info->domain))
-		iommu_enable_pci_caps(info);
-
 	return 0;
 }
 

---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240625-jag-ats_cache_tag_fix-d747bb0f5d48

Best regards,
-- 
Joel Granados <j.granados@samsung.com>




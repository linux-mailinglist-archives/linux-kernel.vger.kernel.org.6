Return-Path: <linux-kernel+bounces-363057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259B99BD67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A761F21C87
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6B1BC2A;
	Mon, 14 Oct 2024 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGTNo9f0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8141798F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728870150; cv=none; b=DpYFosj7g/lO3/qZea7cADnr4k2qYf8o3FZA0HEw29s+6XNk/C+R4yWIWmv3ZzmWXqtfu0tgA43jRR82T77BY+GdXQbn06lX0XBw+XrNZHztzWGF8h41t4Tok1Oc64w+25isCEYVs5TGdhpWM+mFn7iq4kNqCATAY1U59NHo3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728870150; c=relaxed/simple;
	bh=lwHQc1vh94XFawcnVg4iOJEGxATVVe/SeDaqWrj2Jmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swC8aLOG+EOfxbpjH/o0wkNmkUUXZwr9taSnY/igdhO45Oatk/CV85CPvrg5sc6IH6pz9Dq8L2IrrRBjHGesmvQxPu1gqzKwuSaqS3NEfTlnnXL3gvtomnSbbd6oC7kTF5kubKhf83a2VqHPtfTkNgewTfigmPVTweqS2ZGf5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGTNo9f0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728870148; x=1760406148;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lwHQc1vh94XFawcnVg4iOJEGxATVVe/SeDaqWrj2Jmo=;
  b=GGTNo9f0N/OTZSGghnFDZVuIL8m9xi4AiUrCv+3TINhfpnKzv3eJ3mzW
   6zDzU7YMFZXc+POlm3aQkVI9AOv0JvKmWL5oP4VPZAZ3E/htPKRV1noXl
   sZ4AQoAzFnArswH0YTpPqs4TQXYwxv3imIQvZU2w5n9rwGJAVeBIXYyQR
   LZjjyKkDRzdBHxonHaJGAI1CPAmKAK8olZMsq3QALj961vd7H5SlPSPzW
   NKunILSqa+f4loI2bkeAjBDJIT6OICO8PmaupAZyCk8q46iSPY/2B0LXc
   F8bOpmzVvx5oGS838yC04cT6lqruGHm4bHa+4qR2a9s38Kf1cJiUtkLVV
   Q==;
X-CSE-ConnectionGUID: d0rXk+EATkyRsCRTInVs/A==
X-CSE-MsgGUID: zTIrER7WQ1aOKvkz9VAOMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28389756"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="28389756"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:42:28 -0700
X-CSE-ConnectionGUID: dT1RchyFQImmVcX4Lci0yQ==
X-CSE-MsgGUID: d2idVKFlRzS1FrG+yBr3jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77867581"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 13 Oct 2024 18:42:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] [PULL REQUEST] iommu/vt-d: Fixes for v6.12-rc
Date: Mon, 14 Oct 2024 09:37:43 +0800
Message-ID: <20241014013744.102197-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fix has been queued for v6.12-rc:

 - Fix incorrect pci_for_each_dma_alias() for non-PCI devices

It fixes boot failure issues on some client platforms. Please consider
it for v6.12-rc.

Best regards,
baolu

Lu Baolu (1):
  iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI devices

 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.43.0



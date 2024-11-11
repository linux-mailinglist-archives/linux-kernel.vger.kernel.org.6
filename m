Return-Path: <linux-kernel+bounces-404590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73159C45A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D3FB31712
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B91AB6C2;
	Mon, 11 Nov 2024 18:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkngprD+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45F4C66;
	Mon, 11 Nov 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351301; cv=none; b=JtZB1HD/hChGPKCU3dgX+EOpV/9I77EXYEcRVV0YgiueU1pKeWMLj3D2R17hIZ4EsT36htE9iDNGkLg6vcO8e+Ip8ho6dHUA+0JNEBftpWqK/OLZDz7eLcDiaOZEtjtdoqddtGTO0cIvujNXqElnDgz8AGy48+zhyt9YhBqg/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351301; c=relaxed/simple;
	bh=Jtb5ohnHHs1chKS/YEL9y+nasInAf+elZ0NPeyHGDJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzF1+FQPNs5BlOST7cPPbGxvm07oP8lwldeaMzB4sS0fMHWSoenbjsPkny7GFDybxHxCjQwllVJqTbW54LhoqeAO1hAa6k2JlMtlrk+JpSHeqmkaSJvo00mplh8Gwm6lkbk/9rcPjmktxJLMI9oNuYdMUyZTSnvpjVFEL8TjmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkngprD+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731351300; x=1762887300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jtb5ohnHHs1chKS/YEL9y+nasInAf+elZ0NPeyHGDJY=;
  b=bkngprD+ApbbhFwqSoSbiIFRpp+cKUO5+uCmTTQdwjQuHIlTj9ohdMux
   JMqvN+1gZPaxwkpZ8v6jplr4xDi/5825Xnar55RkDfIAEmN6AEmytn7ms
   65lp17PT385+9ZkewT6ZL0ah7wWCzRQmFXqvRWHljBbk5bavLmVrHdWcQ
   NUw4GQBVH3ymegiayG0jLfrgA8Qgw0ct7uUwwLNd9v5bWkDwUs+/3eSAk
   g5R9cS6h4yVs+c1k5xgOXrepmym3EL1eUFfyJ8qxeL8LqhILvLCxfk6ti
   clLTRxrfe5cwdyPSmUPjBRw0x9gMuEqAuSRQ58fvRwlEaam6q5xm2ZLnZ
   Q==;
X-CSE-ConnectionGUID: E/TFJ/BGRuaFM4vPmGAn5Q==
X-CSE-MsgGUID: OrzNXG8TRLCB7uU80cFl7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30936240"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30936240"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:55:00 -0800
X-CSE-ConnectionGUID: uHCfsxUxQo2OaJe63cgs6A==
X-CSE-MsgGUID: skWlJNMkRdiuNFq/Mps78A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="87155704"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmviesa008.fm.intel.com with ESMTP; 11 Nov 2024 10:54:59 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Update ISHTP ECLITE maintainer entry
Date: Mon, 11 Nov 2024 10:54:56 -0800
Message-ID: <20241111185456.331071-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sumesh K Naduvalath doesn't work for Intel anymore. Adding myself as
maintainer as this is related to Intel Integrated Sensor Hub, which I
maintain.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21fdaa19229a..9440edcc0774 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11528,7 +11528,7 @@ F:	Documentation/admin-guide/media/ipu6-isys.rst
 F:	drivers/media/pci/intel/ipu6/
 
 INTEL ISHTP ECLITE DRIVER
-M:	Sumesh K Naduvalath <sumesh.k.naduvalath@intel.com>
+M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
 F:	drivers/platform/x86/intel/ishtp_eclite.c
-- 
2.45.0



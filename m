Return-Path: <linux-kernel+bounces-192941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E28D249F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31738B283E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 19:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0601917557C;
	Tue, 28 May 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbw2Fatb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D8172BD1;
	Tue, 28 May 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924598; cv=none; b=drEgmvdtARLv+NX7oKjF3Njl/HBibLix4yszpalF2d1anr6c/ekcUcr22xH8s9Ln0xZcZtWPjlAjP33DH25z3GNdSPWSJ4FJlhaelSB5fWMfbr2wpO9w3AmzNdmfGEHShypT/OE7ctd4DBl5K8ehj0L6OhCOlJix3BxwQ8K6l4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924598; c=relaxed/simple;
	bh=yrLkMNL0vjGtPcpJMxCjfDCJZd9eHDtZHTZMrLNb4lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8SDJxEYF1D1v3dnySZM/kIysBn12rx6Zni1vGKVDuyj9n0g1Ydcw3YfnZzuGMVTFbwfq/a8Jb5S82q1kPQViQGIWa7/xWZ1bUPA+gpb7bnmr7sVkYpih5WTGW2+1ByR1i4hMskYfStugD8+Z3ESIb0Qvf/JY/B9qH/uQVlSyq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbw2Fatb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716924597; x=1748460597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yrLkMNL0vjGtPcpJMxCjfDCJZd9eHDtZHTZMrLNb4lI=;
  b=nbw2FatbU/qrW/MAO6WpvSE6M6yQiVCCLuyxaCVQpTYV205BnEqDqL1Y
   n9FlVfrfU4CZKJDiqUc8M2xkMVqzggarJQBYsEB2RGsV8VHDG1IubT4Fw
   H2V4u3vaUvUafy60IfDRHvNY6TcQOzYitM0aGhQZQZ07AZXmI6ppvmy4J
   0P3n7wjUjjljlDRnIHJ/zM5neTphcFDQU0331WB5HdzntYV0NEeNzKymn
   zmP6MFS3mt7t0Y/G+cbtYRRjf5JGOD6qe8oBxy1OVgu4osnKPyGRZPE/S
   jlD/OjmIo0LfnXAoRitfdGGjjhsX8xrRDans61utGkt3wwrh2DroUqKMz
   g==;
X-CSE-ConnectionGUID: SIT48geFRYiCEC2GoPFejA==
X-CSE-MsgGUID: /pe+cS9SREOGvc0QbVpPBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24711846"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="24711846"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 12:29:56 -0700
X-CSE-ConnectionGUID: oPjQrdN/TZOsComV4T9Q5g==
X-CSE-MsgGUID: dw+3EAeBTcyrDD4eXkFDRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="35246723"
Received: from unknown (HELO pbossart-mobl6.lan) ([10.125.110.237])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 12:29:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	rafael@kernel.org,
	vkoul@kernel.org,
	andriy.shevchenko@linux.intel.com,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Rander Wang <rander.wang@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] ALSA: hda: intel-sdw-acpi: use acpi_get_local_u64_address()
Date: Tue, 28 May 2024 14:29:35 -0500
Message-ID: <20240528192936.16180-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
References: <20240528192936.16180-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now we have a helper so there's no need to open-code.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/hda/intel-sdw-acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/hda/intel-sdw-acpi.c b/sound/hda/intel-sdw-acpi.c
index d7417a40392b..f3b2a610df23 100644
--- a/sound/hda/intel-sdw-acpi.c
+++ b/sound/hda/intel-sdw-acpi.c
@@ -125,11 +125,11 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
 				     void *cdata, void **return_value)
 {
 	struct sdw_intel_acpi_info *info = cdata;
-	acpi_status status;
 	u64 adr;
+	int ret;
 
-	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
-	if (ACPI_FAILURE(status))
+	ret = acpi_get_local_u64_address(handle, &adr);
+	if (ret < 0)
 		return AE_OK; /* keep going */
 
 	if (!acpi_fetch_acpi_dev(handle)) {
-- 
2.43.0



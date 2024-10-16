Return-Path: <linux-kernel+bounces-367828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AB29A0745
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC021C26473
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7D62101A5;
	Wed, 16 Oct 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0ErMiFu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB10210195;
	Wed, 16 Oct 2024 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074252; cv=none; b=PePhIw+zc/nZvpD7QfFg2SL8m+az0B3UEAx7FuQq1+ROYfYACgBPbxDTFspTRpZY0PuFnvJEHhu6KJjr+dNVVIQuLsXYAeSSY3hXJpJ8zqOpyaQLE56fmPfercvB8b7vRH3qUjzfRNrQEtXc+kTCtlfko/HV7UWakG60PMsOVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074252; c=relaxed/simple;
	bh=MR7mGv44uH93XVt6JOmyrHGxIEfJa5wPWj2sSiGQABg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N//cDr+aYm/i93QdwX7OkGvLFf+Eboct2f6ypzc7yrVZ2lMfxX9Sb8moe0trYE/jykRmnPeoaX8Y8GBYFVIy/qIktzlQW062CoukbpJoEF6Hwe1+Ma+VreScclS8Y7rQP/c6qm/qiLv+imxD2+8pPY87pKwMK9wWsNP25wH5IM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0ErMiFu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074252; x=1760610252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MR7mGv44uH93XVt6JOmyrHGxIEfJa5wPWj2sSiGQABg=;
  b=b0ErMiFuiNM4DGHp7Mc0Eurs9pu0YhIcq/1hjTblFZEgTp1mMy3c5+F0
   hxKVczaa0DkmyR4ye/z+MIbQRUgmCzg23HG5c5mrP/rF2+0OasUjjoAuh
   KDgM+em2jjpxvTyI2F+i9tlMF3tgMgu1Yd6lcPM7hKSVSi2Q/Wboav8Cm
   S2nplCOiFjzhMy46n8eUX/6qH0C7Viw2h2TSgvDIgpXOo/9rilHTDbIBn
   I86qJFjk7Q3vMtpgtH/RZUwjE8T3i6qinJcQwJSXNw4r3lwSJpNP/5rdf
   rhkcFxea30gT74zW8uIh0hi9nvm4OjBlOstgO9ZNSiFstqYEgVRDG9TVL
   g==;
X-CSE-ConnectionGUID: GSGK2w+hQay7H4xSYcijiA==
X-CSE-MsgGUID: 0FdWeCAoRpCiC9u3/1acDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985918"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985918"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:11 -0700
X-CSE-ConnectionGUID: xv0FipJ9RsSp5N2Zqu+ZMA==
X-CSE-MsgGUID: iul1Kt0wS92VZD1SSsSb5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82960977"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 07/11] ASoC: soc-acpi: introduce new 'machine check' callback
Date: Wed, 16 Oct 2024 18:23:29 +0800
Message-ID: <20241016102333.294448-8-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The existing machine_quirk() returns a pointer to a soc_acpi_mach
structure.
For SoundWire/SDCA support, we need a slightly different
functionality where a quirk function either validates or NACKs an
initial selection, based on additional firmware/DMI information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/sound/soc-acpi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index ac7f9e791ee1..72e371a21767 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -185,6 +185,10 @@ struct snd_soc_acpi_link_adr {
  * ACPI ID alone is not sufficient, wrong or misleading
  * @quirk_data: data used to uniquely identify a machine, usually a list of
  * audio codecs whose presence if checked with ACPI
+ * @machine_check: pointer to quirk function. The functionality is similar to
+ * the use of @machine_quirk, except that the return value is a boolean: the intent
+ * is to skip a machine if the additional hardware/firmware verification invalidates
+ * the initial selection in the snd_soc_acpi_mach table.
  * @pdata: intended for platform data or machine specific-ops. This structure
  *  is not constant since this field may be updated at run-time
  * @sof_tplg_filename: Sound Open Firmware topology file name, if enabled
@@ -203,6 +207,7 @@ struct snd_soc_acpi_mach {
 	const char *board;
 	struct snd_soc_acpi_mach * (*machine_quirk)(void *arg);
 	const void *quirk_data;
+	bool (*machine_check)(void *arg);
 	void *pdata;
 	struct snd_soc_acpi_mach_params mach_params;
 	const char *sof_tplg_filename;
-- 
2.43.0



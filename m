Return-Path: <linux-kernel+bounces-528813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E4A41CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DF47A9EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434826561B;
	Mon, 24 Feb 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI9DWGyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAEF265610;
	Mon, 24 Feb 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395892; cv=none; b=WaUz4aktVYitYQqaXo23BgyqWV+52XeubEfaUd0BWN23PnhyRsQoipiyUbSkKY/wEm7IiA/LExurwxLPHUREeAuDKpwty0ctGZilZ8jfHvmFfbLwiHR814o6drYUWgIRV4D4QmAqcO2xtFFRti/VTMupR+fuYTC7Xx4kJwwW2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395892; c=relaxed/simple;
	bh=pS9emY4dKEigrNCph4FoVAg9QGZdXk+25dmHEZ7zKJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7KvaN/wNF3LC0oI9epSPMErb9ri/K09q2J7ywMsP9Wt0lrEHgVxx75jbMJ2M6vNS4HMDdFhOQr0OgICanTwtW1z1SMgRm/zDbGeTlodevoASCqNSjulPS2BObGnDyZU3CosGipFOXiRgAgKGUVCmlQIVsfj4TVXc7pCHi8Ha0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YI9DWGyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5726CC4CEE6;
	Mon, 24 Feb 2025 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395892;
	bh=pS9emY4dKEigrNCph4FoVAg9QGZdXk+25dmHEZ7zKJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YI9DWGyykVTl2KtaS/NA0HR4zFKngZg+hIVivl3E/3WFV53J+hPEKbOLIz1zq7Jc2
	 Anp0P/5jKcuMx2ZTumDSxQbJad881DuMLYfnzdbqsD6Jfe/7+PvXKqjGIN1xSwTWtL
	 Mb/eJ4GcpQBVi+/QvBiWtoH/QCwEZCOqD5olNXnH5FvIUJoDLaKYpFY1WtA1IjWbXJ
	 YI8KhjBUaQA2gwq79Vn+6epqlOJET231yk9MJ7yCOUB2feREatxJtWKGj3VdRc7S6r
	 mF5Kn1j8yBpt9c1iusWvNZifxIRt8X9TNHgGcIBfPj5UwQWOUUKnpxowBCQpXPQ0bA
	 nIQa6bmlcfdmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	ckeepax@opensource.cirrus.com,
	Vijendar.Mukunda@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 04/28] ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S14
Date: Mon, 24 Feb 2025 06:17:35 -0500
Message-Id: <20250224111759.2213772-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 0843449708085c4fb45a3c325c2fbced556f6abf ]

Asus laptops with sound PCI subsystem ID 1043:1e13 have the DMICs
connected to the host instead of the CS42L43 so need the
SOC_SDW_CODEC_MIC quirk.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250204053943.93596-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 8f2416b73dc43..f5b0e809ae066 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -687,6 +687,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 };
 
 static const struct snd_pci_quirk sof_sdw_ssid_quirk_table[] = {
+	SND_PCI_QUIRK(0x1043, 0x1e13, "ASUS Zenbook S14", SOC_SDW_CODEC_MIC),
 	{}
 };
 
-- 
2.39.5



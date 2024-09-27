Return-Path: <linux-kernel+bounces-341446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D999A988038
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7401F23EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A31898E1;
	Fri, 27 Sep 2024 08:23:21 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DB1741EF;
	Fri, 27 Sep 2024 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425401; cv=none; b=KK3KEcGSMGPdqZdyx9GFar1qWDf8yyu9lNl1lforKY2+mheSlqEPCI72T+0ixLTGHSo/eo3lusBzigLG4mhH0BKIG8GAWShhbnuIqf+sf8npOA0rqMmLlYhlADJ/D23Jv0O8SSFCFWDVg9xfgwAYzO5NcCtBUfia9CkgKg/pW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425401; c=relaxed/simple;
	bh=E9/0H/vSBWXLEeUtFMFK08Pxw6HXo9GeLL06pi1jcEc=;
	h=From:To:Subject:Date:Message-Id; b=i/gEnVBi3X8OkI1byRYsvtPY0a5xl2mw/2fZyqjuaHCOtob5/NtoWClwHm5i/4mN4K9enI6tLnT0s0wEXMLPx4LusWyhwcjoIUBQA00HrzXYD73R+Ufm2y1n6y/szEDn+t3ZAlXtbyH1MOyzXxNqVWfCmQfGN+JgWPzpKPQDBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 82269201A43;
	Fri, 27 Sep 2024 10:23:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4764F201A16;
	Fri, 27 Sep 2024 10:23:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 92B6E183DC02;
	Fri, 27 Sep 2024 16:23:10 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ASoC: fsl_micfil: fix and improvement
Date: Fri, 27 Sep 2024 16:00:28 +0800
Message-Id: <1727424031-19551-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fix the usage of regmap_write_bits().
Move mclk clock enablement to late stage.
Enable the micfil error interrupt.

Shengjiu Wang (3):
  ASoC: fsl_micfil: fix regmap_write_bits usage
  ASoC: fsl_micfil: Add mclk enable flag
  ASoC: fsl_micfil: Enable micfil error interrupt

 sound/soc/fsl/fsl_micfil.c | 49 ++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 10 deletions(-)

-- 
2.34.1



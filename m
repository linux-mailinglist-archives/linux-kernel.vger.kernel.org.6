Return-Path: <linux-kernel+bounces-354586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB92C993FE0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0690B1C23D77
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683741E22F6;
	Tue,  8 Oct 2024 06:51:36 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4051E22E6;
	Tue,  8 Oct 2024 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370296; cv=none; b=N3n52eNXspNEUh4Ahg5Xl5OkbPNKsVfzlB8/xq6DlKSB11GWSnpbHw/0hVEi7YAK3e9Zs0wYAhatZghiQj6x+GMOeOEZ9pTgxDiC8bsYyQZ71Q2ijMzycdggg2XFE1XuwUHKSrpPCR200BQaTGJAqiI4B6unM69VIUMDFs+h+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370296; c=relaxed/simple;
	bh=c8dAsjEgz+rM/JfDG0uTZuE9KWHF+zylVqyXZSipnds=;
	h=From:To:Subject:Date:Message-Id; b=rLaWAo0Ss4n68uXw6ZJnuQfR8Ss4nB5k6OekYfJa42odnGe0nwI2j5EZbyb33xS6td7VQmaArq/EwC1mMo4N1Cn5gL3aljz2hjfarxpf3qtWPsaLKvUbDjmXnG1sies1l0lX2QrxJVxCXVdYhRciPuos3jzflAMjvMQBRFcbahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 122451A245B;
	Tue,  8 Oct 2024 08:51:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD7DF1A2466;
	Tue,  8 Oct 2024 08:51:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2EF8E183B720;
	Tue,  8 Oct 2024 14:51:02 +0800 (+08)
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
Subject: [PATCH 0/2] ASoC: fsl_xcvr: enable some interrupts
Date: Tue,  8 Oct 2024 14:27:51 +0800
Message-Id: <1728368873-31379-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Enable interrupt of cmdc status update and the interrupts for
wrong preamble received.

Shengjiu Wang (2):
  ASoC: fsl_xcvr: enable interrupt of cmdc status update
  ASoC: fsl_xcvr: reset RX dpath after wrong preamble

 sound/soc/fsl/fsl_xcvr.c | 94 ++++++++++++++++++++++++++++++++++------
 sound/soc/fsl/fsl_xcvr.h |  5 +++
 2 files changed, 86 insertions(+), 13 deletions(-)

-- 
2.34.1



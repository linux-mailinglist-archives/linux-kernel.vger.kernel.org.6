Return-Path: <linux-kernel+bounces-211036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42021904C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E41B24154
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0139316D31E;
	Wed, 12 Jun 2024 07:07:54 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539416C869;
	Wed, 12 Jun 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176073; cv=none; b=WhlycAQBDcZ2v2E8jNtfzMzl3s6uGXKrTg0LDfrr7TgiEVVpSk34VtaQki3LRq1k5vgQYL4BdHT8HhJJfykLIPZSHgmv7RkEuWqFwKPoV8+sqAv1MVvNKAAkSddf9PZnPg17qTeliVSvyYRMon0O4m69uhlaSas2b+IW5Y42PY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176073; c=relaxed/simple;
	bh=r669ch1jn1copLyRkWU8QWFyTgWYCgtbSASXN3rWsto=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UL6hQJSwU2HIyjxVlA8WEF+dBKzG00IdckbGUui6CVxVgzvjjdTNj9YSMhj8mubfAOlYCCBLSTrEbLbem4EtGlifbnXXmuGQoHqUtMaheXxRaB/SCg6f7O0DHIWG5LhuQTA9QH8WCcKi9L9yV2ncLLKFJwufA6fRfL4V29g4Bug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 98E5C2018C0;
	Wed, 12 Jun 2024 08:57:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A3CA2018BC;
	Wed, 12 Jun 2024 08:57:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EFA27181D0F9;
	Wed, 12 Jun 2024 14:57:41 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com
Subject: [PATCH 0/3] ASoC: imx-audmix: Split capture device to be a new device
Date: Wed, 12 Jun 2024 14:40:49 +0800
Message-Id: <1718174452-17596-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The transmitter and receiver part of the SAI interface need to be
configured with different master/slave mode, especially to work
with the audiomix module.

The SAI1 TX is in master mode, but SAI1 RX is in slave mode.
So add another two DAIs for TX and RX separately in fsl_sai driver.

There will be three devices for audiomix sound card, hw:x,0 is
the playback device for one SAI, hw:x,1 is the playback device
for another SAI, hw:x,2 is the capture device for audmix
output.

Shengjiu Wang (3):
  ASoC: fsl_sai: Add separate DAI for transmitter and receiver
  ASoC: fsl_audmix: Split playback and capture stream to different DAI
  ASoC: imx-audmix: Split capture device for audmix

 sound/soc/fsl/fsl_audmix.c |  16 ++---
 sound/soc/fsl/fsl_sai.c    | 141 +++++++++++++++++++++++++++----------
 sound/soc/fsl/fsl_sai.h    |   4 +-
 sound/soc/fsl/imx-audmix.c |  79 ++++++++++++---------
 4 files changed, 155 insertions(+), 85 deletions(-)

-- 
2.34.1



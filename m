Return-Path: <linux-kernel+bounces-371380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4E89A3A54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAD31F28E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C7200B9D;
	Fri, 18 Oct 2024 09:43:43 +0000 (UTC)
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92418660F;
	Fri, 18 Oct 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244623; cv=none; b=fldFJLR5GJ5asRsEFSFua3MHcfpnWdAgGKv24sTVvgdGrIYsk1FrWGsRTErwE3fIy3L/6jZStDrelaxTg19XYx3Q6RGG2CG1PDsPJ1FQRr3vFS0ONyEPZxDknWp3zkWXhEZzrnKlneVL0A0+n+FyJd5Lh02/mfy5Y/XsH3sbBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244623; c=relaxed/simple;
	bh=U52tBGX3V7Kfo8Upt6OFkiv2WfLQr0Qw30nKNwwfQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgW0pVOfQxS+8kOLgz2RQiAG7gkQ1VTV6TC7ZY0tg/Sy3jjH2w5pV9wrMJhdK8VfcNR/u+cM2JQFaSH8f1CgxFCA+SDFZMzj/dzaSKqK0P2oQX/x4Lnkcu9tvso5yMMwzSJxKjGYdE5Yr3MbuQPFvvEKH84YAFRD6L6Gv7LM7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.ZmCbDO6_1729244603 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 17:43:29 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	neil.armstrong@linaro.org,
	pierre-louis.bossart@linux.dev,
	luca.ceresoli@bootlin.com,
	wangweidong.a@awinic.com,
	arnd@arndb.de,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	shenghao-ding@ti.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V1 0/2] ASoC: codecs: Add aw88081 amplifier driver
Date: Fri, 18 Oct 2024 17:43:17 +0800
Message-ID: <20241018094320.113477-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88081 property to the awinic,aw88395.yaml file.

The driver is for amplifiers aw88081 of Awinic Technology Corporation.
The awinic AW88081 is an I2S/TDM input, high efficiency digital
Smart K audio amplifier

Weidong Wang (2):
  ASoC: dt-bindings: Add schema for "awinic,aw88081"
  ASoC: codecs: Add aw88081 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    2 +
 sound/soc/codecs/Kconfig                      |   13 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88081.c                    | 1096 +++++++++++++++++
 sound/soc/codecs/aw88081.h                    |  300 +++++
 5 files changed, 1413 insertions(+)
 create mode 100644 sound/soc/codecs/aw88081.c
 create mode 100644 sound/soc/codecs/aw88081.h


base-commit: 6efbea77b390604a7be7364583e19cd2d6a1291b
-- 
2.47.0



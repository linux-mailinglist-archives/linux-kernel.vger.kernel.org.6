Return-Path: <linux-kernel+bounces-537727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D745A48FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAC618912A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604B198E9B;
	Fri, 28 Feb 2025 03:55:50 +0000 (UTC)
Received: from out198-8.us.a.mail.aliyun.com (out198-8.us.a.mail.aliyun.com [47.90.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DEE180A80;
	Fri, 28 Feb 2025 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714950; cv=none; b=AS0YPpHcKZ3sGouR43Pyj5gxQ+yTAQWw23YFilIa4FSnmuRXLib+dVpQ+AtKsJMkoc4r6I4W67ZyZhKTIYafgkpl+oS+oqxj/6co+FAQdrqNP22CB0EaDNtHxxHP2aXIu9y20FqDp0+hvQU6psB5AJ2oEvzuQZUNGv0hYGEloyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714950; c=relaxed/simple;
	bh=i6bW/rHcvgT89EAEJIDB0utm9PBMM3NgXDcWd3OeJ18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBog+wefkDHEytIGvAe+GHSmgHiB3/oGd9QQy4lI6sLCYgHOA2MqkgEENVjwJpCUGvBAFZT8vigB6s5W0O6o0xP9QnhFobQkMqBtGd5UUl1As9BsZP/oBavm43dGa4SvWWPD+vywVn6ikjscVgCjG+bkAmeyYpuJCpia8p1rb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.bfYTayM_1740714599 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 11:50:05 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	ivprusov@salutedevices.com,
	jack.yu@realtek.com,
	wangweidong.a@awinic.com,
	zhoubinbin@loongson.cn,
	luca.ceresoli@bootlin.com,
	quic_pkumpatl@quicinc.com,
	paulha@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	nuno.sa@analog.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V2 0/2] ASoC: codecs: Add aw88166 amplifier driver
Date: Fri, 28 Feb 2025 11:49:56 +0800
Message-ID: <20250228034958.181934-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weidong Wang <wangweidong.a@awinic.com>

Add the awinic,aw88166 property to support the aw88166 chip.

The driver is for amplifiers aw88166 of Awinic Technology
Corporation. The AW88166 is a high efficiency digital
Smart K audio amplifier

v1 -> v2: Modify the problem that the reset function
           does not match the definition in the yaml file

Weidong Wang (2):
  ASoC: dt-bindings: Add schema for "awinic,aw88166"
  ASoC: codecs: Add aw88166 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    1 +
 sound/soc/codecs/Kconfig                      |   13 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88166.c                    | 1935 +++++++++++++++++
 sound/soc/codecs/aw88166.h                    |  534 +++++
 5 files changed, 2485 insertions(+)
 create mode 100644 sound/soc/codecs/aw88166.c
 create mode 100644 sound/soc/codecs/aw88166.h


base-commit: 1e15510b71c99c6e49134d756df91069f7d18141
-- 
2.47.0



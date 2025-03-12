Return-Path: <linux-kernel+bounces-557687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8252FA5DC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF7A1897839
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6D23F39F;
	Wed, 12 Mar 2025 12:17:24 +0000 (UTC)
Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com [47.90.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5311E8325;
	Wed, 12 Mar 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781844; cv=none; b=P+MwNi+CZmzOw/ioovxq76IGsCLfoLITYaYpvw8LCRiROnSrrj34TI5vj7SQSC32pW73v7ue04l+e7y79frcHdDBjORLqFmrJqFNzg+ekA0ZGdTab4ekGjFMQCkNFr3vpE8khqbkK6JjEPSD7s/aFc3WzLp1tVPc9REV5bOjZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781844; c=relaxed/simple;
	bh=8Uh5UnlXuQz7gVtNosUV50tm5cgts+g25qLoM/JcjUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZN+upmdhiYfmvtwILUovRMa46+UqxXrRCuZjDhEBfmF19pOYiTljfubl2mIooJs+2SF4xHhyTCjEREpHZQsTCSl2h3V71JXs37ooyCbqxKS8FyqsJmZDQqo6f80f9/R9DF4gT+ZJAhQSYkv6r8PwkJaA772XpzYm6z6o8hOYywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.brTSosr_1741780865 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 20:01:06 +0800
From: wangweidong.a@awinic.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	jack.yu@realtek.com,
	rf@opensource.cirrus.com,
	neil.armstrong@linaro.org,
	ivprusov@salutedevices.com,
	luca.ceresoli@bootlin.com,
	zhoubinbin@loongson.cn,
	quic_pkumpatl@quicinc.com,
	herve.codina@bootlin.com,
	masahiroy@kernel.org,
	nuno.sa@analog.com,
	wangweidong.a@awinic.com,
	yesanishhere@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yijiangtao@awinic.com
Subject: [PATCH V3 0/2] ASoC: codecs: Add aw88166 amplifier driver
Date: Wed, 12 Mar 2025 20:00:58 +0800
Message-ID: <20250312120100.9730-1-wangweidong.a@awinic.com>
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

v2 -> v3: Modified warnings compiled with clang19.1.7,
           removes printing of uninitialized values

Weidong Wang (2):
  ASoC: dt-bindings: Add schema for "awinic,aw88166"
  ASoC: codecs: Add aw88166 amplifier driver

 .../bindings/sound/awinic,aw88395.yaml        |    1 +
 sound/soc/codecs/Kconfig                      |   13 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/aw88166.c                    | 1933 +++++++++++++++++
 sound/soc/codecs/aw88166.h                    |  534 +++++
 5 files changed, 2483 insertions(+)
 create mode 100644 sound/soc/codecs/aw88166.c
 create mode 100644 sound/soc/codecs/aw88166.h


base-commit: 0fed89a961ea851945d23cc35beb59d6e56c0964
-- 
2.47.0



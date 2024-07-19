Return-Path: <linux-kernel+bounces-257174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303BA93763C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB70B1F25D43
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CAD82C6B;
	Fri, 19 Jul 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD0SqM/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711D42076;
	Fri, 19 Jul 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721383007; cv=none; b=by3Rl7gOlB92Id7rdFiMe+Lgvqc+rmVyr7rN93382DJdwE7dWOdUNMjhOUwuDfJlMxvTZ3tlHnKvaFi4UqvcNUMP67cmbkxhiIgFgvEeJuZCoKjwk1VKd93Mljo0R7YwuPqksJ13UiKPvijynhAxhg+jIO98Kpz6Z/uOGW6UX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721383007; c=relaxed/simple;
	bh=DgihQwGyJLD9i+lGfE827avXH+goKNy4YF325JpjvjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KHO7g/ygkIQ/EgctsM1lpeoDAj+KfIRPA79XSV6KFMAgGOEteI6vNh8cNow8dbg3KsdayctY02smC+REE7KhnU7bDKemlduEgem+ISnhRW2cSJu9KNcT3rbH2/7mC1eFP3oEd7VW9j5D6e5wG/sso3Gwn6kOBGfB4QL9DDIuIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD0SqM/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323D2C32782;
	Fri, 19 Jul 2024 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721383006;
	bh=DgihQwGyJLD9i+lGfE827avXH+goKNy4YF325JpjvjI=;
	h=From:To:Cc:Subject:Date:From;
	b=vD0SqM/4Xd9sD0P+xZAVGFqZQrLirpXTV1WG2ruOoIok6P2hDCOjYFWu8+CQ5wO7D
	 hFVbkuihW/ba6wPha+6tpdipbPq+6X4sr8LJdGGFM4s52BTNk0I38hrBxNjEw18AQJ
	 ROOLPNp/+I33EsM4RzSyaISBQdAf+l07SYK8rTI71RUaySXx03aTmCv4HKISav93Qz
	 xY1m3VXBt2J9vicO31k/dzCgq9o2yWhdbPHBtBvgRPH6vlAt/BaColNfJWc8gCvUYO
	 S0KxiWJcD+CpE5kBiqeMLHPnjvZpxzLywZpse7qoTh/JrrNZZ4520KeVS3o52WAn2p
	 wiuky2sbd0BfQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Gergo Koteles <soyer@irl.hu>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sound: hda: tas2781: mark const variables as __maybe_unused
Date: Fri, 19 Jul 2024 11:56:34 +0200
Message-Id: <20240719095640.3741247-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

An earlier patch changed the DECLARE_TLV_DB_SCALE declaration, but
now there are additional static const variables that cause
the same build warnings:

In file included from sound/pci/hda/tas2781_hda_i2c.c:23:
include/sound/tas2781-tlv.h:23:28: error: 'tas2563_dvc_table' defined but not used [-Werror=unused-const-variable=]
   23 | static const unsigned char tas2563_dvc_table[][4] = {
      |                            ^~~~~~~~~~~~~~~~~
In file included from include/sound/tlv.h:10,
                 from sound/pci/hda/tas2781_hda_i2c.c:22:
include/sound/tas2781-tlv.h:20:35: error: 'tas2563_dvc_tlv' defined but not used [-Werror=unused-const-variable=]
   20 | static const DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
      |                                   ^~~~~~~~~~~~~~~

Mark them all as unused as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/tas2781-tlv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index 99c41bfc7827..00fd4d449ff3 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -16,11 +16,11 @@
 #define __TAS2781_TLV_H__
 
 static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
-static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
-static const DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
 
 /* pow(10, db/20) * pow(2,30) */
-static const unsigned char tas2563_dvc_table[][4] = {
+static const __maybe_unused unsigned char tas2563_dvc_table[][4] = {
 	{ 0X00, 0X00, 0X00, 0X00 }, /* -121.5db */
 	{ 0X00, 0X00, 0X03, 0XBC }, /* -121.0db */
 	{ 0X00, 0X00, 0X03, 0XF5 }, /* -120.5db */
-- 
2.39.2



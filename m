Return-Path: <linux-kernel+bounces-379135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE159ADA73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F81F2239E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1D158D92;
	Thu, 24 Oct 2024 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="Cyd2p313"
Received: from sonic302-19.consmr.mail.ir2.yahoo.com (sonic302-19.consmr.mail.ir2.yahoo.com [87.248.110.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6E167D80
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729740531; cv=none; b=VFAWKoD05dXlPFMyHaFpL+CiIIS4DfSjLfQ0CmpO19aMUVOjkBSQdgSXF4yOMQsodeWnxutdUbjhKMN+vbc2J/C/sABKPiJXJa3yh3XmSLTfv9Lq7cslzhH2DPnSNw/oDDCdaIZZpuqgxGgbVS8GIeduQsajtqz47L8+QynMe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729740531; c=relaxed/simple;
	bh=ZwGI8ZFpylkb6XFEt9INmnAgDHvBMqBqmnZAe8+7+Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ofW70aIj9pkdGymHVWuEKQWRuJobUN//n7RwzlOwUU2AYAm17rRIWuLZm0DBi19CLB3nS+emt/ewbTiqPevYwfMdaOdhn0foxEcW4QVU3tBT8c8s7uYvHQHB9TqnkysuiYMLg488D2ktmLxoGN+4jGwtgQkV4MZyiWko722e9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=Cyd2p313; arc=none smtp.client-ip=87.248.110.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1729740527; bh=V/yLWpCvTEqY5RyESeLn3te4FPujd83OdnV26kczf9A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Cyd2p313EoSSBzw4TeC2X2msAOSc9wJRQ+GNbn0+0aRwbV36SCffVriLew6rNkzzL2YKKJwocHwS5UgazPfawbfVCCgXcJoRlDndqXdvb4qHIoa0aqW8Bh9KBf+6cCEZUqKHJmoKj0y5X9t84s1m6dduG4L7gGbNnqns8RbNBLzdY7hOknkuQ52hj5w9Fxo26//70g9ToPSpErOOcCtW8INkGrF8gRLQobD3Ql3OwGmOuYq62aaJgoLxP0tJOHvZI4cYuQfE9unXiXHTdZ4ohszmO8HB2wvwZPFDNnEWqZXKdSzHl40TG7kpIyl551wp4ZlD9xIvTJ8XSwCUSkxpSg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729740527; bh=qYG1B+XEFw+nhcyK6VkIfyHk6tpvSPRCt8yeVgCTehM=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=O6/jQjKk2pbrXaXhSaXBQf1J5JW0EZyPBS9B+tqRjpa/Ekd9857W/j9wFyPM2VEY7TeW+MHSGc0nEzlDDP7VRzTmoCjIeb95nm9gzjGZR61fLkNdSJ6TAHNG9TBLpSffJtQKt9wCoUyD1fLfU/qStHTcmeyssrnu9Do6p3dS5HE2Bm/JIW+vdeLEC3kCLqFRCOZcH/M2fqeNO9POuqm6TWOKVOv8/RWsk02EFL4GmpuqvVcSzkiO0TDXVkTUBtyFrE2ZsbNPfCgHM56f5EPkaSwYsRJi2gYJJMnzKfdzI1qvK85dzitXxQ1F2EcMt4q5Ugf6p9ZT9baYfP62+YpNqg==
X-YMail-OSG: eRMveYkVM1nvlEsA.JoCYclhfRtMGJejPSdiwDO7iu1ExAZrOUoPtKA32fW4yne
 C4d5E5Aj6jJsPYANZTCux1m6P0DqhQpjbz6f9JjkUJ0QQGSGyFHWRlMR67Bz_aNMtzhMHEOyQ97i
 xEoGoJNSoCs5YMxy9TI4Q6_tAUeyDV61ToNprXQbFcrC8iuKyfK2wC34k_8k3wZClwDeIGMc2ElS
 3mrSW8rmX8sdxEjhbrz9QCqPI7ozKASgAuwF56bJX1Uyro2hAfYMiCet16HMRNFSA86JsmrX18_o
 2XBAICGS22a1SGpnrwJTnySYu2Oa8ZiYfWtfOt4HHmjakuFkdKQKex2rhxa92lKuuE5wJPB7txYw
 gEPVqBfzZCULfCwfNzsDHoSNf2qWF4S1Ws8sBs4rXAFf4N5V7dnpU4ftyg.ppfj3Yzd_XQmHAtq8
 e71RPzUKCT0bjrSgGOvtsmLyVZvUaAtxHL3jYlvFaWkVccwo21TPmDY3GimB_3ltdvK81XYHVgIQ
 UnrdrCk5E3oEx96AjWck59DmGHgezvNq2APQHpVpFddLHNp12JgePIuzTRxRI088icxqG65xDjPe
 pZDzcqWQizUUnh7gdrwALuapkuJhk8pIQMqNTneFJqJNxH5w.TRITsZpdrqMB7cbFmllPJHShTrY
 tja0LcTJvlmx1MSieycHg8G5FX5kEc1MYQ7j6yL1lcMCd4jLopZkmCFXchAUb.amt8tqxh1KM.sg
 x8sNEXnckxqpR6L9AspFzugciCb_aKFbnQX2336bBAq6G5mUipIEsbz_8cMEP1C1UHClKBHUiEgQ
 2mz0zDaGvXDNxbjtk9h26pXPR1gSnRqKcU1cKoADfGuDtZTL5_OUuW0C5nNPV5StxsUUAxWeTUNI
 zyYEEeq4vV5.m2qzn9kKN94znBDoFi_tBjDpTYhIMiQ4z8gKlI2s1wIorxqyHyw3Im_rXTHsnfVk
 yvlzyQcGrfbeINlqoOGjtXSnwhMqWgh7zXMlpqQn2Z2_uLcEHedTdfUjjSQ2Y_w.0jIrKQ_cYFMl
 DFt4eRoLRIIOfqRsQxeJUeWMmws6Ct3ggpprED_O6AyE0zRjIONmPMCwXt9F82V6TOtRfbMcVVz9
 ZGNOvuLLkIMwny1J7Eow13e48Y5oSoql9CHTnuOxHAgAZop.iLm.Fj_c9I5SHkCXlP4GE.r54oIk
 UyPsH5m0zJs9q3Yu7u5_q5yVRNyo_.qMl67nchLS2X2jTvn7qcOULU9Ns.RRaze4DMpBZNrYP.n2
 2F5DWpVR_tGyP3siQd7Wd6U5mH5Ot2GY8hu49CBNkGgtwt1TpN2wjLq52UWRekHo5b7zgrQIlT.e
 GFG.kRNIdupMQ0Ov3d8l.tF6mGEThqD5ZkmN5bRijKVk899oHcFa.cHzyneMl278mZ_eT4kkfHJu
 EPqU_HolWegI9ynfEFQpp7msjvtFc_9sMbugDRy0cb4XbagDluGmileWe8RAfRZ38hMBfgYdxQip
 Uoqc74Qpo1nWGm_GArWv8L8qmODhcJQDg.lJfFuUdHBxD3aiOUsWgydu8pFBob5YqifMR7ESR4Ue
 MIhifrAW9Vm6YWi1oc3eFUf1nvHXW9rzfVMamwx9paK67d82TFqFRUBSVy2dZabm2yBXU1DenE_W
 vFJSiYKYOE0iAGbn4ZQGwHhAXP9KwfQ2xTZn0YPp6ZMTPfy.HK23vJJ20dtY7zt321xRXseac5x2
 zipXL5lkZoSAilqBQbOG5QzwAZSoLLRJdhTYQZsiv_YwkGZF2qg3nFR2ZOS0HbT2mS5MKMtC7LJf
 vf97WtCGxwiy2jlexuYU.GFp3lJaVMlNCOHa4_5c_vKra3vsihAqUanlnK1vdcYC9gwGDtD9pxgS
 W0cB_1X.7yxX7fKxeRwsxbemEyUT1IebMS2LxFNG224v.2Foz_zSqMx0TiLZU3iWcYuiw3bWXn7O
 HguhF1B6W8p5Y5WNHhpcCPRJPuoPDHlYn.QfAkwfmzz3QEDmlm2asnP5DlhKXT1QMNiHKf1k3Nuv
 opTRdkzA2PeLFNoGf12C_9IR8LkmOK4tBU04gbpd1va8Zqx87_MDsERuabjQkKNZfwBpgZGkOD9M
 8RWl.OBYUiSFESX5rePqtCV__fVq0Hjjrm2Lt5PZpU5_qt8nNbfES9u7BhpmU6tGKVuQhgpMbe_1
 sit6oyo_6MIB9hA_kmNQLkcTB3.YeAVbzkYOL9TLnBvfsouE_9QYYs9N2BnUyOY3D9FDi36cSXzw
 q6yJFTbULAdxDU2T_TtcWke7WcoSyduk6gluRW75.ml7mjRRNgCRh2SEiDHj.1GVd8WBg4wC3JwW
 wlYvL08.4T3Kyr5He4jBz32PZMLD3gSE9XJxRC3_cJvgD7ZxXmgzl
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 61af113c-0b3c-40b5-acfb-4c058bf6fb03
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Thu, 24 Oct 2024 03:28:47 +0000
Received: by hermes--production-ir2-c694d79d9-2zgj2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 26d1652bc1703d2ade3e89c3cd33808b;
          Thu, 24 Oct 2024 03:18:36 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v3 0/5] Add new panel driver Samsung S6E88A0-AMS427AP24
Date: Thu, 24 Oct 2024 05:18:22 +0200
Message-Id: <cover.1729738189.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1729738189.git.jahau@rocketmail.com>
References: <cover.1729738189.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset adds a new driver for Samsung AMS427AP24 panel with S6E88A0
controller. Patches are based on current branch drm-misc-next.

Changes in v3:
 - Patch 2: Dropped the second "bindings" in the commit subject.
 - Patch 2: Applied 4 spaces indentation in the example.
 - Patch 3: Made struct s6e88a0_ams427ap24_supplies[] "static".
 - Patch 3: Removed the "panel->prepared" parts from functions
   s6e88a0_ams427ap24_prepare() and s6e88a0_ams427ap24_unprepare().
 - Patch 5: Dissolved function s6e88a0_ams427ap24_parse_dt() and placed
   the parsing in the probe function. Changed the parsing from
   of_property_read_bool() to device_property_read_bool().

v1: https://lore.kernel.org/dri-devel/cover.1728582727.git.jahau@rocketmail.com/T/#t
v2: https://lore.kernel.org/dri-devel/cover.1729630039.git.jahau@rocketmail.com/T/#t

Jakob Hauser (5):
  dt-bindings: display: panel: Move flip properties to panel-common
  dt-bindings: display: panel: Add Samsung S6E88A0-AMS427AP24
  drm/panel: samsung-s6e88a0-ams427ap24: Add initial driver
  drm/panel: samsung-s6e88a0-ams427ap24: Add brightness control
  drm/panel: samsung-s6e88a0-ams427ap24: Add flip option

 .../bindings/display/panel/panel-common.yaml  |   8 +
 .../panel/samsung,s6e88a0-ams427ap24.yaml     |  65 ++
 .../display/panel/samsung,s6e8aa0.yaml        |  10 +-
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-samsung-s6e88a0-ams427ap24.c  | 754 ++++++++++++++++++
 6 files changed, 840 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c

-- 
2.39.5



Return-Path: <linux-kernel+bounces-198145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B909C8D7411
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A01F216CA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34411CD16;
	Sun,  2 Jun 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY0Obn2C"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D551C6BD;
	Sun,  2 Jun 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312306; cv=none; b=IVJkb1GUZ5HIkQ2ttPDZmcUkTh42XFWE1xHvqGqlG6P//orTdg8dPukbxLQxidJefe+z8GB0zgyD2gUqbnq1P/vLto4zuKQzItyK5r0ftLDM75E4ZrhafBNWZ3SBV7DORWnnAcHmW2mAI07yS5G4dFWfg/3BA48c58UbkiK5tMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312306; c=relaxed/simple;
	bh=wAB4tvOUkBgNUE+6cjMuoVfOmFtq2IxqXUXAMrhGaIE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a1s5K72h18w8OjcXKyhd9luz7P6nN2OGu4CxM/LopzsV5ynp36OFZOmyZig9t3n2vGqIjQ1XYicXyhPRNKX4s921lujE6Br+fuelKu6SU7WurDzlxYjKOyoClLOwoswX/ffm1+vFpSFTVOuJyaPcNXEtWkLnYNPiSOgz2kc9d5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY0Obn2C; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70260814b2dso345521b3a.1;
        Sun, 02 Jun 2024 00:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717312304; x=1717917104; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPn/0OCWIdd7hzycpNXhtZT0DRdQQFNXkDHRuDF+9OQ=;
        b=OY0Obn2CxUDi9LhjYtmd66u08WR/ulEkK7mdxzbTDOcNmCpZSqNzAOJDGliyLf54bZ
         58QAfVlM18oZdrwQyfJ3mtKuF1jG+PB+ZkbOMNRrMeO1Ul0IlHYRIhJD9WacBM3zP2mi
         7y4h/VXL7QHHLuXx1wnuLCS94bZHAQhPL2BEqsAiA4XH7VDfQtDDE5ti6e3PW+tHRvWo
         N+Q2VqeDkGb9rL/Czn4Z/qsknyh1TNvz3nJnw0d+WBg7DE9JlLAsIoiipyei2F1GtjeU
         L1lExjl8X1U3oP/9RtU7kPBm0Tk9Z9EwMRFfOibMi4Jwzx7mOvVcOsfU8UcnJJuDacT/
         mS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717312304; x=1717917104;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPn/0OCWIdd7hzycpNXhtZT0DRdQQFNXkDHRuDF+9OQ=;
        b=tsCSPzE7iA5PY8VgIbsHINXq+TCrldafSxLlBYsrnP/hsFjDjZPIAF7o8ht3K1UEtM
         pEO5Dbl46/pSt3BU65QQ7iPqIMDIcdblaMFOGJimj5ywI41Po/meCMgF4BeSDJu9q+K/
         9iAPd62uj9BBSUVIdjFLIdRGeV1wvd7jDzuhZA82bSH1KtdEmfF3aVanirpqYd2AWOKh
         bwkS2yN8x2G3OPKcwU2RwuZARnF0H/D5Y6BNmao14jnAIQom3mniLRBS1FSTyhr2f2qC
         NQ4Cqz6ibPMmBXEDL24+LhKWdZnFQBSKCN4Si11qDdRX5ys2GZ6POQx4O8pd6dPr1Mox
         LFfA==
X-Forwarded-Encrypted: i=1; AJvYcCXhctiTmdPtmP52t49yRmaVKBi4hgita4OLofW3mBJ9xWhdv+Bl5crmBTUwUyLo+aItY8bn90gahTdl/ust8PuJU4iaVDHY3vxe+XJl
X-Gm-Message-State: AOJu0Ywa2GP8AmO4YIdjcmugyfPxFadRF2RdupCYKC76ktaFivhCy1xj
	7f3W5E9awJbP83BDt5xlN69lsJ39K8xlKTbKgfWi0UUMj2lIO4yJ
X-Google-Smtp-Source: AGHT+IHHPi+JHmcrngHt9Q8FCOSZAQxXXVr2fikPdnBl5sp91YURqwso0LlhHlFkR4K4ZQhzhLbo2A==
X-Received: by 2002:a05:6a00:8813:b0:702:4a1d:c4a4 with SMTP id d2e1a72fcca58-7024a1dd1camr7465347b3a.10.1717312303774;
        Sun, 02 Jun 2024 00:11:43 -0700 (PDT)
Received: from song.localdomain ([219.145.37.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025aa3cb45sm1555822b3a.135.2024.06.02.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 00:11:43 -0700 (PDT)
From: "harry.yu185" <harry.yu185@gmail.com>
To: corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	maz@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"harry.yu185" <harry.yu185@gmail.com>
Subject: [PATCH] irqchip/gic-v3: Add Allwinner sunxi001 erratum workaround
Date: Sun,  2 Jun 2024 15:10:58 +0800
Message-Id: <20240602071058.6405-1-harry.yu185@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Allwinner A523 GIC600 integration does not support the
sharability feature. So assigned Erratum ID #sunxi001 for this
issue.

That the 0x0201643b ID is not Allwinner specific and thus
there is an extra of_machine_is_compatible() check.

Note, because more than one soc may have this problem, the 'sunxi'
name is used instead of a fixed soc name like A523.

Signed-off-by: harry.yu185 <harry.yu185@gmail.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 10 ++++++++++
 drivers/irqchip/irq-gic-v3-its.c            | 21 +++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index eb8af8032c31..351dd6094a6c 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -242,6 +242,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Rockchip       | RK3588          | #3588001        | ROCKCHIP_ERRATUM_3588001    |
 +----------------+-----------------+-----------------+-----------------------------+
+| Allwinner      | SUN55IW3        | #sunxi001       | ALLWINNER_ERRATUM_SUNXI001  |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..5a71227d119a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1279,6 +1279,16 @@ config ROCKCHIP_ERRATUM_3588001
 
 	  If unsure, say Y.
 
+config ALLWINNER_ERRATUM_SUNXI001
+	bool "Allwinner sunxi001: GIC600 can not support shareability attributes"
+	default y
+	help
+	  The Allwinner GIC600 SoC integration does not support ACE/ACE-lite.
+	  This means, that its sharability feature may not be used, even though it
+	  is supported by the IP itself.
+
+	  If unsure, say Y.
+
 config SOCIONEXT_SYNQUACER_PREITS
 	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 40ebf1726393..d93348947353 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4775,6 +4775,19 @@ static bool __maybe_unused its_enable_rk3588001(void *data)
 	return true;
 }
 
+static bool __maybe_unused its_enable_sunxi001(void *data)
+{
+	struct its_node *its = data;
+
+	if (!of_machine_is_compatible("arm,sun55iw3p1"))
+		return false;
+
+	its->flags |= ITS_FLAGS_FORCE_NON_SHAREABLE;
+	gic_rdists->flags |= RDIST_FLAGS_FORCE_NON_SHAREABLE;
+
+	return true;
+}
+
 static bool its_set_non_coherent(void *data)
 {
 	struct its_node *its = data;
@@ -4836,6 +4849,14 @@ static const struct gic_quirk its_quirks[] = {
 		.mask   = 0xffffffff,
 		.init   = its_enable_rk3588001,
 	},
+#endif
+#ifdef CONFIG_ALLWINNER_ERRATUM_SUNXI001
+	{
+		.desc   = "ITS: Allwinner erratum sunxi001",
+		.iidr   = 0x0201643b,
+		.mask   = 0xffffffff,
+		.init   = its_enable_sunxi001,
+	},
 #endif
 	{
 		.desc   = "ITS: non-coherent attribute",
-- 
2.37.2



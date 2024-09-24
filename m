Return-Path: <linux-kernel+bounces-336875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E19841FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E34282B88
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD4015624C;
	Tue, 24 Sep 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0yrQ9J5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB2155C94
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169874; cv=none; b=QHlrxPYIIJDQQZTYeL/g+9ctW7uH6wvIVn3bypYCCrt0zxNmr23YZl76ia9PhzHK/I2g4kmHyVIQ744w1f9MLcRXfLvRqCToN/nQl+NoEaTcvulxCP+O51jDV61k/Tx4Gniu18XiOFbjAPaaHzhVacfsZ1FYuzHt+9dTRPiZAKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169874; c=relaxed/simple;
	bh=dI0ztOadlf/S1pnakLt/oKsQkgAk4v6rBGf1+7LWnOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FHTQGqXL4yw1GVcgkcUXsPMOhIqVoPs4AkQabCoVuOAS6ZwsM68ZEw5vrQcoRbhm6rtcmM1B0hQ8ER5dDItHcANvKjLCAfBKSCbLxPAtuQSO5FvGTfLIHtRKm1aujDyXKB3Zscv5d0r1eK8XEOLiTj1lEoCR1yvaWA7jInlAKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0yrQ9J5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727169870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bc2XIgIruT3HvUSS07XrwLzqaOB5PyjnEV1kT6BR7U4=;
	b=A0yrQ9J5tcHFn7yf6KPts0cz3CAbP/L3Dd3xoJde1KvFIkJtHEEBwbUUZrYgZqIVGc6EBh
	WKMf2G8y1CoMC2axOQB+JqBdhaS2mJ9tpHrlcSVihVwTYY1g3aQurP6hFM219Y31P5+jnf
	hhWV8PEAs5zxTerEaczKbfDz/mvBTXQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-K59s9IpiOP-LrgYNleLGKw-1; Tue, 24 Sep 2024 05:24:29 -0400
X-MC-Unique: K59s9IpiOP-LrgYNleLGKw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c960ee7aso3518980f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169868; x=1727774668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bc2XIgIruT3HvUSS07XrwLzqaOB5PyjnEV1kT6BR7U4=;
        b=nqqKPvlMnvcJP5q/GSjBIevKLHds51LR3UzxdnyLZxu2E/tPTxVKxBG9sdCZ1lVHoc
         BbbFuDKIC0S1AhmMo6tOcP3X7EB/j/GRfaiUSev/+nG5LG2lFUBUGQY05SEPr/okXJui
         WVsyYWdO+8F1kXwJMNfEHKVkUI9JrjqCfvfUxVDeu8nv+Fhj/kbL7R67z6GLssnaDj/8
         KUH7xy9FNbpY2t/heMQ+Kbfc8k0wm9Gj01F9tUt9RDP7xKyQ0CvYF9v4ZZhFCK0XTpP0
         XN4gyjnuwzSTfJoUBP64XuRHeeq8zCiUbyMifj2E9zxcdybjr0KH5hz4U/rphDHiGWZC
         uknA==
X-Forwarded-Encrypted: i=1; AJvYcCWV4sWcIh5QzjwBC8LUSODG49Nmb3ESjmquWusrmKhxxIIH5ywkBgkQmEHMpDy6W2PdlLgAejo/cw1SBM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExOaA8ctS310mkK+DOJAhVwBTzhfAGabxLD+1STrdE2zrUA17
	n6NMnI6wrT+Gqur2jZpm6HMdZ5+GGcCLkvRWvp/ZnIDi1heLq5Gn5cdETwU6yR8zdmRkyLfGTVV
	U2PPAeWoHWC0W9RmBqbSskjwwfLt9LERkSHrYdFQ6slXzw7crjOsDBj47DCA7Wg==
X-Received: by 2002:adf:f64e:0:b0:371:8dd3:27c8 with SMTP id ffacd0b85a97d-37a42279eb8mr12970186f8f.23.1727169868049;
        Tue, 24 Sep 2024 02:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtB9eM4bgR0oA/7C9qfTMCUdblSA96IAhCJIqTblqLM8bL7ZbpHCQHUESQulyuXbPD8W6YbQ==
X-Received: by 2002:adf:f64e:0:b0:371:8dd3:27c8 with SMTP id ffacd0b85a97d-37a42279eb8mr12970160f8f.23.1727169867654;
        Tue, 24 Sep 2024 02:24:27 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2c215asm1079306f8f.45.2024.09.24.02.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:24:26 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] soc: ep93xx: drop reference to removed EP93XX_SOC_COMMON config
Date: Tue, 24 Sep 2024 11:24:23 +0200
Message-ID: <20240924092423.50734-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 6eab0ce6e1c6 ("soc: Add SoC driver for Cirrus ep93xx") adds the
config EP93XX_SOC referring to the config EP93XX_SOC_COMMON.

Within the same patch series of the commit above, the commit 046322f1e1d9
("ARM: ep93xx: DT for the Cirrus ep93xx SoC platforms") then removes the
config EP93XX_SOC_COMMON. With that the reference to this config is
obsolete.

Simplify the expression in the EP93XX_SOC config definition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/soc/cirrus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/cirrus/Kconfig b/drivers/soc/cirrus/Kconfig
index f2fd0e16a196..d8b3b1e68998 100644
--- a/drivers/soc/cirrus/Kconfig
+++ b/drivers/soc/cirrus/Kconfig
@@ -6,7 +6,7 @@ config EP93XX_SOC
 	bool "Cirrus EP93xx chips SoC"
 	select SOC_BUS
 	select AUXILIARY_BUS
-	default y if !EP93XX_SOC_COMMON
+	default y
 	help
 	  Enable support SoC for Cirrus EP93xx chips.
 
-- 
2.46.1



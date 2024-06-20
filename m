Return-Path: <linux-kernel+bounces-223264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7A891105E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD741F21333
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B61BD510;
	Thu, 20 Jun 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="tqE1e0EM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552D1BD02D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906471; cv=none; b=jhvQc0fR+U0pJ1eC/EvIR/56y/41WXt38vTvVOMh0S+md3RlrCAOMsueYI1Uw7SiYEybAThEMkJJT3IpM6Ty1KVsoLTPE3HaY7h/jQwu+pNBb0Jk2WQpLgFw9MuSejmFZS6Bpv4JDVnPz7F0c4eBeBpjkfiTzziH764bKh2HzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906471; c=relaxed/simple;
	bh=T0AdqBMK9lkL1kcLkmUERSGkLaTYUdQ6VqLsNTB1DZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSnHVP0l1EDmN6DKlJYPGJ+0Fcy/1ugD5YwQ9qj1wT1G/c0r8xsFcalMo3GASe/ZT3LcWhSoHS+ClUsBFAksxoK5HpCc7RDTZSJB+E0pdIQtZHgAnDR9u5ot5I071b5oSTLEJFzoPlEK2cxnLF2OQVoFLkByGovW5/ihK2VC+TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=tqE1e0EM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6fb696d2e5so135954566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718906468; x=1719511268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz8kTOxdaIm1u93eV0Is+4r0vyFAn21pP7Hjv/L4wvo=;
        b=tqE1e0EMqUp2C79hQhRClkk6F46UnOwj31dr27M9qmDkJrZxEP3hyNP4zu628BPCqw
         0tSSFPiQxEVpSeif3aXosKjXeITYlIUThl1mw7LalfsMA3qLmumGXhPCQqEm4QghDY/l
         06uJL8I3HpoyFr7fgEW8mjs/fCjz8dgSTjoeCFR1hY7wb2O7KAhRKj6jKtY3fh1SL77G
         l+IaJWqEfSycIPsIDsUZqhpPuPpuM+uRXDbm/Im+Di1YLI5HKfJ8rvlUiVioW3pZ4eLd
         7fAgA4zdtpkeXkAVD6hEEwdjAm+/EQqLSoSzPYHpmL9voXsAlCy8NacJt5jj1+nXbgUQ
         L35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906468; x=1719511268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz8kTOxdaIm1u93eV0Is+4r0vyFAn21pP7Hjv/L4wvo=;
        b=pDo1knF8dz0WKzgoymQaIADJJJ81vnY3LeDvUlc3RWRhOf2q+sHhlDGXwp2dG1QY4c
         LtzGZXUxDte7P0zwFmihJDDuqmjOp4GzhNqshPd1jJpiFLOmbdx1tFKRk2CUpUssvppE
         zZRj4ElU8bGRYd2KNCD9GJmp8ACKw0ALkSxe2V5tmBk9zAxoQxLO+f3sP2pXdYdB8JhP
         EpJt/9bSWZFl01QMuPTBllOhKiyIouWJNTKX9T4Uyi6pzqgEEcwOLajbo9Xf+RIbqHd3
         bfIEegBsqa7rAhfOslyQYDgNhh8EgHe8zvG/igWoj6KbdjnLwQnzGaDTCriDXH532Sqh
         hZDw==
X-Forwarded-Encrypted: i=1; AJvYcCVfPfZ1Tizs4iUPvPdwegg9mIlw6nNccrCRa+Jniwz8k6O6DXryIUasFvEWnvY8KqXK92vcRX7Vh6vRdWk7qBrwM8s//8KxewohlZ/b
X-Gm-Message-State: AOJu0YzkSqjjVPTlNMpeg9D8ROfXNiUjES9FM1VaaUHb0OqUoZ5ZCkHv
	2DooekLLB/YxEP2s3oFwnAhQiymS9afAyvUsQInTH7F29FWBCGGFR7sN2s/T+7U=
X-Google-Smtp-Source: AGHT+IG8eY8d/PSntzHXSfPtqV/wO9neoC+Na07hB+VY1pAoMYT9SP6YNE1GHB/rvuCByUpgceEg7w==
X-Received: by 2002:a17:907:a80f:b0:a6f:b67d:959e with SMTP id a640c23a62f3a-a6fb67d9870mr344459666b.53.1718906468099;
        Thu, 20 Jun 2024 11:01:08 -0700 (PDT)
Received: from localhost.localdomain ([91.216.213.152])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42e80sm781370766b.186.2024.06.20.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 11:01:07 -0700 (PDT)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Yangtao Li <frank.li@vivo.com>,
	Li Zetao <lizetao1@huawei.com>,
	Chancel Liu <chancel.liu@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org
Cc: Markus Elfring <Markus.Elfring@web.de>
Subject: [Patch v4 10/10] i2x: pnx: Use threaded irq to fix warning from del_timer_sync()
Date: Thu, 20 Jun 2024 19:56:41 +0200
Message-Id: <20240620175657.358273-11-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
References: <20240620175657.358273-1-piotr.wojtaszczyk@timesys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When del_timer_sync() is called in an interrupt context it throws a warning
because of potential deadlock. Threaded irq handler fixes the potential
problem.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---
 drivers/i2c/busses/i2c-pnx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index a12525b3186b..b2ab6fb168bf 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -718,8 +718,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 		ret = alg_data->irq;
 		goto out_clock;
 	}
-	ret = devm_request_irq(&pdev->dev, alg_data->irq, i2c_pnx_interrupt,
-			       0, pdev->name, alg_data);
+	ret = devm_request_threaded_irq(&pdev->dev, alg_data->irq, NULL, i2c_pnx_interrupt,
+					IRQF_ONESHOT, pdev->name, alg_data);
 	if (ret)
 		goto out_clock;
 
-- 
2.25.1



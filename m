Return-Path: <linux-kernel+bounces-227871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8699915797
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01C8285FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AF1A01DD;
	Mon, 24 Jun 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fkzpX3pd"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C11A01DC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259850; cv=none; b=evZuqU9c4fUyVZ0hYRGDiu0G6hXKy1P+bFgOFOa+OfagQrXIdrmYE30dmetO7xJInLjjd23gXWqzk8jTtJPi8fNP+F3yl/4dYCYHIxucoELvtlkoiqazEmqTG6nb+6ncLfpT2BXD05xMiZnQTROgmKz5yLZP1x+CeoKfdBwMNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259850; c=relaxed/simple;
	bh=gwveKsBVtN7JFtmU94y848i/o5pT/Jhq2LKbTqkccp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODA/cNaNzYG5Eg7XmEStQHzXRnx0X+JgQ1R2JWUMCCmf8tBSeDwJR8v+C1yqJhNvL8sLATOhCR2NPXdV1InFM9QrE1AzeFX8+ifou+K3M91F3EF3kKB4AADWabCqsmW9mljztisAOe46C2vuPBkneL2t09KSKB3MSxAxbb6V20s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fkzpX3pd; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25ca30072eeso2510908fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719259848; x=1719864648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pynIwSYLtFCFqE/LQh0xYvfYgPBDJkazLg5naxF4gSA=;
        b=fkzpX3pdQsNMGXaaXbgrCM8rgVlEgWID9r2Jw7nTTqnKu3J4VtKfnXp+CRGTMijmvN
         xt+KtfzfapDKixaeOzyaZBxbPARuoxrdtVpjPkj2ED1I6U5iaaoWF6LlFP06XotfCEhp
         b26CvwuJ9XHtbBQMlAAKK3PtQbdg4/wt+ZTOr0m5wN6eP7jM8uBEsZ7bB6pV7A8qptCc
         d/5U5wTN9GRifeOzHQOnk5a3d3r+4WrwT1PyKHZFG95l27UbXhHqsfctbWTrz4g7beCR
         PYJt8w0Fn2WxUeLQ0bhYyZRK3WZB+21FxMAGTUzS6DLT7eKDo3sx4iuLVAU5CEmhNdSq
         FbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719259848; x=1719864648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pynIwSYLtFCFqE/LQh0xYvfYgPBDJkazLg5naxF4gSA=;
        b=ilPE+Dv0EMvKHArCNBVviIgkyB2KfS8uihlkohg28oeYFJsKcX718pG7BDyRNFyOp6
         yEvujzMmvx3lna8JIWKFYRuE6S/0JPOLQnCXS8KklXtSwQ2aOzkBmyMkbKIpdZkj6l2P
         uyzb4vWNFnWTI3jE3iies4ITsToHjKqP6atWhC9kgWwIpP6Gvzr9ZTt1yUTXp2BBaXSG
         bOcsMw0kFXeZoIU99rCdzw6zYRmys5fSkpM7RelFRcieaV4yTv5imcFtjUOQ7kd4ssFi
         /Y3gTF5RExvAV39AE5bTflJw2xhdpDwAEICU9Yc4bvGJPQeEo8OXeNgQVGj1KKJn7qD9
         QgLw==
X-Forwarded-Encrypted: i=1; AJvYcCWz/LixS3BQk/G8SEp1y7gxV1syG0MGT14EMjp86oYSqZyPNuglORTQUETpwqq87xtIkXBfP50qh1txY5J5BkBN0mVkrSiI4739CdEy
X-Gm-Message-State: AOJu0Yz74sB9vB0187mG4vB69CmZyhfa2Sd6Z0sA8ldXCvWCSeLPgvyS
	/vHqwRT5dgXhqEZipmTwOH9/3GH4zNBOVWbZZR6gbOA0B/pcibgkZhrLvXQt7KU=
X-Google-Smtp-Source: AGHT+IHRPUfp+ZBPyKVGnp8PYVSyxPlPBcZpQHC+Oj3KSMk2tSXxZxcaP2yg1g1kDGwwn06PCl+SEA==
X-Received: by 2002:a05:6870:40c8:b0:250:7a8d:1756 with SMTP id 586e51a60fabf-25d0163e8d0mr6380388fac.12.1719259848112;
        Mon, 24 Jun 2024 13:10:48 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd498872csm2056581fac.21.2024.06.24.13.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:10:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] spi: add EXPORT_SYMBOL_GPL(devm_spi_optimize_message)
Date: Mon, 24 Jun 2024 15:10:30 -0500
Message-ID: <20240624-devm_spi_optimize_message-v2-1-58155c0180c2@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
References: <20240624-devm_spi_optimize_message-v2-0-58155c0180c2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

devm_spi_optimize_message() is a public function and needs
EXPORT_SYMBOL_GPL.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20240624204424.6a91a5e4@jic23-huawei/
Fixes: 17436001a6bc ("spi: add devm_spi_optimize_message() helper")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3f953504244b..814d66fc9753 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4384,6 +4384,7 @@ int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
 
 	return devm_add_action_or_reset(dev, devm_spi_unoptimize_message, msg);
 }
+EXPORT_SYMBOL_GPL(devm_spi_optimize_message);
 
 /**
  * spi_async - asynchronous SPI transfer

-- 
2.45.2



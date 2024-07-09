Return-Path: <linux-kernel+bounces-245044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD3F92AD82
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A99951F225DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBEF36B17;
	Tue,  9 Jul 2024 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="flQiI1G6"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE692746F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487148; cv=none; b=gZOZbuDzIhQGSAslCUSBm/4EAVIHO1k+iSkPfq2mipXcqkd9R7EoVl2qo8/92OrkPPoQP3fYzi+bzucQqgsmAicpEbtk7HfUTnAOR+QMqVN1WpLxVDbUhfUnfhzp74RiUyqztZb1geFZP+LjZfkq4MnI9Pb53FtSFPlXhgacXoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487148; c=relaxed/simple;
	bh=MCMshjCn4X7qsHq4kXqJP0zCCRHD6RupPbdPAs9uLOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBmu5BiT/1GI33DDGsf9cL3wTDdtXzEkw9R08xcKGemLn0ZDuXZCEnsVAXKNn6adFHYYknTm89QsPw1HIRm3nT083buPWSN4fNa1LFmifiYbYkl05U95xDUaw8zOkCnv6ojWcgCtf1SzqY5veGePnwlkPvXpEVgynRsFoD8mHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=flQiI1G6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d934cb84b6so726296b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720487146; x=1721091946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pqUInDFYH5yNjfgMFCM2DbLWsqlTAzTUfTi1S8oEnY=;
        b=flQiI1G6Gt8tKkMq14TZ197Kca36qGR25TWjXdj4Ok9kDxlTZKcESVgoA6zF5UmSbS
         2ITQNODMquatcMfHEuJuy9zI4tAKDswks2N3Zwa3eigkcMtgcwP0ou8j8GRjOGYBeA+o
         XSxjHb/hPKZWDjk3/DvSBdDnncE/zyOLAgYEB6TWo1sgQa2wna4TK8CBtABpY9FU4M4h
         fheTH8tEJNUeuYhsvm9syguYKUloUg0qfvTfo1pf9bAXjeUXjs0sld6cXddB1/B44SE1
         KFSKm/9i2rC6iHmIuABTrNVPl7GvmQiRohdA4vFa3fVc2HF0vGcUyYHnwfMsfRaV4jjd
         /7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720487146; x=1721091946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pqUInDFYH5yNjfgMFCM2DbLWsqlTAzTUfTi1S8oEnY=;
        b=qhIvvjGe3oL77S0TEZqdz0t3RXvNdrxQcuJn33EpoZQ1UJqdhSdVksE8ZPJSLdJHEl
         fRWsGv4jUWikN+cz9TA585NWNnJcZGWHnQVyfcbVb2qCCvhp13KKncmK17x87ivtRjh6
         eIUQCFF61GFzWxVXaP3lGwm84tEGm4x2vcF4j2aJKYL1H40jO0RCu10Fm8bjqaH+j6p3
         YlScV+AY7U7unPP15/q1DSH98/oOZK5Qemy4n1YCTm5EfmKeBKi+1CxAFOxHuhpQXKNg
         Rw8uT4xpQnifdnTA16bI3qc1nwjmMvIiGcJNedP0gXP2pADDvpXodWzET5tkn7vwNfSh
         hGPA==
X-Forwarded-Encrypted: i=1; AJvYcCX0nYdldrCTLxrsfQZR/P0yz3/rWAnqSvxQeKQJkrnA8zA4/C7Rvv/X9Tekex7eDg51tQg4bZ3MKXN4Wn26Y8J02DYBh7kDAt7VtE+F
X-Gm-Message-State: AOJu0YzLK0JbP/8tANoS0boHN7W+4HCQhCsJ1aaOlseIyK3bIdMXRRh9
	9+zpb0tUxMhM0vLd3z/P+WH318xv1Q/xyaukerGse49gf+d+JvTBHQ1ETgv9n9M=
X-Google-Smtp-Source: AGHT+IE04QAcCc+Ka9CUVQ8BW9t27zTe7aVThg+fBFSpAfZ7YHIzZcBJfHAy7mKt7Ub74D1fCpW4tQ==
X-Received: by 2002:a05:6808:1785:b0:3d5:64be:890f with SMTP id 5614622812f47-3d93c0b0401mr1042371b6e.49.1720487146135;
        Mon, 08 Jul 2024 18:05:46 -0700 (PDT)
Received: from localhost.localdomain (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff694sm215442b6e.3.2024.07.08.18.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:05:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] spi: don't unoptimize message in spi_async()
Date: Mon,  8 Jul 2024 20:05:28 -0500
Message-ID: <20240708-spi-mux-fix-v1-1-6c8845193128@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
References: <20240708-spi-mux-fix-v1-0-6c8845193128@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Calling spi_maybe_unoptimize_message() in spi_async() is wrong because
the message is likely to be in the queue and not transferred yet. This
can corrupt the message while it is being used by the controller driver.

spi_maybe_unoptimize_message() is already called in the correct place
in spi_finalize_current_message() to balance the call to
spi_maybe_optimize_message() in spi_async().

Fixes: 7b1d87af14d9 ("spi: add spi_optimize_message() APIs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e715a640237..e48c2fdd7204 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4436,8 +4436,6 @@ int spi_async(struct spi_device *spi, struct spi_message *message)
 
 	spin_unlock_irqrestore(&ctlr->bus_lock_spinlock, flags);
 
-	spi_maybe_unoptimize_message(message);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_async);

-- 
2.43.0



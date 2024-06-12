Return-Path: <linux-kernel+bounces-211430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA56905184
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1571F23474
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027316F0C3;
	Wed, 12 Jun 2024 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drj40tje"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5726F2F0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192573; cv=none; b=rNRR7LEs7R2QTStSissXGScr+mNtwG2Imj53YhAUk+IH+bfikqI2xRLRIkTD2xyxgm2DCGW1CmlIkv6wrkVKQ86R9cL5R7y4mcMBBjexT0GXLVK9VbFsXqrmHD2lh2J2zANayA5jFemAqhxSGmUuhTxKnqAZiUwKUX4WYPzfrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192573; c=relaxed/simple;
	bh=VG/5YfDV7FzQQEF4wHeho7hrq7jCrMwvwvG6FPj3wa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YBEsDUtveq3tCexwwbjKvGoXcGHjoTK6JcOzyMLQHU1DvMcEtQQ5I0DwtSUK+mCAp98M26l+1HkTV4nTljoO7EKPp+h4UTx2plztERTqTcySodpAbRWP7OaNN6qUzA/UZlpLt4aQM+rUMvLgw3nQzzFGITcZpG6uwBaMgw+ePms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Drj40tje; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso2451934e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718192570; x=1718797370; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V13PpaB3KG5lDDATU2PKoVfvcPruYli8QLq7z3xJ5/U=;
        b=Drj40tjeW+rcgn70C7wu6aYs6rgFWjtyJuCV8QOfQVvT8rYzZrRHpVK1S47EJM/tKj
         EPWWb7ZV7A38b4HFcVh669uIbGkEnosnqpuqeaaRTg1VowvKvl0LdmlqmyhpoNxTaO3L
         MIQNcT7hfgYMiWvPK007VBKHSd4Uc30ZBtFJrSYS+PtIuffUmVO1M0pwhQ3CcVrPuWLY
         V6NsIJXyTpZahXBVzb9zZ4shNJutIY5g5X3fMI3NB6sfr28+GTKAeT19aNWTmMQwCNLj
         FnJVhHeZhG6tmhtJLkKl7OGUE/TzDjlwJT3li3H+ZE/4mKajw0erINfb7Av/9n+ZINWZ
         5kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192570; x=1718797370;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V13PpaB3KG5lDDATU2PKoVfvcPruYli8QLq7z3xJ5/U=;
        b=PsR/pwGXh65TRtzgoZ1SOya4Z6FrriliOeD/5tuwsx7/InCrmhbPVS5ZX8IVA2mgEY
         RjCcACuY/8ndc0fW3l8qB7j9Z72N3i4Xrm93YjAPSovQ5OLfq6tXz8YoHSDbHoWjJ5o0
         oDPkR83U1JmYXNJivWg6k/uypN6zl00FdQV5ssJPEO7jsGWja0bjpp7yv6xHHHrItAU3
         n4i55Zf/uzSAizySlnX89T6GSuylGdGj2JmdrONvCE8JJPJhIbZgDR8WPZa3RY2Bv5E8
         NY4NkyTIs897oP2p5t4ItVHQTMixBbFSj9Itn369iI2iNOOh8XuRPn00KXHCfQYpAKyp
         cMiw==
X-Forwarded-Encrypted: i=1; AJvYcCXnSRs9L7oamBATX8KoxgBoR3yDtJx5SR30F4w5S5kXQESEaaCWOHf0A/YPWSrU2geg5lpwvz/R1UIIDjPHqwdG2Jfw44/i+fS+Jz5g
X-Gm-Message-State: AOJu0Yz5foZuvutr/1vzWA4/h49J8Zp31jzcvtszOUKZf8v2iwOum/I2
	t/udon7/KfzKrhvClMosXiIBI/sU+uQkxZPV6DxJJve3eiFqXTG9
X-Google-Smtp-Source: AGHT+IF6fsMDT2nFRaVS9efV41RZSEW4Qabj198Zt5ClgPDF8Mz9HxiqOsadHVEocmaQEpwu3Rqt+A==
X-Received: by 2002:a05:6512:3d1f:b0:52b:d48e:32e8 with SMTP id 2adb3069b0e04-52c9a3fd878mr1068065e87.45.1718192569743;
        Wed, 12 Jun 2024 04:42:49 -0700 (PDT)
Received: from latitude5580 ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c82f8cab0sm1664147e87.31.2024.06.12.04.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:42:49 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:42:34 +0300
From: Kalle Niemi <kaleposti@gmail.com>
To: Kalle Niemi <kaleposti@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd71815: fix ramp values
Message-ID: <ZmmJXtuVJU6RgQAH@latitude5580>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ramp values are inverted. This caused wrong values written to register
when ramp values were defined in device tree.

Invert values in table to fix this.

Signed-off-by: Kalle Niemi <kaleposti@gmail.com>
Fixes: 1aad39001e85 ("regulator: Support ROHM BD71815 regulators")
---
 drivers/regulator/bd71815-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index 26192d55a685..79fbb45297f6 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -256,7 +256,7 @@ static int buck12_set_hw_dvs_levels(struct device_node *np,
  * 10: 2.50mV/usec	10mV 4uS
  * 11: 1.25mV/usec	10mV 8uS
  */
-static const unsigned int bd7181x_ramp_table[] = { 1250, 2500, 5000, 10000 };
+static const unsigned int bd7181x_ramp_table[] = { 10000, 5000, 2500, 1250 };
 
 static int bd7181x_led_set_current_limit(struct regulator_dev *rdev,
 					int min_uA, int max_uA)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.2



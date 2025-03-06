Return-Path: <linux-kernel+bounces-548603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354EA546DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4666C173B8B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02420AF98;
	Thu,  6 Mar 2025 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeP4T/se"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAC20ADCF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254521; cv=none; b=PvtBfitCuWZ7MRccfgkpWVUXTptzKJlDw8opqxvS0OJ39nhpLCZjrHf6rWX1+mwIkCF+ZUUuaN4w9o8G1caugaWIuTZ5XKOCtkrDE64gM1rvgqwlGZmnu72CIRri1sTwXSHAC7H5lRSuMQPXSJf6JmP3khIqDSpOgRR3nJtwf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254521; c=relaxed/simple;
	bh=RJEAUzoNnPjXojDrx1lfGnTyV5utsglqX5RvWoQNM3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lZfcVUjRzkvpdomObbYi5LyrdgdIx508H3fOLieK+FibrY3aP/59Pb6uhF3R6Nc8aBgrRHhz2fG6FTByUTQtkWPJeqaAEyFoM/Gfdu8wgSOiF3kRHmE4OXLtzEs6IkkTqT+XonYtvozaa7nzdGjcAPdlx1nmmOkLzyNeMBstMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xeP4T/se; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43690d4605dso2583725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741254518; x=1741859318; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYb6T/3vLosF9o5q+Y5UiX2/6xC2fpf9CrlM4eItM9w=;
        b=xeP4T/se9LH8ndz4Z61G3FKvdCQlcnEL7DSi6csfa3TbdnIlLsFbivnOiwI1Du52kx
         cwfkJNoXXCMgUIMq933n/oyyXy4rgdFz1TGw+s2SsEbe0aUc8QhlUl2kTOF8V5N6lqfd
         96TSlKT3SbAGge8aINCkOHiekbL4M+Q1BJcoqclUmJEUya1DnT8wrPp8R36aurMHnWkT
         zgtps8ModMJYBrO4Qzabx8Z39Z7KocHwtDoikxTZH2lV+4pwCWRP5k5wqyqHyzuQEdj1
         8zdZeThdz4AdE+0qfmgpqpSFdofGm9EZTZ1DcNyAHe4H46CPrFMa06AWTZQndp8ndWM6
         bPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741254518; x=1741859318;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYb6T/3vLosF9o5q+Y5UiX2/6xC2fpf9CrlM4eItM9w=;
        b=mXrOOdh+OZdLozagdC86Wr2NPjaA0PYOk4HzfHROfATmIJFeI7hjBoxZ0nxR2xQkd+
         Brp+1BfWm5spOZrDlIDdEEex41j6AOc5AnFhndFkx1foz3zLXVR5vXyF5MSZIcyJn1LD
         N6zx3XUrR59TaEYfDnQUVXrYazIBKfRehMd+ODRt5EPyQ8woHz71pvasuaMn4vUcWkTY
         zPDrlfqLChnJ41ueM/QHozn8pHclNzMxX2Zax3R7YtKSTpk1jDsTeRwF2RQwu63iIf1j
         ZvEWBHliior2V04rUupEZLVfjs9hqTF4CkoWdffy10ZbFsGhtcNLNH7/wPJoGt/lWQey
         VBbw==
X-Forwarded-Encrypted: i=1; AJvYcCWu3T5r9cXYt8lUyw4BdQQBB34V6emdP3qH+vSQ+zNBx++1+M8En60Je3kqacUSI9H6UwQYWXrTuc8o6iM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjR7XHeCt/8ykF5/HNIKTD9USsZchTMAfHM51HwndESDN8iRSz
	LX4hceaBoZW9N3l9m+P4MJVM0TomH+G46MNcA05R9o+OAC8umpydOVHC4ThC9hs=
X-Gm-Gg: ASbGncuIItO1Gevry4KfUaxD06tkLsOMoUDNRDruMq2C2YJXt7/6ya2uFF5faIeiwdl
	YZWGzjpIyus93MhtBoW75uu002YXjFZqXZvShyq6h+AJ4El1BtRPrbgX+G5MmZXkZDUHKtA+34W
	FaUNODeupU293Bf9dPVK1w3eSRGvqHB/Msz8hXj+i9BkjzSHBmr4CzvhANp6n6ORQLZwl6sddeS
	xogb3cXv9da9MGeYo0Ta9fr58guLm2Iw4HwzNvhJL3C0gF63OTkP4ckkXwl9oprWcJiccr+X/9Z
	+7UM7IS74K0LPCm/K8umrGy8h6Mls3psA1CYNeVod9mMlN5wRA==
X-Google-Smtp-Source: AGHT+IFBd/ryvsqo4SuH5AoV+P7wyT4wM81i1izptWSUavGGlpTSK4T7eUmgeLPy3GMlZioDo8QvWA==
X-Received: by 2002:a05:6000:10d:b0:391:225:9521 with SMTP id ffacd0b85a97d-3911f7bd8b2mr4846113f8f.38.1741254518181;
        Thu, 06 Mar 2025 01:48:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfba66esm1527318f8f.18.2025.03.06.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:48:37 -0800 (PST)
Date: Thu, 6 Mar 2025 12:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: stm32-ospi: Fix an IS_ERR() vs NULL bug in
 stm32_ospi_get_resources()
Message-ID: <bc4c9123-df43-4616-962f-765801d30b4c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap() function returns NULL on error, it doesn't return
error pointers.  Fix the check to match.

Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-stm32-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 8eadcb64f34a..a544d7897edf 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -835,10 +835,10 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 	if (rmem) {
 		ospi->mm_size = rmem->size;
 		ospi->mm_base = devm_ioremap(dev, rmem->base, rmem->size);
-		if (IS_ERR(ospi->mm_base)) {
+		if (!ospi->mm_base) {
 			dev_err(dev, "unable to map memory region: %pa+%pa\n",
 				&rmem->base, &rmem->size);
-			ret = PTR_ERR(ospi->mm_base);
+			ret = -ENOMEM;
 			goto err_dma;
 		}
 
-- 
2.47.2



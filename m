Return-Path: <linux-kernel+bounces-416154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9589D9D4101
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B4E1F224F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DBE1A7265;
	Wed, 20 Nov 2024 17:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfNnSeAA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E64156677
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123142; cv=none; b=a9QRYsjuZU54Qv98XRyZD12tAj8kG5e/Xz8qYbOT2hEatJOLWW92kaub0O6vxd5G7j01OjUhwes6eU+MFPIU58ePV8/qOOU6W3BhifCv9LgRhEaRY8rDNKf4pbInCpkxocExzj5KVUHEiOr6/I8l4gfWEvaxRjwxa07gncZZohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123142; c=relaxed/simple;
	bh=VMLOhPH//1FlBQm40XRhlKtuyXZJpKN5xaEpPTsmgEo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=US7tkgT0FKl+pqMzqbooyvV2EdSeudpvhvQMIP7OXLZPmv+TYGQP+lw6W+YBmrSWVaWOZLTQXIFjW1OqE6xNP7ae5KENA8itmPvHfsSo1eu226s/7qQOZbCIdPiIh6xj/NKZfxamoIxX5zYdE1rRFkB7r9CEQt1tI5ct6CA5pE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NfNnSeAA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431616c23b5so7178315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732123138; x=1732727938; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6OIt9APg7rl+6VkRZLbtxcfZxEjXQpmkc9A4DcorfhI=;
        b=NfNnSeAA3JAcyNjibjkiJibFQOpOIgKVLQehyHA4mDeZdXgZdbkFRAqahvq3WEgIA0
         zazLGur833j1m07fHuebMFQT7s6kYZLvpo9oc2jUdTJkKtZw8c2nhEe6L3/GjNdchY90
         ebC1zlSXJ0QtbbOGZ7ZlfMkppwMbSJY2z03wRrWNEv2VmkcfK2EzM7hBtrocYrK3FiM2
         qrynHfyEinlpKo5oUrGDnDmBZiDPoWHacPwGN9sjmWXS6kUeLpkmO3hfM17Q0+U0aL0J
         RcT9EfFhop0N0FtKNQ0pRigXVw5ToxIMMIf16m2Wir8IIq/8tC7Cro8S86franiDL59G
         YOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123138; x=1732727938;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OIt9APg7rl+6VkRZLbtxcfZxEjXQpmkc9A4DcorfhI=;
        b=cXxMRdSrSor53k83MyvT0Xu6Z601rdSQNrnqYvU3wvQUroAJAkDA4m/3+9g1EkiMww
         HMcOIe7Mu6di4+NTUuz779rUn0XM7f7vz3fFI0NtIfDdxtO537fs+C5Xr94VicXyl+NZ
         OSxSMj3yYOiNk/kQ/9PjYm0Fgb60GlOuHpdixd7qbuS2OnGEjJjGeXNgLGOU51qPg0Fe
         KMoKcBb5Jiv+htr5sstIikZU4JEbGKL/3eMJzKMf/yAAvBnA08sxvlCi7Zndz3fWYHjN
         0zED7paNsN3NzpqfRaTWlJJQeVrqsUY5qS05D9J/6DsrENDHQCOa2BkDoW4wTuFSQ0pI
         ICnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaqiv+jHhEUGGCxepwNAw6HCRJwaAsPPbPBDUI9+cpE/K74f52xAhPr8X75bMZOiahj2WziJQG48Kirwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1H2oWM9q6L7mVlAJoLge3WIAEdXs2CoDDk0JVQ+J07vkPFB9U
	ximbvDIYyZ0I8WN8njDZLlfabAgOJOCy8HEduzG7Shzz3PhysayGmUWW4jEOVXgzOZ5RTQP+Q6N
	L
X-Google-Smtp-Source: AGHT+IGN4jnKaNwqn5jDQ4Z0JFaJ3NGwDCLW4eL8iuhhfaD5aFK+WN+J+O55z5TrORF8zlK6Mk84zQ==
X-Received: by 2002:a05:600c:b85:b0:433:c463:62d7 with SMTP id 5b1f17b1804b1-433c5c97f36mr1677635e9.4.1732123138455;
        Wed, 20 Nov 2024 09:18:58 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4633b5csm26761585e9.29.2024.11.20.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:18:57 -0800 (PST)
Date: Wed, 20 Nov 2024 20:18:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] clk: mmp: pxa1908-mpmu: Fix a NULL vs IS_ERR() check in
 probe()
Message-ID: <5b3b963d-ecae-4819-be47-d82e8a58e64b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_kzalloc() function returns NULL on error, not error pointers.
Update the check to match.

Fixes: ebac87cdd230 ("clk: mmp: Add Marvell PXA1908 MPMU driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/clk/mmp/clk-pxa1908-mpmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-pxa1908-mpmu.c b/drivers/clk/mmp/clk-pxa1908-mpmu.c
index e3337bacaadd..90b4b2488574 100644
--- a/drivers/clk/mmp/clk-pxa1908-mpmu.c
+++ b/drivers/clk/mmp/clk-pxa1908-mpmu.c
@@ -78,8 +78,8 @@ static int pxa1908_mpmu_probe(struct platform_device *pdev)
 	struct pxa1908_clk_unit *pxa_unit;
 
 	pxa_unit = devm_kzalloc(&pdev->dev, sizeof(*pxa_unit), GFP_KERNEL);
-	if (IS_ERR(pxa_unit))
-		return PTR_ERR(pxa_unit);
+	if (!pxa_unit)
+		return -ENOMEM;
 
 	pxa_unit->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pxa_unit->base))
-- 
2.45.2



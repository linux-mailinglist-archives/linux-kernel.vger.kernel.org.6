Return-Path: <linux-kernel+bounces-324359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BBB974B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA6E28D1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B1113C9CB;
	Wed, 11 Sep 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6Pr9ngQ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E878C9D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040406; cv=none; b=lsYeZfzshhrgwYH0VNhMKCVnXjX2jYVlOkk/wwKUy9vyRiQ0KmRwtEcjTaT1GSPC1elS3OYg0z/xFKZrAgzjFQ68760iKYd82jwsF9BAPNNa+IARr/x8EUh3kCKD0Ubr2x18da2hKqqyidOU28dQbAkRQR6PHcgWOg9JHvfirNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040406; c=relaxed/simple;
	bh=mD1x8nHG1g3JEsBBm+z40nPQ/B6nXDs/HRMrcAOfnQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u0kwYTf0fPJ27HFPStEqKqCho1Rd8Lf4JpKlsAhHaqcyZYjUFcouFpeSBxoRRFsX5mKGicZqztxTo/BP/Ad3PNkZeLpL+arUVtyzlzMM1Fza/blD53w7ux2H+x/D1B/aj6aRGhhQDXcwaZLjYEqyyuByKemBv/aox//UjiNhAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a6Pr9ngQ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374bd059b12so3967714f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726040403; x=1726645203; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Vm+jEHhLAKPjaWuMJ4d76NlcE1THre8Dm/y67wAWD4=;
        b=a6Pr9ngQ5DiKEoc8nx/pp/ypjOuZU5NjJ+r2oOiqcKjV0Cz+Jmzj4SRxw/KmL4BiqI
         reISonqkiUfOcYcUYoBA0PlJ5rjX6vjmVNHqgPl7+QrmI5/b+lvw23E2ZDTTl4mdK74c
         OwCrLacZO5NUOMcEGjFJW/PCVNJ0aG1F80tGp1t1GbWdf9QdeHF5HNDLGOxIuOf0Rll3
         AQGa0pMi1BO8pXLAAJiSN4iBCbH1dBRelJucAj9kVXT3nyAz66SiXMKFyDca20IMVxY0
         EPcLrsrmvdeVeWzU7mcoqxCDDbzG5Qi/i9Z70sbRGgPIdX2T+u0fIL/AX97FAv3+yCd4
         6shA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726040403; x=1726645203;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Vm+jEHhLAKPjaWuMJ4d76NlcE1THre8Dm/y67wAWD4=;
        b=mN5CwBXiqSIY0lSMxyiZr1MrHc+Esj0eb0ZAiD5zm/wfjdcnDwtg8fiZAYqI7YDp39
         t94ceTOLCAN2VfjlDBXhebdOVp2CrlJE4kzhJOrjbsriFA0+cSTlTdRttJSeA2VmLtnw
         /Tdo00VuZzwuzjw3W5gN6T8KbNpB1VLEURO2NeJlL+4AlQNqBmQneuwwzSwXEHSaKDsn
         IrVNDbjvra7Gt7OS1+LHXovIjWuM94FlDaEpkvBLOhcUDmmvLJAB8CvX8/ZdWYhI7W9O
         oaIAekHSyFObOKR2AbcD0w2KV48EwUWTyoZkc4iy7G25lhHkodqjsio6ZQHLsecEHt7a
         IKCw==
X-Forwarded-Encrypted: i=1; AJvYcCX5qKBFFYnQGt/mj9rzbp3gxl5cMYjo5Q0NUlw/W3Ozf9uje7hexIu2hXyEzBLbWGOh4h8h5ws+cKjuG2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4XW0ye+yPlBzIewetRbYOkVmehL0qbudUSeE2rXsFWLOvuZl
	F0zSNJSpsiCkdI/82ejvhho7VKMYMuzzduwQ0Y8m3UZvFcPqUJWGj7/UVqgeM8mpDnRF7U2bKL0
	O
X-Google-Smtp-Source: AGHT+IHoNK+/nUMKYaelXKxN8yhTKmMxOo/BiZURjSF1S6UHYQvazTlTL0voyGPl2bhSF2Y66u2XRg==
X-Received: by 2002:a5d:654e:0:b0:374:c87c:6653 with SMTP id ffacd0b85a97d-37894a6bdf2mr7336145f8f.59.1726040402949;
        Wed, 11 Sep 2024 00:40:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca7cccd35sm151748545e9.18.2024.09.11.00.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:40:02 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:39:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] perf: arm-ni: Fix an NULL vs IS_ERR() bug
Message-ID: <04d6ccc3-6d31-4f0f-ab0f-7a88342cc09a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_ioremap() function never returns error pointers, it returns a
NULL pointer if there is an error.

Fixes: 4d5a7680f2b4 ("perf: Add driver for Arm NI-700 interconnect PMU")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/perf/arm-ni.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index b72df3aea93e..90fcfe693439 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -603,8 +603,8 @@ static int arm_ni_probe(struct platform_device *pdev)
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	if (!base)
+		return -ENOMEM;
 
 	arm_ni_probe_domain(base, &cfg);
 	if (cfg.type != NI_GLOBAL)
-- 
2.45.2



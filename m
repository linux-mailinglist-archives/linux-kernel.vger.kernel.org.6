Return-Path: <linux-kernel+bounces-561807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E3A6167D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C533AE7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3226204588;
	Fri, 14 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UND6oMNs"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5D92036F6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970408; cv=none; b=F7XIwsj/BsxVwiX55mZzgfGIoa9EE8fFIJBFk9Oz3XDvKF3ZNIaQFnyt1h1eyN2qmAPSImKk5zBXTg0s1EeiPDoFTcIbzqTvk3uApZng3Y75mQpNgamOdnx6HWcN7t7bc6PSEF4VTreX0V+BCrEgPVmbC3DoX6fBS9VZUATwsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970408; c=relaxed/simple;
	bh=W7OrtNale60JOsrxsaBAlHsDJ4WH3rrsx+Tnb7U2MME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gTTDazBG7KlkMfDOgf9udPa4oKk+HL2ypiG1T0l7ydTLpuR1wOFN83PRD4Y5J5MDP82HsaE8FYkYEMbTqo/wmiIfjiA9kwZ5wQ98SVlY4nWfgZsjxbkquoj6Y9WDPR2IvQ4WD+I2wOc7syz/pN2gaeZi/PM0TFJEdm4YI6/pqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UND6oMNs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so4299540a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970404; x=1742575204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FqlKsxagPbT76Z6CLNAsMWFx/025f7qb7NuOScguaQY=;
        b=UND6oMNsPyx969ds3VEUYTRVcHo0xohPWHSOWKyD0LAMM1xJO+h777IilgNxOefsWl
         qkiPetbmfP3YUrr6nfVezMjIweY97GHkrvNUjLFNPujSx2ucXeOiuhZ3HU9sn+pSWpsf
         R0Ji6fu0WvFFTg0GCx1hY1Dws3CsaJDSEGw/KZvHDZ/BZMrfL06iDH+BTn9YpCjKdekG
         866WO/Oo+iMhfYzlyxv3kRA6uq+J7OAYd90WkBqwUESSMtvf0yjxBJeCvRnwFz5JeUUc
         uyfntCkdEiFIw0RR0fc7cKpnqcaUjXT5dnveLaT10OeG3W4oA51I8N7L1445pq4QvBeW
         cUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970404; x=1742575204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqlKsxagPbT76Z6CLNAsMWFx/025f7qb7NuOScguaQY=;
        b=fM+O42O2sfyOnViuljzo/0ftEyRPNp+gQNo9MgbFTQ3fpBohAbksy9cYXbE/DfgY4k
         qGrKWp9ckfCfYEa+nAW6XQjZBUTR+xC0pM/JIs16On0hwgEcPzEUxykXSJwBorVO3Nba
         h3N3s0cGt0LXWbABb56dsBw2qFu6zj0boL79VUUU1QNvxfJj0KN9dlNt7XIKlhgLb1+o
         Uacpeye6gl9Y5AuDGU6PuOmvu5045fkK6lJZOgA/ZYRAYZ8rBhoToKSkZJZDbDAsayme
         9MAGvGhcI0pvkjMsTOciKlZmX+LNpcxonz+8P1yexe9KBphEJhpGFprGc2v/Xj+VSFyQ
         ky7A==
X-Forwarded-Encrypted: i=1; AJvYcCV65O3XXNoEE60oXbJd4wGsFqk7JyBPGJ7d7SXT6yA+c6jy5lRU9DCx4I3UNi3Lij5ULD9biR6NGMGoGIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsB0qPagXy6lvvmwcuyDiJBqxRjt65fgGegynT7HcLr3c8PGRt
	LjDjL4rZbFp/ZH0KCVfdeZe5NHcXaeDLR3qnehmfuOJUPHOX+BNFOWGezJoNPNM=
X-Gm-Gg: ASbGncsqmLAfCBmzGqSOQOT+auNJZt6YDCfhvMBbOz2Y/+/UQ6MGYiTLweeHMheyre3
	JCGaEM47fVMx8CFrSKVjaTcfwzzFWILLcLfi4Nokscju6eXW24/WALIqWLRoU3szLB0vWedUIn8
	etd3LaIl86G/c0TzQ70RfqgsEOI59bZO4/EKhoJ1RY3mNwm5LKpX341yjh6BmQhbUtHsmFxVXCF
	26bOTwdLbN3WhZ5v+cgxTC4Zdd1h1yh8HL+zGmVgcIJ0Qr8cKqlFNKtZoKfISwV7Wk0HzoAXLDk
	CR+tXZIANlibBzxRWJqnAcDXLFQ2sf2VZUcDIWos6ttdHMZBhT96k8BZK3zBmxPFPjTmWYDqt7o
	MVHt7RsJ3aOBuRIvGH+EbTyuadV1b
X-Google-Smtp-Source: AGHT+IHLsxwF/DHZEPhOyEzlgmcKjsoUUujUnQwnbW8+qgc574E5shkDM/HanOkkYGXBGqTnr36IXw==
X-Received: by 2002:a05:6402:254d:b0:5e6:267c:a6bd with SMTP id 4fb4d7f45d1cf-5e8a051fdf9mr4301988a12.28.1741970404463;
        Fri, 14 Mar 2025 09:40:04 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968cd8sm2115727a12.18.2025.03.14.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:40:04 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 14 Mar 2025 16:40:03 +0000
Subject: [PATCH 3/3] firmware: exynos-acpm: convert to dev_err_probe() in
 client API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250314-acpm-fixes-v1-3-ab03ca8e723f@linaro.org>
References: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
In-Reply-To: <20250314-acpm-fixes-v1-0-ab03ca8e723f@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

dev_err_probe() exists to simplify code and unify error messages by
using its message template.

Convert the remaining dev_err() in acpm_get_by_phandle() to
dev_err_probe().

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 48f1e3cacaa709ae703115169df138b659ddae44..03f907a95c6acd66d89cd8af2f52e7c6dadf492a 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -701,12 +701,14 @@ static const struct acpm_handle *acpm_get_by_phandle(struct device *dev,
 
 	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
 	if (!link) {
-		dev_err(&pdev->dev,
-			"Failed to create device link to consumer %s.\n",
-			dev_name(dev));
+		int ret = -EINVAL;
+
+		dev_err_probe(&pdev->dev, ret,
+			      "Failed to create device link to consumer %s.\n",
+			      dev_name(dev));
 		platform_device_put(pdev);
 		module_put(pdev->dev.driver->owner);
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(ret);
 	}
 
 	return &acpm->handle;

-- 
2.49.0.rc1.451.g8f38331e32-goog



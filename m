Return-Path: <linux-kernel+bounces-554011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0CBA591CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BB716C992
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543122A4C2;
	Mon, 10 Mar 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCwiqut4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E2228CBE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603726; cv=none; b=SzxzEjG60otq/jhzW+TZMAMEaOnmOeL4F3dSLJfy1PAltM+Xasj9gUwiN5tRbBVKx1RY/n1meUmrT2v/VbVbw4ZSd5WwWY/p9RZUXdYtExlpE6AmwFAUhlljoRPd6p62R3eZw2eTpHSpkSyvsr0C4H4Rkfr83nEdR9L+mZV1Sxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603726; c=relaxed/simple;
	bh=ThNQa8FfIWCfCjBqxfnY7Y6HddW97gUTMSNhwoQo/9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cHIGovU101HJLo1nl3zAkOolXFNE8a4nsLDHQNr+0B6htPDpxO5tUDw4P7YuYzsfX4d7zxknkpg2NlfuzT6mQnpeXxIRtOoDn4Uq1m7EORmCjeEMilghsJD/iUVAQtcK76esQJIGmb8lguF3w00woJJjHMr7QijzJKBvKNe2bLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCwiqut4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso8474285e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603722; x=1742208522; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4FBTBE+KNOkM+Qcs2aGG4D+zzTC9l6YOpjrjTql9Ko=;
        b=QCwiqut4grrDAhnmpyyWOGtoPFSLlO6LwON7v336QIUYd6H34bIxpWF1qu4Cj5u6Gu
         D4exXJWcPTqAN/BTxUscdwV4Tm6W162STr8QWJGPyWznqJXEMllOCwgQ8Q1XegGwhWXQ
         Kqf0pjumGWzC6WkyHEgyvIlWbXhHLrN0zUfSBYSvuUOHtumBcwWb2kDmez9mYMwadwze
         j7Cpr8cnrCvJj4ZbGQ5G1/KnnSwSP+pgnJvTbnW6SRYt3RNzppGwxwXkOudvDzqChLZI
         uAKKBdNTbqIiIpvT3FPBiuKdJh7ETxQ+G2J3OR1wWDvb+m6WQuisczeh/lYtUjtw3zs7
         /zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603722; x=1742208522;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4FBTBE+KNOkM+Qcs2aGG4D+zzTC9l6YOpjrjTql9Ko=;
        b=BCN00NUY0e0l0AtqkuoYXGxSE2s8PocYQNDRY841fKc+7blY3wbzMWH0FBaxbrpsc3
         S+qA7L1foe6xmDvhBpIBKOXN2MI6B9gR3WHoIy0Ekp5zylDV/djv9nSxz8TWjNMGkASs
         FxYGF5WLGNyLsanYAVaYMrLHp2IlroME5JlqT0NwDw6NiRcOAVN9ex0K48WVSpBzIShj
         EEApnFmnTrKhHn8lw982O6ycKjSn9iTpNydlhbDE6ehaZS1svLDNwr0MEDlqfz2Gk9Y/
         tgY6+MrqdX2UFooE/a3r+SCfWufN+/kD+1PCFNl//iRtzLPn13iy3GUYlajhnue8weqD
         7Tzg==
X-Forwarded-Encrypted: i=1; AJvYcCXPeGQC1UOXpkEBATOP7+FG6FlrD4WOMxBAy9dkzRNUvgeaz7phK0nqysBlw2t43EWc4I7iWJAbRle1Rbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9Sc+WKj4FrZuHYX9N/i6vWVClUIAnKxoyMHRA7cW8hZng3iL
	q/t/lWTS1IBCdtvkzP8HikTgnmSl1MboekOp7auqi4yAOZFo+p5mcmTlephdAm8=
X-Gm-Gg: ASbGncvLwb2mHM2ryKYMG4sK/1Bc66ZEz/sRiyzugcFEI6/5CyFKmdFjSJIyOWPFWbv
	XZaFXCtWcuBTwnTwVQZeqmujlCrw0ggJumZVq/ZDZDYhOJ6bzBpU3/YDxG8ZAl6xzDOgn6vAtpQ
	TV62/mcaTudWmDWJFEODyAZfYFaEOjtUtDlcSEsrwEe87vLSRQkprbBa2EUllNsvfuCNwLBM4l0
	GGjH6nHvGwEYrKvUrgWNy22/zs4nhf/YFhLvydpNlzqV5GYTzek6FAi7fx8v9OYpJ/+ZqetEl4s
	17ir92ZF9Iho88eJWmgHqLFWfsptCJd8Uqap+9fNSUA5yLeWKg==
X-Google-Smtp-Source: AGHT+IETFwDZNdnH20Q7Y3z4UlrnseZbh1WDkk70tSsdvhJaGXXT+NyRi65tIbPyOgQrBEERRB/G5Q==
X-Received: by 2002:a05:600c:510d:b0:43b:c0fa:f9bc with SMTP id 5b1f17b1804b1-43c601d93e7mr74449995e9.12.1741603722155;
        Mon, 10 Mar 2025 03:48:42 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ce3f573f6sm57354855e9.0.2025.03.10.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:48:41 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:48:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-gpio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] pinctrl: bcm281xx: Add missing assignment in
 bcm21664_pinctrl_lock_all()
Message-ID: <dfc15d59-7fa9-4f96-aacb-37c3df6d420d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The next line checks if this regmap_write() failed, but it doesn't
work because the assignment was accidentally left out.  Add the
assignment.

Fixes: 60d69769c851 ("pinctrl: bcm281xx: Add support for BCM21664 pinmux")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index 7c8f8bd7da12..9ea20fde3a24 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -1498,8 +1498,8 @@ static int bcm21664_pinctrl_lock_all(struct bcm281xx_pinctrl_data *pdata)
 				rc);
 			return rc;
 		}
-		regmap_write(pdata->regmap, BCM21664_ACCESS_LOCK_OFFSET(i),
-			     0xffffffff);
+		rc = regmap_write(pdata->regmap, BCM21664_ACCESS_LOCK_OFFSET(i),
+				  0xffffffff);
 		if (rc) {
 			dev_err(pdata->dev, "Failed to write access lock: %d\n",
 				rc);
-- 
2.47.2



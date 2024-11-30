Return-Path: <linux-kernel+bounces-426171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8785A9DEFD2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A95416314D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261EC155742;
	Sat, 30 Nov 2024 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcAq/0oX"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C091537CE
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961250; cv=none; b=Oz9NoYfH5xyIsq1jj8FaI1POauIdhPmUgMBxd01eUIIslvNocZ9o9wJ/m1SpI2WDkgCsYXPSLJbyqFcZtVDFskANcQDnVgzk9Nx/XD6Bk2pPOc0rH0jdS+CTaHY0DmSREkYMWHcEKsRtcMsMrgXmoP3sfIsxbh6mH3so/mNXNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961250; c=relaxed/simple;
	bh=R+Jgx/e6IiVY0ZpZJeWh0nRjB/zOm/DuktMO1fY1cTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QexsnwM4xvWoW7ZCnHDJfrJ0qz8+FN/gOVevvr+dCwpcAeVJ65Z2r5O7yrV8oSALQ6pCHpi1egMe8cpyhC7R3HwqdIP/ue9OtRHdGax7K8GUGEvGhSZXXDbm/ZLIhFRXB0Ejb6V1xHq71GSlLxmTvNs5IzhtuzCg6rmXNyFUSg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZcAq/0oX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa560a65fd6so456070466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732961247; x=1733566047; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3IOEa3AQiadqfvRPE7ZHtURn1mAXU3PzuocV6bnPJs=;
        b=ZcAq/0oX7C8KVYG/ZNEWGiq+rODl3cW/stpoSOxufwo+VTslKfcHeFABBy7igwICUN
         YssiZ2pNY6Z/NGNPlWyJbisSS9MBPs91L1rO86BdyyJiTRdfmgB3FXxSQ4yq9EEX2sg/
         OoNlcHOtLd6jfWZn6R3FDyIHQhrBQm9dGFUvQUn58d3f4Hq7WXhIh3TIG614ubAn/zQR
         ez0pe9Td24qrcbTc+r59kUQeeU0ShIzSlnx2dhvMX7vsDRAyuhdTatDdXbJKCyvctgZM
         qKBTe6nRDTbKxEJNl4SAG0eScdO62k1GlI8vpHrIy8Ax58JFBN3korfX+uEewUpC1oyJ
         R5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961247; x=1733566047;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3IOEa3AQiadqfvRPE7ZHtURn1mAXU3PzuocV6bnPJs=;
        b=GL+2dg3L/dN5Of8Yz2vSsPJ0mWH3VEF3QVF1rfYOE6/lGkjSjQO+zt57WcKCGbbn2T
         dgFRyBbNu+xSxdmP9UZcYWTkoEPA2eiRMT2DiyRYewVvg6NxZ4mTJ9FBAU9MPm7KAsIR
         JDe7jv3UecTWIXcfRMCssI50sEdGYF4iVjiv8cTHPA4LHVFInSVhq/wWbv0KUvhxEPKL
         MBxO/RgRfqvaJpEaQGOGJ5K552s49szWka3eHnyDRCs7/INjsFSY638mzxI0YERl4aJE
         iIlBnjudlVi8Gw5TGv/+Hnl7F6YZ8LI3wQ6oqnSX2WzrKjMp8tsNob5J4OQp7k9N5yap
         NP5g==
X-Forwarded-Encrypted: i=1; AJvYcCUF8QFCTszpDoyBi9wiY1z+M27dWmFj5ewEG01XWVRrMU2a8sQ/urlU0ihih2HY/ReJ/W1dwbA19B2WEaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5z+aRTSS5UTncMeRpTztqk+Oho5+C2snl3MJfxlFQcqIYumDR
	c5n4AZNF556HDYqnsXhYTrXn0SdN4WhQkE8pExka0gXR66dVF2BQqHLGwv7U/EQ=
X-Gm-Gg: ASbGncthGeKdGLl3bafRnldsd2qK23O8JkralRHIvxXen9Uh+cRQvugyes0r9p61ygx
	pGVE1OYKyt7qe//Kf4OA65GXWNKAQgr0j6+WS4BzIWoYktmMd4MBMNEv+pFGcbbxCJIQXAenirZ
	239U9VC6GggjCX+RRvIUGgqPICM6ZJzKGc7B1PTVBes1WRKDa7ocpZjFb2ChH5BDZFL+nGClNDn
	ql8w77Myxt9L9XeJDnTk+GjRq8D9IRamFtojmr/ERbiFWXgK3pzwH0ZMIt6XW4iXpJbhuad
X-Google-Smtp-Source: AGHT+IGEehsqRqqchxpEeMpH2p56+C1aMQS6P8kLj4wjLRwyQQPVWBU9FOYoHm9xPFqfOvMYDmrCvQ==
X-Received: by 2002:a17:907:7ba0:b0:a9e:b08f:867e with SMTP id a640c23a62f3a-aa5945dd02fmr1077135366b.16.1732961247420;
        Sat, 30 Nov 2024 02:07:27 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a783sm264103866b.171.2024.11.30.02.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:07:27 -0800 (PST)
Date: Sat, 30 Nov 2024 13:07:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Daire McNamara <daire.mcnamara@microchip.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] mailbox: mpfs: fix copy and paste bug in probe
Message-ID: <9e760329-80ed-4bf7-8d4f-dbb16a736497@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code accidentally checks ->ctrl_base instead of ->mbox_base so the
error handling can never be triggered.

Fixes: a4123ffab9ec ("mailbox: mpfs: support new, syscon based, devicetree configuration")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mailbox/mailbox-mpfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 4df546e3b7ea..d5d9effece97 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -251,7 +251,7 @@ static inline int mpfs_mbox_syscon_probe(struct mpfs_mbox *mbox, struct platform
 		return PTR_ERR(mbox->sysreg_scb);
 
 	mbox->mbox_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mbox->ctrl_base))
+	if (IS_ERR(mbox->mbox_base))
 		return PTR_ERR(mbox->mbox_base);
 
 	return 0;
-- 
2.45.2



Return-Path: <linux-kernel+bounces-562528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B9A62A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA427A8D7A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F041F55E0;
	Sat, 15 Mar 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2wa5mKL"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922BC2E3377
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033071; cv=none; b=l6kjCk9rItqfL+RhUFiEStR5z9hjxHqgZRbHBi8hEMVkG+80IlNmNhVmLGJGzNcc6dDCw4CtOH69sxryga1fnRBVDulIKjpZ/szRS17GcnGCaE1xuetWvOHMfAoDjzqLIU0yFmW7TJ2/398xABciM/+yPwU2QwNVV2hxVkZH3ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033071; c=relaxed/simple;
	bh=Jzfw4uS+2xNHSt7CL1zvCanecwXZCQddc4jFWIgRqxc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s1i3JRnFE3E5GvnYNLnvbaMoqj2ShfCyca17JS24qVFK0eNPAUXB5ibbOSg155+XJsqbT0gGYGwsHfdP+k644e3lotFboURucxx1Cj76AGlcobiZyb11t3Q5L/11e9z0TZzAffFzWkysM7wSmaGyFBxPTbLNPaX+vcRYNHs960M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r2wa5mKL; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso2470535e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742033068; x=1742637868; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ome34xzBD6ytuYkcLvh0hzc1tsMwWzkshxKre3ePFs=;
        b=r2wa5mKLhJJvxdKhng2a0DPJKyBFH/H6HWY/AXEwv9ak4OS4SVbGlGxAwJ10UEIGZC
         6ImPZUBk5gQOd6ZBZjNwElFLjEh3mdfOXj6HEMttysQ6scvRI0uP/CTiMuFHggvVIUPW
         df4nuFdEYYCauO/9tOD7MRxt4cFMW7l2Eub+DBf0rXlZqO3bKq8Inytt27qQZXmw/CQ/
         Bj/kdFAELlqYU7mbQOqkPuDL+wmrIjRLw8qX8+sN4vLuXpw7DZPsyD4M0m2mh8BNTbJm
         u3/ltC2CiTz1/STc946lTd1UhPE4d2Mc8r9hzcceuE0K26IOiWtO+IqmzMzNehwMN3M/
         4nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742033068; x=1742637868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ome34xzBD6ytuYkcLvh0hzc1tsMwWzkshxKre3ePFs=;
        b=HzT3+R95dw9Ji/+O/wp9l5iaydvjpth3JK2OrZd5cOH4sqrfwoXjYiCDBYX6lh9CuO
         qWZr9whTXPHzwUFCcZB/v9mbjSs5pA2h/gnCY82e6/geDR8KJN2uZEmoNNWKojFRJYVA
         IwrE/54/rK3iwxhwISS72i+FCfxRKcupW2entloYDc/8PLxagGsm/74X9wzEpDPcgK3Z
         R3wCsdD3pEAUDm0bzqWAOn4z0DsWR2TEA9+v4J9q8+sL4soRvJtqDo4C4suhEfG4SOAa
         23rRFR2On4orWB3AsZqLuDwM1/GP5BJdcoOrWeNtrNkwX0Sln4eL0FWE8X50tS8zGg7D
         6E2A==
X-Forwarded-Encrypted: i=1; AJvYcCVdTHZHak6MaFfUIdPmqg4h1xmZVdz2XenzdwdKNncEkHnqq7uloYZNjk1Kee4JXrZVq+sZA+popofFIx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytcsLnoKIXsCozHk7c+wRcXSY17bRedyqIER9nfy3ID8iW6LqW
	1/fwA0chH8+LI1Y594ZpQK0kuh201VuagINHYTEelmiyAFusJnBuTWvqYnDbKEo=
X-Gm-Gg: ASbGnctOzM8Jkyawe0U+juUjMypqcpTWtPzFGveGHOPGnui9fsr/YCt63gQWF0WgB3I
	b+xt8hBxO/s9JsR80gmqWAxPXkgzUDSmo90KkygBgtYP4wTFjQwVT2uTwenbxI91/FnlH49X1Kj
	W5wInVKLChewDv490gpuy2WOoROIQyM467pWu6WDFYPKmy1GM7ekXi8/VWXKPoASQ06tBs8HIHW
	ZMRqvKqAV772WXD0HOMT09JmaOL9poDGlqJzDqaeZ6Wzf4HfWFOXwr3uFEHHl54I8phLr1tsn75
	90ruLlE2wvHh55dh/kUUcWW2so3d2za/pgAHPbjgnubTxenRxUGbbIU84Ty0
X-Google-Smtp-Source: AGHT+IGe3a17ib1rZeRVb9c77roGjaqcKEfvjE/17j/FdHz+4lRmpBlGIjmzzYo/ezgUaqKEpaF2wg==
X-Received: by 2002:a05:600c:3515:b0:43c:f5e4:895e with SMTP id 5b1f17b1804b1-43d1ec622ccmr51862355e9.1.1742033067870;
        Sat, 15 Mar 2025 03:04:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d1ffb6292sm45076095e9.1.2025.03.15.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 03:04:27 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:04:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] firmware: thead,th1520-aon: Fix use after free in
 th1520_aon_init()
Message-ID: <f19be994-d355-48a6-ab45-d0f7e5955daf@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Record the error code before freeing "aon_chan" to avoid a
use after free.

Fixes: e4b3cbd840e5 ("firmware: thead: Add AON firmware protocol driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/thead,th1520-aon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/thead,th1520-aon.c b/drivers/firmware/thead,th1520-aon.c
index 4416e9bbf854..38f812ac9920 100644
--- a/drivers/firmware/thead,th1520-aon.c
+++ b/drivers/firmware/thead,th1520-aon.c
@@ -203,6 +203,7 @@ struct th1520_aon_chan *th1520_aon_init(struct device *dev)
 {
 	struct th1520_aon_chan *aon_chan;
 	struct mbox_client *cl;
+	int ret;
 
 	aon_chan = kzalloc(sizeof(*aon_chan), GFP_KERNEL);
 	if (!aon_chan)
@@ -217,8 +218,9 @@ struct th1520_aon_chan *th1520_aon_init(struct device *dev)
 	aon_chan->ch = mbox_request_channel_byname(cl, "aon");
 	if (IS_ERR(aon_chan->ch)) {
 		dev_err(dev, "Failed to request aon mbox chan\n");
+		ret = PTR_ERR(aon_chan->ch);
 		kfree(aon_chan);
-		return ERR_CAST(aon_chan->ch);
+		return ERR_PTR(ret);
 	}
 
 	mutex_init(&aon_chan->transaction_lock);
-- 
2.47.2



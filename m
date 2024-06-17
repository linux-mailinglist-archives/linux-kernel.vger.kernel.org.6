Return-Path: <linux-kernel+bounces-217013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DB990AAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC76B26000
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC432188CD0;
	Mon, 17 Jun 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbqQOMOP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60B192B88
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616880; cv=none; b=Hn+qMyWDDHz9GzCinuAALfrNS0E0r/dndH3NbvGfVNnqKIZo9qc8tunIOJXE014YtYrS/QKCCdQx1j2ooWCRAdQ2RavuxriLgJjqQVj+jBgXQ0efrE0t/PyUg9DM01jwMtVd8VUTWA/j6km4kOkyWgoT7JBvRynBC4Ku9CfW7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616880; c=relaxed/simple;
	bh=eQ3GEmVfz/NFFavQ5n+cPs0wp3Jo10dh1DwRVPw1aME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FHPjcpmsOMkw2KCrVsg/YHOkX1zwVf79vCTcr4ylgigg+k6P9hN9m5temB4OeLmnhuZNHqQiwXBnDBOgJM2HQVWJfabMb7GTOJToH9EKDPh6yqj0/6kHXkYzPj7ZR+s2+DRq5TXVXeZuMHeM3QjXn8N2LsGP4SKErjaGJEUBPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbqQOMOP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c4b92c09bso5547715e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616877; x=1719221677; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZqlfzq0gqd8L9nHKEtDudKTVJ2RTjWVZ3OJQhA6rBE=;
        b=PbqQOMOPL+ZjqEOB2y7P3WMc7nwjms/hKhbpjzmpBdWoX8Wea+u8Md/MMdbE67z9Qa
         fUe+RmpDytiSpJJ/2M0rdzFXPAGtl5aSjzJcn/mmKDkAzVsUC+ONIiyX8DEVkgXvbK/n
         LvmLsAcz49Vn5PGl6dU1ciOkqJ4o+zuChoCZuKEf9LS6SDBY2UxaGgqnpXPS00GL7V5n
         2p2vuLpVI+WzhymLz6pivD0YrI0/ROB1NeMLBIUT5MW4ucwei+Pje+ZeM9nHo04x8489
         0rIxiYByQrNgkJ8KHPlPjSKDXK3BXkt16M/BZ7+dqyGK06e7BGmlBjrFqcqiM1Y6O/vH
         1/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616877; x=1719221677;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZqlfzq0gqd8L9nHKEtDudKTVJ2RTjWVZ3OJQhA6rBE=;
        b=X1CNVNlQoFf/0ouHZ6tg3ahm2dgk4qIaTwV3IJTJAnTW8lTOlmJ4ECZvEjCgGJ2/wf
         2eGQecaDWKCMbbPh9w+waK4NAoc5eZMQvNgJlFzQGHONtx2XQswiQuuIo4T+IcL64c3T
         YfTd5FAMKiBuDmaOvE/21rPTAeW9+6/g0pkDNaKAHP0lUOvrkOd8leoQlsdGL7bjoB7l
         t/QF59hwfkakM2zv8t7UazHmrwz2o42sTXOZMpPPz42C0YAGwxENzw4n41SMmNfHWKWk
         dtXPabwIcCHIe06boSWAxFWoj48usEhHrDbDzTQJHurBvTtXn/Fo0BlnSMC+C58KGVsl
         5inQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNbXJMwP667X5yM1HmZN/0l8OVIPB7RvB9HHyViyzqIS77UUpjsrvYYF1DM3sMt1BEbrERbch3jw9zb+0RYWQk7Am06s1GLARqGkPR
X-Gm-Message-State: AOJu0YwUApd2rDzREZzbDTWuG9cSNIEHCV9bieY2P+FPrm1g2Uop+Jo4
	c6mzqmr3ZALOVP5db12s++snoNp1f52335KjiZ61qqrzD55MyQqogoaFTA70BqHnqPMM49SO4vL
	t
X-Google-Smtp-Source: AGHT+IGTlennQ1HIxAYqKG4+OH6QB/vWUXrpLW9Q5q5XLEK9WNED7iZgfkSiN+EXrJNQbyVatzIneA==
X-Received: by 2002:a05:6512:1c2:b0:52b:863a:59b4 with SMTP id 2adb3069b0e04-52ca6e6e576mr6799194e87.41.1718616876583;
        Mon, 17 Jun 2024 02:34:36 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e0c2sm152224985e9.14.2024.06.17.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:34:36 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:34:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 net] ptp: fix integer overflow in max_vclocks_store
Message-ID: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

On 32bit systems, the "4 * max" multiply can overflow.  Use kcalloc()
to do the allocation to prevent this.

Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: It's better to use kcalloc() instead of size_mul().

 drivers/ptp/ptp_sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index a15460aaa03b..6b1b8f57cd95 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -296,8 +296,7 @@ static ssize_t max_vclocks_store(struct device *dev,
 	if (max < ptp->n_vclocks)
 		goto out;
 
-	size = sizeof(int) * max;
-	vclock_index = kzalloc(size, GFP_KERNEL);
+	vclock_index = kcalloc(max, sizeof(int), GFP_KERNEL);
 	if (!vclock_index) {
 		err = -ENOMEM;
 		goto out;
-- 
2.43.0



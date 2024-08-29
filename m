Return-Path: <linux-kernel+bounces-307539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA2964EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2871BB2268F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B721B9B36;
	Thu, 29 Aug 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2t5myCD"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669015C120
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959373; cv=none; b=Ye1ZcCG+atnuNBoH3MtE3KfVeJ3xROoWC7E2jbkQlo5hrVW39d2u4hg3dlt6rv1unhusx7jmrq19HaDbyUoiULgWNNPdp7TkHR1I2wBsfWpIdB2ZqG91JWhXakJW/8Df6cwP0spvMhpnyZT4MgGxZQypOyiZkAscxytYoAXT5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959373; c=relaxed/simple;
	bh=Rw3/jwjSMxQMbf9n8gdI432rmGXkKg9i02Q3u0710Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fV+Lnkk83A4MOCYdA3+iKRjpkj1w7xzoPji+X+Wj7oTdMEe+/8m7bKEc24DQkuC8FvAU2kae+ZLAxBsqIa3dIkcVaOCtT0u8kuuJloYImkRNv/cnpA6+48G5jccxpjWO7aL5U8ywe/+M5YLRD3mfD/9lVj8i32dXyAeSzT9eOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2t5myCD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42812945633so9185225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724959370; x=1725564170; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMkm+29lh1erc5fAAFWmKKqMqM4uFrG7ZmX40+JvEqI=;
        b=p2t5myCDmLikM0u0IAPYYIlYwsTm2gEsoi14z470Vlf+1KU9iNMxHA5Yj3tmHyHzm8
         HiT599LvPXnZykalIt4q83iJW99ZvLBNMWAnIpipRrOr7N4u/EZM53xtBwUgtgay5G4y
         1Zxs2cR2/2ZAvqqQSfPHBtECbi/WBvO4JkdpkoJHuRt6q5NB1guRtNL0VpR0n6q2WiOw
         2kr5FmtmO9qUeU/5YDYag2/HohuCi0rH4k5b5QdiKlSJbv+NVqE+uWs2rk6y33PU0tdj
         ZWssi59PaYBLgc3EEKwluewDVHbilW0SC4wHbW2ttKGdykd7tDiKvj+lwy525WMnn6B6
         7RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959370; x=1725564170;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMkm+29lh1erc5fAAFWmKKqMqM4uFrG7ZmX40+JvEqI=;
        b=GqWIUJe/QBtruGSZMPtm2m9akQN5StkEtEh3DS7iuIChT3Wjl4ANKezeYrQpEUwSaV
         tUvWX+FvZCnQ14TaGfMcb3+RKMnmszHc6LdJbvm1+q2LAm2qfZa6onPqvSdjy08Iv2Eo
         7mzvWAQgRCZRMiw0JLhYW65cfQIMvXfAReS755SGlkGuyXvttaYBLsDS6Pjqv4gEbFEc
         nFkgGTU9O6Fpl0N7nDh5EHxipcMhPmnnNOsthZ3ZB2s4oyLXS5UZD6cCy73lxz8k/XFG
         QoVB74dP3j2wNpV0RClu0UmqHIa2oOCI6r9VKyYcGUFUuz3MNknt7SfbI6EQAnbL9rEU
         b7QA==
X-Forwarded-Encrypted: i=1; AJvYcCXzm+f0vulS42s5DyRCyFrOuVCoXDOUfdzNukXH1QMqsubfnpK4yzYmFIyG/M6WJyP6wGmBoNk9iJ1S0+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIp9Nm7TUgNN7NHAcf482xr+Uo+uDFOiDLXAtHwnE8EyGMw0o
	/iaUgcQDnBXPRUugvVIS7/O7FQKEBZTUTneY0NvdwxB0BdOEHp5/JqBuV2xSAZk=
X-Google-Smtp-Source: AGHT+IFLYl4gny5GWtr+JnUznytxaTDe9bdDxbaWEeIcz0+3LIEKDrXH219LvTPhwALagT9PKwLE3g==
X-Received: by 2002:a05:600c:310b:b0:429:a0d:b710 with SMTP id 5b1f17b1804b1-42bb024db40mr31712775e9.12.1724959369673;
        Thu, 29 Aug 2024 12:22:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efafd65sm2124567f8f.93.2024.08.29.12.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:22:49 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:22:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] igc: Unlock on error in igc_io_resume()
Message-ID: <64a982d3-a2f5-4ef7-ad75-61f6bb1fae24@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call rtnl_unlock() on this error path, before returning.

Fixes: bc23aa949aeb ("igc: Add pcie error handler support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index dfd6c00b4205..0a095cdea4fb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7413,6 +7413,7 @@ static void igc_io_resume(struct pci_dev *pdev)
 	rtnl_lock();
 	if (netif_running(netdev)) {
 		if (igc_open(netdev)) {
+			rtnl_unlock();
 			netdev_err(netdev, "igc_open failed after reset\n");
 			return;
 		}
-- 
2.45.2



Return-Path: <linux-kernel+bounces-326214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E5976505
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D305D2842FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FB1192B61;
	Thu, 12 Sep 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaJUlmOj"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49018FDAA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131434; cv=none; b=W15kGUlFZ2q2A3ZHPOV8dxGt3yB4HZmwamFbXFBTvT2q+gWialdrOFuThgrIXjqO3D3eQilMqUWRFPq/2L+5UXJSSoNP5MHpz3j14CqKuDAiF+lwv8Gr58OozGNhGeuwSXS3mbDUqjL4cXkfkrlVkMWKCIbGHVxGjVW6VxREXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131434; c=relaxed/simple;
	bh=DjtjHEGrvANFI5B9lVHCDNbOIvLuaXQEHlBzxQ+GrD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUOtMojwiiuH0hzUJRZDJagUa0bMP5ZqRZmy75Qw7njQWnGzpP6/oSkRsfl0kLhkba1DYG6R1eCFjinCP1vc1ygf41cEPQp9iuL8PAybhyHNGNUPmEUJ6uvX+SS3ltof5hzVQt2BZKleFqFfTNU1W101CkQOsoYUuR6z0+NT/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iaJUlmOj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374bd059b12so509987f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726131431; x=1726736231; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GB2egBmowzD1BmyczzI/bnYTjW28edWluz9NwGsMtk=;
        b=iaJUlmOjKxDaMOBKXtRgFCUWa40wevVN/1VF0qOP2LPqgM3V/Pm3wK9BWcnMcvXVVX
         wwZLl9ppQAqOyrpjQcXXy2EtzQch1FpNI6EGviMX0spfdUSq0N6A76R5W0i/lEUfrMCc
         egMNVdqdA6njVK5NifQlEcik7tOfraRcXjOpCg2A2190xnrQIiAKIdjQS0wWiXKLtvOM
         OW9xyQelGI2Q9/bp+lsfFcVdIBoIbsjvbvE+vh647IjF+37r1VD7iB5Agg46KLQcM/0b
         i8PcAgBZ5WGH0o0DKACTpRD6gX6pbtY5b959biMB+S36UakfqFUaNbpg0eMwJzqtwfz+
         WM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131431; x=1726736231;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GB2egBmowzD1BmyczzI/bnYTjW28edWluz9NwGsMtk=;
        b=aPysNa/vH1jUgXKBiRb0v2XW8ph99MHLJpGGnrwYgwfDIQhUrPg9WAfF1S6io8+Y9b
         QJhBhWb77OuqyIpw6SefvxkE173iwP5wEAr9oZaay/Yx8FL2dGcImhzTQCryR9JY9dj0
         2cVILYav/6gSHpWiV2Jv9m3Q53kH1Jhj+tGWRoOfrTi/33URP60CXXexa3uN1ARP7sBQ
         Prk85lzu1VU/94CeVoeXkiilKxskU02+t4jFRTbY/BHUz2uq4IWcumMGkBSMLUmWADFg
         NXCD15nNvsQdYPCHSPsl6sSQGjJJ1W360pz1v+WsSE0PxU88Wxr3bOIjXu5SqsoZ0SK9
         4phw==
X-Forwarded-Encrypted: i=1; AJvYcCXotwacOWEGrH+uvEqo+RaMDHkDnvEX6/nfT3NZd4Vrh4FLmrbqnJqDxtq8uzHXCYB/pycthjPjM3UgJuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7baZsvJtnQv4088c0LFDcFfk8R9RN+rsziUK+SbQMbTGE319y
	fASLB40IFguUvkv44UA+hZRRxILktF/HsoB/LMZVzDfH7NFzEx9ozowo1B4fkp8=
X-Google-Smtp-Source: AGHT+IEOtJzJsuwuqY2oaUeNN42g94gx2ZHs0ZQuD1RVXqzgi2ozhnck9PoCMtBGjepfFwTy/BEe8Q==
X-Received: by 2002:a5d:65c9:0:b0:374:c793:7bad with SMTP id ffacd0b85a97d-378c2cf3c57mr1155356f8f.16.1726131431260;
        Thu, 12 Sep 2024 01:57:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789567609esm13746480f8f.59.2024.09.12.01.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:57:10 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:57:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Larry Chiu <larry.chiu@realtek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] rtase: Fix error code in rtase_init_board()
Message-ID: <f53ed942-5ac2-424b-a1ed-9473c599905e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return an error if dma_set_mask_and_coherent() fails.  Don't return
success.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 7882f2c0e1a4..ffebc67cba5a 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2023,7 +2023,8 @@ static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
 	if (ret < 0)
 		goto err_out_disable;
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
 		dev_err(&pdev->dev, "no usable dma addressing method\n");
 		goto err_out_free_res;
 	}
-- 
2.45.2



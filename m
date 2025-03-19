Return-Path: <linux-kernel+bounces-567398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F5A68575
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681993B87D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E22248AF;
	Wed, 19 Mar 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCDmltXY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DB211711
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742367997; cv=none; b=bU6VUti8gTNvVw9Q6oDiOTZobGV7GHscT2EJZwgOMpvSCk1HCBOtTo5nnjWJcRZj038JWv5qsg38D/kjS7yWGJ2sIi5xTSrWBWugdPyKm1m4t271whL9zRt8LzB/pYFwrxz3KJVJ/RPUw67DVhqofMCOqzyPFVM5/Mq6Wtse/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742367997; c=relaxed/simple;
	bh=nQq/HfwhbxFMClvYRJ+B1HeOFHIj8bJ2yd+p/lUMno0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j6Or5Wo7PV5kL5E+RqETxqOQ8zwmBwwVC9Oo+5QVUt9zCWQkseIQevKZkBpK/7v4COv1mrNZgBBe/HYiSCyrsLgYRF1qYidyVZbIo2v1ZxZOaxxjrUZ4m2nx6mycwniUTpvZBBNrot6sp/nJ8PPS/GHHH8xH94KXgC8x6gylAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCDmltXY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43690d4605dso28366245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742367993; x=1742972793; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7b6xgdmoV1Iom089HH2CF+DeQzDZvROFfj09QmtCOhw=;
        b=sCDmltXYBvSxXjj/f9PzXElP96/+basLSgi6VNtybPQPUCCeKdC7woYipb/N/qZwBd
         7dMwlXgEAJ9B6UrcdZdppu7lfZj1VdcmG5ly/6gWK4L5p+FOX5os90TPb5bVOZLgOXQU
         9btbIVCHqltpdxPv7vvZSujfixvzlj3ykr0KD48+nMYJrzWZQ2IN2jkto5nNlnQsBXW/
         txEZPtYEBHbSOkyzrRoXtnw+tdDjR6EpcSdspHG4Vg8lPqzE5gyW0Fpon7k6nvaasxoN
         llKCsNsGWxa4LSPg18vSrM0bFvaXlvSPm9eNJdRNEQpRVewm2teB7wsxr6yTqTO+rNgb
         Kw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742367993; x=1742972793;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7b6xgdmoV1Iom089HH2CF+DeQzDZvROFfj09QmtCOhw=;
        b=fQCZBaKZaTdAbKxKrYfuCFfSwtIjYOAstJH4+QJcm5f/keKvo1jAA0Uuy3fb5M8i2+
         yV5EYU/EqESR3+wPeZfrr24eu5e6ymIN/4ufxCnyRhmfi/AvvY3/xRkJXKRovjJF2eRS
         lvPXUuwj3+97uFoy4w+7wVOm742R5XPnrTVEAWZRvMMAc5yL/tERfh0UCimHxiZGqA00
         FyRvleEUPcJaMsHPSbSZKslHPtwHifrkz6bCTCD8ZltFkq9la4p/nAIgUL9nTOVYJxMh
         cyx8wUNH6+aN3ljPH17YkGI1puGG65QwqDEnCiyUHxl51ZLdIHdUEIkHqKB4hjBYkHIs
         12hA==
X-Forwarded-Encrypted: i=1; AJvYcCUIA9R+C2apQ3mp/dNiHJp74uWaJe+lSEHAuoV+rorM7HYq8E79Zb/Rs5CMPXIL5qoFDgKwOeU8VpcoTrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMbJxx74nLeAXgMDmT9CtJ2nNscVHLdX+heMs84ey/xM7+z4q
	AU1RGeNjHs0fBH5waUycFvW+gDYGZOXUzf+7BhoNYoHXL/5VQrXVyOGYjgo9u64gvbsSVc6oWJw
	S
X-Gm-Gg: ASbGncsb2cbWmacHgHd+/5gnP89oBL1qMvS1taGAhEX1CRJWgYispbJMGNoDLXTSiT1
	YcibjQfgx6IXf5BlUrutwJnl3d+rgtM2QiGIBdL9zFmHCC/XqXa90FSnnGLPEAwjqgVClCXEpUx
	poemKLUJWXKgRZ3PiillmujvwM9UsqiZfujBHWCQTHkRqNr3oj0QMKUYO3KGdooxFd/q2rnQdrn
	wLa6Qnssyijfa4szn7j0+acrz26npb/2GjnmcxQk7Pp2NxB1NmtfVx2TIYL/zjkAA4aih4VqDZv
	h9s6zLISsZrDsM9Jc6iBQXum2IT3rsAH18LuRWG3pTw4J7m4nA==
X-Google-Smtp-Source: AGHT+IGHvK3obNd7t+NiTomb5dTMS67ej/nVFhpk+PbB11o3bsjXScaBpVaZHw/Msfo4YN+kqmNl8Q==
X-Received: by 2002:a5d:6dad:0:b0:399:6dc0:f15b with SMTP id ffacd0b85a97d-39973b0487bmr1262415f8f.48.1742367993471;
        Wed, 19 Mar 2025 00:06:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f4542dsm9787965e9.15.2025.03.19.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 00:06:33 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:06:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Brett Creeley <brett.creeley@amd.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] pds_fwctl: Fix a NULL vs IS_ERR() check in
 pdsfc_validate_rpc()
Message-ID: <925355aa-c98b-4fa7-8e49-b97f6d551a86@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The pdsfc_get_operations() function returns error pointers, it doesn't
return NULL.  However, the "ep_info->operations" pointer should be set
to either a valid pointer or NULL because the rest of the driver checks
for that.

Fixes: 804294d75ac5 ("pds_fwctl: add rpc and query support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
---
 drivers/fwctl/pds/main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index c0266fc76797..a097fdde0b55 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -255,6 +255,7 @@ static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
 {
 	struct pds_fwctl_query_data_operation *op_entry;
 	struct pdsfc_rpc_endpoint_info *ep_info = NULL;
+	struct pds_fwctl_query_data *operations;
 	struct device *dev = &pdsfc->fwctl.dev;
 	int i;
 
@@ -287,13 +288,14 @@ static int pdsfc_validate_rpc(struct pdsfc_dev *pdsfc,
 	/* query and cache this endpoint's operations */
 	mutex_lock(&ep_info->lock);
 	if (!ep_info->operations) {
-		ep_info->operations = pdsfc_get_operations(pdsfc,
-							   &ep_info->operations_pa,
-							   rpc->in.ep);
-		if (!ep_info->operations) {
+		operations = pdsfc_get_operations(pdsfc,
+						  &ep_info->operations_pa,
+						  rpc->in.ep);
+		if (IS_ERR(operations)) {
 			mutex_unlock(&ep_info->lock);
-			return -ENOMEM;
+			return PTR_ERR(operations);
 		}
+		ep_info->operations = operations;
 	}
 	mutex_unlock(&ep_info->lock);
 
-- 
2.47.2



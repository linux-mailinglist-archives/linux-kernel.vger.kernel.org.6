Return-Path: <linux-kernel+bounces-554028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D91A591F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777C616CC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5590227BA7;
	Mon, 10 Mar 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJhUanvB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AA21A44D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603923; cv=none; b=mlABxq19bQ9MUdPNkqu7qwYZabxyxZ0rvLh1pTyWmHLqkQzsoAXKnzHc56Oc7ikGCkILlUlNL3qN/P42ivBoHeMPUb/ovpgLfNYpXz62ze4AyRU0zbqHb90le9VvCfQ7LV5uZrPK+FL8dQOAkCZhzq3gbedKtUaDE4uXqdWCW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603923; c=relaxed/simple;
	bh=8pFmW2yF7XeBHwGWpBOIVO3bVuCA2uTCoDSKVDixUQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EALnCc6Qo1oLc0fPxElLt+TeXZOzvEoma32OzPVK3yNLmGkjlxoUt5x6I6CqxE3pOpVBeWoROkj1tQPqr9bPtGNYq5Kf9yiQYpoe1cmegCA+SSjwrRf3xFT4ktMgO4kEYSjUKpA5vsuHcnYt9XJuEbmEe3FaNPLemYXyDuG4DAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yJhUanvB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf848528aso6524155e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603920; x=1742208720; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRaYsvVFrqrTjWbVoLzSGid2k7c2/yuWbrvy6P2VIxo=;
        b=yJhUanvBwPoRt/h2J7vQjHB4pn0Y8MkOwza7TUr08zWjsZSGX51/pXwgo4wxqVp+iw
         0YrjbJeVENhg3FuMpVSFBENnWeq4/eKkL2EKY6V6FQZtzGyxciZISKizq267RQzuCBUZ
         6J0Q949WXQxDxhayMaCxWgH+5JbIvdLFvratTq3H7ZtaA6qGnjy8Uejr5nUypboH6ryk
         Y9MqoASeMZiavmeX53rBJ6FfJP185C+fw/x9qqPINjsy79IIzd1AdmqhzaXDseIjXHe0
         bTto9+tziiSCw0IlGvt1mLkxyATSRBCK0CzpDDTOZp7DPEdqF4qCCyt0g3GWA9oqeD1p
         L5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603920; x=1742208720;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRaYsvVFrqrTjWbVoLzSGid2k7c2/yuWbrvy6P2VIxo=;
        b=nnLl47sBoe9bcLptYLthFGJ4uhilZJqQTjQsyEaKbd4ZSLm3IfVtcresIzcBMsaYiE
         6W+rgBBoZectL0taF8GamTBxkexj+4rWs8r/xwwxeAjQ5rPXHKaH+/MEANQR04RWmtdZ
         IIgW+30nOLjSek1zbZENkKW4aNXbmJJsiiY1mAzFSrXVPViuhktrJpPNhZzgjH6Np5j2
         2/9U5Ynp3whdNGs4rollDCjNwIUU7wB9czaedf8t+jLoegO0+JPQU87ipocquG8VVq0a
         NiF6Pu1jtTxE1jfd+HPl0XFupERvXQ7ZtzDTyRqVkI1H9UIDLHFN+Y8FeUEt+AcvbUYt
         jnbA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPsIk1UBasMlvmd0tUq7gwCo1yTtxcmnHi/AzZ1gL4WESJBLQQjqGVyUuPpdBRov8t4PghJqUklRHKaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdT6BQ2Xe7NpMYwe7oG1MiRliBbgwXXp2vHHL13+u84+PbZ7Z
	huh9AQ+Y+TXhURiHcLQGHrb0BsLxoQZqDOZnKzXFlHY3y5J/yQuaEk67OGomxDU=
X-Gm-Gg: ASbGnctkGu28V/2CWZL6WcY5OdtK7MCRMQ2mBYkT6J7+kI40rbLIZA6mQG1KbMb94vc
	8gVaTd4lnQbcuUxdYNP2dUevqphpWxECIVL8xT6w5vCWwjmOLpuuc9saZSQvK5/pHUVAJ1sAqmJ
	a2XxVxiBPGwEBbJZEfE8RISUgVnJlgleCNoG2DwgJOcz1f3xL71GmNmtXcJd7uYAtONJ7qaMl3O
	5ItILEDrmly0/FsLt39lx6OeS0H7TGHhqKL7WSPjnFuiQgnqhFRJQk8XXo46Uk5PK/pbdoUbzji
	kqq+E+VpZCLFFACGn73vPu37xsIf+YRI/dYVLrnnYokPVkZKdw==
X-Google-Smtp-Source: AGHT+IGMN8eK8zmMhyTnMEO8hcxY2G1+yaEB1GlPZwSy0jRn7v/TP69/lWg+VAd4stSNCOgX1BzcIQ==
X-Received: by 2002:a05:600c:1d08:b0:43c:f184:2e16 with SMTP id 5b1f17b1804b1-43cf184310dmr30775335e9.5.1741603920329;
        Mon, 10 Mar 2025 03:52:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ceed32e64sm59063525e9.5.2025.03.10.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:51:59 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:51:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Patil Rajesh Reddy <Patil.Reddy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/x86/amd/pmf: fix cleanup in amd_pmf_init_smart_pc()
Message-ID: <43ad5358-f5b2-4cfc-85b4-e7ab8c7cf329@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are a couple problems in this code:

First, if amd_pmf_tee_init() fails then the function returns directly
instead of cleaning up.  We cannot simply do a "goto error;" because
that would lead to a double free.  I have re-written this code to
use an unwind ladder to free the allocations.

Second, if amd_pmf_start_policy_engine() fails on every iteration though
the loop then the code calls amd_pmf_tee_deinit() twice which is also a
double free.  Call amd_pmf_tee_deinit() inside the loop for each failed
iteration.  Also on that path the error codes are not necessarily
negative kernel error codes.  Set the error code to -EINVAL.

Fixes: 376a8c2a1443 ("platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PMF-TA")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 36 +++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index ceaff1ebb7b9..a1e43873a07b 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -510,18 +510,18 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 
 	ret = amd_pmf_set_dram_addr(dev, true);
 	if (ret)
-		goto error;
+		goto err_cancel_work;
 
 	dev->policy_base = devm_ioremap_resource(dev->dev, dev->res);
 	if (IS_ERR(dev->policy_base)) {
 		ret = PTR_ERR(dev->policy_base);
-		goto error;
+		goto err_free_dram_buf;
 	}
 
 	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
 	if (!dev->policy_buf) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_dram_buf;
 	}
 
 	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);
@@ -531,13 +531,13 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 	if (!dev->prev_data) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_policy;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(amd_pmf_ta_uuid); i++) {
 		ret = amd_pmf_tee_init(dev, &amd_pmf_ta_uuid[i]);
 		if (ret)
-			return ret;
+			goto err_free_prev_data;
 
 		ret = amd_pmf_start_policy_engine(dev);
 		switch (ret) {
@@ -550,27 +550,41 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 			status = false;
 			break;
 		default:
-			goto error;
+			ret = -EINVAL;
+			amd_pmf_tee_deinit(dev);
+			goto err_free_prev_data;
 		}
 
 		if (status)
 			break;
 	}
 
-	if (!status && !pb_side_load)
-		goto error;
+	if (!status && !pb_side_load) {
+		ret = -EINVAL;
+		goto err_free_prev_data;
+	}
 
 	if (pb_side_load)
 		amd_pmf_open_pb(dev, dev->dbgfs_dir);
 
 	ret = amd_pmf_register_input_device(dev);
 	if (ret)
-		goto error;
+		goto err_pmf_remove_pb;
 
 	return 0;
 
-error:
-	amd_pmf_deinit_smart_pc(dev);
+err_pmf_remove_pb:
+	if (pb_side_load && dev->esbin)
+		amd_pmf_remove_pb(dev);
+	amd_pmf_tee_deinit(dev);
+err_free_prev_data:
+	kfree(dev->prev_data);
+err_free_policy:
+	kfree(dev->policy_buf);
+err_free_dram_buf:
+	kfree(dev->buf);
+err_cancel_work:
+	cancel_delayed_work_sync(&dev->pb_work);
 
 	return ret;
 }
-- 
2.47.2



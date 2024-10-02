Return-Path: <linux-kernel+bounces-347351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066F98D18D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18034B21680
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585F1EBFE0;
	Wed,  2 Oct 2024 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2TK15m2"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B6B1E766F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866059; cv=none; b=PdZW8CApK/eJIzu7lYCe6m/GbUtmnwblNYvHWTA/rO+KXWKWyWbeQgxwppK2y6KcH6EoltM81eQIvvXT61VS96KSaMLMs4aUFCMGICnJXCmVu40C0eqP46xFaPx2F+KWcgtLbDJxHKNngZHRBcv2A+HISPTEGJNTuOEJW8QafVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866059; c=relaxed/simple;
	bh=5KapHuvavI4Se4rczWiyFO1qFaxo3pXSlIcqLuWKHaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z0rSQs0wCItzgjauVQNpRDd0HeYYiqJvOUrNQba8B1cFJlrw0BM+rZAU0xNVysogfsTRRdKyC6OWeJcGVxpX0/E9kLSlpTFiY/Q5vYZ8yPdgwhf7O/yvx+wrskV4mcUZGdWkLo0YUy03fEAhC18eRpWUH7ohwwmudfjHgxheZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2TK15m2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so433697f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727866055; x=1728470855; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHmSQBGzytntPfgJ8o5KGntZ1Opu2hYPtLIGWQovKwk=;
        b=w2TK15m2qt0E0Pez+5UTB+LsQLt8KolG8zX4S32941BpKTm3xWgJiOmo65cHj7AVQA
         Egvg4d2n39ckWAwHcW2HFZDtaNddJNsDhBdNK0Gyj7E0ebA6J4VX3c1aTFi4FX+sOQ6Z
         2QJWgspJPdn1gSpMpQGNDbS1CiQQpZS0oPpGQMm6CWYCNZefUjkXSns4W2OSh3ckanKX
         TAfZoL+Sx8tCiJn7RZMQu6Tt3OVjWNvR6/0RAu1qnnxi4o7M1b5ksdPuVLhL9VB+qKAP
         dMEZ8/JAtIhGf/TAdybCaeNJE8WUWF3u3K7RnGYs5B3KunuVdL/+fq9j0M2azfm2t2Dx
         Ksaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727866055; x=1728470855;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHmSQBGzytntPfgJ8o5KGntZ1Opu2hYPtLIGWQovKwk=;
        b=dxMYuZPYzJAm9DKOV4Cu5YUAJVWzBvLpCTMdUus597/jY0TVieTwleaeYL02K9iEVc
         1zaHZovU8Jq8h4rQD3P8lwT4JA2uNKZ/+wi8LDOgfBQkhg1og/Yygn16ONrDKvEYg5mc
         zhudxkRDfFT9kqnocBPOL8VlHYq2s9tBVUXMXMetT4c9SCgaegbi/q9Mp3mFhX+8Mv5/
         u7nfdhA4jYCkFh9h2RsdZGZFaOBihUfhnu3Vcz1NH6cFtJ6Kk4NDs7EnpjavU0Gj9g8R
         BK66C7f4dUFcd8yxr6kQ9wOhb/8IQTfp6WjpB7G7+GeGSnl7McxxQAjW/YMyxQXkU1Mw
         N7YA==
X-Forwarded-Encrypted: i=1; AJvYcCWT08SujEA4HmRQ25VtaFMsJV7HYjPwKIPgdDkZVGoxgZbHEn/Ovx4vXp11x+edrg9+yJfqN9ZGlTnoOXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTKTd7EQZNUut5ldQIkstrbuE9nF/MyRtqt/ZjcVIIDIKWcCR
	0hN73KHAveDTfd0n4ZXpl0FDKZHPxZve+Ron6d4NbtMeet8WxxOFDaTSidHJN58=
X-Google-Smtp-Source: AGHT+IE6eEPaGebslyh86mbGsKbp5uSQnqGRvMhcY+lsSPSSBCOC5HgUEH6R7dOJhN4Pc/2QFlEnIA==
X-Received: by 2002:adf:cd05:0:b0:374:bd00:d1e with SMTP id ffacd0b85a97d-37cf289c624mr3980887f8f.3.1727866055377;
        Wed, 02 Oct 2024 03:47:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79db1de9sm15343485e9.5.2024.10.02.03.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 03:47:28 -0700 (PDT)
Date: Wed, 2 Oct 2024 13:47:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yu Kuai <yukuai3@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
Message-ID: <Zv0kudA9xyGdaA4g@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are called from blkcg_print_blkgs() which already disables IRQs so
disabling it again is wrong.  It means that IRQs will be enabled slightly
earlier than intended, however, so far as I can see, this bug is harmless.

Fixes: 35198e323001 ("blk-iocost: read params inside lock in sysfs apis")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2: Fix typo in the subject

 block/blk-iocost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 9dc9323f84ac..384aa15e8260 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3166,7 +3166,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	if (!dname)
 		return 0;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock(&ioc->lock);
 	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
 		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
 		   ioc->params.qos[QOS_RPPM] / 10000,
@@ -3179,7 +3179,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 		   ioc->params.qos[QOS_MIN] % 10000 / 100,
 		   ioc->params.qos[QOS_MAX] / 10000,
 		   ioc->params.qos[QOS_MAX] % 10000 / 100);
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock(&ioc->lock);
 	return 0;
 }
 
@@ -3366,14 +3366,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
 	if (!dname)
 		return 0;
 
-	spin_lock_irq(&ioc->lock);
+	spin_lock(&ioc->lock);
 	seq_printf(sf, "%s ctrl=%s model=linear "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
 		   dname, ioc->user_cost_model ? "user" : "auto",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
-	spin_unlock_irq(&ioc->lock);
+	spin_unlock(&ioc->lock);
 	return 0;
 }
 
-- 
2.45.2


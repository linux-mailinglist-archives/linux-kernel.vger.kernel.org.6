Return-Path: <linux-kernel+bounces-287198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF415952487
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C4D282FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461021C7B93;
	Wed, 14 Aug 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pm5s9w31"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C811C822D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669920; cv=none; b=C99UcspmpFozFxD7FuSfg8Un3tVPAlX41XRJo0XnCUB4NYgcmCwzeNS8v7Hyg+uFxRH59WjLs0oqGllXBMaejGepn7kpNv8lcGNggjIrRROWTTNaMaDnymJd1S0puwbqqOaYDH6ub6r8x5cAS/r4EFss0BL8MJ+IOScXvDYMA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669920; c=relaxed/simple;
	bh=ycPuvrttB1C6BQ1ELjYP6wzk3vRUYi3s707GVRhkX0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XE8cI69jEQdbmU6ulVyCb7hJyKYXGRL9XGODcUCz3a3hompR8C67wYhfKdQU7rnLwtmMI0Lvm+k4+f7zlKsbNEQEK+guuixI9qh4LoY6vMUiwOTYlJOaQPBLYWoXtMT1qGosf5E7Vfx0tZj3nOgGuaPycT2fu7ddZ77wFnq1llQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pm5s9w31; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so1335655e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723669915; x=1724274715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evmJCbr5KXjWqF9JXMvY5BqY0grGgRkrA3c6RXKRpdo=;
        b=pm5s9w31eZTMn7HDH2FCDvbYfN+6rH3zUEaEORXFXHT6uPqRTGJ+5JVWLnhS6M9YFc
         ENr4WdBtEcdCJym8erCbzCG28NrSXPBcuaK6A1CkO1VzgZw0GLopiiMe356K8NxjsfTX
         QHphOKLDyZgaKE9RTdnbw2ZDnlx03Oguj3Ug569iWYAAtQsD4HA7VL7by4sBjs+Uxwek
         4NZGMYddnBwDa6gr32hOgXuHTfaeibRALgHP2elJRgp4Thk2gC3244bxpHx4nHbKpc3B
         JWc9OKlEro9P3WCzNjRwzr/84SZFlBO4xAzZKE6QsuHT9g4KECSBLNYMR/zmmLGDdXbh
         HKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669915; x=1724274715;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=evmJCbr5KXjWqF9JXMvY5BqY0grGgRkrA3c6RXKRpdo=;
        b=QrnD6TnYmlXmCdPTbwqN5/Wdg5IB1GdCAPzdXo0eVEzEgOOac4TRYJa72SDpkwq0+v
         MqThqm0S5RKN6fFuXgOA4eC4Nvym7GI9xB90A+5+7HViCMFyJ1CVOhSFjBm3IgsZUQxq
         VCbRRVZjDk+ZF0yaIbRrNA87U0AFSe8F2Ks0SLNaKzc0xsrC3bhDBl/4VyS85Qw4iJpi
         YbrPMcRLfIRkk6exkhXiOfleQ6/I6s7Z7AQilPRVUSaZxEukD2mrmCOwgg1au4jFNiOu
         zDginI3lsoPwL0nRFgfUyCTZGOaOo9HZGIZO5/F46dm2W//6oD6SQmtNr0IYGXKhq1G3
         MxRA==
X-Forwarded-Encrypted: i=1; AJvYcCXCnqQYOqhxKpoGJjoASd+4yLPSIq2O608aw2wXKJXFlIieKH/zghsD6+c+fYtp8S6NxTTqKFUY61JrwhCgh+0KvpCViUN8JcREy+NC
X-Gm-Message-State: AOJu0YxS4nVEXdfe4t1bRV9/cbbRFz4ldnGaCI6rDAgPP3YCy/Nq3Stj
	IjQQEYOhf9g3TrAoV/cgY1s3d0KMu/qmU3Y8iz8JuTyHBIw6aAVYm1AdofnUMq8=
X-Google-Smtp-Source: AGHT+IG4xQA7voZvyBkrr8JmB0I9Eo6GKpbi6HEwCJE+aA7CNONDvi13+K+VQ4L/iKeF3xsGk5ywoA==
X-Received: by 2002:adf:ebd1:0:b0:367:9881:7d66 with SMTP id ffacd0b85a97d-371777fe292mr2891842f8f.41.1723669915521;
        Wed, 14 Aug 2024 14:11:55 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac2d1sm30494f8f.109.2024.08.14.14.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 14:11:55 -0700 (PDT)
Date: Thu, 15 Aug 2024 00:11:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Bhoomika K <bhoomikak@vayavyalabs.com>,
	Ruud Derwig <Ruud.Derwig@synopsys.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] crypto: spacc - Fix bounds checking on spacc->job[]
Message-ID: <3bab6e88-739e-43ca-894c-82c17e0177bc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12622ca-923e-4aa5-993b-36cee7442ed2@stanley.mountain>

This bounds checking is off by one.  The > should be >=.  The
spacc->job[] array is allocated in spacc_init() and it has
SPACC_MAX_JOBS elements.

Fixes: 8ebb14deef0f ("crypto: spacc - Enable SPAcc AUTODETECT")
Fixes: c8981d9230d8 ("crypto: spacc - Add SPAcc Skcipher support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/crypto/dwc-spacc/spacc_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/dwc-spacc/spacc_core.c b/drivers/crypto/dwc-spacc/spacc_core.c
index 9bc49de06bb2..e3380528e82b 100644
--- a/drivers/crypto/dwc-spacc/spacc_core.c
+++ b/drivers/crypto/dwc-spacc/spacc_core.c
@@ -1024,7 +1024,7 @@ int spacc_set_operation(struct spacc_device *spacc, int handle, int op,
 	int ret = CRYPTO_OK;
 	struct spacc_job *job = NULL;
 
-	if (handle < 0 || handle > SPACC_MAX_JOBS)
+	if (handle < 0 || handle >= SPACC_MAX_JOBS)
 		return -ENXIO;
 
 	job = &spacc->job[handle];
@@ -1105,7 +1105,7 @@ int spacc_packet_enqueue_ddt_ex(struct spacc_device *spacc, int use_jb,
 	struct spacc_job *job;
 	int ret = CRYPTO_OK, proc_len;
 
-	if (job_idx < 0 || job_idx > SPACC_MAX_JOBS)
+	if (job_idx < 0 || job_idx >= SPACC_MAX_JOBS)
 		return -ENXIO;
 
 	switch (prio)  {
@@ -1331,7 +1331,7 @@ static int spacc_set_auxinfo(struct spacc_device *spacc, int jobid,
 	int ret = CRYPTO_OK;
 	struct spacc_job *job;
 
-	if (jobid < 0 || jobid > SPACC_MAX_JOBS)
+	if (jobid < 0 || jobid >= SPACC_MAX_JOBS)
 		return -ENXIO;
 
 	job = &spacc->job[jobid];
@@ -2364,7 +2364,7 @@ int spacc_set_key_exp(struct spacc_device *spacc, int job_idx)
 	struct spacc_ctx *ctx = NULL;
 	struct spacc_job *job = NULL;
 
-	if (job_idx < 0 || job_idx > SPACC_MAX_JOBS) {
+	if (job_idx < 0 || job_idx >= SPACC_MAX_JOBS) {
 		pr_debug("ERR: Invalid Job id specified (out of range)\n");
 		return -ENXIO;
 	}
-- 
2.43.0



Return-Path: <linux-kernel+bounces-317148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66BF96D9FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BDD1C23C99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC67E19D077;
	Thu,  5 Sep 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fM3KtwMX"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9995198852
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542245; cv=none; b=tenaXoxMHNUN7psI4yXU4NYBxmL6PvrXbKoz3FdQsqWNOCH5CKbZcivJfNYCKU4ckmxZB6g+oOYWjUs2OKT7h2460L7oV29iCw/IPSHiQrxGSnqaTpufcxb/TAyatBHrreUVB3A/sIOdHcXzbUJKy3f649tw6ZXcrpC8IgGlgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542245; c=relaxed/simple;
	bh=7WOKCry+PgcK2CgYU9uF3wTclhygWLEcTw/JlspvEpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZEo2KKDN3vkr9ysmGQgyO7kqF8qUuiAXIscUkis9K6QkbWVgKoN8qewCUhWwkpvNww+Hl5iWukqq2s+XAMQ9EG8tCLjcWIQEPQnKTwEZ3tAObJ2A8JggVODhzgj3bmKQFidxvtLQ4nMbGWZXI5dmMiBMIGOZufl+s2NTyNkbj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fM3KtwMX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-375e5c12042so398135f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725542242; x=1726147042; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=drlaC6b9qjiLFP3rq1kjthnVypsuaHWfHNQNM9Rok0I=;
        b=fM3KtwMXl1nprdeeYyOhb051UViv1zsOWwpKc5mfqb3yyEdp8mf0LIH+lOh+Vploaf
         RisRbUbtplP1uyTouigwD9iWw/NRtRT2Jf6/yJBHG6BshcUBtWEhlv/WT2lhrzUFhDLw
         vz1h6h4aGcdfbiWKU4afhmKWXvJtqnsVrgLDtN+5PJWzlWdpVn8BdOLSo1ezbWeqiDv2
         +Nlsf4vgjAQmEbBwb8iVzezbiOYXCTLDykS5LHUPNYfqvaoQpmxovxK++bY6boVKtJo6
         /A2Zh3+SkGcOMLvMf9W2vSbZjNQgU7IrN7PHwFVAH6/QrcUXVcFxkj6nu9ne3aEbjN9l
         bEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725542242; x=1726147042;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drlaC6b9qjiLFP3rq1kjthnVypsuaHWfHNQNM9Rok0I=;
        b=EdBrSky7SzUqNDSsUI4R2ksQIWSM52XpADcpdsb+ZjnzKdyQOTb3gRI26q4CCAm/iP
         uwtg2ceycNMX9rw+cMq18vLuo/ek4LqHDPv+zHal6rST617uvqWhrb0rJuoAXWdTo5fe
         45P1McoJZ9e20HY24mAutkpV44oPAdGCTOPtyHGSERScuzPrsZFuvViECZEjyBxhAip8
         UuAkkDfj/Fh8Zrg+Ajw5MjqumC+ypSSbP7NAEpU6WT5xxjKWNoh0Ug6PWvrERY+UQJjp
         1PNgx3isbFY+RrLegJgTyP4vvjW6b8Ge7KUhJibbjOkMpP0Ik9MBeAHc2C657XVTJUd0
         p2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVceGod/gHGBKqT90GKgSR60mticqUmDBAPHZ8sejTFqT5QiUNzfih/riXuX9mc9BbYJkB8mJH5w45jxvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tZbWb4nE0ExtIn4tMSPQphL8x+7ITTjHKc+8MoveHx9uWdJ0
	IyUy0cNIOiqiv628LKit4MmnlTF8ECOS189FDPn/M1ANxZo6dd8fSFH7Ipez/Pk=
X-Google-Smtp-Source: AGHT+IEWDXdlgjsXwSq7CPnIA9hri5eaktnWflPdUTktLMLuV7xyR0shsUMVkxH5ljve0mKWgllfjA==
X-Received: by 2002:adf:e84a:0:b0:371:8c61:577c with SMTP id ffacd0b85a97d-374ecc8f32cmr7813347f8f.26.1725542241841;
        Thu, 05 Sep 2024 06:17:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm19275925f8f.62.2024.09.05.06.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:17:21 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:17:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] optee: Fix a NULL vs IS_ERR() check
Message-ID: <f8c12aed-b5d1-4522-bf95-622b8569706d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The tee_shm_get_va() function never returns NULL, it returns error
pointers.  Update the check to match.

Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tee/optee/rpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index a4b49fd1d46d..ebbbd42b0e3e 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -332,7 +332,7 @@ static void handle_rpc_func_rpmb_probe_next(struct tee_context *ctx,
 	}
 	buf = tee_shm_get_va(params[1].u.memref.shm,
 			     params[1].u.memref.shm_offs);
-	if (!buf) {
+	if (IS_ERR(buf)) {
 		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
 		return;
 	}
-- 
2.45.2



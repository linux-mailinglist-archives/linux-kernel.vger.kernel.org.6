Return-Path: <linux-kernel+bounces-287859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED57952D52
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC08F284640
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2025A7DA7F;
	Thu, 15 Aug 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unxTl0kP"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC917DA70
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720812; cv=none; b=Mu3Txjzh91qLMuW8q3DSViF3Y1Um5GC7R5+sf4PDuMfFEdnCOUECI7lkh4/QI3UdQEbqNbq2tHNrNQEu6759Uhz8YaSI3pkDnku+xNfUZ+rJ17ESECNL36j1UnSvOScpO5YHrqf9Uy0Rs8BkQ6e4Ldb3Pn7SmNrq+RC7WYfpB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720812; c=relaxed/simple;
	bh=+rx9vl+x75FoWyGwCUxTtmzERdKUHmIGH1zDEF/INZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ng9uR3SbsYAHWgblU6uy6heXo0APk4vm3CcBQYRReCE5SsUfOFcV+/AV6kB40za+EYjfuvCIN7M1Jwm17nbuHNuk9MzlXLMtsauXt6Uy/spyueP55YWKvuTWUijYEBdYDuHgf/WJnF2Fo52XItCTkwgr061OO15CI2IExPmljcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=unxTl0kP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so1098893e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723720809; x=1724325609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5FdodYMUJlHJKuSCp9GX1nhpR2hEhWwQY2UySRkoYk=;
        b=unxTl0kPMZ5GO/YY+N7XNx37vViuN3aXuD7pDT5xXlKwp8vNVNVMLeoVwrFcQ/Rc1U
         HUh5ffJaVK9h8HsSuIkA3a91DOHROS+ZMotKXu4sfoukR9M6t8ay27aGlzslm29bjuvR
         MkfTNungMFwf1CvnBNGAMdtsyh9O1DziH5kYInM1rZ10f5KO+2m+EBAJ1I5Cni1cDBE2
         +w3O5ZsfHHaS5DXY2riSIQEZVDpqf/M/9FIS/AtVAFgQ5NVcNFfo+/iewkLTmszO1tzP
         VEzfHO8yfLe4Lc5am08XU8hCq3rJXCCutTfe96Q9ZWEXX0kawsrTQQIzG7lqzYUjiPQg
         hk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723720809; x=1724325609;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5FdodYMUJlHJKuSCp9GX1nhpR2hEhWwQY2UySRkoYk=;
        b=lNli1SvrIGkQejeGv10invb7TNLuTu6nLEuj/cXQcU8x9cm1d2Geiiz0IhC+9nuXqZ
         jGdA+MDa3zrq+lQjhbFsJLNSEJPUAY8Jmk6A2juQY+eXsILmUbjUAdWlRS6q26MWGpxi
         y6K0nM6Dq8l3b7OWNE5eqp7gqI/pnTGduLMPJsM13HFeDDJarWzELXzCL/Y/psOxwowT
         nuNSEoPMqwtviURWGCv3Z34lMwPKyX9hK90i/h2rf8QkQL5NkfkzT9cqu3yDR7ITUPX4
         wIgrTzsGvFIae4wOK2Po+ReO19TeyrzdKWSm7xiZ59jPGmhZTS14wsplk+QlnIiGBcet
         aVpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmPQR6U4DvUgrHGX2rzAodNKL6KiuUlujuAOSz5NthElrKVoPzTaZ52vpXbWQRjfi/i8WQQWinIAdjoNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywLv6fWveDkvmyvD46R2r7xNjY964HtauDd4cJPdilZ3RGXCcw
	MT+YshhtKPhqeTJTefzOHJQiQqa+cG/eHbZOr3fdjskOA2Qznzd+g7eflExaHpM=
X-Google-Smtp-Source: AGHT+IGDSlIrMpFgn/V8ura8ZIKZtXcMX3El1z5OwXZ8AzCb2FT/8bSO+SRiLiqDp5oxPLs65pOZLg==
X-Received: by 2002:a05:6512:b97:b0:52e:9fe0:bee4 with SMTP id 2adb3069b0e04-532eda59e63mr3297113e87.9.1723720808603;
        Thu, 15 Aug 2024 04:20:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7987681sm17067555e9.0.2024.08.15.04.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 04:20:08 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:20:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pavitrakumar M <pavitrakumarm@vayavyalabs.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	shwetar <shwetar@vayavyalabs.com>,
	Ruud Derwig <Ruud.Derwig@synopsys.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] crypto: spacc - Fix uninitialized variable in
 spacc_aead_process()
Message-ID: <74ca2a96-978d-4d22-a787-04ceaa08aff6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c352e73-714a-476e-8e71-eef750f22902@stanley.mountain>

Smatch complains that:

    drivers/crypto/dwc-spacc/spacc_aead.c:1031 spacc_aead_process()
    error: uninitialized symbol 'ptaadsize'.

This could happen if, for example, tctx->mode was CRYPTO_MODE_NULL and
req->cryptlen was less than icvremove.

Fixes: 06af76b46c78 ("crypto: spacc - Add SPAcc aead support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/crypto/dwc-spacc/spacc_aead.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/dwc-spacc/spacc_aead.c b/drivers/crypto/dwc-spacc/spacc_aead.c
index 3468ff605957..50ef9053fc4d 100755
--- a/drivers/crypto/dwc-spacc/spacc_aead.c
+++ b/drivers/crypto/dwc-spacc/spacc_aead.c
@@ -823,7 +823,7 @@ static int spacc_aead_process(struct aead_request *req, u64 seq, int encrypt)
 	u32 dstoff;
 	int icvremove;
 	int ivaadsize;
-	int ptaadsize;
+	int ptaadsize = 0;
 	int iv_to_context;
 	int spacc_proc_len;
 	u32 spacc_icv_offset = 0;
@@ -974,8 +974,6 @@ static int spacc_aead_process(struct aead_request *req, u64 seq, int encrypt)
 	    tctx->mode == CRYPTO_MODE_NULL) {
 		if (req->cryptlen >= icvremove)
 			ptaadsize = req->cryptlen - icvremove;
-	} else {
-		ptaadsize = 0;
 	}
 
 	/* Calculate and set the below, important parameters
-- 
2.43.0



Return-Path: <linux-kernel+bounces-250740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5F092FC21
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A826B216F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B99171641;
	Fri, 12 Jul 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOW/a0rV"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7587716C69E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793144; cv=none; b=uH/oOUX15zRgdiMBdnm6/xF5z8glgGGgIEbWnzC86rChjZfolw/ytAyTWSzw0lhS6gp82e/BDps1izPVLdPr9FTv6ZzmxrMpxsNhhEzsU+pSIr+6opiOl+wqWIGOuVRMcozafiM6Z19T7Pbcc9cQEYVHcLM47vQZ3ILIkakU6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793144; c=relaxed/simple;
	bh=s07sW+WzTiA93Z5y93aIN6vcb2Pd9mJhEo7g0I1uSsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kdbLSjlUveG8e61Yv5a9zdgjMQEd1GRdTkdQj4UEDxbk0JULUCx8CUteysSRjD39ibejfo55SdismCgK0EWfq4LDbAwlr12WgfdpAFt1NWNDp2a4KXePNxylHuSz7mcdI0NIdVd0RYVHy5h0+kEP7sqLD3XMayT7Eaw1vCJ4Q70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOW/a0rV; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d93f9c793fso1034407b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793142; x=1721397942; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6sW8CRsL35ZnaN7Vz3PXYaGIWLNI/xKoebh6l2Ns/Y=;
        b=ZOW/a0rVDxIcxMPg8nZP/cOz3YpCp0dQ+YEpZdlLDHoN5Pss2fpqWCBexDyac1BoJT
         OJe+0Pcc4g2Zw1j5grX35Jy0CTc3OMbfvQO2bWlqc9Ar3igl7eBDbHIGyJ2SsZTmP6+I
         WScyMhjtvvYS1VOmcJkm4m3K2doG0bV41PDaodCaoW3booM8qnvoDlUzUyrJuXOsIX1B
         pWzIrnx31045QLCZFSHtGuHMFDhALXUiLJ9eOiOfZId5xOw0p8yUXV4Odt1Z9SbW4d8F
         Cdf6jrMd1t8tJktsIm+63aUTm1r/btsKjIoYO+wXw/iJ3HYmCrGXUaD9fdqCMbQyiMCv
         uFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793142; x=1721397942;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6sW8CRsL35ZnaN7Vz3PXYaGIWLNI/xKoebh6l2Ns/Y=;
        b=ioRBawiSJbBZ0ZApkExtqRZvuurwtXbeXTpHnkSdSDddJnXE4fFQMJMT4IYUgOs/Ah
         rWXHnP4hmMdn8Nx/rwuuKQMTZt7wmWaroYuLx8NNqzfMRDCa8HqhpWHUgr+6kwPBimml
         nP8WCFmQ9kYbbg2x1oRg7XjpJRZ4NMJVCm7/jxZQcRk2FuQrFXbz17hGd/VtsQQvV5nZ
         cbjaXpbOojjILovBgOhO1eNKICIs4P3jvETK8Ndo7hHS1KNaPTH+svijuK7eSPjvh3Ir
         OFZVbjxRGJlOSkCesOYSth5sVoMSFewH2i+47fkO/hu+/vFrWN4d5vXV29fkMPjQbxC8
         P9YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMSbvhqGLnA7TR0ipg84+CDYDaI75HtMZMv41FdtNa1nNS9H9ylM1esO6jNgWK3MYO3CWOq/QcOBB7psdbQDsphsVX+T+9LQe55Nkm
X-Gm-Message-State: AOJu0YyWFbmba/6KQhZcuhjmNqpvALVPR8gFZ+2SXJY5IbrMDdmkxY3a
	sAr/tXrOz+eeXXt26mC1PK6SQqsEkLvlD3RF4VHYqD8CIAeBBMdj2yKmfgXX8Lc=
X-Google-Smtp-Source: AGHT+IEysI9SGkIePZZKaS96R96m8ogDps9CeyaZpTkA7h39rNGBYZkG5ZiHjmniJk+GgmCSrDzh3A==
X-Received: by 2002:a05:6808:15a2:b0:3da:a793:f10e with SMTP id 5614622812f47-3daa793fe0amr4676841b6e.18.1720793142528;
        Fri, 12 Jul 2024 07:05:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d93acff82fsm1427548b6e.4.2024.07.12.07.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:05:42 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:05:39 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: bd96801: Delete unnecessary check in probe()
Message-ID: <01cd578f-127b-4c8b-a8c6-5e11a0a2555c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "idesc" pointer points to the middle of rdesc[] array so it can't be
NULL.  Also rdesc isn't NULL.  Delete the check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/regulator/bd96801-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96801-regulator.c
index 46ca81f18703..ec5b1a6b19e8 100644
--- a/drivers/regulator/bd96801-regulator.c
+++ b/drivers/regulator/bd96801-regulator.c
@@ -853,8 +853,6 @@ static int bd96801_probe(struct platform_device *pdev)
 			ldo_errs_arr[temp_notif_ldos] = rdesc[i].ldo_errs;
 			temp_notif_ldos++;
 		}
-		if (!idesc)
-			continue;
 
 		/* Register INTB handlers for configured protections */
 		for (j = 0; j < idesc->num_irqs; j++) {
-- 
2.43.0



Return-Path: <linux-kernel+bounces-394852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD609BB4DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9EE1F21ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132D1B6D00;
	Mon,  4 Nov 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b="sWq1ZFCj"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078E1B0F33
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724189; cv=none; b=mDImESegCLCZ5kdOLW+HDgbDWOZAdRuIZanS7pOzFI+NTWyXPwWhvm3LhUZw/z4R4/oFNboReN2WqnMHD4DbibwiZvy7FMidBRL3TXS5IaqHT5uxq6flI+FMyFd2ohyHdBVaEUhYHIvX1OIyO4xjQpjE6jDG3ktusEAI3k/flec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724189; c=relaxed/simple;
	bh=y65Z9oR1AobPza3jObL8ZvTUxd4wiVcgtKvXh7x/n68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZhb5jT8nM9qbP63Ym3BkdajpIZD9NWId5y2UfpUuB4KlZfq6/IRKchLWhiT7VD+xy2SDO+c5fnpm5xJNP+Kfs5yEZJgCpTG52wwzeJQ19aPLWfZOrmXeBERxe1ygNtWDgoASXA5KrRbvYpjVHmbD7dh00n07t/NRCkGlqYsJzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io; spf=pass smtp.mailfrom=aiven.io; dkim=pass (1024-bit key) header.d=aiven.io header.i=@aiven.io header.b=sWq1ZFCj; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aiven.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aiven.io
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-539f7606199so1716751e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aiven.io; s=google; t=1730724186; x=1731328986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNTV90YBUHHTjeRnFlpu7gZOlU+a1vOHJ7xyySOcw8Y=;
        b=sWq1ZFCjsT0UCfcos+Fb4V2d1vp8qLVQl3WyJdrXUNQAQFPT4LrycZBLvREN0Wlv0L
         BA3f+1o1VLxLBYa4hJghHKjghEE8CNmMw5VPWqANSIoH1poOnbP1qUUKfZYZnYgrtgQr
         zsFL2dnvB38brlZwxyVXSEBmuA17hwPO/Jbx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724186; x=1731328986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNTV90YBUHHTjeRnFlpu7gZOlU+a1vOHJ7xyySOcw8Y=;
        b=Q4kulAGG9hFNehEIE0yc27mm3o61pk5B+gY+ks+6XlOJCugAb9lUvsJe+o0XpS0Sjb
         w8V11YxRHhXWUSIBJctLPD00sns3sHkgqprFQj05LBd1m/NNehdvk48ksZdPLS9DUUNz
         fSj5enP5iXumvpOHBh3U4lOsyH0x/rVxElLFJdnz2I2q3PpeflC0HQAdQhzvz8VTBBYp
         pZPU1vtKuwuZ8gk9VQ+md7AOzxjEWb+jV4fvZMUeVCrChCVLu7Utgd1ySsoIEjk941/B
         U2nTImCNMxicPjUD8DnxSsGO44hwI8dcxrydwGhsoisScq/mVYPy43pneE2FVLtMcsfn
         ircw==
X-Forwarded-Encrypted: i=1; AJvYcCVVtZAXKougnrNBv+2R1IAkgIRLu5XtlPBbha+rE5dxE2nVkoy6zAfG96lghAneyoBviH6Kgx6bBK3WWFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYeCHsjSs2q2O8ugMr1JYnztAyMfFRa50xIKLgjhR0QtRSA17l
	COCCu/nWkJUM1zgKA95swOvYXqimI5DGUcUYCF8+pcoDRyB4K5pO86Q58ud3VfI=
X-Google-Smtp-Source: AGHT+IEy6uobz47gBvKsl93Jub6o83LrpDnTRo9WUDj6iez5RGxE8Qorg13pXqCkFU93icg9uB8fTg==
X-Received: by 2002:a05:6512:3195:b0:53a:1a81:f006 with SMTP id 2adb3069b0e04-53b7ecf3f38mr9840399e87.31.1730724186140;
        Mon, 04 Nov 2024 04:43:06 -0800 (PST)
Received: from ox.aiven-management.aivencloud.com (n114-74-229-70.bla3.nsw.optusnet.com.au. [114.74.229.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057071fasm60567525ad.84.2024.11.04.04.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:43:05 -0800 (PST)
From: Orange Kao <orange@aiven.io>
To: tony.luck@intel.com,
	qiuxu.zhuo@intel.com
Cc: bp@alien8.de,
	james.morse@arm.com,
	orange@kaosy.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	rric@kernel.org,
	Orange Kao <orange@aiven.io>
Subject: [PATCH 1/3] EDAC/igen6: Avoid segmentation fault when rmmod
Date: Mon,  4 Nov 2024 12:40:52 +0000
Message-ID: <20241104124237.124109-2-orange@aiven.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104124237.124109-1-orange@aiven.io>
References: <20241104124237.124109-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The segmentation fault happens because

During modprobe:
1. In igen6_probe(), igen6_pvt will be allocated with kzalloc()
2. In igen6_register_mci(), mci->pvt_info will point to
   &igen6_pvt->imc[mc]

During rmmod:
1. In mci_release() in edac_mc.c, it will kfree(mci->pvt_info)
2. In igen6_remove(), it will kfree(igen6_pvt);

Fix this issue by setting mci->pvt_info to NULL to avoid the double
kfree.

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219360
Signed-off-by: Orange Kao <orange@aiven.io>
---
 drivers/edac/igen6_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 189a2fc29e74..07dacf8c10be 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1245,6 +1245,7 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 	imc->mci = mci;
 	return 0;
 fail3:
+	mci->pvt_info = NULL;
 	kfree(mci->ctl_name);
 fail2:
 	edac_mc_free(mci);
@@ -1269,6 +1270,7 @@ static void igen6_unregister_mcis(void)
 
 		edac_mc_del_mc(mci->pdev);
 		kfree(mci->ctl_name);
+		mci->pvt_info = NULL;
 		edac_mc_free(mci);
 		iounmap(imc->window);
 	}
-- 
2.47.0



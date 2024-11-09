Return-Path: <linux-kernel+bounces-402513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2540C9C2891
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE191F21A60
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08E1EB31;
	Sat,  9 Nov 2024 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXU2w6Mn"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE88BFF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110667; cv=none; b=XtyScXX58fI0366VLb0lm2QhdnjR0exrXhTWiGHvmHuDjSCKR3fEEOvKuTN/u1N4BBnIPmh4GroixvG9trn2VmiLEuWAhvPqIKBbdtegLkOaA9nnCVv8778mnskJIKXK1TjMaCCRu3A/YraSAwYf0pP8owoNJ+x8xZdByAkFPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110667; c=relaxed/simple;
	bh=vNc9pzUAAlpSLHdwupXEtJEBYi/DEYLSea6HQqWBRGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hJ/+mg3mwJm5SLUBWITDbAvctpo+P8VGOiBl6IXo95XRRrY+cMN6i+xnP9uqYZQzyEZVHyO+6YD6isx3xVFUQVXVbcalipGN5l48BqSSp9NdiiRuoDDDFI/C+PKL4SE8Ah+zJHkCgOTL8r2q/V/T+Iu09aL9t/o5OSG88o3jwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXU2w6Mn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so19969501fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731110663; x=1731715463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiTEPthPqo3/ebkD0qqxoaM8WpYM9XGm0Z4Ybp7u6u4=;
        b=iXU2w6MnMSLnBqQJgwiz0M0I8uCA4JzbXZqRn2xf5ntWsGWDpqL2ofCxiFb40/9xxg
         Ir6D2HYSPkINexUDcic3Umls0iVtYsqw2GGrBEMEW41cYSAwSz8mIZ5eYAHFtywmGGMH
         tcYAdySxaoP2diycBe6msySgr0yCNV2aWp7FiUU8fWodpqnSCk1+ZHq+AOHSr7Twqw7+
         XTRBlyuJX8I5yOIK0DCAmoSJ6O96rAUVvqfeaoHHaEYnBoOt+Zntb5HqE8APFEeqDxfK
         Xta0Qs234FFJhfCg+ECePYnwVtr0QavtNapKNOLeoFn1Mh2uXTa9UKmsRLtAC+tHdGhh
         0k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731110663; x=1731715463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiTEPthPqo3/ebkD0qqxoaM8WpYM9XGm0Z4Ybp7u6u4=;
        b=SWiv9l9fYGXj3s0zEbMRApIFWRQDtGNkbVfJU8BmV3ypATasg8aCzH49XwiXM2T9OM
         Y95pneq+0ChS2AyvZ7bLDU2pzGqST2Z3AOQpkeEt6Vt57EJ9DrW9agLz8IZVb81Oqu4d
         v+IDhLbYEWqj5QjHRBZVjJ8dtdZtKFLMYhSRgwSXse6Sg+Z9NL2kSyJRiA+URoXQxcD4
         j52CGpuRgKPTAStyer+ODX2y72P6GN2I9kMETbRhKA6wB+u5rAo/wWAJuI9Ar7WSDX2L
         vzMYbAHe3ocHak1Af8dyq20TNqE0U28NGWDb8hSquyK4/kTjmpRD4VebUkJxVL1m3Pn0
         ZHiw==
X-Forwarded-Encrypted: i=1; AJvYcCVFWrFU74SwMkIk44qWFC8+LSV6heIGrVfiQPc9HlZiUAMDwvzTuqVprZipWfJbe54u/DHKdmCy/a5EUsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZw+Pjn2bp7wxzLcik0NCRyslKQ1N+gTUPbR3l4n3llGj/4XvD
	OprceQauQr3TGXn6xq3M6dRql2NLI64W4ORtIVzrhLqUXgE9IWFQL46b7A6XxXA=
X-Google-Smtp-Source: AGHT+IHWEG5PGsyY3GLZoDdm2ZbEVdV9W9AgH9pPqyg0jHr5gvSoOytLziAHUCiZwZEroy6C1g3BvQ==
X-Received: by 2002:a05:651c:1506:b0:2fb:7e65:cb27 with SMTP id 38308e7fff4ca-2ff201e73a4mr27560931fa.6.1731110663495;
        Fri, 08 Nov 2024 16:04:23 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17902152sm8221431fa.57.2024.11.08.16.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:04:22 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 09 Nov 2024 02:04:15 +0200
Subject: [PATCH v2 2/2] usb: typec: ucsi: glink: be more precise on
 orientation-aware ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-ucsi-glue-fixes-v2-2-8b21ff4f9fbe@linaro.org>
References: <20241109-ucsi-glue-fixes-v2-0-8b21ff4f9fbe@linaro.org>
In-Reply-To: <20241109-ucsi-glue-fixes-v2-0-8b21ff4f9fbe@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogeurs@linux.intel.com>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=vNc9pzUAAlpSLHdwupXEtJEBYi/DEYLSea6HQqWBRGU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnLqcAO15Qotft0szsjqbSNzcaxCYWgZEOzS82i
 56/L/hrM5aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy6nAAAKCRCLPIo+Aiko
 1YhQB/4phgE/zYsTgO/BKGTEhgTp6cOPDbL9814ZC0n+yzunQFXi9vj539T1t0vrCGzzJFLW1RY
 6e77MQreozkWv5vPZpfbpxRaIbsMYgwQVtBu/0KzkUZaZEH64BzwxLmcCBB7TYmqjh2SOoYxxok
 3sD2ASy3QI4a0NNYbDQhGW+b04jpqmRNqIDpkCqkJT1q1aZUnbY3yhLHhMU8qcdGFBVaS5tUaeQ
 Ff6DxtpKS9kaTIlLKU7A+L0FB2AKb89Y8AQ03mj+rhO1ItkqE0FTh8QVPnAospp41hfaFGVcD2A
 tjBkvRav7YAEOjSvxgC1YyWYeSywZoUiNGwK9aJET29833Xh
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Instead of checking if any of the USB-C ports have orientation GPIO and
thus is orientation-aware, check for the GPIO for the port being
registered. There are no boards that are affected by this change at this
moment, so the patch is not marked as a fix, but it might affect other
boards in future.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 2e12758000a7d2d62f6e0b273cb29eafa631122c..90948cd6d2972402465a2adaba3e1ed055cf0cfa 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -172,12 +172,12 @@ static int pmic_glink_ucsi_async_control(struct ucsi *__ucsi, u64 command)
 static void pmic_glink_ucsi_update_connector(struct ucsi_connector *con)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
-	int i;
 
-	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
-		if (ucsi->port_orientation[i])
-			con->typec_cap.orientation_aware = true;
-	}
+	if (con->num > PMIC_GLINK_MAX_PORTS ||
+	    !ucsi->port_orientation[con->num - 1])
+		return;
+
+	con->typec_cap.orientation_aware = true;
 }
 
 static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)

-- 
2.39.5



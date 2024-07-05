Return-Path: <linux-kernel+bounces-242082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D683928351
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F95C1C24B18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70802145B19;
	Fri,  5 Jul 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvNSkBtc"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CB145355
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166348; cv=none; b=cL1Bhb2LPOA4yIUMHNf4NqhfsR2tsd4D7//wSpQyFzgx6pM/YnRsvLOHaoElykQTxzHMmJM6Krzh4N18ehLjfSoXxS5wLH49I7U45PTiHsvE+yUgkvUShjuVwLeCwHLkvPIGSJEtJ1nTvTCI3r2i8jQQWw2m2FGnZYE9OYnW0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166348; c=relaxed/simple;
	bh=295SPVymILL3zztEI9wBshTd+kDs2G1FpXLFoa0IdoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elp9MRwJFel7QdqrSkLkp3TzYK3bdb76DvQukozSunntbQ5QdrV9ZUFhql+V5r7bxHcxwsI6e8AEOQ8vu0HBVTrCc8wdI2W/JSeICqOa0e+9eTi0CszKLgE+yIwQBSWlaWix5H6UmAeOsWMqixmIAeih2bLHEX0wBYBFElTyRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvNSkBtc; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e8b27f493so1592972e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166345; x=1720771145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haSCOpPQsh3zt9hsGGiD3rlfBhoqaA0P3zbntxRYf08=;
        b=lvNSkBtcajm0YJtkZF0PNLRgMLGWHh6twS8xtiJLhuWl34egpWaFuQTh3o08x9dIFs
         J8EkjSyEzxK4Fvif0dnsaV5+lARQso4UNE/+bLA3kpDWrZBF2QhwvC82kJ7pdTBMUAp6
         +jFsaejdUO+zQsJFLMkHyO94Cvcuij7nPnmhYT+yGvWBGWtaSWEiS/q5i1agrI0vXc9y
         6DnlnGPwtK4meaZOUUMQnMGSRKXdAGO9wAV4iHVGPb+gFzBBS7qDYVOyRWm0Tu9bPLq/
         VHJck0Ux66sHCDEcIp3/fBQryYuG/3MkAc3bL9TxIuM59/iXcWzB08HwQfMtdgP2+XNH
         gPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166345; x=1720771145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haSCOpPQsh3zt9hsGGiD3rlfBhoqaA0P3zbntxRYf08=;
        b=FGOBEOSw3VzT2mTlYDrmIaMLC2DlQaxoY8bdQpu9kD4gZYMh8vOhEuTmhu7LKHmIE9
         0uccV3cU4Ob6DV6SVUns7tvCXzgUDxTgADrkVO8a43TEfb+Z8fQr1KYI9igG4WmydlGZ
         pKKXNTRHmXgc/srmb9PJ+NSb5EegsrfxBh1DmGDMhxrhmKsH6o2HvYZyQD9WgKGV14vk
         hhmK61mDrmvNjZrcJDALyMbfDXpLgGmVXaXSwEBtzkNpOEwYP3ASCXEH+wMnaQMNh3PK
         njDeHWyNOs7fcrHfwOrgmaNha7Ck9x9+07/87HEiFIFYnRRV/YxNnj09EVDB16vLff3W
         4Pbw==
X-Gm-Message-State: AOJu0YxKjnuuuwzMjRFK7ROjnjSOBeDwauYpm380pJXdhjiVe0vI1ZNA
	n/U6EHmSk5vbZGwZwYn17Wjc+F/sQFXlEx4shNwwT2SuERH7tNgL1/ACQW/LWSUP0nviKnaqYub
	SuRQ=
X-Google-Smtp-Source: AGHT+IG7UGU0JGtWsgYnsPyEwjNgDSZ23V7Wc+m8d7CHtWqWl0vA2ZottB+nj/tder7/tv6MwlwvUQ==
X-Received: by 2002:a19:f51a:0:b0:52e:7688:2817 with SMTP id 2adb3069b0e04-52ea0628ccamr2551457e87.17.1720166344872;
        Fri, 05 Jul 2024 00:59:04 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm15315485e9.0.2024.07.05.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:59:03 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/6] misc: fastrpc: Add missing dev_err newlines
Date: Fri,  5 Jul 2024 08:58:56 +0100
Message-Id: <20240705075900.424100-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
References: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2912; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=pdIoWa5mSqtc2w+5UDfLbSe20Voxx74ohoojsJLjHVo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6fD3my50BjgDkdGvxFhdDjQ7eRRb+Mwcn1WX aaNXIeVEdqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoenwwAKCRB6of1ZxzRV N3GaCACjDx3xOGAikoB2TJqqZHPWHPAhTe58mA44sWsrMgGVi8rMfp3ck7r08sIJCUPdmaxXE1B wgdjg9hESahR86mIP9Fs8vqhNupCBQZYWxp6SMd8yBQLh/M9FUv541qrMpScGuUxYScyLVo3bbc 1XEdMpkxF3M+Xig28pFkl91WCNIekxRXq7uDptWzpCjQ5bBPsvTe5LSXUwZBDFZvoqHA1USpHQF if3qPsZxF2j4SFOltSyKBvLXFncSpoChrFp+mzE3jSQXigO62WXaZWrB7dfoRdAw0snDSQCRFia uDZC17Ho4QLqGlUK9xUz8e7lOrJ2RNNQWSbb8JcHziNb7dk+
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

Few dev_err calls are missing newlines. This can result in unrelated
lines getting appended which might make logs difficult to understand.
Add trailing newlines to avoid this.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 694fc083b1bd..2653a193ff2f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -325,7 +325,7 @@ static void fastrpc_free_map(struct kref *ref)
 			err = qcom_scm_assign_mem(map->phys, map->size,
 				&src_perms, &perm, 1);
 			if (err) {
-				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
 						map->phys, map->size, err);
 				return;
 			}
@@ -816,7 +816,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		map->attr = attr;
 		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
 		if (err) {
-			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
+			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
 					map->phys, map->size, err);
 			goto map_err;
 		}
@@ -1222,7 +1222,7 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
 		 * that does not support unsigned PD offload
 		 */
 		if (!fl->cctx->unsigned_support || !unsigned_pd_request) {
-			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD");
+			dev_err(&fl->cctx->rpdev->dev, "Error: Untrusted application trying to offload to signed PD\n");
 			return true;
 		}
 	}
@@ -1280,7 +1280,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 							&src_perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
-				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
+				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
 					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
 				goto err_map;
 			}
@@ -1332,7 +1332,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 						(u64)fl->cctx->remote_heap->size,
 						&src_perms, &dst_perms, 1);
 		if (err)
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
 				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
 	}
 err_map:
-- 
2.25.1



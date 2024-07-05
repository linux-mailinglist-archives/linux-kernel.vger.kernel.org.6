Return-Path: <linux-kernel+bounces-242032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695339282F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A4281779
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803D5145B0F;
	Fri,  5 Jul 2024 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCXCkQSl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B21145343
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165278; cv=none; b=ADmr0xMH6PPgI91r3ScxAwVNwPH5/3MdUN6LFGUsJJk3nXI5y0rYMArOh0HmB6eBNHyDSFmdOa9eHjjjQq0MyrPZ754yLWGgHWHv5daTP8bnOruefzKrh8ownLD7xcDQM1r3NYD9nm6fwN5ZX1PJ8zpV724C83iT5Jid9XIoWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165278; c=relaxed/simple;
	bh=295SPVymILL3zztEI9wBshTd+kDs2G1FpXLFoa0IdoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkDh0W7X0RkgeMxOKI8gkySBbGHjQGKxQdhHkOhb540xgDGk4MIFvsuJDnmtyv+NnlL8zr4Auwodc/38/GjcNEA7Pg1dt9ES7bf7Mu89KBwMYeQ7J2rJXFIzR2b3xZWmSfg4fmA1YnN3uGOSOeKUpNpEmiw6nXE2KoGLFwLAklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCXCkQSl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-424ad289949so9086765e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165275; x=1720770075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haSCOpPQsh3zt9hsGGiD3rlfBhoqaA0P3zbntxRYf08=;
        b=QCXCkQSlHagSNQ/FP0BtU6Y+4QJs32QwvLMdZf2ZMmfBTekHHVSpGpTyJ0OKgB840D
         kP+ZHGmsOnpKJgv0TGNrJKvZp/vp8gfWrIqa8UpA05EVwW7T4FkQH0RQc7rw4A2csVPN
         Jv8S7DKKcMdbco8+YGuWF0jlOWV0goQTAb5f57Yb06/iN1ZUL4+d5kbc+VYYMBWAJUdZ
         wuz84gl/jm9tMIi/Tg6xKbNl2rkrOnljPAN4LaNcT6qvymgSjjmFoGMuiMEBvKYaBaFZ
         KD4J9ZTghWo1QPV81c1AOlxDdZh1PltjvGLPT4GFlteTJ3nySsJtKvPP+o5PTd037tmC
         x3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165275; x=1720770075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haSCOpPQsh3zt9hsGGiD3rlfBhoqaA0P3zbntxRYf08=;
        b=YpnxkAx6k2HVkMjaPM31485YW6WScjtNBLt0VP6SFGTS95EtUFQL0M7iR29ghZLDTA
         kczTyRuL/8pH8LudSQZaat0Sn7soJKvRR9nPp/YOGaP2BsmVPl7NbfJ5D6p0WVkwBi5j
         98H8HU8oCVM/pzgCEh36GMqpADIn4Eq6mx5S26mu7HlJzoh6izjE/7IpPQTuMLQZTlG0
         cvT+WjFJvGoMBfRpJXpBvbQB+IXM8POI8j4m970k7YPdUvJ8zA3eakMQ6D704ttWfZ4B
         crRckC6SejaVEpW0ZakFRdDURdJ9mBROnFVQ6H7BZomKCr7Si5H9z1W8mgvcJkc+/2ma
         Cc6A==
X-Gm-Message-State: AOJu0YwaTCgV8733B363uxn2Q7X/mNdp4DyCqciGVmJiORAu36JfkkcR
	X3bsYPerMLvY+p6G1GMASrnajcpnOLhKSdxTj2L7Irgll920EfIANfw2seU5PEs=
X-Google-Smtp-Source: AGHT+IGHrKWw1G3Cr7oMV3aO1smViwpvZecOzbcPeCeOhIIz+4o0845aC1VUcYw9hw0Xv1eW9QSGcQ==
X-Received: by 2002:a05:600c:6a11:b0:424:a312:908 with SMTP id 5b1f17b1804b1-4264a3cf952mr25498165e9.6.1720165275430;
        Fri, 05 Jul 2024 00:41:15 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:14 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/6] misc: fastrpc: Add missing dev_err newlines
Date: Fri,  5 Jul 2024 08:40:41 +0100
Message-Id: <20240705074045.418836-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2912; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=pdIoWa5mSqtc2w+5UDfLbSe20Voxx74ohoojsJLjHVo=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N93my50BjgDkdGvxFhdDjQ7eRRb+Mwcn1WX aaNXIeVEdqJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejfQAKCRB6of1ZxzRV NxOrCACHosrDgvndudYD0T5Xyz2rZeUI8tgNtrB9NwjcgNp+ccS9X0smFc19I/mjN0zioYMeErZ F/T2HraHtJD71YC0Bby0mjGgmrSAcpOTSFoyE+Yw3hn4u3+8Ie0YvP+Q7tAQ74BG3mL6aLns3p0 yRgbJ+xp14GPCfiBRDmX3fcAzZzwyyQIz2/YfaHvUSbZIwneR/NAVNYt0i/iJtY1RHi3L4VqZzn uRLMsGRResUPnUmf56Y2NSVUs7Gm7zoPv7cyWTsQP3SVfxQfJFGS3B8WK/Q+UZsQ2t01HUrUIMN D+3y/Q1FEYkqfoee9VAjAtfKz4DLk3Q8TVugjzFGuWy2u8/l
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



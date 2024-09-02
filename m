Return-Path: <linux-kernel+bounces-311485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DF9689BC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CF21C229EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D5E2101AF;
	Mon,  2 Sep 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1y036Yl"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EE9183CDC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286715; cv=none; b=qqbxMbkv87Rjj4pMLuMd4j/xZmWBjyzzWM6wnENIKRpKjFKUlv8p+nbii8qTy9TcRbJHdNoDDfMIyTpVscO4oKGyoy59IzM7nUktNdNLZzklqOEO1y00vHMOTcix0aCn5UIGLuNhHGMNMOVwkLL91AIL5FbjIhKhu6+MsQps2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286715; c=relaxed/simple;
	bh=lITsAvEIL2JB827JDTgkGeJqYRt6tTeIhwhbI1DhqVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XiXjvt1fu6mxAYjD/OanB147raS9kNLHILTKeIas22GARjPqSAMw2IfjmeMtlntpYuQjvr+BfmFW3Ray77wuU/ChMcEnbaNQFpakpwkv2fl9fmSUI/NH+CYQSBbzi33+anucpsdFEcP01I76ky/ZsWbDxbZjkGjLYQVnr9Hjirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1y036Yl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8684c31c60so482125566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725286712; x=1725891512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reQLvTgsTmif0aH4/FfWI7U4vWsPrCEZdKZKsSdOSos=;
        b=R1y036Yli2TJC1UcchZrgykRNsgYTLNv7hDkHN/v3PeiablZNwBQvz4aNUUbPmU7AV
         AJh0jLXeF2imSgJ40nWQyWWxEe6SziyLIjG+5wnmE7vGQddm/NNp6EoypKT9pqKvQnis
         Qj2P9KPtQjcuDLnJCnK9Uw8cljbvCw4KZsWnHuxX3E0sv+XZq53RJBfKTKAYtAqdxguH
         elMuW5dIK0Y1xpWPLA6aY8GSe1q/KKauTqO/iKYmO+3HTCuZy5G+OQjE35gTTTafA/Eu
         pH3jCxnTpGcsp316tLn2Uol0wn0A0t47hGFeolkS+cCEW0yiEOMLoIaDAqto3NrfNLch
         JN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286712; x=1725891512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reQLvTgsTmif0aH4/FfWI7U4vWsPrCEZdKZKsSdOSos=;
        b=K34IVbvS9rx0jrchHF28+GUTjGwqGHcg74BagK6+gr9sUiVSrQapjbxnn6X3yhmkE9
         DG0FZGSEFbR2lXPb3gh+11thYAfb7PicNqnUlPx5woJSVntUgdgaNZrGZbSgm7R+aPIu
         CGm7GcAzAnsT3HvVCKAe2TDMhl4BlhI2kU+6QEWAO0HA/D4SR0u82d5/9IP3eYiUo7sn
         3YsX28LMqPPNEjIMwRILt9T3K8FH7UBhODCga/bic0gPqG5fsggarud/gpDuYafIjl6b
         VYX8i7uEy7px33YVokQVfN53RcbwXy1ku/pCh38MYYG4pTwqhr/uv6zT+BPjCj5Jvf7b
         LoCA==
X-Gm-Message-State: AOJu0YzVlmSL4Wpe2csXLZGnlWfzsDs3hc3QvTJukimC4NjMvoOqwkEb
	7K3w7UzTUpMGFiz32iac7v5RIfYEvPCoSsv/guIcB8+GxAvRgY/F1jWIYjRRk+DEfMFRVj8M9z0
	9
X-Google-Smtp-Source: AGHT+IH9k5SPoFyYvgkRJPHuJJRefDZinWIOCrU9W3HsgfT2gsut3HQgy5J/4yCcTLbgi+pxPT4vNQ==
X-Received: by 2002:a17:907:1c22:b0:a7d:a29e:5c33 with SMTP id a640c23a62f3a-a897f83fab0mr1068509966b.28.1725286712314;
        Mon, 02 Sep 2024 07:18:32 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891966f2sm566000666b.101.2024.09.02.07.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:18:31 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ling Xu <quic_lxu5@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] misc: fastrpc: Add support for cdsp1 remoteproc
Date: Mon,  2 Sep 2024 15:18:20 +0100
Message-Id: <20240902141821.70656-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902141821.70656-1-srinivas.kandagatla@linaro.org>
References: <20240902141821.70656-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ling Xu <quic_lxu5@quicinc.com>

The fastrpc supports 4 remoteproc. There are some products which
support cdsp1 remoteproc. Add changes to support cdsp1 remoteproc.

Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
[Bartosz: ported to mainline]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 878a6746f994..3db1c65d7a12 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -27,7 +27,8 @@
 #define MDSP_DOMAIN_ID (1)
 #define SDSP_DOMAIN_ID (2)
 #define CDSP_DOMAIN_ID (3)
-#define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
+#define CDSP1_DOMAIN_ID (4)
+#define FASTRPC_DEV_MAX		5 /* adsp, mdsp, slpi, cdsp, cdsp1 */
 #define FASTRPC_MAX_SESSIONS	14
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
@@ -106,7 +107,7 @@
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
-						"sdsp", "cdsp"};
+						"sdsp", "cdsp", "cdsp1" };
 struct fastrpc_phy_page {
 	u64 addr;		/* physical address */
 	u64 size;		/* size of contiguous region */
@@ -2285,7 +2286,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return err;
 	}
 
-	for (i = 0; i <= CDSP_DOMAIN_ID; i++) {
+	for (i = 0; i < FASTRPC_DEV_MAX; i++) {
 		if (!strcmp(domains[i], domain)) {
 			domain_id = i;
 			break;
@@ -2343,13 +2344,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	case ADSP_DOMAIN_ID:
 	case MDSP_DOMAIN_ID:
 	case SDSP_DOMAIN_ID:
-		/* Unsigned PD offloading is only supported on CDSP*/
+		/* Unsigned PD offloading is only supported on CDSP and CDSP1 */
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
 		if (err)
 			goto fdev_error;
 		break;
 	case CDSP_DOMAIN_ID:
+	case CDSP1_DOMAIN_ID:
 		data->unsigned_support = true;
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domains[domain_id]);
-- 
2.25.1



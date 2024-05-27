Return-Path: <linux-kernel+bounces-190306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD78CFCAC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6458D281C70
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C2139D0A;
	Mon, 27 May 2024 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lhb1blKM"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B0139CFC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801691; cv=none; b=tWkvb/xZ8QMpgMXhZcLMLyQ3O0h/CF3KZ/RiO9S27i1V5Cqm+Wf8R/l1pU5NTzKnwotHuflI+lTaqTabqwD80yjf1vtbmz3+BgfcUD/MxXMn5huIqrCgoYtluGmwDCTdXf16SvkSQGzDL+ObZwn60p8sQHYQ8ym2uEJP/DGQd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801691; c=relaxed/simple;
	bh=JLG5Tk9lIFQ73u9cPu+K2CKr/ghX4j48CAQjKF0wPkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFfWLo9zxkwlFRQ/2pWQNy2HlIkmrVEv73DCQbIUV+bAOsQViCFMPJ64gziyUW48J7APd/4L0fodKbslDL3mcFFhQdjXmPoySi4fyanSRSxLLE4vlltgA9NuV1xUsuTihbiGjkCTjsBiXR8U1FPAH1pPojp89YgW0gALCH3MN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lhb1blKM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6269ad71b6so336084566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716801688; x=1717406488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipebK9m7PVqqulwRzxjF0xLM7H0wET0JcbhhBU7VBX0=;
        b=lhb1blKMjE9t/5U7UIWt/Wb6Bv3ILu1Tk74m7YZ/qrkjtEtq2/+OteOV8LtzIoV2wl
         9idRXoPIpZRxAkEWdC8FQIoiBeSvfNQ3iaYdDgSFFAuswM6f9Oeq7Fyj6etbOQ37Qmvb
         Tiv+qtxmG1EPI77SkNgZ333/cbRRcQbY49Yvyuvnnm5IfA89tX7gt/1p69K4urWWygmj
         pSCFWdMEtmyqo8fQ7oj+IISMUemuA8NXKC5xlN/mVzv1opwIH+ECCfcDOiAyTtJ4JASN
         C+yiaaLmfIHUhYCxuLyn6H3wCHx3YhF8xiQ3SwiC7zKT7rb2ud3bTCCrXhJtKadjXuZU
         4xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801688; x=1717406488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipebK9m7PVqqulwRzxjF0xLM7H0wET0JcbhhBU7VBX0=;
        b=TowOy8MTHkAoFi1rOP7jQ9Hi5Zik2gVDtspnHeGRRksT8PQ0pFYdRFR2wG+hkffCjd
         a2TRygM1M5DK3jgV+GI0TiI374b1U6YXZr9qbcVeyk4CVjOR8lSEDGGekZfTBmM2JXeG
         iCnbnvAn2/Obm3ucwtLQQEYfJW9gyLvhkfvn4EnVf3NF5Ih0ySw2btaPxarknImhil80
         9tOaIDA6uCi+N9OldUHX5HbdktHU56hzRT3CPC+AsmLAx44lpmFPo1aNaQ5sDM3d0egi
         hbWCGNfVScOFrk1q0YUN4Wef1bsJ0fzgpOPqxn7VJg2cFVL1HTjzFHM+YuHTcZLRuFLM
         AxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpbbgSTiU4OLzWYxB8yIX5FIZBx2ruFKG0sPIJkEoCKSPb6+pH3DiIWUJFUhw1GmeWdIpDVvJd3iV6jKtPanenJWDXUaqJGYTK9Ar+
X-Gm-Message-State: AOJu0YyIaKERp7UNGkUBkVCexx4gbmnEa02RByxByyQrXDmLVcTdKIlx
	7bZVNbUSkCfXWWit8mZRTvq/Fa6miFPSSBEHLhrg9tcS4PDrrRq6PQZ2XjLoMVk=
X-Google-Smtp-Source: AGHT+IG2dVBnBfud8TgPZ/tj+z3XZoHB5psvFY/1rOOuSv9EEWfGPcFvymolbCJRBeiPqhCXxo+6vQ==
X-Received: by 2002:a17:906:3cea:b0:a59:a3ef:21f4 with SMTP id a640c23a62f3a-a626511491amr503991366b.53.1716801688140;
        Mon, 27 May 2024 02:21:28 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cd83a1csm466087466b.182.2024.05.27.02.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:21:27 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: amahesh@qti.qualcomm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH v2] misc: fastrpc: Use memdup_user()
Date: Mon, 27 May 2024 10:44:30 +0200
Message-ID: <20240527084428.246396-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240507222226.288074-2-thorsten.blum@toblux.com>
References: <20240507222226.288074-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to memdup_user() overwrites the allocated memory only once,
whereas kzalloc() followed by copy_from_user() initializes the allocated
memory to zero and then immediately overwrites it.

Fixes the following Coccinelle/coccicheck warning reported by
memdup_user.cocci:

	WARNING opportunity for memdup_user

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v2:
- Use u64_to_user_ptr() as suggested by Arnd Bergmann (thanks!)
- Preserve Acked-by: tag
---
 drivers/misc/fastrpc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4c67e2c5a82e..694fc083b1bd 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1259,17 +1259,12 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
-	name = kzalloc(init.namelen, GFP_KERNEL);
-	if (!name) {
-		err = -ENOMEM;
+	name = memdup_user(u64_to_user_ptr(init.name), init.namelen);
+	if (IS_ERR(name)) {
+		err = PTR_ERR(name);
 		goto err;
 	}
 
-	if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namelen)) {
-		err = -EFAULT;
-		goto err_name;
-	}
-
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
-- 
2.45.1



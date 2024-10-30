Return-Path: <linux-kernel+bounces-388416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E659B5F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0E41C21541
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABC51E47A6;
	Wed, 30 Oct 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aa7m4Gix"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF131E2859
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282100; cv=none; b=ijM3/ThNhENOkk5gZWWh8yh86ka4T25fGVBFPKsGUR8/qdyQB3GmScdlK9F1Rvw5aEC4981mpcjCd9AeM7LnF+ufgPMT6wJQwQK5d4Qha2sWKr/0s8HV2biqqRkXGm6Lg8Nmy5PPGYwa4rCVJ8itLLmr9pgIoa/FVNMKXPbUgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282100; c=relaxed/simple;
	bh=VuCpj2n89DoanslWRbLq8TnzKCV9aR5L9fpM5ccZyo4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VJ232waCfXbmCUxboUY7B3fAz12OXa/2FXJXEPvXNzmuJfLhO0P/pMcOLzgf12vi2NCL1aplH/lkgzGn4I3DGdnFWgF4tip+6ftNUKAGPEYWLP1aslab1Yc4E3tdtfIDKt6aQNdabhORljLPyVXQYm8+JlkZEq7zcyeZ+sMN2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aa7m4Gix; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso61044311fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730282097; x=1730886897; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDDDNSuaWmBznhMfkp5tEHEC36JKKYqX7WNIjg9Fd40=;
        b=aa7m4Gix8qgJ1U4j3E1DPojTs4xkcqecWuWWMNbRTqgN1Fw4Qx4LA89ZgwZQRf5G4v
         prUm9niU3yI0KoFOm3Aml3rQ3M+bvidJwJm1uurfJYUGBPw7YNcOjhP1rnWgxwJPqTiV
         c+3zAs2771rbPnWSdwK4vR4E9ANdPrcRTIdTcziUdhWlyZ1RIbaHcfFYaRy0moixSLm7
         kgJ5D3rUICEJXuCSV+KZdzas/VlhRN29Yajt1tUPbZPINoVyOPTlrdlAXqa4BBMf43e2
         kYw+LWEiOkwWo2jiyttcM3JYDjLJaYObouJ0BU7ggEkrw+7az8zOCc/8rs3+fmz1jlX1
         aJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730282097; x=1730886897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDDDNSuaWmBznhMfkp5tEHEC36JKKYqX7WNIjg9Fd40=;
        b=K3P71GjPgc5KFdO4RWLWoxOshWw5fnQbhvISw0EQoGJ+cS0IgEenCCmT3QRthHrvYo
         HmHqSB4dvELSuy3kYwnDW2sdTrxqbpMgBVs9PNXaK1RoNt4o0hdx5QP1nZ1ccB1lgMEo
         eSU9S6hFYV+Nyg5UNZtkEj9QjX2p6tF5SlCoNvg9vnL2YO6NpwZvW7Pxr9KGo7FLasMO
         OsnquTPQ2a7WMqAVIieYFuxBd+ohQM1EmrZChrct3iothaK9KAc2/xpASzpe09sRDtDI
         /eGSfWzIkgyeCZSmuRSB7YQthLYZeu+q97/yqITdimrAxFd7mBMc0uSgc7rI42EigqNz
         QptA==
X-Forwarded-Encrypted: i=1; AJvYcCXSs5QmJfLlUOzlxl5sNGwo/6mEWI6XfoNnrpJE/R0DniCw/7VtSqIalzxuFR6vCNSwqKzUT64IyaxfPN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6OFVp0QP+i6lsXQL9IWvhHlQeek0RFIxsL0YNHnLJcUCrJyi
	Z9mOL494/v0XvWtiNyUYFWhUHXYaMUD8pkj+pdsfUxPYCK3KKVYyU8lAPSUMv6M=
X-Google-Smtp-Source: AGHT+IH+TtYc1IJuGrClf3QG5CcuA5wgN1IsLr8/pAzsn43uVdspD6CyoRiCxP2LGdaFETGrr0KSjw==
X-Received: by 2002:a05:651c:1504:b0:2fb:5014:abf9 with SMTP id 38308e7fff4ca-2fcbe04f0bamr64348391fa.31.1730282096687;
        Wed, 30 Oct 2024 02:54:56 -0700 (PDT)
Received: from localhost ([41.210.143.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b713f0sm14889466f8f.75.2024.10.30.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:54:56 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:54:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] io_uring/rsrc: Fix an IS_ERR() vs NULL bug in
 io_install_fixed_file()
Message-ID: <762b0c95-f4ce-4fb3-8212-01e216f683ad@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The io_rsrc_node_alloc() function returns NULL on error, it doesn't
return error pointers.  Update the error checking to match.

Fixes: ead12caeb8ac ("io_uring/rsrc: get rid of per-ring io_rsrc_node list")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 io_uring/filetable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/filetable.c b/io_uring/filetable.c
index 78e77e2017be..fc6872304136 100644
--- a/io_uring/filetable.c
+++ b/io_uring/filetable.c
@@ -69,7 +69,7 @@ static int io_install_fixed_file(struct io_ring_ctx *ctx, struct file *file,
 
 	node = io_rsrc_node_alloc(ctx, &ctx->file_table.data, slot_index,
 				  IORING_RSRC_FILE);
-	if (IS_ERR(node))
+	if (!node)
 		return -ENOMEM;
 
 	old_node = io_rsrc_node_lookup(&ctx->file_table.data, &slot_index);
-- 
2.45.2



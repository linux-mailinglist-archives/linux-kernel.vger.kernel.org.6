Return-Path: <linux-kernel+bounces-242035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DCE9282F3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2196C1C22A74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394A14659E;
	Fri,  5 Jul 2024 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfivStBS"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C15145FED
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165283; cv=none; b=TGxKqO7DZunfZdIgSfjd4Tok2XXEmhBR53v1RqGNY9f0izFpbU04olY9drVP/oqtH3/ALTm8no8n4XREiDBm7FCiQaFpRJa75AIzTATwFaIxjChbRQ12ZmSnv7R3xyc0dle1MWz4R2EwSpIbJ4ffsWUVvpuzTy7uNrEE3Pf2DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165283; c=relaxed/simple;
	bh=TciCqxzc/qy6kg0GBz6jBFReYx11cwU3Iv5FYJNTzCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LlT6hGLGGu8SV3AaA0DfNP94zjxGpRZAO++roBCRLtQNrVJLWz/nQtKhpuuoN29TKvPbirehKoFdCil2/bbl+6JXG7pnGZUA1OSy/FaSKx3Ed8alaYwyR/PvsPpZiwFAY7p5hhFifzmXK7hfpw30Qu/k6TMJF7DE2yaDorEWDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vfivStBS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42567ddf099so9188295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165280; x=1720770080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygcyp20J2+LIkFpUGmt6p19eExeLNGh9Ae9+Q6pOPWM=;
        b=vfivStBSIDjzmpZAXkBYoO7/5BLMn4ysIbSaYjLKL8em+yI179suxDq2Qv7ZmAw39G
         Tu6rUd2woereBOl76yOXodiDAF5Msdu8aDnVqG0gXqIa4cIB4NZZMclhN21aevyKzTtG
         535ST4JpRXw4K72OStXbG5m/Fi5vs8UpBVkgJGkMI3mCk3JM0B+Xbh6E3TeQX/TaN4/s
         RdnHOg25VvmmTOujkv+VPCfPA0IjvYyPjznDPtqdAabU6R4GG67wAWZ7tJn1ECPayOPN
         1hjR5MZfEt23tXnFQh9YHQt7bBO0ppbxzgGpsT7Su5DMQwHamd7Rri9jBkW/MVFwlzSf
         uY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165280; x=1720770080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygcyp20J2+LIkFpUGmt6p19eExeLNGh9Ae9+Q6pOPWM=;
        b=JVYN7RUpug8cvCQcwqBh6Wr9jIHNW5LoOiqB7eldQ64B2qUucFNoHRUgDF8k0pirBv
         2m1NSOCK+hKC8uMYdbUkWcW5NWIABftWXlYooQAMmMmVr8J9QuUhXUu+KidO0Vnh3WX+
         6iOqlYgCiNTlCetXvdHwDftZrr7Ykb5DaSDxgArDmQ2SZ9T+mt9o3InPa7GqamwvsASl
         r9NhiLcH1ALLnT0hkOneIQKBZU8gW4yJZfknetHA1281+wCEP3LOc/EPVUAuIoW23b2v
         Uxo23/C7a3oHMZTIu1WG6/fcRlA85rkKzcaCVWIG/rH9BmfrMvpyraIN9KI2LCnOssM1
         i5Eg==
X-Gm-Message-State: AOJu0Yy+mcLsdoPjrmH//pd/oIZc6Y6yQ9V0YKrYkT3hIUm07+7hBAUQ
	p78kLq241IUcX5nPa98IUX6LY11Z5BBZIT2YI9ua6ipzdlXY/yPLSbNKyvLRrFxD7IojFSMZAm0
	4QhA=
X-Google-Smtp-Source: AGHT+IHagouOa4oAX0UhSZT6E/xrCjGt7Q5+HYjm0IFhUSyPRklZ3rD5/TnOQ6X8/lHElVLM/tSTgA==
X-Received: by 2002:a05:600c:45c9:b0:425:632b:b924 with SMTP id 5b1f17b1804b1-4264a3e3520mr26111415e9.16.1720165279967;
        Fri, 05 Jul 2024 00:41:19 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:19 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dylan Van Assche <me@dylanvanassche.be>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] misc: fastrpc: use coherent pool for untranslated Compute Banks
Date: Fri,  5 Jul 2024 08:40:44 +0100
Message-Id: <20240705074045.418836-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=2gIsBIhQ/2HvQF1EyxUO84GUNTMwiRGzOemrHaXwkEk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N9Pw48PuUYqZ+kZebcOXFBXVLihgJlDbNQL 6gwJQK0v8GJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejfQAKCRB6of1ZxzRV NymQB/9tz/cFhVnMFkuEGosNrWPKg2wLbzDYZUIrAnsPQnjQa19Btlp2SFE09RswvAuTXUkdz1/ yVAQSz1XziwXU4QOjx2Dfxr/CLYnbcCh2RBO1Phj5ziTamXilUfSoN1BubWb1sfYW2Ex/l5ED6d cGer1Ti3FImVEAo3SSqhDkvUFCIsacM8W79PnlkxpPxmn0qF0xCbhE6HymulpRh+K9BFCg8sBeg Jv0Ldtysytk2nqwEG42CPXWTGARzxSs4jrVKkif5K00QelbP+HZDQlA2KZzsFL/ra4K02pA9Lb/ r3PI6yFB35E4gk/sY81gt8hiO7GcUYVXmiQh6id1xiuNcJWg
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dylan Van Assche <me@dylanvanassche.be>

Use fastrpc_remote_heap_alloc to allocate from the FastRPC device
instead of the Compute Bank when the session ID is 0. This ensures
that the allocation is inside the coherent DMA pool which is already
accessible to the DSP. This is necessary to support FastRPC devices
which do not have dedicated Compute Banks such as the SLPI on the SDM845.
The latter uses an allocated CMA region instead of FastRPC Compute Banks.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1c045f9a75a4..95931abc3770 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -953,7 +953,10 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 
 	ctx->msg_sz = pkt_size;
 
-	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
+	if (ctx->fl->sctx->sid)
+		err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
+	else
+		err = fastrpc_remote_heap_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
 	if (err)
 		return err;
 
-- 
2.25.1



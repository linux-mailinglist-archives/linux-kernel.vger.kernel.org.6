Return-Path: <linux-kernel+bounces-242085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B2928356
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F89A1F25285
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C88E1465A2;
	Fri,  5 Jul 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oV7zqRtu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F211145FEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166352; cv=none; b=o2LLo1WTwFGVWnKvElCq4vkpJbFIeWi9LwPjFkF/4U+tSOau9uPKZrpbtDfE10AdjlPF81mevoF6MqYWDun9Z+5CahAHzTpQzF5abDPtfom8M2NjZUnlQULN5fOCa3uWqDva/7PH2hfr5ck3sw81dvZkeIEwccW36cx9/qqZdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166352; c=relaxed/simple;
	bh=TciCqxzc/qy6kg0GBz6jBFReYx11cwU3Iv5FYJNTzCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUlOVKyT7OthUuqQV+cC0nyySxHV/xn24zp/5up/QTmeGFY/NTmkLXdnExO70KLWbyoaZ4MfVadqdLHbCUIg80SpneRfSr1pFfrLLeTLnPpyuCg5X/esaPi9EzTfrF6vB24Cd87YjJoUHFL30aNbwDrAA2we39Pbk5ojWuutRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oV7zqRtu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so8329775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166349; x=1720771149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygcyp20J2+LIkFpUGmt6p19eExeLNGh9Ae9+Q6pOPWM=;
        b=oV7zqRtuGD+gaN6hMUnBWT/5yEi0+sezN2uLch+TiQQGYKW67RXI7YP6f7IPeeR9YV
         bPN47RXVc8zVXqb86bZ4MxtH3lD4+38J7PLSP6O3rugkPvzzMoGkHDJdPr5ym/C17GF/
         hlO17e48JB92FCgJffw6zBeGb2a108npltuOIbN2BFOOOKPz2ksB0uTR8eMmrnw9N2YV
         cKfzS5yMRdWZzjmJnxlGTB3VKqf4K9ahbgFZv7TsDTu+iXldjEKTfUSkBOFHIuXg6DEJ
         rUH0v/hDfIhOENpwW3qgeBvhf0pH45pP0L/1WFGfJHHac6o0jz9K3bVpZeSETw6b6yP2
         Nigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166349; x=1720771149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygcyp20J2+LIkFpUGmt6p19eExeLNGh9Ae9+Q6pOPWM=;
        b=W0nvI6q3Rc9DfhBCp8ln6vemN65KUzh3LlYJ1Vnn9c7jMoRNwwfTX/P0WuVbZaNESe
         aZ5NUtSN+RDAcRwnbv/LDl7stUpAeQV4FFNbtU4uwh69zG8T3EwWDGGIAu7ChnPyRTz7
         T2qKeZVCKaTPy5s6TedUs6UrnsdtYU0mgQH1h1UNznFJy6uspt2f6VKdXdPSaSXD1lHw
         OhBopx4wHKzbLfPdOrmhJG8qSB35cYS4jWDdjfEqoe0PBwr3Er4dAkdfTcyA6jNPRR3R
         6MvJF9rSxiiGEtEN15byITYKjCAXPLJTq/2ty0xWetDmrvBiUxWf1U6mAC6TYlByw8Te
         8ywA==
X-Gm-Message-State: AOJu0Yz/uA3tm88y17L+aOqHcX5H9LZr/Nhu0BkKlRxprxZtzG8peK1M
	ZyXABzeofWuTAWEoRiW9ewpoPaJIPaOedTWbvmbAe/A9ZJdcrTvO0Y8NiqfEDv8=
X-Google-Smtp-Source: AGHT+IEVSthL/6TxKGR1p9XaW3AvOYF5WWQgzJumdI0bAhoCiQmKRHgfjwgDSW3+jCsg7pJ4K8FfHA==
X-Received: by 2002:a05:600c:35c8:b0:424:ade3:c6b7 with SMTP id 5b1f17b1804b1-4264b0c5456mr34232165e9.2.1720166349095;
        Fri, 05 Jul 2024 00:59:09 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm15315485e9.0.2024.07.05.00.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:59:08 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dylan Van Assche <me@dylanvanassche.be>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/6] misc: fastrpc: use coherent pool for untranslated Compute Banks
Date: Fri,  5 Jul 2024 08:58:59 +0100
Message-Id: <20240705075900.424100-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
References: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=2gIsBIhQ/2HvQF1EyxUO84GUNTMwiRGzOemrHaXwkEk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6fDPw48PuUYqZ+kZebcOXFBXVLihgJlDbNQL 6gwJQK0v8GJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoenwwAKCRB6of1ZxzRV N9+yB/42KGYBE3pAUU4bbT0iCuL+CL+C++sRmcNQDHuIUNtlvy/rRhOtDkRdwWOgKDbs/t6TGUK nN1tXN8T7Pz522oUGi+WlBvbBs8MhJTy2EUxlSqyyqL79ygHmca7U5AxdFPfxpCd7vq1UtukUmK O7+v8VW0yeXK6udlP9vzCWp6P1qe0b77q3QAnsNAvFMi2pPMqC9ek3iJ4WwKWeIiHXRJuUNqemV vA4RkYb3Gliiy3HZXIKWwAA9I1Ho1QoeI7s082VWrwhp9PnDSKSVnH2a4vMy6qRyktOyEH67EgI FS25ub2SdaiQaE1XcJvj0llGxfKYAL3F/yJ92SspT6zSYV2B
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



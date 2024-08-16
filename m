Return-Path: <linux-kernel+bounces-289767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1CE954B82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE772834BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8101BC072;
	Fri, 16 Aug 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUNgIjoU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39469817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816652; cv=none; b=KKR3ruXj0UwdhP05Hovj49R0Ymq+IchNA4g3y3VnCYTnumVNGIeqmWz6kMsPERMV+/OlQRrJENBUh18Uz1+dZz1V7fYTdSLhsH4lguCXS5zt8N4fD6Ok38qlmsf+IJJ07Le6phUcIK+XZzWG54EF91qULjn5advVsCsrIsJPs6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816652; c=relaxed/simple;
	bh=bhKl8LrqSNNy1pCMzfb2la/HnUfCqWNtqkdVM7XHdW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GI5eNrcXedSFRD6BHDvnZyDOiCjbfA7jstiA5vdINcuKZ2slvtRVZ7VNlItUb4fib32qlNWQJ8VTZ4daQmN4y7HFom/ZpFPNPqijvCIWJQKQxa3Jo4ekVO4zaGDIRbc0fcoHPVB+hGneaAXoXSTTv7KdNSBPInlT2cyaZje7cp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PUNgIjoU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280c55e488so10664835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723816648; x=1724421448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUFNUXrgokXIwMs6WyuldKV0ZX1UE+1k07OmPjO8LYM=;
        b=PUNgIjoUp4E6BcHv/9txKXtLNQH6UnoJ8vYc79mK6ktExzy4vFH0DVKEKUMbiBHqFT
         Lud8vllDmLRYVeelE3zoOl14JcUqK6aF5L/5HbtKMtZOGbMBfFBGvM2YeULzkA3Y5kMK
         eVOUIDsDgV0Xd4iXAriM8pRNB4D18/O2UZ+o0yXjbQ3F3U2zDoLCJ10jnWWTteLbOeBg
         RLuxURTBUXfDK/fWvETtdSNkyMcyHeZ1F0tTdxgsvmAjObYmr7CKUWsma3pqdvDTneiN
         2vVqypBE+XGAPHsNTxpet4VjPOH9guXxDxCaQVFlvv34/Tb/T56jCG5nccj7rfGHw29N
         Q7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723816648; x=1724421448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUFNUXrgokXIwMs6WyuldKV0ZX1UE+1k07OmPjO8LYM=;
        b=hkx/TBfQ+3Q2rs7yYIR+F7zP+XDH2bx7Un+WGGWsvxfkex/H9vuVE/aey/mJdT16Eb
         cilUBc4DREPbOhMP2oX0pMNZbCa/0sw0g4l8Ht2WlMNsiB64CDek0Bv4RuecjtMG9E1f
         EcnHr0k/yo8lbuW/tLOMS4gPeWuwuFfkA3z43ipBp3fSeop62BvUFQsz/1tdMdZyTzeL
         83ORlCd8BIESktDNf+3rSQUefmhWfYi3YDwBzYqN3tcR6QZMM2+BhGEcBRIV9Itoy0Uu
         n9BRUjfHKG26ds4NPQ2zr7ZQgisufhXimKN2LHOU1CcrTqcVuWdrppUyfk1ZEgcmXlFf
         YU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSSShOWqQx+1UcuRqdcxBcwdKoXlrXYLdhDFUnWdR8wQa9G+Fq8QxrfeiFyhuue/p1y68oTUxnzdJnphqFzc1WhXofPnptriPKAIkX
X-Gm-Message-State: AOJu0YzRrboz2OXpPWIzbvM/q/tEa7KlVdL1uk2TuIjIURziVbD5ElDZ
	eKflc33iUywIGev32HtPbCVUSkiLWTWoPnaX26oGuFPMVQ+XoRNNp2XLTOdjM9Q=
X-Google-Smtp-Source: AGHT+IFd4s3kymirxsu7ePVn8TcQO9UzOm0dQNnvzYRLs823Sud4ew3QO74mnMOX7OeGvHmgZRcr8Q==
X-Received: by 2002:a05:600c:450c:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-429e232b8a0mr48393265e9.6.1723816648319;
        Fri, 16 Aug 2024 06:57:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36a95sm76183995e9.28.2024.08.16.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 06:57:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Timo Alho <talho@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] firmware: tegra: bpmp: drop unused mbox_client_to_bpmp()
Date: Fri, 16 Aug 2024 15:57:21 +0200
Message-ID: <20240816135722.105945-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbox_client_to_bpmp() is not used, W=1 builds:

  drivers/firmware/tegra/bpmp.c:28:1: error: unused function 'mbox_client_to_bpmp' [-Werror,-Wunused-function]

Fixes: cdfa358b248e ("firmware: tegra: Refactor BPMP driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/tegra/bpmp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index c1590d3aa9cb..c3a1dc344961 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -24,12 +24,6 @@
 #define MSG_RING	BIT(1)
 #define TAG_SZ		32
 
-static inline struct tegra_bpmp *
-mbox_client_to_bpmp(struct mbox_client *client)
-{
-	return container_of(client, struct tegra_bpmp, mbox.client);
-}
-
 static inline const struct tegra_bpmp_ops *
 channel_to_ops(struct tegra_bpmp_channel *channel)
 {
-- 
2.43.0



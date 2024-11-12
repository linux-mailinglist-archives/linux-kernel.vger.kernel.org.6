Return-Path: <linux-kernel+bounces-406822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC39C649F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C821F23D76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9C21A716;
	Tue, 12 Nov 2024 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyo2CS+1"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22553219C8A;
	Tue, 12 Nov 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452404; cv=none; b=ACwbtbq3m71GJ1CkQ0zLZb3ey/BHehp5JTEBRV8r1sZniqIBfndBKYmx0MU4tKHodA9ICVQzHHNrKzMdyxvbviB+NfyQx+1rDCFL1KAJA6PxpUAOFuLe24+bgvyGyibH9oD7UEUGOjLljys/mJXzpt58GFZC46fSPTE7YcMQelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452404; c=relaxed/simple;
	bh=bu+NuDLqu8Tt0GAr7mWfQkamqMac6Nu0S59nZNhC4yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/DYiS+naDWYhBin6IIKpvgbbBPgOdeZZfHzBWqk/rMBjhLUhk9sxPTHO2/Pko1bKfSJKGT/A99WdyyGMLnpFdniPI6qjdOpgCN+vK9aQoq98dC6JN0v5Tyykx60VVqB5bJLkYmlW2T7XhdJ081p3ZZjBVpsDpxhdXkzVJAucBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyo2CS+1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso4743793a12.3;
        Tue, 12 Nov 2024 15:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731452402; x=1732057202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxGJtOVUJmjNsQkVksMPVX9avuA5j35JW80Om/0yQ/g=;
        b=cyo2CS+1fUrmgUp6SnfnnsUpNsBLoXVYDw3Xl/0jWiI8neIvzvXSg/TxTUtSb+B00A
         0l37xxuy6WibWEM+VfLtjQbsCwDAer4a+XonWjxsdSwSfehw8CKnB1xHRqWyJw/Q8SPb
         OUjEVrw9T4Mw3f2eogDuv2ZgYc3CKwfm26504be87zqctl4Rh6tINPfOCPiaqyTPP/ib
         1YGc7V0Tjgf4rOFxLFfg5qQ/Xuitxq017TnXRsPeayhVHc/Nv1EJ96D/qA9XBFXWKWfN
         Mu0PagYRIC5IuBh3N28aIrGnojB1ohxuTw4XLcKhHSZQyihc8OX2EKtrSzAVBnRP14yp
         lu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452402; x=1732057202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxGJtOVUJmjNsQkVksMPVX9avuA5j35JW80Om/0yQ/g=;
        b=iIXPvdbGx5BfNy1ubZprlBN0FyeoBsYh+hUarKFrSQ+mYbLDHf9JttURpDF+SE5StF
         ghWV+gdcfmhRzETNgzXf77k7xrPQeXeIOguYthoGR2UO9w270wYbx2qMbqTLNISoVuVN
         q/V8x2pcrgpOVAsr+fWd42DqaIzDVbIsaSyqMIWgLv1e+qn7QUi1Dzv7nQ8rRWeYx950
         t2RsWyAEUTZ/tdCPB+fCcMD86oYVUEvBOJzybaAqTNVLDDbvpmpUnNyBj46omy4M2nvn
         nj33J4HWfRtGGh/gyz9rHl35dkk/xEL5oT2klHUuUzUffIjMNe0S5tLmaC3zTtOMbo+g
         as8A==
X-Forwarded-Encrypted: i=1; AJvYcCVhvy8ob5W+zyLc/yyT5mUPnhiPwsF67YzEb1mHkYSEXi/FWuUjckEpq42pu6V1uAx6W+BOPvi1SPV8KHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBI8MCGib+Apz2fq0CyH4CfSVUhJLqIBKnaZv73cdBOeUTCc5
	Vb9pqekCCTxWyrXS4ZNmq82IcHBFcPEv6dATtbErLO/aVF0q/tv3
X-Google-Smtp-Source: AGHT+IGlM/Q+IQEStypGsVSlg3I78WcVmnJA9w1qxDsSZpR0/YSwvVax8dEdRzV6/Pbqi/o7IFm0HQ==
X-Received: by 2002:a05:6a20:9188:b0:1db:ee36:8fb4 with SMTP id adf61e73a8af0-1dc228961dcmr28335661637.3.1731452402310;
        Tue, 12 Nov 2024 15:00:02 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f67f079sm11129563a12.85.2024.11.12.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:00:01 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH] clk:sophgo:clk-cv18xx-pll
Date: Tue, 12 Nov 2024 14:58:32 -0800
Message-ID: <20241112225832.3518658-1-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initializing the val variable of type u32 as it was not initialized.

Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 drivers/clk/sophgo/clk-cv18xx-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sophgo/clk-cv18xx-pll.c b/drivers/clk/sophgo/clk-cv18xx-pll.c
index 29e24098bf5f..04a0419cab4e 100644
--- a/drivers/clk/sophgo/clk-cv18xx-pll.c
+++ b/drivers/clk/sophgo/clk-cv18xx-pll.c
@@ -87,7 +87,7 @@ static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
 
 static int ipll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
-	u32 val;
+	u32 val = 0;
 	struct cv1800_clk_pll *pll = hw_to_cv1800_clk_pll(hw);
 
 	return ipll_find_rate(pll->pll_limit, req->best_parent_rate,
-- 
2.46.1



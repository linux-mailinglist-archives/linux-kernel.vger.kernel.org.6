Return-Path: <linux-kernel+bounces-233814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58B91BDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AA07B22E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B081581EB;
	Fri, 28 Jun 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4djO/7j"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DD158A17
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575186; cv=none; b=dUwfCSYcVjDwQvYuKq1ok1GlLMrX8bX/K7F5kp/O7+M1e9y/Q5J8U7UrkI2PKG3JiGOwEBjAzgN3uOL8VyEjQOKVm36NRFvSMLQZNzUvJkREQ+84Qh9li+NnX/vsTvxt3yBpwhZ3pgYxDAe+y2I9gdFxc1WlCIaXwR8W2eaLZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575186; c=relaxed/simple;
	bh=DXhEa8mGqiWV/qQK7qT+F73a5TFS4VUjTrj4t5Gaa2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3BKYGETEvBgZxW6EyM8NJSAutdM/4jUfpDUrdf72xU33XQLpWwoImzbSgoYZAq7glFRpCPLe2yqJBIZz8o7rpPaqUd2RTtziYxg0CyW/qru+hvGOIX8GzFZshPWkYjBpemwhEhx4H55g0usgf7OWIKS9jsN0pfMr55AurFHaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4djO/7j; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4256f102e89so2913195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719575183; x=1720179983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPLR0Po0Ek7N4GOPdSb9qWqsRn4oLprs4RXHqoMld2Y=;
        b=O4djO/7jSx0T9wCHFyB4GXITb1SmoI+wdEhds8jrZwvtHDhcVPeUCz30THMDV/ldY5
         P1+TVAqwoMgILhsWvX/YZtfe9DVkaPRMXb61F8ZGI3ZI5l5oWoYvD0kfPbjA8Sw1+PP/
         a7VNK/x70TyzqeyDvvLYlWCufqCQDgFEQ7pRkdtK0o9JbZszGerGHpKbdRHjCtFhxx9u
         jIM3W5xm1usS/GOkLzzP021Zbo5H0hYr20VfoMuyHJEO+JozXiCNSnG5JVOYEbpdWdna
         KwkLvctE1Rd1rHHzV75X7HvvlZwevDY2Ykvu7o7JAglLgvKxbG0s9UF7HkLrHTb+rc4O
         WezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575183; x=1720179983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPLR0Po0Ek7N4GOPdSb9qWqsRn4oLprs4RXHqoMld2Y=;
        b=QKEG9ZAmLSxld0O+N/v94y9vMWjzjWkRa4s+5OtIjGnRxrEfc0z1R9O85och/qLHZL
         kfowbaUCvCM7SvEGUPbT81vBU10KmCdaSjULF9WG1peKns7RxKs4jcH85KmrB/E8ivJZ
         +e3L7hlyXCoLBYcvABgWnX2T9HD/6hi+/OvF/sLFqchAsmbHxlFQ2MiYQJUDCRzwsyIu
         mblvDNi9+nnmRzBYa7ByopdRLC30PBOL461YId5plllVDdo/MIIUu2mhhbqu7a5Bfy2c
         o4vcwgeCfICZHaXuQSX8LdsOm97ZwOdPcuax763DAMssmlRDxFlHKIQAYiKIVS2TlC5v
         aMTA==
X-Gm-Message-State: AOJu0YwBW/6wgn8qFNI0qlenrSR+J+d91i+WG5HwZ8FTWORnJZSAYe/z
	aOY8c61m0c8NL0qsZ/k9DiruwTA9gidTcgbr3f9+skzWjVYFoxb2anYguZf6Ctc=
X-Google-Smtp-Source: AGHT+IG5N34XjI0I2joDx58QWWB42JCMq6eFPMOUJ11iQz5fyZCm20rSBGIP/5XIpTNwbdzQu32C3w==
X-Received: by 2002:a05:600c:929:b0:425:65c5:79b4 with SMTP id 5b1f17b1804b1-42565c57b9amr34256995e9.26.1719575183503;
        Fri, 28 Jun 2024 04:46:23 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm32721345e9.1.2024.06.28.04.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:22 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] misc: fastrpc: Fix ownership reassignment of remote heap
Date: Fri, 28 Jun 2024 12:45:00 +0100
Message-Id: <20240628114501.14310-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=+lScpHOuKGC7U0+MQ0TMTpr+mO1mgPe8J9pSX6cDz8U=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqI93u/zuGpO+NZ+wA6IQ1XiH8XehXjFjUJoF 700+9jcrXSJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6iPQAKCRB6of1ZxzRV NwsGB/4xJjR7nINyR8hB0K/jNNiHQbzO6lOnzYCfFpZlfbs9JzY2SgUlrtHaEoZz41knCYARxc9 LW9XscIn1tgH3sC0xeFi/Gs2mrb0cRQehLZ5ZOQ2xwSM4EIrS03rrHYFtVIFAvE8ZmtziHFMV57 umsoiN3rUqVSALlY+otkafirD1PkuNZ+QAGpAqedIBN19OdEQPlcdzVPtt8Vknjga/u0MWtKkYQ fUENzBqnbnrz46wbvoGgIHAOSEVdmazfbl0qoppSazfmeYAUh6xwcVrbKDVm1o5A5VFSk7cECss HO+BNBd8Hkk5/ROcrQxr+w1dyYjmwafp30dY/2wObIHC3gKH
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

Audio PD daemon will allocate memory for audio PD dynamic loading
usage when it is attaching for the first time to audio PD. As
part of this, the memory ownership is moved to the VM where
audio PD can use it. In case daemon process is killed without any
impact to DSP audio PD, the daemon process will retry to attach to
audio PD and in this case memory won't be reallocated. If the invoke
fails due to any reason, as part of err_invoke, the memory ownership
is getting reassigned to HLOS even when the memory was not allocated.
At this time the audio PD might still be using the memory and an
attemp of ownership reassignment would result in memory issue.

Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 11d53b9322f1..5680856c0fb8 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1238,6 +1238,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	struct fastrpc_phy_page pages[1];
 	char *name;
 	int err;
+	bool scm_done = false;
 	struct {
 		int pgid;
 		u32 namelen;
@@ -1289,6 +1290,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
 				goto err_map;
 			}
+			scm_done = true;
 		}
 	}
 
@@ -1324,7 +1326,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	return 0;
 err_invoke:
-	if (fl->cctx->vmcount) {
+	if (fl->cctx->vmcount && scm_done) {
 		u64 src_perms = 0;
 		struct qcom_scm_vmperm dst_perms;
 		u32 i;
-- 
2.25.1



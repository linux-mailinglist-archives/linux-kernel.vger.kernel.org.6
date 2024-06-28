Return-Path: <linux-kernel+bounces-233812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768791BDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B339D1F2333E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E41158A09;
	Fri, 28 Jun 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js62zKyV"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B2158845
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575183; cv=none; b=LZB8BswgEXJqUXAmrKzEUIqNnZNZLULDsp51E1bd8Ln4b2sdHlDyusjxhIsHZdXF40ZC1Y3QoAm+bd5v93i8e2fQyn+y3q3oq0lVdQSF4J+rtxNg6B2t9Xv1Fz1KMeEHDEl9M3tCQJV0mEjn7dm6gWroXHwSfcbqZNuS73dO+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575183; c=relaxed/simple;
	bh=6g9UiIZEdVKxbWh4F8n7gJeFwdD4NlgvUF252NhJ/+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZigu+eHEn86sQJj1olMbqXjzskcMW90CM8FGvmKCChhZ4tugoHVt60hIst1divL2bBGMXN4yFkiidFFqQ/FEYZf3gf6SxzKamn1vXgkEXTHJLy1ysV4hDt7NaVz7ynn3men8fHp/IrdvAEsznjzUHA9WEFJkXdRiBKhoONPWAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Js62zKyV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so6655121fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719575180; x=1720179980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBtK7paKPhfq7zwpsh+mBHknmAH54FUcre0qQXSrQtk=;
        b=Js62zKyV0dF9+P0lKuyhBUucCsoeU0/Uig+mpjEOJzpZRdE95OY/wghmfLA+rmyj94
         9uiP3I75sk60rjahtNZy1ipmL5uPsoT4BcGfkOg3ksYgkUtxbV30exjQyKPCCoC3LUoP
         /tRRxhIWGUgG6BifK7WhxsuXlnK7sGWBWpC4OZZxbgIid6/xOrd/9VcQ1vNh9c8K2DQk
         bxVpW8zW181FMsnQ09fDw5b4oMT2B73sr8BWuyFrYXWbXZpwdKqIaBkUSJFt0Vd6nXjR
         ZzyHBHYxgPOZiwr1cvnyFiDysf+w9/vo4sA/osqx6OayfxZjS14WFPZUcTwCEUU9LOcs
         jHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575180; x=1720179980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBtK7paKPhfq7zwpsh+mBHknmAH54FUcre0qQXSrQtk=;
        b=X8/bRaItKN1hc5rEiguhiwFN7yGv8gto6bGre9QSIspTbRDJHavkQSyk2yx7himBGF
         82s6e+xmx/hFAAm1/gAqDk0Gm4z7xGNmCMwwoXQTtl81w+mYukQMfiqNM8akes7a6MWm
         DP9ESLfxDlbiU0DV/673r6YEwPPGOMlULcCkdGgYamtm1cUNpn/kMU0I7ff9XEySHPlY
         tgZI8fJAwkUAGeEAB5E08V0FIPmI6rsce35MM3Vm0ICDqdIUhzaZUoP7VxyTxN6wUmQ8
         6AYQMVV8dHtao9/JZDGPnGyvIm1v2kn2D14bXwMgtrfyF8IynheBbEIPOQAByI8EdKj/
         J+3w==
X-Gm-Message-State: AOJu0Yxq8PWJ8y5yodztPTa1dvHBim/ZgfLlpO0iq4V5HbEyLGb8U8iZ
	Hk7mlRO0vQzRhF8bph+a7w1VxJ+80a87BOKABSufT+zemSiyfKRC3O1xamnPkK7xfZ7gSD4bQrK
	bHOI=
X-Google-Smtp-Source: AGHT+IEmeDnTVu2xMxUnXBGnRXw1GCBA9y5aFVxOvTYb0U3V/dI/2sxYwOK8gtwzRsHueMp9Puq4JA==
X-Received: by 2002:a05:6512:467:b0:52c:da39:87a7 with SMTP id 2adb3069b0e04-52ce1843951mr12479896e87.41.1719575180312;
        Fri, 28 Jun 2024 04:46:20 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm32721345e9.1.2024.06.28.04.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:19 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/6] misc: fastrpc: Avoid updating PD type for capability request
Date: Fri, 28 Jun 2024 12:44:58 +0100
Message-Id: <20240628114501.14310-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=niskVdv1eY7bhTkNIrP3OiXHlYz6PMSZRBavdNmw8Tc=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqI9mjGfDD8BF5zl9IQ2S4Wcpi72ShoFAQxIl kMyKyvPyU6JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6iPQAKCRB6of1ZxzRV N8KhB/oCKthSZJ6qRSGHRd6Wg3UGNc+hjIKiZ4huBvwpiOpfgkuQ9hKRJx+v+P8WNg2n7qBKcX0 RoJog4Y4tASpdeWHxsul7yqjccWJ6BEP8tWycdXvWPyb1j1ye3oiw8WEpEDAUGR2zhp63B/IIlI jIlDXn0a6mVejs11hjO26dGk0tRch2yY+cTpxLddgdN/rr7Xte75N6EhnGht8tU37VAIlHzgPTh j6dqrd1ejpQ1OxHPChs1z10x67ut+pYI8F52gbcJhtruwyDzgrX86LHy4ckWs9vSRteVVNHlhcA oX+VGVswAEnIb5Eb8g9G74idQe2MkpNhnS5FvR+6RHC6VnTA
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

When user is requesting for DSP capability, the process pd type is
getting updated to USER_PD which is incorrect as DSP will assume the
process which is making the request is a user PD and this will never
get updated back to the original value. The actual PD type should not
be updated for capability request and it should be serviced by the
respective PD on DSP side. Don't change process's PD type for DSP
capability request.

Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 30b93012877f..3fef3eecb88c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1707,7 +1707,6 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
 	args[1].length = dsp_attr_buf_len * sizeof(u32);
 	args[1].fd = -1;
-	fl->pd = USER_PD;
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
 				       FASTRPC_SCALARS(0, 1, 1), args);
-- 
2.25.1



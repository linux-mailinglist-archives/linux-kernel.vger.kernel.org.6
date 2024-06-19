Return-Path: <linux-kernel+bounces-221171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2690EFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318B51C2139D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68650152181;
	Wed, 19 Jun 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7yF7jEU"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0395E15098F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806150; cv=none; b=tRgyjcl4ElUNoA8tNDKtAOi28Wl1OMCiZb1ZUzIa8macjwFGTsWZNvGwDnW+HvQixNnII4cug6gRjtcMegBbwZ7Q9QZZik7dqiTWKmzBckXyxN4aYQetcABI1IIIjC9zDPRWf6jX3rNsJI81sNgph9UdY3VbZyz6OA5YjoO8etA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806150; c=relaxed/simple;
	bh=p1L/5WV4IXuFQfEzRqNkQGg76bWmSg2tiKmoi6P2mIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ziz+UV+hHqJG3ErA4Jm1/BPanB1FRijEN//9n1/FT7FC0oh0bVFAtUnU2OeJ1NoRbnhN1tIwBP74i4udpel1D8++F1MVSlraiH419Q3F9xedau4YV80XK8EMdEYl3iMsUHXja874jizp6yXdJZ6Hv2MhxaOijFAVb9rfiNFFYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P7yF7jEU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5295eb47b48so7712524e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806147; x=1719410947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1K1pfLjx3yXde9nph0uxH/MYhA+YR/At4AWwuoRbU0=;
        b=P7yF7jEUQoKqne+fN5LFnkYRcW2vYKJBuVwDTBKCLV+ub0r0OJBbgaLvfyfz0Um8Te
         N7TB4ly/88uZV0qwc3F5Xqp++h/U8PpstQXa5UlC2b2D0agiTPydkibtsdN0TODEXmUI
         BFty1N7iv28efjLTE8rWeLd95/IJ3rqYN+nT2WXkLyBxrxsMeqse8fv1lpN2IoEd3VKA
         WGcq1ahZnu1zHciMKsDfZhX7mWmlbV4LyHW0Bw13rT9/23o3n6kHxUNTXmh1WqxFOljZ
         FgWt/Uqy3k4bDU5tRxfYBpAGsJO2NL5w1TAjlpLAI0AhIZOlHIuA7qBCZ2Nw0Nyp7mux
         n1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806147; x=1719410947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1K1pfLjx3yXde9nph0uxH/MYhA+YR/At4AWwuoRbU0=;
        b=HzFpJz4VeGd+B6X1wJlbNAzdpStu5LB2nQwIvqrz6aXj5HrpdUioHAOfFGa/NnVD3a
         vo6tAfWv4zRMwutV09qIkx69AUBgp0DuWtqt4Mrv7ZnjNaXsQzzPoUlGz+oMyy73TYN7
         f55qcu5KFbAztOl4c6/F4lrINKeM7twPMn5lbVH0dfosmxCJcAE32woZGwSQMA/iRNEZ
         UkiSxb3GDJV7cZQW3589Yw4pPG3fcnimBwtuOWFigqJiyzZiQjZNXi01rDbgI2KsLfAo
         TJax3/TOp9VheGyi6bSkNrDJDk8zW+FgrbPNhVGrWk0Uk6EWTVquiJKGJ7kCUu8f0MAa
         f8hA==
X-Forwarded-Encrypted: i=1; AJvYcCU/8DmGPZiCZZRsaeTXq6A+OhYsX0jtfYs0SwlN6AP9ePUrqTs81uSbL2FLKGbsfuafTavRCnd/SfQnR+ejhwNLLNktJywYmdcGjpzS
X-Gm-Message-State: AOJu0YwGXcY1BTDCaXPjoJBJBv7q1p5WGxbb4XKFdox3L63pRtfV6iJo
	4NZ6Q44WtOe9P/jNw5ne9o0JGDuVf+p0lPXuwxYFE3k9SPHeG6rqcpEcvTDwLOs=
X-Google-Smtp-Source: AGHT+IEVGpl8euILARdKcz9t6ynE/gJP+grfmU6GsH/Be6u3fMQfkdUuTeM52zWE+8c5drYOKvWenA==
X-Received: by 2002:a19:7006:0:b0:52c:c725:9d16 with SMTP id 2adb3069b0e04-52ccaa5f3dfmr1796341e87.30.1718806147197;
        Wed, 19 Jun 2024 07:09:07 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:06 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] OPP: Drop a redundant in-parameter to _set_opp_level()
Date: Wed, 19 Jun 2024 16:08:44 +0200
Message-Id: <20240619140849.368580-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The in-parameter "opp_table" isn't needed by _set_opp_level(). Let's
therefore drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 45eca65f27f9..02ba963d11ff 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,8 +1061,7 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
-			  struct dev_pm_opp *opp)
+static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
 {
 	unsigned int level = 0;
 	int ret = 0;
@@ -1113,8 +1112,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = _set_opp_level(devs[index], opp_table,
-					     required_opp);
+			ret = _set_opp_level(devs[index], required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1172,7 +1170,7 @@ static int _disable_opp_table(struct device *dev, struct opp_table *opp_table)
 	if (opp_table->regulators)
 		regulator_disable(opp_table->regulators[0]);
 
-	ret = _set_opp_level(dev, opp_table, NULL);
+	ret = _set_opp_level(dev, NULL);
 	if (ret)
 		goto out;
 
@@ -1221,7 +1219,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
-		ret = _set_opp_level(dev, opp_table, opp);
+		ret = _set_opp_level(dev, opp);
 		if (ret)
 			return ret;
 
@@ -1268,7 +1266,7 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
 			return ret;
 		}
 
-		ret = _set_opp_level(dev, opp_table, opp);
+		ret = _set_opp_level(dev, opp);
 		if (ret)
 			return ret;
 
-- 
2.34.1



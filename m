Return-Path: <linux-kernel+bounces-233221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8391B47A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12ADEB22757
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0661E495;
	Fri, 28 Jun 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xax8yphb"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3463C7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536843; cv=none; b=gLjZtYs04sNfU2oeBpyx27Afim0IS6rsWcGzmt1aZDZAsIlapqjXxDDvsZt5bn7b81JEgcKDSRwpmqVtnzecBXBa20a2Ur+Yow/75Pw1frEGAEz1Oy92S8Qjw76mB2YfmVK+hj8jdqWi2oTxrwOJu+tSmiqB1EBoDq29HfB0PeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536843; c=relaxed/simple;
	bh=KI0YAwoE5tOePJ3OE78J/FukHKyRQlV6qp3tvk4r3uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QG/oSMKuzTWlM5Cn8FJOzrE7UCRXZGSwRBXPrgtubVS/76l8KN/XGiZflbzFUF19xPE07eSvBEhwvNPqaP20vdBrLu18jbWfoSa/lLPUklkCTW6zZwkkc2D/Ode8A1Xm/bAEBopM8twaK0+FBImsibbeYYUc13IOuaI4+EH9NHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xax8yphb; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4256aee6d4fso401875e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719536839; x=1720141639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tG1DAtBscnbl92897tEGafV+QEn7b6lppJT5wBhQF54=;
        b=Xax8yphb/1oEGWWBptbJTKbZ+H+HW8TUc4uvFpSQ5y/NPxnMKQUrIhSzPatqsDlliw
         Kh0sPbcGdH/PUb4ZBOkthWV+Ltf0RyYE+ito07k7Zv+1zto/px+qG1YSEstfSImqiJXA
         TtXNAIXitnJ/Ng6BULAu20OfSaHZVu6bx0CTksHQz6qylppv5SR9TuHl0DjpACVzPUqb
         qtNmavZPq/EI6DcqgshUtiu0/5RjspBlNrNJCTVARV3rqysjt+j4F4ZeoQe1DgRq9MgN
         IGi1mJN1cvpObVE/Bw8hGFYELrjWD5YgO08PGXHPT6kFxw8w6N1wsNr/ikwZ247+w2BQ
         NPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536839; x=1720141639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tG1DAtBscnbl92897tEGafV+QEn7b6lppJT5wBhQF54=;
        b=epGX/w09tNyPgXw10Ymc2cdxeBNMLxtYMmtN9YSUudRYIMALSco/Ubhpam4EHpeFuj
         9pXyMqmKiByW184jb7CuwajggbXBCB3bWOMwQjlkPvPrNnxKec34xrwKRywuxF9xvpFo
         hQL4iWMl8aLbUA5XCy+4Auy87ade8FKCdBhwSbWFf+FmeogWEEoTk95qjUPlTFRIGCdV
         6Xrd9S5CrFikNTVne8nD9iKBDSP0rCtL99wA6EKcJtFRtZvWnXibyiOAilprKtY26VdJ
         muyTw7bh5WfBDlTXmdAJ6o37ecKvxvoTkJRqttOZMshac1HwS8WWSYSNQ52/AoTSZqZU
         GEHg==
X-Forwarded-Encrypted: i=1; AJvYcCWx93WRb73ar5LXLtu7lR64bZnKdg2X/T9v27/VxRqfLvi/UyDU6sj9BdjLdTI6wxwEof4twL7QgJ+JTHCYMqTuxbz70uc4ZYx2qYX7
X-Gm-Message-State: AOJu0YyEyOcUMXRN4OXK2t2TB/bkVG+2KfY2FsQQRur93ehEkbdR8RWd
	Zf40/h1MLrdE4GTuSdUrPseQfVaCuClNBhPQ2DB7mixewnDKOwrzthaK5kTdzlY=
X-Google-Smtp-Source: AGHT+IFaXp+aeAO1CS/cju1lvX6fP2/V5KyNto62ApeEBvJ1oGHUvh4DgDlWfDnP07O2Fls30BjBHA==
X-Received: by 2002:a05:600c:491d:b0:424:fb2f:9d4b with SMTP id 5b1f17b1804b1-424fb2f9f55mr43198915e9.21.1719536838893;
        Thu, 27 Jun 2024 18:07:18 -0700 (PDT)
Received: from fuerta.Home ([2a02:c7c:7213:c700:2cd1:b0e8:abb:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c27dsm13075805e9.7.2024.06.27.18.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:07:18 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	elder@linaro.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	alexey.klimov@linaro.org
Subject: [PATCH 2/7] ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string
Date: Fri, 28 Jun 2024 02:07:10 +0100
Message-ID: <20240628010715.438471-3-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628010715.438471-1-alexey.klimov@linaro.org>
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "qcom,qrb4210-rb2-sndcard" to the list of recognizable
devices.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index a15dafb99b33..50e175fd521c 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -166,6 +166,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id snd_sm8250_dt_match[] = {
 	{.compatible = "qcom,sm8250-sndcard"},
+	{.compatible = "qcom,qrb4210-rb2-sndcard"},
 	{.compatible = "qcom,qrb5165-rb5-sndcard"},
 	{}
 };
-- 
2.45.2



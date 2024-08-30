Return-Path: <linux-kernel+bounces-308838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B984C96627E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F3F2870D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7E1B6545;
	Fri, 30 Aug 2024 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLYUX4J3"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D61AE056
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023000; cv=none; b=SpK/emFcEJ5p5Qq4HLiJqgjfziHtanvlGvF8Nl2yWVz22yxMRdQmWiAzk32lJC23T2zG3yoqO9lnbbzX7sAmCaa0ZFc8dOm59s+GpcJu1KVx7g1BoAV5q4pEpalip3G3wnbPfO6HvVI9B5LxuVpSi3hKfIZepVXzktvFDLUfHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023000; c=relaxed/simple;
	bh=MvE2RHEdT8Xj0MN5+TcXChbjAgu/9HVucOxy3lO/Ufo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtaAgnB3xC9qjyoj1dPs+LcKG05DMekXmki8DrnXIbDbCNpnCnDM/UiE2zx62yp4TFvX7YFlEsVrb6iIWUWm0u9W7jS8uZ+iwFpGkuel5Sk1WpFsyBcjs1RNYFP7dCTEUMxfN1DRwTzqwEJjujK/8Q+MFsptBgpJdIrnltLVz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zLYUX4J3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-371893dd249so1306438f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725022997; x=1725627797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G4GSnsP/HSvAv8G0cBHEEfYfdU1eVDY3ZlJoxKRkK8=;
        b=zLYUX4J3MCKg1oVlaqm0Y+Nhe2OzFEaeG2qNFwc/mJoP1+MBjPQQjfs0LO2oSj9+Dq
         u1NAarbBqfKMpTHYd/YYXLRFRIGO6CT8HkCVbS6dptJgrBILh9FYCGBsxW3/1yND3YVa
         bxu4iDPHYxp1rjJy9pNmdyXRoGNg3s3pSy9Ilt+hDTpCA/AjuZGy5N88tZ+5gyOhWsXD
         IRkgxySE/KsUxF5xtOvzUJMd1BreECF0iqBbCan2/GwvAv9U/3218GBXtNl/qbE518Og
         dWrJYQOii8/rUKwA5AOt2ObfrofAgI06zY8Q+IH9Ne+lIv+FjVerKDb0Ly+d7B1maqO2
         r/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022997; x=1725627797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G4GSnsP/HSvAv8G0cBHEEfYfdU1eVDY3ZlJoxKRkK8=;
        b=jzpsQ0A3z6jZqvqVOfZWTwjpQhajCP6/W39bttSdmqLpMUg00EOrJqedExuMZmw2HI
         TWftyXUEOqvU96YLnemI1m4f/gZ+rnCHBbvNldzTGWbvpEbvPPO1NA+7Mzuh3RvflR2+
         bbNt5yqiVIOvEJbmbzABsA9EKMqBtuOwD79CQqbSCqCrDaIDBAP/7rSsJf+puNUNP0x3
         l+gcu4XyFuAk0oTI5jbaxz7ytqiGR2vOU1qz4thBPskWStsJaPaxec9IWYtfigz/tUYp
         ejF5QsuuyZY2IgjXBiISw9MdN68TCq5KqTnoO4DiIhffy3Q/pNJIHyq2tWCygAs8lfDl
         MOAg==
X-Forwarded-Encrypted: i=1; AJvYcCUAmtAucWLoMQfQ9Cksy0NyZoo/leKJUdfkiTCAP0LPfY3mh7CA1bFRml2/dVH00HSPW2HbHXBlxDJwafA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FWF/ee3F+1v+NDNLsbefpPd3JrdITUdIyr8bKslQnmU+3HYx
	Cx7hnHAZn9ecDpesZ2h8cAEZIA6ko59lp3Bj7lwa4q3paHZDSqzN3NZf/Z+/uzg=
X-Google-Smtp-Source: AGHT+IHH0zmn4hPpwiJoclfihTw8rkWZegJPSurH29Il1g7OPCRZ0DjjeVOFVmE5sWS47n2zlP6pFw==
X-Received: by 2002:a05:6000:acd:b0:367:8f81:fa09 with SMTP id ffacd0b85a97d-3749b58164amr4253220f8f.47.1725022996715;
        Fri, 30 Aug 2024 06:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3cfc:139d:f91:133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efaf35asm3954076f8f.90.2024.08.30.06.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:03:15 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/5] energy model: Add a get previous state function
Date: Fri, 30 Aug 2024 15:03:06 +0200
Message-Id: <20240830130309.2141697-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830130309.2141697-1-vincent.guittot@linaro.org>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of parsing all EM table everytime, add a function to get the
previous state.

Will be used in the scheduler feec() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 1ff52020cf75..ea8ea7e031c0 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -207,6 +207,24 @@ em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
 	return nr_perf_states - 1;
 }
 
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table, int nr_perf_states,
+			  int idx, unsigned long pd_flags)
+{
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = idx - 1; i >= 0; i--) {
+		ps = &table[i];
+		if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+		    ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+		return i;
+	}
+
+	return -1;
+}
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
-- 
2.34.1



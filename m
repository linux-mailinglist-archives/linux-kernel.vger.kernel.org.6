Return-Path: <linux-kernel+bounces-405605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA589C5401
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D9F1F2239F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B832123EE;
	Tue, 12 Nov 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="GuJF7lcP"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8EC1A76C7;
	Tue, 12 Nov 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407664; cv=none; b=luOiCvkEglE0au8IFE28NYDq6JTBA9N/34OkG6mUs2wsLTdFIRS2mHtB6Oln+Uhb+s9Ua4DsgjmMX9Qq8vhunzfmEz/cz7lQ3ahtc2JLK4RZEhbPtOwCWNPqg+NQEOynnZKFYfFvt4B0eFDxZsgr5+iA7qpUBkJMcbVIOl44yRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407664; c=relaxed/simple;
	bh=u2QG35Qib3QP61ailcKCQZuTrWCBwXFPZ0GvopOEvTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BZt/fd5rc1o3mydoVd0yqjmQ+VEWBXusKIjrOOjEGTzl09oST1pBSEGoIByasgt5cCx7Zjn1BIAbg8p22HYaQdOHYOtW4adzHkkHbFgFGSlPZxdVFzdoAJ/cPDrJsiCKImZSQANpeKZHQIKcZLTMz/086F4Q1kCeS6Ap+4zgdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=pass smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=GuJF7lcP; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1731407655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r+Rsi+aDkoT9MpvrEBvzu12aj7IGZFG8BehIF3d+ynk=;
	b=GuJF7lcPGDYOwUWmYXd4dACuNtvgm925NNtNQZGDXe/bzdtD6itQAZ9Jyuk0EhQTnV59aG
	5sjO63boG1WZy1wNF6zcQRSTcDBHwNy1mmom8ge7f4pn2oG16ozneQw2KlBxUoN24gjAiM
	A2ZORzqj8ZOpWL8zli5I8Him21PiDhNl0P27UO3vTvWI5MafMH2B2A2i2i5eXY/DL70kX9
	7R1mLr0GfMmeVpzUzcgNU8ey6PbbbOhKqxPpwvahUs73SStAdOmOtErcodKq0L5O/S0amj
	UoBcKI0eabZH5qSYtvDGoLU+xFzyvlZBIQl2qgEbG522VvuODg3qq3AHdE/dvQ==
From: John Watts <contact@jookia.org>
Date: Tue, 12 Nov 2024 21:34:00 +1100
Subject: [PATCH] ASoC: test-component: Support continuous rates for test
 component
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-alsa_test_rates-v1-1-95cf529db871@jookia.org>
X-B4-Tracking: v=1; b=H4sIABcvM2cC/x2MywqAIBAAfyX2nKD2OPQrEbLaVgtR4UoE4b8nn
 YY5zLwgFJkEhuqFSDcLn0cRU1cQNjxWUjwXB6tta4yxCndBl0iSi1igtJ7RN23feR+gVFekhZ/
 /OE45f+5k0flhAAAA
X-Change-ID: 20241112-alsa_test_rates-00dab3465bbc
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1731407645; l=1317;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=u2QG35Qib3QP61ailcKCQZuTrWCBwXFPZ0GvopOEvTc=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgPs7MDd2XR
 g2uRE9caV1lPPPeu0VzIG9fPrrVmYyAhLcAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAs2TBc8qM+SRCT9/XpD1pKeM
 FvZLkgKCyfWzk1BS0j+RFLb/lM8sRj0Vqhc21+G5tbZxfRphXS+DwnHAaEWqoAQUAARmD
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:/gEvgms/9HpbgpcH+K7O4GYXmqkP7siJx9zHeEWRZTg
X-Migadu-Flow: FLOW_OUT

There's no reason to limit the supported rates of the test component
to specific ones as if it's a real piece of hardware. Set the rates to
continuous to aid in testing different rates.

Signed-off-by: John Watts <contact@jookia.org>
---
I've needed to use this while testing audio-graph-card2 with a variable
MCLK. I'm not sure if there's a reason why it's not continous already but this
patch seems to work well enough from my test results.
---
 sound/soc/generic/test-component.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/test-component.c b/sound/soc/generic/test-component.c
index e9e5e235a8a659cabffee7acd747a68bd45f177f..e675b69109a8cf39e2462db8006daf6dbe75840b 100644
--- a/sound/soc/generic/test-component.c
+++ b/sound/soc/generic/test-component.c
@@ -233,7 +233,7 @@ static const struct snd_soc_dai_ops test_verbose_ops = {
 	.num_auto_selectable_formats	= 1,
 };
 
-#define STUB_RATES	SNDRV_PCM_RATE_8000_384000
+#define STUB_RATES	SNDRV_PCM_RATE_CONTINUOUS
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S8		| \
 			 SNDRV_PCM_FMTBIT_U8		| \
 			 SNDRV_PCM_FMTBIT_S16_LE	| \

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20241112-alsa_test_rates-00dab3465bbc

Best regards,
-- 
John Watts <contact@jookia.org>



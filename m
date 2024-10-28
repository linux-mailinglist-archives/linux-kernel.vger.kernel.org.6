Return-Path: <linux-kernel+bounces-383970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06AE9B229E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 03:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5989A1F2188D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758E1714AC;
	Mon, 28 Oct 2024 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="YMtu6hZA"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998D433C9;
	Mon, 28 Oct 2024 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081565; cv=none; b=ka6zXQOALSyZbFDE8KeuPrn9GmsPakutzi5vI8Xc+lk/oI4TIo39R+dMHxLkXS0cBMet0X6n8n+AxAOsCfoQ9fhxeZT7iV1vEsrQidFWHqUpFaWNh/FmtcDqZAfTc4gusWjYI5bfbs5/QkWgW5lqwyHr/KOys3Ram7KBppid3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081565; c=relaxed/simple;
	bh=eOWiFxmtBV9Ahj/oqdrWyOdTi7XxRAictG3MytQg5hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gK38R/2QUnG+Lcv07/P0bmV0dvgk22VFg1BBhLEu+MIlQqE3hzSAPaTd9wW8sdJfqKq12o0OBSEoIJTKbF0I9LR+SL9wZfJyMMDcKb2GWKdOTpOiqH9ofMxDK0qFL90bOKLTZ8xKG4qz0PhfPE0h7gyOJQQw0RST7X2Pm1Lmi1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=YMtu6hZA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=jqU5JEHKNpVIYeesdnslpCRBXaVzMn9mDNHN1fq+VEM=; b=YMtu6hZAlJNmeZiY
	yynP58lcGAUoOUsRD2EaiSGFQ0eWXZvb/Z+usLuk03YKxVp1/nmPT/4dX3pJmBasrgBclHtZNE8QS
	RzUthpQ/EnkPm955SFpuJo8aaF9Tn1GY7pTeJWoNp7Pbixw/NPBA9dC3fAiTzH++Wtp3zTrPVZNGD
	DXw2Bo7F71q9KcvFGEpOIRMbieUjthd23IxTDbOLPLpeAXaxhL88CkwrDXvWCp+sLe21siqxRFuh9
	045gdr4yRmbhpOoyxToDFgbmLG/9+AMN6FUSR2j8s6T+jpgSaULdq5mbYmz9l/OQ1jol7hP41vPCZ
	7F/GXLxnyjaZirDQAw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t5FF5-00Dpxx-03;
	Mon, 28 Oct 2024 02:12:27 +0000
From: linux@treblig.org
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] ASoC: soc-devres: Remove unused devm_snd_soc_register_dai
Date: Mon, 28 Oct 2024 02:12:26 +0000
Message-ID: <20241028021226.477909-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of devm_snd_soc_register_dai() was removed by
commit fc4cb1e15f0c ("ASoC: topology: Properly unregister DAI on removal")
in 2021.

Remove it, and the helper it used.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/sound/soc.h    |  4 ----
 sound/soc/soc-devres.c | 37 -------------------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e6e359c1a2ac..1b7ceb018bf9 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1438,10 +1438,6 @@ struct snd_soc_dai *snd_soc_get_dai_via_args(const struct of_phandle_args *dai_a
 struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 					 struct snd_soc_dai_driver *dai_drv,
 					 bool legacy_dai_naming);
-struct snd_soc_dai *devm_snd_soc_register_dai(struct device *dev,
-					      struct snd_soc_component *component,
-					      struct snd_soc_dai_driver *dai_drv,
-					      bool legacy_dai_naming);
 void snd_soc_unregister_dai(struct snd_soc_dai *dai);
 
 struct snd_soc_dai *snd_soc_find_dai(
diff --git a/sound/soc/soc-devres.c b/sound/soc/soc-devres.c
index 4534a1c03e8e..c6364caabc0e 100644
--- a/sound/soc/soc-devres.c
+++ b/sound/soc/soc-devres.c
@@ -9,43 +9,6 @@
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
-static void devm_dai_release(struct device *dev, void *res)
-{
-	snd_soc_unregister_dai(*(struct snd_soc_dai **)res);
-}
-
-/**
- * devm_snd_soc_register_dai - resource-managed dai registration
- * @dev: Device used to manage component
- * @component: The component the DAIs are registered for
- * @dai_drv: DAI driver to use for the DAI
- * @legacy_dai_naming: if %true, use legacy single-name format;
- *	if %false, use multiple-name format;
- */
-struct snd_soc_dai *devm_snd_soc_register_dai(struct device *dev,
-					      struct snd_soc_component *component,
-					      struct snd_soc_dai_driver *dai_drv,
-					      bool legacy_dai_naming)
-{
-	struct snd_soc_dai **ptr;
-	struct snd_soc_dai *dai;
-
-	ptr = devres_alloc(devm_dai_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	dai = snd_soc_register_dai(component, dai_drv, legacy_dai_naming);
-	if (dai) {
-		*ptr = dai;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
-
-	return dai;
-}
-EXPORT_SYMBOL_GPL(devm_snd_soc_register_dai);
-
 static void devm_component_release(struct device *dev, void *res)
 {
 	const struct snd_soc_component_driver **cmpnt_drv = res;
-- 
2.47.0



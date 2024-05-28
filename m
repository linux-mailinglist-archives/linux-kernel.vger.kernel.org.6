Return-Path: <linux-kernel+bounces-191616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B68D117C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27501F22B24
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A61DFF5;
	Tue, 28 May 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="WFyaHz7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPPNYM2x"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9E1BDD5;
	Tue, 28 May 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860214; cv=none; b=cCf0h97pg8ZZ8EwmGnTzYMNNOjGGgtTHSzasRKufmNXnnxi4Jwck2mD8ZCjPF0cAXzeGHyb9zHCMRyildGyD7b517QmNwEMMutWtNPEu/wjuwF0AmZ2Bk7mhvJAy+INGa/Qxb7t3JBkhp69WotIsDdrJx5duYVLTyixFYB++g2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860214; c=relaxed/simple;
	bh=ItassXh+AUFWJJQOX6KSfktnJt4TTmMNonwiy+/h+Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPAIAQMRcT5R+4EqNKq5ZOZ5XJbAUnbrXUf4BVN6odGq48BLzlNF1gTy+Chwt4qOgSAjY773yodWjMK7mW3U+DrsZHPb9dHiA6QKE0MohGLtgHrjS+ayik7zmbO6XGlBSprK7g1Xs0C16Nw0/9+lV2W/tMc0RIdX+zcIao1bsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=WFyaHz7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dPPNYM2x; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C79BC11400E2;
	Mon, 27 May 2024 21:36:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 27 May 2024 21:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860211; x=
	1716946611; bh=hORT7ngd02w+eotRPxOFI1MpB1jcIPhVVq4sYj5WU7k=; b=W
	FyaHz7JWJMD+s+0nNy9FpUgBjNpDq7zaDks2ThFjWNpExS2+WzqAMeOn8Znh8ajK
	6g8p2CImVwInvl3I4kzGCLWa7M0igS531+MulVccIj0WObZlIP0cqwScTICxEv7K
	d/aEVL5gRj5WpO2gusK0Yp0UkIvluvwMeLOobuqFKOtqo/FL09DVj3AuZoqIbY9k
	sS3TIYXKClttUB9HWz5uw9bRqxmr10hGHIz/CSVhueOdXEQWp+EBiRv25/IACYYo
	XlmrOKz1OFviTWL9KbGLGftR7Goxwk9J7pRVV1+aRA6p+y+kUDIerFreXUrlDiOi
	jr0mWKSPpGd/32TG8/HyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860211; x=
	1716946611; bh=hORT7ngd02w+eotRPxOFI1MpB1jcIPhVVq4sYj5WU7k=; b=d
	PPNYM2xIrR6ZZXuIR2JF2EnYEtd3QVywT8LMGydPtO9QWF9/EOOG3+RHq6hZvOZg
	BIeMvbZOEfBDYzWyOQRdLuFvXwaaNmBRSICNbYpwGj1k6K2yjviVvhliSEc/7N2X
	D4J4H5bZ4QIKKVHplGJiqOHzJbKdyRqlu1jl3wlWxfqSXwDQJyfT0R+SFp4I1AeP
	WCTrILLehUKV6OzyLmPL9uWAHRkplYHHBs3qliVbfCtqgu/fG5SS21i9bPnSwnLd
	iynDFGNkyinymGbM8RRhtv9Pu8CHogFacuwjUUxWLyNVbJ5unTq8S3Zte2+1Ehkn
	t1EIZ9TFja+YSTWbnt1QA==
X-ME-Sender: <xms:MzVVZplQEaXaAXECU2HcW1Zec0eRIPOhxnOf4oPu6WtOj_MD2VORUg>
    <xme:MzVVZk3jyhmF7MGAN6PFE9TKuyL1QcdZVIM5pakwbhBFlsZI2axp137L4kYXHHbKk
    e0Cdd34VhwGCogxXQY>
X-ME-Received: <xmr:MzVVZvpN9ovjpPXKk9sjZ-B9wb3Uz1XX4I9_549nWpajRHvGU1ME_XBgNQa7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:MzVVZpk7SdXxSj6Xap11PBEe32T1qvy4RVldRdWvumf2Q1LMkr9AcA>
    <xmx:MzVVZn2aCXeueYnV0TgyTalRrPVb9k_zoLhOUv8Vnrcfl_I5Kwq02w>
    <xmx:MzVVZouxBaLi4KcwlbEw-g2WFlwsStIl1QZL1ocopKb8k3FrnHv7Zw>
    <xmx:MzVVZrULscIMOR-xOrcL2PYuI092PgeUtIArxJF7PAch8hjXanCKzg>
    <xmx:MzVVZn8pgM4-_dFUww2tyHmFd0PyFkxWuP8Fc8trZfywfeVnd3sjnZKR>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:49 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 5/9] platform/x86: asus-wmi: use WMI_SIMPLE_SHOW in more places
Date: Tue, 28 May 2024 13:36:22 +1200
Message-ID: <20240528013626.14066-6-luke@ljones.dev>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528013626.14066-1-luke@ljones.dev>
References: <20240528013626.14066-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Further reduce code duplication by using the new macros in a few more
places.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 5c03e28ff252..260548aa6a42 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -813,19 +813,6 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
 }
 
 /* dGPU ********************************************************************/
-static ssize_t dgpu_disable_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
-
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_DGPU);
-	if (result < 0)
-		return result;
-
-	return sysfs_emit(buf, "%d\n", result);
-}
-
 /*
  * A user may be required to store the value twice, typcial store first, then
  * rescan PCI bus to activate power, then store a second time to save correctly.
@@ -875,22 +862,11 @@ static ssize_t dgpu_disable_store(struct device *dev,
 
 	return count;
 }
+
+WMI_SIMPLE_SHOW(dgpu_disable, "%d\n", ASUS_WMI_DEVID_DGPU);
 static DEVICE_ATTR_RW(dgpu_disable);
 
 /* eGPU ********************************************************************/
-static ssize_t egpu_enable_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct asus_wmi *asus = dev_get_drvdata(dev);
-	int result;
-
-	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU);
-	if (result < 0)
-		return result;
-
-	return sysfs_emit(buf, "%d\n", result);
-}
-
 /* The ACPI call to enable the eGPU also disables the internal dGPU */
 static ssize_t egpu_enable_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -943,6 +919,8 @@ static ssize_t egpu_enable_store(struct device *dev,
 
 	return count;
 }
+
+WMI_SIMPLE_SHOW(egpu_enable, "%d\n", ASUS_WMI_DEVID_EGPU);
 static DEVICE_ATTR_RW(egpu_enable);
 
 /* gpu mux switch *************************************************************/
-- 
2.45.1



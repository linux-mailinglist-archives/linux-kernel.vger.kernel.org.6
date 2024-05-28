Return-Path: <linux-kernel+bounces-191613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB388D1176
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C511F2215F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 01:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0DA1798C;
	Tue, 28 May 2024 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="gh7KSpuM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSqq02EM"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D00EEDB;
	Tue, 28 May 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716860204; cv=none; b=ZeU/ucGn4WGavvnOC8LdtCFPil/Td8Kg5wFHGFe9pOOswfD9nkyfrmzHdOFj0mJqYDgqa9LFImIMx1kO+h3u6MnvWW/k2koHqXpN5Ipa2dtLDvT9ur/C7/3Rop6VRbCrQExvle7gKMf3QHZVlqiBm3+JDuKUmBqgo+/64WaW9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716860204; c=relaxed/simple;
	bh=6X5qvdGER3UOQsX0hdA2jSbk0AKoPE1PhDLPSdV9aUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0mGmSNWyopHRc2APOY86LYjD4G0cSn8XlyVP3Qv5Pfz1seaURtAu3YPCJEpB/YvMiimgcv2FDBkFKlD/sRka+GzeTWWyT6mR2f2tMim/vWTbgNCGadg1rK6GVhxxNeShKNqsz1DNeruj/i//g88HepFW6tdkLUVHIbS+AkIgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=gh7KSpuM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSqq02EM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3253911400D6;
	Mon, 27 May 2024 21:36:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 27 May 2024 21:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1716860202; x=
	1716946602; bh=3bdXh04xDjc3/ImoEZe1VUNcZWPsiJSevANr5wdAkVo=; b=g
	h7KSpuM5ArFiDOkpZ3NDlTY8PoNNKCgNr6iYv9RBjxiYUfUJ7pK3+VY4rUmBzXp+
	5B38SRhbPDfYBGkecEOV+UliGNG5GTGICDTo0ij/oNwQtq6JjGn6TOnO2andKoYz
	KkhCyOWoj4pR5BnaFvEEbiG12iKSRnt9/4Na4EMc+p9URiDB75ssMgHlDroZsCxV
	GryGlaUngjBQJIWR2+DvZknmsEfOteH7oLbaxXULehOLVkuIXZE3MuCguHHoKs8O
	gmm9Yye2+ceQipuQFNP3nx66/c6V4JGNoikWk9xg3CT4OpQ5V4ORJoKmGN0LWcep
	5hNtsKdzoD0DnVEpXhSLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716860202; x=
	1716946602; bh=3bdXh04xDjc3/ImoEZe1VUNcZWPsiJSevANr5wdAkVo=; b=N
	Sqq02EM7QkwCYyabkvCoJ9tuR2ZNr3E8MvnvoSQnvb9IntZ9f3D1CoGcKMnKRNap
	CWrqqCPYy/M0EzA/EtcB4b4zBI+WRGThnWCVvdVQ4BQzGNScqefa1Je6f6ZuSWCj
	DVDv0+KOuz8B0q1FLRq9zYtwrZLOw6YzDF+0a8jaKy4PIV96VhNv/RTwtS3tVmHU
	DCeNnW/xG9jbStcp4EITmlncXPD1Dw0vNzUF8lNEPCjGO//hY55g9bqmf3vs1H8S
	i8o/hGfsFbBCTCU132vER9umbjVgsI88Wry3/SSKGFiAT2HAfJJZ6ac2zhAlsgl0
	4hnz27OOTbLwebz/gzOMA==
X-ME-Sender: <xms:KTVVZh0ekPSHPSy69qYKRkWPFEnRvVF9gQqDGhMe7XgWbvhkeHYvvg>
    <xme:KTVVZoH8HM1wH5km5SEju2j0rWfOZMKcSd_xNJxCwkmjJtI7uaq4lzmpDTKuZ72av
    BUmJVS1xbVUt73dKqo>
X-ME-Received: <xmr:KTVVZh7Bf_ylrAbbWUqerqbcRks4iQrjVkMcCC9Fs1BJc4nLPIxiJXZyRajs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:KjVVZu2ZcZoX2jjg8K_TaUX6ryr8eZyspwxMeTwl2rb_gmtZIP_6rA>
    <xmx:KjVVZkE8aXvOk8bFqDs1WaCnh9gftTxc2RFpb1ySu79-kDso-ublHQ>
    <xmx:KjVVZv-pw4LZyfjGZ4JsFIK4NN-4caBhQO4MMYrsk1RkL3KBSbDkqA>
    <xmx:KjVVZhkNvMMEoA6UcbwNldKyhgxAVQp4FfXFe8g1Aj6OA4ICVZD2cA>
    <xmx:KjVVZpN3PloSPRNiaGzkxYlWZ1pjc-9DA8MxxHVB5XjYmqfoYBxKclxM>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 21:36:39 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: hdegoede@redhat.com
Cc: ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/9] platform/x86: asus-wmi: don't fail if platform_profile already registered
Date: Tue, 28 May 2024 13:36:19 +1200
Message-ID: <20240528013626.14066-3-luke@ljones.dev>
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

On some newer laptops it appears that an AMD driver can register a
platform_profile handler. If this happens then the asus_wmi driver would
error with -EEXIST when trying to register its own handler.

We can safely continue loading the driver instead of bombing out.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index adc841abbb2a..999cd658ec8b 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3836,8 +3836,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
 		asus->platform_profile_handler.choices);
 
 	err = platform_profile_register(&asus->platform_profile_handler);
-	if (err)
+	if (err == -EEXIST) {
+		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
+		return 0;
+	} else if (err) {
+		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
 		return err;
+	}
 
 	asus->platform_profile_support = true;
 	return 0;
@@ -4713,7 +4718,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		throttle_thermal_policy_set_default(asus);
 
 	err = platform_profile_setup(asus);
-	if (err)
+	if (err && err != -EEXIST)
 		goto fail_platform_profile_setup;
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
-- 
2.45.1



Return-Path: <linux-kernel+bounces-322404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D889728A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E43B1C23DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87297153800;
	Tue, 10 Sep 2024 04:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="fz44neLz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvcHljlp"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACF13E02D;
	Tue, 10 Sep 2024 04:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944095; cv=none; b=uKWSBjZNqyrtBPIOlm1Z/dAy1P4S+89MygcgenVdfxGPBT/axNUHLwzIctupHuV54gz4PWtYJYicYU2mwu2+0fbjzWTsakzPHSOYKwwjZ1NTekZdw2NTN9TCyrg9oT5b15wOVXJdUYv0yjCKELaUlgGjneg2Jx7rz5GsZQ0Bhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944095; c=relaxed/simple;
	bh=fnqmtqs3Q42EGzjO2tDxIkAyYbiDeraUlBYEEcvIkgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMJGhfTuUx3b05pZF9QK3tbYM/Ty5MGxeu/6VN8wiJSvt4NPZaTsxU+epGEUqgPcDFh5i7w5wQ8Z/mHiuJ+sTIbXXFrxZYvyr1y6yYUFNbMiiYKT2c4eSP8JGkBriSSxLjjQAmiwPEYvPt/TwgSe79wzwk1684HbtLIBRMK1xt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=fz44neLz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvcHljlp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 177A21380225;
	Tue, 10 Sep 2024 00:54:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 10 Sep 2024 00:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1725944092; x=1726030492; bh=iM8dQZ5RWFE0qerYBgfJG
	VCWSMqHffJNm2ProEISIYo=; b=fz44neLzlBa7cgxGK21n3i+gsNwN3UtOrTRpl
	6DqCZ6MFg+yscReMsQCaYDVNeVj8cjOYcQDKDaHSvhFvkScfxFDtZJOqwOkjtuaT
	wc+H5tKz7dFS2c1FEhrfDPuQPAwDlHP/1pzUJLSnn2IHB+KH5wk2yONT6nVNgjrx
	8Pes6kuY6Jfn/qgGS+aBwynWwb2LfsHrF75fvlvIueg5NUVSlkat+bpCUFGNBBNP
	ilMf6SeV6zTNcESQZhpHuO1s2uhQL/nWBlAdQdaTy1FSQN6QRT5/OyyWcgb+8aB2
	OWMMMk7pPwClPGxEXDBcNnmdRq8jageSGzATSl7b0jRH2pvBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725944092; x=1726030492; bh=iM8dQZ5RWFE0qerYBgfJGVCWSMqH
	ffJNm2ProEISIYo=; b=YvcHljlpSHdkZE+F2w+nuO6Hp8bVjJN4B1ZRMiWXn+ka
	eRupMIeSORSzFOiNsK6DRWjOEJTRbICCLW0i9G7Sg/J2jRIIZwSG5YXKynT7YWcV
	NOiP7b9shpaKhpoC4trfIEjOj52KTXOsEnJSTbCmmHV8XAZ3zHJsCw0JIWEVk+vv
	6JYSWjyvsTj0iIqlb6gSoanG+O8IgwL1I47fS5E0iFgLwMrE7P2YljMike/Kl3Dt
	52vw261d/JQ7WnewaI4vtzrsrzXD9rE0FV02XKmXNQsfOKmX4A9eKTsI+l4ufxS3
	HP5Jx42QsFQGXTLipfkMoD+IStR3rLMmoSi3rc7obw==
X-ME-Sender: <xms:G9HfZu0uLjEb_sgDR9VUJZaisiPQ4xwg6MFMfyoLIe_ZjmsHRy6KaA>
    <xme:G9HfZhEFRX8uAaZbccLT2aqoFMM9NAb12YUiCeucT6hn-FUj99LfiTHWdzLlsxJFo
    T7jv9fBVfn2ur3CRpU>
X-ME-Received: <xmr:G9HfZm7G_JNMRgD9K0G_h2IJbxSwcxoz4O6Ofgh96s2ZvxoaGpazgBZMtUdb5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdf
    uceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthf
    duudekffefkeeiffdttddvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvsh
    druggvvhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopegtohhrvghnthhinhdrtghhrghrhiesghhmrghilhdrtghomhdprhgtphhtth
    hopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:G9HfZv28MrNMdiTCrUJFr-XngyvSmGFutcddmENSdUkKaXLrywNWwQ>
    <xmx:G9HfZhGK5b15IHMWT02MT31U9uvl07WokH4aIjMDlmSZF3-IB5WJ9Q>
    <xmx:G9HfZo-rWZtuUXgZAg-3Mx04WVu3KybsfOQ0aoS9he_vdY0-QTBfyQ>
    <xmx:G9HfZmkXwlHW80l8mOIYQ-4Sn4UMhRthtEJGQUM57krzwtbuVt7TpQ>
    <xmx:HNHfZqMtMy9e9sxtLsdDnHq5Q_0bLjbUB-PBgModRFsVTut3-nZuB-F7>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 00:54:48 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corentin.chary@gmail.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86: asus-wmi: don't fail if platform_profile already registered
Date: Tue, 10 Sep 2024 16:54:43 +1200
Message-ID: <20240910045443.678145-1-luke@ljones.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some newer laptops ASUS laptops SPS support is advertised but not
actually used, causing the AMD driver to register as a platform_profile
handler.

If this happens then the asus_wmi driver would error with -EEXIST when
trying to register its own handler leaving the user with a possibly
unusable system. This is especially true for laptops with an MCU that emit
a stream of HID packets, some of which can be misinterpreted as shutdown
signals.

We can safely continue loading the driver instead of bombing out.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-wmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index fbb3345cc65a..d53c4aff519f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3876,8 +3876,13 @@ static int platform_profile_setup(struct asus_wmi *asus)
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
@@ -4752,7 +4757,7 @@ static int asus_wmi_add(struct platform_device *pdev)
 		goto fail_fan_boost_mode;
 
 	err = platform_profile_setup(asus);
-	if (err)
+	if (err && err != -EEXIST)
 		goto fail_platform_profile_setup;
 
 	err = asus_wmi_sysfs_init(asus->platform_device);
-- 
2.46.0



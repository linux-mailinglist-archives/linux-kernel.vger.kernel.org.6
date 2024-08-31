Return-Path: <linux-kernel+bounces-309630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26B7966D90
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177C8B22F09
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F717BAF;
	Sat, 31 Aug 2024 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="Bj5JVRGA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMihmeHA"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4714295;
	Sat, 31 Aug 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064757; cv=none; b=RPRpsVT/5ZbjQYNXbfjUXnR/XCns4VdLRFioJk9IENBl5/lRfsFAm/mRZVIZCIjvCIDWxzhUxXWjP3adtC4liZhQVS8oaOCEQWL/gE//0BP6QVMMOxGX7ZPUxtamPdjkaAzT0C4WjNppyYBPP5YeHOfZYBBFzrVJIlta3Xb3mJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064757; c=relaxed/simple;
	bh=mppTRV1zZW/Ag1x0EJ0PAo1cyUU547iLWc9ES9D0S+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOcnJotVJisaruJRJpVh3WDvwNMxkOx0YsIOjYNny8z3o9rSx1rcgU6kT+B5Jgi7udBjxIGg499hZPnEn8ceJ0Wl5jOJkjVC2CIAt+C0/Y2pCvLvFXJY+YX/2pKPEM+060KAna9XWn8VUSPzvh0Nx/kmBIbofi61C3y/g2S8pzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=Bj5JVRGA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMihmeHA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A82741140175;
	Fri, 30 Aug 2024 20:39:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 30 Aug 2024 20:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1725064753; x=1725151153; bh=LXV0nOlsOnCv/Pdhy6bRp
	V1/J/v3Qjd5zmbmqu2eUCY=; b=Bj5JVRGAWnSIxW/Bah3o7S+tNwn6Cat5W3VHD
	6WuPyHJ5lSTYwA/OARj7useI6A3f5f7Xld/KTCH2Ntxu9RVY1XHYjUhoCWmNqHCc
	+ucSJvN/bE+nzCdcCO8FrdJBhLyzGgyRbsJhu7kkdlYOCVHqArIr/uhRqBuH9rgy
	QW0JSBStcFHbgJO3wd+IFhu1BW6Az7Vm9W5h9xxGTCzHU6rYmnvv9tshRJzIEl7v
	IvCx+UBE27mk5BHWmmoAVs281TeIckeHQ2qbawxsgHoqYoqSYe+1oPSMCwysp3He
	6P4iTYX5JcKxvTUvKn5XLu2le0CJum97rGK6GXXG/eDZ+FgXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725064753; x=1725151153; bh=LXV0nOlsOnCv/Pdhy6bRpV1/J/v3
	Qjd5zmbmqu2eUCY=; b=UMihmeHAPUrxNvtqNJ/YGHUON12ebsxW30SnwKZfDmnj
	NPAxQCcyIe4aFO/6QzgEtadv7li1CP7r5mf9zpXVc/RbN7XdzLo8IX0Hn60/4OcK
	ZyKRIG/HUP3f+ib1D554UUkfhsGQhbJ/DiTTXLhbekl6fLTQcfF8lCzOGeGWKWNI
	8kFWK0VT1rxOVxTQYhh7aoKwIKdOnSVhGWlOogL1qM3sVirncBWU3kFtUFgaxDIb
	k6kkMoCxPdIB1KwPgOp656v9tgqsvgqGML9ezqkMTnsury5AqH1bcOqvKNKTzElj
	p0+crTL2sZgmLX5togA+i23khQ29CrDyaT7HBxMXDw==
X-ME-Sender: <xms:MWbSZiFtpVwTH66bE2_ONW49yoXc2dh7A_iHtrrtPX1F3RTTjGTZDw>
    <xme:MWbSZjU53ZIVVauSnidX6AgNREOGj4BMpww4FQ8qI_dvXTotzne1RHvN4crwL2juK
    BZaShzGlFLpReHDduc>
X-ME-Received: <xmr:MWbSZsJR0_N3kfS4Rgj-_EiDqaMAE7B51CswSDwY_mRmfUCLoKnR0s4KxIdQ-nT25M2UrVDCPURXSQjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefjedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdf
    uceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthf
    duudekffefkeeiffdttddvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvsh
    druggvvhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghnsehlihhnuhigrdhinhhtvg
    hlrdgtohhmpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrghmugdrtghomhdprhgtphhtth
    hopehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:MWbSZsGHKYwn1A1V3rbuBoYUmX08LchBcVj42C90XUwf0_7GKV1Ylg>
    <xmx:MWbSZoX31b3JZOaFUL8t9JRDUSroT3wtizIKA_UN709e-rw3PKlKZA>
    <xmx:MWbSZvN9_hXJRKj0CHjVsb7teLtZE-csQCwJNncC_Rq8-cwIdTz5mQ>
    <xmx:MWbSZv2DJUvpi7iXuE8PySQ-4R_K-FVXAjGUJ2fMoQGdSyfdQMe3eA>
    <xmx:MWbSZic9D3bj4lFVh9d01r20o_7VnQmBAUL5AFp9sydMhioxCtDD2Cl3>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 20:39:10 -0400 (EDT)
From: "Luke D. Jones" <luke@ljones.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	Shyam-sundar.S-k@amd.com,
	"Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH] platform/x86/amd: pmf: Make ASUS GA403 quirk generic
Date: Sat, 31 Aug 2024 12:39:05 +1200
Message-ID: <20240831003905.1060977-1-luke@ljones.dev>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original quirk should match to GA403U so that the full
range of GA403U models can benefit.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 460444cda1b2..48870ca52b41 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -25,7 +25,7 @@ static const struct dmi_system_id fwbug_list[] = {
 		.ident = "ROG Zephyrus G14",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "GA403UV"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
-- 
2.46.0



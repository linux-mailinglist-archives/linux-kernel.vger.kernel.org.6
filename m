Return-Path: <linux-kernel+bounces-215403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3490923D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C77C4B224E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8D19D07D;
	Fri, 14 Jun 2024 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDayHVGh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76382CCD0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718389525; cv=none; b=sQDqY3PH9rxYQsOnSi372G+Pfb1UqR9N+kXOmrddxzNTXp6CN5nlZi0ACk/WKypVRMfp4PDLeqh8mZeeu72fAqwUHD9qCfOwsSzEEVTV5fuTm8V9QUM5W+OSLvSSlH4Za4N6DKo0XWxLSY+0v/uYEO6J0hNLwXW1jvspEwg6ZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718389525; c=relaxed/simple;
	bh=17XqsCYTuwNMMXk8dTaMUWD29V4eaG1WBt3UP1RONPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3JKarGtsG42M8UngHwXfBirbFr3j4eV9N3Zw6KRHYGeA2qvZQpC0p9igTvmF8s5d2pohxW3cvwLR3glLAzkP+wMrid8b5QxYOP5y6grKUvn9DldL0OhTccqUkNop+VVSfTo1TMMJx+/ozAB+IUPfblvlVJAN/lqFH4nyGsVjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDayHVGh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718389522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rVuWdzbjR5bd+U/y/e+aXYkOnbjqY8dHfGNq+VGdIi8=;
	b=JDayHVGhOsqyTsP2Ad/nyu/rj92i6P1AfN1sMw/KeuYaCMC2j/t0hLubb//K84YDF0lAhC
	aWz9VgUury8MzzMqelMym58pFXC0YfNURuZRGUYZA+1cym7uthwQInhCXW8RLmEfZ9CWWD
	jOmAl8ZKDsuOjWDAZcN61Zb3glASZqI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-yroaDZQoPo2HAkZQVCiwnQ-1; Fri,
 14 Jun 2024 14:25:18 -0400
X-MC-Unique: yroaDZQoPo2HAkZQVCiwnQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28041195608C;
	Fri, 14 Jun 2024 18:25:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B377A1956087;
	Fri, 14 Jun 2024 18:25:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	arnd@arndb.de
Subject: [PATCH] Documentation: Remove unused "mtdset=" from kernel-parameters.txt
Date: Fri, 14 Jun 2024 20:25:08 +0200
Message-ID: <20240614182508.600113-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The kernel parameter "mtdset" has been removed two years ago in
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support") and
thus should be removed from the documentation now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 87d5bee924fe..ff02e1a02e12 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3631,11 +3631,6 @@
 	mtdparts=	[MTD]
 			See drivers/mtd/parsers/cmdlinepart.c
 
-	mtdset=		[ARM]
-			ARM/S3C2412 JIVE boot control
-
-			See arch/arm/mach-s3c/mach-jive.c
-
 	mtouchusb.raw_coordinates=
 			[HW] Make the MicroTouch USB driver use raw coordinates
 			('y', default) or cooked coordinates ('n')
-- 
2.45.2



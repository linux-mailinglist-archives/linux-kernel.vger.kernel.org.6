Return-Path: <linux-kernel+bounces-401249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A669C17C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154C3284225
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6391DE897;
	Fri,  8 Nov 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIv16Y/m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AF51DC1A2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731054056; cv=none; b=goiJJhap92TE/9MMDxjTXkCTAo/LTxFr72Hi38Makm26XZakgbmZZ7R6PV+2LYBYTGm2n9kQhyHjCrQyt1iGqDS9I5mQD+4Avzgu2Xet75sap4XgPk1hN8BZhN70SgCI69AfyLoY4uRMh54eZAvyAVTDBuZvnU1yo4Ndf5Xge78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731054056; c=relaxed/simple;
	bh=tecIa7CDBzn8lafznHJduNt9CbxbbxfTUai+ece5p3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjHPdTW1ojUwO99ylgqPAU3VvOODyOOMd5Um5DgMe+vnwjzSOhTb30NsMNSxAZPg6mXOcITdZs56BwS0lBzqKRq6ZAjeqUqC+6cHVb2/PVTRZgXIMxg1jpdQk3uZCOYNFwrSRnxHG3n3CWCpNlB0XbLmWwkBGTG9VDqqvFZ29bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIv16Y/m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731054053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZoaRFNucW8/vSTTo4IXqqRzuuRIBqeFEE4/Iywql7c=;
	b=VIv16Y/mosCCDINvEIkjaLnk8jZ8YWB7nPAa5PW5t6rm+jtExpwGc3pbNF3wK/y7ufr+sk
	rYnRoF9s9DO5EN4sBWDejIITInox3k7zSu6ge+TIHfDjvPVocGrru+n0IVYPqhsxyHDFAd
	+VcI6NfkQHYHEdEi7mxPBtScGpdjvaM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-yVksGHYYOE2-5Nmh3aAW8A-1; Fri,
 08 Nov 2024 03:20:51 -0500
X-MC-Unique: yVksGHYYOE2-5Nmh3aAW8A-1
X-Mimecast-MFC-AGG-ID: yVksGHYYOE2-5Nmh3aAW8A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8781955DCE;
	Fri,  8 Nov 2024 08:20:48 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.51])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 39CDF1955F3D;
	Fri,  8 Nov 2024 08:20:43 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	John Ogness <john.ogness@linutronix.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	bluescreen_avenger@verizon.net,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Petr Mladek <pmladek@suse.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH v7 2/7] drm/client: Always select DRM_CLIENT_LIB
Date: Fri,  8 Nov 2024 09:10:20 +0100
Message-ID: <20241108082025.1004653-3-jfalempe@redhat.com>
In-Reply-To: <20241108082025.1004653-1-jfalempe@redhat.com>
References: <20241108082025.1004653-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

DRM_CLIENT_LIB has the code to select the client at runtime, so it should be
always selected by DRM_CLIENT_SELECTION.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---

v7:
 * Added in v7, to fix a build issue, if DRM_LOG is enabled but DRM_CLIENT_LIB is not.
 
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3f16dca0b6643..eabedfc11061c 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -234,7 +234,7 @@ config DRM_CLIENT_LIB
 config DRM_CLIENT_SELECTION
 	tristate
 	depends on DRM
-	select DRM_CLIENT_LIB if DRM_FBDEV_EMULATION
+	select DRM_CLIENT_LIB
 	help
 	  Drivers that support in-kernel DRM clients have to select this
 	  option.
-- 
2.47.0



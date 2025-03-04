Return-Path: <linux-kernel+bounces-545603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37475A4EF26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F46A3A70C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49C927816D;
	Tue,  4 Mar 2025 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvdDZrkv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F8264F8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122410; cv=none; b=fsoEfU1EikFJl7vH6/cs7QA7WtRmL4NaOaNjJQNjeRxD/yG8kcHbGmxq/qFRzFjoi8r/lSnZx0OqMYgYw1ka5t2Gufy5YNpOr8lIZjdK3VU0c9YzGRiCzHIPTAW6i+q5Zg6qgyGejRmiNaOnz2MmlE+nnCA6lk7OZd8eT6gZc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122410; c=relaxed/simple;
	bh=a+9vSiehl6gknw6Mmbey4xtGtLQG5CCHOmYcTZZMmdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHKm5o8rP67TIZpKthLHFzE/NuwrP7PZIX/ZAE2RSsDadO8o0777ksPbUgfEzpAdalO9FanP1YWr0KoAo7MgcpoiP3M9x73x/ZYB3CvY74MweAOiEwXjuBqCA0Rkl/rDONS5cgT8zVVq/gSubwP7JxVOZ59HnlCtqCm6d4jNZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SvdDZrkv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741122407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXScMvqY7wnhyHgtPtCu0A5GRSUf3CJsowbwzHCyWmo=;
	b=SvdDZrkvTkeJpGEYQGrpP78rEBKhUCp+MZlU6ExMVfyEK9mXv2OYTKEORdr7m4L0KcwA5F
	AeeoubUAFfWAETM7IwftAJXhBvz2zX0B6qslEl0rTUVWwQZOaGnXEkpnFNx8H5clDIXlrK
	JRAdGXpKlEV6bfFTmsxesQD1HxQSORE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-0cKN8XxRM0mrXwnxQn2CEA-1; Tue,
 04 Mar 2025 16:06:44 -0500
X-MC-Unique: 0cKN8XxRM0mrXwnxQn2CEA-1
X-Mimecast-MFC-AGG-ID: 0cKN8XxRM0mrXwnxQn2CEA_1741122400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7190E1954B1C;
	Tue,  4 Mar 2025 21:06:40 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.107])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18CB7180035F;
	Tue,  4 Mar 2025 21:06:33 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Tue, 04 Mar 2025 16:05:37 -0500
Subject: [PATCH v5 7/7] Documentation: Update the todo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-mem-fixes-v1-7-fb3dab8d901f@redhat.com>
References: <20250304-mem-fixes-v1-0-fb3dab8d901f@redhat.com>
In-Reply-To: <20250304-mem-fixes-v1-0-fb3dab8d901f@redhat.com>
To: Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741122340; l=1624;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=a+9vSiehl6gknw6Mmbey4xtGtLQG5CCHOmYcTZZMmdo=;
 b=8rCBCsNcZ8amMTaIWFiJodYpFjxHIQvmmD9mzX+B3axhphImg2RnoMahA4QjvfU1qzgfFB9SV
 k3E4bSlMe1pCQkwPPjO0buETRRr0CC9j9KMOdGq2ajbFFEFxqaUT8Ct
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Update the Documentation to be more precise.

v2: Update for clarity
v3: Further details in Todo

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 Documentation/gpu/todo.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 256d0d1cb2164bd94f9b610a751b907834d96a21..c57777a24e03d91b1ffe04365f7356f2d938befd 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -441,14 +441,15 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
 
 Level: Intermediate
 
-Request memory regions in all drivers
--------------------------------------
+Request memory regions in all fbdev drivers
+--------------------------------------------
 
-Go through all drivers and add code to request the memory regions that the
-driver uses. This requires adding calls to request_mem_region(),
+Old/ancient fbdev drivers do not request their memory properly.
+Go through these drivers and add code to request the memory regions
+that the driver uses. This requires adding calls to request_mem_region(),
 pci_request_region() or similar functions. Use helpers for managed cleanup
-where possible.
-
+where possible. Problematic areas include hardware that has exclusive ranges
+like VGA. VGA16fb does not request the range as it is expected.
 Drivers are pretty bad at doing this and there used to be conflicts among
 DRM and fbdev drivers. Still, it's the correct thing to do.
 

-- 
2.48.1



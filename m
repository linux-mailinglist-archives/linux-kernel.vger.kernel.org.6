Return-Path: <linux-kernel+bounces-558655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8048A5E91F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171F417A9F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAA7FC08;
	Thu, 13 Mar 2025 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJjRguAF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA52C80
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741827300; cv=none; b=k1pmQC2/7MV2bGe7jcfp6/jHiQoX96bbGd3eC5eK8PcL6y5mM3X/HfV2HoY2yiUR+hrHC94bTw3dbiVFPqd0zmEfFpsseP5CzJlj6EW9qxO/1jS1U9uE7Z9yohjHICqZ+o/9aIFO8Tqr1RNQpBEAjhOkc0We8LsSnELxab0W+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741827300; c=relaxed/simple;
	bh=prKb1/vsoLZeKMb2AQiT1U6bRaw46DjeGENTzbI5K3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VxLOGgDrpulV3iyQNaUdZRkxp9+NUQUOA3wvJ6dYwSbcGaFvFJquOUGjYxH7XH10nF9XciAMnkGRr1X/33dcd7Jgzyp2CqyIpOkG+lCYneQVOkjqwk8MX28mCv6ersM0wiecz1HDQkgEkOft214tYOfFsfa9nPl4bBskYc6X9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJjRguAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741827298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UoaJonu1Ykft8honHbcoNgiIucT+lAcKoBxDQ1EsVIU=;
	b=LJjRguAFGzyk0tCyNWwqEk0hkX52U5aUXGUoX0FJU19rGy1NvFVtRfIzZkJo8lJFyjF7G+
	L3iSEsBBurNwN3bNaOf5c5frez9HSB4evscwUM+0rPdycT611OhnRyRmYZNHqD8PThrbV8
	SX7hyqsbUIEiL3/7r/nPmNV6C1SL3Io=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-h5hFTB0PNUGrbqzmFZNZCw-1; Wed,
 12 Mar 2025 20:54:54 -0400
X-MC-Unique: h5hFTB0PNUGrbqzmFZNZCw-1
X-Mimecast-MFC-AGG-ID: h5hFTB0PNUGrbqzmFZNZCw_1741827293
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC76195608B;
	Thu, 13 Mar 2025 00:54:52 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.186])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46C7F1955BCB;
	Thu, 13 Mar 2025 00:54:49 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH RFC 0/2] drm/panel: Refcounted panel allocation
Date: Wed, 12 Mar 2025 20:54:41 -0400
Message-Id: <20250312-drm-panel-v1-0-e99cd69f6136@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEs0mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0ND3ZSiXN2CxLzUHN1kYyNzS0ujVEtjo1QloPqCotS0zAqwWdFKQW7
 OSrG1tQAm2jMqYAAAAA==
X-Change-ID: 20250311-drm-panel-c327992e932e
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741827289; l=1079;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=prKb1/vsoLZeKMb2AQiT1U6bRaw46DjeGENTzbI5K3Q=;
 b=xjrFzIHHXSIYDjna0xcXbb6Bqj7JFBaS5Mw9FAVoKT8/aywRJzepAS5iZPGRCve271zLWFm5x
 VKYrR51+zZ/CBllFYT0Fk8Y0/P6zklxMKNqhPINNmo/JXDZ6DKJAMNn
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Primary motivation is to avoid havig a dangling pointer with panels.
In a scenario where panel device no longer exists, the DRM driver
has no idea of it. It can continue to try and access a panel leading
to use-after-free situations.
This is the initial draft more for feedback only. Once the path
forward is clear, further drivers will be converted to using the API.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Anusha Srivatsa (2):
      drm/panel: Add new helpers for refcounted panel allocatons
      drm/panel/panel-simple: Use the new allocation in place of devm_kzalloc()

 drivers/gpu/drm/drm_panel.c          | 50 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c |  4 +--
 include/drm/drm_panel.h              | 58 ++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 3 deletions(-)
---
base-commit: 3282422bf251db541fe07c548ca304130d37d754
change-id: 20250311-drm-panel-c327992e932e

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>



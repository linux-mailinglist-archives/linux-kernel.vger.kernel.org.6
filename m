Return-Path: <linux-kernel+bounces-575854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B132A70810
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B83A1889D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5538225D21F;
	Tue, 25 Mar 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkAnLZly"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E31ACEA6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923461; cv=none; b=gZpMREM8n1zSZro4PcP3BxUEwzLDx+6zwLYnv08rDobBRll804iHuSBqMLuA65oCl4yYzFMtVTdWBtR62cXo0OJOULCLMtafOcojoAqT2T06xHO/ZPBIhePxCob1Na4r4WYRahukPp6zL8EN5AS3jpkAyKrEuKDxfe/TMaLXZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923461; c=relaxed/simple;
	bh=YI0HrZQP8aZ4SZN0foFp1lzPWSTH5yaNiJ+zsOiEXv0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pZMgdmA7ewbPR1R5WNu92/+LLj2+C0CnHwEyKSusRF15nECM0mi227XaGu3rq+H4OQxxZHSn5Xni7FjLyGIO4nxHV2GapOHra91Z8Xn9SUfSzXPqI+lrArtqTfgvWco+CCucpgJnBVohQvIVNwZWQ4ybayoeXojt7ie6fOU2AQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkAnLZly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742923459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KvhVivQ5gaIIde3METM+UsizgHmcc0VHpE+Y4ZP4uEI=;
	b=BkAnLZlyi78h/vW6kC3ufeF4mBdEW0FeL70w7FMtlq3Oz+nKXgAZz7L3BXWaUByeO2A8Tr
	n1b0WW8RDHcVolFrYWWf6RNQsCYOX2r7RQOYDNwDdNF9dKoXXMb1ozhwstSOQ1WdxI/RkA
	ghy9o+oyrrm9bI0bSzhV8Ue787gMPl8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-Ota3XEv_PwudJMjllrA_Og-1; Tue,
 25 Mar 2025 13:24:15 -0400
X-MC-Unique: Ota3XEv_PwudJMjllrA_Og-1
X-Mimecast-MFC-AGG-ID: Ota3XEv_PwudJMjllrA_Og_1742923454
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D99BF196D2D6;
	Tue, 25 Mar 2025 17:24:13 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.186])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E78D180A802;
	Tue, 25 Mar 2025 17:24:11 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Subject: [PATCH 0/5] drm/panel: Panel Refcounting infrastructure
Date: Tue, 25 Mar 2025 13:24:07 -0400
Message-Id: <20250325-b4-panel-refcounting-v1-0-4e2bf5d19c5d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALfm4mcC/x2M0QpAQBAAf0X7bOucQ/kVedhjsaWlO6Tk310ep
 2nmgchBOEKbPRD4kiibJijyDIaFdGaUMTFYYytTWofe4U7KKwaehu3UQ3RGZ8hXNVHppgZSuic
 p97/t+vf9AHskQOJmAAAA
X-Change-ID: 20250324-b4-panel-refcounting-40ab56aa34f7
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Anusha Srivatsa <asrivats@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742923451; l=1742;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=YI0HrZQP8aZ4SZN0foFp1lzPWSTH5yaNiJ+zsOiEXv0=;
 b=34sntolmHEx9YMCAkKD1pjk4dqo34XcwPkLRDjVbyrGwFISRO9qrSMk8nhbGsFRCWZYDJgno5
 gNZoEA0FuRhBPJDJRcjMZpCDi4REbPjneaREeST6/Kb4Vn5vFzUnhTa
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series adds the infrastructure needed for the refcounting
allocations for panels similar to Luca's efforts with bridges.
Underlying intention and idea is the same - avoid use-after-free
situations in panels. Get reference to panel when in use and put
the reference back (down) when not in use.
Once this gets approved, rest of the drivers will have to be
mass converted to use this API.  All the callers of of_drm_find_panel()
will have to be converted too.

Tried to split the patches as suggested in the RFC series[1].
Also fixed the connector used during panel_init to be the one
passed by driver.

Patch 4 was not suggested or part of my initial work. Added it
after looking at the comments Luca's v8 of the bridge series
received.[2]

[1] -> https://patchwork.freedesktop.org/series/146236/
[2] -> https://patchwork.freedesktop.org/series/146306/#rev2

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
Anusha Srivatsa (5):
      drm/panel: Add new helpers for refcounted panel allocatons
      drm/panel: Add refcount support
      drm/panel: get/put panel reference in drm_panel_add/remove()
      drm/panel: deprecate old-style panel allocation
      drm/panel/panel-simple: Use the new allocation in place of devm_kzalloc()

 drivers/gpu/drm/drm_panel.c          | 96 +++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/panel/panel-simple.c |  5 +-
 include/drm/drm_panel.h              | 39 +++++++++++++++
 3 files changed, 135 insertions(+), 5 deletions(-)
---
base-commit: c8ba07caaecc622a9922cda49f24790821af8a71
change-id: 20250324-b4-panel-refcounting-40ab56aa34f7

Best regards,
-- 
Anusha Srivatsa <asrivats@redhat.com>



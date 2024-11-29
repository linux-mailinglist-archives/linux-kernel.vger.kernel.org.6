Return-Path: <linux-kernel+bounces-426007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA49DEDB7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF162B21459
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE09155742;
	Sat, 30 Nov 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="epTdT6qU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ECDBA45
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732924834; cv=none; b=IjNuwSJBFV9iNVUfWR9GBdmTTrziIM6qkpY5j1+ufGzrSXf4ykv49/p3AWDKTrWr+6CvhuiKAV4ETKT6ae4Ji7SMBgvAA8ctouMW0ZghYC+WU1cvAH20sCb3MAD7gnnxYi4eAFhjCSmfNgBSKbFx9YLCXxHY4FcShJKth0daius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732924834; c=relaxed/simple;
	bh=EKQm2CeHWzWU4OiN1m7A1Caw19UNYuKsVB7OYItlHL4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B+tV43QIw2hf49kjhW2KW3qbafQQvFRUezig0IoiSvbSp4eO5tHdFe6Qx4U/pjzrVJXK7TbDGD5eqvM1jiFICnDzarT1UP5lIkeM5BnmQiyaxOlmH3cybIE/TJ1mWjK/X25FsiID/+NRSmKfid0yCAg4Qtnv3EcJb9A465fZ46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=epTdT6qU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732924829;
	bh=EKQm2CeHWzWU4OiN1m7A1Caw19UNYuKsVB7OYItlHL4=;
	h=From:Subject:Date:To:Cc:From;
	b=epTdT6qU6V8pgXZ7h5HnlIGD2va5HyK355aReGOlH7WvV6sqVZYl/9txAntyyKShx
	 xEPqTNC4Y8qdNjijL1HZQq4GA4cFHQQPJmKfM6PnOsZDgRZKWrIR6TxJ49I1O6SKq+
	 1ccpYGWXYIh53POhrIpOcGoJCIZdTcxXffHd1LI4eU8E7QenGryztAODSiPUa6lLzY
	 mU4RPlmBpL1V/BVcFHR2zD2lBbLSapg1vYn5AhZEVRD1mqrCrLqb3cPhYSX4U7spXA
	 PRsYM9MPifoJ6pw/+PbvZrw2wTnbtI4UL+TPz6bLJDEongUk/G6r9VXxn5d7ytsh3C
	 4m99h69epeeKQ==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B9D5C17E0E37;
	Sat, 30 Nov 2024 01:00:29 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/3] drm/connector: hdmi: Allow using the YUV420 output
 format
Date: Sat, 30 Nov 2024 01:56:31 +0200
Message-Id: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK9USmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ2MD3YyU3Ezd5Py8PN3K0jLdVMO0RFNLs5Q0czMLJaCegqLUtMwKsHn
 RsbW1AAAnREZfAAAA
X-Change-ID: 20241130-hdmi-conn-yuv-e1fa596df768
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Provide the basic support to enable using YUV420 as an RGB fallback when
computing the best output format and color depth.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (3):
      drm/connector: hdmi: Evaluate limited range after computing format
      drm/connector: hdmi: Add support for YUV420 format verification
      drm/connector: hdmi: Use YUV420 output format as an RGB fallback

 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 55 ++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 10 deletions(-)
---
base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
change-id: 20241130-hdmi-conn-yuv-e1fa596df768



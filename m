Return-Path: <linux-kernel+bounces-572413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99713A6CA1D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6673BE081
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C939B210F53;
	Sat, 22 Mar 2025 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xGbjvq9C"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EC01D8A10
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742646082; cv=none; b=clnfQBWX/qp2CGs61TggsPx+Q9/IUgW7cC1TyQS/x/gTp2laTgQEd42T6HzTLh00WkukZzRXRWOaL/nQMtz3MO/vkkK9GRlvlmB67fVW8QSV/b3GM6QtKyykg9CLpjceY/tAXzRJ57u4OtxjWoIWvXFJaptBflul+Er/zcP6aF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742646082; c=relaxed/simple;
	bh=d4zCb2nPi+92PBYP4GVS0j3wv4Cc6an97P+w1Dov31E=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SVp4rHT6RfG4cLQs9+6RHe4876y4dpxgxSmeAutnl6ukq3Ipy6JS/PlFLh10CwvkLMVZCy+V9LE4YG17ZxR+DlQmxt2IOXnK+ORJFX4NsdFMFtRJ69mB3mz8xON3hM+7rQrZhSv6O0gK4kEOFkL6EIUF8wXhbqAZUsEWydnDiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xGbjvq9C; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742646068; x=1742905268;
	bh=d4zCb2nPi+92PBYP4GVS0j3wv4Cc6an97P+w1Dov31E=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=xGbjvq9CgZpMLuI1PQaBeKcE0yAcavsPvTdw/PPcZAmnCTDSFn9FRO0SoTgoCeLAr
	 adAcJ6yJHKjjhgkCRPgNoCIBAupkBAPOJJ7pDdyWDPYzZysCCgNxRN/FmN8jJcE6Lg
	 wjH/gL/UBjmWqN+i7QKGycYDSBQpFWe1GULlTW6GWp2hCJh/XLhhOnLQdsIHZ86gHd
	 0D9jE0pzrub0FXUpsf28rH1vJi24m1QY/910knN1UF3kiRf7e/utMStDPiYKaplIMB
	 xcCAIm9LG8oh4yrxeVddnTEV/XF1QFjEVwRm0N9oI4uJAu8Ta6ZRUwxbD4paaX5tbD
	 MRmge930WiqaQ==
Date: Sat, 22 Mar 2025 12:21:00 +0000
From: devbrones <jonas.cronholm@protonmail.com>
Cc: maarten.lankhorst@linux.intel.com, devbrones <jonas.cronholm@protonmail.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/edid: Add non-desktop quirk for Playstation VR Headsets with Product ID 0xB403
Message-ID: <20250322122048.28677-1-jonas.cronholm@protonmail.com>
Feedback-ID: 34760268:user:proton
X-Pm-Message-ID: b5ee08acc308f1f101224bd5e7be7549405e0561
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This fixes a bug where some Playstation VR Headsets would not be assigned
the EDID_QUIRK_NON_DESKTOP quirk, causing them to be inaccessible by
certain software under Wayland.

Signed-off-by: devbrones <jonas.cronholm@protonmail.com>
---
 drivers/gpu/drm/drm_edid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 13bc4c290b17..51b4d7a02c02 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -239,6 +239,7 @@ static const struct edid_quirk {
=20
 =09/* Sony PlayStation VR Headset */
 =09EDID_QUIRK('S', 'N', 'Y', 0x0704, EDID_QUIRK_NON_DESKTOP),
+=09EDID_QUIRK('S', 'N', 'Y', 0xB403, EDID_QUIRK_NON_DESKTOP),
=20
 =09/* Sensics VR Headsets */
 =09EDID_QUIRK('S', 'E', 'N', 0x1019, EDID_QUIRK_NON_DESKTOP),
--=20
2.45.2




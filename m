Return-Path: <linux-kernel+bounces-378735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1B19AD491
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23A41C21D45
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38B21D89E3;
	Wed, 23 Oct 2024 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYVGIOLZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521F1D14EE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710827; cv=none; b=GwSssVVMuKuy8ZT1Lx9D3moAdJg+4g8dKXrbNBPKHDBwwojZfXT8IacXE9ftbKF9zLxg9SvPH1MtYJQR8G7z5hTaIAZcS/nl5LOh2dCBlernVYJFHrkA2jWkj59b2XC0DbN7qKMhDY2XHCMJ0hB1iXQ28cRfoYg7Ue9IAJsJOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710827; c=relaxed/simple;
	bh=R3dkWwgNHlV+WgRIcHEKQG2yUVmk1xcO4Cpgk1toE2I=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=lzHKsRVvpJ//Zz396FEfwleQFLGQPfuwjw3bONxBB5TJ4v5EEGZxlrm3ZgLJe93kNI+nNcMImHqqqNV19oOb7SUsDpZcFwx2uaA0DJfSGa1jIRo9ioNX9T74XtaQ0GXjAJaw5yNXBPXR4gGptcbE71NkkWSp0vvXF4Wp2dr/1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wYVGIOLZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso1392077b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729710824; x=1730315624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9XbsmUl/ykzeRnfUHw2btfSodiXu3QqAkcfgdiNebV8=;
        b=wYVGIOLZWlBTd21+jdXgOy8wIk3MH7Nb+/N5VpySiWw0SlauVltkdFBCMIOinCWgeM
         TwIZ9r6O/CoSYjIrIRBkMLiUY56cdZsPZkH6CZ7lIoNN896rzlII7NocMqGs/NCNH7fN
         XgYYW2tEVtiYYBhj3WKzcTJpu8/SIOIfdRo8sasyrOky71GTIdPNAeIhXOksiTh0nxBf
         juECsnihl24Ub6bu8P2+jfc0qp74h0ZynfvM/L4Gn2kfhH0GWXpl4ss6aDAueFVse50s
         edKFdcPZuOCsUoK6LY/XNWCKBPzenwIHhFqYl07E3JsXAMBsJY4HK6k32y8vr31/1ckZ
         shUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729710824; x=1730315624;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XbsmUl/ykzeRnfUHw2btfSodiXu3QqAkcfgdiNebV8=;
        b=lRtd/7aJnfkQViFHSJvtpxNfSq5sjCysxHFysp/1TmF6v3FdeDVhw64wMCxY0DQsAy
         mEykmiyJXRcvb6DzOhwURn1/fum69zYrqlmdlfBuWic2ho1dU1IoA13zfes7QH9f9wSw
         UdjhMNoP9vzaBVSg0/Y4oZdpsG3Fd+fs/kbICW+04FRIa9/F7+BKqWJRb663nnRPtWT7
         JJGqWgu6+BYAgGsWp6m5w0gur4lmtuY86eP7C016U/VTTtC8sypaQ2IeRVA8HQq8fB/K
         Epn2YS4CCmL/5sEPq6e1P4sKBAYGfsDJeUq87KjuYM1J53q2+MI3WdtYyVcmrQoUIg6N
         u2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6pgcEZJUIdQTS1IJiHBwHRS4bTcAdfA0mSCl9sVXmVFS+BUfx+noIGU0es4Muru2ugf+XkSMyYmQ7WW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jR24deiqCNtrtXjiVtbcX1i4+ZzK8z0vFkHzdVR2uQw270Cr
	ZwDp987eI1Q6Q1c6VzxA6ma/1XsGM8TmsdppGR/WDjxhGjEHKeU2jjfteO7xC+nTiW6RzEF6s9t
	jG+f5YKx7jKsPrg==
X-Google-Smtp-Source: AGHT+IGtw++CFsHM6UsXTaa07P8s7oTXdItvei/TRQB3GwOD9DmownHZlFBOwrDDCuKJGIw70cl6vC5daxpXLbk=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:965e:f81d:c9fb:b352])
 (user=saravanak job=sendgmr) by 2002:a5b:602:0:b0:e28:f2a5:f1d with SMTP id
 3f1490d57ef6-e2e3a632bffmr3981276.4.1729710824576; Wed, 23 Oct 2024 12:13:44
 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:13:36 -0700
Message-Id: <20241023191339.1491282-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH] drm: display: Set fwnode for aux bus devices
From: Saravana Kannan <saravanak@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Saravana Kannan <saravanak@google.com>, 
	"=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=" <nfraprado@collabora.com>, Jon Hunter <jonathanh@nvidia.com>, kernel-team@android.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fwnode needs to be set for a device for fw_devlink to be able to
track/enforce its dependencies correctly. Without this, you'll see error
messages like this when the supplier has probed and tries to make sure
all its fwnode consumers are linked to it using device links:

mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with =
backlight-lcd0
tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) with=
 1-0008

Reported-by: "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@no=
tapiano/
Tested-by: "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvidia=
.com/
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

Don't pull this into stable branches unless its causing a regression in
older LTS branches. fw_devlink code is complicated and it might end up
with missing dependencies picking up changes piecemeal.

-Saravana


 drivers/gpu/drm/display/drm_dp_aux_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_bus.c b/drivers/gpu/drm/dis=
play/drm_dp_aux_bus.c
index d810529ebfb6..ec7eac6b595f 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_bus.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_bus.c
@@ -292,7 +292,7 @@ int of_dp_aux_populate_bus(struct drm_dp_aux *aux,
 	aux_ep->dev.parent =3D aux->dev;
 	aux_ep->dev.bus =3D &dp_aux_bus_type;
 	aux_ep->dev.type =3D &dp_aux_device_type_type;
-	aux_ep->dev.of_node =3D of_node_get(np);
+	device_set_node(&aux_ep->dev, of_fwnode_handle(of_node_get(np)));
 	dev_set_name(&aux_ep->dev, "aux-%s", dev_name(aux->dev));
=20
 	ret =3D device_register(&aux_ep->dev);
--=20
2.47.0.105.g07ac214952-goog



Return-Path: <linux-kernel+bounces-379236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D323D9ADBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E0028358A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B65176AC7;
	Thu, 24 Oct 2024 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+O9FxV8"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692C17C225
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750443; cv=none; b=dq/oIXRUYvTcMKVwyrGvCc+8GFrGUnG+7KObDm18MXq8RwLTTmxo4fn9BdF329gm15Ii02SC+cshe1K42VXD/Fle62KIisluB2bT90qeLRKYLX3F2OdnP5nMn5Zt3chJnA7xMLAZ2GDpbpWToFqsCF2yilBsTJzNlCQgpyzG3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750443; c=relaxed/simple;
	bh=Mr5FjaOgXQrzsjuJQ+4UFZauI2YyRX/0dCS+xJPRDiI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=OK6iOQSc0XWRm8o0k+8XMeFlLVLfAslyT/iLDqYFhAjiZ8L47eo9JNXC2nHFAIthvVbHC/HjuTIZc3vNXwB8AFI7kq9dbuP8DiG/ZdQeHJbcvphG1wHrxGt/qOKhCO+emPDAzurMCgwYE6SkenxCmThAVWp9FHrtobBMshSYiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l+O9FxV8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so7635807b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729750441; x=1730355241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXMUNc/LORv2j86/u57jzQlk6FOM7Zoz5+8UmtPcmgU=;
        b=l+O9FxV8zMyJLtiECjyP6uxQWt+z7Nh6pOzPxwoTy8TsQ03yElJJbJEDsG7X+fc0Hs
         xy6vdkz4D9T4FDkX35/oZorIHOCxHE+TjfGMmAo1Z1p2E10gftpnjinn5ugwFGJKk/8I
         SBggeJTTd8zvE9c0l0HiBbDuZ6zaGBT8Q0C+Q1j7VTHRxtsE383CG9JRO9b9oKiLYEA+
         Kr6WqBGJglU5SxMwE2G/yD8qA/q5hw7j51c3SU62dvGh7R2W6mUApmAWoal2Za7EB+ve
         ytm+q88bMY+9g7fDguAX/z/KGEX5HPLGoBg5+V3zKFb+Crl5ByyspT+02b17GBarf1EJ
         8wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750441; x=1730355241;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXMUNc/LORv2j86/u57jzQlk6FOM7Zoz5+8UmtPcmgU=;
        b=FXDCrQFAG213sOg8VWA6piITvx5LawoFfBE5jHsNnl3NLPtmyzgH5uNcPo1frukMvM
         3iRsmX0cHEldpOLZMXJNys0vqTvAk/S3iKYdlDjLu6JzL2s/tXnAGX1F8DcB1cLWpGT7
         9K+/eFImEFNwX7siqxkSfyEsgiF8dduNEFQ/SuFYCYk+ry+5C/RC/i3hCag87zTXZwJb
         FymK8f7HLGfn8/HsWigwmEDKdyf8Rzjbxa7pBKGTdYSuCXknWn+WwKo1/CTDOjqPP+pd
         M8WGQsBsYDKnBbZeSiQe8tKSXhRHa1YlTj5wfluYl0FpqNSrmvQIM+7fx9LjpdAuB7fx
         YQKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKs1AjrvrAiPF+8spg3qV2IFJpx1n7LEnJlZhXdZvLuIATHxfTFO63gpb8MeJ6+SaifME2rSLFvb60J4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqjSpmz76pB548Ohrbrw0N4BxTYlblo6XINSGe04Yd1spb5pE
	TuPR6nvfxh6kjKpbO9aQYqgRpGr//JBKB0+a3vYQwK0oYH2cvnwIQZ6EpkzDsSvz4pl8P7caYNF
	gVrp64GarSzak+g==
X-Google-Smtp-Source: AGHT+IEvWKI797qzaVIyJQytUKUTuDrxqDTilc69F1bH77+J3k5wYMBvLRY6cYuzVgsPwwCo2eftygSjpmQuXoI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:965e:f81d:c9fb:b352])
 (user=saravanak job=sendgmr) by 2002:a05:690c:9c06:b0:6e3:c4cb:689b with SMTP
 id 00721157ae682-6e866350bbfmr483267b3.4.1729750440665; Wed, 23 Oct 2024
 23:14:00 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:13:43 -0700
In-Reply-To: <20241024061347.1771063-1-saravanak@google.com>
Message-Id: <20241024061347.1771063-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024061347.1771063-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH 2/3] phy: tegra: xusb: Set fwnode for xusb port devices
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Saravana Kannan <saravanak@google.com>, 
	"=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=" <nfraprado@collabora.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

fwnode needs to be set for a device for fw_devlink to be able to
track/enforce its dependencies correctly. Without this, you'll see error
messages like this when the supplier has probed and tries to make sure
all its fwnode consumers are linked to it using device links:

tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) with=
 1-0008

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvidia=
.com/
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Suggested-by: "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/phy/tegra/xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index cfdb54b6070a..0a2096085971 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -543,7 +543,7 @@ static int tegra_xusb_port_init(struct tegra_xusb_port =
*port,
=20
 	device_initialize(&port->dev);
 	port->dev.type =3D &tegra_xusb_port_type;
-	port->dev.of_node =3D of_node_get(np);
+	device_set_node(&port->dev, of_fwnode_handle(of_node_get(np)));
 	port->dev.parent =3D padctl->dev;
=20
 	err =3D dev_set_name(&port->dev, "%s-%u", name, index);
--=20
2.47.0.105.g07ac214952-goog



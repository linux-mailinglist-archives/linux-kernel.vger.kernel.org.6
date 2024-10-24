Return-Path: <linux-kernel+bounces-379235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CB9ADBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2015A1F22A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B0176228;
	Thu, 24 Oct 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpDNcNux"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03AF17836B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750439; cv=none; b=C2PJGQgDO26Em2tLAm0/HJt12Q+Mq/2GovXWaSjb5v7AQrTSpQkeW3pUbSyLna9jmUhtcMBfTaQuAJAT6soBo8viyg9DH0KD/lpeVlUbukDofclzvkMy3FYfdzBJ01kkdd/FfLYQsxdeCGDV/+1fF68gWScGafKY6RoCk4m+A3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750439; c=relaxed/simple;
	bh=l8D/9i6mXjdrnGYXKluLekzKk5HyhssFtVUnJ+7Jyfw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=gS8nx4muz7qFwu+o6HvUwJ03nbmGamdbajiO3uQqiyBY8RThroe+dZ//rVr6QoTg6AessXWw8iVLvtVRjDiyZpGuSkfL1LIRfLCmNRgEhO0hcUmperOJkbpsYDlMIY4mW1PbH2OqHxt/HbROq7aRVW+GF1jUEUnNNDFYX1h9RSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpDNcNux; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7fb84f999so9654767b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729750436; x=1730355236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULy+zyN1BivKyLwzuPRCl/8UJCnpTGDPYrNtb9eDcL4=;
        b=VpDNcNuxDW34hq19vrx2nfDDXyLZw9bizU2zwZj38NQDPHK0zGHXvmBriTeVxkvWaO
         fzs2G2jqEm4VPeKGYqTPHToGn5Orrfbt+fjiBfIceWHkKoIi8PCaEHHhYlbq+WyHaUcz
         ahvuRJ2IQUH/HCNoMve6hne17gbkYkhbQZrq/X6XZL6cWy7NOnieBzKWjOkkm+an13wx
         0PkV9LDNsi2zWwHYpRu/fd/5lfbUKQPl998X6S4W18P4jVrKp+W6Li6G4tUXwkOBCzEx
         56+tTE0pPKKOGucPFiAYV7o7LowWGajA3KrfQujnV8Lp1ddFY7dQrappplH9BngQnF4G
         LISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750436; x=1730355236;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ULy+zyN1BivKyLwzuPRCl/8UJCnpTGDPYrNtb9eDcL4=;
        b=jkxGonSUCOyGcyuTBuJOJXd11fiKNPVh9U4XEZRioYHhmchNKgrBjZlCAMug49DRPw
         d0Getx/aavSquipQqLyLmrIfoNPrgMV6GexDf0sVRDa3a97lDRxIVSn4NEuWp6f7JuwD
         9BvcnrRHQWL4++eCmX03dWxvQzilAegBtKXz7VIiFTTlO1gD0GHnUin2jnjWJxK7n4Yr
         kSZpgK3Clnl9IACC2alKX9Equw3oLRgY7fg74xdVAZZO+gZI6/sR7olnWHYhR3QO9xdg
         CRysk8cvO25tAc9dtkozfnTXv4F3IyZ0z3lan13e/qb53/GoMxNmMMYttTTE+KexCOK6
         ZMFA==
X-Forwarded-Encrypted: i=1; AJvYcCX6vPoAKfyO/7K28MH9ZE7GMEpA86hDJ8ncF99Rl1NQQwFHZvzTaMZcs896NS5rT57+cNkzO7jAoqHObJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxKGyBQdlhFvrBnIVWp6+flfCChwHVZop84Mq57yTQLViT+8Y
	8mXqMSXTPQZ+pnFRxacLpN4wgVll48i8S7Vad0JBZs8Vbq2OrJmWRhi+qPiYaQJtEH0iQXkiHgn
	RhFdDaBXEv+3Qtw==
X-Google-Smtp-Source: AGHT+IHCEMkQ2RfyYdNtjaLmn7Q1IV6vv3d2IoDuURVXiH0KtdFNDJTv0BNk9TxANKxuJUTxCoodn7NIA1qQz7g=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:965e:f81d:c9fb:b352])
 (user=saravanak job=sendgmr) by 2002:a05:690c:6811:b0:6e3:19d7:382a with SMTP
 id 00721157ae682-6e85813d7f5mr589267b3.1.1729750435897; Wed, 23 Oct 2024
 23:13:55 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:13:42 -0700
In-Reply-To: <20241024061347.1771063-1-saravanak@google.com>
Message-Id: <20241024061347.1771063-2-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024061347.1771063-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH 1/3] drm: display: Set fwnode for aux bus devices
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

mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with =
backlight-lcd0

Reported-by: "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@no=
tapiano/
Tested-by: "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
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



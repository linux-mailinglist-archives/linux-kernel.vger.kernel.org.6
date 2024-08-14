Return-Path: <linux-kernel+bounces-286486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E6F951B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07763283624
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BD91B29BF;
	Wed, 14 Aug 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="D6ehFi66"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEB1B14EE;
	Wed, 14 Aug 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641055; cv=none; b=H6OgrobG+kfQEkv8GV0j++guLpeavuoxrrr2I8yYJ6BHwk1/pXktV4lhsyhEfw5RXeh7ml7Ui1rJwhL3GMXCVarUpp0Hm6ynRcS4rhUclNnlV1xku3tBM0/j8J/qxAbq3SPJeGYbNQRqkIPeCNeGww0GMy+8xNLQOx+Q9/TYr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641055; c=relaxed/simple;
	bh=kPrhEKM/BZV6soBgJ0puownb2x6qHW3ZunIeVUYPM3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wi4FF2tY8jKVys9cz8I8ffolb0ZDVcSaI3TvWvLGhb7yqLmgdZBB5qqwORoKwNa3n8jSl2TIH2+Z9KgvMMfoKPRYQ7scZo871E6ict2sVdBIPnyCvlmFiRjxP/o8jwamO9NFyfroZ/ItojYiTMEfSeH0Y3+yJwief5IJsOlAs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=D6ehFi66; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=j30iXy4QsqTOIAicA5a+3rBeXvQIPSkNgDc1nDonppw=; b=D6
	ehFi66wCHihwfF27B4POIa/+VtgAArk6uSGQuoNbrZyHeWvnZ/ztZmNX2nWVTMktfDSwd7fAV+LAz
	btJWJu2aWA4nN21o27S+uBzYmpyeacYGgn/OXZj06uNDmYGC0DnJ5hV5l1xeVhnVV7lXn87+a8Nie
	eN1E3YhUDi5BwLmjn61Bj3YLUl+2XrsiFbNfu7btl8kBosMROBrxDBS6rsoT0gG2KJLAv0PcxJx0+
	mmQg+NaExXADy4r0VPpnYsd0wrlh+UQ9alEFN6ypYmXUD9IYq2PNOHrr4oUi9zXlBAnQX9bW68L7y
	MYEGI0K8wuiWYBc+DK+7K8oi1clYHSOg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1seDm1-0009GK-V9; Wed, 14 Aug 2024 15:10:46 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1seDm1-000H5x-1Z;
	Wed, 14 Aug 2024 15:10:45 +0200
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH 0/3] drm/panel: ili9881c: Add JMO LCM-JM800WX support
Date: Wed, 14 Aug 2024 15:10:34 +0200
Message-Id: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMqsvGYC/x3NQQqEMAxA0atI1gaS6qIzVxlcaE2dDG1HWlBBv
 LvF5dv8f0KRrFLg3ZyQZdOi/1TBbQPuO6ZFUOdqMGR6stzjnCOuY5KAGvRlLTsMLuIvWqL9QOa
 O/DSJ74yBGlmzeD2ewWe4rhtzE9oBcAAAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723641045; l=794;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=kPrhEKM/BZV6soBgJ0puownb2x6qHW3ZunIeVUYPM3I=;
 b=u7vmfgfnUuaPrDbu2zhk1HLodRaPRiFmv5cpVhHMxYE8XIDtP5cNUFYFwVRYM9RQsQn269Ajr
 htFJjDeZvzBBn7nFLY/+rlg0C1FIOLXsAEj7UkTYV2R/QK9ywDKpVWI
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27367/Wed Aug 14 10:36:34 2024)

This series adds support for the LCM-JM800WX panel from JMO Tech,
which is based on the ILI9881C controller from Ilitek.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Esben Haabendal (3):
      dt-bindings: vendor-prefixes: Add JMO Tech
      dt-bindings: ili9881c: Add JMO LCM-JM800WX LCD panel
      drm/panel: ili9881c: Add JMO LCM-JM800WX support

 .../bindings/display/panel/ilitek,ili9881c.yaml    |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      | 228 +++++++++++++++++++++
 3 files changed, 231 insertions(+)
---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240814-drm-panel-ili9881c-lcm-jm800wx-1130fbbef322

Best regards,
-- 
Esben Haabendal <esben@geanix.com>



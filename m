Return-Path: <linux-kernel+bounces-286485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3EA951B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9721C20944
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B5B1B29BE;
	Wed, 14 Aug 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="FD55nFFr"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C611B14F2;
	Wed, 14 Aug 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641055; cv=none; b=fcSO3BX41IaOMfkjIZCUstjRrZi7R6k/5g7H0mQ1VtabPXK/pdPF/hu+A35uTD5D5l0inpRy61bnys1LRqponfLPVkCdkRc6ldhHhrhkSVWrACiUg0/zdsTQBxybkT3w+tGygGG/uU9dUPby2WEjEONSz1Za4jy81IDYYCOiAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641055; c=relaxed/simple;
	bh=H7wQC7vAmTQ7i03aRdlETI0vQg9JdGIdza7y56E1jAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ay8fL4MZx6ESSf7eU6Eti+u/WWKMynsyMNI4kgoky4taVf/ghFX7YjSVQLIsBOVA8WRScjpaOOJYDtH9wlqQ2BAXBv6F5Yma34T0n0wUX6Z7y2Qq0kmvaPz5EConXZybhCtd/6XnuZBfvAHiQOwZXODy6Qb3jtKPMLrWxjG2130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=FD55nFFr; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=I3NBjEI7N/Ip0iGg1mV/AVkW0RXIprWyuAjTu/uC354=; b=FD55nFFraZHfhUv2WhWbSSzn44
	MKwOQFOLTdX3qTLBJTG5LKsgH+CLGOjB6fWe98Gn4R5fAYoId/bLwPf3oTI7ZalOO95A0+Ek4JAdY
	6V/ON18zlER83XRGmdu+dvJBcSwZrkUGnv9yDluyEUZu+oUYgJ9F8z7srkEnD4ACbLMj0cxN++QJq
	LD4iarZ9HpZk/dEUj4ase3HqvPRNahgbK+BMAtoMx5JRldupONamAtu71rPYrqWgPXUC+LXQr/TgQ
	kKMRRu34vbzVs89Hb+8QQUY0BSe5VW+msOIchYz6QzPVtqUPhwR9SZGfRqZYiz1+cysBlGV6LRSsA
	qc+d0rxg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1seDm3-0009GP-01; Wed, 14 Aug 2024 15:10:47 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1seDm2-000HB6-1h;
	Wed, 14 Aug 2024 15:10:46 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 14 Aug 2024 15:10:36 +0200
Subject: [PATCH 2/3] dt-bindings: ili9881c: Add JMO LCM-JM800WX LCD panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-2-22a5e58599be@geanix.com>
References: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
In-Reply-To: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723641045; l=869;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=H7wQC7vAmTQ7i03aRdlETI0vQg9JdGIdza7y56E1jAg=;
 b=wOZ3k4Z5Rt5+iwzdURFXqVsQM3pGUIQd6DO43D5TNANlKblEOYBj3ke5y1EVVXWeVnD9oFj5c
 vLS0Nbvo8UqD/2p4/cdAAtYDLO1U5/n9IilBG8JU3YCcTf08xbaRpqk
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27367/Wed Aug 14 10:36:34 2024)

Document the compatible value for LCM-JM800WX LCD panels from JMO Tech.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index baf5dfe5f5eb..c3f1ffb0c207 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -19,6 +19,7 @@ properties:
           - ampire,am8001280g
           - bananapi,lhr050h41
           - feixin,k101-im2byl02
+          - jmo,lcm-jm800wx
           - startek,kd050hdfia020
           - tdo,tl050hdv35
           - wanchanglong,w552946aba

-- 
2.46.0



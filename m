Return-Path: <linux-kernel+bounces-215369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9489091B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B19B295A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A641AC235;
	Fri, 14 Jun 2024 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j9mZJCji"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6A71A2FB9;
	Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386378; cv=none; b=L7oFe04NT3OrrkyvWG2Q+q2EtYVxkzNiooozasRkibXeB029pMrY67Qfnug8X69zLESB9yDyweu0+VLRHbCxOM3D2p+UVBxCoU+hGu8E4ITgCwamcon8Nc1MzdpxORsXH0Sc0EZCLFeMrsNPN/znBj00rZM6G+F0fjImFn6dU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386378; c=relaxed/simple;
	bh=jCoNvzNYdAlBtWeLwq9+MucCPKALc9tEZvAvUc+Vmj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GibUh8BHYJJ/W9zaUnfNKzXZrzzlk2UgC5+1GR8jG9ZCQAr8i8Mt7p1xhsrZBfIVE7bIKBVnRv92lcZCitQSD1F5238WX1Z4Fi3l7xper6rD0tt/S9Y/RHb4ZP7NcH9ihDEW107joqHQufyts7vAQT3bgIleKPg5Z7w+IkTbPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j9mZJCji; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8A994FF807;
	Fri, 14 Jun 2024 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ETpH9U3zJAUx8gMI+S0kUDXLMTaIq1vXRUaXwjXffw=;
	b=j9mZJCjipsjNo9x7akuPGHHDXKc0Wm1HJ4TWq+w5/oxvjSXJeUY+HI4VGcrdMaAoDxP+sf
	vjpuSZ2vzgCxSbmmbnmNnyBDB+XHxQWKG8KuiZbd0HAJ3Yh93hcoENeyGrpSzUa9yJtufb
	crnSJHlhie1of9gkpFRwnOnGLsOiVUXyMJPhQSzGrDrS2y3g0tJRrShODauoGhpzLlAt2q
	ETxw6v4nimxi2MFQx/Y1I+tShZ7zG+bTZy703umJLkihTezVbrD1jtcp+1yQzLIUEoQL6F
	qHXckEQOvxIF/VFUHFzQbnqrL6oEjC+FCQnjr4UeaZyfu+Y6Scc+P8vc68kiZw==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 04/23] irqdomain: Constify parameter in is_fwnode_irqchip()
Date: Fri, 14 Jun 2024 19:32:05 +0200
Message-ID: <20240614173232.1184015-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The fwnode parameter has no reason to be pointer to an un-const struct
fwnode_handle. Indeed, struct fwnode_handle is not modified by the
function.

Be consistent with other function performing the same kind
of operation such as is_of_node(), is_acpi_device_node() or
is_software_node(): constify the fwnode parameter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ab8939c8724d..a3b43e357009 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -314,7 +314,7 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 
 extern const struct fwnode_operations irqchip_fwnode_ops;
 
-static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
 {
 	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
 }
-- 
2.45.0



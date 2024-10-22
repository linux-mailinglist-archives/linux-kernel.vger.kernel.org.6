Return-Path: <linux-kernel+bounces-376322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D879AA32A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6269E1C2228D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A3B19F406;
	Tue, 22 Oct 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VLGCSs1W"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69C199238;
	Tue, 22 Oct 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603861; cv=none; b=BCLxiqqsbLG7a2PXe3cJxk3H4CK6YZ3v1SVZdpANg1hs9ELFS9pKIQDAna+7gPOCi35/hKuBtXh9cJPBRKPuLa55DH/lQbTi/AFcalfCcLwds/t1ClZ3LuE8S8g54n1RpYY1xh/rO6Z/nDCAUboMMrD3Cfjq6dLyG2FHwOI4qm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603861; c=relaxed/simple;
	bh=bo2zSEnLxRUd8cXvWxm+2fGoXpZEaSTMnZlREMzd/TM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lSAPyvfqwlyBLqOHl6YHcTpyKCh3fMn6XMIXSzfHQzc+SONN5RLNb0bdc0FCVWpKpg4g2NnJVIWbNXhPP2s3g9ODkxZdvNyxGnd0KmCXikhzdTqDnSjMZNWSfDYebWw6N3zm7UjCwnMFrf+coQGfPta8Q/3q0EuP+SSPih63Ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VLGCSs1W; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 0BE5588F4D;
	Tue, 22 Oct 2024 15:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729603857;
	bh=/8jLXotQrE7fuRlDFjaApw4iVJpE2qFGjJxOo9h6Ezc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLGCSs1WAzfpt4VW1ex4TEp4xM4xUQrNyvu1lrpqiFuOQ0rncsx2qcjonum5MD1iv
	 Usz97IHzsIi4MLpqhWdxuhLhz9NzmbO0Ifa0svAuGc7iI4VEYNweG/9yh1Dk4JzpJv
	 Bie95TxVkDaEeDoXfvFk3tis7GpBuLWEE8/5edTgK4LyuhWGNmpW0r3x/JiVo6oGGg
	 2ygkVb39II6Tm0yQzvLBLJICRRyaWmbXN9c7tYzZFFdjtIas0dfOFnzHVVP7y/IA5v
	 6P0dL6bQq/GI4kuFUhunNc6oVNQUWRRMkxDA3cKsACh+gwwn+fmCA/cKsW0tCL01NU
	 CNKb6cmyYSGVw==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Lukasz Majewski <lukma@denx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 3/4] dt-bindings: arm: Document the btt3 i.MX28 based board
Date: Tue, 22 Oct 2024 15:30:39 +0200
Message-Id: <20241022133040.686562-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241022133040.686562-1-lukma@denx.de>
References: <20241022133040.686562-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The imx287 based btt3 board is very similar to xea in terms of used SOM
module.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
Changes for v8:
- None

Changes for v9:
- None

Changes for v10:
- None
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 014cab2a0cde..f865b2d44a65 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -97,6 +97,7 @@ properties:
               - i2se,duckbill
               - i2se,duckbill-2
               - karo,tx28                 # Ka-Ro electronics TX28 module
+              - lwn,imx28-btt3
               - lwn,imx28-xea
               - msr,m28cu3                # M28 SoM with custom base board
               - schulercontrol,imx28-sps1
-- 
2.39.5



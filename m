Return-Path: <linux-kernel+bounces-339480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B459F9865B7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEF0287EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43913A25B;
	Wed, 25 Sep 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpOLuYnE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A777117;
	Wed, 25 Sep 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285701; cv=none; b=WgG8IkuRYJe/PUb5Zy0p/019zya2eX/xiiFN06NP9WYvkW4yhTRY/IHASic/PQ3S5jpEA+6rZp28O1DYJoy5SUAC5MBv0qBnJoQFQq6d+is/OfY3tRFUHSG+LR9y3htL63RGj7p5ESlmHGZFyyUXGZoYqYGOhvRdbfwvTQ4lPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285701; c=relaxed/simple;
	bh=PknjQbNiw/djMdS+Y91wxat2ymt8KIh6qfLthVSx4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrqbECa8OEvpzXSGZl2HBkpoPCd1IVhpDrGdC1mCLzqRBqa70IUjMh51zF98I6KHzaETRGpJd0gDnsTyty4e8q5EEzW2IWSDaWP9k70e/lC5SPWacK4iUoVEnaC6ikyHi8k2W5u3j/YIVXflp2ATkRm5TTWnb037uRRYCE9JIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpOLuYnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06190C4CEC3;
	Wed, 25 Sep 2024 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727285701;
	bh=PknjQbNiw/djMdS+Y91wxat2ymt8KIh6qfLthVSx4Q8=;
	h=From:To:Cc:Subject:Date:From;
	b=CpOLuYnEVuBqG5+nGYhe7T7sNmET3vgLmGFyG1CN1K6PDMiNc9EyvVzd70iX927Fa
	 QOJnyK1pYwMvkYNcvRoXyMxqiSpZJWdTev/E6VkmI0xlTYIUVVtCr47YPILf92e28c
	 F2zR7kTf718Z+3+cJgf9aIOXQZNBhFpAnKArK1tkiUElnH9UpnT7rV1bscpUOs45Vk
	 SezbAKow1yxH6VjcgarP2MU29zs5tvpTWgtO9CvHGehI5mmbQ5kUHWxwVHiGDwv9Nj
	 84UFgKLZHzVYWMjfprs3qz/QgYGne8ZdnwmZe/ah0ci5Zi26yg8m3LhnpADcQmyD8v
	 5VhaiPJ9YKONw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wayne Chang <waynec@nvidia.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: cypress,cypd4226: Drop Tegra specific GPIO defines
Date: Wed, 25 Sep 2024 12:34:48 -0500
Message-ID: <20240925173449.1906586-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Tegra GPIO define is a problem for the magic code which extracts
the examples and fixes up the interrupt provider. This was partially
worked around by putting #interrupt-cells in the parent. However,
that's incomplete and causes a warning when dtc "interrupt_provider"
check is enabled. Just drop the Tegra specific define and simplify
the example.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml b/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
index 89fc9a434d05..0620d82508c1 100644
--- a/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
+++ b/Documentation/devicetree/bindings/usb/cypress,cypd4226.yaml
@@ -61,18 +61,15 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/gpio/tegra194-gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      #interrupt-cells = <2>;
 
       typec@8 {
         compatible = "cypress,cypd4226";
         reg = <0x08>;
-        interrupt-parent = <&gpio_aon>;
-        interrupts = <TEGRA194_AON_GPIO(BB, 2) IRQ_TYPE_LEVEL_LOW>;
+        interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
         firmware-name = "nvidia,jetson-agx-xavier";
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.45.2



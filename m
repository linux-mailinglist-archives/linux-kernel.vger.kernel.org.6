Return-Path: <linux-kernel+bounces-183634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF28C9BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4CB280F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBF453384;
	Mon, 20 May 2024 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="d4uIlM+V";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="QNc/u9i3"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F31C47F7A;
	Mon, 20 May 2024 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202751; cv=none; b=lTPyabzhDgftJ6nNkOyr50Zt6VY6QSVCfats/toCIeVNL1B3pHhXjCtBTntaB/+CgFWzziPXU87tmEOVd0HdmtDThzq3xT7BDDb5DLxRANQrBCkpm+wqquegDhG+1hT32b2bZvU+10sjOt7VnD31iRgeZ+qiZZLm/ytQ1mI1Fiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202751; c=relaxed/simple;
	bh=LVap5KcHhie4Ew1SwXzHWoCTe66JbKygQVQhZNZNkfM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BVD8k5M0CyHjUaYdC37/B/JnPCz0X4AAm7w50/+SVyua9+N20b343dHTArKRchuh+JDLjQ245IHfXHmsdQ2aLkQsTuZmyhdINOMXB5Gtoe5WL0w2Ugi94Ih8LZMlNhU1YqknZqLd2ISHVQfxPn+s6CZNp0zQC0VNlj+dXErPzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=d4uIlM+V; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=QNc/u9i3; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id B0E6AFB03;
	Mon, 20 May 2024 12:58:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1716202736; bh=LVap5KcHhie4Ew1SwXzHWoCTe66JbKygQVQhZNZNkfM=;
	h=From:To:Subject:Date:From;
	b=d4uIlM+VCv4q+xSA/gVe+v8nUuH7kOkhqEvXmHJYCFyKy2Zz3nUzbE6Ro7gCOUCXW
	 1ApaTm+a1pDc5dg3f61kaHd50uzQkR/bYpVuuwEoBeJDo2O9Os5/4wmxvUjMSjTNY1
	 caGo+bl/43hwigIqXsxBqE7BEEZHU1nUy5LY8gi/XYK2PlS+NExfW6OqcjilLDKo/n
	 4l7CM0nJd7j7DYj675h+I7V3T918+YAdWv986SeBYFugtmb1vP+i6rA7XbinCsSdCu
	 pUooWkjlEpMWkVVRsbnw30QtxXrO381p8uaC0zX7NKiK3nblkZJNbYRldGpmjKBbZj
	 SMFHq7QG13aDQ==
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1t31Xa3dvWmD; Mon, 20 May 2024 12:58:56 +0200 (CEST)
From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1716202735; bh=LVap5KcHhie4Ew1SwXzHWoCTe66JbKygQVQhZNZNkfM=;
	h=From:To:Subject:Date:From;
	b=QNc/u9i3S77ioYu1u/mAmNICEpCx+G5WhKGLHB5R2QX2qzV1zOHolrlirVaL4ZfN2
	 B/IFJjqdZsZguV+WufLE0s6xH8lh2rbM9Esg4ogcAfYt3TVpCMORbDWHV1MRrak40b
	 8VnUzGhv0ZPKBBhaQjjVBh0gViv/RNdmSj5hBk1C69QH6cN/GVCCzM/sGxzZ1A/Jab
	 lD2hSnoNVOaC4GvnwSAwazDC6RphUCNHXoZiETKPw0JNB/JFQEQT2VQiYfFEFBRo/H
	 tL9TjUqUhIXNuw7LjWaE0eSAc0ck0ild7DF13jEEvBHx2sRk5lAsBeCazldTGrqOb+
	 AdAamm2Qk1IQg==
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org,
	kernel@puri.sm,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] dts: imx8mq-librem5: Don't wake up on volume key press
Date: Mon, 20 May 2024 12:57:05 +0200
Message-ID: <fa416916049e85ca159805e8602fa8361d5e6d83.1716202515.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The only key that should wake up the phone is power button press. This
prevents accidental wakeup due to e.g. pressing the buttons in the
pocket or backpack and is in line what userspace uses to unblank the
device.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index ffb5fe61630d..1b39514d5c12 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -45,7 +45,6 @@ key-vol-down {
 			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 			debounce-interval = <50>;
-			wakeup-source;
 		};
 
 		key-vol-up {
@@ -53,7 +52,6 @@ key-vol-up {
 			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			debounce-interval = <50>;
-			wakeup-source;
 		};
 	};
 
-- 
2.43.0



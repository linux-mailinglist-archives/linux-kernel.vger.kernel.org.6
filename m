Return-Path: <linux-kernel+bounces-187608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798A8CD52E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3941F1F21A13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2814B07E;
	Thu, 23 May 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="B9WduptF"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FA14AD2B
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472729; cv=none; b=X/nn5XwFMzx66sqVQhUxSBf4sdZObbCe0+X2mxnnTSCowa7cH/AXQVPO1OzvDiXRnnHxFDM5sQBaCojEZ/1sK3Eq0nWTsqNRJFxIQFAI+E4IlvzdiUyzi3MVGSq/Dw9llorYRkVL9DTKzBiufXnqnGGpM5sw1rAIbY1N6QW1VP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472729; c=relaxed/simple;
	bh=K8S/RH5xbSFWbYcSj/xEygnrg6Y4m/tKjga93P359e8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QZubh4Ff/oallNR9mCrTSLUMxDto1ihh6fN1/I/YGhTmOnK4TgtZ14+RFzhG10Ox3dFIlcK29E/CVEHdyv22JbS7fvyLpiycu4anFr7HyMFeCYsIjPsHrYaS4XFKTAmg9A2aJbXzi+9RnXDhCA0fKhYmS7W5PneP1AVUJAtwyKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=B9WduptF; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=Wi7mrKqXXrJP2C7bbxhuWiixIqln+QxOIIfqxzOJhsE=; b=B9
	WduptFYpkNFUY/yOKcu7PUOWulGWckQ9s1eiukQWg6xDcHopsS022VdxwN1bH/ThCTNwbCM1jl18+
	T7ggZulEdyzPcVbENgxE2TwYeMMFq8FhWWIS3wV7z0D2B+eM0Xtj2fdfrWYkmOqOW84X+NjA44u4K
	1sf2ELgpGCqTHPXYQAN9dQhz8SZoAftMhcLxjqs9uRN0ibqmXxhVIhDJhErrHSjM+z3VM3iTVok5B
	TvjkFe++Swfbln71vwWLlWEAmUh3Ys52OxzGN6pzyNXP9GfLKCjFBjpULSZGV7pyM8tKtNJxRrbjN
	6fECV2DI7ohHDtw1dUthqERwIQEf7T5w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sA8xm-0009t7-4N; Thu, 23 May 2024 15:58:34 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sA8xl-0003xo-1I;
	Thu, 23 May 2024 15:58:33 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 23 May 2024 15:58:22 +0200
Subject: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
X-B4-Tracking: v=1; b=H4sIAH1LT2YC/x3MQQqAIBBA0avErBuwqTC7SrQoG20gLBQikO6et
 HyL/zMkjsIJxipD5FuSnKGgqSuw+xI8o2zFQIo61VOLLh0ozqI9gxOPdtDaKFrJaIYSXZGdPP9
 wmt/3A7VDsm1gAAAA
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716472713; l=1025;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=K8S/RH5xbSFWbYcSj/xEygnrg6Y4m/tKjga93P359e8=;
 b=qMuktJFS7Ku96n3tugCChtvnkI020HZp6LQY2vjkxJtjzq5YyGqp4QT7ihudxDbqvvFJ7p5kc
 4dXzuNWAZPCDV4wHDnPRFHVKrCOskNIYCrfGHJ5Tah+LRPszD0Z6MmS
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27284/Thu May 23 10:32:30 2024)

While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
driver selects FSL_IFC automatically, we need the option to be selectable
for platforms using fsl_ifc with NOR flash.

Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 8efdd1f97139..c82d8d8a16ea 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -167,7 +167,7 @@ config FSL_CORENET_CF
 	  represents a coherency violation.
 
 config FSL_IFC
-	bool "Freescale IFC driver" if COMPILE_TEST
+	bool "Freescale IFC driver"
 	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST
 	depends on HAS_IOMEM
 

---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240523-fsl-ifc-config-c877902b297e

Best regards,
-- 
Esben Haabendal <esben@geanix.com>



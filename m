Return-Path: <linux-kernel+bounces-298298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AB195C568
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4837AB2197D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6F74BE1;
	Fri, 23 Aug 2024 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Js1f5327"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3303F9F9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394300; cv=none; b=B6hmS5M/69W9EotDqfD6grt6yyokwNVVCeDLp7UPbmUhv50NnFUAeD4dz4QG7gqUMa3TaSeAwBTuaRrT5REjKbGlCyD2Szb9QmXsFIOi3UFx4CUhMhRTw+moirzPpd0aGhitvaTdjfmXvUAo0me/XFrzNsRVFr2HxQho0+cKeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394300; c=relaxed/simple;
	bh=PydE0ACRGG/uOJE3Ud5bKLryRBQqgQOWQ16ywi2KerM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdUptG4G4dN8XvInbc2ORAnR2lrFRAXzaK6xTVDN25rpYIMwBCYfs2C5xsNXD8xUkBxwnx/0DD78ZmSW+1By2naZfJ9StJXj7PSqcxVP0/RIPtjgcNrc9mtwz1UWZCqSed91ou52PIg3gIRFArRe7UnR5NxEGbf/DU5Xw8ER9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Js1f5327; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724394296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UPXD9Xz1BaTvCyjpi0+oHDqdxADzbC7LmDSjyBTL2ZU=;
	b=Js1f5327/2ReHDnybS21HsuIFYM0PkcasXCRxJRio3ru4dIOMSBGsXhBUPe1TBMtspMCB0
	hjWe50lK4406LL4sC12TSHpUoFH6wTnv+33uQ9GfWs9rF7TzuZasRMyGlRmNzF74LpU/v6
	SWMuF1qj1dTRKJIpTL9aTFW6jmTMAt0=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] bus: fsl-mc: make fsl_mc_bus_type const
Date: Fri, 23 Aug 2024 14:24:40 +0800
Message-ID: <20240823062440.113628-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the fsl_mc_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 include/linux/fsl/mc.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index dd68b8191a0a..930d8a3ba722 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -309,7 +309,7 @@ static struct attribute *fsl_mc_bus_attrs[] = {
 
 ATTRIBUTE_GROUPS(fsl_mc_bus);
 
-struct bus_type fsl_mc_bus_type = {
+const struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 083c860fd28e..c90ec889bfc2 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -436,7 +436,7 @@ void fsl_mc_free_irqs(struct fsl_mc_device *mc_dev);
 struct fsl_mc_device *fsl_mc_get_endpoint(struct fsl_mc_device *mc_dev,
 					  u16 if_id);
 
-extern struct bus_type fsl_mc_bus_type;
+extern const struct bus_type fsl_mc_bus_type;
 
 extern struct device_type fsl_mc_bus_dprc_type;
 extern struct device_type fsl_mc_bus_dpni_type;
-- 
2.43.0



Return-Path: <linux-kernel+bounces-418356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F909D60BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE8A2814C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC70476036;
	Fri, 22 Nov 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="uzsdk1BC"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D12AF04
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286886; cv=none; b=cX7lowQ8L2IjX8I/XkCoD92lveFlfTUzInUt3uDAA5deUSw8JFkhIgjHZsI+DoCwNAEvvnYfynk37mpsbsLtzfuLnJRPvALgVrKJzZZqL/Lw2IYJzVXmT9pRilebrN2FjQJQPWFqSPAJoPEeg+cFcgeybLQjnHjviu5Eikcz7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286886; c=relaxed/simple;
	bh=k0DLlJF5pzxf+dcq5+CjwFaUm4bEs1VCSTahRbdTxzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBA56uTbcWdoxmRnKKmREAFK1gVzV7FbPowVMo3XuFyM6ZANCH6s9l6WAt3EK1e0FIR+pvF8A0a9f4r26b3zqlFxiorjgjHKdX9i3ds4iwVydM9kwGvlHJqpeiCP0RwhPCzR5X6m7k8Fiz/g1NGbP6riBnC3sbsiXxJgfCZmWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=uzsdk1BC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 81AC914C1E1;
	Fri, 22 Nov 2024 15:48:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1732286882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mChST4oG1qTA4hRQNt9WCwIj728ndP8rnvxu0Kdgk0c=;
	b=uzsdk1BCqr8wi4Znob9ds8rgWKsF35V8cYc2KSwskhfEQVCSDP5GHszd/jnUzlDbvHv35A
	t9u1VfavpoObfmRMzbA5x1Rg978gWAkni68kGVaAzteuLZmY16NElhXwqOrjYvPtlcj8Ni
	naHZh4Tu+mIZMfioCjj9QCa/f3AM7SzjVVeW0yPJWtfT9vHVCbr/v3zSPUATZrJWxmmCDk
	714y9mp3wIJrm+yi7dkeWMXQOKOs97xRPx6mZUa9r1FEAo6wNLuF0/EeAhQcSGxVmDKPUV
	2x790r0J8VkZx7vwMCzlCCER8CTJPKE7XOWcblOR7bmXwdxESi0BpnSZZY+Nyw==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 837d027c;
	Fri, 22 Nov 2024 14:47:58 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/9p/usbg: allow building as standalone module
Date: Fri, 22 Nov 2024 23:47:51 +0900
Message-ID: <20241122144754.1231919-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason only the usbg transport would not be its own module,
so make it tristate.

In particular, this fixes a couple of issues the current bool had:
- trans_usbg was apparently not compiled at all when NET_9P=m
- the workaround added in commit 2193ede180dd ("net/9p/usbg: fix
CONFIG_USB_GADGET dependency") became redundant because a tristate item
cannot be built-in when its dependency is a module, so we can depend on
USB_GADGET "normally" again.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Link: https://lkml.kernel.org/r/ZzhWRPDNwu225NWz@codewreck.org
---
 net/9p/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/Kconfig b/net/9p/Kconfig
index ee967fd25312..22f8c167845d 100644
--- a/net/9p/Kconfig
+++ b/net/9p/Kconfig
@@ -41,8 +41,8 @@ config NET_9P_XEN
 	  two Xen domains.
 
 config NET_9P_USBG
-	bool "9P USB Gadget Transport"
-	depends on USB_GADGET=y || USB_GADGET=NET_9P
+	tristate "9P USB Gadget Transport"
+	depends on USB_GADGET
 	select CONFIGFS_FS
 	select USB_LIBCOMPOSITE
 	help
-- 
2.46.1



Return-Path: <linux-kernel+bounces-180944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B29C8C7546
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E7AB2268D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8B1459FE;
	Thu, 16 May 2024 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="g9jNpinp"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E5145B04
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859104; cv=none; b=stdvEFY2vWD+HxtkNTiCDVYKIY2MqjafZUQvBPC2B0vB+8b6UdmWzdWmQkjczk5EjzxLvb3uV0wkgJFABrEvVimMJHLjYMEo104a9kXDDnL5yOMUmRzbSVXaq/lVYM5o8Mq6iw05zw+B107Q46c5GWLG1xct9KKCAk2PtNdRabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859104; c=relaxed/simple;
	bh=lBKWNCjz5XeMeeVLKV0cVIhl8GuROrhj8AxVnzf8uiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAx2vA0pz5ZYwGmPGcaxLHWbjmN09xmlB31iw3WejZhl/ZMTPHePbruNarx40Yuqw/8qSCeUcNtr0sHHhV5j+qTyM45GmxXdMAjRqRgQRIJufgOn4PxqrDCTG8/y+VjpwZh9HCVEUiQ2lyVDL/0/s9hfLTeS1olL3S6zHJlb2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=g9jNpinp; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB584181C2E;
	Thu, 16 May 2024 14:31:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1715859100; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hLJvt3Qp8v0w1uJwmrYsCccfbrCeUtcFvurCzwm/ryk=;
	b=g9jNpinpkHMYurNslyMiEuGtbzGGZ2TIYQDy7RVJDpy3biesMJBNa3/c2d45MXJ4RKqYpF
	hhGTxi8A1v5Yol98OElo9K1Wbf1FzwSahKr1YC6KQhW2TyGOxzlVAnMPAaFCw5BC0cr82/
	1SmSZFDAAvhBfGijvlrRIIbuh2p7EbqLQMtDpljWq5+/USwWCJFojYfOF0wqf0gG1WCCP4
	OFzNgj3ZNi/yHy4yTCHlQNdwCwsY8xZtjN5Hy7dpfZQ775ARKq/c8xoIyNxkwUJ/u/wYzn
	t4+r5F/Xr97lYNOC8YaqyePp22cGCYFI4LKxZQIGoWtcLa/FONKxAYZNWc871g==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 3/4] soc: amlogic: meson-gx-socinfo: add new definition for Amlogic A113X package
Date: Thu, 16 May 2024 14:26:49 +0300
Message-ID: <20240516112849.3803674-6-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240516112849.3803674-2-adeep@lexina.in>
References: <20240516112849.3803674-2-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add new definition for Amlogix A113X soc found in JetHub D1/D1+ devices.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/soc/amlogic/meson-gx-socinfo-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo-internal.h b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
index 3ebb80972fc7..2028101bb9b2 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo-internal.h
+++ b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
@@ -78,6 +78,7 @@ static const struct meson_gx_package_id {
 	{ "962X", 0x24, 0x10, 0xf0 },
 	{ "962E", 0x24, 0x20, 0xf0 },
 	{ "A113X", 0x25, 0x37, 0xff },
+	{ "A113X", 0x25, 0x43, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905Y2", 0x28, 0x30, 0xf0 },
-- 
2.43.2



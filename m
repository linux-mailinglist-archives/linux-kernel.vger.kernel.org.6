Return-Path: <linux-kernel+bounces-409313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477879C8B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73531F22142
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846481FC7E7;
	Thu, 14 Nov 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XgQM9uMr"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88561FB883
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588693; cv=none; b=c+CligQdO/YQnlRkCuIVu1HhYzsTwYIXMllgtNQ6s/qoDYVgnq5/Kf5bU7CYo1fv12PhRQCxpXQggfVs5S67ByrJSQYbuG1LUtAemuOM+Mkynh2/aWEbkC02G2MvqPQazpg73FzUex2d3/BkcCozabksKla6IxyhHNEmXylZVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588693; c=relaxed/simple;
	bh=Bme9HoCO17oLCcMrdqLj2xxeRtpwjynLmGHFMgF1iWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6pTVybpo569IgDeu3v9HbmHfl3Q/YDkNGJChRIknUDLPs0YlX4VdMumlzzuaFvbQJ1p0XwJGoAy1h3TTKXimK7hJpv9DCRWGwp1BPyPjBD0nEiAoTQDJcl/sjiuFx2Hud8VT3Ty+1oVhNU/beoi1tfRkz0wZRfLWSjCkZD1AVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=XgQM9uMr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588685;
	bh=jI6uzr4iftvLEDrKaIrfDHLTu3TXT4BdDaqup2quvik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgQM9uMrd8iaRiMJvZ9j+abUeH7VQN5utmtmMxLU1I9i7K4Or6My/OvaT2/pm2CG5
	 0qSqoHsI0zBh3qZKvCXUVGPlhqqJl54cY2Lmmks2HY8j1jZ4KKWRlBnmTTnZTjQ9u3
	 28bVtsT5/wLRcH20dfnIMhBuTN+y4upxmSddypEABk42MWJ4eY+8Cs8f5A12JQMZL6
	 qx82a05j3tyJ+ICsAYXL6V0Rybnwo2sML5a7OAbbsBdDMBBEGFRz5xAlCX5acAlOUf
	 WU9D88FiRTAhGfebBfGYxO0hUmz9hn21lbZVi3sEsouAmi0B0K0p7hChvjBk0OwMRB
	 88v7/LlcizCjA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QP43dtz4xcN;
	Thu, 14 Nov 2024 23:51:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 18/20] net: toshiba: Remove reference to PPC_IBM_CELL_BLADE
Date: Thu, 14 Nov 2024 23:51:07 +1100
Message-ID: <20241114125111.599093-18-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a reference to PPC_IBM_CELL_BLADE which has been removed.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/net/ethernet/toshiba/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/toshiba/Kconfig b/drivers/net/ethernet/toshiba/Kconfig
index 2b1081598284..b1e27e3b99eb 100644
--- a/drivers/net/ethernet/toshiba/Kconfig
+++ b/drivers/net/ethernet/toshiba/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_TOSHIBA
 	bool "Toshiba devices"
 	default y
-	depends on PCI && (PPC_IBM_CELL_BLADE || MIPS) || PPC_PS3
+	depends on PCI && MIPS || PPC_PS3
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
-- 
2.47.0



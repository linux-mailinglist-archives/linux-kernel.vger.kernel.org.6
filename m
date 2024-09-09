Return-Path: <linux-kernel+bounces-322176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8341F972552
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C651F24B96
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B118CC01;
	Mon,  9 Sep 2024 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jr2qIQ4F"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B568F5A;
	Mon,  9 Sep 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921134; cv=none; b=iivwldc7QBzMPdwR3qXbiaw1Y0sAIRPgmjE9aR4SGIeY0+ZemNJZ1B/6Tlp92QqFDF/Teg6FuAMqrWQW6vGv5kbttsrFg+ebxbQ2Ss+nFR7fsF6g6FoS0nK3jhPZA2w2kVGy4m0eJZfhNPEVMGfzl/CJ6OjJFxkWLg/gVn/gvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921134; c=relaxed/simple;
	bh=tsqDLvP9vPRpFgxpyggr8Z+DWHVh9ytCS8RNAb5/4PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOcxC/eCGv1nKHCm5TOLuRSzLwFv732Dj0oK/7rp9Yz0a2ZYuORKVhN3k+oyyXt3CsVYWRYDcDUKfkDciJMWxeHRGtcJ8WK2dGznGGZ+Xc/+j8Cjb6H4AA6zSvTZDCG9JJMy5VYm1L7bjbtmmi7HdwS1jRmyIKtvZQ/CL1sQtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jr2qIQ4F; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hx2KsAtNeN8lDjIIK64wYqeEJzRRQwAj00bZ+1+RjZs=; b=jr2qIQ4FOwzUMcKX+WHC7m7qA9
	rkuwY6L5L3grjP0BSFnMTz1K+3IY5Uu454r+cUCb7YGG3h0SKlKWOGYEgJHtGwJaKSNdstl2TXCBX
	qN31O9UOy5VtBJFgiweUofkjswF0o/DuLvOe7KnpmNTlO8YjtY3etEUqKCxWDtgDrtmnV9QQYs/m4
	UytYFKq/J4sHjFw9ghDdQ7zfxa6h4bzfLqoOsXUmkWt3+/jqvuBUhVVM0nZFfXaqhJKXB/1+A0ZhT
	Fb/eMU27oOAox/JOSXoBcDgWCd1I4lZ9/DOWORESx7OIbeziPX+4DERybzqMoS+BFQcikkKQFPdOZ
	sW0xonmw==;
Received: from i53875a02.versanet.de ([83.135.90.2] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1snmvJ-00064D-7q; Tue, 10 Sep 2024 00:31:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	detlev.casanova@collabora.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: clock, reset: fix top-comment indentation rk3576 headers
Date: Tue, 10 Sep 2024 00:31:49 +0200
Message-ID: <20240909223149.85364-1-heiko@sntech.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Block comments should align the * on each line, as checkpatch rightfully
pointed out, so fix that style issue on the newly added rk3576 headers.

Fixes: 49c04453db81 ("dt-bindings: clock, reset: Add support for rk3576")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/rockchip,rk3576-cru.h | 12 ++++++------
 include/dt-bindings/reset/rockchip,rk3576-cru.h | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h b/include/dt-bindings/clock/rockchip,rk3576-cru.h
index a2933021be89..25aed298ac2c 100644
--- a/include/dt-bindings/clock/rockchip,rk3576-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
-* Copyright (c) 2023 Rockchip Electronics Co. Ltd.
-* Copyright (c) 2024 Collabora Ltd.
-*
-* Author: Elaine Zhang <zhangqing@rock-chips.com>
-* Author: Detlev Casanova <detlev.casanova@collabora.com>
-*/
+ * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2024 Collabora Ltd.
+ *
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ * Author: Detlev Casanova <detlev.casanova@collabora.com>
+ */
 
 #ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
 #define _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
diff --git a/include/dt-bindings/reset/rockchip,rk3576-cru.h b/include/dt-bindings/reset/rockchip,rk3576-cru.h
index 291fec0ecba0..ae856906f3a3 100644
--- a/include/dt-bindings/reset/rockchip,rk3576-cru.h
+++ b/include/dt-bindings/reset/rockchip,rk3576-cru.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
 /*
-* Copyright (c) 2023 Rockchip Electronics Co. Ltd.
-* Copyright (c) 2024 Collabora Ltd.
-*
-* Author: Elaine Zhang <zhangqing@rock-chips.com>
-* Author: Detlev Casanova <detlev.casanova@collabora.com>
-*/
+ * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2024 Collabora Ltd.
+ *
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ * Author: Detlev Casanova <detlev.casanova@collabora.com>
+ */
 
 #ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
 #define _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
-- 
2.43.0



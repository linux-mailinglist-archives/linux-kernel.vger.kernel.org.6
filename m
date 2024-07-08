Return-Path: <linux-kernel+bounces-244058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3955C929E88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33CE01C226F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81A34D8A1;
	Mon,  8 Jul 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W8zPPwr8"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340602D05D;
	Mon,  8 Jul 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720428941; cv=none; b=J/wzhCNcWOjFpXjXqFhOvc0anY9C5QCbximXDHygxMwWFvg3va5RhqFThJbAQ1I6yPda1YlyKpGnKOjk1t44rspK7FqBFfNVCBSvfOm7uOhQEHdl+aTnrhcTX9yasd+Vf4uq6Gniqdt26a71IAA/Oz9jSCIEE0bezzG3vcV2BG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720428941; c=relaxed/simple;
	bh=6loMpFpx3P9PFnAc28r8p2yWuBnloCE5jWkAX0Wzl64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dj4WK5opKxyhl9qhrcgyneT6YBcnSk5HEPOM+GP9NeSbd4d3EyOQyYUVOkh/3anGZyERw1Vi/s0zdHOZNDoue7DuUeRJAqrjF6LNlDnjrkeL0Anxc+xAYJz9CVhY1r5Ytrc1l3VWZ0w2lyTeFV2DkVVGUQlNnodt9FvYaa51UXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W8zPPwr8; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2ADABFF80B;
	Mon,  8 Jul 2024 08:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720428936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LIRhsvv/pIVr36oyhlkGcGkygXhvNc+0sDuKltZxyyM=;
	b=W8zPPwr8wJbYRqqZpfKafh/ovWZuVi2za8KrcBuLYz3qvWIpVLfBqwmX4NVwBYfIw8bj75
	H+v+nYE9nusa7Bfn+XAKacQbLoFLhDcr0sediO5uEy4EA86wXpPBxFaiMJVRwPjUBAN53x
	g2NuFqKwf5MLB5BE0T0r0emF7QvKMqBKpc0oL+HxSiO+OXEnoqp7e6yavuyCGj0NpcSj/O
	d5U2gt/3JkH1l90kStRdKZUzhi3xf09rX2blvRlyw5vbLFpK5BB2PsNyI1cQkniDoR9ZD4
	gM3+fGVSF4/aemsVMKaOekLu1cPhmsdcjE2IFyP979CIVx3qmRvK/v8jp5rrZQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 08 Jul 2024 10:55:31 +0200
Subject: [PATCH] of: replace of_match_node() macro by a function when
 !CONFIG_OF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-of-match-node-v1-1-90aaa7c2d21d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIKpi2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwML3fw03dzEkuQM3bz8lFTdxBRjA0MTg0SDRMtkJaCegqLUtMwKsHn
 RsbW1AGJjFPRfAAAA
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

In the !CONFIG_OF case, replace the of_match_node() macro implementation
by a static function. This ensures drivers calling of_match_node() can
be COMPILE_TESTed.

include/linux/of.h declares of_match_node() like this:

	#ifdef CONFIG_OF
	extern const struct of_device_id *of_match_node(
		const struct of_device_id *matches, const struct device_node *node);
	#else
	#define of_match_node(_matches, _node)	NULL
	#endif

When used inside an expression, those two implementations behave truly
differently. The macro implementation has (at least) two pitfalls:

 - Arguments are removed by the preprocessor meaning they do not appear
   to the compiler. This can give "defined but not used" warnings.

 - The returned value type is (void *)
   versus (const struct of_device_id *).
   It works okay if the value is stored in a variable, thanks to C's
   implicit void pointer casting rules. It causes build errors if used
   like `of_match_data(...)->data`.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 include/linux/of.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..f973ae119504 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -891,7 +891,13 @@ static inline const void *of_device_get_match_data(const struct device *dev)
 }
 
 #define of_match_ptr(_ptr)	NULL
-#define of_match_node(_matches, _node)	NULL
+
+static inline const struct of_device_id *of_match_node(
+	const struct of_device_id *matches, const struct device_node *node)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_OF */
 
 /* Default string compare functions, Allow arch asm/prom.h to override */

---
base-commit: 256abd8e550ce977b728be79a74e1729438b4948
change-id: 20240708-of-match-node-ad30140a0a9c

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>



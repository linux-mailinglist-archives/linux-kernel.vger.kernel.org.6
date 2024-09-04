Return-Path: <linux-kernel+bounces-314917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F396BAF8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492BD1F253C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46851D0174;
	Wed,  4 Sep 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXqCs5yb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9C1CCB43;
	Wed,  4 Sep 2024 11:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450074; cv=none; b=Clz/uI024Kha/CfQkNW3JlVhmPYliV260+iT5W3IYCC9q7h++lUk8T6Vjlnm9Crv/MMM0rjdKlu5cnMdBbOaRWULTCa08Peoegjrrrqyt0aXF4u6jx/iOMbmnRbeBx29EQjZ4CXJW8CjCayVS0UsrIZ2O2h3gMTCGOUcAUUd4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450074; c=relaxed/simple;
	bh=LbFW91VPcN5CCwLrLiHjJBysPMZp8cnj63xvRHHWltc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ps56uH8Osf/WubFin6KT0cfYeskcN5GBdC+S6KPoaNZUnBIS02EPr0/65xRhWbp//HdUlm4MnV5dP/4mHeEDCJ8bPVYR1WjTbBYwi4kreqFL0346Uth+Qzvm+JUapK9mfUmZF9B3RTwe77aRtjV4zqk8Uxad67J8l9LMRq84k0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXqCs5yb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D058C4CEC2;
	Wed,  4 Sep 2024 11:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725450073;
	bh=LbFW91VPcN5CCwLrLiHjJBysPMZp8cnj63xvRHHWltc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rXqCs5ybpYlZBHRwTbH3RbO3VvWuuvS8vB7qIUZGHBrNDfvGIwcpR5AR/sJ+vKATw
	 Hon0z/3iP/E/KAScigYcMesxjCRRAYkLHHsYZnO+VqIK94DBYllCcwodyE3uX2qiiv
	 cenGU/yUVscdISjEO/ihG5kRp/wtA+iDYw3lM4uDlUXuNZzi6AZLxzC79swd18WENP
	 SkQogcoatP3wNvPLjFwR8UnSL4nqjAqbLdXqOW/r0A59wlzhzGgG8j68wH/mHLJt2k
	 4jOYw5Cid0m+MCgQ5ggVnQT6B5bCSmrhk8mPbzutTUKRVVx5iuAjhnEDsI1RyK+aao
	 EG5FiT8rzbIxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B788CD37B4;
	Wed,  4 Sep 2024 11:41:13 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Wed, 04 Sep 2024 14:41:07 +0300
Subject: [PATCH] clk: fixed-rate: add
 devm_clk_hw_register_fixed_rate_parent_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devm_clk_hw_register_fixed_rate_parent_data-v1-1-7f14d6b456e5@maquefel.me>
X-B4-Tracking: v=1; b=H4sIAFJH2GYC/xWNUQqDMBAFryL73UCSBsRepZQlmKcubVPZBFsQ7
 974NwPDezsVqKDQrdtJsUmRT27iLh2NS8wzjKTm5K0PdrDBJGxvHl9PXr6smKVUKE/yQ2KNFbx
 GRa6cYo0m+dC7q3VDA2qLq+Isz7f74zj+9tGLEX0AAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725450072; l=1857;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=J7DnDW2A1MJFcbrAhVPLzVkKMJjwXrfE3ffVHEB0sZk=;
 b=6R2yziTvOZcOMtb4T1iRVn+0YljewW1VpSDEBwPBRoKPOwJuM9m5JVIHPVlr+OiLsyX+vUztfo8P
 Hbn+Gd+YA8FU/lpKFKd0cUCeN3tlYwgkIFo3hFFdju+tLwI8Mo+J
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add devm_clk_hw_register_fixed_rate_parent_data(), devres-managed helper
to register fixed-rate clock with parent_data.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Hello Stephen!

Sending devm version of clk_hw_register_fixed_rate_parent_data(),
as promised in:

https://lore.kernel.org/lkml/79cb209c6c5a14ae4d6a015f714c58d4.sboyd@kernel.org/
---
 include/linux/clk-provider.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4a537260f655..7e43caabb54b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -393,6 +393,20 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 #define devm_clk_hw_register_fixed_rate(dev, name, parent_name, flags, fixed_rate)  \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), (parent_name), NULL, \
 				     NULL, (flags), (fixed_rate), 0, 0, true)
+/**
+ * devm_clk_hw_register_fixed_rate_parent_data - register fixed-rate clock with
+ * the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_data: parent clk data
+ * @flags: framework-specific flags
+ * @fixed_rate: non-adjustable clock rate
+ */
+#define devm_clk_hw_register_fixed_rate_parent_data(dev, name, parent_data, flags, \
+						    fixed_rate)			   \
+	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,		   \
+				     (parent_data), (flags), (fixed_rate), 0,	   \
+				     0, true)
 /**
  * clk_hw_register_fixed_rate_parent_hw - register fixed-rate clock with
  * the clock framework

---
base-commit: 88fac17500f4ea49c7bac136cf1b27e7b9980075
change-id: 20240904-devm_clk_hw_register_fixed_rate_parent_data-d24713019d24

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>




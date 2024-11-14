Return-Path: <linux-kernel+bounces-410006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C99C955D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A401F231D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B81B0F2C;
	Thu, 14 Nov 2024 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo1cRGUN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF618B464;
	Thu, 14 Nov 2024 22:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624567; cv=none; b=AgtuL1xZy1flucbDvo+YRyH8FQ8XMjiJnbJoPDspqh6xpiiBUaxB2j5FWIhmJ/79PgCyTX87x+6K2El3VqU4hzG9HOSSd3ILq4iFFRz+L8P/vSrAGNo7wiyjVOvEmEm+mw4xgjuXwDCW9Zm4tuTmWsdTMK6OUZCq+J39igwGyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624567; c=relaxed/simple;
	bh=lACSCrdzRLG5x1E+njLfHcgssYzowjsw+9YGqqUEk5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JlyYFZNZfFDE4LB2SE5ESVovnN5KApf49rP8ejE6eadN5Ox9OgvoqV/4TUy4RSXJ4NAPLe3X/sHDmt8Nh+ES9++zGB5CIBQsjULIX3qJl16cxDMI7lLRP/Ab3DluM+KUqibfpHS5nGDOskrLzDPZ0+3BkScXZ4Oc1HzYZu+63Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo1cRGUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D9AC4CECD;
	Thu, 14 Nov 2024 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731624565;
	bh=lACSCrdzRLG5x1E+njLfHcgssYzowjsw+9YGqqUEk5I=;
	h=Date:From:To:Cc:Subject:From;
	b=jo1cRGUNxfABfeEOZv9PLK4KjN69C/Kdsq3mfouhwGEWZuVFooQhG7JYRAKWI4txE
	 Yz9jO0fFHl8ey2nqakGiyjnD8ynEsjMrvyBRw3nfGXjhtw8wb0VK2ZzLLHaogEQHUk
	 SGD5WvzhU0xhmTTYl6JJ1yk21eXZ86bkJzw4Hm+Ebecb+XRrdgFkarvxcKq49myWPU
	 nTA1Gu4RyMYBSb4Yn0VeKugjBCD5LUk7adNx+bMsst5C9YYNAa9VO15wCLLSzPCb6d
	 +ARAQxl1WudwwxmejfVwgxRDWh4cDJI94LJ8fVaMw6JfFdJOV6/PAYBg1D/lTbwX37
	 kEGJHmcyZufqQ==
Date: Thu, 14 Nov 2024 16:49:21 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] clk: clk-loongson2: Fix memory corruption bug in struct
 loongson2_clk_provider
Message-ID: <ZzZ-cd_EFXs6qFaH@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some heap space is allocated for the flexible structure `struct
clk_hw_onecell_data` and its flexible-array member `hws` through
the composite structure `struct loongson2_clk_provider` in function
`loongson2_clk_probe()`, as shown below:

289         struct loongson2_clk_provider *clp;
	...
296         for (p = data; p->name; p++)
297                 clks_num++;
298
299         clp = devm_kzalloc(dev, struct_size(clp, clk_data.hws, clks_num),
300                            GFP_KERNEL);

Then some data is written into the flexible array:

350                 clp->clk_data.hws[p->id] = hw;

This corrupts `clk_lock`, which is the spinlock variable immediately
following the `clk_data` member in `struct loongson2_clk_provider`:

struct loongson2_clk_provider {
	void __iomem *base;
	struct device *dev;
	struct clk_hw_onecell_data clk_data;
	spinlock_t clk_lock;	/* protect access to DIV registers */
};

The problem is that the flexible structure is currently placed in the
middle of `struct loongson2_clk_provider` instead of at the end.

Fix this by moving `struct clk_hw_onecell_data clk_data;` to the end of
`struct loongson2_clk_provider`. Also, add a code comment to help
prevent this from happening again in case new members are added to the
structure in the future.

This change also fixes the following -Wflex-array-member-not-at-end
warning:

drivers/clk/clk-loongson2.c:32:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Fixes: 9796ec0bd04b ("clk: clk-loongson2: Refactor driver for adding new platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/clk/clk-loongson2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
index 820bb1e9e3b7..e99ba79feec6 100644
--- a/drivers/clk/clk-loongson2.c
+++ b/drivers/clk/clk-loongson2.c
@@ -29,8 +29,10 @@ enum loongson2_clk_type {
 struct loongson2_clk_provider {
 	void __iomem *base;
 	struct device *dev;
-	struct clk_hw_onecell_data clk_data;
 	spinlock_t clk_lock;	/* protect access to DIV registers */
+
+	/* Must be last --ends in a flexible-array member. */
+	struct clk_hw_onecell_data clk_data;
 };
 
 struct loongson2_clk_data {
-- 
2.43.0



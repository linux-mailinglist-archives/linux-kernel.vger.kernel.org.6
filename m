Return-Path: <linux-kernel+bounces-558488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB66A5E69D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969F77ABB0D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5BE1EF370;
	Wed, 12 Mar 2025 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSdDs8JF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEA1386DA;
	Wed, 12 Mar 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814983; cv=none; b=BGklVYAxcaKAi8FIHa7fKY6oXL+MIM4UtbNWYR/8STNC4ieSHInzDHW2Ce5mvfL73klsABe6r8XYibr+lMqvoN7rYlf5q4UILiutYpSiQZQP402YZjecUhWg7a5/OZdx43NrgFysOt20zsFD2OxmkCS2s/w2eeDopTkJbRk7enQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814983; c=relaxed/simple;
	bh=YVUgEWMy7jxvRHWqdQRsl/OkXD+AzGQgcrlK5jfQxzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAnHeQqG5fdVyw6TY6cDqlKnHa25pyaQcF80Z6ACLSSbuvboD8mP9P9K2Vdvu0SqTaRv0Ejpxrtvf81BLcsBoihzXUkZ4JjB0wP6ux4Iahh1ZutJ+1F5v6JC//tcAUXpgnT7xZKtkvQvSSGIqtjNgWRkjNZl6qEhNZl1BSVZPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSdDs8JF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E54C4CEDD;
	Wed, 12 Mar 2025 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741814983;
	bh=YVUgEWMy7jxvRHWqdQRsl/OkXD+AzGQgcrlK5jfQxzo=;
	h=From:To:Cc:Subject:Date:From;
	b=pSdDs8JFhOw0q0mQtsglPsCCb+dq61YGN3TzbDwbDdxgnukl4QAIHB7qfBoTJQoSE
	 gkwQA1XiSNtuORG95LylVZsAJEHnVU47PyeUmnuVTAPzzjuyOhf7YR9yjHOfvBxI7A
	 MpeLn0ondmLgWkkzglOzvbn2rIds1C1gjy8+XtW7UsczaSZEpppckpjSRwrwAgCHzu
	 BA1vtjPa+xxOltCc4HW5waOK+WL9J7UH9OhRTh7U6rMqnvj0LnAfEPoD801qaanPfd
	 BZPni4RPuP4dH3aSpRomr0YvFZI474o+wLS4jl0JZ00ERwAme+nHANmOftrGOWTx7s
	 QdSXGmuYuBv8g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of/platform: Use typed accessors rather than of_get_property()
Date: Wed, 12 Mar 2025 16:29:36 -0500
Message-ID: <20250312212937.1067088-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the typed of_property_* functions rather than of_get_property()
which leaks pointers to DT data without any control of the lifetime.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c6d8afb284e8..f77cb19973a5 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -334,7 +334,7 @@ static int of_platform_bus_create(struct device_node *bus,
 	int rc = 0;
 
 	/* Make sure it has a compatible property */
-	if (strict && (!of_get_property(bus, "compatible", NULL))) {
+	if (strict && (!of_property_present(bus, "compatible"))) {
 		pr_debug("%s() - skipping %pOF, no compatible prop\n",
 			 __func__, bus);
 		return 0;
@@ -536,8 +536,8 @@ static int __init of_platform_default_populate_init(void)
 		 * ignore errors for the rest.
 		 */
 		for_each_node_by_type(node, "display") {
-			if (!of_get_property(node, "linux,opened", NULL) ||
-			    !of_get_property(node, "linux,boot-display", NULL))
+			if (!of_property_read_bool(node, "linux,opened") ||
+			    !of_property_read_bool(node, "linux,boot-display"))
 				continue;
 			dev = of_platform_device_create(node, "of-display", NULL);
 			of_node_put(node);
@@ -551,7 +551,7 @@ static int __init of_platform_default_populate_init(void)
 			char buf[14];
 			const char *of_display_format = "of-display.%d";
 
-			if (!of_get_property(node, "linux,opened", NULL) || node == boot_display)
+			if (!of_property_read_bool(node, "linux,opened") || node == boot_display)
 				continue;
 			ret = snprintf(buf, sizeof(buf), of_display_format, display_number++);
 			if (ret < sizeof(buf))
-- 
2.47.2



Return-Path: <linux-kernel+bounces-531887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0CFA44644
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644FF164A10
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF519258C;
	Tue, 25 Feb 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIiEEs0G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B32F14A60A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501296; cv=none; b=tMhs65GFhEAtjZQkjOpaBK2MZT8pOhsLuk8Ko7SpYgLunfaMUAv3qGYegBRz+X9+QcbBte/q4DExFehtnYMSEriU3SOoIecNEPB4GfFoFbFBU+iaPyLSVyMQo5bG/Wssnp35+NNyf/YY8UX4YUwpPnA7dA3bqw9bYHne0W2A3yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501296; c=relaxed/simple;
	bh=dw/Bs++PpsNCE3uNfxFPVQNMSdRGskgKYc917Yg+n60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GtXnXpdAvh+1Xmv+ymnJDl62AFEzMLRt3/FXszGusoTZZlDX5jncBsGRZ4d4LeKVBq39Rfm0MIM0Oc5eXtBhl6Tt/A6R9d7EsbFl0ymNGwZLx6YKGItkd0a2HjWNAI8oUkqCBm51+enHaY6pcpidiSwtVp3tp7k9DcPY2TBE8Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIiEEs0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6325C4CEDD;
	Tue, 25 Feb 2025 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501295;
	bh=dw/Bs++PpsNCE3uNfxFPVQNMSdRGskgKYc917Yg+n60=;
	h=From:To:Cc:Subject:Date:From;
	b=CIiEEs0G5yLiA7n/LrsLKO5j0g6nTd+A5c55gS8dOT0BKOLCZufFBPBW51JE6zo9z
	 hY3N41Sx7PDbB5VGZeu2nh5ctBTMOtbF0BtJwiowwn8EAJYnMjpvcyBjIvgrNNCueA
	 DhEuELMgf026vdHexf+z8J2+C44XeoxKzwlFPRZfrF+/HNyqT5Dbgkija/ZgqTWp/y
	 Ib4LD1l3ChTYYFZau0vEtRqBOyF7ET0EPpEeWfcUdc9G42oOtrh/Pu4n3HH4vW8wsj
	 IpJhDlm6tVmsWhmRCxjckGYKFdG2U8OqxGVkSw48YzQaJZncpgq42qmD5s6xU4X3R0
	 UxTgBIL3gQ8YA==
From: Arnd Bergmann <arnd@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mux: adg792a: remove incorrect of_match_ptr annotation
Date: Tue, 25 Feb 2025 17:34:47 +0100
Message-Id: <20250225163452.4168739-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Building with W=1 shows a warning about adg792a_of_match being unused
when CONFIG_OF is disabled:

drivers/mux/adg792a.c:134:34: error: unused variable 'adg792a_of_match' [-Werror,-Wunused-const-variable]

Acked-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mux/adg792a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/adg792a.c b/drivers/mux/adg792a.c
index 4da5aecb9fc6..a5afe29e3cf1 100644
--- a/drivers/mux/adg792a.c
+++ b/drivers/mux/adg792a.c
@@ -141,7 +141,7 @@ MODULE_DEVICE_TABLE(of, adg792a_of_match);
 static struct i2c_driver adg792a_driver = {
 	.driver		= {
 		.name		= "adg792a",
-		.of_match_table = of_match_ptr(adg792a_of_match),
+		.of_match_table = adg792a_of_match,
 	},
 	.probe		= adg792a_probe,
 	.id_table	= adg792a_id,
-- 
2.39.5



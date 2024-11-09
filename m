Return-Path: <linux-kernel+bounces-402787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E079C2C26
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933E31C2115F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545DE155C94;
	Sat,  9 Nov 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="PMvGAxGY"
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335871547E2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151515; cv=none; b=fMIgsyf6GDgX25wbUbTi4kUEpZLBgJdO/oFQ/8Ice4S9v41J/yfvi5z/uqpbyIO2slKYqpSXfcKgboLU1GzxLWNrvKy99glFNy71AR38Eer8CCNleAdgi12bx+wJ4AZIB6WMqwJvdiZMVzzGgTFThpwkSkP04mue89GjARBCFoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151515; c=relaxed/simple;
	bh=jPN+mpqzq1b5A1aO/3kAVASyV7JMROcMIlCQeIcx3zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfDuwbSp8hefxK2bNGnG31/6tuYbwBnE0F53bP2rz7Zqp6WnDwSTCN3wL6tAY01Pgmv4kUS4/Izj9yZExCtjsDdPeXO8542J/PJSAy0+oLtW3h56Io/az9SLPLQZVR4+2b66v4x8hVvpl+f/6FzgGJk2OTvrIT5nHR9Fc7KgJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=PMvGAxGY; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XltNg4fjZz9Qv;
	Sat,  9 Nov 2024 12:09:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731150547;
	bh=wkWRlEMEK7FvlLQ38hvp7KYHuVEdEySAkFn3X5ARLaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMvGAxGYReypCdwqP5VJvaAPsADCXKO3jqa5fjRKajXENhpu2iEkd1VqIeR4MUzmi
	 chBlcAypVRO4kc+3lyPcCWVwzEayehLvew+7dxnvhl4JKEgqlswSNwsEbpWb/1E9zN
	 IA49llM+27y0FQ4aWkE4Vsxo8yLk9Kx3Fh0AKPWg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XltNg0WMyzjtJ;
	Sat,  9 Nov 2024 12:09:07 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v4 2/3] landlock: Refactor network access mask management
Date: Sat,  9 Nov 2024 12:08:55 +0100
Message-ID: <20241109110856.222842-3-mic@digikod.net>
In-Reply-To: <20241109110856.222842-1-mic@digikod.net>
References: <20241109110856.222842-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace get_raw_handled_net_accesses() and get_current_net_domain() with
a call to landlock_match_ruleset().

Cc: Günther Noack <gnoack@google.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241109110856.222842-3-mic@digikod.net
---

Changes since v2:
* Replace get_current_net_domain() with explicit call to
  landlock_match_ruleset().

Changes since v1:
* Rename the all_net mask to any_net.
---
 security/landlock/net.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index c8bcd29bde09..d5dcc4407a19 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -39,27 +39,9 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	return err;
 }
 
-static access_mask_t
-get_raw_handled_net_accesses(const struct landlock_ruleset *const domain)
-{
-	access_mask_t access_dom = 0;
-	size_t layer_level;
-
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
-		access_dom |= landlock_get_net_access_mask(domain, layer_level);
-	return access_dom;
-}
-
-static const struct landlock_ruleset *get_current_net_domain(void)
-{
-	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
-
-	if (!dom || !get_raw_handled_net_accesses(dom))
-		return NULL;
-
-	return dom;
-}
+static const struct access_masks any_net = {
+	.net = ~0,
+};
 
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
@@ -72,7 +54,9 @@ static int current_check_access_socket(struct socket *const sock,
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
-	const struct landlock_ruleset *const dom = get_current_net_domain();
+	const struct landlock_ruleset *const dom =
+		landlock_get_applicable_domain(landlock_get_current_domain(),
+					       any_net);
 
 	if (!dom)
 		return 0;
-- 
2.47.0



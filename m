Return-Path: <linux-kernel+bounces-570266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B96A6AE46
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF87D8A5CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520222A7F0;
	Thu, 20 Mar 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="LIEopfzy"
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83892288D3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497662; cv=none; b=bmc7zCz3ahS7TLSYmOOrMyy8ZyYcAaxHPNbXcLZYQ0TpXPbTIVD/bi+pfxpUEgbBwqjIZ6DLajXeOy5Dh+cQ+NuDDnBTWtTpeSKtBkof1JqWuNbN2uK2n6qoez5Ekkiobx52vJgG1T8xeVC5xywvrdz+hjlS03yEEufbAfwEQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497662; c=relaxed/simple;
	bh=NYVwcMWemQmEiWnZteDQ8lONFuLhqsH7PqUfQbdhS6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeYnjiouoVysVb19eoPXK6v/A/Mz+ldGdauYuuzJt5MlJYHHSEgSSH55JFHxWpsmJ+ZafOcHeaUtfrx2Rs/u6MEhzqJ5HvOUd+6TfuxEH1CjN7y1ZzjrZXObiKwN5G3IToLsdvkTwfk74xLuwfEhsQ4Hr+wvI7W8n8HJVVCu+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=LIEopfzy; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZJZpD2JQZzJY0;
	Thu, 20 Mar 2025 20:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742497652;
	bh=NjVUiJfqjY7Ng++S2c2pq8mJVrk+JLkBmJ/OwlRWipY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LIEopfzyk59e73jJ9wrDH8gcv2ThnXzBVBstki/ekI37EPYVy76p4nomxXnX8HnYF
	 F1beYxi4b1J1kq+IA09/FVn6IHiwOb5po3ntnI8TY5Cu2657ANG3OZ0tOa7mrg+jNt
	 Qo4Ob22Sr3/dofASLPrQxk54dZ5hVkfC4AwVOPyY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZJZpC3LjmzYfX;
	Thu, 20 Mar 2025 20:07:31 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Daniel Burgener <dburgener@linux.microsoft.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Tingmao Wang <m@maowtm.org>,
	Tyler Hicks <code@tyhicks.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v7 05/28] landlock: Prepare to use credential instead of domain for network
Date: Thu, 20 Mar 2025 20:06:54 +0100
Message-ID: <20250320190717.2287696-6-mic@digikod.net>
In-Reply-To: <20250320190717.2287696-1-mic@digikod.net>
References: <20250320190717.2287696-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This cosmetic change that is needed for audit support, specifically to
be able to filter according to cross-execution boundaries.

Optimize current_check_access_socket() to only handle the access
request.

Remove explicit domain->num_layers check which is now part of the
landlock_get_applicable_subject() call.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v4:
- New patch.
---
 security/landlock/net.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/security/landlock/net.c b/security/landlock/net.c
index 104b6c01fe50..6fb3e60bc5ff 100644
--- a/security/landlock/net.c
+++ b/security/landlock/net.c
@@ -39,10 +39,6 @@ int landlock_append_net_rule(struct landlock_ruleset *const ruleset,
 	return err;
 }
 
-static const struct access_masks any_net = {
-	.net = ~0,
-};
-
 static int current_check_access_socket(struct socket *const sock,
 				       struct sockaddr *const address,
 				       const int addrlen,
@@ -54,14 +50,14 @@ static int current_check_access_socket(struct socket *const sock,
 	struct landlock_id id = {
 		.type = LANDLOCK_KEY_NET_PORT,
 	};
-	const struct landlock_ruleset *const dom =
-		landlock_get_applicable_domain(landlock_get_current_domain(),
-					       any_net);
+	const struct access_masks masks = {
+		.net = access_request,
+	};
+	const struct landlock_cred_security *const subject =
+		landlock_get_applicable_subject(current_cred(), masks, NULL);
 
-	if (!dom)
+	if (!subject)
 		return 0;
-	if (WARN_ON_ONCE(dom->num_layers < 1))
-		return -EACCES;
 
 	if (!sk_is_tcp(sock->sk))
 		return 0;
@@ -145,9 +141,10 @@ static int current_check_access_socket(struct socket *const sock,
 	id.key.data = (__force uintptr_t)port;
 	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
 
-	rule = landlock_find_rule(dom, id);
-	access_request = landlock_init_layer_masks(
-		dom, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
+	rule = landlock_find_rule(subject->domain, id);
+	access_request = landlock_init_layer_masks(subject->domain,
+						   access_request, &layer_masks,
+						   LANDLOCK_KEY_NET_PORT);
 	if (landlock_unmask_layers(rule, access_request, &layer_masks,
 				   ARRAY_SIZE(layer_masks)))
 		return 0;
-- 
2.49.0



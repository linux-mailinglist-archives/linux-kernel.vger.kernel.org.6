Return-Path: <linux-kernel+bounces-346092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2D98BF7B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310FD1C23F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C912F1CB30C;
	Tue,  1 Oct 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QJi0lLhu"
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA821C9EC7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791978; cv=none; b=qesDfI50R0r23A/wqT9/8tkZK3peGPcq/DjGJ8qbPCqTt+lfRB5qO+tiDxj+NnJqUn54+eREhX9BZmPplaGAMDZ36X/RRQwuqoooB6RD/JfF+/Sdr6O43D+sf+ELNXt1vHw8aeX/mm1LDbgQYLmqR0lvM6wMaf6nFkQMuDkxI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791978; c=relaxed/simple;
	bh=ueKXlRKbUxKgW/VYitwtQFQ3oZkGIkwxW/mJgtz7r7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2EWMO5GbSBcc8LPnEKeO5O4vCI520b529bKe4kRK4DZXpwdZVpU19sDCE55i2Whk07Fc6cggB5/fmjMSqSKnptxGRyF4F1zbbC0zAlC5DCOLJsiwCshdSZSPlwMZOQW02oUisgJANeaTng6v3oQPn3viekhjU2nYnZbDqWJ4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QJi0lLhu; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XJ0JZ0dnZz4fm;
	Tue,  1 Oct 2024 16:12:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1727791965;
	bh=Dj0MGq2F7eT7dWux7TQJIkSeSK0bidTDsqd/S578HcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJi0lLhu4AnjRR2h9kdlOuBQ6LsMCmMm+0cDxL8LofGgcPPVvrppWmdhskTd6WASl
	 7oygurNxglPypTxibL5oxxydqsRCd9bgfaK+KdXUKs2yPVEfYDEzEWaCP4X47k0Kdr
	 E7HAIh/kTwCA+/mc1wINsc4UxfGavJOsz1TQaLGw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XJ0JY2RsbzYqn;
	Tue,  1 Oct 2024 16:12:45 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 3/3] landlock: Optimize scope enforcement
Date: Tue,  1 Oct 2024 16:12:34 +0200
Message-ID: <20241001141234.397649-4-mic@digikod.net>
In-Reply-To: <20241001141234.397649-1-mic@digikod.net>
References: <20241001141234.397649-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Do not walk through the domain hierarchy when the required scope is not
supported by this domain.  This is the same approach as for filesystem
and network restrictions.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Tahera Fahimi <fahimitahera@gmail.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241001141234.397649-4-mic@digikod.net
---
 security/landlock/task.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 4acbd7c40eee..02e3a0330b21 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -204,12 +204,22 @@ static bool is_abstract_socket(struct sock *const sock)
 	return false;
 }
 
+static const struct landlock_ruleset *get_current_unix_scope_domain(void)
+{
+	const union access_masks unix_scope = {
+		.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
+	};
+
+	return landlock_filter_access_masks(landlock_get_current_domain(),
+					    unix_scope);
+}
+
 static int hook_unix_stream_connect(struct sock *const sock,
 				    struct sock *const other,
 				    struct sock *const newsk)
 {
 	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+		get_current_unix_scope_domain();
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -225,7 +235,7 @@ static int hook_unix_may_send(struct socket *const sock,
 			      struct socket *const other)
 {
 	const struct landlock_ruleset *const dom =
-		landlock_get_current_domain();
+		get_current_unix_scope_domain();
 
 	if (!dom)
 		return 0;
@@ -243,6 +253,10 @@ static int hook_unix_may_send(struct socket *const sock,
 	return 0;
 }
 
+static const union access_masks signal_scope = {
+	.scope = LANDLOCK_SCOPE_SIGNAL,
+};
+
 static int hook_task_kill(struct task_struct *const p,
 			  struct kernel_siginfo *const info, const int sig,
 			  const struct cred *const cred)
@@ -256,6 +270,7 @@ static int hook_task_kill(struct task_struct *const p,
 	} else {
 		dom = landlock_get_current_domain();
 	}
+	dom = landlock_filter_access_masks(dom, signal_scope);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -279,7 +294,8 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
-	dom = landlock_file(fown->file)->fown_domain;
+	dom = landlock_filter_access_masks(
+		landlock_file(fown->file)->fown_domain, signal_scope);
 
 	/* Quick return for unowned socket. */
 	if (!dom)
-- 
2.46.1



Return-Path: <linux-kernel+bounces-364060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FE99CAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F7C1F22ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B71AB6CE;
	Mon, 14 Oct 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DOPmenqH"
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13A1AA7A2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910136; cv=none; b=JsJ4yiONDGLPfbTDLfHqfB7WUd65vzdtVt4y252EtfysNt4bzUsWkfniD0gePtVaZm8L5+kEFe2gSDqPDHYEZNBDWYnCLL2mZiWF9WBLL/TeiDmQVN95/el/HwnI348IYZOB+n8On/k312q9WzEoWd4BTEhNDewhH0u4srydJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910136; c=relaxed/simple;
	bh=rNxJpcFBERK76idcXNshrfrnJJj+cQuOURuyJF0cfJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5q8PTOBMUQ0obEIgSTklrW/BxcFFGn2MG8dB3Aciuu0hcRZ0fvGofhw4cG43Xt4IZpkuX8Epz3plIwnG8x6aBRiF2D94Z0YopyQHWQW42wTapAK0XIzy++Pf9xC5izs25wprKMy2gwIvR32/j+5fQJUniQS9Y/iNmcUaQ1z+lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DOPmenqH; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRxqd2NKkz1vw;
	Mon, 14 Oct 2024 14:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728910125;
	bh=Js8NTxW4n99qeYYGTT5T0Yl1gQ8Ca8EIDdDrVsVOI8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOPmenqH6j5DSb25lUZORcI4hxzFBLkYRaOYQXvxiF1IWS7zkoBAwaz9ekeSUVNuK
	 t853wHJ2Mv/fZOJZ3I11IcqRDxl2pMwiyr3q8t6mxx6WuXBZcI1kQpQM9LMDhtpe7D
	 muOM9k5i/hVg+8jmt9WM3vladCCH4EjEmxTkvjBY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRxqc6FfQzDPH;
	Mon, 14 Oct 2024 14:48:44 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 3/3] landlock: Optimize scope enforcement
Date: Mon, 14 Oct 2024 14:48:35 +0200
Message-ID: <20241014124835.1152246-4-mic@digikod.net>
In-Reply-To: <20241014124835.1152246-1-mic@digikod.net>
References: <20241014124835.1152246-1-mic@digikod.net>
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
Link: https://lore.kernel.org/r/20241014124835.1152246-4-mic@digikod.net
---
 security/landlock/task.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 4acbd7c40eee..9725e0fd36d2 100644
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
+	return landlock_match_ruleset(landlock_get_current_domain(),
+				      unix_scope);
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
+	dom = landlock_match_ruleset(dom, signal_scope);
 
 	/* Quick return for non-landlocked tasks. */
 	if (!dom)
@@ -279,7 +294,8 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 
 	/* Lock already held by send_sigio() and send_sigurg(). */
 	lockdep_assert_held(&fown->lock);
-	dom = landlock_file(fown->file)->fown_domain;
+	dom = landlock_match_ruleset(landlock_file(fown->file)->fown_domain,
+				     signal_scope);
 
 	/* Quick return for unowned socket. */
 	if (!dom)
-- 
2.47.0



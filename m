Return-Path: <linux-kernel+bounces-418321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256ED9D605A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76BB1F23561
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D22143895;
	Fri, 22 Nov 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="14EZBYXs"
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492C5D477;
	Fri, 22 Nov 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286056; cv=none; b=ZhYkkf4uPSPHmW1Zh1q5GW6ssLyKUVtUAFTWmnVj19HJtxfzvSpf2Jlz2cCtfqmHJ1+yphpeE3hoZgpIcYcIq1I8rTeixtUdsp7pCxSaMQVmXmNPWBHNZsqDMhiwjjE2ht0UriGT427RTHfyjLW2IqRr4HAkiUDuz0YwCxMh4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286056; c=relaxed/simple;
	bh=2iJktCeaTluhzGMhzwBTsU05yTdrj/X6rZ9VX/kRBo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPuyl6E1kjbletHPh5FX2oLnntHsXg0qtTVhWhOT2TGwc2yJ9OLTiaexD5RiIhxdxdmGA5bINtAVnDiY8OnCkc1tbx2r59YLr4ESq9DuAd3X+YdEAj3I9zkmuasGFJUI6GwOvhJpBj/jdK+9dIgoItYBltx6Dvgm5B6wghxFbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=14EZBYXs; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyK94fpXzgVL;
	Fri, 22 Nov 2024 15:34:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286045;
	bh=DxTkVg18bqBuopoJy37l1mwDFC0IuH3r81EWdfJlrGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=14EZBYXsghzpHcV4S9I/82WBIuEutrRSJbYqLSze9QEYnwPklS2xKoKvfXcVragVF
	 be+0kf9RAHS+IJGyHlMF1Scd+I8dk97gWys97GznkAmwVStfOGqyLksLtJpdFGrR87
	 ovaonRdKTRPB/SndwK+NJfXY5cyf2qRZXvj4afX4=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyK90L6Kzm5p;
	Fri, 22 Nov 2024 15:34:05 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 02/23] lsm: Add audit_log_lsm_data() helper
Date: Fri, 22 Nov 2024 15:33:32 +0100
Message-ID: <20241122143353.59367-3-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extract code from dump_common_audit_data() into the audit_log_lsm_data()
helper. This helps reuse common LSM audit data while not abusing
AUDIT_AVC records because of the common_lsm_audit() helper.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-3-mic@digikod.net
---

Changes since v1:
- Fix commit message (spotted by Paul).
- Constify dump_common_audit_data()'s and audit_log_lsm_data()'s "a"
  argument.
- Fix build without CONFIG_NET: see previous patch.
---
 include/linux/lsm_audit.h |  8 ++++++++
 security/lsm_audit.c      | 27 ++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index c2b01380262c..b62769a7c5fa 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -130,6 +130,9 @@ void common_lsm_audit(struct common_audit_data *a,
 	void (*pre_audit)(struct audit_buffer *, void *),
 	void (*post_audit)(struct audit_buffer *, void *));
 
+void audit_log_lsm_data(struct audit_buffer *ab,
+			const struct common_audit_data *a);
+
 #else /* CONFIG_AUDIT */
 
 static inline void common_lsm_audit(struct common_audit_data *a,
@@ -138,6 +141,11 @@ static inline void common_lsm_audit(struct common_audit_data *a,
 {
 }
 
+static inline void audit_log_lsm_data(struct audit_buffer *ab,
+			const struct common_audit_data *a)
+{
+}
+
 #endif /* CONFIG_AUDIT */
 
 #endif
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..de29ce8ff708 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -189,16 +189,13 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 }
 
 /**
- * dump_common_audit_data - helper to dump common audit data
+ * audit_log_lsm_data - helper to log common LSM audit data
  * @ab : the audit buffer
  * @a : common audit data
- *
  */
-static void dump_common_audit_data(struct audit_buffer *ab,
-				   struct common_audit_data *a)
+void audit_log_lsm_data(struct audit_buffer *ab,
+			const struct common_audit_data *a)
 {
-	char comm[sizeof(current->comm)];
-
 	/*
 	 * To keep stack sizes in check force programmers to notice if they
 	 * start making this union too large!  See struct lsm_network_audit
@@ -206,9 +203,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	 */
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
-	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
-
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
 		return;
@@ -428,6 +422,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	} /* switch (a->type) */
 }
 
+/**
+ * dump_common_audit_data - helper to dump common audit data
+ * @ab : the audit buffer
+ * @a : common audit data
+ */
+static void dump_common_audit_data(struct audit_buffer *ab,
+				   const struct common_audit_data *a)
+{
+	char comm[sizeof(current->comm)];
+
+	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
+	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
+	audit_log_lsm_data(ab, a);
+}
+
 /**
  * common_lsm_audit - generic LSM auditing function
  * @a:  auxiliary audit data
-- 
2.47.0



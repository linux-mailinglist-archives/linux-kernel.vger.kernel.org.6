Return-Path: <linux-kernel+bounces-548435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D1A544D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD181896532
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90EE1A2C3A;
	Thu,  6 Mar 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="anzQ54Nu"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31FC1C8625
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249582; cv=none; b=H6L3/AcAY4G5L36lOoE7m4BRi7I+woZ6VH26d9SXsZOTRw1B5GWypxajD/Wl7y2iGoq5Lu/yxm1mV76UszFW5DBuCJftuwS/lG8kYyg+NbpXMFbWOGlW96jerYVBQJv+bwkkPZklT0sK40msQQAlzOR0C9BElrq0gIjLisVZKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249582; c=relaxed/simple;
	bh=kNnM/LDS7IvlSvI9XG67HWWqKM6+7AGHvlsO5eGeesc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abrzphcEHsVvdn9IQTINGQKbw7FdcDhYrT313ZwSflUowXgQXuwO4YPEZc+InM837abFNzqEJUD9KeYjYDSD9DbOUbJ3KtY64A0IOEloRqkGoJoklzt4YZHIayL+hDz47SefYSNQ5J7gmTxKwVTGVWaAe4TD6cGq6o0yst9fIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=anzQ54Nu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf52666efdso58625666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 00:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1741249578; x=1741854378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8od9BeiA2C/SBfPOr6lG6qoon4Wn7CeHbKHLdKKy+o=;
        b=anzQ54Nuk4ehIbat7UY/ryTJwxxotc7to53Cjhy/NG3oNrvr76yG9TYuRuluEt1XHY
         oOY8hIvD3xf29QjUV0eMz1Dt7Khy2wHTXFE8FqMCDYk8maes9NQl956qzmzk8HtW/olR
         MUQRIMhprJRqwu0vcaKRUZHQIlmADcGLB7ukrXOpzyUVOL1SxAjphRROHggb/7/yLV+6
         p9nRMHOJfCfKCsSFvCmt1copE6uUcnb9wsI25HlXJV1YyK1F+W9WrgIGaev0As8ako0r
         JtcTArjfUtpVw/mTEzRDOrrWTVWKfWMNfsKBoULgGp+fdWJLRdCmWIzFnE5ECR2QBeQj
         TzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249578; x=1741854378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8od9BeiA2C/SBfPOr6lG6qoon4Wn7CeHbKHLdKKy+o=;
        b=Csw1SHd+Nj0zt7QKcGGp1PQWJwv+HCxbV5PsiRK+UjUhEVhLvHboAqHqJkeUpQNySj
         2y/sc5FIIBNSEgKUfir/TGvtnqwzdd1bva4RMKKGRdbMUsAsx3R8ZRAJDIQy3L9+Q6bO
         ACuysQnJUX0t083UJdUbDvPwnhYXHyPBqsdfgu8ZEqiVl6cGRYl5PC517sjug4GzCwSH
         qCaI8V6753scY2DBDxgkQlOcLwd07lpMwhvcRKx0gfTnpOIeeklYIqNbLKOTFHFE3qjA
         BC3tyDQTfjETlpMzV3VMWpajpZ3a5ZeFSqtIg3s+f2lDxX3TCtTRsxErg0gVe9fZP+45
         +DTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjzewX2JEJXY8d6/NPvO3AKmTIduxyf4U49bGCZIDCoYLW/qvc/x5oFlAJaNY5wGtYXxm3g6+Zy4zxaF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkjYzuANaM71ME+PGznAQlrcl0CPdoddo7WkocryljJx/9U44B
	gOO0kg0uz1PQosNB+5JCh+fkEN2unD6GDOul4q78ILAQPFpdQpMVYvMVLyKrKDZyuO9/4okKsdd
	I
X-Gm-Gg: ASbGncvCUDAy0Qc/Lf460ZnTI5ROK+V0RbK+gbBgZ+UQZaLbBD/xZ3AN9yKYYX1rFNy
	ZP9jiM9/B4CETOcWN4dUZuYDKsndU+/tGPrsVZ0O9ZJZU+rXimTz9UHoTg5BuplxGTxYcEd3DIU
	O178b5C/NtPFLTpiQgrPxLUHjUNJkuEJxLOHcleD5yKSaJ95II1yp5JP/9I+/YdKcxgvAp1vQ9u
	cAepGevpSa6YhIONn2gqg/o8A0SLR3kRBD2Qw4VIa/Cu6FHsLEt+EL9UrtpICZ4tDrIIeYEnpjo
	Z8u4jIfCKNJ2q9GdM4ya6gHk1A8Ptz0nJHcFd0gwxYKnSpZ5pwgu7jDHhOxWUru9A3x/DFggZPr
	JT21tpXwdYY1Br8RdaW/VsDMm16s5YfVl2xq0f7/kQl5o
X-Google-Smtp-Source: AGHT+IHYXORUkmTszW4MsCOViEYZiHv1dUV4xV8dCiAuiiR3cR/ZxT3GdrPqcjEXocor95YlDynp2w==
X-Received: by 2002:a17:906:7315:b0:ac1:dfab:d38e with SMTP id a640c23a62f3a-ac20d8bc960mr630147266b.15.1741249577911;
        Thu, 06 Mar 2025 00:26:17 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f191800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f19:1800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d7dadsm55092266b.172.2025.03.06.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:26:17 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: serge@hallyn.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
Date: Thu,  6 Mar 2025 09:26:15 +0100
Message-ID: <20250306082615.174777-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a program enables `NO_NEW_PRIVS` and sets up
differing real/effective/saved/fs ids, the effective ids are
downgraded during exec because the kernel believes it should "get no
more than they had, and maybe less".

I believe it is safe to keep differing ids even if `NO_NEW_PRIVS` is
set.  The newly executed program doesn't get any more, but there's no
reason to give it less.

This is different from "set[ug]id/setpcap" execution where privileges
may be raised; here, the assumption that it's "set[ug]id" if
effective!=real is too broad.

If we verify that all user/group ids remain as they were, we can
safely allow the new program to keep them.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 security/commoncap.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 58a0c1c3e409..057a7400ef7d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -861,6 +861,26 @@ static inline bool __is_setuid(struct cred *new, const struct cred *old)
 static inline bool __is_setgid(struct cred *new, const struct cred *old)
 { return !gid_eq(new->egid, old->gid); }
 
+/**
+ * Are all user/group ids in both cred instances identical?
+ *
+ * It can be used after __is_setuid() / __is_setgid() to check whether
+ * this is really a set*id operation or whether both processes just
+ * have differing real/effective ids.  It is safe to keep differing
+ * real/effective ids in "unsafe" program execution.
+ */
+static bool has_identical_uids_gids(const struct cred *a, const struct cred *b)
+{
+	return uid_eq(a->uid, b->uid) &&
+		gid_eq(a->gid, b->gid) &&
+		uid_eq(a->suid, b->suid) &&
+		gid_eq(a->sgid, b->sgid) &&
+		uid_eq(a->euid, b->euid) &&
+		gid_eq(a->egid, b->egid) &&
+		uid_eq(a->fsuid, b->fsuid) &&
+		gid_eq(a->fsgid, b->fsgid);
+}
+
 /*
  * 1) Audit candidate if current->cap_effective is set
  *
@@ -940,7 +960,8 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 	 *
 	 * In addition, if NO_NEW_PRIVS, then ensure we get no new privs.
 	 */
-	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
+	is_setid = (__is_setuid(new, old) || __is_setgid(new, old)) &&
+		!has_identical_uids_gids(new, old);
 
 	if ((is_setid || __cap_gained(permitted, new, old)) &&
 	    ((bprm->unsafe & ~LSM_UNSAFE_PTRACE) ||
-- 
2.47.2



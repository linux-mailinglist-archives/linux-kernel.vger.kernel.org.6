Return-Path: <linux-kernel+bounces-319048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A215F96F6F9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D55E286FEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2334A1D1757;
	Fri,  6 Sep 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QSxUFDT6"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AE158205
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633310; cv=none; b=EV5c1MBsLiU19Jha8PSUJK18PvBHXGK7NUPuBuiPTlFZ5IXmLZ9LUHTILurY07pNlkHdJE2myvtxm6QFbG9wbMBmCCNOl8GERyAVp+P+6EwxnFxvl3+jYRyqs2PqQkzsu0t2x0ByPms/O+8H6VmuM00sNCS5UxT6ryQqpaJ1BlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633310; c=relaxed/simple;
	bh=vRdXR+Ob0mnRFvuQCd+W3NEcC2Rb5RFsu+cBKmNqVa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYBYkebol1d7g0xwJNpXPq5MbfhumWvuOTZHtLxB4eCXKxep2zRLcN/H9GTd6E+WHn3Pn7gsEeHqgqIxGWhBCHbtHDVuRMnSHiAnWnDM0aZxkriKUcaB+8a2z6jaYge4wl/w/ib5HhZAEkVI4Vvn1UYOW5FxyFhADsM7uhgiZeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QSxUFDT6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C999D3F339
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725633306;
	bh=vVAyedH9CSkJs+YjMx3elnJrl6De9lkV+SRi3m1K9lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=QSxUFDT6Jq2zQpgNnXSwrSPUUlvlzvzEla2nGru0MHEC6Q/UjhndpVI03A3wXbfW6
	 qRKpZV6zUz+mkuNl4JJAZzoQnyHCp2MY7ssByFVKXcvq6aJupKIqKj8Qcv//V/Fqm5
	 qw0M4QVCOIBoxHnuBi0b7O/ztk6QtyRJQh/FGM242i1Da7APcKuBcgsoRFp3MHlqR/
	 zYRmBIzxUHc2gRVwDKwibxQqLhV1BIrzPezhhjtaC0T0/Q5E8AVZQGDlyFFTIuaqRI
	 d2XwwxNSdG0FHLGHBICPNAHX5SIvukG+4qJ8plWE/m8mnmGpI4UGnlk5rh42Y5G9gk
	 YDqbv9IDYXrGg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a8e19833cso60472866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633306; x=1726238106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVAyedH9CSkJs+YjMx3elnJrl6De9lkV+SRi3m1K9lQ=;
        b=X+8cIUkqn9CptXjfrOHe3O/Yd4Ct1kgHHPyR4tBi087epKiV0xjPOde7oR3Ghs5XgZ
         dfzzc2uGWyOw6JQd+fnwnB5On3aL8GHzk9gJ0bvLisArBMYfP0sqDE73t5/HR7Di/bXV
         P+CGJyXmEXTW6RgMKHcp2hcLBRXsJ4jneDf3AMFRW+gp3hitFFxpdUVXMGYbgse/nUdq
         vyfUZ7eADkoOwIfMwLVpXqDUn74NRjq7jbJNNxjPJJhFOZQ286iJmuZGJKPMSGXFbwNE
         ry8q2sn0O97NIsW13YbIc0uM6mavwF9x7VOGaJG+wFZGrUhlgSKxLMlBRWPAmlaUnaS3
         6PgA==
X-Forwarded-Encrypted: i=1; AJvYcCUhQQm9Jhcf8yuyO4s5CDT0VF/ObCgq+6iiprF/o1Qu1sdjhMAJqNyFPduG+ZfrtVdvjxlHBV63hWDR5eI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1MOWMJxxaOKJiUinqN8b3zf/CgJCVMCPNZfPn9io1BemzDN4
	uYC903NjJg1pkQQGr8R9nPks1dIISrE+Q4/v5GZutw+SNqoerI9S5AJvWbFEeNy5qkmIH+EJ1WJ
	XehAdIr8jXqxLWbl4JOc1zsfOFu7+jKYZe3sj/+H2kaG9XxqXhy+NE98svfVgm6BCIHt3StXQjy
	WZqA==
X-Received: by 2002:a17:907:96a1:b0:a86:a7ef:5c9e with SMTP id a640c23a62f3a-a8a888d048fmr180478866b.59.1725633306349;
        Fri, 06 Sep 2024 07:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaDCxVgARkRpUsjaX0FAJO6glT8Qcp5RWHWQTtwxvVEnZ+tv3NLGsJxlxsKS0polGzAPOuOA==
X-Received: by 2002:a17:907:96a1:b0:a86:a7ef:5c9e with SMTP id a640c23a62f3a-a8a888d048fmr180476966b.59.1725633305874;
        Fri, 06 Sep 2024 07:35:05 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236cee0sm281787466b.101.2024.09.06.07.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:35:05 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Seth Forshee <sforshee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] fs/mnt_idmapping: introduce an invalid_mnt_idmap
Date: Fri,  6 Sep 2024 16:34:52 +0200
Message-Id: <20240906143453.179506-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://lore.kernel.org/linux-fsdevel/20240904-baugrube-erhoben-b3c1c49a2645@brauner/
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/mnt_idmapping.c            | 22 ++++++++++++++++++++--
 include/linux/mnt_idmapping.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index 3c60f1eaca61..cbca6500848e 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -32,6 +32,15 @@ struct mnt_idmap nop_mnt_idmap = {
 };
 EXPORT_SYMBOL_GPL(nop_mnt_idmap);
 
+/*
+ * Carries the invalid idmapping of a full 0-4294967295 {g,u}id range.
+ * This means that all {g,u}ids are mapped to INVALID_VFS{G,U}ID.
+ */
+struct mnt_idmap invalid_mnt_idmap = {
+	.count	= REFCOUNT_INIT(1),
+};
+EXPORT_SYMBOL_GPL(invalid_mnt_idmap);
+
 /**
  * initial_idmapping - check whether this is the initial mapping
  * @ns: idmapping to check
@@ -75,6 +84,8 @@ vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return VFSUIDT_INIT(kuid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_VFSUID;
 	if (initial_idmapping(fs_userns))
 		uid = __kuid_val(kuid);
 	else
@@ -112,6 +123,8 @@ vfsgid_t make_vfsgid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return VFSGIDT_INIT(kgid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_VFSGID;
 	if (initial_idmapping(fs_userns))
 		gid = __kgid_val(kgid);
 	else
@@ -140,6 +153,8 @@ kuid_t from_vfsuid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return AS_KUIDT(vfsuid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_UID;
 	uid = map_id_up(&idmap->uid_map, __vfsuid_val(vfsuid));
 	if (uid == (uid_t)-1)
 		return INVALID_UID;
@@ -167,6 +182,8 @@ kgid_t from_vfsgid(struct mnt_idmap *idmap,
 
 	if (idmap == &nop_mnt_idmap)
 		return AS_KGIDT(vfsgid);
+	if (idmap == &invalid_mnt_idmap)
+		return INVALID_GID;
 	gid = map_id_up(&idmap->gid_map, __vfsgid_val(vfsgid));
 	if (gid == (gid_t)-1)
 		return INVALID_GID;
@@ -296,7 +313,7 @@ struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns)
  */
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap)
 {
-	if (idmap != &nop_mnt_idmap)
+	if (idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap)
 		refcount_inc(&idmap->count);
 
 	return idmap;
@@ -312,7 +329,8 @@ EXPORT_SYMBOL_GPL(mnt_idmap_get);
  */
 void mnt_idmap_put(struct mnt_idmap *idmap)
 {
-	if (idmap != &nop_mnt_idmap && refcount_dec_and_test(&idmap->count))
+	if (idmap != &nop_mnt_idmap && idmap != &invalid_mnt_idmap &&
+	    refcount_dec_and_test(&idmap->count))
 		free_mnt_idmap(idmap);
 }
 EXPORT_SYMBOL_GPL(mnt_idmap_put);
diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index cd4d5c8781f5..b1b219bc3422 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -9,6 +9,7 @@ struct mnt_idmap;
 struct user_namespace;
 
 extern struct mnt_idmap nop_mnt_idmap;
+extern struct mnt_idmap invalid_mnt_idmap;
 extern struct user_namespace init_user_ns;
 
 typedef struct {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-313214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B896A1F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF10C1C242EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D70188A22;
	Tue,  3 Sep 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RZqzDMl3"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6418756E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376613; cv=none; b=VYVjO6XjbhWIhiZY3ORcr92euoDAx8PwwidQA5gbqa2ng72daesIzGsJf1WMl9T0L6DAzUiDxvl8FFObYHO8rDr/D60ZYFyVoc6NhP37YXRZAe2lfODKVMSTWj4VmCqFpK63m9pHgCgONq3/pT3a+UYWUCuOgAYCP65A3R2evvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376613; c=relaxed/simple;
	bh=zbfFmYg52x4bNkZY0iHbZPvACTmlOnxysSOisb9uilw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R0D1Iqq/TZ4AMEzF5AShDjauu91E2XLPZ53/2UJQ0XeNocy7ZGEwpwuARUtrRyx/mTS6K8BMDaeiagowBj9Gh/gTtWlunjq2GMw37B/PV6CoVLP8+O2lXT7kkJ1p49X/kkDctanTPVp4umqJy464aFW/KcIF7b9SUDzITK4962k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RZqzDMl3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 138FF3FC04
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376610;
	bh=x8jszuSuXnXNJxcLdhQ06xMDLcRlHy+xx7dW4v2SH2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=RZqzDMl3/InQyDIqo1HyLcZ3Uu7HdFMNtvGFIdzn50g4rKw3D2ENO4mKGniH03Cm4
	 tIg49bJIe/l6l7KpNuCdKdCfrX+s6q6YE78zo3YXfmIyIh/Q3Ej2s8um1hx603u4VJ
	 LQkLfxsJYj/E2ZGpLoBFRZUJ3eIouGUC1hDkBRniBjefEooqVPBEQZA7KNw6OSxSWL
	 R/72Qg18Wto78Ud50V63ytPbXOhe3ciVa5Omi/QbyjYzczjPhT4Stj77nAbu8l5TV2
	 zzFtN/1wxKOeJ2Q8AUMp9r5unpspJ2W5pgATKDX3YuYOK/Ofop4Bb4UI92YdLLlOQa
	 yx3DOqX0jlXbg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a86975f70a2so382736566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376609; x=1725981409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8jszuSuXnXNJxcLdhQ06xMDLcRlHy+xx7dW4v2SH2g=;
        b=KmPXn7tZfz58+2piLlFHKBn8ZXjWQjiLBeuycJPwAy3SvanNVjZ1d3hhBSms6caq12
         SP083Mb6D1rTYYn6505WnEAOM7/LATlRwrTiFJJSPxiNttTQ+f5p3a86oboKjOM1dIHh
         MtSoxr/9zSsyyY7lQAyIQwe4Xkl51G2ri+1TUt4LvBA0LGx3EbDi0TnskQ4rDmmlmeeF
         vyOZGsIJHl/6kyQ/mgXkWWBfpsPrCDn07cBeRNsBrXhIJ1XY1a2x5VLwu74vuL9kkW7a
         J+21dZwCCdAHNZOlOMSCHAfEUDyQY0sVP622VS6d+em9cXvoKrZ0AqpiQXUqlqK6NhIK
         yeWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+00o2RoYhNy246+hBejZPaJ+VcxBWpCwsrmhoOBFoE7GZhfTxCWxcNlXEcydGvPysKgbUes716gNt6L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55i+qKZVccT9hqIXduIy9W0vtWX33fIcsc+MwZi/TY2oe/Rlc
	Or4KGG1tLnlLTzoGPwcFghC6ikTFzPjJNpqodJXq2ZNijVOdW0Z/8OPqYxU3LCIrqscB5zB3GZb
	OpQidEoAdATaCWGglNjnYBLOY4nIdTm57rusD9gS1d0UXmOAZFWleQxfDbN7LWnQLWsSYF44R5X
	4aVw==
X-Received: by 2002:a17:907:968d:b0:a86:b6ee:8747 with SMTP id a640c23a62f3a-a8a32f9f1f8mr90221166b.43.1725376609540;
        Tue, 03 Sep 2024 08:16:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs9nFNqPMbcV/jWpg4+uWW1GqZ9gh0BQOAKr9B+8QKp53t56++gbos2lE0uI6EBfpBGrbq0Q==
X-Received: by 2002:a17:907:968d:b0:a86:b6ee:8747 with SMTP id a640c23a62f3a-a8a32f9f1f8mr90218266b.43.1725376609062;
        Tue, 03 Sep 2024 08:16:49 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:16:48 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/15] fs/fuse: add basic infrastructure to support idmappings
Date: Tue,  3 Sep 2024 17:16:13 +0200
Message-Id: <20240903151626.264609-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some preparational changes in fuse_get_req/fuse_force_creds
to handle idmappings.

Miklos suggested [1], [2] to change the meaning of in.h.uid/in.h.gid
fields when daemon declares support for idmapped mounts. In a new semantic,
we fill uid/gid values in fuse header with a id-mapped caller uid/gid (for
requests which create new inodes), for all the rest cases we just send -1
to userspace.

No functional changes intended.

Link: https://lore.kernel.org/all/CAJfpegsVY97_5mHSc06mSw79FehFWtoXT=hhTUK_E-Yhr7OAuQ@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/CAJfpegtHQsEUuFq1k4ZbTD3E1h-GsrN3PWyv7X8cg6sfU_W2Yw@mail.gmail.com/ [2]
Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
        - this commit added
---
 fs/fuse/dev.c             | 50 +++++++++++++++++++++++++++++----------
 fs/fuse/inode.c           |  1 +
 include/uapi/linux/fuse.h |  2 ++
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7146038b2fe7..d3f3c3557c04 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -103,7 +103,9 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
 
 static void fuse_put_request(struct fuse_req *req);
 
-static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
+static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
+				     struct fuse_mount *fm,
+				     bool for_background)
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_req *req;
@@ -135,19 +137,37 @@ static struct fuse_req *fuse_get_req(struct fuse_mount *fm, bool for_background)
 		goto out;
 	}
 
-	req->in.h.uid = from_kuid(fc->user_ns, current_fsuid());
-	req->in.h.gid = from_kgid(fc->user_ns, current_fsgid());
 	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
 
 	__set_bit(FR_WAITING, &req->flags);
 	if (for_background)
 		__set_bit(FR_BACKGROUND, &req->flags);
 
-	if (unlikely(req->in.h.uid == ((uid_t)-1) ||
-		     req->in.h.gid == ((gid_t)-1))) {
-		fuse_put_request(req);
-		return ERR_PTR(-EOVERFLOW);
+	if ((fm->sb->s_iflags & SB_I_NOIDMAP) || idmap) {
+		kuid_t idmapped_fsuid;
+		kgid_t idmapped_fsgid;
+
+		/*
+		 * Note, that when
+		 * (fm->sb->s_iflags & SB_I_NOIDMAP) is true, then
+		 * (idmap == &nop_mnt_idmap) is always true and therefore,
+		 * mapped_fsuid(idmap, fc->user_ns) == current_fsuid().
+		 */
+		idmapped_fsuid = idmap ? mapped_fsuid(idmap, fc->user_ns) : current_fsuid();
+		idmapped_fsgid = idmap ? mapped_fsgid(idmap, fc->user_ns) : current_fsgid();
+		req->in.h.uid = from_kuid(fc->user_ns, idmapped_fsuid);
+		req->in.h.gid = from_kgid(fc->user_ns, idmapped_fsgid);
+
+		if (unlikely(req->in.h.uid == ((uid_t)-1) ||
+			     req->in.h.gid == ((gid_t)-1))) {
+			fuse_put_request(req);
+			return ERR_PTR(-EOVERFLOW);
+		}
+	} else {
+		req->in.h.uid = FUSE_INVALID_UIDGID;
+		req->in.h.gid = FUSE_INVALID_UIDGID;
 	}
+
 	return req;
 
  out:
@@ -466,8 +486,14 @@ static void fuse_force_creds(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
 
-	req->in.h.uid = from_kuid_munged(fc->user_ns, current_fsuid());
-	req->in.h.gid = from_kgid_munged(fc->user_ns, current_fsgid());
+	if (req->fm->sb->s_iflags & SB_I_NOIDMAP) {
+		req->in.h.uid = from_kuid_munged(fc->user_ns, current_fsuid());
+		req->in.h.gid = from_kgid_munged(fc->user_ns, current_fsgid());
+	} else {
+		req->in.h.uid = FUSE_INVALID_UIDGID;
+		req->in.h.gid = FUSE_INVALID_UIDGID;
+	}
+
 	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
 }
 
@@ -499,7 +525,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 		__set_bit(FR_FORCE, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
-		req = fuse_get_req(fm, false);
+		req = fuse_get_req(NULL, fm, false);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
 	}
@@ -560,7 +586,7 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 		__set_bit(FR_BACKGROUND, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
-		req = fuse_get_req(fm, true);
+		req = fuse_get_req(NULL, fm, true);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
 	}
@@ -583,7 +609,7 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 	struct fuse_iqueue *fiq = &fm->fc->iq;
 	int err = 0;
 
-	req = fuse_get_req(fm, false);
+	req = fuse_get_req(NULL, fm, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d8ab4e93916f..115538f6f283 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1567,6 +1567,7 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
 	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb->s_iflags |= SB_I_NOIDMAP;
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..2ccf38181df2 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -984,6 +984,8 @@ struct fuse_fallocate_in {
  */
 #define FUSE_UNIQUE_RESEND (1ULL << 63)
 
+#define FUSE_INVALID_UIDGID ((uint32_t)(-1))
+
 struct fuse_in_header {
 	uint32_t	len;
 	uint32_t	opcode;
-- 
2.34.1



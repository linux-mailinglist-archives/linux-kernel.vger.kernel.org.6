Return-Path: <linux-kernel+bounces-437782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 557849E988C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A54282F19
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD39E1ACEB8;
	Mon,  9 Dec 2024 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="c1ViYMv3"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B51798F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753766; cv=none; b=Yug3JKOyaktNMCajw485jMp9mMYTsaxnPl9QSyH9nr2UKFW8Q/PbeVuQDgGJ9n0CRh0hM4+q0X8emCEd/edCOdK2pp7n1xGJKYad4QgXPFdIVT/WwHikIChZRApy32bbTdDe3RnT3hgG3VPnu44cp6qRtOvzLhvNtUl8/qA7PDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753766; c=relaxed/simple;
	bh=VzcSKHy18NLLXf21RkjF1FqrTcUOAH8NoqpvDorSaU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmk/NG1SEaZZqadtlYmdvS5KG+H5qWZJxOXu/QIpcVdg59m1BoowYvB0FI5apPXGTsHReMQlnadvvbg/PKhlLnmf1ftjsPEGDp/1sVmEFBF98XBNpM1byqoRts/XSHID8dHdZ6TMC6Rqc3GIoyLmULtHaN1YZpDVoCJfrOOH0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=c1ViYMv3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a68480164so597630266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733753760; x=1734358560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vdmax77IGEEwisTCnHEna2vDXeBlXeblGP0C74f9/Ic=;
        b=c1ViYMv3fvP5ur1qzbYbScZtFUFG30ZQ5ktJnJEGO2KllSz5i7BHedtMjc2pmSW49a
         wDYurqtorPJyrwwR6XwTewvwIbJsvrtX0UxUkUTYWQwUr9fza/xbRj5mrnX9dIsYogBW
         DitdfMiZDc/i/FEJw/mvmiYtpUfotch1HTK87oPGnA1M6FhbvcgAC4pP3Fb8Bmi8dUCL
         oXGYytwOgaAabGHNylaWuP1yAfPpbG+yaBIx2AY6GLDbmqyGB1N0Xgfek+71WgZcMz4B
         zmubHOvv440S0dr0UoKWTP3BsvxRubQgP486X0fR4gqb9UpeUwRzuUeBs/o32beV6Fko
         +1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753760; x=1734358560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vdmax77IGEEwisTCnHEna2vDXeBlXeblGP0C74f9/Ic=;
        b=ocz3G6Skku/hxHa/7Fv8IxcBFsu7UjUzW1e9e/TRdMpRAauv82iFgtymqDam9S2YMG
         yJds487Bvmxl2Vp686TG5/TBiZYnVUXfvy3lrltTEoR2dTHTh4yQB6M/vi5yN+fiGLZY
         JenlCsE+RVcIAeu+6k7xY8+KJmApSDTeoUVbghkPLt6bmJ8yYNIBnoThcxK5A/MfraX4
         HKHxE32Wgho7ba2kcZ4ddVLyDXWp4tG9mgv8yt3yY4I5rxwSLguitVtLeqAbzC4EROE/
         BLpjpvT1DKIHNnPxKnZl1zqFiTJzeFGreF5WEHurLKuBbY5FBLx7Z+Omwb9kaaAm10cG
         mLvA==
X-Forwarded-Encrypted: i=1; AJvYcCUuQ4038TNrwc6Ojyl2AyUDpaHhxADwb+pSDEQnudg5b11rM3X0RS3NmJv9zXN+qq47+ZxdPrlYVBc8HQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cq6J1MrgMseAObhhPknysc4oDMl7pcSdU97miPVP3rB+c98f
	jKooWowyIRrBPmUd0pDudjsL/sQdx6mHMKFW4XbiAbzMdR0EaVTKJETjgSwhNHm2t8MArM3IYUM
	TMok=
X-Gm-Gg: ASbGncu1nfzGUCVWEoIJoQRxapIy3wxQL8ANaHIPBjM4ZkuxsFZFZVCrt0NAUfcTRrY
	sGbka59BlsJJknQa2g7hQIQD5Hu9AOTZk8uHar6y0usPQV6/5Oks94P0Hm/mxCUtO913HqUYNeE
	5MNeCeV0JGRKeGlAzc6GQGwmbo/gfPjCYWcj9GmqgaP3UQCwOMAvOcWG0ccCZCwrMBA3QAc2159
	Vc//nkZ49KtGYBHXtDMl0MPStCJgGduxzn2QwqoYqCsaYsqlRrndygE/1EXn/xmPBWHKHMw7rWy
	f214/qHOzApttw5PKqAYPpBDUyez4HOepm9TevF3Z/mG7Wz8Cg==
X-Google-Smtp-Source: AGHT+IFLBp2fdCsJQMa/TJPMRoMaNu3fmS9Q17TcQ19MhzzXMeczTB44DwPwQ6to38t0U4YkQwbl1A==
X-Received: by 2002:a17:906:30cb:b0:aa5:3782:53af with SMTP id a640c23a62f3a-aa63a07edfcmr1132170766b.27.1733753759856;
        Mon, 09 Dec 2024 06:15:59 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f2c8700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2c:8700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa689b6e7d8sm147359666b.78.2024.12.09.06.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:15:59 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/cachefiles/daemon: parse the "secctx" immediately
Date: Mon,  9 Dec 2024 15:15:54 +0100
Message-ID: <20241209141554.638708-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of storing an opaque string, call security_secctx_to_secid()
right in the "secctx" command handler and store only the numeric
"secid".  This eliminates an unnecessary string allocation and allows
the daemon to receive errors when writing the "secctx" command instead
of postponing the error to the "bind" command handler.  For example,
if the kernel was built without `CONFIG_SECURITY`, "bind" will return
`EOPNOTSUPP`, but the daemon doesn't know why.  With this patch, the
"secctx" will instead return `EOPNOTSUPP` which is the right context
for this error.

This patch adds a boolean flag `have_secid` because I'm not sure if we
can safely assume that zero is the special secid value for "not set".
This appears to be true for SELinux, Smack and AppArmor, but since
this attribute is not documented, I'm unable to derive a stable
guarantee for that.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/cachefiles/daemon.c   | 14 +++++++-------
 fs/cachefiles/internal.h |  3 ++-
 fs/cachefiles/security.c |  6 +++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 89b11336a836..169e8709e4ad 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/poll.h>
 #include <linux/mount.h>
+#include <linux/security.h> // for security_secctx_to_secid()
 #include <linux/statfs.h>
 #include <linux/ctype.h>
 #include <linux/string.h>
@@ -576,7 +577,7 @@ static int cachefiles_daemon_dir(struct cachefiles_cache *cache, char *args)
  */
 static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 {
-	char *secctx;
+	int err;
 
 	_enter(",%s", args);
 
@@ -585,16 +586,16 @@ static int cachefiles_daemon_secctx(struct cachefiles_cache *cache, char *args)
 		return -EINVAL;
 	}
 
-	if (cache->secctx) {
+	if (cache->have_secid) {
 		pr_err("Second security context specified\n");
 		return -EINVAL;
 	}
 
-	secctx = kstrdup(args, GFP_KERNEL);
-	if (!secctx)
-		return -ENOMEM;
+	err = security_secctx_to_secid(args, strlen(args), &cache->secid);
+	if (err)
+		return err;
 
-	cache->secctx = secctx;
+	cache->have_secid = true;
 	return 0;
 }
 
@@ -820,7 +821,6 @@ static void cachefiles_daemon_unbind(struct cachefiles_cache *cache)
 	put_cred(cache->cache_cred);
 
 	kfree(cache->rootdirname);
-	kfree(cache->secctx);
 	kfree(cache->tag);
 
 	_leave("");
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 7b99bd98de75..38c236e38cef 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -122,7 +122,6 @@ struct cachefiles_cache {
 #define CACHEFILES_STATE_CHANGED	3	/* T if state changed (poll trigger) */
 #define CACHEFILES_ONDEMAND_MODE	4	/* T if in on-demand read mode */
 	char				*rootdirname;	/* name of cache root directory */
-	char				*secctx;	/* LSM security context */
 	char				*tag;		/* cache binding tag */
 	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
@@ -130,6 +129,8 @@ struct cachefiles_cache {
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
 	u32				msg_id_next;
+	u32				secid;		/* LSM security id */
+	bool				have_secid;	/* whether "secid" was set */
 };
 
 static inline bool cachefiles_in_ondemand_mode(struct cachefiles_cache *cache)
diff --git a/fs/cachefiles/security.c b/fs/cachefiles/security.c
index fe777164f1d8..fc6611886b3b 100644
--- a/fs/cachefiles/security.c
+++ b/fs/cachefiles/security.c
@@ -18,7 +18,7 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 	struct cred *new;
 	int ret;
 
-	_enter("{%s}", cache->secctx);
+	_enter("{%u}", cache->have_secid ? cache->secid : 0);
 
 	new = prepare_kernel_cred(current);
 	if (!new) {
@@ -26,8 +26,8 @@ int cachefiles_get_security_ID(struct cachefiles_cache *cache)
 		goto error;
 	}
 
-	if (cache->secctx) {
-		ret = set_security_override_from_ctx(new, cache->secctx);
+	if (cache->have_secid) {
+		ret = set_security_override(new, cache->secid);
 		if (ret < 0) {
 			put_cred(new);
 			pr_err("Security denies permission to nominate security context: error %d\n",
-- 
2.45.2



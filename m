Return-Path: <linux-kernel+bounces-418981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC559D6808
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDECB21B9B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E27183CA9;
	Sat, 23 Nov 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Uk05GTB8"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16B4A0A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732346488; cv=none; b=HI+w28I9TYBLM+TXmDwftuxlqY4BeLDkVNkFUjIMu5gxIGIOlWeTSUPJwVDvlsk49CH+JzBlhlsIdPsgNVvPLA9NoqdLVCeb2Bfauw4xbuMaPwjnM4ccW0nphQgBBA+2hUEdyU3QffFoAm1rli5K8qlVLolxCw5J8iIQrHjUu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732346488; c=relaxed/simple;
	bh=+Uh18BnwWLPB7ox5dDwpLR/2M4WjGNtc7pg5MyVHUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYjrBf/zAqmoqo0Opdy0noBkCALJSeuxufsSKd4Y5e6kEBpzAVKZhqNuWU3+1Tb2PCS7wLDYKhnE8GVci5B2zB7rbmQwxEZsaagi/UDz3Ck0DbDnSQBQsT+MxUHLb2XSB6OKGxbR2JEbzqjfZvpLqDc78j38KnhPbk4SPgi8Rvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Uk05GTB8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cfcf4df87aso3657777a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 23:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732346484; x=1732951284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/YTNmEWfSDtA7h9QFVeEH/ye6CcFDrvL5f8PLeF/T+E=;
        b=Uk05GTB8nUAMRYjwQvNPtk8cpgWtM72DeYgoQl6V+I+VxYK9UJja+pzd3XeKoB0TcJ
         E3KfMXbp0gsMqUZwvs/r54HryN5+awdj5BlQvcNZ4DNtepozyP26+iutPXhuu+kT3lXi
         Y5oqNJPgaVmwjI8icDHZH19aNMlz1G4iB+XPX+NbNtV3OM50Y1LETOYzLNjIkm3QkDSs
         q2yiZliz2N7e3ZEsR5P+j9rDeMAwX1RBS3xEvLvb5ZKP2gxpNE6ESSGaxXurXl1XLPJ1
         y45QHho7KNouBRpvt+59WEv/QW7vVzOPYt4W0Bm6Fo4kYMTGAaZsYHuyUpQsmCD8bYsH
         uJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732346484; x=1732951284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YTNmEWfSDtA7h9QFVeEH/ye6CcFDrvL5f8PLeF/T+E=;
        b=G8UbMvTU3/tVBzBECspdyJBvj82NMRfbGYbN5pqJZ7yrW0rAOojves+D/D3zXnKerL
         fB6eq1I+RyFDhGXUbBvCMa2xRyLKEFkl3lOezCjIprocaFTpW3RpxB4M6Gc5eyCOg7Co
         60KyIXUWxirgchd5K4v09ZZXUjN2ffYGkE8BrYtKr6GFB1k9/Vy9sQewKGuv8CRIIra1
         59GFR3GS3hzNvuKCHSyhy11Tj9GE0+RtCnaKVsl4eWkrTxPxDSetdCWIBUlzuft4mlkX
         yRYl33gukuK63Sr6J3aOa929AdFsxzXXm8B/yvOgZaRWzBZEehmIqEiPEu3jLwI5Ae74
         yx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr1GdMEpnDoTL+5/xZ0Z0yamqnnUPoxBcY4gWgVfb7wzLaasBHasaPR02XFR2ZDsGAQTkyLkSp9GxOsJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwOjvpKa/1WLZ+4CCMcNTwG9Ijl8d+kz+i5B0ENA4jRMDSBRQP
	SNCnIx//0rKI+TeOnRRCZSOBGpFG5FDPIzMsnNr9s11EntRhOyY8DcfwvsVsGaltE7x+UEFN46b
	OwhA=
X-Gm-Gg: ASbGncvCMFmZqMhccwSzu/xBzmCZA98/EJ/oz7VkYcBhP8K7e+FUE+bg1Q8GjJELHlT
	xKwyjQ/hQWu38p3xNsmg+h1veoSWlUNIuiOCAyp4C4c5zU59WZeohYOwFetSei6OHIXSxXZ8WK8
	P3AH6d9s8PAxIVOqfY+x6nZWXnglXyrebY8PVo9pNMJU2zaxh5C9Y7MNxxQUpBWi5YjXhZTVWpf
	xNZeumiWSTQvRl6Ej3nmjvlJoPKcFYlmnllxnpUjeM0P2B6DHbegvKpedJbeNxVPovD9FxXYW/6
	61Coh5RUbVSK1ypO8Vje+N39oIqt9OzpmhIeJBZ64R1eDCkNaw==
X-Google-Smtp-Source: AGHT+IHXLdLmo1tmtjgCD0qXUsxAXVAd8FLm9qOjaiXqI+c53wWX0tVyWhZvrhtWm4ABhSfP9OWgKg==
X-Received: by 2002:a05:6402:5212:b0:5cf:bb9e:cca7 with SMTP id 4fb4d7f45d1cf-5d0207b2521mr4251606a12.28.1732346483822;
        Fri, 22 Nov 2024 23:21:23 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f12b600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:b600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01ffd96e4sm1590029a12.60.2024.11.22.23.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 23:21:23 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/2] fs/ceph/mds_client: pass cred pointer to ceph_mds_auth_match()
Date: Sat, 23 Nov 2024 08:21:20 +0100
Message-ID: <20241123072121.1897163-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This eliminates a redundant get_current_cred() call, because
ceph_mds_check_access() has already obtained this pointer.

As a side effect, this also fixes a reference leak in
ceph_mds_auth_match(): by omitting the get_current_cred() call, no
additional cred reference is taken.

Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 6baec1387f7d..e8a5994de8b6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5615,9 +5615,9 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 
 static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_cap_auth *auth,
+			       const struct cred *cred,
 			       char *tpath)
 {
-	const struct cred *cred = get_current_cred();
 	u32 caller_uid = from_kuid(&init_user_ns, cred->fsuid);
 	u32 caller_gid = from_kgid(&init_user_ns, cred->fsgid);
 	struct ceph_client *cl = mdsc->fsc->client;
@@ -5740,7 +5740,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
 		struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
 
-		err = ceph_mds_auth_match(mdsc, s, tpath);
+		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
 		if (err < 0) {
 			return err;
 		} else if (err > 0) {
-- 
2.45.2



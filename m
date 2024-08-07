Return-Path: <linux-kernel+bounces-277676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0894A4A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A5AB20F78
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66D1CCB36;
	Wed,  7 Aug 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWHm5BYP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248FE1C9DF2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024054; cv=none; b=dC7a2QQaH6VO1SW/JZ1lh9+VOH75Fv6yoTvux/hMSZd8kMD0Bo/orDWJuRuqX74Qth7wIWs2OVItnjnRnoV0eq+WzSYOGAPnVydDB8lnV3fdgM1Fwis58g9+lQaNU2+/muvW3zwG6GpmHTA9kl5Id42mU9uzts2Fz16QNy/o2kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024054; c=relaxed/simple;
	bh=ioksRDqwNLk17P3K0C/NbICBneuR8qlCZWl6hNhU3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlJCRHI7KINmG9BuvJq4VQDM0FugPC0tjFttWnjwk49PYpYxFDNHoL75FnPsE8WW2YPqqEVedntcgB08oaruPcyUuM3wDHdKiDGpYPHHOt4JdlEEQEOm7eMgkkdrrgVeEiKpb+S/pOOZ/bnd6RleT8NCR/MPK8DhKqgXagz0bzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWHm5BYP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428243f928fso15178845e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024050; x=1723628850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62SrWCnNhxclSxuLWcVToN8VEVDl6BzHuN80K65dNUg=;
        b=gWHm5BYPjfOtcVKb5KzMjBNlZbZq5Bfan6w0x+LkKhjf4yUf20CsriLNniSlwrHNB6
         eM5xeFqAr4TbP1V4T+rSCke0D5/hCwgXi9s4tnupad6ym4pyezHnlT1JDuO4FC2VWi9e
         MrpTwt3BhavVIITLckYkvfTXf1GsTjh/nmatsT0eOjPRg4wVD9jtjiTHe3/uMdIiVKa1
         RW6SjDesRuonvWw2g8V57RDvSKZkNdy9I8DDpMU8sZHfM+iY68C6yEyUXvKxvyhKC+NG
         3G3zSUam8zWbSTOO4XYTaWGjbUjIBr22pHEAm3H9LJTfN2YJPcwkZZrGc59VWPuvFpzn
         cYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024050; x=1723628850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62SrWCnNhxclSxuLWcVToN8VEVDl6BzHuN80K65dNUg=;
        b=QcUoOBXiqTCEVCwPPl7exwdDW3q1/h4v0voqvN3yei1bb6GXQfKY1nRGNDnYXiRX5Y
         QAPD1GIEHE8WutMk1AbZP8qYktYEn1+r9/Sn0ERJrETyItk5iTF2Oi0nIlw5r6y0bjwJ
         aSwi7dE2JX/qkeRKl9KyVKGQX/XhYcRXblz/07dqAVT71YC1QFWSPBQD2x6kYOdkdU5t
         TK7bBlKi98JQzqGH31kexoPe6VTPah4+CXw96/v4GX042j0l4rCW3LC/DnD5Kg1wcsdL
         EQz5sIuPvzv1FXcOv3bQxfsx5jO9+1YhlPq2junbnH/inIls1JotcWIt16cL8ZEmti4B
         6s5w==
X-Forwarded-Encrypted: i=1; AJvYcCXyonNu9A43pggcyM+MDGQAuH9mECuGOa0xCkntXeulUxmoJ+Hc0owMmcic3/UTAkjy0L7Vzz2tibFG/NOfvYGHlxXMAa7AVQeV6ob1
X-Gm-Message-State: AOJu0Yweb6i7krTNpI9YrKKXhrZj+xqrdfvTS8rAWIQYiQDoz6Nmpiyo
	FkpCeED+w+cxhO2EqJkcs1Y5HoUZNWetGu+zXZ5hLapVAfGglLeO
X-Google-Smtp-Source: AGHT+IHHiCLygoa5Cy0kG4Ocdj4Rt8Aj3T1Zf7ZwIMSu/V2JXiJj0SzeBsGgeuQCLQrUwtO+HDNpTQ==
X-Received: by 2002:a05:600c:4e87:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-428e6b02594mr161877885e9.10.1723024050150;
        Wed, 07 Aug 2024 02:47:30 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059a3e99sm20860085e9.31.2024.08.07.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:47:29 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH] 9p: Avoid creating multiple slab caches with the same name
Date: Wed,  7 Aug 2024 10:47:25 +0100
Message-ID: <20240807094725.2193423-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the spirit of [1], avoid creating multiple slab caches with the same
name. Instead, add the dev_name into the mix.

[1]: https://lore.kernel.org/all/20240807090746.2146479-1-pedro.falcato@gmail.com/

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 net/9p/client.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5cd94721d97..9e7b9151816 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -979,6 +979,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	int err;
 	struct p9_client *clnt;
 	char *client_id;
+	char *cache_name;
 
 	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
@@ -1035,15 +1036,22 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	if (err)
 		goto close_trans;
 
+	cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
+	if (!cache_name) {
+		err = -ENOMEM;
+		goto close_trans;
+	}
+
 	/* P9_HDRSZ + 4 is the smallest packet header we can have that is
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(cache_name, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
 
+	kfree(cache_name);
 	return clnt;
 
 close_trans:
-- 
2.46.0



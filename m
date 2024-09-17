Return-Path: <linux-kernel+bounces-332011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024997B431
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B258A1F2448C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49969188A32;
	Tue, 17 Sep 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFL8jZOm"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0A52F88
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726599139; cv=none; b=JDWzLPVaB3mFhbDeJOJRQ4giJne5d1faQcC2Piix70z28m1V9tiyuRFUSjbiRPN03+f9PnD6dCuopIlVDq6nE3RsNtXkQ2T+4zqdLEVNl6J6TJ6KnEdbFH2i2Kb5QDIj/4Jl0fLEGCaLaqqzaEozrPKSd8I8PuuKLW/DIjze5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726599139; c=relaxed/simple;
	bh=9rZ0NAjyMN/Cy6XIxzVeo9DgCI/Rlqh8OOlBqAhJOdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAFluLOQ4LTpp8xkcuyU2o1ljqEnn3ERBYZqgLfZ4QIioA7NpqMD7OCpx8XxEYx+j0NeFTcDDikdEQJUN9h8JP72zyQz9YxrbWQYtPDCnEB+kBIJpnZyxi2QiFfe29Xdjk2yPJI58aETI7Hl1Vc/t+E961xMHDTtySTACl8utfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFL8jZOm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso603520b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726599137; x=1727203937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vyLopvVFarVc7b6zqFWSVn6Mj7mgp46/75nlYETkLY=;
        b=dFL8jZOmLU68gsn/sfaZPQ3MLrequOI/ystdz9YC3id1Drgh8Fu1drt9fNRJvsbJse
         +yx9ZvAuZs+/SLvRNkIthiyvjO+deOgRwe+FLFbU3/wz5Inyedok1bs0demduafZKo+Q
         lBhGZPeeH4LScz3MGvTQRxyS1kJRplkp/O1qUpvV2ImcOXsCaewtUZ3731nA6HUCR3pR
         szHC5yPemdrbyZo7W9jJ4pNztKOivpVMMaSqWR3r9oIwdR4eTemO0yb7FNT3hFhmunom
         JddRKufIi/rc+hEPWl/X5/5OQvTzea0D+KX8UxrKOhSPMJ+RQ4yyF43Beq0JmymsAvR3
         OjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726599137; x=1727203937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vyLopvVFarVc7b6zqFWSVn6Mj7mgp46/75nlYETkLY=;
        b=lIUrqPtWalfGLg2FjEnY/DMPrDdwMpb8QtwFc2cBeSXOXQcVyPjBnOjFj54/G4XtJ8
         Z/EtF/LJPJyMSEsoPqJZ1ZH5x8RHzBkrJ/GkAF88wmCunWtyPeg3QJpnv3WvHZzLppv2
         elES/cQnPq5fuC1Z8NssffEelTPDJN3/SsPfJpqvkcsPP2qsQTsPJB50sXUsP4JF6sJ1
         4x1t7fJ3kkvp/hI51pl0bYD7Tf3Xz9SQ5oN5PGKzkIWmN4bH4oQ0rxu1fBt70ihDarSJ
         JVz29bswrNmYsdm0dzgyD1YO1Ko+R8yNsZIN9LCVszI/xkvoZpXM9svZ938OuvmUJ/xs
         sS6w==
X-Forwarded-Encrypted: i=1; AJvYcCUBeGAyI8ZESiWfdnoMCtDRHhKpIbtkAQd6MB6nRhR8V1qG+701E2ggnDjxhJQHTAuycCtb1/+H1N02pVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZszzRJDPL7e7MFbru1rDWGbyL112KZt1D/QYvjuBQgPkcOEcx
	Vu2xRKwDJapQd7dZ0uQ33KDND1HHYq0hVt11ddYSWd43weJjURvx
X-Google-Smtp-Source: AGHT+IFmCN82+5xtavbARoR+V+tU/i2kaMpPTlaO2CRQHv+8DXSG6y6urfrYImfGrdKu9Rjz81UpEA==
X-Received: by 2002:a05:6a00:23d5:b0:719:1f54:73a5 with SMTP id d2e1a72fcca58-71926056052mr28503306b3a.2.1726599137339;
        Tue, 17 Sep 2024 11:52:17 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944adf70fsm5468108b3a.89.2024.09.17.11.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 11:52:16 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH] ocfs2: Fix typo in comment
Date: Tue, 17 Sep 2024 18:51:56 +0000
Message-ID: <20240917185156.10580-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix "Allcate" -> "Allocate"

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 fs/ocfs2/alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index ea9127ba3..395e23920 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -4767,7 +4767,7 @@ int ocfs2_insert_extent(handle_t *handle,
 }
 
 /*
- * Allcate and add clusters into the extent b-tree.
+ * Allocate and add clusters into the extent b-tree.
  * The new clusters(clusters_to_add) will be inserted at logical_offset.
  * The extent b-tree's root is specified by et, and
  * it is not limited to the file storage. Any extent tree can use this
-- 
2.46.0



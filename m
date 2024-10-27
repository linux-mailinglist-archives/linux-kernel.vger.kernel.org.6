Return-Path: <linux-kernel+bounces-383603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1E9B1DD8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963721F2164B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772541547E1;
	Sun, 27 Oct 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv1H/9yj"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CEF2C697;
	Sun, 27 Oct 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730036148; cv=none; b=AuM/8L1oC3YilIzsj4V3YxOyUxPoBnH4vxgjo8Tr4Jutwe09KT8W2WuVoyRtLpOFtDewQkD9XSvqV6BedL7gpvtQ9xZbdzM3on6K5juhwe2MEUnwrjYrx+834Th8Lc+4DyBPhYgaMOR95rI6KVvIbwM183AXQHQM30F8KEe4FKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730036148; c=relaxed/simple;
	bh=0O8eKPQladhE8cLxr/bSaYHnQGuNIfdauWs5HzIC8rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOMOPokxnTGXyeZqo/OaxLq/Wfdp9sbw4n0Hg5UidT2Mx+HJUpD128++LkQTd5gkIojCe+qIoTAIa0AVvEbD96csIg00rddsrbp89SXfcwLg7Z3Lq8zHEw6Xazb0mC2hSqwnQ4dz826KqmDmWdTpAZjnS23RG7HTptyJYA18oPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv1H/9yj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43159c9f617so34349905e9.2;
        Sun, 27 Oct 2024 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730036145; x=1730640945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mK7sVqYoX25AgNKVn0A6qLQfrJlccu+9fSrGoYMncso=;
        b=Wv1H/9yj0Iz81R5tRABdfT3BIi/fpOLzkToQ6IxPsBTM1luxzicSkld/80TVAAuf6t
         XhPAHuja95kKIKnntEXxpsimwB1n2a0BQ8TV4sDn3tCY4iuG4w0DX+hI233jV8xbAzpE
         Z+lYPBFFeuJBCUv1t7b79D8vVGPTS0D3k8WzQ2GrWg6KWq1z3/Tt/N0seeHhDBbmew0V
         Q5hkYP7VoUZUzta/KM22YrL0MPdndM9N04s2Fpm6jPDy+5Lvj215k+O62nHLlXrwNDcj
         jvZgsgWRf/b2oYh1mVIa+85mAdENHyisV0LfV5z4sAuuzyn678V4fSwJ8n1jUbOlacEK
         8kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730036145; x=1730640945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mK7sVqYoX25AgNKVn0A6qLQfrJlccu+9fSrGoYMncso=;
        b=C1ScyW8Rt5xp/1dg91QvmWKaQOGTEY3PnKtdNpE8v7UyLfGvhsVHGIfyTH2HcbiZyl
         n2pQahxR32vUp1Byvhos9JS4quHDEDXFJJaBMEV3UfUmxGWdyHnnSa3wNY8De+Ba1Z6E
         a4GnyuxlDQxY4XB/gUbHV28wFQh+ZstCy9vsKEl7I3WfMAglBlqXsA/r5VuJ627PHYem
         0Wo2a+qhBzx2XBbpXWfbrBjxmJ2hAFmbNyiOUYYgt56r+7H3jqgcpfOTHG2GaUUBWDK6
         zZEC97NymzMt88gsxZF0a5eSfZ8B0bzVF94XJBgHtXzTSeaMQ3IRsG7ziSJ6r2Wt/phD
         nk2w==
X-Forwarded-Encrypted: i=1; AJvYcCVDxgAYLPGy6ah0ySN8q0J/YTHnjMEyBhcSAKSJpB1KnZc5RizeuxBpQsrd/5JjsAnJfAMG7T23Op/I9PFF@vger.kernel.org, AJvYcCWAzMVpp/OUSx7w2y0DZC6B68K4c6qeMMkDV+A3YAHdKMcK0e0p5j+w4KLH0iNZVXTh+16QHi1vbjOt4PKsWt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWiF/dt9osZCrz2VndAWjvvyW1j/d4cqMtOLsJt4b/3js8Ve+
	V67V0kcwYYv28vXUXsdfsCXCB5Sx2lpgfYFC94/7xDPxenoG7gLl
X-Google-Smtp-Source: AGHT+IFvoR5pALM3sVKeUHGr16ao40f833nEkt8YEwQlcfMaEnCIzjNv8RcjHl6d476xPvJAQ3quew==
X-Received: by 2002:a7b:c5cc:0:b0:428:1310:b6b5 with SMTP id 5b1f17b1804b1-431aa802774mr1484315e9.34.1730036145278;
        Sun, 27 Oct 2024 06:35:45 -0700 (PDT)
Received: from void.void ([141.226.10.223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b712d6sm6814218f8f.78.2024.10.27.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 06:35:44 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] ocfs2: cluster: fix a typo
Date: Sun, 27 Oct 2024 15:35:18 +0200
Message-ID: <20241027133540.22090-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.149.g3e3ac46130
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo: panicing -> panicking.

Via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 fs/ocfs2/cluster/quorum.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index 15d0ed9c13e5..8bf17231d7b7 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -60,7 +60,7 @@ static void o2quo_fence_self(void)
 	switch (o2nm_single_cluster->cl_fence_method) {
 	case O2NM_FENCE_PANIC:
 		panic("*** ocfs2 is very sorry to be fencing this system by "
-		      "panicing ***\n");
+		      "panicking ***\n");
 		break;
 	default:
 		WARN_ON(o2nm_single_cluster->cl_fence_method >=
-- 
2.47.0.149.g3e3ac46130



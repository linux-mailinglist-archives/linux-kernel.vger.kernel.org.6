Return-Path: <linux-kernel+bounces-400682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596819C10E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A0628560A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3932194B3;
	Thu,  7 Nov 2024 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3Iu36X/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB17218D74
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014601; cv=none; b=C7o2vQB01p9ffbj0M78NZBoBmAVpGr6qBG+4faDLre6HmsnrPMmijBJd4eD+va1p8xjqtABvQbNB0wQyr+ItYdTvPlPvWWlU5dd6VXw3rtMcgAnwaGtvswtyz665MJBKRp81VHgEozGwj0Wko2+mdGrF2RByXj+cDKlzlvzazQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014601; c=relaxed/simple;
	bh=ps8g7aS9YWdHiljpOSe0iIE7Rn7tIj0JNhfoyBSlYao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0o9Gwz+OOP1pQY67ROKURbgJaZidW69+L49qzmUI8kuxS5ULALYiYbWghCGVOqzC/EO8Di3lvkXIJkylfOrMk8PTN+eqIYWPrpMIkKOzGFJshGhV/zvR8+1A26a9LosLVgQ27huqw9RmoSlv91N29x3cL8IGkh8kWpJDzsvMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3Iu36X/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3314237b86so2533342276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014599; x=1731619399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+st140tRnSi1hqWlJmll4Lhmo3xu0I4VHUB3oVubp4=;
        b=w3Iu36X/yN/uxVBPCA0bVFgUHHngQwmlQbGeDD5IQUWdRRQwbPr9u7EERMWBkTjcrU
         czdE26k7JQmthwf5YdeYXKccOoYarRNkLO+dvgyzye8aJFEUZu8+xH7/o7ujiY7ZYE6o
         +sb4WeqZ8xo0Xjcp24l5F6oh4TdYWJi9xNBtbJG3UCw41HQQAggUbsggMULH08IzqB1p
         /5ISuwFpbzX7lOe2DasET+M8J1FRQIubFA4/rY2I5Cq20LeDJ7OEJreTEng8IOFH9OT9
         dZlhEzOXZ2Wb2Y82FPh7tRoeIlTcWHQRPxI5iTkldRF7HCZj86QEccWnMR27mzlQ55Oz
         Nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014599; x=1731619399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+st140tRnSi1hqWlJmll4Lhmo3xu0I4VHUB3oVubp4=;
        b=Xi8rZyhWC1sUqtnjtVuf2HuajFCxg3U44c898EEp9HXJclqcMKcHXd7HsT+qKwwV1Q
         X5QciRBxizx+hkPh9wCaSShGTFT8SRq8voZLFc/bZS9hIEHDmBoSRHj3czCKckXyHWo5
         GX2QzQbvzZ5Gbigee6RQHUr8x2mHZRyaiRL68jS2SpA1YDRXadgC7/WQ2M7QbXK5p29o
         UxSN7X74Up9+8ZJPbfyWOD1MRlexKd/Eq05r43hz4fdS4ATEqSJs0NaGf87otes8WIpO
         G3PKySN6KZtl2605z1Ky+CR+PHFwUzav8hUgzSsQAEeb7tf0kS/TTZeVuz2AL78fievf
         aapg==
X-Forwarded-Encrypted: i=1; AJvYcCUEdc0VPTv1SwB1b7REX+HSqufYpZOWYyHIhGuflaIESpOlmxubl+uo3ZZlVuXInba7HAwCu7g0MDJMMfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgojiIWcqcYNwLstxHHg3ezd8bz/MdfnUxLfhbX4HlJjkaTlXy
	l9uA2mSF6sJxKdQBxstU8lViKNq+S+jNTHDOnoznOyQjZzB39xsIu0KZG0L43HINqt8SfoWTHif
	sGXvbPksi4kTSkg5XCkR54g==
X-Google-Smtp-Source: AGHT+IFgLUXTW1oofpX7j+3fjQdPt6Z3JBpPD3P1QknlqjCzkBELvb4f5iD7diwTeje1LMy4ccv21eNPv4d6rFfFOw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP
 id 3f1490d57ef6-e337f8ed8bbmr319276.6.1731014599186; Thu, 07 Nov 2024
 13:23:19 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:07 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-4-almasrymina@google.com>
Subject: [PATCH net-next v2 3/5] page_pool: Set `dma_sync` to false for devmem
 memory provider
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"

From: Samiullah Khawaja <skhawaja@google.com>

Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
them generic. Set dma_sync to false for devmem memory provider because
the dma_sync APIs should not be used for dma_buf backed devmem memory
provider.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/devmem.c    | 9 ++++-----
 net/core/page_pool.c | 3 +++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 11b91c12ee11..826d0b00159f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -331,11 +331,10 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	if (!binding)
 		return -EINVAL;
 
-	if (!pool->dma_map)
-		return -EOPNOTSUPP;
-
-	if (pool->dma_sync)
-		return -EOPNOTSUPP;
+	/* dma-buf dma addresses should not be used with
+	 * dma_sync_for_cpu/device. Force disable dma_sync.
+	 */
+	pool->dma_sync = false;
 
 	if (pool->p.order != 0)
 		return -E2BIG;
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 77de79c1933b..528dd4d18eab 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -287,6 +287,9 @@ static int page_pool_init(struct page_pool *pool,
 	}
 
 	if (pool->mp_priv) {
+		if (!pool->dma_map || !pool->dma_sync)
+			return -EOPNOTSUPP;
+
 		err = mp_dmabuf_devmem_init(pool);
 		if (err) {
 			pr_warn("%s() mem-provider init failed %d\n", __func__,
-- 
2.47.0.277.g8800431eea-goog



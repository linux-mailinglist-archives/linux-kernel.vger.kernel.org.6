Return-Path: <linux-kernel+bounces-235083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C433691CFCA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 03:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BACFB216FA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64064186A;
	Sun, 30 Jun 2024 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Te0hS34i"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D372620
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719709999; cv=none; b=aUtoSygN+1uOKHhlAvNCUWf5BZHFIxcF7i46VXgMOs5dgasfkEFw7FPLWzvGRBnjIsi2cGLk0OeYhAAoWhjv6+e+lslOMoQaDwEtefa3X0Ngg2wnN2ThFdBOJT6VtaCjkti968LK5VZU8afOy5DMlbkjSolF4hIh/joHgNTm09g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719709999; c=relaxed/simple;
	bh=ToQq1ZQ9vwJrHHT722V7/Od5moDhjnavZH5B3avO3ag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0KWdZVEk3tpGer++cSWXWoFjH5Gtbdf7SDT3vlY1FTjDvpAteX5QW3sTJqQMkRDRu6VCgIaeWOEVS/+GntVqv4LTf9Rx2QG1JYYnt4Kl5ZSrU3s1fZfpULwKfhx9zyDLPTE3AsUG9O/3Op4GcGHE3ti3HVdmeKiOIzHqiSkMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Te0hS34i; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7eb895539e3so76452039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 18:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719709997; x=1720314797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=anfaGnVv6qGZ9fTEACnymibk2+foMeU2mmNZTdiuU2A=;
        b=Te0hS34iTES+aALa1AfC3oniYcMIF3+L6q8aDR2pHgAHHSUkVgk1T+NMKJ26bU/L5k
         3sokVNQjav7TFGyljzk8gq5OnnBcTdSCzBTXmKs7julj/7YXzMe18TKf4kAgD/j151q9
         xAYD6rMFMPa7BDSgLSxQUIBsCOFe8FkIc7LMaIhyN65NvBaxPoaFrvnNEz3TuYDivrHd
         3sPtc+B+TVGggd4t6Y0bjuGCHZCOcUUEV/7LiM+GuikOlMDcrInibnSpVGDkSMxRvV5b
         23dQe9Uw6WyQoctq8oQNdezSGXfcS+iJhxPgfQHC8b+HeKn+YUtXaOXZgTzPrk2R9VQj
         9KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719709997; x=1720314797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anfaGnVv6qGZ9fTEACnymibk2+foMeU2mmNZTdiuU2A=;
        b=Dn2zHow71lcolHXGS5jy1oSEMHOH99s6T8F+GlB9Dd6IL9Scx9VmTfeBye6hByAJhw
         jhEK2YeLcZQ4XVScz6r8wD6THoYCZh1M/J3I1rJOyL44xkru34SWHUHwdFXMTVx9DEoY
         wLK4GYsaZJnPatKhQzJDj9GFcn6//K1FxK//aIFQFj12w/izwqBExEhxUsQiASkAeU8x
         JhYIt+n56KaJJzlawRDVN9TFFDAndZfEKEX5NwbhO0iz4XyweEKpPEHHRbP/ivZ0khOZ
         yvDUjAucQBlVYF1iRYIlUZXUYyJHw7NbGDnM9G7Yq71yiYS4up34OLDG0spnvNP6uK/l
         TrzA==
X-Gm-Message-State: AOJu0Yx8nurbGyg1ycSOvGJrvQrxOm5j1dJJk3oGIc64KmUh5FEQSRCN
	aEe5M8uRKhO2Yw4GloOV9ScsxIhJU+IpgOXU8+0ndFyvm6wSe1gMVD/YnzAWxg8=
X-Google-Smtp-Source: AGHT+IHodVCD2SttNoFUdFNRsoeedXmXQ8LVwZWP9/sCNl8YtV2Ep81+ImTS/sfhE2hOwRzEMSin9w==
X-Received: by 2002:a05:6602:89c:b0:7eb:7f2e:5b3a with SMTP id ca18e2360f4ac-7f62ee11854mr244113839f.2.1719709997223;
        Sat, 29 Jun 2024 18:13:17 -0700 (PDT)
Received: from debian.vc.shawcable.net. (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b13sm38149625ad.169.2024.06.29.18.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 18:13:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: akpm@linux-foundation.org,
	jack@suse.cz,
	surenb@google.com
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] dma-buf: Remove unnecessary kmalloc() cast
Date: Sun, 30 Jun 2024 03:12:16 +0200
Message-Id: <20240630011215.42525-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Casting the return value of kmalloc() is unnecessary and can be
removed. Remove it and fix the following Coccinelle/coccicheck warning
reported by alloc_cast.cocci:

  WARNING: casting value returned by memory allocation function to (struct dma_fence_chain *) is useless.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 include/linux/dma-fence-chain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-fence-chain.h b/include/linux/dma-fence-chain.h
index ad9e2506c2f4..a9dc82e1b7f3 100644
--- a/include/linux/dma-fence-chain.h
+++ b/include/linux/dma-fence-chain.h
@@ -87,7 +87,7 @@ dma_fence_chain_contained(struct dma_fence *fence)
  * Returns a new struct dma_fence_chain object or NULL on failure.
  */
 #define dma_fence_chain_alloc()	\
-		((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL))
+		kmalloc(sizeof(struct dma_fence_chain), GFP_KERNEL)
 
 /**
  * dma_fence_chain_free
-- 
2.39.2



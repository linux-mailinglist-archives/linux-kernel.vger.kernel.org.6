Return-Path: <linux-kernel+bounces-549999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F1EA559B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0E21899651
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5AC27C857;
	Thu,  6 Mar 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHO22TNf"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160741FC11F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299897; cv=none; b=Z0/jIT9g2P+97LdkARLP7J8iiOpNGWL4jP7xJh6zmV1NWk3mUwnNXKibMAcOsnwEy3WWrWMG1AR/p+IZm6BYJgM81axkF3BIhaZs0b9HYvSA/+AqX6BVj/W8XCGX9mkMFKYgzxe/YsePRhu4dYe1G25pmYLv2Mx8UVVoKbmg/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299897; c=relaxed/simple;
	bh=mbCaNW7ZTOziYBdpdZ5bbzJsB0hfIJrFjvE1gSsm0Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pM4ek4Sle40WmzfVPMOaACtshUpXWqzFcjPYhPVtA6BtgOWmk0uWO5jMEF4dSeKuVtrsxkrA8S0z9kvQ0sve1X5Q7fOqGrc9VgII8WEW5B23RExQlvTHgKN7QenzCzGyECqKV+1XYPrpEWv5nmA4u9EWx3DgBaMCB8pmcxqczB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHO22TNf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6feaa0319d8so8490747b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741299894; x=1741904694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwYSJPsyrD20DkRJnKjiCAODhSwgzKxjJiAbTnSnk30=;
        b=nHO22TNfnLclaQMdnlU3OsF9/TYRZiVxTuQ0v1TKfmyaoVinCVCEiU4g0Zd4bvIC0p
         9dml8/LyXBHlCqkwajQ+zu54Tr0/nDeOM6Xc+afxhO7lmEzCpD5CL4FUeo+TgCSKwhkf
         Eft7XGK35Jv4HuG1LOXNVGwXKz6JOfiHh5wPCJVAKBaxa7uwN6ERNF3Bs4pF2oYTDnEA
         AtZkdMXKHxCWocUOccSbiMewhmh7qHSuVbBRui4ouxa4LnNIRZwH1bC2AZXHqXJGOYIU
         GCtKgxXy2yN6qBlf/46vPuHsIpFofQ7De2VEpyIacLiGHlG1jUPKtjo3m+D4Jujr3K69
         ndUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299894; x=1741904694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwYSJPsyrD20DkRJnKjiCAODhSwgzKxjJiAbTnSnk30=;
        b=KiZM+AE+XvGg7RLrN663usLWA8Yegh8L5uUYzU4qsrsp+NAcmBJFxiRBXsYzuLjLIl
         1D92dyxaxEbX6SLz+c9W6WcrNp+DI9LZmPifKzl1xzS+S3WsJAHekoGhHYFY/JosiTVz
         fxbc01TT4ZqXYwOSnRPnmUdPfL/yDSGhWSrcN0qOyA5YUtcXgTFGeYwin7nGwylqehWU
         bBn8gGUVmB1fZURAmzOVNm6V4fD98/lJs2iyQYYkJsTA41sWXWLDLdKRITQgmQOrbOow
         kU+1NaRkn6ru4RiBcDLGMV1Dd2F1VqxwwHYrYrIG1WtNXj/Djo1JHLwnhGB6BA96pG0F
         FuSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVISTLUcVo2R1MPUzfkYmE8m6mXhNb5oju8gZitreDGxOMofqrO6jFnL7AR/cDzOLvhEmjWOxhBKE3fxH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvcM/Ws+ixkQ1p9+LC9T1O5E/IoPJeae5wo6B5Iuz/D/SjPoIB
	OAIT/+5bAh5R2/YNpoNSNIJ3lPOwgMwrzp+LZfyA8HxkxRc4ciC6ms3xUw==
X-Gm-Gg: ASbGncv7dSGPrPhmvovTfp+onJa8QZNp/sulWTWo6XpdUngvdLTjreNUNrzMGazv2Ya
	+p7ZSFWTcvxnpuVYjprmZMV5DWapsncjuCvI1HjigBqAbxyF2wXAgAnVMIlLhMdnkycwX1p90e6
	DU7klaX03kXXRbi1S7Kfmznd5IktISYE+akyLE6GIfrU4ONJcHAEZwBf4M/j0yVeCn9ApYaK222
	HPGJQu+dPRdNihBwhreGl7pD1AGG4d1vqNiTtsDtt2Z14pegaXpFgpPKj2sC3WBVB4lPCXBV7Vd
	0aJWvX0XGosbRLFj8ajFohRrkH1YXpU/
X-Google-Smtp-Source: AGHT+IFv/8eB92arxR7N1UEnJIDSpj+Nqmy4EyPANzg3uHZJgkct9j+inzCIr3rTZcbHezFPSyaVrQ==
X-Received: by 2002:a05:690c:6813:b0:6f9:af1f:53a4 with SMTP id 00721157ae682-6febf3ae047mr19663667b3.32.1741299893589;
        Thu, 06 Mar 2025 14:24:53 -0800 (PST)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c4674bsm4625687b3.110.2025.03.06.14.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 14:24:53 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] page_io: zswap: do not crash the kernel on decompression failure (fix)
Date: Thu,  6 Mar 2025 14:24:53 -0800
Message-ID: <20250306222453.1269456-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250306205011.784787-1-nphamcs@gmail.com>
References: <20250306205011.784787-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the documentation of zswap_load() - should say load a folio (rather
than a page), and should be explicit that the folio is unlocked and
marked up-to-date in the success case.

Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 799b22c19b5e..c470073c17cc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1629,10 +1629,11 @@ bool zswap_store(struct folio *folio)
 }
 
 /**
- * zswap_load() - load a page from zswap
+ * zswap_load() - load a folio from zswap
  * @folio: folio to load
  *
- * Return: 0 on success, or one of the following error codes:
+ * Return: 0 on success, with the folio unlocked and marked up-to-date, or one
+ * of the following error codes:
  *
  *  -EIO: if the swapped out content was in zswap, but could not be loaded
  *  into the page due to a decompression failure. The folio is unlocked, but
-- 
2.43.5


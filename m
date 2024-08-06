Return-Path: <linux-kernel+bounces-275508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE45D9486A1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D69C1C21C78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F12566;
	Tue,  6 Aug 2024 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2YHE8Tf"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BFF64A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904447; cv=none; b=decuvrOgIhCUG/rCMGPGxYnBEsgPIRNw1ZApfKGQCo5HB8aBDj3dagkTTimgwn/qt9YsHKK3jci4b4/8ihAMV012agqf1dw/3rQEtyuiaOt5adqRHP+TKp2LYfs3t5ueWoG6sbP+95tSFKC4UTD3PemcaTAuQmcRf+Qex1UY+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904447; c=relaxed/simple;
	bh=q5RaGcjCG5dt9T1rbRveMNgC2AxuGIFwM5v5hF4EI/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t908jISrBDEHVMpGpy+af7UFvgNHZrgZzaYTQRSbwUwww03ZWCYj6bEianj0hzx3kRxt/gVMHQ/2m0xFQALCH8jEQb2RoDpEEiCSXbHmHyAh2NYeJXa24rdBLz0MZ+7IsciZMkfz7uc3jySCY0RSSXgmQCRd1vdg8PdjuqQbcgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2YHE8Tf; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65fdfd7b3deso1958977b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722904444; x=1723509244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpYb3iAkX6Pj2noFJG3iswjNut7YmxzmopLWs21kTMk=;
        b=P2YHE8Tfq82zBlBCCHH4DuigrjwbMoVjoRcak9fTQcZGy/csSEdOdV+ApEg8ByA3l7
         gfuw+3OsfxpduV6Ao2csrfvKEM01uByAt8CgjCUPedPnAwNOG7Jj9vlTWMb7LOfZGMAy
         SYlqxrVYZV9fcDS61QSCLZml4irhp8v3xT7m77iTbNuocEYMDcDlBANVVzN/5otLqb2k
         UKvXlT1Aj8Kpq2RDMgJJM8y5ghkg5r+pdmStZFrAZHGv6kvGxNHnryxYEMIuBOHHUNaX
         ShMpzAxv7hUYSvck1j6XVBspouOaiQ6YjtfpOEe1BLQPJtmOpF6Jz8jYGAqSJgSElgp5
         FZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904444; x=1723509244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpYb3iAkX6Pj2noFJG3iswjNut7YmxzmopLWs21kTMk=;
        b=uXyKYvMgBGxqB3BS5HIto9xiALQ63WgIqLKSus63JH3kauQt11GqlVsK/VKUFj4APT
         4egqeT2TdHlSZW/0c58Xobw0axCLqihGb0bzloVk0FJYmsc756YtkwUrG8tUdEona3Gi
         b3zC01NYzzp8HPWOvjudrKfmND7jX8fkToQLBC2fW0qVuacckeHGdp3X2Zov4upCQcNg
         YgjLciArv+8wHncAM0s+4n0v2YVFlCIA6WC39y0ybEFATd0OZ/2ItcOfaXpDEU3ibTs4
         LkH/a9/RcA0UffHfS8wEvLhluwB5yLAy76Yxjlcu+U4IL6bciy4Bts/4L1OXVmvf/P+E
         +NcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTE+TgnuQ/SMh2yv3wA8d/4B84bnN9BT1S3f2tdT4d091Day1/LVRaTt2ai9glj/0u2ATwI9KQ6FlbXeJYK2HhB1SFRC5cD7K+uvuL
X-Gm-Message-State: AOJu0Yzsknfv78LuRq+pUGVz8CPtz6nek9Ki8mIUmgWVrgMWdQlDZ44t
	Vajn+2op743IKlCaJfb3w4ziTiOk46rZbup+NdpkfsFfxqd2wQnH
X-Google-Smtp-Source: AGHT+IG6TSLTNLY/FXIkujsVRLu+PSaG2maHR8Efkp2sn8lYLNWPUzDy0h5AY8vw+6JkgAJEIgCO0A==
X-Received: by 2002:a81:8a83:0:b0:64a:e2ab:be33 with SMTP id 00721157ae682-68960589dcdmr142727947b3.22.1722904444471;
        Mon, 05 Aug 2024 17:34:04 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b409esm13867787b3.129.2024.08.05.17.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 17:34:04 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	flintglass@gmail.com,
	chengming.zhou@linux.dev
Subject: [PATCH v3 1/2] zswap: implement a second chance algorithm for dynamic zswap shrinker (fix)
Date: Mon,  5 Aug 2024 17:34:03 -0700
Message-ID: <20240806003403.3142387-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805232243.2896283-2-nphamcs@gmail.com>
References: <20240805232243.2896283-2-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a small mistake in the referenced bit documentation.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index fb3d9cb88785..44a7234a7b11 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -188,8 +188,8 @@ static struct shrinker *zswap_shrinker;
  *          decompression. For a same value filled page length is 0, and both
  *          pool and lru are invalid and must be ignored.
  * referenced - true if the entry recently entered the zswap pool. Unset by the
- *              dynamic shrinker. The entry is only reclaimed by the dynamic
- *              shrinker if referenced is unset. See comments in the shrinker
+ *              writeback logic. The entry is only reclaimed by the writeback
+ *              logic if referenced is unset. See comments in the shrinker
  *              section for context.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
-- 
2.43.0


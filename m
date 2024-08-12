Return-Path: <linux-kernel+bounces-282961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993594EB4A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C79E1C2142C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BC1170836;
	Mon, 12 Aug 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="p9AlzTWV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8AA16FF26
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459021; cv=none; b=APd3JjaUU8wEEblm9aLeQmtfGjjRjgJdWaUhdfj2McsSY7GmwBIXd24P9rQGan7zYRjZINzzToP+oCmieTAd0IIDaRk2tmWCfsoBC2pJz+X0/Ze4ArKVxiP4uC6cRqT8fhWnAfZgfyWJNBCmAxuso03bMN+jMaRdUChtfMW/fFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459021; c=relaxed/simple;
	bh=8+LIWnQdrWxt7ycwt1k5XvF80HXWWgVGtbMU2iI1TG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E98qa1TRq2f62MHAlxd1NMMHFHmJcbRuE1LeO+3WJqu3hB5vMzFsucHW6PkDp2PuSQADEBHht4Ja/KgblhNqoWrGL9Xht+O+yWlKFn2AGVDkyFJYNy+/X+U5Pz/sEh0tQsHVekTNiQPHjrF4WDyJXbEJEjfXBaruGP70ideHVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=p9AlzTWV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ef95ec938so4134114e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723459018; x=1724063818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NHXPZC38UkK7O5TEx6SvnlkLMGTpM5Jg04F0VTZcmI=;
        b=p9AlzTWV+bcSvn84piwSb0GmqMCIJsSZl99LRvJfjrfZ7l7a9JqrpT2U/Ol/H/2cUo
         z1OUx8iAQopfRHe1J5Lb17mzJjVf9BAxRbaN6kUrKe9wccksq2TOrl0dNvVftvwG5de1
         GUYYdLAQMg/ko6jDTXlq83P1U/wxgiizbkRsIpLLKJ+ekmu8vJqmMizJcDbPtvIlgu/z
         C9gOtikTLNZ//PdMlPFHcI3liL48XcbFngJJCjJFFecNqs3e9qGAP1EqgMnBSJUC3L0+
         6cEW/bX3JCFjSFFJgenkZBvnxlbvmZhckvcPGR9vLlbyiIrstFAM3GSQOX0HN7DOOCzI
         nMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723459018; x=1724063818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NHXPZC38UkK7O5TEx6SvnlkLMGTpM5Jg04F0VTZcmI=;
        b=MBpHb7c17vmT1Av9FypWmkk0pmf8gi+Rwg02AfzZJ0AP0VqBrHQ06kxX6f9tnrU2SV
         ubHjWrEyVXcrZ85TtYnu6fHCy06ULHBpLym75PrQ6lSOGz8fXIHpiOQZ13fPkgbgzoab
         p0jXZmd6dvVX/WSntWahRl1EPCxlaE2WS6TiHi3BLPJ/wnFippp/5ZJjtfTpErq0kX6c
         XNDQxpB1wnvGFeBWYsM3qEE5gBsWvtJ/rKnUo2IaEcwhc45L4gbWW0CKmhFQObVQzjvV
         Ny+H0yUE1iipmElM01rwxAdPltGeynCKzI2F1QzpA2eHq9JNyfHyWZNZBbGTwE+Vw/EF
         daGg==
X-Forwarded-Encrypted: i=1; AJvYcCW9sBJCrnWslwCJNuGB9nuC2bL/vEvLRNBajJG8H4JijQjTeU7yrQlUeA1Bsa/Wv3sqQP2tMxthLaVL9etXSWaEsw88WLu4S9thURmh
X-Gm-Message-State: AOJu0YwIuEmr3RIzAuedYUqOpMmEIeMJQUMxd0dL/iW6P90GMXhfV/bH
	W8O3BFJrylTBnr3OSJheHnNJpSeBWYnHEcZWBfVa36wlRJr2XGbc4l5bpVVEGqLt2Nt3YZZ7GE6
	aldw=
X-Google-Smtp-Source: AGHT+IGhryedRog1uNgUMvSTTd6FzO5BP4X7rYeAgqKS3aPe96HVq3jG2s3kGS4P92rT09XMfGeoLg==
X-Received: by 2002:a05:6512:398c:b0:530:daee:cfb0 with SMTP id 2adb3069b0e04-530ee9ee3a3mr6043926e87.52.1723459018211;
        Mon, 12 Aug 2024 03:36:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cce87sm221661466b.101.2024.08.12.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:36:57 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] btrfs: Annotate structs with __counted_by()
Date: Mon, 12 Aug 2024 12:36:20 +0200
Message-ID: <20240812103619.2720-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/volumes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 37a09ebb34dd..f28fa318036b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -551,7 +551,7 @@ struct btrfs_io_context {
 	 * stripes[data_stripes + 1]:	The Q stripe (only for RAID6).
 	 */
 	u64 full_stripe_logical;
-	struct btrfs_io_stripe stripes[];
+	struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
 };
 
 struct btrfs_device_info {
@@ -591,7 +591,7 @@ struct btrfs_chunk_map {
 	int io_width;
 	int num_stripes;
 	int sub_stripes;
-	struct btrfs_io_stripe stripes[];
+	struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
 };
 
 #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
-- 
2.46.0



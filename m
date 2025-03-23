Return-Path: <linux-kernel+bounces-572952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F42A6D0B6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F23A8BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26119C542;
	Sun, 23 Mar 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjCGv4B2"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4718FDDB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742757013; cv=none; b=P8p4ofpJIQrO3RoNOuQ924Cs0T5N+RbF/csugrx/WALV6e3ZRtpA8NjP8JJQE7ZsMT282NVAv25/L2306yZLeOYilq1GjNzJEaFY3kq5fB+bXDdi9C2LCgp28dV0xc3Xg9LiJyv0ByNFLpZadyUnSpahB/vP/6gHbm7XtKNqi54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742757013; c=relaxed/simple;
	bh=VZWfJWjre+F2fe/fBJysMelpM9YpL1+slJ6piBJ58b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCbSoq9drjI/K08I8pQpkUlCtp17IdJywwlcu6h2PGDFek0v8Zc8/qH5+TrrC8GRG57SZG44Fu2w7/IV9wOs0+K+b5oENe34BsB2Ng3XrybbBqC8PArblQBrD6WXKnQ12ohsEW1h/vKO+XMLeayuaSBSYEj5LS0jRWVTLzwhW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjCGv4B2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so38021421fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742757010; x=1743361810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZCt7UAEUCdasxrI9BZV+hCWZ7b8eMumDP7Ypn6YiH8=;
        b=WjCGv4B29hN35BP+qxDUwFs/rSoZqcG1EMddFrscxBoV3JjqCbCIUp3NNmL7P9JPx9
         J0Sze+MwitRs7CK2x7NHZVF/MlCEm4ImXcJxocBvBcPat1mHoF+It9XKLjAr/P1/gwiV
         sHrvWECsErftX6G8ZhFYLQ1XNDSfUZayFJn+wzvkw1njKT0tHE8DBfo/HnNVftUcU/9F
         wNCv+YP9QmMYfjIjXOJaXUd53xD4/3PZLdKYrCe5P34W6GZcUJJuQFd5+6kTvDjMap7F
         t+ZTMMt3WXY48DcaRDwmQYSIqplKi0Gm0Ss7g9O+bvBuEN37lPXAdTTBPhEG33s4jujG
         WtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742757010; x=1743361810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZCt7UAEUCdasxrI9BZV+hCWZ7b8eMumDP7Ypn6YiH8=;
        b=hCaoPMILdsRkF6aLjKXiFfax+LvF7o2dxyJkMWquo/m3sfmyhVnfMszOSkRiOUomcH
         w4aWLWHmgTYFE8qgXOq3mAkWN/nBFPlDrvFlbpOPKLn4vYQ9Hc8DECdE+GIXPCjPepss
         go2fgWwYdhlKh8aqZr5hWO/AA79AHrxdxzK0a06OLtN3PHoVSdnKq5czqtgkPMujqD0o
         n9ipVFixjaYEEpKoEVI+b2Ea4c24RvNVQOvrhfIS+3LfFomNyydJ8PE9QQWZSonIWksB
         5/j0UPAsn6WhWqSZ33ft43MPMTZpevb/UAwIME+knaYGKeNCKMzVV5AUz7AVImMRWVmq
         KIdg==
X-Gm-Message-State: AOJu0YzD3AXDm4oj96q8JY5XOAAO1O+QAB6cmwSCYkVKwddDHAw9YCvG
	c9f1yru0r0hEJh/CHJaH9VKO3eX+QFsVnKungD9W6ZnbZdZb1HFFBAiG21A3grI=
X-Gm-Gg: ASbGncu57muldbWa/hkqK8UjrCuwlV8ESern0GMLAByf+r8F1MQW2uKalSQPnzXKsSR
	T5CqAqPlWgWhegQ0m83bIQkr2vLAafK9O2b2VlWlALdw5eedpXI5ZpkKpqDl1E2klUEtvZj4jRp
	OAvSJ5gjcDlMSNjOrehLccbdUATJ1VPG84z8wZ/3b+F/4IoiBTRg6GTWiwvXsDJ5Hz1U5T/GZa7
	rNg8NS/TARQyOxddyn0ztH/RseW09EqWUFDAsHAVIk1AUT8I1FYVzvA7gFLkNCOAPyeqQNbunAt
	7W7kIFomVaHScOLYPTvO+FvEpz8xBX+FVMTLuSZ0gvht1hOrEdTNKoBAtX0w1p6KXnJjiH3/B0E
	Y/nwmjVKWDQQCOAhM9uJgt9kU8zqsNXaOSZk2fnL8YFdu/cMg9uKwOstx313xQEG2NQ==
X-Google-Smtp-Source: AGHT+IFrtPwdRIYlXw+E280B/e6OOpooWLF8Qwg1P/Kx+7RSH+C2cLRZUlEfrmq+8+tMXQUOpVpoEg==
X-Received: by 2002:a05:651c:50a:b0:30c:2590:124c with SMTP id 38308e7fff4ca-30d7e222cbbmr40232661fa.11.1742757009080;
        Sun, 23 Mar 2025 12:10:09 -0700 (PDT)
Received: from yocto-build-johan.c.remarkable-codex-builds.internal (122.96.88.34.bc.googleusercontent.com. [34.88.96.122])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe7cbsm10585291fa.55.2025.03.23.12.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 12:10:08 -0700 (PDT)
From: Johan Korsnes <johan.korsnes@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Johan Korsnes <johan.korsnes@gmail.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] arch: xtensa: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX
Date: Sun, 23 Mar 2025 20:10:04 +0100
Message-ID: <20250323191004.112743-1-johan.korsnes@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This option was removed from the Kconfig in commit
8c710f75256b ("net/sched: Retire tcindex classifier") but it was not
removed from the defconfigs.

Fixes: 8c710f75256b ("net/sched: Retire tcindex classifier")
Signed-off-by: Johan Korsnes <johan.korsnes@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/configs/common_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/xtensa/configs/common_defconfig b/arch/xtensa/configs/common_defconfig
index fa9389869154..09e4a1d9d1f3 100644
--- a/arch/xtensa/configs/common_defconfig
+++ b/arch/xtensa/configs/common_defconfig
@@ -32,7 +32,6 @@ CONFIG_NET_SCH_TEQL=m
 CONFIG_NET_SCH_TBF=m
 CONFIG_NET_SCH_GRED=m
 CONFIG_NET_SCH_DSMARK=m
-CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_CLS_U32=m
-- 
2.49.0



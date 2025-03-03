Return-Path: <linux-kernel+bounces-542083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34FAA4C588
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1319A7A437C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863DA2139D1;
	Mon,  3 Mar 2025 15:41:02 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D423F36F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016462; cv=none; b=gMO+Q4gcpmJLCUCKoK0MiNWjCTv7VXVx6tKJ00UMRoP7VNHGm9TLwAQt/K8z2Mhw0bC+jYSJ7OWfDvAnHnFzEYPfu9um25RGeL6oScdda186tPTL0uiLdROtSTjFRECH78LvgnIMWhS3VgiwdKSZECiiypPtrkIn0/1f3+wEL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016462; c=relaxed/simple;
	bh=C1voShr7QZBAZN+zbd70EoBJvqupFDaWLGBECIThba4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fcbam2qugAy3wePsF7JYHuSwhZ8TMr8R4G2ARxnXgb1sUTD3IQjbyGjLDHd4sC3lqA6sWvHe53w7QXsYU78ql0eYboZw7a83psE95Rp2PvkByyk6d/xWPJzIa06PaQdUTR6vSr59WuzJIS3q9Ud5GbqQ9XEF64rO30d3vuH54hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c3b4c4b409so240599685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 07:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016459; x=1741621259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9Q1CGP4dTc4ReWFNLDCwkt5znmDQGNIDebPCmoEtHE=;
        b=dtzD2Zo777+Axl+B7qi+YY54/EamZccDXpiXFetUUo8UNX5HlEhhMYxCNdDNQq9QlD
         Vu+Z0kOE2yuvEVg8KeAW30ZsaJ0dyq9CFFiny3QO0b5hd2ncPx4H9KVv5Scu+/yVf5pk
         kAOL5z3hialCjHAP3YjQBj2Mhr48x9+I8Jxe9vQaMwgYq65mRe7YS8t36i5G45fLiFr7
         GMSqH+05PL2Xb4fcjxY4+9qS8PcCPV8R4pt4ZzhQKg5avyu3OlirYgjraYelCNATpccr
         uuyN3GccsQw6lJrdQdVHxbf9gqfwag6QUltTLgltdJ7Quiv622YGRVmXuq+MBhng5CJB
         th8A==
X-Gm-Message-State: AOJu0Yw2Z5n0ZgrVjQrud1HzMymP7Au+DYt0OXskGMsHfa8VujTE76o4
	5s8eXO9Jr98T+77R/17umkipW3lCu0BLhlx1ai5Aq7qSsP6j0nyRSgJtas3cins=
X-Gm-Gg: ASbGncs79lv9E3PC4WgKNvr+bTBY43H22Hq8BymxzX/xskYSPaE+sh5WLcbI0q/1zeh
	Zj5lS3tutyCJAiHyUbyDzznz8wgzgIGtxclw8cOI5T+8in2vYMLq/mAAHVKH2tSqksMSEgMWAry
	7/YdRDtKGkqYgJBXHbAqef7CJ3BLWZa0T/g4TRKzDfpnQyeAs8Tg34uv1uwmZaKd7yNy0Hi6bKu
	jn1UUZYkCE4U+l2Vf/djLATmyFTJJ6lk0c/LrQud3Q/m+gu12Fmspn2j1ahsarnTsiROsXThBh+
	qDh4j9/PgiGL4FE+kk5FMzdkkr6B730XHaHQkG4R4tDXhPe5BJcpKjg=
X-Google-Smtp-Source: AGHT+IGMYW21aDwHdBh2fatxOmmOzXnLq+QcGm1yyhgrEjUujkrtZp4lmeRrA3XkLXCqUwF33zdaag==
X-Received: by 2002:a05:620a:5641:b0:7c3:9d35:2c91 with SMTP id af79cd13be357-7c39d353655mr1526898185a.5.1741016459115;
        Mon, 03 Mar 2025 07:40:59 -0800 (PST)
Received: from Skuld-Framework.gompa.lan ([32.221.37.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c36fee9d22sm613629685a.21.2025.03.03.07.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:40:58 -0800 (PST)
From: Neal Gompa <neal@gompa.dev>
To: asahi@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>
Subject: [PATCH] MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple support
Date: Mon,  3 Mar 2025 10:40:10 -0500
Message-ID: <20250303154012.1417088-1-neal@gompa.dev>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a member of the Asahi Linux project, I (Neal) have been involved in
reviewing the patches downstream as part of enabling the Fedora Asahi Remix
distribution for years and have recently been reviewing patches for upstream
submission as well.

This formalizes my role as a reviewer for ARM Apple system support patches.

Signed-off-by: Neal Gompa <neal@gompa.dev>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0736dc2ee0..052e6e997817 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2212,6 +2212,7 @@ ARM/APPLE MACHINE SUPPORT
 M:	Sven Peter <sven@svenpeter.dev>
 M:	Janne Grunau <j@jannau.net>
 R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
+R:	Neal Gompa <neal@gompa.dev>
 L:	asahi@lists.linux.dev
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.48.1



Return-Path: <linux-kernel+bounces-310005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1349967300
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875542835C1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 18:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D1214D42C;
	Sat, 31 Aug 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9yy7/LZ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589521F95A;
	Sat, 31 Aug 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725128700; cv=none; b=ExInSdimxMSlciwatySnSotPwWEBOE2bGKA484RJvJ8Sczbtx+7wWUHLnA+NN1/ZQFB3OLCGlgzRR+HcDsLKV0vzEUZhusiTKX4CYuk3C4fbJUabLPqtOs5wGmm/UtcIoj9U07lwJt12SXCVn1Ow7AFU3+2DflaMeXQ91riacWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725128700; c=relaxed/simple;
	bh=SZkGb/suidooOF7CNIyTK3j26VEn6eagFIulsSPcXpU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4Gv6n5PmNOgh7PYpWd5G8Kr/65hw6Cr/hsHBfxjPVPmaYLkX/GlNRY+KJ6SxC1lCqIRqf8iohk92tslH3M9qS6wVWzY6OxnBxsMWA7hdIPuqVYkmN+/EVCqxJrP7w9XAgEnZydY5y5k+6af5qu7caF//G27BfRSMQLKy8/tFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9yy7/LZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d21b0c8422so272344a12.0;
        Sat, 31 Aug 2024 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725128699; x=1725733499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DhX/kaFZeCTg+YwZd6U7tYPU4NZdXw1PzKarghSqxA=;
        b=c9yy7/LZ+oT06jsGyjAcWR7kd8YHIYrnNSRe/vG8wxS6/IgF419oRPog1Q7mO8YJBs
         YtYMYCW+Devk+jpzEDYorOkBA7+simRIqEH9qW7tsvJ1zHZo8OTrVotO3r/sUhS+nBpa
         kQCwA1Pkf7zTt3ETyhZR1A3l+TxzlBVY0kc68HR8OLgXMO8oEDy4DFvysyD1maEoTsy1
         j0P6JvZeCvtX+vQiBOkqhNimxxr4gOvo2/pzBLU9gcyapaoLBESN1en7cxgJDyGfiEv2
         JYpG4MW8i4u7lBHT4xtegNZnaZjVmgZ8Locl7PTFbvhr4Y2+1qO7aQISWu27ndNWx0v1
         YCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725128699; x=1725733499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DhX/kaFZeCTg+YwZd6U7tYPU4NZdXw1PzKarghSqxA=;
        b=afi5Mnsn3AVqaa9Zd501m96jU1DmLodigDl4rwESY5qOSZ1U36D36m7aH5WoDG1B3T
         Ocxv4wCw5SZ/rhqFNOY59RiPy4K2GWMPVOUSlGBqhrIbK93ETM8BuPQDqYiWT+UA8u2n
         69kuqFgisTATSPXO+v+iUVjbvHRzqJIrLSOeoGpneoldP/uqhiUOG4Q4J4BRyvponlNm
         m9pQ43kT9Gy0aOPmqRgG903zuAue0w60EbDFDDlgJVeoniwTwuuI7NiRAsDY/wTjMv/t
         jkCI+LMzhdQcnKCjgMKvBSnfl4IeStZ7othIKUPah2L/JRgymmNkLYrCu9NoYT6UG49s
         LDKg==
X-Forwarded-Encrypted: i=1; AJvYcCVjMEEk3ZforYQRVGXQFXyXbRe1RNqrwByA1LjZCjIgCH6EsKFQPdzFXLf7J0A5xnE5XEMLt4x6KOl4@vger.kernel.org, AJvYcCXSZhZqFF8z7JCw3TcJDn9MXBt+xIvbVy/aiKEQTr67iIyUuUV8LwkAHqr/ljxalWxj0jcGsncT7ygUHYRU@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJjXa0wAvKhLYxvN7+2ECYvw0pSiR/WVowTDRluinqb+dSmw1
	4CVfXdhvOa87jhf44H3fuCekr8ZcqGXmcQwKZhPlW4U7xBPj1gkq
X-Google-Smtp-Source: AGHT+IG5caGJp3kbJu0q1H7IeKVEyQQ0/VkfM/U6HyNtpT+EQPNfyxzSIWN5x86SGzgyTJfYp1ncfA==
X-Received: by 2002:a17:90b:3a50:b0:2c8:e8ed:8a33 with SMTP id 98e67ed59e1d1-2d86b8819demr3430149a91.4.1725128698323;
        Sat, 31 Aug 2024 11:24:58 -0700 (PDT)
Received: from localhost.localdomain ([221.220.134.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8b2725332sm553855a91.34.2024.08.31.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 11:24:57 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/1] media: rockchip: rga: Add rk3588 support
Date: Sun,  1 Sep 2024 02:24:23 +0800
Message-Id: <20240831182424.758816-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables support for rga2 in the RK3588 base devicetree.
Dt-binding of rockchip,rk3588-rga is already merged to v6.11.

Changes in v3:
- Rebase commit to next-20240830

Changes in v2:
- Sort node by bus-address based on next-20240604

Jianfeng Liu (1):
  arm64: dts: rockchip: Add RGA2 support to rk3588

 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.34.1



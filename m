Return-Path: <linux-kernel+bounces-550949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C5A56651
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F591896523
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935B217664;
	Fri,  7 Mar 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSEkiGvZ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5103216E20;
	Fri,  7 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345731; cv=none; b=oLN+gfMPWiHC4REnAeJrb4GhNJdfCaIShU3dE2DOYPGjgYygAX5C5CGdxTUNiPvqaBOoqGvHvxqBHLjx72LVdHVWRaTkMxl5vIfAmNL2WMyL1IpgcArmFMoScNCFoDgAn8iDGCZGHAOWAp80Z5te6r/Tq5dpXfpyMUL9wgfgVSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345731; c=relaxed/simple;
	bh=EXM0h+nNXEzWwA+37YY+ZOrUkAfwYMWN8MLzC5oEIWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH425JQx230mGH1IXkzIPjaqA7UBtZPGtzbN5NNq+oMmChKFrDdxbSG4JcS2CXTeDDsMNILrKmMLYwVsidtoiA4sGFlWZYo9NNVumKsZO6wf9NnzbCP3qvpORy3jPFiiL/Gy3kF1q33iLfr0FUGAeWsh2VZsM9JaMFLxoRdHhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSEkiGvZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5495078cd59so1968828e87.1;
        Fri, 07 Mar 2025 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345728; x=1741950528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLJkp6MLOD1BiDeGrlidAjVqoKEfJEO/erWzBeDn7QE=;
        b=kSEkiGvZP9KF4tYX3b41caa3EJin+bxlzR8s6UiHLY/e/94cKrOHqHvZVu1t/veP4Q
         j7umQo0z/zQ+UMWxdZd7D1HNVByn1kkYy+ZwE0cCiulJzjLb5l0RNNAJBAD8qq4RGpVJ
         STLko6aIrPVCzApEYMd/7jIwd2ps13juJII7IiTsa1WfllQrHDDngtYEi/0tqvQmPv4y
         I1UMJbeJSoDbOsS47275WepqQbHp1D4uWWh+jcDXKTOOZjbg6ZgLQHW6w+EAN7wMNYF/
         ps1BjSNKK5QusdqI8JnB4L/1+tn1TgO7C3mewvnH1w98cjSBLxbqg0iG9zhRulZxwL0a
         3Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345728; x=1741950528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLJkp6MLOD1BiDeGrlidAjVqoKEfJEO/erWzBeDn7QE=;
        b=fWzZoQUw13caAAuAZzEOJtw8p4CImFqO1aMWEMugYEJSoHI7zYAd6+FJlX+xiu/l44
         wLHylvIBzzeU34pJa8BB1T9xUAU92EIA4s5SzKSAYbsXvBbVMDWgCt5FDSpBiRZu1Sht
         zjGP2thyDf3kPjcDBKyvayrq+1/KlSJ0G/w36jT/v+R1w+mdH4GGZo9XX280WsP9PBuV
         kHsO+9Ds00Da7SUuW1TLALeyyR4DL7xgybQxDnVY+/G20SF2uOPMWOIQiD/CNN7as4Cp
         GXvnrl7zpu4yCixEMnMaL7zaW82P/VoVegtG8L4us/K5IJxkeujdf+P1zhCVpD0xeSdr
         yhPw==
X-Forwarded-Encrypted: i=1; AJvYcCWTU0xk/umODhJEWPCgdyTNVxN0HZ8KDmLn9Fez6pihWgYlCB532LQ0BzuOd8KpQ82lx+XclsYeFw4AzzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXzbe93s6gsHx4E4JtZNzWLDaEYZPhDdrFs/Z72CIxefI4cBW
	m07lYEhoqXnqFNYJIyPHAfJKXKm2LxTJ+ogXKWuGNu/WWJpHUOJTs4Wbsg==
X-Gm-Gg: ASbGnct55uaQEw7v/xEvsBImhooVG/sElIuuEM8vusKE4WesG1c6AFAc9v6PREswA1T
	Zf3uz8sxuedqZNRlTPd2AOLmcT782YTwf91DPR/SOu68BAme5HJ2hMkLIvosVfXp6WfbtVumaTD
	SvHGZvar3pEiQ3i1+4m/VRmoVVpDWtUYRQMOSjK/nDQuDVHG0eFVxvU+N1xE2lRPqe5B3ztpFcc
	QJo/9m1c/Da/wWT1cmOcPhqhuCZQpuVWsN5qG9mvXGbdioPfX+CP/uXDYeIqbmAMqxkDmA/cPA2
	nuvEdacxkhaK2STGESRQaL83KzN+Tziu2wEPwizewSBcs1BNhIEZP7BuY+tmw4GTAcf60OCgbwc
	Tb+m3+g5xETwrKalxBtt8xw==
X-Google-Smtp-Source: AGHT+IGiGpe6CSJJtkufhdPB5iGLtwq4UxbrTZKaH5A1Wg2RvJPmdaO+/Wjn/2beT+7PpJmdLcSDmg==
X-Received: by 2002:a05:6512:3dab:b0:549:8d2a:880d with SMTP id 2adb3069b0e04-54990e5005fmr900677e87.21.1741345727697;
        Fri, 07 Mar 2025 03:08:47 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:46 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v13 6/7] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Fri,  7 Mar 2025 13:06:23 +0200
Message-ID: <20250307110821.1703422-7-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the Rust dma mapping helpers abstractions.

Nacked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12f2d79ce174..72daf5db0242 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6902,6 +6902,18 @@ F:	include/linux/dma-mapping.h
 F:	include/linux/swiotlb.h
 F:	kernel/dma/
 
+DMA MAPPING HELPERS DEVICE DRIVER API [RUST]
+M:	Abdiel Janulgue <abdiel.janulgue@gmail.com>
+M:	Danilo Krummrich <dakr@kernel.org>
+R:	Daniel Almeida <daniel.almeida@collabora.com>
+R:	Robin Murphy <robin.murphy@arm.com>
+R:	Andreas Hindborg <a.hindborg@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	rust/kernel/dma.rs
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-- 
2.43.0



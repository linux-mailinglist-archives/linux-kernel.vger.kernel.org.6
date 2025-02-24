Return-Path: <linux-kernel+bounces-528947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E8A41E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530D21890E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C51261398;
	Mon, 24 Feb 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF17Noq1"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BBD26137A;
	Mon, 24 Feb 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397843; cv=none; b=kHdB5eVOyQcJDdUfHcxo397dOI2hJiK+TODTzPCNbXOnijQZfvBHUQp3S1qOums7DjU3ObNITXopKcgliuP/kfBnCtXKTYAQIAb9Hd7FvdVOO1qZybFdTMM2xhVJzu/ATlJP4X6FtrRIoDCqd+VZ+6omb0IA6qHCqPmw+rFYMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397843; c=relaxed/simple;
	bh=exnmk4QoMfx9qtW7vQx3ctX13oqT61LfRTvCDXadsEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz6rzPjxcW7n78JLcTszCnQ9lDPMrXQTaTzaCpnQPzyCkQWN/kQBNx0Ny7I231tkS8PnwqKhTT/x/V/jlVDF2V8oxikXr04B5Ofa8n86BCMkP1LG6t1unGA3IDGpaoG+ChMeqNIEOuf6UQMpAcp8fa6rFm81goIIcHOVbB34NX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF17Noq1; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30a303a656aso44017691fa.0;
        Mon, 24 Feb 2025 03:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397840; x=1741002640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSEFC3Z4MM80reKv528I94a4MnIklfvmUttoKk+o084=;
        b=fF17Noq1Z4OuG7BxaVxmr0mV2yRyFyOI1k7YA135vQ9R9RCjQMLNddhVZyOAoYkAhc
         Cx+PRPWwKCh1YktImpyOluBW6m57O0D6xKljp9ub8vfhYOrAZtxFPclEL2psutZhZPup
         b7lpCQk5lQ3VM85tmqkEjwxAaooOws7tazzebXsNkhj7FAY0zG80dZDf9D9RHshqZcf8
         3xf7mIjN6TZfK3iIatfkWCBP34m1m0VSiXMrpn9RZfmTyzPfl9HzSLPLgVuioasAiMBe
         128LJHr1WXxv/gacwZ005DsuOMb1WEzCSg4VK1lkq1X1JOPtkDej88tTtDFcZqGmR0jJ
         oiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397840; x=1741002640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSEFC3Z4MM80reKv528I94a4MnIklfvmUttoKk+o084=;
        b=LOEk+/IYk8JlZx7tbYLl9P6iXYoZYIau5T2TwudEWxLhiFwY5ugF/nbLdFl1uEsoBn
         DEefr2hEA2zLLBW8gq5X2qxv8cHVW3g0EErLnHUZH+ueCuQIofA1yxqz4Nhu0pSXfJCY
         BSUn9oRjlgBM4cg392ufEMTJrwd/T9MbSUYsIPqCHjaOa9VNMxs3gKaAXrdxC064PAXM
         +FyNA1UgWN/hpK9NMGVjPSOiogEaPBHTCxxGIqfxZU8vLU1BacGPvEGHS7A1tfQrXDeU
         s1gFsPfajJsaqL1qtwuUNTbZ2PDn/lL0B3zwWwGK15/qy1VDn/rsGUrE2xW+dKdXmld3
         69hg==
X-Forwarded-Encrypted: i=1; AJvYcCVkKuSTfjmdhCASMhzJ0F1AY5NsEXRMDbc+jJppphkSXfc+fRNZYlKkx9/eXW7BEqf1pexSSKIjkCpqH0s=@vger.kernel.org, AJvYcCWwNarjGsfkIbzRfV5W9/Oq8+70uCBzaiMCByUIAATVCFaBtYGwsyTHKX+YjFgaAHEnHC5YC1SItNh/etqlwgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+l67QqAcrD5nOLrwo5PD+Gic8OUPCqVgQ8cKkW/gx4tY8XGoo
	4DMYnPUQLkqkPzzRz3QBxrVCwsGadSqI6OplcO+RFf6lVkXeimqZZB+LRg==
X-Gm-Gg: ASbGncsLh4rL2xQNSuw6ZWlX44umUSgYZrTslWK/LO1NAGl354j52DB+CYwCFKdXDGP
	A2uOsyqtVlhqTXxO1cs6ryfpJT5kuV22EtvXQPmJq3iXHofHWqRZeD99pHcHOsF6xW3AcknQHGp
	nN+KumkUT3sYawQc7nNpTIlt+V4VZFD2PTABJKYpQu3pLDKRQxxFHYdgx0JFPA0p9KVWc9Ouvfl
	Xxi4CRIIHdn4Ht4TR+ILjst7LGSZ9dK0kuSCtCruEtrYvVoQgj/PCFNRXKkmD52IgM4Pn5H/kbW
	v8116vsbpLOzDqtSbkIDn/aAUQMaTpZnX2oLw/Cxlf85gO2wb+zFGiaTg2L+QRG2vOH99NBI
X-Google-Smtp-Source: AGHT+IHbT/y6SIytgLwKF4WORSZ4NAzvYcWlOt4XTeSB+apsoFfrwhgoAxg4dkzURyJKOfKYhDQVIw==
X-Received: by 2002:a2e:9c06:0:b0:2ff:8e69:77d7 with SMTP id 38308e7fff4ca-30a5b1a09d0mr40853261fa.20.1740397839852;
        Mon, 24 Feb 2025 03:50:39 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091f26cd5bsm33174541fa.18.2025.02.24.03.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:50:38 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: aliceryhl@google.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org
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
Subject: [PATCH v12 3/3] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Mon, 24 Feb 2025 13:49:07 +0200
Message-ID: <20250224115007.2072043-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the Rust dma mapping helpers abstractions.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d9e8187eb0..3bf130c0502c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6900,6 +6900,18 @@ F:	include/linux/dma-mapping.h
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



Return-Path: <linux-kernel+bounces-556637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C427A5CCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8844917A170
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88062263F20;
	Tue, 11 Mar 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0N0kxtp"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AD263C66;
	Tue, 11 Mar 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715396; cv=none; b=AoZ6+Q1Vq9NqbxN9FxYU2jvkuwN4TWQJeBDoUPUcnKvC+kyl7LvavSrkMXScR/AEKjkbtbXlMsdoSmYkn/7Wewq9VftmHWswnN0R2BydDvhOm3SeFcrmFi07ULr78M8LqXGqKJ++CtBGZ1wk9Wv2VM3ieQ031vMjTNcXdqj1xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715396; c=relaxed/simple;
	bh=kcqiy6qGt4Y+kxGncSLGf72ytPK9edLXcjO1O4LH7hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7CteoHsSmd29vBOaIczSGPiomba2pmkUmS9vLkcSxhokOlRIdofbK0V/L5KeHBV45u+nQM5y2p6NMvciFTSR2vRdJgpxOgCJVx2t1x73t7O2D6xh+dtujSEfBFMbz16SQWTTOFC97cyqA/PNQibGG10/D7eH6Oo9RLq05GHwfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0N0kxtp; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bae572157so56924651fa.3;
        Tue, 11 Mar 2025 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715392; x=1742320192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14YkA0wGL7fYnkvOubGO+Rkt0qCHzCYEIoKnBb0OOUg=;
        b=j0N0kxtplm9KWRJDHkSrqzZjj2AsnbrTIsldfnpKi+BlToJ4lrMas/uUI3Cpaj1qtA
         1MCXV8Cvyz7K4aX5QOCNm30YH48pmsQ98za4v58FQeG4za6FoUVm2Y4KYsj12R/YXUbk
         zLkFp734qQ28S2CiiFka2d65s0QlPUdY6nkwxUV2Z+lHLoPNKLmnIkzzIx4aB5mx3Cdf
         7YPFJWYdlTgUDt+QMVCBHiELzCPZ+wk3IhfST9eQYaFzwAivbkmQD66WFGx+yzCy6rVf
         OrzNu1d4WzoSH+L105JrmkMnFL3rBctTIDz4Vj5SX8TPYX62SF0KZWW/Zz7pPhNFcKzu
         b8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715392; x=1742320192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14YkA0wGL7fYnkvOubGO+Rkt0qCHzCYEIoKnBb0OOUg=;
        b=l/Z8rgRq3yKYISVISqCX27WAdlFmZLYqhqD4JUi//7vODvrXqfEKlJ5QW6XqNoE6pc
         l83ojcpQlrG0YTlC7Zfd+/+cUj5Cq/+W6aGuKdv7V9NnnhOXfFFsIsKD9YUaTiLtPbSW
         kgUN7xayZlruBANt4p66mOqBx1XGNphWAlP9Pnd/FezPqKUAErGEVGOEWJKaGB9CYuTj
         00gcRhQwbemrrVso08WGGNIc+3E47xVBl69S6tRPfpNYVfTPRMvMy5uGO/RdX0itMjjg
         8MeMf7dDacAcPhxhLk8Cjrsc3iv9ruK3YmJyAPyD7J83cbe6ZUXQuhmgem8rfcJj1NXR
         GKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUXO4JtGkN2Z3ggwuimGRXluf2DSTetar9yAzAMugdvckaJpm+xU9fyueswSgO19oK7c38fl5JiwkrPHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVu8XUMQ4ztoYBhvQEyDqPOudvIRVq0RP/WscztgCrgKLUgo/V
	kY8+UyuIkJk1dOnWSLm9juvagC40SwkfrcimLt3++8a/1PzXXBguLEq7SQ==
X-Gm-Gg: ASbGncvqitdzNfHQxnFlFEuDKCE/tvQjlRJLE0iMyg3QNeY6xg4Lui7Sg2Bebwj87nW
	IaxYW/krQlER6byxFNP0fqDjbFv+ge5gbfuT9URofvyeX3RIdd6otgc90ZJXrgZNgdiVeyw1KeN
	uV3nSmCylKDpZSrPj865wKasrps+Eq1lvn+Uum+EYFHT4Tvkd+JcmHsKltAghAaLUqeLg/j46Dg
	SsiFYlFe721YfJk1M/GwNTCuHJJLA6HFy73GeGRC2aqYpS53mTvxKnd9wgofxh/oepw2uMcJ5Iz
	CY6+QHGcfBFWPIThOglvA11wvRLswW+cW+559Oyn5HE98X5XJNuc7wlatbSDKkQ2NKlS+XTGGU8
	ez4QukNHyMJE3HBdggE6dyA==
X-Google-Smtp-Source: AGHT+IHOS3hlQgJU64hUJKXadQ+ab5L4zyh26dMc/jdCYKiPNtOWkm2Ahv2s8J3tE0GaKNyF1kyskg==
X-Received: by 2002:a05:6512:6d6:b0:549:8d2a:8820 with SMTP id 2adb3069b0e04-549ababf0ccmr1847721e87.17.1741715391892;
        Tue, 11 Mar 2025 10:49:51 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:51 -0700 (PDT)
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
Subject: [PATCH v14 04/11] MAINTAINERS: add entry for Rust dma mapping helpers device driver API
Date: Tue, 11 Mar 2025 19:48:00 +0200
Message-ID: <20250311174930.2348813-5-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
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
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 007ca67cc830..aa49c551fbec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6902,6 +6902,19 @@ F:	include/linux/dma-mapping.h
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
+T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
+F:	rust/kernel/dma.rs
+F:	samples/rust/rust_dma.rs
+
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
-- 
2.43.0



Return-Path: <linux-kernel+bounces-556644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA944A5CCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C34189EEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B58264A96;
	Tue, 11 Mar 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7jA9UfZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39326264A7A;
	Tue, 11 Mar 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715409; cv=none; b=UmcABb48XlX5Nj38o24w08003D2DRSrAyedUPtZHUC1FOSj4AS+UoGdYToWyqp6ekMN7l7LOZ6SHKLLl/ZLDDfL8ziJI89avlUMQUj92JNOXvykVqBAaoEgyaW/kHPmY8TxcL1/8NqR7zjWrlhs1rv2DMT/JS60DPOS2Rl+5tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715409; c=relaxed/simple;
	bh=TcpoD/AzioVcQ+RFPHlw+D3njSBh1aynVEy/vrcfm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6uLfFKEVcyfsnDrKJd+FszixSuEtTh2Z8CqVhE5wWZRtwskCCnU34kQ2UwIXQdRETxDfzUZwqKAVl57BVNh8Fm92XHP5Xlo/k91jgba8L1damjDgvBg7zgXoVuSBGOsM3an6udirSB6jlH1FtgEy1Hu0+/FwBOphtOmLS4dr/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7jA9UfZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54954fa61c8so6136677e87.1;
        Tue, 11 Mar 2025 10:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715406; x=1742320206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=M7jA9UfZiig856j/JBD8Yn3v/KzBVLcQlQZes+vGZum8vDY2wvPjt4KFCPPrROuAYv
         eJipd8KxiVAt0FHlJ3yqAHj1g+EX822syHKRhfwVvHTfMPhnMzhHw/XA1HY5HBmiaWml
         3FVNdzfoWJBvr0z+BQzBq9BNRlb9ve3BugW1zJcfKN5UQTYoJG6WaZuz/p0scL4FH7qM
         462XTdjAl9Oy6/1EvQGbQefAdraI9nTSXjCDtV01nrA+kBs8HOB9Q88XbOyfl/ZoWR3f
         f1ScBPu4qsI/h4dB150vrduxIlApyxtIFh8vqDN3BywJcbH3ENrTGzaB1TMo7VAogsrg
         E1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715406; x=1742320206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=U76lAlyyrz0FppRrBhj0R9I0WxuzeQP2IoBbBqXa7jNysB8mH2lLw8dHjePjrUXdGV
         l+kaHAkKb70pFBJYYUv7hCEHLMk2oDjyfpalZKptThej/ZjsECQmTDtvy4KoUMAF3Apv
         RiF6cJiPDsNhbueToYB57vKqec1mDrbuymTgYLC0VoK3vptrT5EVyfmv80kafxy3MGoK
         p6O2uRLiOaHNT9ApNgGkHzIDgt0MhX1gWcm9OntWaW6gJnGxOGPW34aZmWKuYtYCsEEo
         6/2jN3A11phmIByoBdoJ5hSFe5kQbo+cLNnPD1Sgn21ZWUVsxnIwgC97WQE7lH3EJQN8
         BqKg==
X-Forwarded-Encrypted: i=1; AJvYcCXuYSMLchtaKohqTcqjtc2WX2aFnVVhlL54SY8g1t1HrQMyL/i+YkNokE7zxTaaOKvYyY1DvGIZ4035jf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqti6PgElnCBNot4aP0panvIcqcRNvsG97RvKveBNa4gPHdsQw
	Uzi/0aUD2Bw9pMQ/SjjpcJ9t28fdik9wxENKBImExAjI/qTFVlKMwQJdEw==
X-Gm-Gg: ASbGncvgPuQxPbIz0hofBHvHG/WmVF8DOYk6zNbg4Y7M6kvCe5ZxJzZ6UqkmwbH1cHl
	lGX33vpyw8y/EI78IHiuY/s2UvxtrtZkAs8c3zCvNc78eRunqXGGrTJJzBTDuRPWkZDuhsff9zM
	WKYGU8XULxjSiINEaJKapsxq0h3fWzBWAclpV0v/c/7GSqS52O0IIqJwAG1itvZcsEgcsLygyae
	V77A1T6Sn1/y6FKLmMx4lJB0y0Y27euq26BCbYGNvC7vh6yUixHRDG0h3w0hpvk6OSsjhbJQKEj
	d9AfcdaQqWn+ZdIICZ3lXqwDHC0e2HU8Pt29VQC7KNfngeyLFqkcIe+YGYbOlM9gsBY2y2wQS4B
	hn4EM/HCE2DVeD+vxFsM8fA==
X-Google-Smtp-Source: AGHT+IGq9+9j3TLKd4ZMF0Hv/jAhadwI+/7rJ6RpYAMlyrkjAtEgxGTE8Fo3X2gzmbXq68ctC7l0Vg==
X-Received: by 2002:a05:6512:ad1:b0:545:c7d:1791 with SMTP id 2adb3069b0e04-54990ec158fmr7085373e87.43.1741715404978;
        Tue, 11 Mar 2025 10:50:04 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:04 -0700 (PDT)
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
Subject: [PATCH v14 10/11] rust: samples: dma: set DMA mask
Date: Tue, 11 Mar 2025 19:48:06 +0200
Message-ID: <20250311174930.2348813-11-abdiel.janulgue@gmail.com>
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

From: Danilo Krummrich <dakr@kernel.org>

Set a DMA mask for the `pci::Device` in the Rust DMA sample driver.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 samples/rust/rust_dma.rs | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 4c7ebf66647a..39b6050aa3b6 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,7 +4,12 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, dma::CoherentAllocation, pci, prelude::*};
+use kernel::{
+    bindings,
+    dma::{CoherentAllocation, Device},
+    pci,
+    prelude::*,
+};
 
 struct DmaSampleDriver {
     pdev: pci::Device,
@@ -51,6 +56,8 @@ impl pci::Driver for DmaSampleDriver {
     fn probe(pdev: &mut pci::Device, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_info!(pdev.as_ref(), "Probe DMA test driver.\n");
 
+        pdev.dma_set_mask_and_coherent(kernel::dma::dma_bit_mask(64))?;
+
         let ca: CoherentAllocation<MyStruct> =
             CoherentAllocation::alloc_coherent(pdev, TEST_VALUES.len(), GFP_KERNEL)?;
 
-- 
2.43.0



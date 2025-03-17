Return-Path: <linux-kernel+bounces-564943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C3A65D58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1E417661A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050512045B8;
	Mon, 17 Mar 2025 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLEVKi1q"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FB204590;
	Mon, 17 Mar 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237666; cv=none; b=CuVCpTOldsPNyGG0bg2V45/9AmfwEb68ppC2/h75HrpOd7JPOre67KOH+mET7qzqn+RmFKSqqElw/d86g+t9gMyGtWWUMedLLOj847eSScNC3PhP2znPsTcC3tG5weJZKJxRtGpiZK2CW9alGeT8PL5JttYeNIyqMUvfriHe/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237666; c=relaxed/simple;
	bh=TcpoD/AzioVcQ+RFPHlw+D3njSBh1aynVEy/vrcfm3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1ycokRMEG2mXefLJIRuCfOOcjaNWNEZiO3n2o/VV9EPrB/SNX2cendR6jn9FTwFgKGhgJRp/SEOOGpOdJK0uemDbO17rFNrs55ZmaoNl5+5hTFa+oarELpeYRsIdYlXzatMDql+2o7NM7n+9b87HL9fgSyGUK90YAF9Jj6s7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLEVKi1q; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5439a6179a7so5294528e87.1;
        Mon, 17 Mar 2025 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237663; x=1742842463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=VLEVKi1qbRhu0zax2Fs6VZI2MgIy5sSZ2ZcQcuL6kVRMuynblHrgeJ/43GPxsOeU5v
         Kyac/gISjy7qSyhYrkrU8J0dA5G8ApqpiMFkovqXmdjLALZcXRhok3Ix3IvLcKgVj1Qj
         NBImPQWkTQs4SKJSr8fxE6/5dlg+cWq5pV3UmQbXSuZHKdbObW8idDsXOZIvfeql+Ra6
         1PxG4vwQFNvWdqs64fHcUaFlWML7dh7byrz39qV9Wqmkm+qIgC4gtct1CF3rFTOrTHQ6
         FKUyKJZ4gd5l0+vr06bwYL++vfY34hNEb3yFSgSYVj2OxhhtW9nlOfn2wFIlKk6NXfb9
         XU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237663; x=1742842463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6wjTKcHZVvHIKO2S7cxVflMybOF64R/jyjw4en16rI=;
        b=AcgRR3WjGQCxRFTZOYKmC2ts0T7srDUxxWu0goklgsqP4m/kH+wK36pVt/nowb53Ks
         OleTz9PnlH5o++iT6kTZZrSIvaT1POHBGBPRFhdIVL+lKjJ7DoslI+2QEvyuyWOAacAf
         nwrGzGz9ZJLTBIOQWyrUWN4OWGC8IJpKMT83R6W3tiLkimTAo1bc50AVtBzpg0yhn4Km
         OuutLhwng6+4tQ65LZEZyCIhod6MPkhy5WLrbD9+KPFqVDp6MqqmerElHLb9vzFLPJqc
         hIeohMcE1dQBSSIFQzywGIYaELDB5cZpsTrewsuMLq4bhsWMgKful8QbzXY97e58tqxA
         8LTg==
X-Forwarded-Encrypted: i=1; AJvYcCUxbXzQ/7PDNfIR5biLnlsSy/O0VibNX34qGDM3QxaZ424c9gCGmVr9QJKfs2RKAJIbg5MgUsTTlaFOA+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmnOFn6uc/TbYViYzHQuvKXhYFWs+Wyo+ZJ2Ujq9EKTwdCT0r
	ACpHWF8MQ4ZIMw7A/cJhLg+RzmvAUXbT6lCCizr4z9+2BfqeaMwlapyzuA==
X-Gm-Gg: ASbGnctcVUVXTaXBBPbtDG43fXLWLxes8lmzsbxHAMZtfY48JJRjiranO8uC5b4KZvU
	iEUz8o3Np4MNaJdEh7JCCJ5Y8BzB0N68PimOh5jvF4EOohoms+eYwlo6Il5kLYUKF7y1H8eW3ic
	CMN5CZkv2xJnQYJph+T/3LyOulzKcpltriOlFSF3XZhYtAHPl+9ZA3ZNLJhn4114gzTAIrnwsg2
	5q5wZlyfOJRd/v9/ylvq6zX9fcSqk6c5XXwrtbf7GsmdxFNaouIwyvix9uzhTGrE08sX1FFXMQp
	mx3nJ2ihU1oqZaQ8+mJlZXf4jNUcc1xcA/48Rp3THPyTfHpn6188zCouwd8HQLR6ApY2EbiqbT7
	byO60vRFdY0jlas07twYNO6CrD4e6MFAl
X-Google-Smtp-Source: AGHT+IEP/PtVThPCG47TCqBvS5ALN6nZRdODEw6SF73CDXB1BtRyV/+bQ0SZ49Nqf98pxWHzMjB8AA==
X-Received: by 2002:a05:6512:ad0:b0:549:5dcf:a5b with SMTP id 2adb3069b0e04-54a3046a9bamr523713e87.4.1742237662590;
        Mon, 17 Mar 2025 11:54:22 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:22 -0700 (PDT)
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
Subject: [PATCH v15 10/11] rust: samples: dma: set DMA mask
Date: Mon, 17 Mar 2025 20:52:17 +0200
Message-ID: <20250317185345.2608976-11-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
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



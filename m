Return-Path: <linux-kernel+bounces-564933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B035A65D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BF23A9861
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E01E833E;
	Mon, 17 Mar 2025 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc6XuXfW"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387D1DDC2C;
	Mon, 17 Mar 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237650; cv=none; b=VF+MVrTjobLD3ZsMBVe132EGTfdCSX4fdDRRYKoUJZbO9HqO3K1ct9Pw/HjwIgxddYRzrQN6YEgkDrFrJIMvcKSs2nxLeVprJIS/to4wMr6pWVhWyrh/azurbsDDc1uJURmiR6P05K7+d8HTWLYFQfBKfnJopEbrVIhrsNNxgXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237650; c=relaxed/simple;
	bh=VNgS0vH2ZlYZUHj7qrVoVvtJKWTOOMEET1wyGgzN1t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvGh2W38fdwywoDl8vn+eckPLFpf7CjGd8cTUeMjXT24gvKBmsy2VZf2hWshFIhiTr9TuqXEqQ0pWYAzs0o7KzIPD48NEE4p7tvIq/z+st6uh5GASR8juGUPJzCARtlcwqN+UyG45nW2yZVC1ErF20+JPEjZFpHdjdTHtAsSYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc6XuXfW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so60499581fa.1;
        Mon, 17 Mar 2025 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237647; x=1742842447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSlOoVfGuSynT1x7fqBiBqNVP4Dgpx/NS3fcP7oxU0c=;
        b=Cc6XuXfWU6VJ5dRkVizeZvb7tmojGRX4fq0BCUps3KlJP6kGJ37aAVOw4uXr+5jFqE
         XVhEVSnEz0w//IWnP2Il1iqwUgAnJ5kv38G9d63G4LGeCM1J7bo2xW42XKnofjJ3VC+q
         MMgJBposLv2bxw8MtVmM8v6tAVWu8V4a5Gxp8RcpIG89cVKnqIdrYwzFr1W3TLaKRX4i
         n6t2zodwpZKnV1XZqo6+RysvocJ3N67Lr7WmzXMQBm1yUP99+LyopoXVONiw9UdsU0Gl
         TXWh0rD1vRnEJfdMqFQ/2gr9o2B3cl1GdZQThaeeZvmmy0tC5hYSb0fZiaRIBWGThiT1
         HK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237647; x=1742842447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSlOoVfGuSynT1x7fqBiBqNVP4Dgpx/NS3fcP7oxU0c=;
        b=xF1RvUTQel6n57mBgniayoPXAkBa5dos0C6dGF4LtbswM1ZZW1t6czAI8cWLy3AkhY
         vbzkqZcYw9WDCSgvhmfEX0Le5Gce9DDYgmarqTxaNrZ/znS+Q19nAEZXfQ+P977tP9Yr
         D/HyMglaewk3qNfYDR7QW+BFuf3C1wtlWAAQmICVf89ETEOnWdxJ5re1jairQs1rgi/J
         gjbvLiNpENc5tysj0xNf7yCsXQP9/zWG7Vz4B2bEJsDwnOPes2oQL3qP8iXhoWWcVG/y
         klAjpn16a0U4UX1K0PKgAFlGl8vI904gdOA7ij/jpgfqcrtcTeAEFHeIYTr9J2jbrw06
         7pzw==
X-Forwarded-Encrypted: i=1; AJvYcCU/FPf6+yU/E3tk2vrhSs3iZ4JLLhr0bzOa9S58pVeuSAInlvztx5Tni8bfRr+yB6ycu1YuJpXH9k9yUO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjM/j2+s5kuMH+hlq3ACRrIMrpTHHBRpLAwL8peKgeDbQP6MH9
	gIdynkMz0/hNRghtAQYADH5vmLQukoiyetM5/jRQU0Q78n7Q8sxhVbPRcw==
X-Gm-Gg: ASbGnctOeyX9Onpy41GEzaOzhdx3I0YUwyKnzMclLDxOvCnipjJwEgvvDcpCZ8zmOPX
	DL9bJ1ZyLIW0n7b53zGK34ra4LZ8cPj0BarAplaUogfCXT6ZZY8pnX7wnKJNfXKIDmKSX1NTXqj
	O4A0Ju0kbQhqmSKN1bmc3TfYXQNUcFLQH7ueMyywSc5u0xK7qworPFxmoSPAbWJzyAYZdZhx1oM
	/vcu7mcY159SxVA4xiysVkt8ULbV7f/tJ3bHJr1BF8VhQPd3SD1hL4zAfgKeJ33GUZg+6RwGBIN
	bpyu6WpTpigDcbJuqmnPkbg853YzCcBTtDSWY7QN2SSuac0Vm+c7G5jGxhXIsFuSXiL4YlN464x
	lR26ZqcX1yBa00s+Rg38nBA==
X-Google-Smtp-Source: AGHT+IHQF2iIfVqplnGsSaUNHSln0qW15Tgb5KGAxJooMIYRxAdePR22i8Oq/R6m75Sr3v82hQrpxw==
X-Received: by 2002:a05:6512:3048:b0:549:90ac:cca2 with SMTP id 2adb3069b0e04-54a3047117fmr558637e87.1.1742237646739;
        Mon, 17 Mar 2025 11:54:06 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:05 -0700 (PDT)
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
Subject: [PATCH v15 01/11] rust: error: Add EOVERFLOW
Date: Mon, 17 Mar 2025 20:52:08 +0200
Message-ID: <20250317185345.2608976-2-abdiel.janulgue@gmail.com>
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

Trivial addition for missing EOVERFLOW error. This is used by a
subsequent patch that might require returning EOVERFLOW as a result
of `checked_mul`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 376f6a6ae5e3..30014d507ed3 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -64,6 +64,7 @@ macro_rules! declare_err {
     declare_err!(EPIPE, "Broken pipe.");
     declare_err!(EDOM, "Math argument out of domain of func.");
     declare_err!(ERANGE, "Math result not representable.");
+    declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.43.0



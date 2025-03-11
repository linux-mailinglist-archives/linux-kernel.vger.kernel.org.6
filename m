Return-Path: <linux-kernel+bounces-556641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46FCA5CCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE24189EF08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C112641EE;
	Tue, 11 Mar 2025 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD1GyJsO"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D1262D21;
	Tue, 11 Mar 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715405; cv=none; b=VkGk+G27x7qKj3eBzGVaYVU5E327luzjGIqx0yAlwgR1KiNIUDD6DXMIRkemdGktgqdnvKYsBROSFACeZiuova7zmXhSI/5K1r1pxRVWaZUmvSMTfI1i7EFbksoKPVqSuiQZMD45mSzu0+HYKTGqxBk9VbwkfAkyRehooRLdojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715405; c=relaxed/simple;
	bh=DhrwcCKAPl4wQYbKHYYSepNVPu31+4xtNNYqjdxy+Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEFFL9JVf2f34Uh6ySe95xTm5SKY6VBcERXMsR12svhMgkBAVS7w0NSDjgin7CpUXaKRwUr5kl5PnDoVtCS5E6u4H2yS3XuPolhhmirJKAefSqecwQZoBjLCOjdTl+KQdJoNY3RIrqutrX8Zr90po6ytCSGR70hExLOlfQz+gK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD1GyJsO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54963160818so6550297e87.2;
        Tue, 11 Mar 2025 10:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715402; x=1742320202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=mD1GyJsO531yX6cgGwevwwlDdu3mg0XMoRdv1IdjLOZVIDDf6XYgg4hOglQNOBTbvN
         JiC58l90m1z+LRYJi45SPma7ID3U29kePN9S6n4J7hauNXlNDgp3BM5Y/oocaHtGcWxs
         8kN7XSgoj1eduWcwF6xH5QgG7607wtPnCx3JfQVJ80H6u9eHFCV1hxYOLzTWQ3dnvZA9
         Y+tKipcX34gdylC9tjThCwIHsNe7ZCkgUhKiKlW6+ALEjBzb54jGmuCKDNpLzd02xeb7
         +fnm4WQqbIhrrQA3uIhfuNAUcqoU3U/1ggGoRsDazGOcjzuE7fYoNzIFr/duaBx4aWxj
         FAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715402; x=1742320202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bITllDD7zuDX+leMoEvJ9eOhvzTi6bzqiRqTzF92s50=;
        b=IUYh0iN2JHwglMdNX2tXIrsU/UivhXzmzMzB1IWDvXrAk/Fg2NvtD8OtuQaM7f5+zk
         Sow56um3WVOOKVeYy1+CAamtLYNcpSKmxtX5ZCw0JXtVuQtkGssgPcKrDypt23BafMdB
         6QsA/OSZsfVyZmtTx3VPELD67O5l5TzbmO2pzJLBABHbd7u5Mpedg0CmbAUZy3Z9ZsVr
         XC/QCGSgXlsrCQksPQcf/ImRL4GDeYHxZp3S9XtJ5b4zmk6XV45Rvcyy3ZdS8LhNuxCw
         MPJdc+JX00pYj794iB3BILZwQ6WrnwTjc7S1LFS5hOdAhFqrNor7lW87MkhLXKJsPB7N
         EfTw==
X-Forwarded-Encrypted: i=1; AJvYcCUyvdFINq/QJYmLo5SHvhC/mrjYKEs+TTd5Qf3gRNKNV8ixDnqrPxq7E35e5VXkXwRs0XBl9ia76u6nbMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgqkjLuCfalFZn7LEDxDH1ICIcba4KeudM0y/IVduUqz/J32Z
	/QjrlPDIXOcBcGdPusPukyEOxe1cTjO/0o7Oi/qd3cjqycULimPKwPs+1w==
X-Gm-Gg: ASbGncuUNm0IEol78wZPLMzwEFMNjLBFRJiD8hdTNFncabJ7yKBI4bASZgOMm7iwchg
	b+QJCE52yaXUCkyJEdDmx2MEFDPs7UzRE99hoVGEMMB/DQlqbeFZqgA5elx8SfIaLDMuDyIBjPi
	Ja+8ZEVNryq/Q+fSo+kiT49DERf1bHcLA6/W9Sp09Ff3CffM+urqhEKCyZz/c7fokUjc/AL1bq1
	XjB+Xf6VXOS6dyK3k7/U4JPCCCoRlHOXXJfHiIU9RAaqNCh5GsCCj37ebp2eG4dHDjFWh8ysQ4j
	Mt+q5LIevuvMc+Fnkxr+yrDNbRzKxvKME0N2OL9/uUxFbLGskOphnsMZZ+o7NWQhKDhA9D+fCBv
	X3O4Qh+06WTWdoLNrdTwbDA==
X-Google-Smtp-Source: AGHT+IHLqeLrmjCzyXaU21i/GMhrHAYwaPPURUglknBJ5VdO/cQPJy+xrLkGD/iWnJmSh58Q5/RDJQ==
X-Received: by 2002:a05:6512:3d15:b0:545:2eca:856 with SMTP id 2adb3069b0e04-54990e2be1fmr5700784e87.9.1741715401504;
        Tue, 11 Mar 2025 10:50:01 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:50:00 -0700 (PDT)
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
Subject: [PATCH v14 08/11] rust: platform: implement the `dma::Device` trait
Date: Tue, 11 Mar 2025 19:48:04 +0200
Message-ID: <20250311174930.2348813-9-abdiel.janulgue@gmail.com>
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

The platform bus is potentially capable of performing DMA, hence implement
the `dma:Device` trait for `platform::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/platform.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 1297f5292ba9..a7bf3525313e 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -198,3 +198,5 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+impl crate::dma::Device for Device {}
-- 
2.43.0



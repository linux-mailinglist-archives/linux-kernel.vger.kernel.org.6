Return-Path: <linux-kernel+bounces-564940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27EDA65D55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2862F3B50A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81520202C47;
	Mon, 17 Mar 2025 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv06Lm5x"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556E1FECBA;
	Mon, 17 Mar 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237661; cv=none; b=D3+yavpWTlIPqbFtGJYpsXjwD8eIbAXyYkEa70UjJ9n051xsj+5YT2K5KXmjo8juFmimpRVofLVwdMfgFwdhpd1p/u6tzpRz5mM7uirQ+pySbMCm+DiTR85eRJp8Qn4fLSi8lWurIiT7UTg5r5iwr55aSyWu46ZXxAFVwHIiTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237661; c=relaxed/simple;
	bh=VyefDGWH0N2YpL9VfzECx+ApcLuk3v2hDwgQ1bV/Fl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pq7v0+73HJdyEqG1Uh7QK+2371lBOiZN8cWfJOIncyyunfPVvxj2FEHag7z/SXxR2aG1RcWr3rlhfa5BODidt4xxvAravHWFeYUONQ1cBBzTwTBNkGeWIAIPapRQFTnGmXshDfLI0UGNg9NMAFZUJPRY8QqOxBQWaHx3r4gd/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv06Lm5x; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499b18d704so4799138e87.0;
        Mon, 17 Mar 2025 11:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742237658; x=1742842458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=Nv06Lm5xFaL6pQi9y00Kn2sYUHw4dO+b/g//JqO+R7TMQuWr9uEEAKTohmIhXagxpb
         6XCIWoc9k2SLfku5AGGo22Ns6w1Klg3QNa1Fk9kcGjlC7eXZ4CQkX7BgQML7TF3MniCf
         WJ9XP+YC6r9BiG2KoEChvRXgAQK1sFWNE9QbhAXxuahiCxows1B9cQRbRWOkH1tO4J5W
         CZseVMDjyv1UqlhIyQVSKXxrYPnx4Ow2TlA1oAESxjJAbRUPx74PoFK3pSKyDe/WEMxj
         lo9vUDQxXJHc24yQy+Mw8IWE/C/FsNCBh0or+BmQVyiMWvWAuMIU653UvS6UjffTXjn9
         2LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237658; x=1742842458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=ihvd8P5FUD3ncxg5hvueoR5Ot1+Lz5DrpRtyuxAfBuEKfbqG5vrR7ponlNDxjgeAbO
         jX/yjv999UAA5jlgWaA/3qXTs1b45bLdTohMW4RgKJOWjwgG3xRJ6K4VCRq9JxTyAgZ2
         dssihjYC/VwclVSq2XtjiHXY/KInLyc0cDZ8UDoxnEk8fpm8rvgn7Y7l42nEsVyePNdQ
         jo78D+CYIoZ71FZz7G3w3muLbJoVrTYGd3iAmbqBhTGz74SGJsaNWiajHzz/v/xChY2D
         HWNtQX+GJms1acx9Th8WUtXTd+gUZ0wFFMJdShCXXKpKzo6tinTHYeG13ahba1ZeIwMK
         RDmA==
X-Forwarded-Encrypted: i=1; AJvYcCX6VbNb2nQH6Teb0tnvIlefha/ublxdmc/xMCeyGk1HfKeFtLzfOuzHUSrLTAFaspC8qc972hVoFjwlJLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxopYX4KZSQRWlo5ipLw3Veo+ufRa6looVKXmqU3zsdCEPTCNAz
	QCdCwINzt3ai8qiYwdJFVx3idKFu6N77wjn19s6sb+UArAvKvBGVMYfjpQ==
X-Gm-Gg: ASbGnct2TUF44fUEeisfX7vRfme8hziMXhTqUICzFtowCokXQtpsFlcpYSBDE9b5DN0
	G2Qe8Ey3ZoM+sWngrQCC+KhYFmJgXndSIkqgudSLiYI4YZyLQ5sJVQ7DWITk19wmsZjwoXeUfJy
	Ns5+m8kWetH/4CCUYB1DbYdgTVJ0I2bpBinEOY8XSMIjFOWWpo/Bvz7v8cPATQvkYqnQdlLUTy5
	wH7pAgcb2aVJPZeZI3ic00c6AyG04ZsWtRLqIzkSkYRCr2LJqBOgYeG+Xc34RghG/XogkqcGxzj
	HZvzKC8gAN9kfHX5oS+pzlY01GdD8978DPC8xgVW83BAAqXdokpPLgxEUpkZ/Y4O4tKmvmMnxCa
	bn/bZF0xV0imyAoTMs1PE0g==
X-Google-Smtp-Source: AGHT+IH+KOAMpDUgs9VZDCOMT81BZbgFevjKeE27whY+TdKHMJL0Bf3RFF+AR/1gnrWgGKy1uUv9Lg==
X-Received: by 2002:a05:6512:3ba4:b0:545:22ec:8b6b with SMTP id 2adb3069b0e04-549c39907ccmr8171472e87.35.1742237658184;
        Mon, 17 Mar 2025 11:54:18 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba865024sm1387506e87.123.2025.03.17.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:54:16 -0700 (PDT)
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
Subject: [PATCH v15 07/11] rust: pci: implement the `dma::Device` trait
Date: Mon, 17 Mar 2025 20:52:14 +0200
Message-ID: <20250317185345.2608976-8-abdiel.janulgue@gmail.com>
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

The PCI bus is potentially capable of performing DMA, hence implement
the `dma:Device` trait for `pci::Device`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/pci.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f7b2743828ae..5839aa5d4098 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -432,3 +432,5 @@ fn as_ref(&self) -> &device::Device {
         &self.0
     }
 }
+
+impl crate::dma::Device for Device {}
-- 
2.43.0



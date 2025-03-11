Return-Path: <linux-kernel+bounces-556640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF11FA5CCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C50189EE98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF642641E2;
	Tue, 11 Mar 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUeZJZr3"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F6263C85;
	Tue, 11 Mar 2025 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715402; cv=none; b=ZmF6FwyBaC19TUOssLjo8mURkMLiVfAuH4gqBCQyjV5NfP9hnY+Uo0W5sS2gxmzkc1X6xyyQ9tnRGM7JnMj/Vdua9umW98WpGYUN4IgDbYrhAnSjXkWizkyL40xyJmDBUxkAPDXq7s4fsGoZ41Wxm5uv9ciWIeWunk+goEXFstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715402; c=relaxed/simple;
	bh=VyefDGWH0N2YpL9VfzECx+ApcLuk3v2hDwgQ1bV/Fl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQAa1eT0AefvwyneddZ8Uc1I4q0YelfibW0k9L4nfPgqHOHO3DXMsJOkxaR/ohqcRMRpLRFnTgO5x392ewPMkQOajFSDn6bQitVicgkHvmW2n8Hh1DIQDuFzqUiTXUS/GlW3J87SoOXp0gOpP4+mv4ZebWl6u18Yg8Jxa/KFKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUeZJZr3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30613802a59so64189001fa.0;
        Tue, 11 Mar 2025 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741715399; x=1742320199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=FUeZJZr3yXQFWbfN7otgg8iPf/9Mw88VcrL4GGMdj9K/OX3h7CGue9mRl+hRLyVdXm
         pWY9eInHLHzhYhXIYq7uhOwXAjHEAFIfLLl7yN34ilbakUEgl7VVLT+3bZ3aX0xX0Ggc
         LqnHQm02tinm+q+SHkS3FpydD8ZjtHv45krpl1vIEX1qXc9ZScHSZhdYNVv6uJsgvQmj
         E73aN9SVZZj9MatUPei6SLbAiThewYVS09fluQ+r73lHuriU2KWvs4QY1ZHiCUnIsHLM
         rj5Acnijq7obrtpWjMeUmrZXqGFOZzlgEnFIHVbrx2e8h+7GBHldJT16ycl5WkSLcCjU
         5vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715399; x=1742320199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RE7FkHXPj3rgd/JOL9Q773Ys4uYomt6iSafrtUCPEA=;
        b=cdbnUseNE/KeYd4cI7pQvYmPB1Z/KpPlydHbt9ev+7yBeO+5RwQBPb5GBmhFDhou6b
         76B2cvU0OBlPOVlFIxyYKvkoaBf5TBCZ60tqn4flbYuOgV74jDHWdEcL/fRZlqfyZz4p
         kmO+hkFdaUU9qBlYLOrudM84fBLqJKkzcbNuKt+AiscHCBubDtllcp+04Cl9utAjyvfX
         5w+XQk1UlP031m5ChUnULlb52uBiGJ1yBplCyHBIFNF9JID+mbOU9FXb4GKq2rnXFPgc
         T/SewyWNdQX5KqsEYFHyODOHU7B/P+nYS8g4gC9Wx658HjCp1MaQhz/4bc9PGSmyRoz6
         BPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUteqAvdD7KJHdJaG312Id7kikLlPa8gMo12Wgok4cEMmMN4L/OVrNGrcFkOhNVgmchhqwUIEbSNw7Rb/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwraBgy2rBLwmO5fq0FeKmQOR2xcuSG00pnsVqDrB09+vNvPwuq
	JQDgyuBlhVZnuJBs2rZTv+UH75HOt/0pWXZs6R4BqsEByk103lt420N4bg==
X-Gm-Gg: ASbGnct4+JCLslQ7+IEphO373zd8zfT8NVYzNs8oBOVGIgM6oONUc8FidAe14wozeHO
	dEJO22vvaao/N8TlxWXfW5yaxJ84R19gVt9jJ1d2y/+S6lTcf/OnHaEuTNamr5k/194/CDNAMRO
	CywWdNRsMYahKv7zEvilfTH96Ub5bNmAG/WjTJOAzQ278OCvYDa+Jms3TpdsluA7M8VtF6JZbJK
	xgYqfOzwIXfwVExT9msAaYs7phwIBxVEQOjEscyrPDH97ZJ5HRbfFi80UMp7d3d3Rz2bzoeTIj/
	RQHdlhDhQdzALZbXI6KebGQUcbxLiYPR2UAmWQrUcLuCFP3NHjKuvsv+NAsshUtx7eWcePXH7ZE
	08fJT6lFyzKWM5UsfC7cdRA==
X-Google-Smtp-Source: AGHT+IG4/njd7PlBm1mpnIVR9OdsVm4WGkJQXiTRSmnS3QRyKrR3ovUI1B0STYMLIlQyY1eNipdRAA==
X-Received: by 2002:a19:8c0b:0:b0:549:b13a:5d7f with SMTP id 2adb3069b0e04-549b13a5e20mr216857e87.41.1741715398584;
        Tue, 11 Mar 2025 10:49:58 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae4465fsm1921728e87.26.2025.03.11.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:49:57 -0700 (PDT)
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
Subject: [PATCH v14 07/11] rust: pci: implement the `dma::Device` trait
Date: Tue, 11 Mar 2025 19:48:03 +0200
Message-ID: <20250311174930.2348813-8-abdiel.janulgue@gmail.com>
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



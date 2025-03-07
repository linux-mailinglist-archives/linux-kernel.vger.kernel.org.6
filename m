Return-Path: <linux-kernel+bounces-550944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE1A5664B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4887A4841
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053CB215F5F;
	Fri,  7 Mar 2025 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTN+pnXZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267F2153DE;
	Fri,  7 Mar 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345720; cv=none; b=a81jclQY3s330jOANhfDAWK17cz7oq+r0TZqrcVr/rJnSez6kzJQ9RYzY3RV/KvRUNkF1gRpfV18rMSWtbgVRHdk0EEFCxjDfSTBG8wWE+6fl8IqCH0XHyve3c9+1BGrCc+vaHt+irkW/08dAZgm8KFkY406++Gbg4POyQeCaf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345720; c=relaxed/simple;
	bh=7EWHV9dXU2kG/xafKevv9SzG5SSqBdCFZI3L654ZQDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJo0KycVdBYYMQm13ScGeJ/QQz/65ErtCvrYfiV0Ovu1xPP+SdkyFVm8qJKA0kiEkuuxS8u+YyicRvLi4P9LP2d+fE+2RmtbB1O0WtR5ir2qHd2PMvqzi7BNCtFvmsCk5kxPEU+ORveT1sOu4LNEQHPBJnwSwnX+6rV6b/FfMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTN+pnXZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5494cb8c2e7so1870261e87.0;
        Fri, 07 Mar 2025 03:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345717; x=1741950517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=RTN+pnXZELpGE/BUdfQWqC+71/XQveuvXeqJ8uxPbrF8cGfO5JCZWJj31oVYPbS/Xm
         Klty46VmRGMtujvlr6NQMHuu/TwrNcf3MjyDhcXut32p402Wp7cub1cj4dhA09KuW9+4
         DdpDCzwc5DE6VEiO/QdbhsTW4WhKuOzggjF3sAU9gq9lThIDBtqLAMMlNufo8g7FLXKh
         H0lTJK1L/JdBtfYeGE55dRvuUknBB5r8R7WnJqf2dpw/fm/36AfqODnhkCujFounHVE/
         hOj0ScwnwEyUk/pf2zNe8a66hYo072R6CpGapm9YWDkqvu8mDL2DQdzoL3NsjWcdBSIQ
         zmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345717; x=1741950517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QE3/EOD24kfqjSTHkaz9KRGvlEanB1hF966k3hECCPg=;
        b=PWTxOiSWIFNK8sO2G/UUJGw9N8Hq5ZN+0tNN1qq43hovPICx/Gfire9jiBJFQ9azL9
         dyWpWeQ+TCrkxQDFwiWwEs6KW5TdzC4VQgYYDeWOs6XSB/mDo6/Fb5l0bJJuXJvGrglV
         BMeuAgEP1iYmS+fZh2vvlDd92IW4qv4tTkcVknhHi61h/jeSBUGKlpHMThnJhqR3RKr/
         Rp+NkFUJdhuKVRgPFv6YFIVnIo2pI/JnBqOU/iV5yrAX6ySHQOPH+h7oJfa+EnBsq4Cj
         hYKQMQ2h/oDHWtD36gP2llUspRjXOlfiuO9M4sQyp86+H6UwYDs5f+SMGmeXEaaWiq94
         QGWA==
X-Forwarded-Encrypted: i=1; AJvYcCXvdOrX9jHdR/uBeZXCeIiesWaLpVrcGZ45y8nWm9aBIAumRd9vsVNyNfW82BQpDbFdClvFvS7IXTNv0ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fG45IUhGBIveqdkFYZN2ykt9uBH7uoOpc6LCYsz6044qYO95
	OWWwsehrOGc8NDd1L12o0XG6ZaD1W0z4gKvrbRctTS61r9OFFBDOspzEEg==
X-Gm-Gg: ASbGncuG0k56WDHjOCGk0XCZw1Tlz9Gc5Ma3mXRV3VId94yfKobEJS5Ob7U8X4Fdk4y
	fk2qRqcw9rQ0prmspocoPQS+E2TvPCZVp6u7/3WbNSslNA4kUqplL55XSrSrE0zUULWX+IM8wCw
	DqwJm4ScQv4EYN5PfPCNKOcDSrJHs1v8/LozGwJeNb31LOTu5qjY3c24dILlmBZUrjwwN06zBFk
	mmu7WXvqxUSy7aeVQVV47PXvrwoMaPF9I01+hKyGD8XiIWvG9c3cQcDINB/lnhJjaeNfJsy0qj4
	ePKqffxK3E5pAk6/dpNkZEIMbUHa3hrEHB/v4QtPmiMgAY/rjjIvmAmsSSoCkUzimBwC7Eh9wXv
	lTM0Hkz7YDYNHrNzLKQuclw==
X-Google-Smtp-Source: AGHT+IE08HRwi5zEAOrxjSmh0hF4NwG0alA2vND812imDj4F+QH8VbA/puyLUNVeEErub3tHh6+9Jw==
X-Received: by 2002:a05:6512:118a:b0:549:5b54:2c77 with SMTP id 2adb3069b0e04-54990eaa9e3mr941912e87.32.1741345716393;
        Fri, 07 Mar 2025 03:08:36 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:35 -0800 (PST)
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
Subject: [PATCH v13 1/7] rust: error: Add EOVERFLOW
Date: Fri,  7 Mar 2025 13:06:18 +0200
Message-ID: <20250307110821.1703422-2-abdiel.janulgue@gmail.com>
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
index f6ecf09cb65f..1e510181432c 100644
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



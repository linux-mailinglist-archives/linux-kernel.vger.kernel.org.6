Return-Path: <linux-kernel+bounces-221968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDD790FB34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409FF1F21E1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7D1BDD0;
	Thu, 20 Jun 2024 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPIpjJ1o"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292A1E52C;
	Thu, 20 Jun 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849494; cv=none; b=oLHd+0oky8KkCNqe/4SrbsispcvFD1+ckqfOVRx30hQhoahVwX02RccEllxOBDSu2xPpyKayHGWpkh/SNL4ybQJG/R1TBWNrddHrl38goa+QPkiU2lJRnPm2ugsNaoF/8BhOZV9wmTSh+NNldzXEH8MF3X6/qRN8vyR9YS+ssnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849494; c=relaxed/simple;
	bh=SD8ucd+MXkgHO1mi9Q5tKHqe/lqz4JzlnaVxoHbJ6nU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hsCNzk3Bk00dUFwiZGn1JUfwhGdovJYwot8dS87Ya/WXjfvM8Kunj1VxBuR+LDnlcqovmeT7La8QZDyqMIa+UcPXb4X/euitNK4aXys9XbCRdYiShMY9yTsMuZiwB00dk6Rp1yEEWyZPwNi+xq08Dhri5aTP9nKI6MzUnWIsSUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPIpjJ1o; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44051a92f37so3138111cf.1;
        Wed, 19 Jun 2024 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718849492; x=1719454292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u72mufYqsXAdwuNuoR1mFE6e256FLqvci5j+lxdHW1s=;
        b=OPIpjJ1odINvRaoFdjQ6oxkmTkwwCvZoZHzN6RUjDMDDjx1Yox/X/r3nMX35Aasd8P
         S/a2uATSXgqdC1o3h9jHaGuOlYYMixmnzFk9go4yCdKGhH71RRMQz2+sw3UiYboone6k
         E/9bZNbVHLoyWTD++OmdM8/IClbPsT3dOCjZND7isecgtnjwpy8K7phLD3d8dF7sbA3r
         LySd5pN2p38fEBP7h7rfU1vZ+BEXeH9ADj/VUxo3UVJPqRJnTXCLNXqEQHKCMEdN5oxg
         fWz5fPwAjHuqCnksNNPgrXF+31tSpRAYpD63ZYAsCVdgIK69kIfbrofzdNEroSk+uB1+
         lpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718849492; x=1719454292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u72mufYqsXAdwuNuoR1mFE6e256FLqvci5j+lxdHW1s=;
        b=Q+PqyE5d5VyrB+Eg6dn/SLLL4wHAtwJviKIbVXXFJL61S0LUpnFrY4rPtCGWbK/ZZF
         8rDS+GtUNW9dM9CnOM3GWKjt0VcRBgN2CdPjmlLAnXIbEbOTu1JXaT8jPJ2YrpkOBl7u
         v3U2t9cW+MjAeKz8SHILOfz/cexpARCps+qdiKWeqmdf4LejGJfXO2KJ8Bm3DFg+5uvH
         jBfEuT12DcA6peGFjqx3eySSBVIImZY4r9M7vefhlo9Zg0lTiNmLiM9lnNbpj/e/BBPY
         W3BVth9nZqE+m7sOkYPactzCVJ+W+nB+dI9u/A34H4CCIqx8hlVToHCSEb1nJhPHRMQl
         zMqA==
X-Forwarded-Encrypted: i=1; AJvYcCVd5axLqE4dzODXAfrKb91lwQq2pk5SEmU55FGhQYg+2RcoNPBDwZN4zSDECSnA7Gck67/HRznlqbAYfcax2Oo+SByXspYxIXaMTxa8QgRO0WKNeqEC+f0+dBqv89I9Fj2QJp9fM0vNr05cOJI=
X-Gm-Message-State: AOJu0YxTnmdXGvWEsOoG3BjNkydl6dPr/I8HoIS1BQQ5Yr7JgKZlXW2B
	+RUPyH7ZuPW/r3v7JIGEA7BvE7pCiVMPRw04QaZRTFGx65NvXxL+
X-Google-Smtp-Source: AGHT+IEC3jcCwWYsRs5yILOo9txSrc9aSgJsUwCvA64HI6sYFXu26Zu9bWF1QXabZjmtq5DgWg37uA==
X-Received: by 2002:ac8:4814:0:b0:444:acc9:bf43 with SMTP id d75a77b69052e-444acc9e906mr37569011cf.0.1718849491692;
        Wed, 19 Jun 2024 19:11:31 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444b43507fdsm4539051cf.43.2024.06.19.19.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 19:11:31 -0700 (PDT)
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@redhat.com>,
	"Ethan D. Twardy" <ethan.twardy@gmail.com>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rust: alloc: Fix unused import warning
Date: Wed, 19 Jun 2024 21:11:08 -0500
Message-ID: <20240620021112.136667-1-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

core::ptr is only used in code that's not compiled during test, which
causes rustc to emit the below warning while building the rusttest
target. Add a conditional attribute to match conditions at the usage
site.

warning: unused import: `core::ptr`
 --> rust/kernel/alloc/vec_ext.rs:7:5
  |
7 | use core::ptr;
  |     ^^^^^^^^^
  |
  = note: `#[warn(unused_imports)]` on by default

Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>

diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
index e9a81052728a..96d7cbff96dd 100644
--- a/rust/kernel/alloc/vec_ext.rs
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -4,6 +4,8 @@
 
 use super::{AllocError, Flags};
 use alloc::vec::Vec;
+
+#[cfg(not(any(test, testlib)))]
 use core::ptr;
 
 /// Extensions to [`Vec`].

base-commit: 39e6bf7394d852b17fb083a85fee5890b445908c
-- 
2.44.2



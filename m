Return-Path: <linux-kernel+bounces-569068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD374A69E23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDD8483361
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365222066C8;
	Thu, 20 Mar 2025 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="gH5e1A7t"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117F1EFF8C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436563; cv=none; b=Y9lLlm12y9bO5gAx1j6wp9+sNkY9ItoQUyM1qmd2jYmHM7seLHsyH1Lm1JtuGbmOS/BELybv6fxyKduZ4vpcOQZYHqUB8Am5C0wUG6O3H2hnySJnnjZznW6fILxzIvaYj+N6M5tnzNljY/3Lm0c+4CHU7YCv3NAfzxFUWEG2jNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436563; c=relaxed/simple;
	bh=27vSvks/MWT9LOaf4f0uieR/vssi1EPq3DwLBLqpY44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpG0owhalAoq5BohVKuloTyJvlDz9SRiPgf3rHFoVJ7Ncg71spximkTXi0fPuaNsq/0nRoayxUrEbuWVrlraDmQLTPySHhj65krzV9aGBfasBIS6ozjRKqvg09+1ozJtHZZ+r92vHpeg41z0F1EUZzjA+Mo3Odny97XV9kLUIhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=gH5e1A7t; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46ebe19368so214257276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436561; x=1743041361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2ozZKg9M4M1eGcQzNOsTQiUzk0UhLzJxxv/goq0eN0=;
        b=gH5e1A7tCR8TiJQPJDwvojeh1QDJZkxHjPV5MxC2XkeDK/HrXfBm2EmKr8TSlhyAuR
         QoJIzlsN4F09pl978oKpapjzM7lXxhSOgA4RnNoNnKfws5qLXohtLIZKFsZj8/5Y7tzP
         oTVtMxUibUixN+wEA9XIQRCaByToDvr+HPvUbFqZosfvCrk3jLdwVImChHSAw9S/p8LN
         pPLPmXRjn67bjQiZPeyrHi1E3fwatl6BXec5VuQfSYHuCnYObIHtKOTucinEtS5a0Gh0
         tPtghxfTKCXA6nF0RObHMugc0tUp8ziAvjUxJFrUFZMlviX/blXJ+abYorFR8r7vXXeQ
         sTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436561; x=1743041361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2ozZKg9M4M1eGcQzNOsTQiUzk0UhLzJxxv/goq0eN0=;
        b=gnHfFejABi0Aq8p0537DFjOLMH23Bp3gq1HztMNeQqI892hXYJRIFlmBdWJ6gs+gWm
         6h7Zeu3b9JGJVP9U+XlrQ06P6a7wC5Bwm6iqx29IbT2GNY6ymi2edrkMXAcBZvUKAdE/
         MWaXRGwtfJIr/LP1cLxVFYcyEx3rASJD/xN/Hu5+P0Cao9F6mkUgdjU7qnMjpkkRtrgM
         Ac+L8ecDiI2zvj9B6iNywSYCMUCOGCFyFAfSK+RwL0cqXwknm+2AjP5N83cwqh/Gblee
         E3amqHsPJ4WhKKsDuzX+B9EKTa8i5uP4rzeu5FL7hv6qofuCLBl+bN63SYGLxZRkaBoC
         48HA==
X-Forwarded-Encrypted: i=1; AJvYcCWX7Sg2omjfKZ5xE+8sC6XWK1h9GRvN5toQNPXiq4si4WQRlPahpIMQY3nOYCdcNeD2xXb/uLpUU5NssNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuXyJzXybB0oiTnbD4AYWv/UR2BxVyL+2mbGX7Wzb0E2WOKF1
	7KiZAsS+G8+JLzJZGM7Eeq+eE4zxDl7FFoKfLOyIFyGx6DvMgIBzkLVppf6zsgg=
X-Gm-Gg: ASbGncvue2Sj1UXQDZfo8dqJdGXlxRNqBHWX1RNpgt0j6cx4eFUReVB2frv7b8aErfp
	Oj3VT4Rmb3s4YQNXOPZsFCcvGL/zjDSM3enOLpm70zx4gZgCsls88CYQDwqoE20T2FogEZn9Hwz
	vKg0Uvkta8rmpwUSNnCJ3aI2l/ZipwElqqUdISrIo/ZUpmlUhD/PBMeZ1YbQUxp1l7fFVZ5okRG
	UazWNctlYQX3DYZKHZZa7PHn08LiwZPr68kI7G5donOro0hpbxiXNxah6N5rdVwFH1lCmACiE5i
	dQdn3N0xyZ7GY5bzdo6NoCVO4/gS00SlQibaAWBie7xsaWxfpdfFhu5MGrYT304VPbfJwuI0H5f
	Ln9GDst8yfWgnljfYULhk4TKNsIJgwg==
X-Google-Smtp-Source: AGHT+IH7EZ6+8+dCz4bP1LLN56y09OfGCvVT4d8nVrS+w4XXeQExgC4rwOB6o+v3CUWV78wi4AnUCg==
X-Received: by 2002:a05:690c:6e05:b0:6fd:63e9:a441 with SMTP id 00721157ae682-7009c02dc9bmr72055117b3.28.1742436561071;
        Wed, 19 Mar 2025 19:09:21 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:09:20 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/17] rust: clippy: disallow `addr_of[_mut]!` macros
Date: Wed, 19 Mar 2025 22:07:36 -0400
Message-ID: <20250320020740.1631171-18-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the `raw_ref_op` feature enabled we no longer want to
allow use of the `addr_of!` and `addr_of_mut!` macros.

We instead want to use `&raw const` and `&raw mut` to get raw
pointers to a place.

Note that this lint isn't currently reliable, but we enable
it nevertheless because:
1. Document that one shouldn't use the `addr_of[_mut]!` macros.
2. When the lint becomes useful we will already have it enabled.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Link: https://github.com/rust-lang/rust-clippy/issues/11431
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 .clippy.toml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clippy.toml b/.clippy.toml
index 815c94732ed7..b7d87377a468 100644
--- a/.clippy.toml
+++ b/.clippy.toml
@@ -8,4 +8,8 @@ disallowed-macros = [
     # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we simulate
     # it here, see: https://github.com/rust-lang/rust-clippy/issues/11303.
     { path = "kernel::dbg", reason = "the `dbg!` macro is intended as a debugging tool" },
+    # With `raw_ref_op` feature enabled we no longer want to allow use of `addr_of!`
+    # and `addr_of_mut!` macros, but instead suggest use of `&raw const` or `&raw mut`.
+    { path = "core::ptr::addr_of_mut", reason = "use `&raw mut` instead `addr_of_mut!`" },
+    { path = "core::ptr::addr_of", reason = "use `&raw const` instead `addr_of!`" },
 ]



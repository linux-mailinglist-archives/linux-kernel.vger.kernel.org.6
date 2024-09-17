Return-Path: <linux-kernel+bounces-331219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A19997A9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 02:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31841F26AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AF1B85F2;
	Tue, 17 Sep 2024 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv1otZER"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB75672
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726531873; cv=none; b=KVZKOc+Zg0aNe3X3nMaszpfCS8wbEQkAaAPh28XFROJxckezXUR+PVx84KpmuJYVrRvtU+I1gEMQOITM6g9TUVDLUPb/+eVR55UPjAkye56cFgHlFOEs4cc7u+6O1aneHH3tia1I/Jo8gCPmIFCzDpdmfo/VRfGGoeKv4jxrqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726531873; c=relaxed/simple;
	bh=W56FUMR9QIT0LTtxeEn0yFfK/pN99UsZE7+uyX1M+rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4PbqfanWSYpjJ37Y79zEyFgygwaYMODZq7tx+4rlTuUkhQfGxZZn4IL4svT3CIoFx1rSloLBOexMaALHkCLJ3l3GBzkSQS1Q2zrjRBAIz7WARTEGzjsh+RHXLpgGfFrlrqV2rdJZDwrNohWwFK0wAfe4uOdOS20NRT86mlnwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sv1otZER; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726531871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3XRknCuZ+rddMbA9raqM8xFOQmhedysMspZNVnmtig=;
	b=Sv1otZERWjluYopxq+IslkUcao0waGxZmfP25Pqg72zBMsvDiFclMD1VFzCeV6s2zSuyM3
	iqm7feOgamVde8SVGVYYw3GNTQCbvW6uasGq6XBkKR6lpBISE4Bv1SvAIqzre08EpCDctO
	3jU1etsECNVFAhpFWeX3nZJD/pstYV8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-cucXlW7lOtm45N_ajUKMFw-1; Mon, 16 Sep 2024 20:11:09 -0400
X-MC-Unique: cucXlW7lOtm45N_ajUKMFw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c5a32ec343so23583586d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726531869; x=1727136669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3XRknCuZ+rddMbA9raqM8xFOQmhedysMspZNVnmtig=;
        b=VOxVrj8CEQ7qi/jmtC2/Dugfyr0HzF76BGkKTr4uWvaH1TBhQ0grZU682BDquuz8nk
         MxBZDMJhrjQoXG30yrh46fhZrvYy3sVuJ70zQUyXumpUfe2c8RapaB4o+3XhJuf2yZyG
         9N4Len/xbmQlvIcfWZ+Og+UxwL8edduHvL4a4NNsQAc3HxaC65Cec5Biu4kGlmkJ3D7Z
         z3CVmGYcgJJAvHkPC+1ejArx4+4ghKoxtsYY5q4zAztfCbpgEhwviQJyjBjhhjlIJ/tZ
         iQQX8dZoTq1zSCRhq/tDNLlp0oqVxVsZP7mlYIBrfyD/Ur6VJFG3SnltpZ7Tk4fKYTjZ
         r3LA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ/+5eVMEbfDlQRZaso99cK1WeR7YqmTA5i+TX22gQTQSoFTmnPGnbac04YcU3Vodmjef9vyALynkML2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrYlBDdibI5LEWYkXFljejlHNn5PasghqMrFPBXahcCj1JCGu+
	rWm5AQB674Eyv9AKlefjjYKbRIf9gGb1d04np/G5EXQAZEy7wA0nVIQkZE5QbcsW23RiWPj5V9D
	Jx7awL39JNLzE114SrMKRCX/TVDj17nIBIkWDgIeBP1TL9w9JohpidtOKJNAIKA==
X-Received: by 2002:a05:6214:311a:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6c57350b986mr276808286d6.10.1726531868922;
        Mon, 16 Sep 2024 17:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHnGglfemeo+Af3oezjiRWKnnZJZ0HiOz3D898c3WHVJObvGXlST1AzNl9ohW/gu5HlG6/gw==
X-Received: by 2002:a05:6214:311a:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6c57350b986mr276807636d6.10.1726531868420;
        Mon, 16 Sep 2024 17:11:08 -0700 (PDT)
Received: from towerofpower.montleon.net (syn-066-026-073-226.res.spectrum.com. [66.26.73.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c62633bsm29221956d6.25.2024.09.16.17.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 17:11:07 -0700 (PDT)
From: Jason Montleon <jmontleo@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Jason Montleon <jmontleo@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] RISC-V: Fix building rust when using GCC toolchain
Date: Mon, 16 Sep 2024 20:08:48 -0400
Message-ID: <20240917000848.720765-2-jmontleo@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917000848.720765-1-jmontleo@redhat.com>
References: <20240917000848.720765-1-jmontleo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang does not support '-mno-riscv-attribute' resulting in the error
error: unknown argument: '-mno-riscv-attribute'

Not setting BINDGEN_TARGET_riscv results in the in the error
error: unsupported argument 'medany' to option '-mcmodel=' for target \
'unknown'
error: unknown target triple 'unknown'

Signed-off-by: Jason Montleon <jmontleo@redhat.com>
Cc: stable@vger.kernel.org
---
 rust/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index f168d2c98a15..73eceaaae61e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -228,11 +228,12 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
-	--param=% --param asan-%
+	--param=% --param asan-% -mno-riscv-attribute
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
+BINDGEN_TARGET_riscv	:= riscv64-linux-gnu
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
 # All warnings are inhibited since GCC builds are very experimental,

base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8
-- 
2.46.0



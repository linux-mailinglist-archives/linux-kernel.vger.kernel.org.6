Return-Path: <linux-kernel+bounces-205595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155EC8FFDF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F38C283D72
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB2D15B0E2;
	Fri,  7 Jun 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gp/EqZVB"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AF15ADBD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748627; cv=none; b=o7j3thK/PWqf33SRaSSYvovFdczj7EGMdGWEN6JTINjdlLg3+aC5mQ8ubhgVRa0Jo3vnB9HbALd+zHLSpbNfHnG1jZNnn2HQ64kB4xxCAMQ2FIfUWPIhg2ibpB8ZsAGDrRrrJn7s1nJOozigx8QPBvymiwa7D2u42Muw1hGMXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748627; c=relaxed/simple;
	bh=Xgwy+VXx5E3JZbP4Ybw+wTF/Dg2wgJSpewPSloTt8eQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NoUZxbh5Ixr46PVhUMRE5rCo2y6Cs5kCtF/Yi8nma/e6aP/Ku0d6lFSTzHcB0b8e1c2DQYTzk89p7SusxoJIW23uiq0k5uW4ZqDBApARHUD3CXLP/rfNJZBF5F9b9XmWoqluoPPDrF+YbRu1NisnuKE54mpfVMCf887rq3Np2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gp/EqZVB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa78a1b142so3244637276.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717748625; x=1718353425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jFzDLAm2JoetzCIq+IZooWSo9+/OTnrDCeqgi9Uf1Qw=;
        b=Gp/EqZVBAwQU/FP8j2ygb08OWyI7m6v3xhkUSXQ/y6g6BXng7yl9da3U14aZd66aSi
         ednzH3E6eRHPipL+4x9DNAhscBgVJMfCf8IDWjjNC5eee/KdO99HUWjuOfInVR+i7NHY
         0m8R1JO8z/5Uumf4Zdv6bPcY1AuyN/uaKGdP+1vGxepJg364FmGWPCAxCPDsJYlfMKIG
         sk1COkb6qzGETOMuahdazmLj69tjhgKqaXQRjDCX+lj/u0Q4PkqFCsQakg0Ww7MPvkNx
         WZ4m/eiJds79teQDqLHUIbYPxL04JGQKoVeDmih/M8yAxzNAoW6WA7afGFlMOTSKwS6n
         s+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717748625; x=1718353425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jFzDLAm2JoetzCIq+IZooWSo9+/OTnrDCeqgi9Uf1Qw=;
        b=CgNjd/PmJgS3bYOMYZiCTopRX+ePdB2/ecK08J0+5D+nbpmX0qti2cgfLyeF3NLQh9
         v2d/quNyZBBQ9E7f2K/9mQtdz13TiX/jQk4B90/Bd26UMAdCrf2dp7RSwyskFeuWZh6U
         WdNm+WW0Sta2o4ZGe148Q7eXOyKlnu8pl+Qk2+q/9J4k9ZoeP//WozAe7i7GLd9mzpFC
         hKt1WCcPheTzxZKFKfsDagboRU0hqd9wdpPMvr1yILZVeTxjsPP1YFlNhQV9j8dVZZYx
         yvHlmNIGDYzYwd+qN4p/Cb/OKLHuih6VJLL+n2tBDoLthRpn4Su42rVvnezzU3KSE1QQ
         m5Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWCAL7zruwv4UrJ/pifRJGlct/9nCAH5oCn10kDFRU1CafvD+7CPahVY5KmEmxcBrClD77QWK/JHfrb+zOBICME+92DA8H2nixcX81X
X-Gm-Message-State: AOJu0Yzl6Re6Sp8nsTkgQMoxYj/Hdtte+sUlsVoiu2KuYZd4qj7SJ8T0
	UF+mrSiZaOAOSeu15QQjAsKdroDDEOjvPDyF3LoQsXoHwtMhxwfWxLZA3l7KtnZSg1f7j863dn+
	jcoEJypg2Vcklng==
X-Google-Smtp-Source: AGHT+IEF7CwqKNpySd+6AuoFJi32vnnmAET+ZclCVOtY5J7qFDRYXcocHOA7xl/OSLW2UDLxrIJKMjnMqQ92lHY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:6b08:0:b0:dfa:59bc:8867 with SMTP id
 3f1490d57ef6-dfaf64d3340mr115964276.5.1717748624990; Fri, 07 Jun 2024
 01:23:44 -0700 (PDT)
Date: Fri, 07 Jun 2024 08:23:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIzDYmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0Nz3YzM9Izc1FzdlKTElBRDU8ukVENDJaDqgqLUtMwKsEnRsbW1ABY H8rlZAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2472; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Xgwy+VXx5E3JZbP4Ybw+wTF/Dg2wgJSpewPSloTt8eQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmYsONk+jvByYL2TvCtGEpw2mG1FeLXT5tMEqGf
 QENb1/iRbmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmLDjQAKCRAEWL7uWMY5
 Rtg5D/97pMiTip/qY8xClBaqwr63gv3MaEt8Te2hgLcwePAMnxTBOxvv7XkJAggvpaPBODWZyX5
 k049GAOcgQykCCJI7lcBbnlCJcUgCiCqdvhx4+uSKHtlu2KqqkWvE7aadk9mtSK1LKEqWKzgw64
 O+G/8qQ1/MuKgZq7UdXAS+W087EfyC2Vcy0md0dCvMBMPVS04ujRsvQsugtUswaomEh6/Y5dbIR
 CM/gobk6d+WYYyXfWuxWOA0Lahb/YcCndsQdlAYw4T+GRiOjvrNuewH7OFnQneS89yQGrvSOT90
 twfceUV3O65lVsZI0EDrctFXv2U5iHgc1EJd1+ccoM8+MFOYoRuHgvJugMysWCJvuGZZGQq6tL5
 9SYegBtv/YY0tDovG9l/XzBxbe0aTXwofemBpHJuH68g6B8INU2eTtl+ZPLMHY9u1Enw04xnnyW
 W55EPhsp1NDsYV5MVDi+RGq8YYNa1FdUfWeY/bjwLIJdzI9O02LuzZlAFAdEJ4+g14p9wb5ZIqz
 +Mcm2UIbJ/n6wBEk7teLnGTMlr0FcMFsyZTuZ0w/N/GMuoVn35L6vYWltCgRj+N03venG14qMS6
 X2Htqv9BIwEe431MxLTlmrJmzFvO+gELPdL2jzLRgCvh2f3O0iuR63qjN0dRs7bEvjntlDT0l4S NhuJ8H3zSx1Z/6Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240607-highmem-v1-1-d18c5ca4072f@google.com>
Subject: [PATCH] rust: alloc: add __GFP_HIGHMEM flag
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Make it possible to allocate memory that doesn't need to mapped into the
kernel's address space. This flag is useful together with
Page::alloc_page [1].

Rust Binder needs this for the memory that holds incoming transactions
for each process. Each process will have a few megabytes of memory
allocated with this flag, which is mapped into the process using
vm_insert_page. When the kernel copies data for an incoming transaction
into a process's memory region, it will use kmap_local_page to
temporarily map pages that are being modified. There is no need for them
to take up address space in the kernel when the kernel is not writing an
incoming transaction into the page.

Link: https://lore.kernel.org/all/20240528-alice-mm-v7-4-78222c31b8f4@google.com/ [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/alloc.rs            | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..52a1412338ef 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -25,3 +25,4 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
+const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 531b5e471cb1..f2994aea5d8e 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -52,6 +52,14 @@ pub mod flags {
     /// This is normally or'd with other flags.
     pub const __GFP_ZERO: Flags = Flags(bindings::__GFP_ZERO);
 
+    /// Allow the allocation to be in high memory.
+    ///
+    /// Allocations in high memory may not be mapped into the kernel's address space, so this can't
+    /// be used with `kmalloc` and other similar methods.
+    ///
+    /// This is normally or'd with other flags.
+    pub const __GFP_HIGHMEM: Flags = Flags(bindings::__GFP_HIGHMEM);
+
     /// Users can not sleep and need the allocation to succeed.
     ///
     /// A lower watermark is applied to allow access to "atomic reserves". The current

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240417-highmem-dbadd159be11

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>



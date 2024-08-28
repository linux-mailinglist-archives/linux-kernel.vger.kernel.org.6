Return-Path: <linux-kernel+bounces-305474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E930A962F45
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BE01F2252F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2841AAE10;
	Wed, 28 Aug 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgxCrwJx"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956181A7067;
	Wed, 28 Aug 2024 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868123; cv=none; b=pdF8MVxvplfCNviEf5CONbYT/7ntvXOaE+xteefTHro9QrmfaB8crkw9/zA6q3AVZTK5UArNeKgbo2PqxpV/uTRQWDUyQjZY235LS/rlEtPomcQ4Q0gCpdbu+nWZK4TohSyL1gTWZ4M3LQvMW3vZFb8QnghB7Wogw8HbnTyH7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868123; c=relaxed/simple;
	bh=wCEraXtt3CtNf0yLZCe+VwVDczzOo3RFhCzAD51xT8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUtqdlxzQUfKRNd9VoxWye5WLYlz+nXu7qK3F3154San5NK2UIDeshTbijlQ2U8/ELMonBq8R8155KIO21Hbges4uaQDgRNP8yQNTQeJpMEujUMvn5KONxGY+GfYhHOXO9Tb7OTidwZwXXR7HbQCiYhifoKPrXP6mVueir9WaSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgxCrwJx; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf705959f1so8993746d6.1;
        Wed, 28 Aug 2024 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868120; x=1725472920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=54WDneH5aK9PrcJyxN7n5h0O+70QCL7ZSw0Q0gtHZVQ=;
        b=RgxCrwJxI/4ZaD74VTqiDIXpYOMNQSRUPrQdDKov5kgLgY/SkqtKvUkFApLN54HHqH
         pPgFmQoujhU2OWUWSh9jCvG1WeUD9LutQRr8/CkAhTPWwyQXve0px0IZ0HZlt6LE+Im1
         4SD97ycA6+xY0Nw0uuQhNta0CzrBLVuinQ5fOhI1xIONp3pgeub/bfT97FnCORHdUrG8
         0iCzUkslIqsmwObQtCxWA2qH1/iviwYMBQ4HseAIiTIKbJrm9Au199YfsxxrrCZMvMaF
         GIFFlPxaQ2EdMfPlo15EpBue6k55jiNN139jKreUk6MTalkAHDI4b5Oj03GEDqUlEXvA
         7IFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868120; x=1725472920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54WDneH5aK9PrcJyxN7n5h0O+70QCL7ZSw0Q0gtHZVQ=;
        b=gyr8Bgz3i5TkB0+GUpg1uLJs2DJfUkQw60vKx3Lh0qmBhJu67YRqKwpjweuL/9J5Iy
         7wb0uF6yXrHx0LVe7s8++oatFRivnDBzJX/hm6DeDR8k7wcnJgvrgaE1pl/fadF7crzD
         sgh+e0lVHlCI0xbLouAOIvaQgLLeuN6seOxCIafSKSF3FWWpGnlWf/+XtYF2HTMfmI5q
         ShgNomGQgfhdcLZugQHnhXHZq8tAsiTJ81stzQMFm9SxdUkveFP87cq5VidZei46s2DI
         8WuBFlR9QvoQJFB281R6DkjWGJygOCHxQx5i7xyisOtXBu/n2ziElQA93Vb2xkiKoh8E
         x/FA==
X-Forwarded-Encrypted: i=1; AJvYcCWQmuSAp92N2CSU6Q0p4nUixBr5uNoy3y/4I7lfmV1w83quQy+Cs4vNw1dUFTUM8eD+bGVNGuCo6TnJj5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfuFgGhABxgbgtjjBVmk4zxURlxLVdY8Nl80e68P7C488AeSo
	4mXqfRL2XJFkxZsm9oL7lrTKk5+xS1l/2lIogJD39SiKZDW4cDJv
X-Google-Smtp-Source: AGHT+IF6KFSL7WK8Q8kMdEVQM7ZBZvcCB/Hsm7d0+iaMLXt4IZg/8vJ6Oj0GBa+uttL89AXNnzmNww==
X-Received: by 2002:a05:6214:4304:b0:6c1:80d3:8d2b with SMTP id 6a1803df08f44-6c33e3fb944mr7355766d6.18.1724868119993;
        Wed, 28 Aug 2024 11:01:59 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d242sm67879766d6.16.2024.08.28.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:01:59 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 1AA7A1200068;
	Wed, 28 Aug 2024 14:01:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 Aug 2024 14:01:59 -0400
X-ME-Sender: <xms:FmbPZpi1Oat4QMoTQmLRsZXFvfm_WFlCeL70LEkihIIMOQS3sdN8kQ>
    <xme:FmbPZuD9zkBHuL0aH7caioVLXWh_rd_YSxIEjiqtHpFbU-372hbAVLGj0dI5PxFM6
    09ucXOsKM6m9x18AQ>
X-ME-Received: <xmr:FmbPZpGwGdKbuJyPW8XVH1Vh4j2J98ja5BRldtWTZMufALDNstjupzHWfJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgfetfffhheejgedtudeiffduteefhefggedujedu
    hfeifefgiefgveeuudeludffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphht
    thhopeifvggushhonhgrfhesghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrd
    hfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:FmbPZuTfIVLKHGZtwjtHODwWwCwHRxWycFDbhWEHVmhx9YgW58Xb_Q>
    <xmx:FmbPZmzwBsK7nrV_BSYOyvdSAH8YdBbz-0isuahc24knNqKkbXCqwQ>
    <xmx:FmbPZk4CbKXVRcXrwRCaAnaI0mrT3qolVN4eRpipHzmrabL7VeIbJA>
    <xmx:FmbPZryglK_bCv9rNdC-eo-uVMGIWI-bn8OrhllIqmI52ez25A424w>
    <xmx:FmbPZugksohC1kBUKKDQnDqQrwDOD8cEyMGH9N7X6mBccL3zdF6ybznw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 14:01:58 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: [RFC PATCH] rust: Provide correct provenance when constructing THIS_MODULE
Date: Wed, 28 Aug 2024 11:01:29 -0700
Message-ID: <20240828180129.4046355-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently while defining `THIS_MODULE` symbol in `module!()`, the
pointer used to contruct `ThisModule` is derived from an immutable
reference of `__this_module`, which means the pointer doesn't have
the provenance for writting, and that means any write to that pointer
is UB regardless of data races or not. However, the usage of
`THIS_MODULE` includes passing this pointer to functions that may write
to it (probably in unsafe code), and this will create soundness issues.

One way to fix this is using `addr_of_mut!()` but that requires the
unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
an extern static `Opaque` is used here: since `Opaque<T>` is transparent
to `T`, an extern static `Opaque` will just wrap the C symbol (defined
in a C compile unit) in an `Opaque`, which provides a pointer with
writable provenance via `Opaque::get()`. This fix the potential UBs
because of pointer provenance unmatched.

Reported-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/macros/module.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 571ffa2e189c..aef3b132f32b 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -217,7 +217,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             // freed until the module is unloaded.
             #[cfg(MODULE)]
             static THIS_MODULE: kernel::ThisModule = unsafe {{
-                kernel::ThisModule::from_ptr(&kernel::bindings::__this_module as *const _ as *mut _)
+                extern \"C\" {{
+                    static __this_module: kernel::types::Opaque<kernel::bindings::module>;
+                }}
+
+                kernel::ThisModule::from_ptr(__this_module.get())
             }};
             #[cfg(not(MODULE))]
             static THIS_MODULE: kernel::ThisModule = unsafe {{
-- 
2.45.2



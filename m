Return-Path: <linux-kernel+bounces-399229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 089769BFC59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B974A288CA3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0E18039;
	Thu,  7 Nov 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbdUEZsE"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BF17543;
	Thu,  7 Nov 2024 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945323; cv=none; b=tFy9VYZ6nY9U4Y04z2LSk9l2Op5R5qplWBQfLWN9x8a2af+k9hWn0G+NSnxQeojAAnnaiKqkhNrCZLVGgkwUJDaBH0qPogH++DlcnPQ5TwqqbHCBSiMGcj33+2xV8m5pTjyIPz35+J8J+EjmfMu9BlHqRUe0rLI6E1EQeEiJKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945323; c=relaxed/simple;
	bh=eKe+f4LZFe3OuR6c2Utbe+jqby1mM22HqL1RD9tKyVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UuSBua6PjG9cHkUoilmnYDIxXvDqPcUYloHI8A7plvtV16tcMuZnQaQuvcTlgEbEIWGrAlc5YoyQzIhon25VUbIvx7jjKKJcwmySkIBSCNTSrb9fmKv0IpFli8y/pdCSuT+jUr/VyJzCY97lwGZkIvPKngvSGMcJ1n9CW1QAktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbdUEZsE; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8de14848so350639a12.2;
        Wed, 06 Nov 2024 18:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945321; x=1731550121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPjHlId0uyQw9OURqHh1PA2htdOUV/LJvhLM1w7edWA=;
        b=RbdUEZsEJfw8OI09djsSQngHfZU6aZMHmmS4XX7NV68xYdqAf6YO+fxqs2ie6Co60v
         X+ei/S7eVDV44YTWFP1otLjjTM7UFmXrUzNR+61ZrFYdMj+8LCZ02Bp+BDBzbb8LYyHu
         87FCyQV0ykk7AikcuV6lvmRfjL7bBlxhjEQKrqjHop2GRZ5CkbPx3q4F+KKILanuCYZK
         yjmvVefXLXcwJE+DVJ+ZXb9zM5z3GDMN1t0jf8sTbHapQYKjSbSMZ9OUWlLAb/KMZru+
         hDoUCn1CoFnQqKX6d7kmTTx/XFKi4zuXpQvKmx9MSGBgee6OYxEW/CJ1BvLR2Yj67yge
         uu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945321; x=1731550121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPjHlId0uyQw9OURqHh1PA2htdOUV/LJvhLM1w7edWA=;
        b=rp5fsqmuhOuDDXviqt033zNnLQy4EmpBI8v1d1pbgXIaHoXWQDTJO02fiMqKPxFp+2
         vpVq8coZ7wwi0fveOxCHbpO9YQDpZwG9is0E9pWAUmgJIF7YkKnwrtH6AnGjO8JyKn/u
         8/5Wxv2C/U+BqQV8S2dmPtJFA737mJRPyru+8SXsIeX+JwMdzR8o9P3y4ikEQYluw+BB
         3gxos/B6MsO8B5PPdw3xDjt3pEVfNBP7zGgtl0it/WA9ZEh5pV4fIwiTRlP1wvWFQwFd
         U0l75gTwTRNs54xZ/QUWLegcN5BdLwmX+ttHJekBkcut1tNaesCOi7e9D2bBcqF4gg0L
         +0TA==
X-Forwarded-Encrypted: i=1; AJvYcCV6OaNCduhDuhJNHUpBQc5b/K87KS4aKfDprMdeSs2NJie5C3OP2tjHDbpUNf242nDHE9I/AmY2bGER7hGMX0E=@vger.kernel.org, AJvYcCXjPPh6HjfUX3OA4uDvPWNX+7rkT+bfvEWxQMpVUWIuTLJaI5/6tp7G+dXG683Vr8ZLkk1e1ruVvL46WHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxKDDtQD+2NlMYw4CclrEbfMv+PVfDP2x5FhkjiBA+ix3aWpIx
	RI9onuQ0kzB05bJvjfZGxFgceBFXzMHvhQXRf5jmchyuWXeNHhyW
X-Google-Smtp-Source: AGHT+IGgjJjumWPR6joaiukcrNiDoySbjcTkhpP/INyzhzU8CO09ocpI7zrqIpcOduO8MAFjAWvu2A==
X-Received: by 2002:a05:6a20:3d87:b0:1db:ff5a:23e5 with SMTP id adf61e73a8af0-1dc12886ffbmr744303637.4.1730945320503;
        Wed, 06 Nov 2024 18:08:40 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:08:39 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	me@kloenk.dev,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: alistair23@gmail.com
Subject: [PATCH 00/13] rust: bindings: Auto-generate inline static functions
Date: Thu,  7 Nov 2024 12:08:18 +1000
Message-ID: <20241107020831.1561063-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The kernel includes a large number of static inline functions that are
defined in header files. One example is the crypto_shash_descsize()
function which is defined in hash.h as

```
static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm)
{
        return tfm->descsize;
}
```

bindgen is currently unable to generate bindings to these functions as
they are not publically exposed (they are static after all).

The Rust code currently uses rust_helper_* functions, such as
rust_helper_alloc_pages() for example to call the static inline
functions. But this is a hassle as someone needs to write a C helper
function.

Instead we can use the bindgen wrap-static-fns feature. The feature
is marked as experimental, but has recently been promoted to
non-experimental (dependig on your version of bindgen).

By supporting wrap-static-fns we automatically generate a C file called
extern.c that exposes the static inline functions, for example like this

```
unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) { return crypto_shash_descsize(tfm); }
```

The nice part is that this is auto-generated.

We then also get a bindings_generate_static.rs file with the Rust
binding, like this

```
extern "C" {
    #[link_name = "crypto_shash_descsize__extern"]
    pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi::c_uint;
}
```

So now we can use the static inline functions just like normal
functions.

There are a bunch of static inline functions that don't work though, because
the C compiler fails to build extern.c:
 * functions with inline asm generate "operand probably does not match constraints"
   errors (rip_rel_ptr() for example)
 * functions with bit masks (u32_encode_bits() and friends) result in
   "call to ‘__bad_mask’ declared with attribute error: bad bitfield mask"
   errors

As well as that any static inline function that calls a function that has been
kconfig-ed out will fail to link as the function being called isn't built
(mdio45_ethtool_gset_npage for example)

Due to these failures we use a allow-list system (where functions must
be manually enabled).

This series adds support for bindgen generating wrappers for inline statics and
then converts the existing helper functions to this new method. This doesn't
work for C macros, so we can't reamove all of the helper functions, but we
can remove most.

Alistair Francis (13):
  rust: bindings: Support some inline static functions
  rust: helpers: Remove blk helper
  rust: helpers: Remove build_bug helper
  rust: helpers: Remove err helper
  rust: helpers: Remove kunit helper
  rust: helpers: Remove mutex helper
  rust: helpers: Remove some page helpers
  rust: helpers: Remove rbtree helper
  rust: helpers: Remove some refcount helpers
  rust: helpers: Remove signal helper
  rust: helpers: Remove some spinlock helpers
  rust: helpers: Remove some task helpers
  rust: helpers: Remove uaccess helpers

 rust/.gitignore                 |  2 ++
 rust/Makefile                   | 36 ++++++++++++++++++++++++++++++---
 rust/bindgen_static_functions   | 31 ++++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h |  5 +++++
 rust/bindings/lib.rs            |  4 ++++
 rust/exports.c                  |  1 +
 rust/helpers/blk.c              | 14 -------------
 rust/helpers/build_bug.c        |  9 ---------
 rust/helpers/err.c              | 19 -----------------
 rust/helpers/helpers.c          | 13 ++----------
 rust/helpers/kunit.c            |  9 ---------
 rust/helpers/mutex.c            | 15 --------------
 rust/helpers/page.c             |  5 -----
 rust/helpers/rbtree.c           |  9 ---------
 rust/helpers/refcount.c         | 10 ---------
 rust/helpers/signal.c           |  9 ---------
 rust/helpers/spinlock.c         | 10 ---------
 rust/helpers/task.c             | 10 ---------
 rust/helpers/uaccess.c          | 15 --------------
 19 files changed, 78 insertions(+), 148 deletions(-)
 create mode 100644 rust/bindgen_static_functions
 delete mode 100644 rust/helpers/blk.c
 delete mode 100644 rust/helpers/build_bug.c
 delete mode 100644 rust/helpers/err.c
 delete mode 100644 rust/helpers/kunit.c
 delete mode 100644 rust/helpers/mutex.c
 delete mode 100644 rust/helpers/rbtree.c
 delete mode 100644 rust/helpers/signal.c
 delete mode 100644 rust/helpers/uaccess.c

-- 
2.47.0



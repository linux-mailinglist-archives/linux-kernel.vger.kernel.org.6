Return-Path: <linux-kernel+bounces-400955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D849C146E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30667B21CDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5C84A5B;
	Fri,  8 Nov 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3GGp7OV"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161DD528;
	Fri,  8 Nov 2024 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035424; cv=none; b=amhSdSdRPBsvvg2J6QXiueZ0DFtXOubfyPoQPFTwfWzw8ahi9k7zes0uySgb4JNLQ/Io3PeVgoccRlaSFc8gsl/OOir1Tpl0saanYGH2anhlDLBrmR9SO/uxyVieJEPnJJ/b5I6x77oETHIRD16UDkfhZzCEPLmZRHsS5tbNWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035424; c=relaxed/simple;
	bh=EYbkmSxnY44Rkfe0qp+OqBaKTMxLI0X2HMoDKXoHUTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NxMB0JVHuGsILEzK12ND3N0DFHPnucziVOmRznNrxuPnBwDMGbVgoUueDS4OFe27DXjCKYMEWzpB35An4XKI4HGCDz7G/iJctEwYeSjUjAIM6nlI/GSlWZkyppil1fpswilfZxD2jPNvyGTZzjqsuTEF7WOynjTi4SD/pnZJDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3GGp7OV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so1321328a12.1;
        Thu, 07 Nov 2024 19:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035423; x=1731640223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+x68b5KmuCGfsIw5OnC0ak/gYO/bY86A5SEAd3e+36I=;
        b=O3GGp7OV5xCm5itji2YN/LHarGLDCYjnksKt3k2u+6bMEARqTnmgn5QzGhnE5faSqx
         yaaujXmuOUF46Ik8H3Qn4E02otictPaAAFJmafxzlcswOxfFRbHYBQSa22MMkDptR79+
         NX9Edgx855bQdiQkbmdZfO6mLAlqYyK242YH7UWTgCEi+t87gkxgaQ6RyeWhQ6ozsbIj
         krKXzqV0eRA4DsGNsbcnGFvfF00NHAGOH54Iio17hJzaZXvrH5t7+ye1pUFTpFsPyLZS
         4MhavAkoKA6QvwtXuXxUV7fWHIheViLV0d+CfqenIiact/5CRTy64SRC6ASoRr8jAukT
         dC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035423; x=1731640223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+x68b5KmuCGfsIw5OnC0ak/gYO/bY86A5SEAd3e+36I=;
        b=eEQ1HxE8oLXAFTkD38IpjXxVAJylwIDjGoQejn+7Qjn3bQAwUe0bfy7y7xzhoRxsiE
         zNE3wsXgDgCA40sIuGCN72GciFp7DPPN6G/jxad5Wjy10t+yLhvmLQiXfiND7f+otd+3
         C1rNk/cAb8ytxOKuoVcTqvSv7NngemdAksZhmbEPz5sivVQ07/yuyrUZ/ZePUjN7gYkF
         qwk5w8ye0qyUNO0ryjYrJdtnf/8FaZqYLGMShHXk3VobcDnfDoL8xN1saV9sln0t+v1Y
         wdLZfZlQzmqURjo70prpR+SeFQtdSvzm9WR2C9w9UI2ca/LnbgmluzWPlQsODgTOT6k3
         LE0A==
X-Forwarded-Encrypted: i=1; AJvYcCVV75Fv4KFT4WVtoIO1f3Agoxbb8FKHuYarZ5KI6VtE9pILDVOb7x6UMiLqDvV+LNZorqP3J8fY3cJxnNp4QZM=@vger.kernel.org, AJvYcCXT2npqdkhv7EYtzt+k2SZg5lCmA1IGma5xo1bmcH1VObOzPe83+aM/jJZfRYZo2mj8Z++7K/GQdx8GH8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRuOLGpAV58RnDkZ1OYU8BDAqlPGgSXI8p/1MzcTwge8BWHqGT
	JoS9RW7n7GAP8ejkmApMI/uUiA5zjWPC0A74lGTYYi1pPa6G5DNO
X-Google-Smtp-Source: AGHT+IFT2i2HfavjJNcmk4rVc1fXvDRTrWKTCkqzUN8lKQsQiSeKbCMShI2iCCk+ioxZp3TtOwjysQ==
X-Received: by 2002:a05:6a21:3290:b0:1db:e358:48a8 with SMTP id adf61e73a8af0-1dc228eed6amr1977281637.10.1731035422607;
        Thu, 07 Nov 2024 19:10:22 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:10:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 00/11] rust: bindings: Auto-generate inline static functions
Date: Fri,  8 Nov 2024 13:10:01 +1000
Message-ID: <20241108031012.335203-1-alistair.francis@wdc.com>
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

v2:
 - Fixup build failures report by test bots
 - Rebase on rust-next (ae7851c29747fa376)

Alistair Francis (11):
  rust: bindings: Support some inline static functions
  rust: helpers: Remove blk helper
  rust: helpers: Remove err helper
  rust: helpers: Remove kunit helper
  rust: helpers: Remove some page helpers
  rust: helpers: Remove rbtree helper
  rust: helpers: Remove some refcount helpers
  rust: helpers: Remove signal helper
  rust: helpers: Remove some spinlock helpers
  rust: helpers: Remove some task helpers
  rust: helpers: Remove uaccess helpers

 rust/.gitignore                 |  2 ++
 rust/Makefile                   | 37 ++++++++++++++++++++++++++++++---
 rust/bindgen_static_functions   | 32 ++++++++++++++++++++++++++++
 rust/bindings/bindings_helper.h |  5 +++++
 rust/bindings/lib.rs            |  4 ++++
 rust/exports.c                  |  1 +
 rust/helpers/blk.c              | 14 -------------
 rust/helpers/err.c              | 18 ----------------
 rust/helpers/helpers.c          | 11 ++--------
 rust/helpers/kunit.c            |  8 -------
 rust/helpers/page.c             |  5 -----
 rust/helpers/rbtree.c           |  9 --------
 rust/helpers/refcount.c         | 10 ---------
 rust/helpers/signal.c           |  8 -------
 rust/helpers/spinlock.c         | 15 -------------
 rust/helpers/task.c             | 10 ---------
 rust/helpers/uaccess.c          | 15 -------------
 17 files changed, 80 insertions(+), 124 deletions(-)
 create mode 100644 rust/bindgen_static_functions
 delete mode 100644 rust/helpers/blk.c
 delete mode 100644 rust/helpers/err.c
 delete mode 100644 rust/helpers/kunit.c
 delete mode 100644 rust/helpers/rbtree.c
 delete mode 100644 rust/helpers/signal.c
 delete mode 100644 rust/helpers/uaccess.c

-- 
2.47.0



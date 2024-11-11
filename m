Return-Path: <linux-kernel+bounces-403958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841809C3D26
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74E81C21C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB57189B88;
	Mon, 11 Nov 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="ToM5NpVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T4nXwwi1"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A615687C;
	Mon, 11 Nov 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324385; cv=none; b=dSakLG+HtcHil5W5cvzszjKCHKNLN4/Ddd6iCkTjTEV+Hn9khCg1DTRXBfs6wfvc2FYufxtTjFkWUvQz9kA03VuXhMUf/cD80aJN+0yBdxbrkIjXLqxPYxgBZhhbkj3wha4iwfb1EL+SY3Eqa1dE6eKsegQjAoyucA8X/s39FfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324385; c=relaxed/simple;
	bh=0f4qiiW5D+dTtakUvEG1LxCmsc7AMNw4DVUy+HRN3j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aN2vSUs4O1iWqRQEYmukMN/B3nI6cJkkv08vfZ0iEa4QB6suGqH1sJUoc4wDzHJNWmSsYQedFppDClK/5FXP7EkgfKt/16riMZMDZHRvsQw1oItaZAp6A35yMEkze7c87dse7JWSR0naUaJXILqlX1ZGRXXQJAKxbnHTqN4x43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=ToM5NpVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T4nXwwi1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 84372138026E;
	Mon, 11 Nov 2024 06:26:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 06:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1731324382; x=
	1731410782; bh=kQCT6ux3cqTieWbFyqpXcLJnODcvdgp+raEjvH1c5DQ=; b=T
	oM5NpVRqxmE4RCFZAGjEB6y1smGo1z0guSy9dA0T4hvAEbr444iHTkI3JZpUxI+0
	/puaXwkJTKo1EfuemCEo2X3kmC67tl5bidROzcFQRJSYLO0QaPqgPMmtf6bSyWW7
	9Q0QHr771uitxNdN9snFsJTZf36DZexGzbLhx8rw1huVClzci3dbWwlXSjvBHYep
	81A94g9yCegdQL7AP3woIIWgUztFvoJ+uVSbRnHmxE7AyvfEfzlOsmsbh5d9V3Mt
	creUUeB2hrX0iaYDv2jhSiD6Hw8ZkyRI2ZcOkxQ6KIP8kKIYjcsZm6DjfucjKnV5
	7hz2fscuhEUnDasCkQJTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731324382; x=1731410782; bh=kQCT6ux3cqTieWbFyqpXcLJnODcv
	dgp+raEjvH1c5DQ=; b=T4nXwwi1FXFR45Vq01xBOD+ACRvSxar9z2x8PArKEZBH
	EM0L3hdG0/5UukoIAjgA3UkxLf+gNgjqplO1aVRLQthtXmT8kr91XbBHEFg3jvUt
	Rk7Idr0qhN2NBx5fq+917bwLB3INVLuKkOSQgzo9r5Kr9t/mxQfmx5igpHa8crvt
	98IdAIdTcnmB0Wk7gIPBOPsokX0bv1n4FhGEbRoaG+coeZ2wFShi8yb7WcGhFy7d
	VvV7kz0+rmJkA0OGT+sFGbammgszHxCTJ46nZfDjk2/9TiO3+YVsa0UKAzwsyy0m
	G3ydxsUDg1jWHcL2DncrTCycSx9JJF3pLXRSBeMYzQ==
X-ME-Sender: <xms:3ekxZ1NFUMwiZDQOwm8Gg3qHfpQX9K_jgGzuD0g50O0f1kFXdjBgog>
    <xme:3ekxZ38y8EbB14pnS1dVO4WiOnF1ZrIFJoJGl_5cFR0uRwkyFTqXrXvMNoN7krnnc
    4c-rm0qqL-WC4OhMIQ>
X-ME-Received: <xmr:3ekxZ0TyF6iwijmj88PEcpXtGMqJ0KLNLmD_C5MOwgfpWqSoOxi-GaiI4zHX6oQS22NGnzK91P_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghi
    shcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvg
    hrnheptdefvdfgieekiefghfejgeduheehvdffjeektedugfejgedujeffudehffdvueev
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlih
    hsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgeskhhlohgvnhhkrdguvghvpdhrtghpthhtohepsggvnhhnohdrlhho
    shhsihhnsehprhhothhonhdrmhgvpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthh
    drvgguuhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehojhgvuggrse
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3ekxZxurbqnv9yMoKx9Eo5fWGuK1E1_7vW501cd3FlYu0_QfQGlcWg>
    <xmx:3ekxZ9fgAPVuLkfVBAo79vHLBkVuzpz_1wJWJPgwsraZkhqiMt_WfA>
    <xmx:3ekxZ92Be1QSnet_tvTTl4yX95VDADGjCUPVQRxgRyEDdHUJesO2Bw>
    <xmx:3ekxZ59qnL8kUE3JhPPK9st1cC8EecCW2BlQ3XPN0-psGYZ_2VEjlA>
    <xmx:3ukxZ98aGgTnW7TCWYLv6Zg4iFpNFMwPMN6ZuDzkg1z0ZpebEshg9HaE>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:17 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	aliceryhl@google.com,
	gary@garyguo.net,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	alex.gaynor@gmail.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 00/11] rust: bindings: Auto-generate inline static functions
Date: Mon, 11 Nov 2024 21:26:04 +1000
Message-ID: <20241111112615.179133-1-alistair@alistair23.me>
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
non-experimental (depending on your version of bindgen).

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

v3:
 - Change SoB email address to match from address
 - Fixup kunit test build failure
 - Update Rust binding documentation
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

 Documentation/rust/general-information.rst | 10 +++---
 rust/.gitignore                            |  2 ++
 rust/Makefile                              | 37 ++++++++++++++++++++--
 rust/bindgen_static_functions              | 32 +++++++++++++++++++
 rust/bindings/bindings_helper.h            |  6 ++++
 rust/bindings/lib.rs                       |  4 +++
 rust/exports.c                             |  1 +
 rust/helpers/blk.c                         | 14 --------
 rust/helpers/err.c                         | 18 -----------
 rust/helpers/helpers.c                     | 11 ++-----
 rust/helpers/kunit.c                       |  8 -----
 rust/helpers/page.c                        |  5 ---
 rust/helpers/rbtree.c                      |  9 ------
 rust/helpers/refcount.c                    | 10 ------
 rust/helpers/signal.c                      |  8 -----
 rust/helpers/spinlock.c                    | 15 ---------
 rust/helpers/task.c                        | 10 ------
 rust/helpers/uaccess.c                     | 15 ---------
 18 files changed, 87 insertions(+), 128 deletions(-)
 create mode 100644 rust/bindgen_static_functions
 delete mode 100644 rust/helpers/blk.c
 delete mode 100644 rust/helpers/err.c
 delete mode 100644 rust/helpers/kunit.c
 delete mode 100644 rust/helpers/rbtree.c
 delete mode 100644 rust/helpers/signal.c
 delete mode 100644 rust/helpers/uaccess.c

-- 
2.47.0



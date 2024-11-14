Return-Path: <linux-kernel+bounces-408497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF7F9C7F92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F6B284452
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A49171C9;
	Thu, 14 Nov 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="x4neSCRA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5+RK1LB"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C1C8E0;
	Thu, 14 Nov 2024 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545803; cv=none; b=SglwpBjSPEq7/43Gjf+ETCkfGm0ZyOIpjUEek/qc6O3m338SLufW5eNBlvwPTfO2NpcWX2+0J6FefhD/ulthiNNHwfktdWVSVaC5nb/xVoVuC10KNCmB0aRyil1OhIspUI4oL5yVKUhQBwep2mBqEv124krs008kVt/ZV6phc+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545803; c=relaxed/simple;
	bh=rTtDaFIsaq9E/wTOZYgn93ur/3lHrA3j7xBom9UYpc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XGIofLuMVPA0JYHld4u/SGXMGY92bvO0J0X0li2TJw9zkMwKGuVBZLedR0NHhM+dp7vY2n4xDAvv0WT6shvxGh5Cbi2ZzDDwX9jArhmL1SNrZyRhzVdCkVhJdmItUE8g0DaEAncZ4t7LS9xakYyhB8DTmyfBDzcvXmPp9s9Bv88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=x4neSCRA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5+RK1LB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B66C811401E3;
	Wed, 13 Nov 2024 19:56:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 13 Nov 2024 19:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1731545799; x=
	1731632199; bh=fH3yUm03hJQDmtSnYMcETQ291J6U7Mm8gXQLFpGnO7Q=; b=x
	4neSCRACnEl+CX2PUFar8Euh8VUO0kYb/IM1De5YB19aD/Ehox7yT/+5SGCGFYdv
	V5xug1UmML+Au5Om7swBpr7t7CTlaepm0zsrVZob63gFHyZNeEtHfwFOef455kYP
	wQWOL2jw3iHmfHfmDYHx3ebDSFQAx3/UErquBLAWt20ZomayY7csjNhL/mrSNlrQ
	NZjN2QbQQUWTFIbgkDIqXHYv2AP93evCIJRNPZKprDIpgJpNImWuQgJ9mOAuLXL3
	qjj3arHxGduxCrYihjTxnX6+/rhLoeo01GdcNC1gkEmV1hW0ah/zfbkWBk7VgTb9
	3+U9HVfUf+1w8r4gNG78A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731545799; x=1731632199; bh=fH3yUm03hJQDmtSnYMcETQ291J6U
	7Mm8gXQLFpGnO7Q=; b=b5+RK1LBQ5cKWedVPQsih98f1p9JfuOuh0jeH6ZDcfpu
	5oMg8NYuV/TiPyqIkM6R++wprBO90ziiE/Pzf1Owm3iGvt8wyLNQpppnalUXB9y1
	IufErJfaot/aj8Qayer/wMwS3n0D54smoSJjukOtuuAGkcCMiEnOK/r7jpg6R1Oo
	dfI5xcQEwSZhOhhj+r9riWVkgbf8XZGdV3CbKZoSdDVqTSBVcLMJsACNcBe7EUxe
	BCsZNpsU5E9kdo6XFmZOH33nsF26m8MDq8QVRuTMPAhe2FfCUF8ZZ+tbwR/MBFs6
	TSoUZb/l9UIQ2jNOoBsiTfyY0dLJQfLlEYr8Mrd4tg==
X-ME-Sender: <xms:xko1Z_ejQ-ffAlPT5IR5zpDtXMbMEArm-iRESKheAkJRrGFpv0nNqA>
    <xme:xko1Z1PWxt67iuGgH7yUo1vsIraA2H3pFwYa3p748RARslJJ1YNMc6I2NBR9JuaHV
    uyaKXHDnQMOvm1CckI>
X-ME-Received: <xmr:xko1Z4grHAUBI59z9qAHlovPWMrE5f66GRIdUiemYsJpfz5ZgC-YWLU8IGP3Hv07kYLuS51hG9QS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghi
    shcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvg
    hrnheptdefvdfgieekiefghfejgeduheehvdffjeektedugfejgedujeffudehffdvueev
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlih
    hsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhho
    thhonhdrmhgvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegrlhgvgidrghgr
    hihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrlh
    hishhtrghirhdrfhhrrghntghishesfigutgdrtghomh
X-ME-Proxy: <xmx:xko1Zw8lXtIjnTmeTcxy_n4Zhc330dn23GCQ6y7VaUpDPFBBnDle0Q>
    <xmx:xko1Z7sFeY_Me1SDLSu0JToSeglppC1aQ4is94TqJ3CFNWnplvu1tQ>
    <xmx:xko1Z_EO-MQR1akD_HgT2AZQAFjsgPCTWdNw88FqFnASdg832VUnGA>
    <xmx:xko1ZyN01PFsRLavJEPcWN1-w9X1pId77mnlrhA9xEv25n-Y0C_O6g>
    <xmx:x0o1ZzMiwZEj3e9i5Zg-dUMDXQ3MRN0phJzMOt2oilwjNKq77GC1yRRL>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:56:34 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	me@kloenk.dev,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 00/11] rust: bindings: Auto-generate inline static functions
Date: Thu, 14 Nov 2024 10:56:20 +1000
Message-ID: <20241114005631.818440-1-alistair@alistair23.me>
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

v4:
 - Fix out of tree builds
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



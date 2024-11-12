Return-Path: <linux-kernel+bounces-406308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516799C5D19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DD91F255CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11EF205159;
	Tue, 12 Nov 2024 16:25:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1D2038B3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428746; cv=none; b=eRPt44MCHxxgwe0wtAl7qx2aNE0CIJw9TPI6+KowXLRqKE6ktRkmsfdDxKzlcYvyzlUJabP1v0bwtOPCOIhXwEfldcyz5kI5/L54I4Iq/7G2M9XekHBMabXUctuaUjIs9oWLvzyzL4Qx7R1tjyAfTT7kuLCtVJaWvbaE7Ie5jRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428746; c=relaxed/simple;
	bh=aZiuXNhGYziJUKMTs3Fzo+W4onQ1l1VYpMSX9YhIILk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lUZn6XSnFclPeCZgNZ1XDX241NpjSgxQyoSgzkpNVvMwLjWRlo/+jarIulREXX6IF+I/5FZpKtCm9d4AHo585x6HFrrnPyokBHZdqXIR+hdvT4X/mdPY1nt+o5sydFadrHaovMdAdDqZFRfO83qbwdVpQEBiOwkqEz9DPo6CSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F80C4CECD;
	Tue, 12 Nov 2024 16:25:44 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:26:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: [for-next][PATCH] samples: rust: fix `rust_print` build making it a
 combined module
Message-ID: <20241112112601.58aed250@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
rust/for-next

Head SHA1: 22193c586b43ee88d66954395885742a6e4a49a9


Miguel Ojeda (1):
      samples: rust: fix `rust_print` build making it a combined module

----
 samples/rust/Makefile                              | 4 +++-
 samples/rust/{rust_print.rs =3D> rust_print_main.rs} | 0
 2 files changed, 3 insertions(+), 1 deletion(-)
 rename samples/rust/{rust_print.rs =3D> rust_print_main.rs} (100%)
---------------------------
commit 22193c586b43ee88d66954395885742a6e4a49a9
Author: Miguel Ojeda <ojeda@kernel.org>
Date:   Mon Nov 11 23:08:05 2024 +0100

    samples: rust: fix `rust_print` build making it a combined module
   =20
    The `rust_print` module, when built as a module, fails to build with:
   =20
        ERROR: modpost: missing MODULE_LICENSE() in samples/rust/rust_print=
_events.o
        ERROR: modpost: "__tracepoint_rust_sample_loaded" [samples/rust/rus=
t_print.ko] undefined!
        ERROR: modpost: "rust_do_trace_rust_sample_loaded" [samples/rust/ru=
st_print.ko] undefined!
   =20
    Fix it by building it as a combined one.
   =20
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Alex Gaynor <alex.gaynor@gmail.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Boqun Feng <boqun.feng@gmail.com>
    Cc: Gary Guo <gary@garyguo.net>
    Cc: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
    Cc: Benno Lossin <benno.lossin@proton.me>
    Cc: Andreas Hindborg <a.hindborg@kernel.org>
    Cc: Alice Ryhl <aliceryhl@google.com>
    Cc: Trevor Gross <tmgross@umich.edu>
    Cc: "Linux Next Mailing List" <linux-next@vger.kernel.org>
    Link: https://lore.kernel.org/20241111220805.708889-1-ojeda@kernel.org
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Closes: https://lore.kernel.org/all/20241108152149.28459a72@canb.auug.o=
rg.au/
    Fixes: 91d39024e1b0 ("rust: samples: add tracepoint to Rust sample")
    Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index f29280ec4820..c1a5c1655395 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -2,6 +2,8 @@
 ccflags-y +=3D -I$(src)				# needed for trace events
=20
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+=3D rust_minimal.o
-obj-$(CONFIG_SAMPLE_RUST_PRINT)			+=3D rust_print.o rust_print_events.o
+obj-$(CONFIG_SAMPLE_RUST_PRINT)			+=3D rust_print.o
+
+rust_print-y :=3D rust_print_main.o rust_print_events.o
=20
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+=3D hostprogs
diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print_main.rs
similarity index 100%
rename from samples/rust/rust_print.rs
rename to samples/rust/rust_print_main.rs


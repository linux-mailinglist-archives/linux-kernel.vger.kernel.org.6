Return-Path: <linux-kernel+bounces-559909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A44A5FAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC40422828
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868B826AA8F;
	Thu, 13 Mar 2025 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="PaAlGdPr"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB8268C48;
	Thu, 13 Mar 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881774; cv=none; b=haNQTBSNMjz83jBe+o3VCbJlhIDrWJXK3OjUZpFqvPhUuOBrZAyrSY1tWpjSlaSUIECAOgCbC25EUrGz39nVJz/n4vhPyhvMLOZ6HtbykevApaWW2oP4UdiSEzpuivxELbm5HyTMxCeRJIp7tijezkGffIiwC3v5YDlfzxfLtPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881774; c=relaxed/simple;
	bh=3MxODXhUyDWZ/m6JfPXzUJhXPAMmYaBGPrDeg7AXWGs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=SqljzvA7dvyI+KlWJd4JHsBPbMkk84K0r5P4iO/NX6pLitEz065QW49xOoxedEjhSknSOhjp4ooY/BZXhxpIrIqAMHgGVHmcZ7+YwRva4aJkTksh/sd/35ERrWMAHxkTiA6xpZD4/HtXHfkJdJqmuQFIvIwyBxybkVrDNqrvZ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=PaAlGdPr; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1741881769; x=1742140969;
	bh=BQ4wJAhy2dpyN+MuSRLCyVk3VO5GKkBoc4sLhOsLk04=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=PaAlGdPrUf+jO4kxjZ9r/b4CZUlb/UQh4hV1S0yyF0gUCa35LP7a8l0Gu1ge7NIxb
	 wE1Z4RQfH7jTDB1OcwTPSGX7y7jB1aCAtiFcBl/vuAheunyDuhuwDPE8ILJ2sXH6/2
	 Bzc8puAaD16tm+/IBqdS4oq4Qv7i01P0X5//93ZrQ1cS0aOFHGFLhL4v5KrmOnMOPW
	 yErOquFahSGV+y98+WsoGciOjkEkSOEWduxCqrqJVjR6/TM7dMy/G4dx57xtbeh2Ez
	 TVzNHcgsyLOEqUsNJbbi0oyQAQ2m0pNoF/wCBAcw4E7SIR+VMpSski8ea+igP2cZri
	 HIfmjBbnHUsTg==
Date: Thu, 13 Mar 2025 16:02:45 +0000
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH RFC 0/3] Initial work for Rust abstraction for HID device driver development
Message-ID: <20250313160220.6410-2-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 7b970764ee6dc7211652295f774311d67daa40a7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I am a hobbyist developer who has been working on a project to create a new=
 Rust
HID device driver and the needed core abstractions for writing more HID dev=
ice
drivers in Rust. My goal is to support the USB Monitor Control Class needed=
 for
functionality such as backlight control for monitors like the Apple Studio
Display and Apple Pro Display XDR. A new backlight API will be required to
support multiple backlight instances and will be mapped per DRM connector. =
The
current backlight API is designed around the assumption of only a single
internal panel being present. I am currently working on making this new API=
 for
DRM in parallel to my work on the HID side of the stack for supporting thes=
e
displays.

  https://binary-eater.github.io/tags/usb-monitor-control/

Julius Zint had attempted to do so a year ago with a C HID driver but was g=
ated
by the lack of an appropriate backlight API for external displays. I asked =
him
for permission to do the work need in Rust and plan to accredit him for the=
 HID
report handling for backlight in the USB Monitor Control Class standard.

  https://lore.kernel.org/lkml/f95da7ff-06dd-2c0e-d563-7e5ad61c3bcc@redhat.=
com/

I was hoping to get initial feedback on this work to make sure I am on the =
right
path for making a Rust HID abstraction that would be acceptable upstream. T=
he
patches compile with WERROR being disabled. This is necessary since Rust tr=
eats
missing documentation comments as warnings (which is a good thing). I also =
need
to go in and add more SAFETY comments.

Thanks,
Rahul Rameshbabu

Rahul Rameshbabu (3):
  rust: core abstractions for HID drivers
  rust: hid: USB Monitor Control Class driver
  rust: hid: demo the core abstractions for probe and remove

 drivers/hid/Kconfig                |  16 ++
 drivers/hid/Makefile               |   1 +
 drivers/hid/hid_monitor_control.rs |  42 +++++
 rust/bindings/bindings_helper.h    |   1 +
 rust/kernel/hid.rs                 | 245 +++++++++++++++++++++++++++++
 rust/kernel/lib.rs                 |   2 +
 6 files changed, 307 insertions(+)
 create mode 100644 drivers/hid/hid_monitor_control.rs
 create mode 100644 rust/kernel/hid.rs

--=20
2.47.2




Return-Path: <linux-kernel+bounces-255743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9B93449F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2991C21401
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378DD47A73;
	Wed, 17 Jul 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EnxVSMSd"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656302574B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721254357; cv=none; b=boQFEVwt/VkRD7a5pAnvbHFhlqW8eeXcg05hEynNfXjMCCzuI0ztMYoh4ss/3fdjK9KElevHAoQbAa39GkGlXlNNOfFwksZOPFdnwv7HL7G/IlB9VLaQi/LqLhQH3i+qtHXjKsUQScgdTRxF7KXbTs/Mut6ovdXL7TXsZpotdo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721254357; c=relaxed/simple;
	bh=kS4OGQtw2cUO3ktnl5K0TWYCJ+yM1dUyR77OvKKiA0E=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Ts8a8W+sehgRMgUqEPTyOPDRn6LYHJhI+jBDM3r0ZU1bzyH11PLf/0sCx4pQggf53xWyPocIu9utqkC//f6yedihD0b1z/UTOTaU8rUqVdNlDFFC5Z/kiftPD+M4C8EEbisRZYAmS961tN//iUd7FuyendDEWWMu7XqwkOsnfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EnxVSMSd; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3xahdcz46fbs5avt2xdlmxh6wu.protonmail; t=1721254349; x=1721513549;
	bh=vWJ831e142vfCDH2rjzZdcl7BIbENMaOr44f0vM34iE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EnxVSMSdZt096mApZR+jP2QoXu/HRatYFhlMpklevFZu+L+JtSM03FaAMgNMtzVJu
	 CUCVOSUGO06y8jtSGsPo9uu7tN+YRPajdK6oROtPtAnS/E47YG9LST1IYtEIkBILMo
	 Wdh9nGgqn/uC+y6SQVPmlw987WuTc2GayuYqznXsBGmbzZXcHegjHmPeq61zlMe5Ae
	 9/+03lW29qpU6nNG05HxpCTrp9WhAFOsilbMM4A6/6rWu3RN2r0gy8ZPGLiRwbFRSg
	 +HAW+eiBXpoRFtri8TJSmmuClvrV4fpJoefmjnd/yQqBrCkRpMtBnfBAxB9cgcO9U6
	 wGLjU6NM1UrVw==
Date: Wed, 17 Jul 2024 22:12:24 +0000
To: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 0/5] Introduce the Rust Safety Standard
Message-ID: <20240717221133.459589-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 66aab4dfcb8f5367d81c68150dcc6de6a394f0ec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

`unsafe` Rust code in the kernel is required to have safety
documentation. This is to ensure the correctness of `unsafe` code and is
thus very important.
However, at this point in time there does not exist a standard way of
writing safety documentation. This leads to confusion, as authors
struggle to find the right way to convey their desired intentions.
Readers similarly struggle with correctly interpreting the=20
documentation; it's the wild west.

To alleviate this issue and to raise the quality of safety
documentation, this patch series introduces a standard way of writing
safety documentation.

Because creating a standard for every possible requirement is a tall
task, this series starts off very small. I hope to start more
discussion, in order to find the best form of safety documentation for
the kernel.
Please do not hesitate to give any kind of comment. I could benefit
especially from improvements to the visual look of the documentation, as
this is my first time writing Sphinx documentation. For example, I am
not satisfied with how the tables renders in HTML.

Benno Lossin (5):
  doc: rust: create safety standard
  doc: rust: safety standard: add examples
  doc: rust: safety standard: add guarantees and type invariants
  doc: rust: safety standard: add safety requirements
  doc: rust: safety standard: add justifications

 Documentation/rust/general-information.rst    |   1 +
 Documentation/rust/index.rst                  |   1 +
 .../rust/safety-standard/examples.rst         |  70 +++++
 .../rust/safety-standard/guarantee.rst        |   7 +
 Documentation/rust/safety-standard/index.rst  | 281 ++++++++++++++++++
 .../rust/safety-standard/justifications.rst   |  40 +++
 .../rust/safety-standard/requirements.rst     |  80 +++++
 .../rust/safety-standard/type-invariants.rst  |  18 ++
 8 files changed, 498 insertions(+)
 create mode 100644 Documentation/rust/safety-standard/examples.rst
 create mode 100644 Documentation/rust/safety-standard/guarantee.rst
 create mode 100644 Documentation/rust/safety-standard/index.rst
 create mode 100644 Documentation/rust/safety-standard/justifications.rst
 create mode 100644 Documentation/rust/safety-standard/requirements.rst
 create mode 100644 Documentation/rust/safety-standard/type-invariants.rst

--=20
2.45.1




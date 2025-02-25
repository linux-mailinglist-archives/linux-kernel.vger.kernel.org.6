Return-Path: <linux-kernel+bounces-531321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436ACA43EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631EA3A6404
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF4F267B98;
	Tue, 25 Feb 2025 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljCZgrhF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681319E992;
	Tue, 25 Feb 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485651; cv=none; b=WLSf0XtnvNVLpHdosRUsZ873RcTc2q5+XcnRH1AcMaGPzPba9Aw1F9asAYZWNx/X0//EvhbmuKWOyW/03H6z+80DmF5lFz3sbHifCCRUHURnA3zj0eKFgkEuk5MhQ0cDwi6voCh57sf7M+DeIwCQJdmHqxWV7nPqOczycqV3mYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485651; c=relaxed/simple;
	bh=3a67tCypQbtcBsmDmDd2NPYPMTvZYXuMOhZzZLoGJEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dzZz7R56bySS3JTtPCWkvPJlFDeKtQGf2IyoXaOc9VKmv6OwWW/O+Os8AtTupL+OGjA948R0VuiMEiptl/roEJgnY0yynIdk1xzyijmbnDBUYAdKvCyf3zCBqf/svpfbntwW/ByC6sMKeYItXJtBQlNBfe3o1n9xqoBAnV0MWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljCZgrhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768BFC4CEDD;
	Tue, 25 Feb 2025 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740485650;
	bh=3a67tCypQbtcBsmDmDd2NPYPMTvZYXuMOhZzZLoGJEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ljCZgrhFdBFtZyDLrVBqLL1DGKY5Mh6/32+378UBL7Rd50Z9s5piUc0f1huOqOmAd
	 1ygep7nEW1uWI4Q8OY9hF26glbfnhh2Y9gw+Fq1lu1tLaE0B0KcdhWp1Zr41HbCs1S
	 rVAx+YY/oHBbx2WaUo61lEJX+dsdnojn1dwYAOsxKAM8ni96+M1oCDshmvKB0N85F0
	 bvgh7POQxKbuTBiE8fQ6bjsZEgLjT/5xMdyN8bS2OIgSKh797d2D5O9xlF6TUdfXm+
	 GOlrg4x5MM7HLs4VeFVDrmPZnLdbd3Pbf9E9HHZ0fexS7Y1EWkepJ1HpnLVnsyBNbo
	 whh/VsUOWoScw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Markus Elfring" <Markus.Elfring@web.de>
Cc: <rust-for-linux@vger.kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "LKML"
 <linux-kernel@vger.kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Boqun Feng" <boqun.feng@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  "Guangbo Cui" <2407018371@qq.com>,
  "Lyude Paul" <lyude@redhat.com>,  "Tamir Duberstein" <tamird@gmail.com>,
  "Trevor Gross" <tmgross@umich.edu>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <4b9c2253-b791-4baf-a790-e776e15baa89@web.de> (Markus Elfring's
	message of "Tue, 25 Feb 2025 12:36:06 +0100")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	<a_VxAPGAquHbNyHozrHOG4FGp4ceNqklsYu7oghhNGie6MWcQtMOEzuKERps8Zx3sXjqcP7ZJ9bF1kf0J8VSwQ==@protonmail.internalid>
	<4b9c2253-b791-4baf-a790-e776e15baa89@web.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 13:13:59 +0100
Message-ID: <878qpuw7aw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Markus Elfring" <Markus.Elfring@web.de> writes:

> =E2=80=A6
>> This patch adds support for =E2=80=A6
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n94

Thanks for pointing this out, I'll change the wording for next spin.


Best regards,
Andreas Hindborg




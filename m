Return-Path: <linux-kernel+bounces-429426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC81F9E1E65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA62AB453A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7621EB9EC;
	Tue,  3 Dec 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlwDeyXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB51E573E;
	Tue,  3 Dec 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733228192; cv=none; b=RySyGbj5ZEsSPT+2bHp5eOH78/NzgFzXU81l3EBgON8CQGXLt22YmfY5lFhuYf6u1RRKAH9Lnb0w5qzj7wcNyrvW1JFD461t8fEggVpaxxtUDt89jO2FrwaKnoeyuD34XpfUY4cMdtx7FJIbycvZN6RB6HLWBSXdb5Xqw5pnXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733228192; c=relaxed/simple;
	bh=/aO6/dZ1qzKrNplUbQzs6rs7FOyIPmNmTkFF3huDRM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ST4bGISDlEHJPZMU3bY8KuNXCS10ZlXaTFsdghEwl0juo8rcxSLDMSxHSDFZFt4Z/cCcJC0ItQ2SoRdXk93/NJMtmSFfTBcxwHhQuUZOjCrTwnhd6qiJnQUkL2kLX69oC1fmWLbXFXzp2P+gKHehmRoxgL6Of13DzzMB0mxaAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlwDeyXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7857C4CED6;
	Tue,  3 Dec 2024 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733228191;
	bh=/aO6/dZ1qzKrNplUbQzs6rs7FOyIPmNmTkFF3huDRM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZlwDeyXfWtq6PzTnfjAJL1drpPjTilnk3ebUBMckgGl6xMmuxz3V+hYubcXY9B07U
	 V0Y8LCxfC3jBGS8xyukWtaHgOqGfDhGh3pXkpluHfCupqKNRMymyu7dry9eha/Z93r
	 c9c7pxZ+5jSsq1GOJeRSzwhVnou3BV72Vj24f75wrovxbBNDMrpgp/XmudbRfur2Vv
	 FwYeijPJ7sR/dEhm1VZUpiucfSf8XTtgGOaZOXoe2hupqdPjpPYs7HFlNIgcoWqV7J
	 /SepoBOwZfruMngcbfNMwAvXcsdCxbsNsIdctgx2H5KZrLabDwlQoSxknhurGNeRd6
	 MIKwCDhY4rgBA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>,  "Asahi Lina"
 <lina@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/2] rust: types: add `ForeignOwnable::PointedTo`
In-Reply-To: <20241120-rust-xarray-bindings-v10-1-a25b2b0bf582@gmail.com>
	(Tamir Duberstein's message of "Wed, 20 Nov 2024 06:48:17 -0500")
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
	<nR31Ti2MTTrvntU_ZI3ie6K-WF-6Sof9Z_J5GHzpmaMWJROlCvPkgzzVxYa5ZX2nBWZ1xOhCWLOl80OeZ244GQ==@protonmail.internalid>
	<20241120-rust-xarray-bindings-v10-1-a25b2b0bf582@gmail.com>
Date: Tue, 03 Dec 2024 12:51:28 +0100
Message-ID: <87ldwxf0hr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Allow implementors to specify the foreign pointer type; this exposes
> information about the pointed-to type such as its alignment.
>
> This requires the trait to be `unsafe` since it is now possible for
> implementors to break soundness by returning a misaligned pointer.
>
> Encoding the pointer type in the trait (and avoiding pointer casts)
> allows the compiler to check that implementors return the correct
> pointer type. This is preferable to directly encoding the alignment in
> the trait using a constant as the compiler would be unable to check it.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




Return-Path: <linux-kernel+bounces-370093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D2F9A274F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB3F0B2B159
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0231DEFF7;
	Thu, 17 Oct 2024 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AOOtwpWa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9926C1DEFCB;
	Thu, 17 Oct 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180012; cv=none; b=PWrrt/Vivnr/MTIzdn7etS9zCrphukDBiqVDQwLXEJbadXj+RqhuzLucPojgQVAOI9b4h9zcYZfAe8vVbNzjMSfvaZN1vpOYqePHluztU9T8gYiTKo0gT01e/SHIpfGoFtXMEhPLuGMeuBvg++catseNsJSBL3b2cJvPqdc7gng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180012; c=relaxed/simple;
	bh=xfZsdaouK9c11NS8MJBUJaGS9qi4/dGFd60QE8h2lGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIMItSwNpfHezhuYPBQg9KhmoLsodrVH+9YaAZDl1peb+12ioHM4TVK01elmnzVOs+euDcpwjEA/z876RmQlmPdfSzIndWyU8Cf9qc1nLLyANECPOxP54oHL1l+QCEiNNQAlq1vlJJobkZ0tSkU8EJztOWj5YkftjpKKXCwr1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AOOtwpWa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B371B42C26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729180006; bh=lbIoIO+xJXLQRNK9loyEZijJ54dZ/V3Q+NLtfSIBhHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AOOtwpWa+OXFoGebwTqmsOuOwOuQAVD231H5Cy2aG/2WvwRUXy/Fgo7zNdEWSIYsH
	 dVeyt1gQWtsUABzjRSuAWK67VHUn3qPNoSws+FGsMsgZnaTYOL+WYX4KjGyeiJILwG
	 riPBpEOfiNQ2QXBdADanVZbkaQvZi+UA+sVooc/mBNPTDtOJNSkumqjECGojmjQ6n3
	 si17Ah8F7segVuQmpdMf1snL1easHlQicqHmXQg3mbur35G4jyUKg7uMYTCcn1nHV9
	 w092ccf9272m0oBEqHD7VdSXmBtUIcBs+6TgjQcX8WCdK+0fOaqCAWelHVLe8dL1T1
	 AVp0ymaM9m2DA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B371B42C26;
	Thu, 17 Oct 2024 15:46:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, Yanteng Si
 <si.yanteng@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] docs/zh_CN: add the translation of kbuild/kbuild.rst
In-Reply-To: <20241016131710.2619567-1-dzm91@hust.edu.cn>
References: <20241016131710.2619567-1-dzm91@hust.edu.cn>
Date: Thu, 17 Oct 2024 09:46:45 -0600
Message-ID: <8734ku3f6i.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Finish the translation of kbuild/kbuild.rst and move kbuild
> from TODO to the main body.
>
> Update to commit 2eb5d7f24299 ("kbuild: doc: describe the -C
> option precisely for external module builds")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/kbuild/index.rst       |   2 +-
>  .../translations/zh_CN/kbuild/kbuild.rst      | 304 ++++++++++++++++++
>  2 files changed, 305 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/kbuild/kbuild.rst

Applied, thanks.

jon


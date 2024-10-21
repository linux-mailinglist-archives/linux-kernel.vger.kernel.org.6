Return-Path: <linux-kernel+bounces-374671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE5E9A6E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBE4B21E25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3A1C5781;
	Mon, 21 Oct 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qxf1QEKb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67881C3F3D;
	Mon, 21 Oct 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525136; cv=none; b=Rfx+4iAehFM0eQAttx2etiQFenkwm7RfHt+SdveyHxmxTLDni/jGViLIvljvr9clhetp6v1fLG4JXigrDkSOpgs7r8YoqL6yHJXjkT9RCxwyGh7JxWOZqJm6PrfVrT7ZAomKGcfzTvo6/5vnCWnpj3UNVFA6IrvzrmUa/k4dNTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525136; c=relaxed/simple;
	bh=rewxLSB3+E6vK3pFSLcUVzgSk/vaieKpNK7ULfVxgHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r0ZNXy1zAib2KhMeSd+aNd2b5kPIBumzVt5oxyJHE6CX6L9YDlf5fU+jVynFCfQ7dldF4TFFeCyvprZVVeGxJwcc3zJ5DKYZipJKZnTEwe+oolq0FkOiWXELStIm77bQLJso8WbzfeTLRNYmKqjoeJIHI/ICj/Vl0W9wlVRGer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qxf1QEKb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E7C0842B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729525134; bh=663VDK6otAnlhYHjpaYmyTrveXbjH8tXmKrjO3SC+UE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qxf1QEKb26FsXYPu/e3hbfG8JAGk7dBlqqusySh8r1m3K2eLf6dnt6lWfm5CPI64f
	 yxCRsB5re4A4RZ34eqetpfMUkutskT3xQn8/MWlcopBQvpTIVNpZGQsLWa/V/0wCaR
	 71xBrnlUrKVoAICp+V9w9+Hi7nasWBUJ7Jw1sUFARBbHw0YECAqqdUatbcZyB8VgbQ
	 8r/zU87KKpeceYV5qxlbeHvELb3W9GPNj/5XwO2PLRY/aJqu8g8Zye/uvA/7ayBOli
	 52+IlIm2M2zWV9WmGTnh3kRGjrDyf8e2HIc6iwmm5D2TMpD78N1cwrT1mH/hTuoXWr
	 Tvt+QJyJTTcZg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E7C0842B3D;
	Mon, 21 Oct 2024 15:38:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Dongliang Mu
 <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/programming-language.rst
In-Reply-To: <20241018015226.3786020-1-dzm91@hust.edu.cn>
References: <20241018015226.3786020-1-dzm91@hust.edu.cn>
Date: Mon, 21 Oct 2024 09:38:53 -0600
Message-ID: <87ed49tqia.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Update to commit 0b02076f9953 ("docs: programming-language: add Rust
> programming language section")
>
> scripts/checktransupdate.py reports:
>
> Documentation/translations/zh_CN/process/programming-language.rst
> commit 0b02076f9953 ("docs: programming-language: add Rust programming
> language section")
> commit 38484a1d0c50 ("docs: programming-language: remove mention of the
> Intel compiler")
> 2 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: revise the script name
>  .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>  1 file changed, 30 insertions(+), 48 deletions(-)

This one adds some new build warnings:

Documentation/translations/zh_CN/process/programming-language.rst:44: WARNING: duplicate citation gcc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst
Documentation/translations/zh_CN/process/programming-language.rst:51: WARNING: duplicate citation rustc, other instance in /stuff/k/git/kernel/Documentation/process/programming-language.rst

*Please* be sure to do a docs build before submitting your patches.

jon


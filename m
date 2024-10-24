Return-Path: <linux-kernel+bounces-380569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 173409AF29F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5244C1C223E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2301FE0F6;
	Thu, 24 Oct 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="QmeNS15W"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAE22B660;
	Thu, 24 Oct 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798459; cv=none; b=t+iNVbXs0ou4WZOBZX6gtD99cRg7HzUzowzV9/N9CNKDtMyH7ZkTpYxFiVId4ZTpFFxsb/MvGd512I3fBse1mcLqqn6Yx5Zygb4eWyl8NvZff+W52H3WxrhBP2BoG14k7do2EspRNHl2hkFUry9hHvzdEJgTUjEVcCvyAfUkhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798459; c=relaxed/simple;
	bh=1kUvSduy0LGVPYVn3P+TUIfbacZS4kAR9QgTrEeaFf0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7DCFkoUedoOxSwZE93p7vkGqvSRrFgbdTv4xECo8IM1TulrORMBxZu80mckc/2Q7GTwjPXx7dTKvPku6hZJ4tq4AeyWngZE/DbomXJU6lJfAuLJhggPMh11UCWQH8159p5mX+DI5zywFnerPF8GR+LNindz6nLbUMrr7LZ0Epk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=QmeNS15W; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE5FF4188F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729798456; bh=Rz6K0v/9UGNXjj4AotqN+xg7ZIBooQuowAI+q0MerFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QmeNS15W8SbkOKnFYIPeI03euuHTH2bj8aJpauNbwmegAPDpoyBnVr8JrtJ/EpF+y
	 +VYUZAarDc+mujqMEP2lZ/ZunV0UB7H4sIxgfDU9dsagh9nCDDh+96ivqkMfAgvAty
	 Sutsl9YalYSZZ+O+n5c042XGyKsbN8hGyVPMA3xMXY7qaLUDY85GpE8M7WD9hJYkCr
	 4utBrRomBAk6pDAvs1CVN65u40YIXvWlGxuwrLwRyhBqUxetJlf8FVYueU9P3gLe9u
	 AIF0/89HaceSQpyGLXcYHBShbv/gAdevafN5a8T7QmM1IsuBtjlp+7UVD7e+SQUE+I
	 WicLK6vfbSkyA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DE5FF4188F;
	Thu, 24 Oct 2024 19:34:15 +0000 (UTC)
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
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of
 process/programming-language.rst
In-Reply-To: <20241023062750.849951-1-dzm91@hust.edu.cn>
References: <20241023062750.849951-1-dzm91@hust.edu.cn>
Date: Thu, 24 Oct 2024 13:34:14 -0600
Message-ID: <87bjz947nt.fsf@trenco.lwn.net>
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
> v2->v3: fix warnings in the make htmldocs
> v1->v2: revise the script name
>  .../zh_CN/process/programming-language.rst    | 78 +++++++------------
>  1 file changed, 30 insertions(+), 48 deletions(-)

Applied, thanks.

jon


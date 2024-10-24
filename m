Return-Path: <linux-kernel+bounces-380653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF59AF428
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE56B21C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C72170D3;
	Thu, 24 Oct 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lvGIaJcU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709F170A27;
	Thu, 24 Oct 2024 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803761; cv=none; b=cUU5PzvAFgGf0cR7puN5pO0hjfYlapxXBJ3/7F2h1oQtAbZCSZc6BhbUMAaGh8SPbgJ7qMrd5L86zukGQLfogfQXMKtpQUc4VWpKw6Ut6R8Uqy8RvQmWnmIIpa+kQcyvfABDVwI/x2vhSo/Lhyu2Ur0omTeCJTrlsRnbdcO54VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803761; c=relaxed/simple;
	bh=JRu/0yRLFkjGcQnRvva+FsDQtQypm8tdfhveZVg1Ocg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bC+QKEdPn1vWR8bKvXZdO/zFl6JARm5CwEIhiBjhzWLGyDt38TR0W/rggn3U6UF1gKNL0AjBkk/VxP5xVHl4pMTXUchJB7lh5eorGg1UBnZKI2VuNDqF7Hha6vpwJcknuj5sdo2oPeIi4OjzeNQkfl+tS/uG9gYC0hkp936WHtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lvGIaJcU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 41AF642C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729803759; bh=CjqmLTP7r6fnx9k6gL8lAGFaj5pUPVS/3GNp7nsyHWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lvGIaJcUI2xmSkzqFobfbkypZWvt1Ad7FnNihTyw9kYC8mpXU70KnAh44He+KVan+
	 VvP2w7YdoQ+pB5eAK6hG2crd4kCZFiPP1zDe/Ej1BrpJ8F8TBMDhmFAgL6EJ6wg1/w
	 QfvAvo80OXSkIrpxZgSsRqDfNLWkZ9rwFRapSjRZetVr5kMB1edD5IzFdEZBAQAvk5
	 w59NIvcY38f+eDT1AVD43H5k4sbY4I/b8XB2boywNzUa7HMCeXWX/2lIzoOjnJGZ+C
	 wgS+traxCfEgCAoPX47178lKvoQb1fYiF56ydBQHr3vzRU9NuPjjaTitjfjqNZVDCD
	 +5EoXVP/3jnGA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 41AF642C0D;
	Thu, 24 Oct 2024 21:02:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v3] docs/zh_CN: update the translation of
 process/programming-language.rst
In-Reply-To: <874j5146ek.fsf@trenco.lwn.net>
References: <20241023062750.849951-1-dzm91@hust.edu.cn>
 <874j5146ek.fsf@trenco.lwn.net>
Date: Thu, 24 Oct 2024 15:02:37 -0600
Message-ID: <87wmhx2p02.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Corbet <corbet@lwn.net> writes:

> This still generates warnings:
>
> Documentation/translations/zh_CN/mm/physical_memory.rst:131: WARNING: duplicate label nodes, other instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst
> Documentation/translations/zh_CN/mm/physical_memory.rst:325: WARNING: duplicate label zones, other instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst
> Documentation/translations/zh_CN/mm/physical_memory.rst:334: WARNING: duplicate label pages, other instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst
> Documentation/translations/zh_CN/mm/physical_memory.rst:350: WARNING: duplicate label initialization, other instance in /home/corbet/kernel/Documentation/mm/physical_memory.rst

My apologies - that wasn't your patch at all - that's what I get for
trying to do things in a hurry.  Sorry for the noise.

jon


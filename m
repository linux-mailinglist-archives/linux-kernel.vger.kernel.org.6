Return-Path: <linux-kernel+bounces-323897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD99744CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B0B1C24C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935E1AB522;
	Tue, 10 Sep 2024 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="o+iCojLz"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E641AB50E;
	Tue, 10 Sep 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003780; cv=none; b=XOuMXwPfW87Ou0roG37RrDB8hsvwWlp2R3cqZXkGaX0V8w8Ve/PX4FvN85NyfFSIdkCVilpY06C0Y3NvfIJgAKWCEigbxtONATWC+bY3p0bH1gqoL8Cemi5AL1owxkt5nTfikS/s1F5Zzus3WWBQqk8+mZmCUE3KXjo9Gese4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003780; c=relaxed/simple;
	bh=Ynqn4nAJCQb3K91P/VTtiGu0x1IN7vkR3zg8XkgCzF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eqWuvY2COe+HwI4RB0wwg59T8FRJRSjRneIsv0M0uKMNw7dgPNj1bletEuDi0TinJ7U94PgzKTn9k7tAuLE9KYqNMfwrvm6ZGUxaQynadheKJOowfS/yxOjU1ePiW+2pUwbNm64iLqv49/ekPikCP+z9369kF21YToKcgAd6Nxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=o+iCojLz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 093BF4188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726003777; bh=zp8fJpAfCbl72Th6GiF5qBWF4ZzlCNk5ypC8iY8soVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o+iCojLzgGJmKlIWeAfHi54FvVQk4yWSIqP6dI/9GOVgPRc007xVEPhTUsxqFNNQR
	 U9PmqGLY3+tWrQL7tDQtCklcNTLGTLeUwnGOAI4c76VrtyBC7fZlPAz2+Cpc+prkID
	 2WiTxRmXPUIktt2cwfaegWIFizznC+Ym3pmW5B5/QKQdYPpqV1qVhVWBtd0/gmi4Tg
	 iXqPy9T3oE9kuEijdU1W06g+WM5yf9b9B63dgcpGlTxVFzN4SAjKQdvpXwHBHbC4TS
	 mUOuJKo2WPOxWwkaoMMMyk/YBHCXfFhaHGN0ITozQvcIZJmwNHJEVOrDKgPHSwoSsT
	 SxbPge4UaDF9Q==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 093BF4188E;
	Tue, 10 Sep 2024 21:29:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.cm, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3] docs/zh_CN: add the translation of
 kbuild/gcc-plugins.rst
In-Reply-To: <20240907070244.206808-1-dzm91@hust.edu.cn>
References: <20240907070244.206808-1-dzm91@hust.edu.cn>
Date: Tue, 10 Sep 2024 15:29:36 -0600
Message-ID: <87ed5r6vun.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Finish the translation of kbuild/gcc-plugins.rst and move gcc-plugins
> from TODO to the main body.
>
> Update to commit 3832d1fd84b6 ("docs/core-api: expand Fedora instructions
> for GCC plugins")
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v2->v3: fix sign incorrect pointed by Alex
> v1->v2: fix comments from yanteng
>  .../translations/zh_CN/kbuild/gcc-plugins.rst | 126 ++++++++++++++++++
>  .../translations/zh_CN/kbuild/index.rst       |   2 +-
>  2 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/kbuild/gcc-plugins.rst

Applied, thanks.

jon


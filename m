Return-Path: <linux-kernel+bounces-399535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EF9C0048
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CAB1F21DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CAD1DD529;
	Thu,  7 Nov 2024 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PrD0Tist"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F811DB349
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730969106; cv=none; b=WznqEVBy7Fs8hZl0qyXxGokWZXiymU5EOm20+alOovutprmI8+xXkqGDOrkGR8FAhzuzT+yRzWetFf5VmNoABJbM5LBVU0w1WHKiYM27+qSbUYO9Ydcz8XvLZP07rFeSbzaJMyo2zf8ypirklDIc51OTW5T4otxqEn7XkMOTZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730969106; c=relaxed/simple;
	bh=LN9MR3PjegFNzfqHHZatZO6yFMcV+myx/HbST2KZtmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PLtonMqArbdcjhepjfubVkuBO9Dak4EmRg6nNK1AHHVL7pBNblNicGdOHWzpE/XhuWFe9R7NkWyqXuHdXyInKm+7C78VW+INhuPxYFN5s621GEMt7D8KeAK1s44oo+IbiOdH/EuyRXEsPnNLUBMxe9eIKKBbDbApWgjj20oe7Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=PrD0Tist; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730969098;
	bh=YcoNI6p0eg9WucO81EJRRVqZRfThSLzqgOfGDYEeHkk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PrD0Tistw/F5QPfDUOtoEoTPZ+rLT2wE11fllXX7ekT8N5ob+MUkT0YKkytTpn8Za
	 cj34UXCrBZPPFv1QmqmrNTj0Ab1s4JbFTyqC9gblMF6MdIs/7eezeHlZL9qlm2qybk
	 YkiLp3lKAxkX75wXy+Yba6/jvAUaYYxYh9Vf4mQ1+698KfhjEIq0Ds+WS/z2RE8O5d
	 MhIzWfe8hu4Kd2PmaD3aCwT48m9MUgP5JARWtbsBjjwDypOTnzgz87M1BqcMPSakP5
	 aQXBOwOUcrJy7vELn0s0vMXoU1zujFi5LohYs0/ijXsiFYjCRc2TelAIz4PBfqFo00
	 wGLyFXOFjm+mQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XkbHF5RxMz4wxf;
	Thu,  7 Nov 2024 19:44:57 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jason@zx2c4.com
In-Reply-To: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/vdso: Add a page for non-time data
Message-Id: <173096894627.18315.733580033753983197.b4-ty@ellerman.id.au>
Date: Thu, 07 Nov 2024 19:42:26 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 02 Oct 2024 10:39:28 +0200, Christophe Leroy wrote:
> The page containing VDSO time data is swapped with the one containing
> TIME namespace data when a process uses a non-root time namespace.
> For other data like powerpc specific data and RNG data, it means
> tracking whether time namespace is the root one or not to know which
> page to use.
> 
> Simplify the logic behind by moving time data out of first data page
> so that the first data page which contains everything else always
> remains the first page. Time data is in the second or third page
> depending on selected time namespace.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/vdso: Add a page for non-time data
      https://git.kernel.org/powerpc/c/c39b1dcf055d420a498d1047c645b776e4d1a7aa
[2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
      https://git.kernel.org/powerpc/c/4e3fa1aecb2c1f128f7289272fe2947e4396f1ce

cheers


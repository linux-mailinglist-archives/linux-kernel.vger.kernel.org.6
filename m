Return-Path: <linux-kernel+bounces-350215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A02299019D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1E7282A99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C01487E3;
	Fri,  4 Oct 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QC3TjD+f"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46381179BB
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039170; cv=none; b=jw4y4ba5WzrMdFriRFhlSeY4FwsdxO7W1GDDhTUetCiJ6VzLUtwreP1PE0EZahJIQVcr6fdBr+DaLTrVjUi1teeR3v9rwkWZV78II5bD3R8nwWvocZQnu/RYgOczbmuUdjcqbRZ70tf8RPdmQ3YolFssyGziGAxA+fFxODPvXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039170; c=relaxed/simple;
	bh=Xf20ckW3L//pyjfHS85q5T2s7VAw5Rlb01ssQESduZo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=es45exPeB96HlcEY4BkRK8b6kjwMaXLMj4JKh8a9wAeY9J9hBTa9hq0UvnAjU1/il0wXGf05IpCdlwoK59LEzhENCJNVbUnzzTaRbj+Bhu3gYMBCA889VwzJQXxhvSeq94CbL8H7nIgnC8l3L4ARoKM4ZeuVaa6B9vQljPtH9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=QC3TjD+f; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728039164;
	bh=Xf20ckW3L//pyjfHS85q5T2s7VAw5Rlb01ssQESduZo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QC3TjD+f9O6zr60Zj10G3ShVWkAWLJdr/2ZVjhoTin78RkDOc8+9o7hPYBJXKrobv
	 HMpfguaKPC6GxS/iBntGcCLnLzubBmU4rICqVU4l+ltG75hzK3JBqo3mH8U7SCRa8h
	 jLwPesVHMaJXczNYHlA1KX8B1rRpmDqbNTs+DkJtpOgHREftBYq+ulPVh+5TNMr4t0
	 koOaSo1hCCPFjKL1xxrzvFtZxll5HPnY9KcZxfsuYNz+SbBVdgpabp+yiG+LQ84vXF
	 dbSMjFXhqXDow6v8j3RlnbHctV7tIwZde3DpEm+NZJZHYqMaSKOLLnMfQ7rwZqVTcX
	 gkjcTFz63QKbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XKlkN1H4dz4x7D;
	Fri,  4 Oct 2024 20:52:43 +1000 (AEST)
Date: Fri, 04 Oct 2024 20:52:40 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, mpe@ellerman.id.au
CC: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
User-Agent: K-9 Mail for Android
In-Reply-To: <Zv7HcuhVH1uM9BNI@zx2c4.com>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu> <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu> <Zv7HcuhVH1uM9BNI@zx2c4.com>
Message-ID: <EF78F2DB-7219-407B-9017-990462128B13@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 4, 2024 2:33:54 AM GMT+10:00, "Jason A=2E Donenfeld" <Jason@zx2=
c4=2Ecom> wrote:
>Hey Christophe, Michael,
>
>This series actually looks pretty okay to me=2E I realize ThomasW is
>working on more generic cleanups that might obliterate the need for
>this, and that may or may not wind up in 6=2E13=2E But, I was thinking, t=
his
>seems like a good correct thing to do, and to do it now for 6=2E12, maybe
>as a fix through the powerpc tree=2E Then ThomasW can base his work atop
>this, which might wind up including the nice lr optimizations you've
>made=2E And then also if ThomasW's work doesn't land or gets reverted or
>whatever, at least we'll have this in tree for 6=2E12=2E
>
>Michael - what do you think of that? Worth taking these two patches into
>your fixes?

I agree the series looks good=2E But they're not fixes by my reading, so I=
'd be inclined to put them in next for v6=2E13?

cheers
--=20
Sent from my Android phone with K-9 Mail=2E Please excuse my brevity=2E


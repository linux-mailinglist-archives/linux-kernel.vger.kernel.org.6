Return-Path: <linux-kernel+bounces-307646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F29650BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62491C22C70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846421BAEC8;
	Thu, 29 Aug 2024 20:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eWSxQOtA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aw2yiIrM"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B41BAEC5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724963156; cv=none; b=BNbvfjk9dBMveqhacryuqgoS3RR3y8Ee7KEU0RZAH4/4Db31f7ywH3l9C1IhwVzEiqbBJ3mYOFPgPCxs6s8igjK7q25rmg7sov0IsASPOBrv0onQQalgSfEwS+rQYJO8yrgX5PWyEpnWR9pkF8M4jXsxjS+vBW9kOnUyaYOFHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724963156; c=relaxed/simple;
	bh=hLOXJqLw+nrMzttY9OwrwacidposqDabmfTUh9DbRuI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AaOtucqSgPYpmGyAuYQ3dkOgL8zr4P881NMMMP8k4rOEYVlUTSmBvPq7X4LGe7OWkM+mvr05EIbQCaC8tN9uRWLJLiJT1aI5WfzLFQtG1tP7junqA27uxXgUirolc/LZzOJq7QHeBMaJYoedCZJ57BTRPzC4yRxw1/BV/1o2YEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eWSxQOtA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aw2yiIrM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id ECF2A1387F34;
	Thu, 29 Aug 2024 16:25:52 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 16:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724963152;
	 x=1725049552; bh=RqNxdmkgXgvaXl6yDrU5g8iCj93w+09GrKsSBMcpsOE=; b=
	eWSxQOtAs7vZ/MBf4b6lS36tOtwE4fxu8+dScNQZxGjFpQzYY8SzceWA9Bys/x1C
	gTGNOAm5jJNtpGUM6l0r/a4Kx2g/u5rlC6LKi2yJVG9SuZsC9EnHcYHyPFnNI70N
	UexD8KOtRvzhrDP7nmODoLzKETJFbtmwh+fBzcqiq4dUMwlibR97JfPW5pXt9NrV
	eD97L5eIqOCkBF8BEaz3nC7txuDRnTG32kq97KKisdS0jSSz409k38lh/n2DWdVL
	yU9DfLuUsWFvgq8fCWrAH5G1lqE95hL1RhJp2MuRrNyUZ3xAFCoZiqJt2gDvRmrM
	Ihp8TOGXI35LAzwQzHPW3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724963152; x=
	1725049552; bh=RqNxdmkgXgvaXl6yDrU5g8iCj93w+09GrKsSBMcpsOE=; b=A
	w2yiIrMMxlMI7qFHlWM53lsfgS6AJN7UV7wxV4YOuGwvzYtJ7cYRA8kA9bbhLK6L
	C98JTdm2lvISWhH/QIP2r3wCsN3fgTSClM6emEZQRDOaLJP3qKMVfse2TFIGZJjP
	WFwsA9gqHwC7hbwK58d61SMXGJuNk8ZgTUHxJaNfTvfCNN0og+kFQyyC7GdvEbaq
	r4sF5EfUOG4Bf5ztZHmLg7qGGilRZowG6u8erHnZEiPUadOsOBYN01fuRO5ahyv1
	7dApQ9rOPzw8wlpAgNVKjlomuzU/v3prfQZWFZLwgo5G7xIDNT+1oknHlcv1IFFU
	Pl62UWadjdrDlkdc8dXIQ==
X-ME-Sender: <xms:UNnQZkwSwo8HO20VoZ3naTdgMkF63P1cBmYrBMnFWjveYFrLgmIJ9g>
    <xme:UNnQZoQuGKCpAQ7gUkcWpkTtn67wFTQeTO49cTNRcYy4iPkHzHZapxl3K6MmxVfXX
    xtlElGenmOheKA3B1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvvedtgeelvedtveejtdeijeefvdevheefveel
    leekiefguefgtddvudetteegteenucffohhmrghinhepiiigvdgtgedrtghomhdpkhgvrh
    hnvghlrdhorhhgpdhllhhvmhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrghthhgrnheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhgrshhonhesiiigvdgtgedrtghomh
X-ME-Proxy: <xmx:UNnQZmW-JjWYMnYpYe7alEkjqvosG3bptmRZG27RNBQHNVhPrmiMmQ>
    <xmx:UNnQZig7jdDP1TUyKHQifa_UNoXzd3MNVI3ZY8bp9BSiFDZPF2IBeg>
    <xmx:UNnQZmDkayRXazOgVrSai9OMM-xIXsJsO5vUOUzI0LQyeXslD8Iafw>
    <xmx:UNnQZjIZhbqtorbjVC9Wm4i3QSK0D1kM4XYXN7JFJPM42-GMBJXK8g>
    <xmx:UNnQZpMdaxMns7U1XTbPOK9Uuo7Y2ymupknVnKOsFMra2Fvg2hTMgMED>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9EA06222006F; Thu, 29 Aug 2024 16:25:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 29 Aug 2024 22:25:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
Cc: "Nathan Chancellor" <nathan@kernel.org>
Message-Id: <f7069edc-a152-425f-afb1-8df326d0131c@app.fastmail.com>
In-Reply-To: <ZtCZF_yaHnECJyZ1@zx2c4.com>
References: <YmX7z+BirkA3VAfW@zx2c4.com> <ZtCZF_yaHnECJyZ1@zx2c4.com>
Subject: Re: odd endianness toolchains for crosstool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 29, 2024, at 17:51, Jason A. Donenfeld wrote:
> On Mon, Apr 25, 2022 at 03:39:27AM +0200, Jason A. Donenfeld wrote:
>
>
> I decided to give it another look, seeing if I could replace my musl.cc
> compilers with your crosstool ones.
>
> The actual changes required weren't so bad:
>
>     https://git.zx2c4.com/wireguard-linux/commit/?h=update-toolchain
>
> But there's not universal success:
>
>     x86_64 - good
>     i386 - good
>     arm - good
>     armeb - MISSING
>     aarch64 - good
>     aarch64_be - MISSING
>     mips - BROKEN (doesn't like -EB)
>     mipsel - MISSING
>     mips64 - BROKEN (doesn't like -EB)
>     mips64el - MISSING
>     powerpc64 - BROKEN (wrong powerpc ABI)
>     powerpc64le - MISSING
>     powerpc - BROKEN (builds but some binaries segfault)
>     m68k - good
>     riscv64 - good
>     riscv32 - good
>     s390 - BROKEN (should be called "s390x" instead)
>     um - kinda broken (but not crosstool's problem)
>
> To try these, I've been running:
>
>     ARCH=aarch64 make -C tools/testing/selftests/wireguard/qemu -j$(nproc)
>
> or similar, against this tree:
>
>     $ git clone -b update-toolchain https://git.zx2c4.com/wireguard-linux/
>
> So it looks like it's not quite there, but not bad either. Just FYI in
> case you're interested.

I wonder if the ones you list as missing all work with Nathan's clang
builds from https://mirrors.edge.kernel.org/pub/tools/llvm/ instead.

As far as I can tell, the main missing bit here is libgcc, which
is not always built along with gcc for all possible targets.
The llvm replacement for libgcc is https://compiler-rt.llvm.org/,
and you may have to build that in addition to musl when you try it.

I don't know if compiler-rt also works with gcc, but if it does,
that should fix most of the ones that you report as failing above.
The only one that won't work at all is um because the x86 toolchain
is already unable to build a kernel for that.

      Arnd


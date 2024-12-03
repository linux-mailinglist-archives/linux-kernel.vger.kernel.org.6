Return-Path: <linux-kernel+bounces-429213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3949E9E18DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F349E166C18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32101E0DD2;
	Tue,  3 Dec 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="YoXQmWqa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5q+31Ol"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC81DF74D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220533; cv=none; b=ON/BvN0xH2lURuqYLjnAavnp4Z41KL0wg7Kvt7MdZFC4ZiYAufWr/dML5z4b/kwWbMjVNnRcKXOX15rc8eqCcKlqIXfdbysOQuHGgqkr/KZ4hATR9yNkR7pPVNPBla2gHxLrbBxX6HVMSI/qWBIZ9vQ7mK4CHzlIM0NJnd95Bnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220533; c=relaxed/simple;
	bh=MG8W4Va83v8slZiCpe/OsA1IKuewjFUF7vSXnC5IBuA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M+N0cvbmsAqn0M5VhXUWj916DuK8XDi97j75BFbfAoyS6FOfjMk7uVhR/Ngs+7kAQAHJ8dwRjXH2x/87MzeSa32gKgzG2Am8dmxElhC05r+0OXd2EAdQxHQ67DAqRaY8kdq2uwucTl5ujPfNE4XmYYZPsyXomUPdn2HrezoAcKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=YoXQmWqa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5q+31Ol; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D16EF1140109;
	Tue,  3 Dec 2024 05:08:48 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 03 Dec 2024 05:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733220528;
	 x=1733306928; bh=24kNbAf2DV9qqwNGoDvbA1XyQw+YLYxtcrmKEHcOfOI=; b=
	YoXQmWqadtJcnc70qtzKm40uS4bC/GMOkqoHIfm62TBcFDALwVW8juW5MgGEB1YQ
	tgJHw9+OGZBNVVwQ0UbVK5Dza4i9Q0IGfWBsdOsbNo2r/fQVHqs9hhJEgSnAB8GT
	efzOJT8a/fIxjn+1oiMumVD+i7gWD5u+++E/PF0NMIE6hKCW2z1yx9yn+OrVNmEN
	AqTniePcXQXEvOHHNBjClcAJrrFWYf/apBuPg9p8/b798LxTqkhH9wh0Z4P6tZL/
	5rSL08XNA4iPjHpzFc62bHAjvCmIkxfvLuRqMHxlmOOTRCwaokvNqFcw4mA5hfii
	Rdip1ucVZoRT3F5JnvvRMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733220528; x=
	1733306928; bh=24kNbAf2DV9qqwNGoDvbA1XyQw+YLYxtcrmKEHcOfOI=; b=f
	5q+31OlGFiGOXMEBuOCfkEe044TMNI5QHd4qIWUcwJo3oDqZBBOB0gTayYaj6ALl
	Ju6UcKPwyHo2rFlvzgdCyBDtZUgQy+VgnPou6kF5XtgpaSpzHvBNflWN9TqdMbYb
	+h+9BsD/bRvgN+NS7pTLw97dJuzKnoJg7ogWozO7DJScl3bXWHphYO0B9J0xD/4i
	DiSAunJy4+iTeS6twSTuV8s1+0E7RkCKHZ8itmlVjCNQnRXv4GJe/9p1bT1y6jTh
	WZx3uwxjWtgLPUcKObKlPT/bJWI7Vs2g7oYKgZ4V3Uj403Xqj2GPaTYHXj259Blw
	jJ/+9WdiWhUgkFg++Dkcw==
X-ME-Sender: <xms:sNhOZ6zHTtp7SjSpgoPJ5j15kSjKQeWRWKROl970_d0fW5Vdp5xG7w>
    <xme:sNhOZ2SodT2n-rhOWy3WSuHDMQvr_qeMw_erFL-xujF4EX1M0CXqevdh3B7UPqmXq
    6RhX4sWnshRQ4yaWto>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidroh
    hrghdruhhkpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordho
    rhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhulhhirghnsehouhhtvghrqdhlihhm
    ihhtshdrohhrghdprhgtphhtthhopehjvhgvthhtvghrsehouhhtvghrqdhlihhmihhtsh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:sNhOZ8Xi8sv7AGW58kvqGWMlzGRGRBpRhD1QO5GOcB6Mki2N7Fys9w>
    <xmx:sNhOZwj4pjYFhUOct2ToTKJUmpYXGfJpPdM0ifmWN4RzbCTLyoxOug>
    <xmx:sNhOZ8CPkht2LHwOKdjB0PxRGzZMRh19aZ6PKviYTurgsye_mdWlDg>
    <xmx:sNhOZxJRdPCYRfJbw_7sMVwi9279H1UTdnUK44wZOzyS3kkvFEBHVA>
    <xmx:sNhOZ75q0xqZBGoOEAh_V4Sfd733ngs-lKLzef4mJMZlfInk_-gpDkoh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4DDE42220071; Tue,  3 Dec 2024 05:08:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 11:08:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@outer-limits.org>,
 "Russell King" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Julian Vetter" <julian@outer-limits.org>,
 "Linus Walleij" <linus.walleij@linaro.org>
Message-Id: <609b026d-d54c-4a11-b7df-6ef0ac315f25@app.fastmail.com>
In-Reply-To: <20241203083838.3260036-1-jvetter@outer-limits.org>
References: <20241203083838.3260036-1-jvetter@outer-limits.org>
Subject: Re: [PATCH] arm: Remove IO memcpy for Big-Endian
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 3, 2024, at 09:38, Julian Vetter wrote:
> From: Julian Vetter <julian@outer-limits.org>
>
> Recently a new IO memcpy was added in libs/iomem_copy.c. So, remove the
> byte-wise IO memcpy operations used in ARM big endian builds and fall
> back to the new generic implementation. It will be slightly faster,
> because it uses machine word accesses if the memory is aligned and falls
> back to byte-wise accesses if its not.
>
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
>  arch/arm/include/asm/io.h | 11 ----------
>  arch/arm/kernel/io.c      | 46 ---------------------------------------
>  2 files changed, 57 deletions(-)

I'm not sure if this is safe on all platforms. Big-endian arm
is extremely rare in practice, and in comes in multiple variants
that behave slightly differently:

- On modern ARMv7 the byte-invariant big-endian "BE8" mode
  generally well-behaved and works as one would expect it to.

- There is one ARMv5 "BE32" based platform, the ixp4xx, which
  works differently, and this in turn allows multiple configurations
  for its buses where a byte-swap is performed in the PCI
  controller.

When the little-endian I/O string operations got optimized to
calling the word-based helpers in commit 7ddfe625cbc1 ("ARM:
optimize memset_io()/memcpy_fromio()/memcpy_toio()"), Russell
intentionally left the big-endian versions alone, which I think
was done for the case of PCI on ixp4xx, but could have been
out of general caution.

Before we apply your patch, I think the minimum would be to
have Linus Walleij try it out on an an ixp4xx with a driver
that uses these functions. Maybe Russell remembers the exact
constraints that led to using byte access for big-endian
mmio string operations, and whether the new lib/iomem_copy.c
version causes problems.

I also looked at the little-endian arm32 version, and
it seems that here the generic code would work fine, but
the custom variant is likely much faster when both the
source and destination buffers are aligned, as it can
do larger MMIO transactions using ldm/stm instructions,
though the generic version would be a bit better if the
in-memory buffer is unaligned.
We could get the best of both by implementing optimized
arm32 versions __iowrite32_copy()/__ioread32_copy and
using those in the generic memcpy_{from,to}io.

       Arnd


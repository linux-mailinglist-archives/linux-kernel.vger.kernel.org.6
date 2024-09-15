Return-Path: <linux-kernel+bounces-329845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B276B9796A8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27AA1C20F11
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDEB1C579D;
	Sun, 15 Sep 2024 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JjMqU2h4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE9184E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726404541; cv=none; b=c++0UXxQTtPouVYG0JDboA7M/DM5D3sZI8DmBSTc5U2StUZgZN9g7B7MfyTdpUTLFtyLWZ4XzSLv4lqu7IUPE3ZjhLbQP3xvyrpk9Kxtw5pDn5T11JBqgLu/FI4FlvcT6zEWXQKTbann2G4QyAkRlp2wOonnoeO6mExgWmC7rZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726404541; c=relaxed/simple;
	bh=qVRP/dgmh6U4Hg5y3CGOE++A5+kvwiVLlE8hoiQFl+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOQMsERzBFIT0/A7dfKuA3BLQ6gHgj9SPfBlQqFwXxYfJSX/UcdlHhA6sXi0E4nIxReVbZoI899rrU1g2D0ZHM7xk7UFxXSZjHxKq1B695sFUrFkB1wF+BPOPy6Ozpir6KfoxZi//PXluT9vnL2WyGpnjjxum2Ojq4DUUJCfE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JjMqU2h4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2697C40E0289;
	Sun, 15 Sep 2024 12:48:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id t8wrKQS7D4WO; Sun, 15 Sep 2024 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1726404524; bh=twWhhJv2IWqN+i3BOP1ACMclSg7Wkbfm6L0PuPo6+X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjMqU2h4X2E0f0w2RHFQ1MY0Om2YxUNsfJJVrgzlUoTcfG09IzV9RYPAl9g22tsGd
	 6gSKdsLs0oDurNFHm9A5GwMvxf4gGImkQNSXKKKid7TlAmSOxRmz+mWDtaR/i+1ib0
	 eSDCeU3QMqriUIHGH7v9OX9TZ48em8PH5TcWo/y1mHcp3v9+0TFT9s8ComoMvuTC0L
	 XXfCdNfmSnIMed28KWaGhlc/9840kCEd6lAiqOxCK4jXiQo6kCVSWQQzTShu+hoC43
	 DbbXLXUjxPfod3hT15dF6R6Ww35i1Go9vJ2oJjCUXv5CUYaYAVzf9l/AbQay92kYRu
	 /gZE0Jt8xDhu5t8hnpe1x+pvFxcxSYcvUWKNcN3rKCKeTqJrWzGXuO4w8/jC1THbeh
	 +EG0D0lotRrVe37RlmacXU77H2bEs+BARQufSj2q92VZBQefkDDSoljIa9zQEZXCAL
	 S7jGa8NPMn0wHyTCAk0Pthtc5JacI/MF0CfTQ08i5xXqBvYjdKoqRexjb8f5oiDBWh
	 D0CHqYKTgcsxuFYRzzSobHGhKdEocwrhffTAfiJks7lYOIl8ZIaVswaNeqx6ufWNqD
	 P2mXm3LtYNuW4EE74lA+zK2fnuqDJSLab18MpWZxxuM1l/wc0gFLziUwxXeLJaEqMY
	 fVH3hM6x7xLtJKpvmurpsIJo=
Received: from nazgul.tnic (unknown [88.128.88.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADD0040E021C;
	Sun, 15 Sep 2024 12:48:36 +0000 (UTC)
Date: Sun, 15 Sep 2024 14:49:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: John <therealgraysky@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Message-ID: <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>

On Sun, Sep 15, 2024 at 11:05:52AM +0000, John wrote:
> GCC 11.1 and Clang 12.0[1] allow for the following new generic
> 64-bit levels: x86-64-v2, x86-64-v3, and x86-64-v4.  This commit
> adds them as options accessible under:
>  Processor type and features  --->
>   Processor family --->
> 
> Users of glibc 2.33 and above can see which level is supported
> by running: /lib/ld-linux-x86-64.so.2 --help | grep supported
> 
> or: /lib64/ld-linux-x86-64.so.2 --help | grep supported
> 
> ACKNOWLEDGMENTS
> This patch builds on the seminal work by Jeroen.[2]
> 
> REFERENCES
> 1.  https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9
> 2.  http://www.linuxforge.net/docs/linux/linux-gcc.php
> 
> Signed-off-by: John Audia <therealgraysky@proton.me>
> ---
>  arch/x86/Kconfig.cpu | 60 +++++++++++++++++++++++++++++++++++++++-----
>  arch/x86/Makefile    |  6 +++++
>  2 files changed, 60 insertions(+), 6 deletions(-)

Patches like this one appear off and on on the mailing list and each
time I ask what's the upside of maintaining this complexity?

And everytime I get no reply or random handwaving. That's because -march
settings have no noticeable effect on kernel code generation. Because
the kernel code is already pretty much optimized when generated by the
compiler and all those flavors don't bring anything additional.

So this is not going anywhere. But hey, I'm always open to nice
surprises...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


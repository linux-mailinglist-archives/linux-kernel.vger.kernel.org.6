Return-Path: <linux-kernel+bounces-212281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721AF905DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D79B22686
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CE126F02;
	Wed, 12 Jun 2024 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oo2oEiyy"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD021360;
	Wed, 12 Jun 2024 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227947; cv=none; b=jZJqz/L4mazuuBbPzLB1zmtncmCBQRetdEIPskCqDdmwn6Z7fDYNVWWoJKsovly7wHZttyrWAq8D9rrq1KWIjCo3l9RcjOTUkgMgqxJ+L3GAdoe6a2HqWRAOCQk3qxfnGhoYEbOS8yN2eIwHLUOPWldXAYuLkoknBbrerYcsxkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227947; c=relaxed/simple;
	bh=EOKbcnt6rurpfvI1kMjeCMyOhouYKbzIbHo7o2o1e0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lA9EGR5g08yPPLbEXkIdjn8U8nguQk8ITQhsRwiBPOzKy2ssfJ3yqt0b16lSZsq4hzqMk9Jmipc2HZE/YH6WYuxw792cKhsLpdLwqgbdODb8fv6yNPwDc+QS/zsC0VdEbXYvzTzZ5AJ2Wv/AJaRn1yGhb5izATNT2YuVSiqItbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oo2oEiyy; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E7E7845E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718227945; bh=efWY5Xij91b91tKq7ztvtBG+eCPq3ycx19cYryj8860=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oo2oEiyyL3ZzhorBWkO098Y8kGjUikJSut6adZZ+QuiVg9sD6pBwlNbtD8xdO86g7
	 VjhAzclNtXZ6eEwjezQtZcaAL5gLkX15SIY+XSQa9CkdpjOa1+selaXInvIT3vc1kD
	 hCtr5Jm5IhZz7QgkCyVz2mGQNGzSIcrVlPBbS8lOSxCosy8WlhPR7BAt0qB6mPWKyS
	 wDKXtMJtO2lZOZjZT4DbgQTV88zRh5PuOneeDWSymSxvWOG8LDFhoi++hJAQt+S2uM
	 4/GjdttlcfdLOcR+2mN/rNrzpZ9sDrx8Yj6nEHM8HUFeNzReqjGivLn18id3IA6Qpy
	 WEEJ+dVHuju7w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E7E7845E09;
	Wed, 12 Jun 2024 21:32:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jinjie Ruan <ruanjinjie@huawei.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
 jpoimboe@kernel.org, tglx@linutronix.de, rdunlap@infradead.org,
 xiongwei.song@windriver.com, wangkefeng.wang@huawei.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH] Documentation: kernel-parameters: Add RISCV for nohlt
In-Reply-To: <20240604114005.875609-1-ruanjinjie@huawei.com>
References: <20240604114005.875609-1-ruanjinjie@huawei.com>
Date: Wed, 12 Jun 2024 15:32:24 -0600
Message-ID: <87le39oniv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jinjie Ruan <ruanjinjie@huawei.com> writes:

> Since commit bcf11b5e99b2 ("riscv: Enable idle generic idle loop") enable
> idle generic idle loop for RISCV, but the document is not updated
> synchronously, so update RISCV support for nohlt.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Fixes: bcf11b5e99b2 ("riscv: Enable idle generic idle loop")
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon


Return-Path: <linux-kernel+bounces-435346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BFB9E765D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64D0165890
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD041F3D2D;
	Fri,  6 Dec 2024 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XQcXF0K0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E520627F;
	Fri,  6 Dec 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503661; cv=none; b=XCyOu0YQxkPmpFcdiq5jJXehxiwNk171tg9cQ0B29Z4zB9lbRzyXzqSKAGQtbfW6/6MMKP4vc8V4XeJF4ud2FuWqhEc53jtUOZX5SmHOYNsMa7w1Yl3teX7TWUw5SIvwv4mgkUVhi912R/RMY7rq7muQncXTc6NLZjWzlz1T408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503661; c=relaxed/simple;
	bh=kvE0y4dFgneEl0Xw4h78GAQyKPGVaNI2DxPT0S+gJgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZNplnS/OSTH042BRxqEH6CPv4Ajt2L60bTicy9tbgRONKFUt4ZP+Y+Y8XFloPAa3GYHc9OvmSDrOR+cmrisMD5vVRq5EjNpB2/dOItf8CfiC7mN88ibWxmElWgvS9SlZ0Z7JDJyNzESX6ecwe59V0oKngc8gWhySoKIZ6zdUcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XQcXF0K0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1AFEF40409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733503659; bh=PSEFYRD5HPP4WZPiIKjB1GYPa+JV0S6EbNMDEY+qpB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XQcXF0K0yueFjTcsx6fWvYkD/PYs3+k9Q6p1Igjct9xFlHmofbGtlfSR8JmAW1M2x
	 SMB9L2pyMp2Wt7rnHGVng3X8goQKyVLXxaOB73EZSTXO0ILSWtQ5/hD8CYPcXY5kzU
	 VkySquII2r41kGxp1Z6e2pHmGjO7tfR2HaAdqk8HCKLhPtj7h+iXdSI+UvM6iO3q2e
	 1+UUzxSRjai4ge2oVdRWS9wF0z+EnUdJu+id3rfuiWhTH1agpeQVzNVqaD0EF0jTBa
	 59Gx6uRMVhpHBgwjxo7Cg4k56eTZm2QG4t89A+BjvLQn00/geEf6EyAwVeJKLr0LWy
	 pPxsmxjYiV6OQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1AFEF40409;
	Fri,  6 Dec 2024 16:47:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 0/3] x86/Documentation: boot.rst: More style &format
 fixes
In-Reply-To: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
References: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
Date: Fri, 06 Dec 2024 09:47:38 -0700
Message-ID: <874j3gu5at.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> The boot.rst is combined from the pieces of different epochs, hence has
> some inconsistencies in style and format. Fix (some of) them in this
> mini-series. Rendered result has been manually checked for PDF and HTML.
>
> Andy Shevchenko (3):
>   x86/Documentation: Make Literal Blocks to follow reStructuredText
>     specification
>   x86/Documentation: Align Note Blocks style
>   x86/Documentation: Elaborate Intel MID device list
>
>  Documentation/arch/x86/boot.rst | 369 ++++++++++++++++----------------
>  1 file changed, 184 insertions(+), 185 deletions(-)

How were you thinking of getting this one upstream?  I can take it
through docs if that's what's wanted, but would like an x86 ack first.

Thanks,

jon


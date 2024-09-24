Return-Path: <linux-kernel+bounces-337460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB096984A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB7A2861C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF31AC42A;
	Tue, 24 Sep 2024 17:38:09 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BED1DFFB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199489; cv=none; b=FUX0XYqiwKD9MRBlmkhaIvkT1M4ZFaRZPUoo46SXCczwRtVXZaj9ldh6FWOGwzCiI8d+XO3r/kHzeO6rnZsFBeUk93gfon0hNgtQqrlDrt4O+uFgUBwyd1Kn1EJro9oAzr093o+PoE40jM54EPz52q7+HXNfwWTXgxQAlXiLa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199489; c=relaxed/simple;
	bh=N9W6KE7gEwcnjbOHS4aFtMGjuhz3vA/5voXxNGyHbus=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FJ4fYZbyhYx6/aNW7eItB0xGQyR13YXy4T57ZMTRSZIEEsHcyvabXyjLiQXacJypqB5hetUlXf0F7LTm485EapIT/3mlDWMR7J4wh3/7Nh9dvVIM5e/wrfP7v8WPxIQnB9lknzx3yn8LmXaoUo2PnIQWUkC+L+NbU6A2eCUSNmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XCn176mvRz1sB7f;
	Tue, 24 Sep 2024 19:29:47 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XCn174F82z1qqlS;
	Tue, 24 Sep 2024 19:29:47 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id eiIBmgS3VUyq; Tue, 24 Sep 2024 19:29:46 +0200 (CEST)
X-Auth-Info: /EBdu7j+LPwEP8cbuGwU99idD/PbqmRwkq94ZtujynXb6g97VQOYiS5cz/OwqWDQ
Received: from igel.home (aftr-62-216-205-79.dynamic.mnet-online.de [62.216.205.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 24 Sep 2024 19:29:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 6DAC22C19CD; Tue, 24 Sep 2024 19:29:46 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tony Ambardar <tony.ambardar@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Arnd
 Bergmann <arnd@arndb.de>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Tue, 24 Sep 2024 15:55:20 +0200")
References: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
X-Yow: Don't hit me!!  I'm in the Twilight Zone!!!
Date: Tue, 24 Sep 2024 19:29:46 +0200
Message-ID: <87bk0d2c51.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sep 24 2024, Geert Uytterhoeven wrote:

> All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
> the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
> x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
> The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
> fails in the same way:
>
>     error: ‘retain’ attribute ignored [-Werror=attributes]
>
> All my gcc-12 compilers seem to support the attribute.

That ultimately depends on binutils support for SHF_GNU_RETAIN (2.36+).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."


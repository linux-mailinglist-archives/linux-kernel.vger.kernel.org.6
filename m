Return-Path: <linux-kernel+bounces-343102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9849896CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 20:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A31C20A62
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82D55897;
	Sun, 29 Sep 2024 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lZotxcRk"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84A364BA;
	Sun, 29 Sep 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727635577; cv=none; b=kRQTJaZvLdBvWljaEUbKxb0Fwj9Rj5OkXB2M5kwOd05De7qYu1yJ4JTmHVgEotprR5jih3/ib3fhz9c51D1QUbOJtejb5gh3VSKs19efqHqv5vXZK9cD8PwdQqsI9RL2LxrRrA8ab9fdb9aiIvelDdfvgvc+sB93xyK+ayFnMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727635577; c=relaxed/simple;
	bh=RjMxtxQDuLXORe76uqEGn8mOtgsRg5/ahz/7B2p9fuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WJqI/NtPgt5j8lZQ51in2EOXuYKOLrBVIGch4h09TCkkA2Nk/flmquMbv9x0YP9HYGOJALNUjQ6in2JPkmw6Iwvjc62TwFV4EZjmoCUcClDM6QF1NZ7+LibQb8mc9v0JjIB9syqrbKQ0rsU7cGl6GiYnMHz8clTVpyM6QeqCq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lZotxcRk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D0861418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1727635567; bh=gmDrMhG7sZH9BFaRoq0xQy2ReKc1UDllwoB2/ScS7bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lZotxcRko0b/kaguCB7QOUOHdFO+dglv00DzGLL76RO2fcOqPZ8iZGUv51MrgevXF
	 B2zNyaWqWPf3YQif0aO4mtlDMJ1uwuecCKbuBx6h/e9FJrVrj8xeXVsRFBRCzpDiSv
	 voRKBvo8/tiU4P6HM6DDepebPzwJxoUhDkcnWAubMgHgpZc8dC4kHzNU9DHmEIfC/n
	 ZqP99Pa77mIiDVkp44x8WwsrGa57UAIrGhRAV5MbH2Lh5UovaR2sRR57BXraWQAyRa
	 4Ngqrr+gDF68ZM3+ETcBhXDojGJTF8cPC4HL4mbsrcP7T1BLX12tdX7lyU1wuHcbUB
	 D+RPEo+Q7EK+A==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D0861418B6;
	Sun, 29 Sep 2024 18:46:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Nam Cao <namcao@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, =?utf-8?Q?Cl?=
 =?utf-8?Q?=C3=A9ment_L=C3=A9ger?=
 <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, Charlie Jenkins
 <charlie@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: Fix typo MIMPLID -> MIMPID
In-Reply-To: <20240929153305.m8IHY_7l@linutronix.de>
References: <20240925142532.31808-1-namcao@linutronix.de>
 <87h6a3fw74.fsf@trenco.lwn.net> <20240929153305.m8IHY_7l@linutronix.de>
Date: Sun, 29 Sep 2024 12:46:02 -0600
Message-ID: <87ldzab8np.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:

> On Wed, Sep 25, 2024 at 12:02:39PM -0600, Jonathan Corbet wrote:
>> Nam Cao <namcao@linutronix.de> writes:
>> 
>> > The macro that is really defined is RISCV_HWPROBE_KEY_MIMPID, not
>> > RISCV_HWPROBE_KEY_MIMPLID (difference is the 'L').
>> >
>> > Also, the riscv privileged specification names the register "mimpid", not
>> > "mimplid".
>> >
>> > Correct these typos.
>> >
>> > Signed-off-by: Nam Cao <namcao@linutronix.de>
>> > ---
>> > ask me how I found out..
>> >
>> >  Documentation/arch/riscv/hwprobe.rst | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
>> > index 85b709257918..fb0affa61eb9 100644
>> > --- a/Documentation/arch/riscv/hwprobe.rst
>> > +++ b/Documentation/arch/riscv/hwprobe.rst
>> > @@ -51,7 +51,7 @@ The following keys are defined:
>> >  * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
>> >    defined by the RISC-V privileged architecture specification.
>> >  
>> > -* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
>> > +* :c:macro:`RISCV_HWPROBE_KEY_MIMPID`: Contains the value of ``mimpid``, as
>> >    defined by the RISC-V privileged architecture specification.
>> 
>> You should be able to just say RISCV_HWPROBE_KEY_MIMPID() without the
>> :c:macro: markup and have the right thing happen.
>
> My .rst knowledge is limited, so I probably miss something obvious, but I
> couldn't get that to work.

It's not RST as such, it's an extension that we've added for th ekernel
build. 

> Do you mean something like below? The brackets do not seem to do anything
> and get treated as plain text.
>
> Sorry but you probably need to show me what to do exactly :(
>
> Best regards,
> Nam
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 85b709257918..4b4b4ef0e0f9 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -51,7 +51,7 @@ The following keys are defined:
>  * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
>    defined by the RISC-V privileged architecture specification.
>  
> -* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
> +* `RISCV_HWPROBE_KEY_MIMPID()`: Contains the value of ``mimpid``, as
>    defined by the RISC-V privileged architecture specification.

Try it without the `backquotes`.

Thanks,

jon


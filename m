Return-Path: <linux-kernel+bounces-343038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7EB98961B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D366E28225C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0E317C219;
	Sun, 29 Sep 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M859z1De";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VOLfd/bQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8695C14287;
	Sun, 29 Sep 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727623995; cv=none; b=hi3h82o7sSGPVGWKYqe5obFBEtJprjz3kgfAj2HdsJFbQk4SQx24cgcU5k5wDJJq9P+L74OnplRsipg2bFiQZl7mzF7exY264fm0C7fI64EhRTZvI0qWCgi5bVIVcd23jnqnV01hOJi3rRGQjwGmEnHckfXQ6+XtzAEsgQQ2qz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727623995; c=relaxed/simple;
	bh=dnstHy1AWjgOiKbxJzIuM+1ZRIpK9B1RSrlUMNjvXRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIhv3AvWl6myCWusDFgnH7SQoCYlOPWVKtZ8/US6H64xyB0m2i3u5izh5CqaQchL3e7YT8pBBrXdYxG7i4c0ZpNGttpmIfKg+E6oRTpyE3aFVmqT0g2P8AX7dD1X4aHFR0m/MXkgnpmYL45yp+VKEkaBQHuBd3EusHcnz/uY+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M859z1De; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VOLfd/bQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 29 Sep 2024 17:33:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727623991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gsGi8fTdkDcmJzk7dV7d8IvixwZDjA6Zah8Vb/3I30=;
	b=M859z1DefwlRKGAU4Q3SEdJZgXQh3ow+SoL9Fivllc9WBMzZErU+cQFJ97VsvpmBuaZsSf
	IjIqY5lp7/lDseQ5eykOII4yiSyrCKzctUpEzYzXpVM2qhhoMGzN6SSYHjCy2G/TsLGJQ/
	0tNKULx7gdnAPWDae7TERI8clJshFBVTd5G9vmeQfIygFTqfqv+5GGxIr2qgSKXr++MJIa
	NaoxjGN3svxh1UpNbsaMALdZ8xaWRujbQtixUnQpbKAP/TMRrrkLUUNnS/Aufp30+x7R1O
	6MXpY33o/VU8UHjNLtknE7YNC9l/OQ0q/oDAurAzUugJvfwwbwFFpSFH7b5kbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727623991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9gsGi8fTdkDcmJzk7dV7d8IvixwZDjA6Zah8Vb/3I30=;
	b=VOLfd/bQWzYYXYJ82FqiyEZH/lMqD5rWjq63zTJ/aRHrUcHy5MpK/fSJJL03O7tpRiZ/s4
	nHEJm9E3zWx2lNCg==
From: Nam Cao <namcao@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: Fix typo MIMPLID -> MIMPID
Message-ID: <20240929153305.m8IHY_7l@linutronix.de>
References: <20240925142532.31808-1-namcao@linutronix.de>
 <87h6a3fw74.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6a3fw74.fsf@trenco.lwn.net>

On Wed, Sep 25, 2024 at 12:02:39PM -0600, Jonathan Corbet wrote:
> Nam Cao <namcao@linutronix.de> writes:
> 
> > The macro that is really defined is RISCV_HWPROBE_KEY_MIMPID, not
> > RISCV_HWPROBE_KEY_MIMPLID (difference is the 'L').
> >
> > Also, the riscv privileged specification names the register "mimpid", not
> > "mimplid".
> >
> > Correct these typos.
> >
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---
> > ask me how I found out..
> >
> >  Documentation/arch/riscv/hwprobe.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> > index 85b709257918..fb0affa61eb9 100644
> > --- a/Documentation/arch/riscv/hwprobe.rst
> > +++ b/Documentation/arch/riscv/hwprobe.rst
> > @@ -51,7 +51,7 @@ The following keys are defined:
> >  * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
> >    defined by the RISC-V privileged architecture specification.
> >  
> > -* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
> > +* :c:macro:`RISCV_HWPROBE_KEY_MIMPID`: Contains the value of ``mimpid``, as
> >    defined by the RISC-V privileged architecture specification.
> 
> You should be able to just say RISCV_HWPROBE_KEY_MIMPID() without the
> :c:macro: markup and have the right thing happen.

My .rst knowledge is limited, so I probably miss something obvious, but I
couldn't get that to work.

Do you mean something like below? The brackets do not seem to do anything
and get treated as plain text.

Sorry but you probably need to show me what to do exactly :(

Best regards,
Nam

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 85b709257918..4b4b4ef0e0f9 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -51,7 +51,7 @@ The following keys are defined:
 * :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
   defined by the RISC-V privileged architecture specification.
 
-* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
+* `RISCV_HWPROBE_KEY_MIMPID()`: Contains the value of ``mimpid``, as
   defined by the RISC-V privileged architecture specification.
 
 * :c:macro:`RISCV_HWPROBE_KEY_BASE_BEHAVIOR`: A bitmask containing the base


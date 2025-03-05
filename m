Return-Path: <linux-kernel+bounces-546231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131ADA4F821
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80193AB40A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7108E1FBEBB;
	Wed,  5 Mar 2025 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRnvota9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5/sYCjs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC01FBCB4;
	Wed,  5 Mar 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160492; cv=none; b=gd2Py/CmllPsW8kwxVF8VHVEc4/ik50qeuo/XSy+rEWmM1ZoNAq0XccVkfaTcu7Zw77SqZle31mvtJyGH0XYKGtmebmXDd12XGMFkeN1spvSgQLjYKmFoCuTvPQhodLggdsL9N36lSMNIDWxmKJCQ1RRqmtoWNXhm+M0DIduR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160492; c=relaxed/simple;
	bh=U6821Tp0iLqJP+cP8sHBGHgpzXEMWoYaLFAQuW2Xw7U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O+6zprHCZhBurObDnmCdkXXQ7yXuuJbhfhfgffnAPoQZPLWM4foReNHMcd2MoZzehf7aR/6i3N96EwwWz23wQhVggjtCvRhUyEaoWVU7oIT/u/rJjFS3OW5IVkavhRhGvjZu4fRgxka8asFccPIe9cddCqxprRHfHq6+i+ovsJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRnvota9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5/sYCjs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741160489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNEnQU0pyTN9ytzfEL7xzUn8SaDvuW5mh+YI69rPvmk=;
	b=wRnvota9OxP8xA8c4n68M1q9AT72rhK/58Yok3x+y85pGa908DBegMj2nJxQ4kSVyF2cHo
	AmndPcaKCUpf+7+Dn+lo9cNEP0OrCllnvnyZUnHrJd0Xhy6Q/5BrdAAym6nLTQZX23ZjnG
	2GfGhKPvGx9zk4Dse2MnbeRCZiBWTjSaZQKHlv47mB9C37HW3T7Nm/Q6TEtrE3uROhP/fp
	rnkmTqt9RA+hDyX2j6IDddORmoiLKjiVL3sR0m+xsIxJTBM1aVehJQWI3Qr0gAM9JE1ncA
	eocvkWisPEJHF5sLZABO7ANGW3NTry92s6WKaa4aiBZ+5ZqI8MlljbrDlbxyOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741160489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNEnQU0pyTN9ytzfEL7xzUn8SaDvuW5mh+YI69rPvmk=;
	b=O5/sYCjs8JjfUP5tkNS7SuXKdmW5bHio0KtEOf/d0fiKUUfJ8mrn4p7DZ76aeZYncwG0E+
	PhcVVpXm90lX9rDg==
To: Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/15] irqchip/sunxi-nmi: Support Allwinner A523 NMI
 controller
In-Reply-To: <20250304222309.29385-7-andre.przywara@arm.com>
References: <20250304222309.29385-1-andre.przywara@arm.com>
 <20250304222309.29385-7-andre.przywara@arm.com>
Date: Wed, 05 Mar 2025 08:41:28 +0100
Message-ID: <87frjr6i1j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 04 2025 at 22:23, Andre Przywara wrote:
>  
> -struct sunxi_sc_nmi_reg_offs {
> +struct sunxi_sc_nmi_data {
>  	u32 ctrl;
>  	u32 pend;
>  	u32 enable;
> +	u32 enable_val;

The data structure name and the corresponding variable/argument name
were making the code pretty obvious, but now this is opaque and
incomprehensible.

data::ctrl does not even give the slightest hint what this is about. You
need to read up in the code to figure out what it means. Something like:

struct sunxi_sc_nmi_data {
	u32	reg_offs_ctrl;
  	u32	reg_offs_pend;
  	u32	reg_offs_enable;
	u32	enable_val;
};

or even better:

struct sunxi_sc_nmi_data {
	struct {
		u32	ctrl;
  		u32	pend;
  		u32	enable;
        } reg_offs;
	u32		enable_val;
};

makes it clear and obvious, no?

> +static const struct sunxi_sc_nmi_data sun55i_a523_data __initconst = {
> +	.ctrl	= SUN9I_NMI_CTRL,
> +	.pend	= SUN9I_NMI_PENDING,
> +	.enable	= SUN9I_NMI_ENABLE,
> +	.enable_val = BIT(31),

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

Thanks,

        tglx


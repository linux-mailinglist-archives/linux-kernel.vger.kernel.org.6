Return-Path: <linux-kernel+bounces-306954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1869645FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB970281FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478191A76B7;
	Thu, 29 Aug 2024 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ab2CXfyZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rzqzsieu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69D19DFAC;
	Thu, 29 Aug 2024 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937159; cv=none; b=AO62bFP4+NZ+Z0d0zhQ7Nzgx0n3YH7fLyPDFEkmCHK4qle6Q/CLdgtoKQRxxXn7SZe2SHRT294oqoJ7u6QSPq14t98XF27Ig1CjfrBwkwb4Oyz+B60hvkzMkRsCGolpzp2vZHbInEt3gIUIHomX7RowS27wRwTiBu63hmRbN+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937159; c=relaxed/simple;
	bh=9mEiyKRKGmuKE9kqpMPS9u3nFtzd9ezve5vww0FGj8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BN0mTkV0zwzrpub2WPVQTQd8DcYEAKXLMeHO4JoV8K9h9sE70TqfBihWpJh2Vq0BR1CIn5I1vZ2kpZOhvXgVLoGkjg3LWSgLgoTvim9qig1cFN7uzE6ROJkHGMp/fbQdvu59yNYVnoayQcrI6pEMQMVC0MjvhlR2TKPOpmARP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ab2CXfyZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rzqzsieu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724937156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xi8Qk6/yo+z2xue1pu6ArfZkIB9NZHNwbWBMMQVAWw0=;
	b=Ab2CXfyZFci3E7J2IFQD1bogFsly6JhZ33cyfDGBgwNAmovS7p97ZqgUPcCXMh7B5lAdQT
	oB56bXurDz8SwOYX/1DOaR8BjSwK07D0F12Ej4x16nrOxD+H5t9GaP/JEu3tEZDetlATwA
	eviElp7DW5utYgXtVofuBQp8F8abHKr0Eiz7nRXTTq24rX7hV5Brpa/RUx0yUinMmP/CLT
	5p8PSZ7PLkGgJc5y6v3FXV9aebdycZyISifmY4Ar/WBLzJUj9l6ImsE+Wcqnaks8ByvJq5
	EBYErRk80VHmOIj7BiWEPuNYzR8ek6QDKitmkGvWkAgjgFBt1VjKvVkmiw8hdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724937156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xi8Qk6/yo+z2xue1pu6ArfZkIB9NZHNwbWBMMQVAWw0=;
	b=RzqzsieuQComb0N5FzZoQ+NVPc7369MkHiKj2wKiJ27y0LP3lvAYVZMlGclV67Xt0t2Mub
	OD5p2Ey/6DF5xVDg==
To: Nick Chan <towinchenmi@gmail.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH RESEND 3/3] irqchip/apple-aic: Add a new "Global fast
 IPIs only" feature level
In-Reply-To: <20240829110436.46052-4-towinchenmi@gmail.com>
References: <20240829110436.46052-1-towinchenmi@gmail.com>
 <20240829110436.46052-4-towinchenmi@gmail.com>
Date: Thu, 29 Aug 2024 15:12:36 +0200
Message-ID: <87wmjza2wr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 29 2024 at 19:02, Nick Chan wrote:
>  
> +	if (irqc->info.local_fast_ipi)
> +		static_branch_enable(&use_local_fast_ipi);
> +	else
> +		static_branch_disable(&use_local_fast_ipi);

As you define the key to be true by default there is no point to enable
the branch some more. Copy & pasta ...

Thanks,

        tglx




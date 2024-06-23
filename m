Return-Path: <linux-kernel+bounces-226340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA728913D43
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9207B1F21A73
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973E1836C2;
	Sun, 23 Jun 2024 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AuTNeJgg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVt5W9RJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9612217FAB1
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163641; cv=none; b=DG/wnNKdtXKpq/QWxIH98CIG5L0s4uzze7REKkJput9SHydwHsT8sIxOjCiYurqg4HUA8bTnVryZgsfInG9DoyW0Kr/Jy+kiRuIRRsUGurMt5WpjqP9QPBdc4QKci4LiSiPC4bMIMCsSmMCUJ40gvTQa0NmyPmZBV/UCycLqeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163641; c=relaxed/simple;
	bh=SQGb0zjsjmFCjP5RMUYFlggEFHyxOjZVl/TV9jRkygs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TZX1Sw+/l2M1FHdR0H9V0sfVKMcvYuN+8dLnQ58e7sw+pZAM7U7ToWA/GouWkGDTiG0NdzgvNqwSUEjafnFfHlmj2czDRZZ+fuDKFh4EiV1feyNCf82+YpnCYrfeYclMYzsM8WKDbSFNXc2vetNbqTAzz3eDvnc0Ga/PiNfO8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AuTNeJgg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVt5W9RJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719163638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNQgs/jtsewNi1//a25BPwNZEq0Iu3ZSb+SWVutwhWg=;
	b=AuTNeJggR3UvCNRht7/Vqfkhk8Ie1Ert61cYfMxSqB2CktWozBSGp+rZIInLL8CY4gwM8R
	kS357bdUvzZHW5l2/HnEunX7g0EOKOCfEIyZ14RYLdDzZ2q/2HlcNH+/bFRqHl7s3XpZeA
	XNzp6R7F3psZxSQwvrhJTaA725AY+1JdZZH5fZ49jBOBlYwJ1t8u7H6/O9AVETAmNYU//n
	ztKE+3cm7xy5PphUj5mojkKDxLqidgyIc7bcZ/EiWIquibWxT2JLC8CDG3yVJuyFWZTSAT
	lEO0xAwY3f3QTlqCqglrWp4jt4PjcS4UBOgXaJBO/Bsh+MSChPTZeywY9pKhAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719163638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNQgs/jtsewNi1//a25BPwNZEq0Iu3ZSb+SWVutwhWg=;
	b=gVt5W9RJ8ec7jGLru9vnYm+Rd69c6ItC2Y7aPjw79ygAc6tl4YQyxvD6EWoBiwr+iH58T5
	KIfKaOKW2zM4cKBQ==
To: Antonio Borneo <antonio.borneo@foss.st.com>, Russell King
 <linux@armlinux.org.uk>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] ARM: stm32: allow build irq-stm32mp-exti driver
 as module
In-Reply-To: <20240620083115.204362-8-antonio.borneo@foss.st.com>
References: <20240620083115.204362-1-antonio.borneo@foss.st.com>
 <20240620083115.204362-8-antonio.borneo@foss.st.com>
Date: Sun, 23 Jun 2024 19:27:18 +0200
Message-ID: <87le2va7t5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 20 2024 at 10:31, Antonio Borneo wrote:

> Drop auto-selecting the driver, so it can be built either as a
> module or built-in.

How is the driver selected then? Has this to be done manually now?

If so, doesn't that break things when starting from an empty config?

Thanks,

        tglx


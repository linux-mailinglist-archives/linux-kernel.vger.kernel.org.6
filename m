Return-Path: <linux-kernel+bounces-179961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38A48C6822
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C99CB24EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 14:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AABC13FD65;
	Wed, 15 May 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="woyymNwH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fs12Qqsw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5B13EFEF
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715781508; cv=none; b=iRGoj+iHwalWVl0RHAkZ1WCZOdFoaAmKrOlYd/ZyGZ3vQqiiwpLgRis+VFLc2yD9QIf0wMawE8g8X/P0g/xLFwIDVKxvtmHs263hlooDc34nOJZsWluDQYNOeCxenNxp/0M1/P8TRCHMeK3N92FJ7GFdSLX6G4mk5FyfMthIye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715781508; c=relaxed/simple;
	bh=E+7nNphptL+TRxLMeDw1zOU56LjsxRvw8zXBEuRZdSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s0Aofdkk/J0cjLOHC8WlPyILCFyhb8RujMVW4nqkttmwHfr2e7u6ZaZm0Q5cegKx//FZKT8vyXbvzlu2iD3irEu1RTnEq7RgiNADPvhILtnjFncG4TLBM09xqxvfeJPvAfCAeUVvgf8ybHDlvvXjHV8pjqI2Lm/OoKOG2pNmUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=woyymNwH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fs12Qqsw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715781505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euVTqk1JuslrNTa2ntwqAAJS2vk5/4vkRaGenZcgtGo=;
	b=woyymNwHwLxP3SdUdoRpLVltVmovaHxb7Aay4zhgvewNIyXUZVWg80vpfTh9nrbGf3XMgo
	gJmVEK8Kn6l+IrsrHg2rNkg7jDK07Z4isVPAVcven+PHscs24NGt4NNJxytUDZFHa9h9di
	ZFP8ITJHoBPYh4Km/oN0ZYvKCg5JMACg/WaVhlX5tx/Z3xS+xTL8kclLqMSQv+rt6IWBl2
	SiLY81+BDjG5MhJSQJeet7pGDgeph2AKUrRXBIaCQtBzgod2r5EhWFkwJfWcj3nNMUcV7b
	jBs2EI40xnmD/sIrF5YRioD4cMbC6bGQQ2u1gEeEWpGUnP7XbcRMFGgBDkiuZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715781505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euVTqk1JuslrNTa2ntwqAAJS2vk5/4vkRaGenZcgtGo=;
	b=Fs12Qqsw3ysH5OtmG1qZHCI+NQdsaRY19dPaWBBOd4EqkSNGLVLFpHfXsZJqzAaPtOY6c/
	NVEFuHgRs7Og/pAg==
To: Xi Ruoyao <xry111@xry111.site>, Dave Hansen
 <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Sean
 Christopherson <seanjc@google.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>
Subject: Re: [PATCH v9 1/2] x86/mm: Don't disable PCID if "incomplete Global
 INVLPG flushes" is fixed by microcode
In-Reply-To: <32e53b74f382f691fb8f60d68b093901964bd1c9.camel@xry111.site>
References: <20240418205414.67735-1-xry111@xry111.site>
 <32e53b74f382f691fb8f60d68b093901964bd1c9.camel@xry111.site>
Date: Wed, 15 May 2024 15:58:24 +0200
Message-ID: <87bk57kwhr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 15 2024 at 18:46, Xi Ruoyao wrote:
>
> Linux 6.9 is released.  Is this suitable as 6.10 material or do I need
> to update something?

If it still applies. Nothing to do.


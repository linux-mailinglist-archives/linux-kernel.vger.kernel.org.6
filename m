Return-Path: <linux-kernel+bounces-425606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB49DE797
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282CA161BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B9B19D8A9;
	Fri, 29 Nov 2024 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kLDb/kGR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tzt4zpj9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A419CC27
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887141; cv=none; b=f00s8+0ITh4u22B39Ac5We8IjJ8O6kTN/5p9EYsu/+Bf4NoS3GUnFFy6K4Nyl5BLvc2NNTtcXrOgoD+ndFcMtLOqtASq6XqRmvwNw6DyHIXxcnO5qVuAmNnoBFGMFiEYG/rWovZyfVh8MWnFN/vQ1l1o7v0qEXKlOvllfqxj7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887141; c=relaxed/simple;
	bh=ely/wz7MIspBhexwRIMqf/jW4lQC9IqBSrx6I5GQlq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b3vC56HWkdA8NQexcM/OUfZmb0mOuSRK2dA1frSYBOcaIN3Gx1H33v594ylpdWMEjQJ8LS8ICTvhPQQVysjuuMeLv1dl+1X0RG4dslXDWyR0lNkhrc0IVOtV4DZmYtx/SZZDcDj50HK16eozFI+si/0hLQ6GnD3/55xrkBV34H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kLDb/kGR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tzt4zpj9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732887138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EHb2L56DDpjtwU/UFh8uioIw0HOZZ1rlPpTrDEs14Q=;
	b=kLDb/kGRwiapc8IEHEJjX9JdZsSzN8BsAPa2RTHUSmua6pSEIlHIgFPZAriB/53oNtf7JZ
	kb08bkLnlTRGxBCT6bQPVQNny0HqGd6tAYTMi9Ky0a0Gy7cSBBru647vBSJ2gbiGAnM8CL
	K4CmqKSsKg+gcvEgc6iOJ6ErKbBM4liqw7b9gDPy6Rcf0GPoHN55zf7xb0QNa4jQbf2LNg
	6Fsofl0Jz8ofxH91BOzO8OKVBTLnFc6gazkfCzTaMa9hSmcBXen8PnbIfJ9u7HsoethIoe
	w/hDPRTTj2EFL4BE8Lv7tMlbcNS/RKZZ/3BUP/X0yf0KDF2mzupUN8apxs4v2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732887138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EHb2L56DDpjtwU/UFh8uioIw0HOZZ1rlPpTrDEs14Q=;
	b=tzt4zpj9BspmJyWB94OMHjwpdw2hmq+t+5FW1SE8HuJJfHm+iH++4n4CuIEmA74V5vgaEl
	zmueYz7U+7FFcBBg==
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
 maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, ebiederm@xmission.com, akpm@linux-foundation.org,
 bhe@redhat.com, farbere@amazon.com, hbathini@linux.ibm.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 songshuaishuai@tinylab.org, takakura@valinux.co.jp,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 kexec@lists.infradead.org
Cc: jonnyc@amazon.com
Subject: Re: [PATCH v4 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
In-Reply-To: <20241129113119.26669-3-farbere@amazon.com>
References: <20241129113119.26669-1-farbere@amazon.com>
 <20241129113119.26669-3-farbere@amazon.com>
Date: Fri, 29 Nov 2024 14:32:17 +0100
Message-ID: <87wmgmw4gu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 29 2024 at 11:31, Eliav Farber wrote:
>
> This patch addresses the issue by:

Again:  git grep 'This patch' Documentation/process/



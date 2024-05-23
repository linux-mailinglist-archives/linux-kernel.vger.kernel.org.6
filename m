Return-Path: <linux-kernel+bounces-187611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D88CD530
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A67B1F2425C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806A14B064;
	Thu, 23 May 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3qmiiYvM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qzAcmqid"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA714AD35
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472788; cv=none; b=SYh3TArZ2Pju1AbLgBiLfo4T7/CBTOmrbrSyW1BSotf7rbXu9aRHwd6m/BRsMqtCMmegxjb1mjGf1aM2ACj4cXT1jrgLoYR//V2ahHpi/MASPe2CYj9Km59mmqjB8SThSRtMSLeBni2MnDssxYDn2049I0QQvcgA/Bt301/2gtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472788; c=relaxed/simple;
	bh=mzoDj4XgSAO01IWyiH0sPXg7AFLMH9G0O81MdqxOCts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YDhYhJW0sAMHJlwbZyvCrWBR+wCfI13jK03tVkunqeGdIqAmIoBs8m4XK3AFYn2QMpwfyGkKLH+lptZ2tRU6Wpc0d51L8nnVII6OpEl44urhizvo3GBG9o/Iy9U5iFkCIZb/dmgRL5i6q3238rGBiu8LC4l0iplcXiImXw3X/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3qmiiYvM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qzAcmqid; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716472784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+N81KTAmxqigDRwmaMjHxrB3yOtm6eDGK4EsQAR05Bo=;
	b=3qmiiYvMYsQdwmhYZykoeLa6Ht9fNsda+B+xGXs1GtINIlgZdCjyTJxslL4JHmYMirFkmA
	SvFhg2Yar0leAwdeE7tbU0Bky3TyxDTKYATe8y+t/OnZ+9L32Gw7F/oWxSsWmrOwynHI0S
	pHlqIVsfymFZHsvS3PhYBeT1ZxzJa+Zp7+atlGMS3+LmymRRIBFD/HSrI44rxk/LcoBMht
	fEfMlF3G/a5qS1R5y7cncVNz7xWrTNHaZGvb/MiwRsMwXknOqBIoomgsChudRKmYvrhwx4
	3Egt3PuNvKTnlIjEc+PfKb+drs2SzYCsWB3J21eH1pJiCu9I/zMWJyTizxUfNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716472784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+N81KTAmxqigDRwmaMjHxrB3yOtm6eDGK4EsQAR05Bo=;
	b=qzAcmqidEnAzvYGxC+ikZM7oqaU+gz4H5u+F3oRQcbZSXUCYE9t+BXk0btN4JIBr2WNikD
	7+9Q3vd5MlBPdbCQ==
To: Jason Andryuk <jason.andryuk@amd.com>, Juergen Gross <jgross@suse.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, Jason
 Andryuk <jason.andryuk@amd.com>
Subject: Re: [PATCH 4/5] x86/kernel: Move page table macros to new header
In-Reply-To: <20240410194850.39994-5-jason.andryuk@amd.com>
References: <20240410194850.39994-1-jason.andryuk@amd.com>
 <20240410194850.39994-5-jason.andryuk@amd.com>
Date: Thu, 23 May 2024 15:59:43 +0200
Message-ID: <87pltcfx2o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 15:48, Jason Andryuk wrote:
> ---
>  arch/x86/kernel/head_64.S            | 22 ++--------------------
>  arch/x86/kernel/pgtable_64_helpers.h | 28 ++++++++++++++++++++++++++++

That's the wrong place as you want to include it from arch/x86/platform.

arch/x86/include/asm/....

Thanks,

        tglx


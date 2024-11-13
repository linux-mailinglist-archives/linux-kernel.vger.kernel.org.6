Return-Path: <linux-kernel+bounces-407340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B32B9C6C43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2993EB2A706
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403C1F8183;
	Wed, 13 Nov 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE8AEooD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA3178CC8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491774; cv=none; b=ea/XLivX74MZUpAHDFNydSFxmHVXglMNon6p1Rswsr6I9QJy7BqpcTVnTB9e37DEjaj05zYUfJfn7LJNLCSNJtg68y8Y63QNEbwL3tFnrejwmoIfaVwDw+EfQtEmrQdPO1mVYmIDo5ZTqujvLTNOifleODMmOIgrDxNSkRX6ik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491774; c=relaxed/simple;
	bh=aAHRRDGrmzw10/VRGpGX0P1HyO1tg4gGwLVpLFZa6NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZpNGO10OxcHVOziywOP9wsyLAYcPEvvNuKYg1hg3e32csUfclB32bC4l8RqA7eyecW2AJyCxI3TjbmNKy/8xVQ55dC0Ku2E+zgi1Xr3TxiJ9XCnp6Mfo3fxZvS90EEXXHSTr8+4VW9rM+Oo1cFPaanHjG1KiIRZvX3NdhEiMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE8AEooD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805B4C4CED0;
	Wed, 13 Nov 2024 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731491773;
	bh=aAHRRDGrmzw10/VRGpGX0P1HyO1tg4gGwLVpLFZa6NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PE8AEooDawij5qfvWm852OSvm6jmBDroaQfjCTEJi7obpydJnpiOiyc68FNtDluui
	 kGzKQc6SKqIRtpQKK+DjcSbieuVbSzDIeycnnTxFESVeg2ANWg8xTQQ02p45CT0Yty
	 zrTb3Znzkqzo68SP5tInNrhLY7ZnlCz7jSgTdpyYvf50WD+aye2af6z4Ol7LpDnGoU
	 KhtLAzEP4LCmBkC3GLH8MqMIviW+kVONGRT+VY7/O7vcEDpqa6W5aiaoXCibAc2pY8
	 u6+1qQaV++chbViggXKv9G1mtEp+bjTipIy3PncI3B2nW3Hb7blYzzGZ+WXMcJL3rc
	 XYmHiXhjCr2Ww==
Date: Wed, 13 Nov 2024 10:56:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, peterz@infradead.org, andrew.cooper3@citrix.com
Subject: Re: [PATCH v3 1/1] x86/fred: Clear WFE in missing-ENDBRANCH #CPs
Message-ID: <ZzR3s78NZDIi1Rxh@gmail.com>
References: <20241113091313.3717338-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113091313.3717338-1-xin@zytor.com>


* Xin Li (Intel) <xin@zytor.com> wrote:

> +/*
> + * By definition, all missing-ENDBRANCH #CPs are a result of WFE && !ENDBR.
> + *
> + * For the kernel IBT no ENDBR selftest where #CPs are deliberately triggerred,

s/triggerred
 /triggered

> +static void ibt_clear_fred_wfe(struct pt_regs *regs)
> +{
> +	/*
> +	 * No need to do any FRED checks.
> +	 *
> +	 * For IDT event delivery, the high-order 48 bits of CS are pushed
> +	 * as 0s into stack, and later IRET ignores these bits.

s/into stack
 /into the stack

Thanks,

	Ingo


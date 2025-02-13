Return-Path: <linux-kernel+bounces-512765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4989FA33D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA143A712D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837821422E;
	Thu, 13 Feb 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4oMAX80H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ucIGEbU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D667F2144B0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445015; cv=none; b=u3mJdA6B2+m9hDuPRQBxxN1sh2uSyARRSes2AMbaaY3YhPco8I5QpOEBAGAvPwN5IXKOtOCqWZsw8lmlM50+mxdl3toMnVacQt8zaYJ4Qo1afo5Jz9J5pAVTTlcMNiTtMrn6Tp2Vr9pcr6ejullgyUheQqKYady+lSDWB43yGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445015; c=relaxed/simple;
	bh=y03ahs1iCe0rNBmKuJbCOu/uupSZOa5fiXKkrHJtuTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CFJFrYZfi7sdZlmaQtnSAhQXkjbYM5FjrBfS4sOUbWCUQQhRJkpTG7hNsJ+WaVqCh8XnkOHllPP3arZdVaFgGBY2/NLyMwWj+2mKQvTZm5T4y0+5+IHpFuS6OT+3PgwaTYvga5zsXPOo67hesbB9lGLeBXFgBLV1V/MDdYU2Vjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4oMAX80H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ucIGEbU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739445006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y03ahs1iCe0rNBmKuJbCOu/uupSZOa5fiXKkrHJtuTs=;
	b=4oMAX80HrZBvcs9fVSq9rqN7wF7f1vH/GfZ02XdxCJIfbC73ZEWxJEbVoxXBVwa65E+D8P
	YzXfIml/YuXbV/6JFvvlMCWAkU4Hm1mE+nDP6c1dJ1Zxk2hLn9ToAG96SwDe98XLF0X3aO
	0rx4uCBCTMCule43odmg/j5qJVK2I4ekAiimBsu4fK2N7CUOs75vnfr9nRPT6F5FD6c1LU
	rBRDkNI5cTiq3x7tkuIKFBpC0QdaSID9q/IdD440Q9RzaMu/iGyPqMSyrCnQ+/vgMP1CC4
	oTEEbENC81skOpZV4Dl2Tu1Wt/LwxshJtO2qDr6OI6oLH59Yb/XgLfuozDIkoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739445006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y03ahs1iCe0rNBmKuJbCOu/uupSZOa5fiXKkrHJtuTs=;
	b=/ucIGEbUkXCjAUuIHhWys9UIJsZzkZk80bD+Jvwn63UrEWi+45GTy57wLbcuxEjpjBlvP6
	L7Tq075NEKHRD2Cw==
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH 0/5] x86/microcode/AMD: Some small cleanups
In-Reply-To: <20250211163648.30531-1-bp@kernel.org>
References: <20250211163648.30531-1-bp@kernel.org>
Date: Thu, 13 Feb 2025 12:10:04 +0100
Message-ID: <87a5aqksmr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 11 2025 at 17:36, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> A bunch of small and trivial cleanups which sprang up from recent staring at
> the loader.
>
> No functional changes.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


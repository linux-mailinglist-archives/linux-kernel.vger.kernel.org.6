Return-Path: <linux-kernel+bounces-278372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579FD94AF6A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A901C212F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E608E13FD86;
	Wed,  7 Aug 2024 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oe4Zao1O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CXPBr80Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5B13D8A2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054276; cv=none; b=gpLgEkEPDkSPiLtnMyY+sB7IF8fawQFQ/M9cTUWGGBiGRi9FtVIphepfaDIJNcBnYIcghgk2YTfxu/1/x1rGnIrRqwmMn9BQcVtHTn8hZpgI0+ffVoBJD/b8Lb5IOrlV8mlxGM7zND7qMVWBn4sTMiAHmoqWx3qSEXn++gRH0QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054276; c=relaxed/simple;
	bh=f7VOdTdsCDS0H9YWJKjS5pgwYRTi2fVeUHwEgiofpbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mYTaq0EC670TI60A7cJa1Gkj48J7GNQ6e4XG0I4rKH9g05GqAo7bx3DgbKAhaJIsrQo/RF/3j9PeSBa+TJEb1r2mWzHvtFlPienvOWFNC9InD6dMcDxdmPidzzzGxhUxw7+eTi8udn18/RI3EklmMfsORQVtC7wHQVOz0zOZGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oe4Zao1O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CXPBr80Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723054272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gklrIq6TslN4UXO5oCvlWRn6m5LV/JVfYC+zzWqSvkk=;
	b=Oe4Zao1OR2l4EkyTOISZOwQrzuKiQg0nWUajFhpaiaRrsmo8Mo60teABDPAMWFN9bZofZq
	HWyCgAr7dYONSC5BR9Z99WFJR9dXaJqfpZWRvc3muAYK6RTDOA4cbLTwrsZ4t/8LfQqpco
	ebOtLOE06orObguiB7Mmctk/AVcJVu0zF5ogCf4l+csfr48HUsyOlSsiety7aBuyS1Le67
	cgxUcEGFNj39ZkzFsQPY3DFMnv4PA2vfEMEc8pB1t8mIlgCqO7eYHhEHNNrytjSvDG2Iid
	ztEzzby+ZLyjmJUH55103p8egjmLczUnRndAWDZzMJgWCC1NCq5SarTeZ72PyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723054272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gklrIq6TslN4UXO5oCvlWRn6m5LV/JVfYC+zzWqSvkk=;
	b=CXPBr80YatCxnaDk2rAUgOvlp/nUJZWDDPNZ8KliePYxm9i3vjYt9k67BwVO3fH3th4DWd
	eM7IHZ06oHyvFwAQ==
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
 andrew.cooper3@citrix.com, seanjc@google.com
Subject: Re: [PATCH v1 2/3] x86/msr: Switch between WRMSRNS and WRMSR with
 the alternatives mechanism
In-Reply-To: <20240807054722.682375-3-xin@zytor.com>
References: <20240807054722.682375-1-xin@zytor.com>
 <20240807054722.682375-3-xin@zytor.com>
Date: Wed, 07 Aug 2024 20:11:12 +0200
Message-ID: <871q302ofz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 22:47, Xin Li wrote:
>  
> +/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
> +#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
> +
> +/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
>  static __always_inline void wrmsrns(u32 msr, u64 val)
>  {
> -	__wrmsrns(msr, val, val >> 32);
> +	/*
> +	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
> +	 * DS prefix to avoid a trailing NOP.
> +	 */
> +	asm volatile("1: "
> +		     ALTERNATIVE("ds wrmsr",
> +				 WRMSRNS, X86_FEATURE_WRMSRNS)

Please get rid of this horrible line break. You have 100 characters line width.

Thanks,

        tglx


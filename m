Return-Path: <linux-kernel+bounces-188972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AFD8CE929
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898DB1C203D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE012EBFC;
	Fri, 24 May 2024 17:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNd06Wna";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OpA4dZDS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5B12CDAE
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571125; cv=none; b=UEAoy0KhFb4mSd+tdKtke0UclxSa3gcj2zPL3bW6/w6WVnQsm/nH8Fhla8VIrt5HQDznZulyWtZaGLjDtWtcJ/1e2gB/8oOcMB3XtZ9Yj4MC2n+tfElclQ0wBVlvLAnZYFyoXb5EDJTa5MwJBzrjxancIHtYduFbvR8PNbkY5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571125; c=relaxed/simple;
	bh=uNtijc03QyA1OufXWMDDP/7bxvf3znWBWE1i8mvZnJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KBf+Bsu7qemKGuzHW6HOqntAmpvsaTxLJS+prw7yciquafJfi9SlJiquLnjjuIfYjwGBruJJW+kq7da7LrmTVM/Rj4dLADrMKD6H1MwQPHdo71X0Kpzq6OL4C1qg4s6gTjHRW6PRSOAEJARFtlNVPBM8wDLjxRKhfBh1CViOnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNd06Wna; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OpA4dZDS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716571122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIOG7CzhtT1xFZ8Eri8WfuwhBOo/lZKM9x6m+n5FoM4=;
	b=fNd06WnaQqijO8MrgjmXO86YXL43Ns2lxHWed536++ef4ILGB0MUiVPuHUPTriBe8HAFWw
	Uzwwb3/H5RV5UzrHOtH8meq5d98/mZhI9i+L467s9vEUC1xAniaU8xoGPNAPiQvQ+RSA15
	104vUOdanPnvMvG/TdC7cAFMpH7GAJtSpBsTjpZbGnQCkRFuac7AMq3srLXOViXNy+6mKC
	Wm3FpzqYw+/70WN5zyr+JpPDzD/GYFpTD3elPQIq8twJK+SjcjX8wfXDpjx8FzPkZ3aCBe
	r4oRTnyx8yUHBYqpAswRf02iyV9uwYfDXWVA9dolxtlDlQ35tGGE6719W02oDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716571122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIOG7CzhtT1xFZ8Eri8WfuwhBOo/lZKM9x6m+n5FoM4=;
	b=OpA4dZDSXGtNkHfJ6+44/kl14RBmXu9GA06kjAjhzjVszqF7FoDTfreGYV1MF/Uu+29hWg
	z7eN33LKW/lUsdBw==
To: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, naresh.kamboju@linaro.org,
 linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org,
 regressions@lists.linux.dev, linux-riscv@lists.infradead.org,
 apatel@ventanamicro.com, anders.roxell@linaro.org,
 dan.carpenter@linaro.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: riscv: irq-riscv-imsic-early.c:52:9: error: too many arguments
 to function 'riscv_ipi_set_virq_range'
In-Reply-To: <ab42f444-b10c-4992-bc6a-83e269cfe9d0@roeck-us.net>
References: <20240515-zen-calculate-289cfb90cd65@spud>
 <mhng-10b71228-cf3e-42ca-9abf-5464b15093f1@palmer-ri-x1c9>
 <ab42f444-b10c-4992-bc6a-83e269cfe9d0@roeck-us.net>
Date: Fri, 24 May 2024 19:18:42 +0200
Message-ID: <875xv3dt71.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 24 2024 at 08:10, Guenter Roeck wrote:
> On Wed, May 15, 2024 at 10:05:59AM -0700, Palmer Dabbelt wrote:
>> as a conflict resolution, which IIUC should happen when Linus merges my next
>> PR.  So I'll try and remember to call that out.
>> 
>
> Unfortunately it looks like the conflict resolution did not happen,
> and mainline builds are now affected.

Fix is queued and goes to Linus tomorrow.


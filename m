Return-Path: <linux-kernel+bounces-407173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF369C69A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B15DB23DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154F183CAE;
	Wed, 13 Nov 2024 07:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2MEFKuKQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOlcy+Ce"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F922066
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731481552; cv=none; b=AMI0KHpLrueTuJQHjXP5B/SFbdlB+/DxHbDJNCTDTVCPkB11OHOY0HLrsdr75S6law9u24S45V81l5hgk9BCL0zvKNQfUysK5kwKCq1KEbdHbRL9blssJ4W8uTR+CdEu8uhJ1dh1uRflLLWio0m7XuaoY8LkUDNuB715BhSugc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731481552; c=relaxed/simple;
	bh=NabcAbpmZJlEnFL/osc1f2OecYWlGiW4ZN/JgS7kXyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCbzDV36FUq+9HUXgtVMA6feeAuM92I6wm4tZMnhKYrqNqJubaRX9g7OAcwOLQXe1zt8SZTb2J57cNN+1dBzf8ISog3BmLYGdFQf3oEb5aWZVGkOLFdQpwVdoeHCIdnSs42ZaJFzPU8jlq3yMrS4QUBxDr3fpXQ9zkkINZYSmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2MEFKuKQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iOlcy+Ce; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731481549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R3ODfK7Vw7GBZ1b5MupvYZDTvxJZVNfsQzIadf/tXDE=;
	b=2MEFKuKQ07qRMd3BuxqPDKuO12Bn6C0cqslwetsqxBjYO8g30oAQCx41c8L0BaYuWURlly
	MDK6GMR2oNRGdDRcm2frDpzvcCv86hDjBCyW7TEfo2awyoA8JGk1/31JK/6u4+SdjByxQc
	/bcRc0+zyaUPRLKxy83tIaU76RegXyph0TSBRFGahkNIGBAiUKiYpgAudQdThysZD1tAMo
	N88GZdGaAJE6H7vkSh6XXbU97DEXBzsMp23nWbsMVfpcfRHLD6b4oW4Icy93KZtnt/XuTm
	/2a9M1zojqgb6wT7L5LaUg1frb0/tVgogetH0bJ999CYO5lIlUDYjf3wCtWOCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731481549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R3ODfK7Vw7GBZ1b5MupvYZDTvxJZVNfsQzIadf/tXDE=;
	b=iOlcy+Ce/AWf3qV8788BZkRuenn9ddM2wHKoUaMF29iVerQbB6WlP2+MCFI3UTPGJEsIYJ
	bpzurHfMEE6DgaBg==
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH v2 8/8] powerpc/entry: fix ppc syscall entry issues for
 common entry
In-Reply-To: <AD7BF1A62C0AD367+20241111031934.1579-16-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
 <AD7BF1A62C0AD367+20241111031934.1579-16-luming.yu@shingroup.cn>
Date: Wed, 13 Nov 2024 08:06:04 +0100
Message-ID: <87y11nlijn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024 at 11:19, Luming Yu wrote:
> Due to the common layer and internal calls details are hidden from
> the top level at the call side in ppc arch code, there are some
> difficulties in preserving
> all semantics implications of the original code in the patch. e.g  when
> we got -1 returned
> from syscall_enter_from_user_mode, without touching common code, we have
> to do
> our own inference to recover the reasonable route to return, in order to
> have correct errno
> and syscall work behaviors,that are tested in seccomp_bpf 98 test
> cases.

This indicates that your conversion to the common code is broken to
begin with. Which is not surprising given the amount of issues I found
already.

You need to sit down an come up with a proper conversion design and not
just randomly replace things and then hack around the fallout later on.

If that requires changes to the core code, then they have to be designed
up front and implemented in a way which does not affect existing users.

Thanks,

        tglx




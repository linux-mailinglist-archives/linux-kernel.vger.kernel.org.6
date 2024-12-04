Return-Path: <linux-kernel+bounces-431232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D99E3ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921C1167B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA051B85D2;
	Wed,  4 Dec 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjS2iZeY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HF+6t4SB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC18746E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317831; cv=none; b=e2qS2UKGq6e8vYuMWWrh3zVKiCg/G+w8x9D8bQl8dEo1JU0L/sA0e/pP2FdTMwvnT8CdoJqum8g3RuLWaH8qdeHPRw2pKu3uKIM3sOSPr0O6ZS95Mycsu9KIlDk8sSUnEBZpDNeSwnWmTOhDB8Kt7lkovns/GUC2qEnptUG7pE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317831; c=relaxed/simple;
	bh=OwzKGIi91GVzldCqp8aZmufzGtWB/qYRtTNAEiyz/pU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2Ax8y29PgxkL71DL1ZwPNR2n2HVXHAWQwWH9LsJbcSUgnQ0qF89478K9iDpwBu2ac5wFkPE1OO5QYO5fTnvkvcvCHPfAQ/dYDIsTxPXsu/eGvsxz07fyBfbmvl0LrLYMpFneuFKVOYfUDkumUikOIdDvBwSQ5vVjLGhwJyI8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjS2iZeY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HF+6t4SB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733317827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjhWlbCIJDJjn4HbII2Irw3DofMSzPoi0YPEq6Hjww=;
	b=bjS2iZeYOMUAfwObpezZwUgL+1sSE/EX/VaOf4jutvZyu+H1qC2xlaWBjHpOmvbLGzif7/
	P8Ly0JcVjSr68hI/Svh1U/jGuy9TmaH5UxxqfUjzC0XkCWmcIQWxTm1/59pNpiH+F+Lt8R
	Nlx9ZUJS3O3vbV3u3MH/wJ6a4xWwBIA+caBRG4utolnsNuNBGJDUM5j55PjTTIK/3v5LI3
	fIPuNDAw8pYe4eiDbdP5/Cs0OUSe7FD1TEKgVwB+WbArAlhvEyOg64fn60O3XBF12Rouv4
	H4+fueOdr5WzItt3ZsCZepvlGMHFj5F3J8F4blMdTYKjKQ54PF5KrnNWewIggw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733317827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2FjhWlbCIJDJjn4HbII2Irw3DofMSzPoi0YPEq6Hjww=;
	b=HF+6t4SBlLXuT3jmQeyuSoSUUPfT8eEdl9l46i2hgXzzbjb0d/nfB6adbx38IRG4RFGA5K
	wNebFywW/Rm3QcAg==
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use
 it in nmi_shootdown_cpus()
In-Reply-To: <20241203150732.182065-1-longman@redhat.com>
References: <20241203150732.182065-1-longman@redhat.com>
Date: Wed, 04 Dec 2024 14:10:27 +0100
Message-ID: <87h67jsif0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 03 2024 at 10:07, Waiman Long wrote:
> +	/*
> +	 * Call the emergency handler first, if set
> +	 * Emergency handler is not traced or checked by nmi_check_duration().
> +	 */
> +	ehandler = READ_ONCE(desc->emerg_handler);
> +	if (ehandler)
> +		handled = ehandler(type, regs);

Shouldn't this just stop processing right here?

Thanks,

        tglx


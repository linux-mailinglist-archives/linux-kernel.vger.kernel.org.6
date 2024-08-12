Return-Path: <linux-kernel+bounces-283548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9982994F638
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401E21F22C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A23189509;
	Mon, 12 Aug 2024 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9qU1IP3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rs16bbUW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC37C156
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485651; cv=none; b=eFmrVH+mw/+o7fga9ILDX4aACn4VoqlpjdKlP54iDVmWb2eo7VmysULr6xT4gK6MUySVpyT4p8v46cYVSUisCx/jMrNIPsOPUrd7Z5sNPvFG59MyXLS12aJs7qozB+fvv9QJawapnxhqjpR8vUiM2r5TdhgQTHCV/etGxrdKsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485651; c=relaxed/simple;
	bh=Ftmp0VQq6tAyMeujMQHlmlkAWv726Lbhnrtn6ZvbNhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ER655Ruh07T+rauhFhtijcMUzdmjU+2BcS1VgmYPV2LvFeiCGy4mSS48bK/OVN2JwFOS6h8YF556lEfbCfi3qSpQjlEQL6dKU/U+jtyvkfGjXf6L0zWMw214MMlohSO4SsFJZ8Vm2CvkZVq5rxb+couEIHZBA2hfQ5KAYAGElYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K9qU1IP3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rs16bbUW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723485647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQHIn6J1uLdo48+UJl8I9q22z29K2L1zlSzsPTSA4y8=;
	b=K9qU1IP3APQIk/lR0KajyO90tO1+1fam904Fh9cQXe8XZOODXCAX/zmk7+1FxysNbfEoDh
	OSIyuPpjALEF4Kz840cth5KUZ9f0EDkBJQG7rfrqc/k2nEb+nn5SGcIuzKTJZFCMTYYjXj
	yxZ/xFyCr/xrqwnvNr1PsPtpZo8o35TVft4DAtznB7ruU4R7iIdqEZdbGAW3+SIKSnqar7
	ag6n5SG0gW0sJFHmsUgrYPUUsjiaT7bDFNpKG5cG18AtbGpF60Jp7Z5D0k/J/v9Tk5t8Bg
	a0Tx+Vqf50fAWl9mnLy7t6Y246pz04vrz+lexkoz12Qe5ZqqYS6KrjFt9lMArw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723485647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yQHIn6J1uLdo48+UJl8I9q22z29K2L1zlSzsPTSA4y8=;
	b=rs16bbUWveAbVOQsK5ICcV9tr+l3xrc4ImNid9DcmOpGlblMc5BXbhYd61cqWD3uBCdWP6
	Zj85Gkos/gDjVBCQ==
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: bp@alien8.de, daniel.sneddon@linux.intel.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
 mingo@redhat.com, peterz@infradead.org, thorsten.blum@toblux.com,
 tony.luck@intel.com, x86@kernel.org, yuntao.wang@linux.dev
Subject: Re: [PATCH] x86/apic: Fix the issues in x2apic_disable()
In-Reply-To: <20240812155358.890025-1-yuntao.wang@linux.dev>
References: <87a5hhsspm.ffs@tglx>
 <20240812155358.890025-1-yuntao.wang@linux.dev>
Date: Mon, 12 Aug 2024 20:00:47 +0200
Message-ID: <877cclsjsg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 23:53, Yuntao Wang wrote:
> On Mon, 12 Aug 2024 16:48:05 +0200, Thomas Gleixner <tglx@linutronix.de> wrote:
>> There is no point in overwriting the state in case it is < ON, no?
>
> Are you saying that we should replace 'goto out' with a return statement?
>
> However, when x2apic_disable() is called, it's possible that x2apic_state
> is X2APIC_OFF. In that case, we should set x2apic_state to X2APIC_DISABLED.

What for? It can't be enabled later on and for the rest of the system it
does not matter whether the state is OFF or DISABLED. Either case says:
X2APIC is not enabled.

Thanks,

        tglx




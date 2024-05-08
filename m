Return-Path: <linux-kernel+bounces-173856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F28C0682
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2812B28337C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2313247D;
	Wed,  8 May 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0tiVP6Cr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KhQVvY5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2761E89A
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715204876; cv=none; b=hGQL2lK4Oqxlt97SE5MQzy2aOYdJhpnI0rWdptti8g0EniVD3Ezo/Kl1mRqEfEAvIHO2dv5UExFxR6D7SMD6cJm6ZEREkuyERixtxMhqBdeFAXEjsjc4PLCJg+VY4EPGsUd8mY3Ep1hQBePAxB9kNqmMnxasA8xkLRPorcqxF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715204876; c=relaxed/simple;
	bh=ApAfur37pJHaDLMNymbOTaDtj9dyHQKpw8yoUE/X7K8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAAGStZX2hUS/cMq1Z1EeVSuxz6J63JMnhG6tmMQeByqM5Ot20PPg+2KlH4G5cH2zkXmeEwvrCJEMFJ94rzZkp9k9xOtdWdVIUoKANGVZ0Il4Xr74Kcml5oTJtIpBCGosyxwZDRTyFr0lip/8LnkggfDjSwcUaUHQXxVLlA2Ip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0tiVP6Cr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KhQVvY5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715204872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ny7SdBBfM4fA06WaOHFWsDW9CAExUUs1RYJao5DtbQU=;
	b=0tiVP6CrCXtKmyPXBtBSby+bZ0UDyD2+kHnbHf4uwNdCR/87NEPF8JxBfgPJ7VDICxTQmE
	Zfk+8G57Q+BSoSTaNrL6iID/XFlKpzMb83wrqsPt3zEGprFSgcHXqjKcV1OFzOj3RuBBSa
	RUChCkvQYgs735w5RjYM40utaM4pbE9790L371TJwKyvhE58jGZvxyM0qJsIJwfbOWWXDd
	ksqZoJqa+ly9uDF9k2ufpiRJkbGcf8rLUMpTa4oUqvDH+ARLvhGaRia0CYTCVDWauz46IC
	Lj+Ngt2EUa3VjKQSlgZu7OkMR3RbNhp/4fxIsTpt95rTU1W/VoDjC4h+mlxrIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715204872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ny7SdBBfM4fA06WaOHFWsDW9CAExUUs1RYJao5DtbQU=;
	b=5KhQVvY5adfQ0p4UxE+x/m9Gz/3WB0U9XGpnX7J8Mk2MJyTLjT9yfAQe4NEMAt8ITGjKli
	/YAr6AW4jH2eyfAg==
To: Mario Limonciello <mario.limonciello@amd.com>, Lyude Paul
 <lyude@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
Date: Wed, 08 May 2024 23:47:52 +0200
Message-ID: <87h6f8nfg7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario!

On Thu, May 02 2024 at 05:33, Mario Limonciello wrote:
> On 4/25/2024 16:42, Thomas Gleixner wrote:
>> Right, that's what we saw with the debug patch. The ACPI/MADT table
>> is clearly bonkers. The effect of it is that it pretends that the system
>> has 16 possible CPUs:
>> 
>>      [    0.089381] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs
>> 
>> Which in turn changes the sizing of the per CPU data and affects some
>> other details which depend on the number of possible CPUs.
>
> At least this aspect of this I suspect is caused by commit 
> fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c.
>
> If you try reverting that I expect the "hotplug CPUs" disappear.

That does not solve anything.

The topology core already rejects those CPUs and accounts only for 8,
which in turn causes the boot to fail as also demonstrated by limiting
the number of possible CPUs to 8.

There is some other problem with this broken BIOS/ACPI.


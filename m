Return-Path: <linux-kernel+bounces-263002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E935D93CFB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C4E1C22137
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193F176246;
	Fri, 26 Jul 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0k0tRys";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="97s5uNx0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E912C6B6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983039; cv=none; b=rC9SDP9HOOR0gDnxcEoSZZD5IWbFH+ENVQ40Xi7ITaFrefb8r/0iZRTCT2QuDvXJ+4nywux0GJ7TppK3EXwub2xu1GYTwGu0Iw5wsZ8gaSdshthlctrfLcMh/Cr/neh3DKEvRTTfKu9nvELFdEcQ3eRWgUy4OfNd5q8IZTSkAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983039; c=relaxed/simple;
	bh=PGzE7h0yAGlGgLDyHnAvdDwIrMCPngj1CcskoTOyEX8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZJ7a25Od2y4JwYBM+uibS2j1kq+3yVmw4t70s1mpL1gMlKTBNf7OxD/Nq5ha01GNP21GtB4Q/RxPGojV3oUMLvezlYA7UQ22SovecJYmLDsIaR2+DVXg7knyBVDNZ8d3J0l4Nc51xU35NGjycTcIvbhu6y94RK6KZ+pEz1JnFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0k0tRys; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=97s5uNx0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721983030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjB/TYJi55yLbuMBfuzCRracLh8CJcvRBtBl120nrT8=;
	b=n0k0tRysYxtkpCDj8c0WmHCeA7iRkU1B1hgxHf3M7BGPctKyxPGSGKjdR73360ozQlqaWR
	BelGGOlB4PWfvwNiYgF0Cv5LmK+qM2yQMjMrWiR8I3WNrspXSokM9SIX5DubqbryCphmsx
	bAXX8bABOZm377vYQHo8JKQZ4ctoM9lqM0lP8naljEKDdQ5oPn6Hf+7mihiwmZxrPtb04A
	T78OjMIGcdnn9e778NYI6fn4EoFOzv5ut4L8aCWurjj2dT9CZSu9SmPf/2fraAhFuh6Jeq
	NVUTvxnGxfTKIBksqWx4wK/9k4zMSP9asTyacos9r4omUW7J2IBKJjUl3L3RFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721983030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjB/TYJi55yLbuMBfuzCRracLh8CJcvRBtBl120nrT8=;
	b=97s5uNx01f6Ydbv1wzvpKuf3knKBDFfv7rFJw9xvv13DKi5pxh04Uxf+ymO5AutjLJJ6Be
	kZSZfpSR7o06S7Bg==
To: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>,
 LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Linux regressions mailing list
 <regressions@lists.linux.dev>
Subject: Re: Linux regressions report  for mainline [2024-05-12]
In-Reply-To: <171552254677.1971316.17732013113090096417@leemhuis.info>
References: <171552254677.1971316.17732013113090096417@leemhuis.info>
Date: Fri, 26 Jul 2024 10:37:10 +0200
Message-ID: <87cyn0wnux.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 12 2024 at 14:02, Regzbot wrote:
> x86/topology: system stopped booting
> ------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d77cb898=
57ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/
> https://lore.kernel.org/lkml/3d77cb89857ee43a9c31249f4eab7196013bc4b4.cam=
el@redhat.com/
>
> By Lyude Paul; 24 days ago; 19 activities, latest 2 days ago.
> Introduced in f0551af02130 (v6.9-rc1)
>
> Recent activities from: Lyude Paul=C2=A0(3), Thomas Gleixner=C2=A0(2), Ma=
rio
>   Limonciello=C2=A0(1)
>
> 2 patch postings are associated with this regression, the latest is this:
> * Re: Early boot regression from f0551af0213 ("x86/topology: Ignore non-p=
resent APIC IDs in a present package")
>   https://lore.kernel.org/lkml/87le59vw1y.ffs@tglx/
>   22 days ago, by Thomas Gleixner

This one turned out to be a broken ACPI table and the system came back
after a BIOS upgrade.

Thanks,

        tglx


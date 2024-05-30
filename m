Return-Path: <linux-kernel+bounces-195704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C38D507F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2300D1C217F7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5964206E;
	Thu, 30 May 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D0hx+6mW"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15545BEF
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088801; cv=none; b=qcGUhZJqRN4tQIqXilhrsQdSW2np5jA4jA0n0xaPbLe/eJ4goxu2HSrqpPY0/F9J8YljA/guRd5jYF1s6wNMdFE/kRGF2MyvVdVf81wZUzuXNjrivvZ5I6F9+tLY31qOm4Pghn8Pvs7d9RnqetHxncEoVqRWvPlWLQ0jEnYWgMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088801; c=relaxed/simple;
	bh=gtdu0GvAQFq8iw8q+5qfg7hoyhbmRH7qS9rbJZ8b2pg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fnfL3QT9EeNgSS6ca8hjZC51Od7dtxCTTtQS0uACz858LUO0O67OWrwAlHosdC2fsAkGdQMRR/ASQOimVnXvvaCQ0seZETVk3HUVaBTE0eRM+c+3BejL3sn8+Ewe2ympLj/8JCEIK0HawLbXNZpQaPZhkx7Wo2V3Ui9CCdzmPA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D0hx+6mW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9C87540E0192;
	Thu, 30 May 2024 17:06:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sNYyHG-YTVhx; Thu, 30 May 2024 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717088789; bh=NIJhHBYRXpsOpCMDaZBRg66bIGp2F6TZ3LYJusBswTw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=D0hx+6mW4KXBs5YWbfF192f9g1dp5vAbEAD0981MrCo83AR/hJgT6La4iNba4zp9B
	 dFN8/FbZLldqWdoKULCvGhdrRoRS56tWw4L66fKKQyT6VclbzJPERJmkVqwczxVJFO
	 hKLkBTV7RD0+KeCO6rwcAZWYIL3yXMLgqcAN5ueR94KaIDM7sjw+GbamIQJVQpycO5
	 rgF3H5FpayfB/FmnKe1ubeOi1AgSntci3VvO+OYk0b5QWwGJVYer4ge0hpyUlwvQfe
	 wyHkkQ3EFV2qH4Y/DOjLU5UlEDGQF0OPpB2le5gMz8Dc64x2F9KObQkEmmYzskD+ab
	 60sAn8zCNCcCePMi4gPf5PtuQyWJN5mPo2lr7HJ9MHqjcMYLyZCuLTaGupDCiSm3rU
	 YaqRw2XxCkwGES2WPBkkwuwLJhYtU71Zj1SrLBWqBe3SvX52VGXGmXGDSuOpo5l5lx
	 Lxt8TlWT8Ro8e+/aYn2sutgwusaNlapdKQt2i5vSL4j4lItPB4MSO97Etfoax66XiR
	 jzk/Zik2POMYZWQvXAP4umo9iZ4QL4hFPkxiGSSnST/2Q2PgZ8JONrygfkbMQm9sP+
	 DChBobSMA5+8kPsHqZ0AtNR64Dr4QIQx4+La2zo88n5AHj/WkHIXWMKjizTK/Viq+8
	 q6rYMpwgbpXd34TsX+9srG6M=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:20f:938d:41e9:261d:4ad2:487c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6E9C440E0177;
	Thu, 30 May 2024 17:06:15 +0000 (UTC)
Date: Thu, 30 May 2024 19:06:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
CC: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 09/15] x86/sev: Provide guest VMPL level to userspace
User-Agent: K-9 Mail for Android
In-Reply-To: <e7c24be1-dbea-0efd-2661-b626fd655478@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com> <435f78e07c76e25d2d857138724098bc2a729b0a.1713974291.git.thomas.lendacky@amd.com> <20240527135101.GBZlSPxQ6iBSlMDefY@fat_crate.local> <e7c24be1-dbea-0efd-2661-b626fd655478@amd.com>
Message-ID: <D5A4D31B-4A37-48B7-8EBC-C8A4062B4813@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 28, 2024 11:08:35 PM GMT+02:00, Tom Lendacky <thomas=2Elendacky@amd=
=2Ecom> wrote:
>I can move it there=2E Or what about creating a coco folder under /sys/ke=
rnel/? This would then create /sys/kernel/coco/sev/?
>

Sysfs hierarchy is special - can't just add stuff willy nilly=2E This doc =
hints at that:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/t=
ree/Documentation/filesystems/sysfs=2Erst

And then those things get documented here:

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/t=
ree/Documentation/ABI

and supported forever and ever until the end of time=2E

So the usage needs to be precisely documented and weighed whether we reall=
y need it=2E=2E=2E

Thx=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 


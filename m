Return-Path: <linux-kernel+bounces-572674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22BA6CCF5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 23:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8843D3ADCA4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 22:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659A81E3761;
	Sat, 22 Mar 2025 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nwexD/iY"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA71C863E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742681024; cv=none; b=dIeyDpLKb5q8nWNyX8KZ08xPwbOfZ1rsUv/DmghuJ/95viPZxqnQEjJcX+R1ABWLYRFz0e3ikpLASkZmNxIPedQgGIo0i2G5SELPo7dkiZVWvKT7oOef4tR7fBKuvcGXkIV794MtzQ0pgWDA5MFo43WCS5PgvgrsxIkmJ/4EI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742681024; c=relaxed/simple;
	bh=Vvhjn2fz19R5/Jq44KlOWboEiScb7vTDk+SrhovXv7M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=b4i3ZZo5Q/xNqMz5T5QQk3P3V8F+/kNLsTysDo09DVyvTbjVW/SqaeGy7JUCDXKVOSdGb0Hx/7S+76zRWeEjkoQYfDq1WIA9/jw5SmNUpELTtuhkE68klxwV2VpggRc8yOury2LejjCn3JLYGi5YJ3t0TrOTW/AEMaqKOZoz//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nwexD/iY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52MM33NG3450102
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 22 Mar 2025 15:03:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52MM33NG3450102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1742680984;
	bh=gMo73RR1jk5etfxXk8yM367LMiUIyGdbOXTuYtAjE5A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nwexD/iYluo8eHX8gTHejFT7e5i7itnd7EOP8fVkIc3R5cNmTn8fN/VT/u4y3euma
	 UgRlKvFHbaj3OWVq8iLJVgLEjlGZhhOYDxGCP+LMR681Bw4dsA4F8xYvjeeBbXnIi5
	 FV7X6tCTD5cAvWhFh9Q5iVWl+Npvyx9g/Oo5EI3FtT3aFXZrDlYxHu3KcyuI7MKEQ4
	 PMRQSPDAP2jcbXkNCczabf1l8zXJbZJl6ek+zaRIVa5tp47h+Tqd7livIsZ3WQ34Rb
	 Ij0lId125bIR1Y6Zjs783fno5fNzsY4eZjghS5A7+m8npCdLgW7l+E1v1Ek3/pcdbN
	 xYal7iOsxikxQ==
Date: Sat, 22 Mar 2025 15:03:01 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <david.laight.linux@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
CC: Tor Vic <torvic9@mailbox.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_arch/x86=3A_Add_an_option_to_buil?=
 =?US-ASCII?Q?d_the_kernel_with_=27-march=3Dnative=27_on_x86-64?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250322215310.7b69b8a1@pumpkin>
References: <20250321142859.13889-1-torvic9@mailbox.org> <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com> <20250322215310.7b69b8a1@pumpkin>
Message-ID: <FA38B840-8F81-4D95-B0FE-797291BA38B3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 22, 2025 2:53:10 PM PDT, David Laight <david=2Elaight=2Elinux@gmai=
l=2Ecom> wrote:
>On Sat, 22 Mar 2025 12:40:08 +0100
>"Arnd Bergmann" <arnd@kernel=2Eorg> wrote:
>
>=2E=2E=2E
>> I assume that the difference here is that -march=3Dnative on
>> your machine gets turned into -march=3Dskylake, which then turns
>> on both additional instructions and a different instruction
>> scheduler=2E
>>=20
>> Are you able to quickly run the same tests again using
>> just one of the two?
>>=20
>> a) -march=3Dx86-64 -mtune=3Dskylake
>> b) -march=3Dskylake -mtune=3Dgeneric
>
>I've wondered what -mtune=3Dgeneric is actually optimised for?
>I've seen gcc convert 32 bit add into an lea and then have
>to use another instruction to clear the high bits=2E
>I've not fiddled with the options to see why it does that=2E
>My only guess is it is avoiding false dependencies against
>the flags register - but the flags are split on non-archaic
>cpu so that doesn't matter=2E
>
>	David

Not to mention that you can use leal to get the zero-extended low 32 bits=
=2E Sounds like a gcc bug report is in order=2E=20

The general idea, I believe, is that "generic" is supposed to produce coff=
ee that performs well on the majority of hardware currently in production, =
and doesn't outright suck on older hardware either=2E In other words, it is=
 intentionally a moving target=2E


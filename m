Return-Path: <linux-kernel+bounces-533178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60145A45680
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19BB1895799
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2612267709;
	Wed, 26 Feb 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vXuIJ1fo"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF919CD17
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740554261; cv=none; b=ZROPcgL1PU8iKrWeYQgSivP1UCGobv9xPyoAdoF8xm/ByYLSDM6tSC+NyuJOkD25XDAARgekmJAN3+OR6PFxNNi7RMXwe6UodJXPgZJtGlouZwAlc51h5gWRURO2yK8DmYg72Gg2496n0X6foOIAQ6ylPSADgVtNGa4lQHt+av4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740554261; c=relaxed/simple;
	bh=nQE82M389tEqleRp6N/SxEJ1DNH209IWxLRnYe2riB0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jXSnYl/7H6k06AqAJfAj4wAs6fdy0CrT3n3272mvxwxkmXHKEwMp6N2GFgnbiYRvdo5kxLJ3fS1A09HEX+QgSZtod0BFsFh5pMaQLuhr6IhobTz2IKP/nRyk7+rOEW9rbzNsAYJbf8EWNq2GGG6K/B2jUW7SbLNCglEmXRg7/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=vXuIJ1fo; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51Q7H9rg1592254
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 23:17:09 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51Q7H9rg1592254
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740554230;
	bh=nQE82M389tEqleRp6N/SxEJ1DNH209IWxLRnYe2riB0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=vXuIJ1foV5j4uLaC59mij4w9wJ4qGpy+3d5SPYb4gXprn83GNQs0Mz6WzMaXPbntU
	 Qm+EYYTEKM1yOR2ZfHAl4HVBrqW9CbL2t2qgdeg9/kChvNcyoJtqdI/uN31OhE7Tqj
	 kCRgEF1TmMxs4yALvAd4S2ODq1pFDZczjo9tz9g0SsK3q7Nvln7T7ArScV4EW54mz7
	 Dr+KYG7CjOUO2Yv2GV28kc+CGz4z7CZN+KTGly6bCju1j0D8+Q+4l262mz2WzfeYrD
	 8SBgQXK1Je//ip5NHf0v0m06Dsq1lorvymeDiqdxJEFlL2ZKgIs2ABtiYH+iLNdvO1
	 A05IQmHtjYdTA==
Date: Tue, 25 Feb 2025 23:17:07 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Jiri Slaby <jirislaby@kernel.org>, Ingo Molnar <mingo@kernel.org>
CC: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 1/2] x86/bootflag: Change some static functions to bool
User-Agent: K-9 Mail for Android
In-Reply-To: <67544c34-2c6f-43d3-b429-c8752f57a7e6@kernel.org>
References: <20250129154920.6773-1-ubizjak@gmail.com> <31e1c7e4-5b24-4e56-9f17-8be9553fb6f9@kernel.org> <CAFULd4a4qbMiP3dYXDp0_vPapkoi-i-ApOY5pHfKG1h7=vfbbA@mail.gmail.com> <43c41ab4-1771-4b01-853e-08e1689df7f3@kernel.org> <CAFULd4bTYudfNap1trVyjqA0xv5cQQeWxSZ8numv_uHqxz1Afw@mail.gmail.com> <ef6e2925-f005-41e9-bc24-b9adc3922706@kernel.org> <Z7zBXyywUEC2ieiR@gmail.com> <67544c34-2c6f-43d3-b429-c8752f57a7e6@kernel.org>
Message-ID: <2229E260-CF5A-463C-8552-32ACA97BE30F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 10:31:37 PM PST, Jiri Slaby <jirislaby@kernel=2Eorg> w=
rote:
>On 24=2E 02=2E 25, 19:58, Ingo Molnar wrote:
>> So this CodingStyle entry is a red herring, and the !! is absolutely
>> used in the kernel
>
>Sure, for intended conversion to either 0 or 1=2E
>
>> as an explicit marker of intentional type conversion
>> to bool=2E
>
>With this in mind, you would have to write "if (!!x)" everywhere=2E
>
>I don't want such constructions in code I maintain=2E (Nor for return val=
ues=2E) But this is not code I maintain (obviously), so your call after all=
=2E
>
>thanks,

Uh, no, that's not the point=2E

The point is that:

!!x

=2E=2E=2E is the same as=20

x ? true : false

=2E=2E=2E which if promoted to an integer, intentionally or not, becomes

x ? 1 : 0


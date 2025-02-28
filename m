Return-Path: <linux-kernel+bounces-537618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B9A48E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE45816CB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2167602D;
	Fri, 28 Feb 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vG8vwXfU"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8E2628C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707393; cv=none; b=SwT93jFvtZdx8nkISAdkVOm9IR4nEvm7GlhsCzQULNq8PTyiTKQoCfk66C/eeZa8az3jK+qJdeAAdxXRL4Ztpt4KiUEznGAj7OZ1T1eCNT1rvlyxtiyTExeMUrJrFWElGHFRBQ1Y5T4eeFtySpQ2w6f/MBfisLv/+yeQRmEbn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707393; c=relaxed/simple;
	bh=ktRhhmnrpNjYS2J+Fqf7mz5+zvoyQaMFSiTUEmlwv0Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=joUEuDKNIFpsu1Ndu7FslLOzHyalI/QL4P7b5bCjEfGIixAtP9mjig0I3FgMFDhoEOWdRK0r1b3GFEKwfgFEAPFaS4rU004mIzOfF6t8sJmHAxvlxTewhZXq7erNsHyiK5txzrYkCbLJrycIUUIW6Ok4xRtVfdQ5vkYU4m8dfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=vG8vwXfU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51S1n2tw2393688
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Feb 2025 17:49:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51S1n2tw2393688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740707343;
	bh=6FCGUjjFfT2kFKjHpJH1aBTC0RhE3epJX4ztS4rM3LM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=vG8vwXfU0xFwfQ8UNJe3TppVziH4T6Y3EQ/ntjR/h0oWTzTPjrDe3Quu93XFXiAUX
	 JebOUQ0bjNPgui5w1kY9ABIW70EOizhzxUzOApXehqcabAfVOaGe7kGWmE1eDNC5Aw
	 qcVdSrKuqZT3KQaGyROngWXE6qPeleWNHxriBJWYkmxR7jrbPcyeCw1b3tbD8BQx/O
	 YeyipTb7aETyuVLTCsGKRtL9QYU/LCcnCeI4fV77Kn/rP+807Bxv9f2d4A3e41tQpP
	 DX+nf5DTQ2Wbnsn6M4n2a+5ApcXY2cQ4C89C3FF6W2lUXMQvgZbIBCpTaAcLN9HUp2
	 r8rygA4um6c5g==
Date: Thu, 27 Feb 2025 17:48:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 05/10] x86: remove HIGHMEM64G support
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wjFb7jeWXB2wovPeHqZ7XaxfiCbb+Vgk9FeGO2pcY78zA@mail.gmail.com>
References: <20250226213714.4040853-1-arnd@kernel.org> <20250226213714.4040853-6-arnd@kernel.org> <572DCA31-1CCA-45FB-ADCD-29C24A527437@zytor.com> <CAHk-=wjFb7jeWXB2wovPeHqZ7XaxfiCbb+Vgk9FeGO2pcY78zA@mail.gmail.com>
Message-ID: <628C48B3-E6B3-4A24-A9EF-7C07F828608E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 27, 2025 8:51:59 AM PST, Linus Torvalds <torvalds@linux-foundat=
ion=2Eorg> wrote:
>On Thu, 27 Feb 2025 at 07:41, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> One of the generations of kernel=2Eorg ran on a dual socket system with
>> 6 GiB RAM=2E It was a mess; basically it achieved less than 50% memory
>> utilization because of highmem=2E
>
>I'll be very very happy when HIGHMEM is gone completely, but yes,
>HIGHMEM64G was particularly painful=2E
>
>It was definitely used, and it worked better under some loads than
>others (large user footprints with lots of anonymous memory and little
>kernel side memory pressure), but it was not great in general=2E
>
>I suspect that absolutely everybody who ever used it switched to
>64-bit as soon as humanly possible and nobody has likely actively used
>it for a *long* time=2E
>
>Good riddance,
>
>            Linus

I wish that were true=2E=20

At rPath I had to debug a customer machine where they insisted on a 32-bit=
 OS because they were worried about the breakage possibilities of the compa=
t layer=2E In retrospect we really didn't spend enough time/effort on makin=
g sure an all-32-bit userspace would run on a 64-bit kernel; little corner =
cases like autofs (my fault) that only popped up when all the system softwa=
re was 32 bits=2E=2E=2E


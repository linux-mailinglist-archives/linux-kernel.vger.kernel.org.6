Return-Path: <linux-kernel+bounces-523645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B0A3D9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32D417E9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212861F4E5D;
	Thu, 20 Feb 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FT8HuSje"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32821F4626;
	Thu, 20 Feb 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053648; cv=none; b=OGdvgp4CZqTiMkZyUodJ3hMsjOY6R2r21qORGaq8SSSBAN7ygV2LLOSznYxr5nTlP7vSEzLeVn3yYT+ynNTMXufOnN2y8cOMlpJIvFU39uS/LMGNJ3HMFG4PYpXNnTHExep5HHVP3nDX8ZPSY0ehSrI0MVyh67QEfnuT/hOwriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053648; c=relaxed/simple;
	bh=PtQW4VmpX3Gux2bL+ZFcWOaxQzQHWQuzF3wYCZ+6j/o=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dOIFKMblmSq+W/o0jVuJnnsH4sk9hKlchHB+bdVucobk7zP/Ify+cykUT6sfEp8ctRSbrugMl6elEdEniXmLvmMr3DRSe3wR9Ibit6WpN/1fMIYIbhjK32Fi6sXZ10Md1URap+BAo7GI4z07rG5/cQWd9DrmMAsyeiXGp0xmVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FT8HuSje; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51KCDxS02195213
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 20 Feb 2025 04:14:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51KCDxS02195213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740053640;
	bh=GhMAHSBtV9/kfMoKmY83r+p25mAz8E0HTxvLo+40ST8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FT8HuSjeZC5A832cO6iAOgJF0qznA0PAd3qlSb34Zac6fWKZuEOdqOPRIyeVFqqw4
	 Ol5CBxY1NaPfJxNw+Lg6VNyPpIF7qG1RnxkJCNixDZwyxp44MMV+vWGomixexz8uFJ
	 QEDZzqzcTLOoivbEgcNPl/hpG8kjxIDyFSFywdzpjbeqnQ+sQWy6aZ63qu2/Lrqqxs
	 CmFqz+A9uOSyxGjkumLk4w719MSIEI0sIYKERzNtgpjTEiQg5jwXEmJD/GX9U51sNT
	 kMlga5a/rWMNgeaITUxRp9vTg8q9lIR2YiT8V02jvnUMpAgv0jB+r4oN2qTreds3SU
	 lUyXDI1ZQlKBQ==
Date: Thu, 20 Feb 2025 04:13:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: Kees Cook <kees@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
User-Agent: K-9 Mail for Android
In-Reply-To: <6E8DAA21-2CCE-4E53-A5A8-3B82D4A2334C@zytor.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <202502191026.8B6FD47A1@keescook> <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com> <f77d549c-b776-4182-b170-571d1e5bb288@p183> <6E8DAA21-2CCE-4E53-A5A8-3B82D4A2334C@zytor.com>
Message-ID: <1D187908-AA1B-4D17-A0AF-8672BE7476C2@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 20, 2025 4:01:28 AM PST, "H=2E Peter Anvin" <hpa@zytor=2Ecom> w=
rote:
>On February 19, 2025 10:32:15 PM PST, Alexey Dobriyan <adobriyan@gmail=2E=
com> wrote:
>>On Wed, Feb 19, 2025 at 11:33:56AM -0800, H=2E Peter Anvin wrote:
>>> b=2E Can we use existing mature tools, such as C++, to *immediately* i=
mprove the quality (not just memory safety!) of our 37-year-old, 35-million=
 line code base and allow for further centralized improvements without the =
major lag required for compiler extensions to be requested and implemented =
in gcc (and clang) *and* dealing with the maturity issue?
>>
>>We can't and for technical reasons:
>>
>>* g++ requires C99 initializers to be in declaration order,
>>  even in cases where there is no reason to do so=2E
>>
>>* g++ doesn't support __seg_gs at all:
>>
>>	$ echo -n -e 'int __seg_gs gs;' | g++ -xc++ - -S -o /dev/null
>>	<stdin>:1:14: error: expected initializer before =E2=80=98gs=E2=80=99
>>
>>  x86 added this to improve codegen quality so this would be step backwa=
rds=2E
>
>Ok, so those are obvious problems, and I agree that having to rely on the=
 legacy implementation of gs: is undesirable as anything than a transaction=
 crutch=2E
>
>

Make that *transition* crutch=2E Stupid autocorrect=2E


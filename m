Return-Path: <linux-kernel+bounces-523627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A82A3D96A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F3816B891
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579281F5425;
	Thu, 20 Feb 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Baqyrqe/"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3EC1F4628;
	Thu, 20 Feb 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052911; cv=none; b=ZSyRKHN7eR7oZuKpiXpQ8uKBV4ig53+f/gak/DZI1UnSe4Eczg7ocBUMo0tiwKp6Er86E/tdYM1ZCl6tC+VNgewMw9tmscBi6YlDfkc51EesM5Ou7GI4hhZhJDTGVt3PZqgZcXm6jdyodmn/3R47vwcznDCI54luISdXZd3nung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052911; c=relaxed/simple;
	bh=hT3+hzgJ5kxGAO4TwX0ooaELT3zupGX5jXPoElZSe0s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=RGtxVXFuldV8H1JlGHMLxpHUbh9oGaLTzgbk3xPDZDUqm9g2Ypr+KPDoDqhEU84RfzaehbH185E3c0JHaYSFwPN5QRfSrGxru6mFvSGI7TT0oB8cbJIS5VQ8a0QnqhdgyEZRiuKJGi7rphA7mVRQF08DOPtONOAGsHvZijc0oEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Baqyrqe/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51KC1Tci2191325
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 20 Feb 2025 04:01:29 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51KC1Tci2191325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740052890;
	bh=zt0WBvfTByDuNbJ4aX75lg2KosRfDbi2F9Se6AdH7qA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Baqyrqe/xYlm8E10ZBuJYvI6CnXDYctxiBDSE3Zb1CaAOGTvO/iA5Ul0Zl1EBOiy9
	 s1d2oYgxAioDBUjfso5l86+BVacksNc4Mda/uH0+KX29DcnZFTOh+JoVTzrI0SmbtF
	 AKRoBnmzNrkAY+UjNESbsCKu3bHuqDCS0xG3hfRuk5Z3Wsiq0fQLyGayS6ImL6Ozfr
	 YYzfZvdVngBkpb0h1AQVfORYZwNq+mRzTD2qFMMkqckWFu9/PBBOhyXOexsizgCt//
	 tUkrrdGZHTcZSySEvabaWhTCx3Fiy9E8C5F7+nZgDH12sLXU9tQ356fQGN0kdQlv3J
	 nUqKeQBiKbJsg==
Date: Thu, 20 Feb 2025 04:01:28 -0800
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
In-Reply-To: <f77d549c-b776-4182-b170-571d1e5bb288@p183>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com> <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <202502191026.8B6FD47A1@keescook> <785A9F60-F687-41DE-A116-34E37F5B407A@zytor.com> <f77d549c-b776-4182-b170-571d1e5bb288@p183>
Message-ID: <6E8DAA21-2CCE-4E53-A5A8-3B82D4A2334C@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 19, 2025 10:32:15 PM PST, Alexey Dobriyan <adobriyan@gmail=2Eco=
m> wrote:
>On Wed, Feb 19, 2025 at 11:33:56AM -0800, H=2E Peter Anvin wrote:
>> b=2E Can we use existing mature tools, such as C++, to *immediately* im=
prove the quality (not just memory safety!) of our 37-year-old, 35-million =
line code base and allow for further centralized improvements without the m=
ajor lag required for compiler extensions to be requested and implemented i=
n gcc (and clang) *and* dealing with the maturity issue?
>
>We can't and for technical reasons:
>
>* g++ requires C99 initializers to be in declaration order,
>  even in cases where there is no reason to do so=2E
>
>* g++ doesn't support __seg_gs at all:
>
>	$ echo -n -e 'int __seg_gs gs;' | g++ -xc++ - -S -o /dev/null
>	<stdin>:1:14: error: expected initializer before =E2=80=98gs=E2=80=99
>
>  x86 added this to improve codegen quality so this would be step backwar=
ds=2E

Ok, so those are obvious problems, and I agree that having to rely on the =
legacy implementation of gs: is undesirable as anything than a transaction =
crutch=2E


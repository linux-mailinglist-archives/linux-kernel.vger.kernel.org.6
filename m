Return-Path: <linux-kernel+bounces-557136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFF1A5D413
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C647A318A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B278F44;
	Wed, 12 Mar 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d69IV3bI"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B6A31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741743301; cv=none; b=rxctTf3wsjj94kHeKPGLSMkcCt7B+WxsyiWA/9Ctn0eAsDFJ+L3hdQuC3yOlixozqQIoVZHx0M0fe+mz6SQZNs7Vg97oGHcY9F2YNw0iAQdJXn5i7tCrZvVoW2146bofGjRo8pNaIhDJE86Ud1PeJueXOechDicYJ9Y9OJapjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741743301; c=relaxed/simple;
	bh=2d3nZPl/1VTuIyPclk+OH11b16mjErrRfI3RWTO0SMM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GeBYdHL+4GvXfsKv/9Ru/vrJDXonwsw0HP3VCO/WU1NLbZ689FZ9HerJnb0Grfc/8bGlp6ZOfaNv+z1NZYNZ1eSiBHnrk5EJS4OxWX+39iQ85LSxp8WQLtGQhk2sx5grOXMtI83pAncMHzpqkeSOsluWDI5gn5xWPVhCbYGGGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=d69IV3bI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52C1Ykga2331197
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Mar 2025 18:34:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52C1Ykga2331197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741743287;
	bh=2d3nZPl/1VTuIyPclk+OH11b16mjErrRfI3RWTO0SMM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=d69IV3bIErnWAi0yNBa/nZEh9y9D33OyI17QxZJ90oax+rg3YtZ2DV3sR9N10bnQw
	 FV4tORkL3ncHmesOI0i7s7i1YxdUoxeuXN2T5socFPtdbB9Lz5YE+ej4AeZfOI1Aeg
	 MKLr+q9oEX4FC0gk15KV/NJnp1uK3Cfgd2cpGcMXrDB0wvGDLbhIz/aTkPqleqgl7Z
	 yHJGM/gm35+teL1quznVV9GKfrUcHbrfKfHFLDANoE7eSXWa9UbMrjfCaRqcbHn9qd
	 UIHaP25N8+bdlP5STk3ONJNxxqGT8fcriIycWAM6/8mqQ822/Jis4370IandPwPjpM
	 Jh8LBqyecEYgg==
Date: Tue, 11 Mar 2025 18:34:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Juergen Gross <jgross@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Paul Durrant <paul@xen.org>, David Woodhouse <dwmw2@infradead.org>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_resend=5D_x86/boot=3A_Drop_CRC-32_?=
 =?US-ASCII?Q?checksum_and_the_build_tool_that_generates_it?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXGmyssEYer_Su1N+s9svNd3yNm7W4bf9DYHsJszxHoyUg@mail.gmail.com>
References: <20250307164801.885261-2-ardb+git@google.com> <87bju7o65f.fsf@redhat.com> <3AD32490-F072-4C10-A732-E5BF1E303C43@zytor.com> <CAMj1kXHZsk68kVA=dFbCb3yCrLJmHvn7HZ-qqSjjuQkdUf9_2Q@mail.gmail.com> <988E1140-BF0F-49CF-AA0B-D05741148836@zytor.com> <CAMj1kXGmyssEYer_Su1N+s9svNd3yNm7W4bf9DYHsJszxHoyUg@mail.gmail.com>
Message-ID: <42BED675-5849-473A-ADE1-4882D1091C4D@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 11, 2025 10:44:09 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> wrote=
:
>On Tue, 11 Mar 2025 at 18:29, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On March 11, 2025 10:25:15 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> w=
rote:
>> >On Tue, 11 Mar 2025 at 18:14, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote=
:
>> >>
>> >> >Ard Biesheuvel <ardb+git@google=2Ecom> writes:
>> >> >
>> >=2E=2E=2E
>> >> >> it seems quite unlikely that this checksum is being used, so let'=
s just
>> >> >> drop it, along with the tool that generates it=2E
>> >> >>
>> >> >> Instead, use simple file concatenation and truncation to combine =
the two
>> >> >> pieces into bzImage, and replace the checks on the size of the se=
tup
>> >> >> block with a couple of ASSERT()s in the linker script=2E
>> >> >>
>> >=2E=2E=2E
>> >>
>> >> Please leave the bytes in question as explicit zeroes if possible=2E
>> >
>> >Keeping the
>> >
>> >=2E =3D ALIGN(=2E + 4, 0x200);
>> >
>> >in arch/x86/boot/compressed/vmlinux=2Elds=2ES should be sufficient to
>> >guarantee that the last 4 bytes of the file are zero, so it is quite
>> >trivial to implement=2E However, I'm not quite sure what purpose that
>> >would serve: could you elaborate?
>>
>> It means if someone *does* care it will be easier for them to adjust=2E
>
>I=2Ee=2E, someone can always stick a CRC-32 into the last 4 bytes if they
>wanted to? Yeah that makes sense=2E

Yes, or something can look for all zero and know it doesn't mean anything=
=2E


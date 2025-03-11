Return-Path: <linux-kernel+bounces-556601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F947A5CC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938F17A43C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977ED2627F2;
	Tue, 11 Mar 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b+hQoqDR"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF02620F6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714197; cv=none; b=R66WZzbytj/e3s7396ZiT8y6DEdNynpsbhmYXGXUNXUy/vPOFupts/LH5yNkQOJMvSEyZCNc88Buyr0xGbjhj5gUavs82dmcheOaHh61iLaltQYNEYVQHDg+dvrKzmrbCulH1BqdlOkGOMZEUAB8FsoDzOm4SHaI9x2H6jq8WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714197; c=relaxed/simple;
	bh=/Yt5i5AF7ypc2L/ll5JCcPxRnvIMR77klsNKBNpcRpw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JUsooKKbWRJfSVfd+7HzhDLKR8bd53JOhx81qqUKnivRUk0869F3cMwov4YItJ6qKUaN1b1pT2Kl23LeHEMkzXoJbnMDBEbDeFFsvqe1j5S8Y6SxVira9iA5Zf+7XTVdGk7TooZVO3/bt/aF1j4V2d6/SAIGhUv5wCBvj2IutJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=b+hQoqDR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52BHTiUq2168609
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Mar 2025 10:29:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52BHTiUq2168609
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741714185;
	bh=/Yt5i5AF7ypc2L/ll5JCcPxRnvIMR77klsNKBNpcRpw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=b+hQoqDRQbLdsA11y4j6eyFnlaIyqzyWYexM3A26iD6ZZQtbE36gSvKKxCrJD/DEa
	 kIyooRFMJt5fcNMA80Fvl9mVH42YOqApsZSGPSPyGIejiiANi/HSfFtUzmVw+vMhFf
	 A/8vMb3hLmyPc1lBw8YGEE9kH1IrKSNW1NHvMzOBfJ5GAEAjo5Ty+PE22nGD1VdBbG
	 JWjezLj/yzEo7KGOLzfgh46wSEVKkuBg/tHo034GfiKwRBTAisuU7sh223VOC1LsoM
	 JIt4iNR0Nyg7C8COcNmYeDWiH2ZTNM3qbpXsrAHMDwu5j2CY0heFXjvZJ4Ikl08dqQ
	 6csVSlj0u8XTQ==
Date: Tue, 11 Mar 2025 10:29:43 -0700
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
In-Reply-To: <CAMj1kXHZsk68kVA=dFbCb3yCrLJmHvn7HZ-qqSjjuQkdUf9_2Q@mail.gmail.com>
References: <20250307164801.885261-2-ardb+git@google.com> <87bju7o65f.fsf@redhat.com> <3AD32490-F072-4C10-A732-E5BF1E303C43@zytor.com> <CAMj1kXHZsk68kVA=dFbCb3yCrLJmHvn7HZ-qqSjjuQkdUf9_2Q@mail.gmail.com>
Message-ID: <988E1140-BF0F-49CF-AA0B-D05741148836@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 11, 2025 10:25:15 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> wrote=
:
>On Tue, 11 Mar 2025 at 18:14, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> >Ard Biesheuvel <ardb+git@google=2Ecom> writes:
>> >
>=2E=2E=2E
>> >> it seems quite unlikely that this checksum is being used, so let's j=
ust
>> >> drop it, along with the tool that generates it=2E
>> >>
>> >> Instead, use simple file concatenation and truncation to combine the=
 two
>> >> pieces into bzImage, and replace the checks on the size of the setup
>> >> block with a couple of ASSERT()s in the linker script=2E
>> >>
>=2E=2E=2E
>>
>> Please leave the bytes in question as explicit zeroes if possible=2E
>
>Keeping the
>
>=2E =3D ALIGN(=2E + 4, 0x200);
>
>in arch/x86/boot/compressed/vmlinux=2Elds=2ES should be sufficient to
>guarantee that the last 4 bytes of the file are zero, so it is quite
>trivial to implement=2E However, I'm not quite sure what purpose that
>would serve: could you elaborate?

It means if someone *does* care it will be easier for them to adjust=2E


Return-Path: <linux-kernel+bounces-520551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDDA3AB61
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B8F3A54FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2A1D5CF8;
	Tue, 18 Feb 2025 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WwcLeFIu"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66B1BBBD3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739915625; cv=none; b=bCzXuQeOo/OKC50UrPLA5PziMpwUE00EIVfZygeGiDL0y+WFgihmrz0aenpPkDYZX3BrkZd5Nl/l0qEdyYOw4mnOWWT6uq1V/LYxRrktzlcj73QRGhImgOb/QR9pAWvqDaOFoDoZkd0RNxQKA5APaMHKpJzSG9x8jPElWb7O1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739915625; c=relaxed/simple;
	bh=Ckd5GGliYUD3weeXP0dxTtFcYHILoc1NsVRcMlqsgL0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=om+QUDcxf/dmuiQVqRV48nB6VmNj5FSTUW3Uf2ByWYBHLGAqSnbQuqNetU+eKU/6H+CLF+i8X3F81djVwT00TZiqWSqsfMkk6csDu11xRwiv6wPYXj5uMwyIGh760EqavQH8OO3FYRxzygx71Xu/qY7urGqlJYfuzriKaTwrEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WwcLeFIu; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51ILr2lS1490760
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Feb 2025 13:53:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51ILr2lS1490760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1739915583;
	bh=v1YEoMF4Ynx2HAHPzxxDjriXsM9yujl7/UXKxqH539E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WwcLeFIuT1ft4/BYc7oZe+HASFb5UkLZjziaBWS9zGNiz/M7GrhhqGHwoHsjlVRdy
	 q55fBaaUPNCl/oT3f8xm3yNMoOEWdag5jexEvUPIEdGk+wcf6PMrvI2a1czrMZOoWF
	 NY4xCIoEbamNtVp1gqTaKJx3wmaJF0WxKnBsvTSZQRWY4xRPn0m+WPDyR1nEOk0Frm
	 /pG88xQ35d1i5zm8BzSnnUXWgEo2aaqK5wZbzDyCKfyD/U5g9IXNSH7opLVBvuoWjk
	 8+OSmMyB8OjSCFs/7+b9Is9PfqNHWcwjvuVkwKLvjtricYQAEWA7E4YEqo+zv2sIjo
	 4eYngWfZ+zpTw==
Date: Tue, 18 Feb 2025 13:52:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>
CC: linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_06/15=5D_x86/module=3A_Deal_with?=
 =?US-ASCII?Q?_GOT_based_stack_cookie_load_on_Clang_=3C_17?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2i7-=2BU=4_SY_hxPHU+n5MMGRwS7BzApy-TGoeWTZHog@mail.gmail.com>
References: <20250123190747.745588-1-brgerst@gmail.com> <20250123190747.745588-7-brgerst@gmail.com> <Z7RNxf9NWmGZ6aDE@gmail.com> <CAMzpN2i7-=2BU=4_SY_hxPHU+n5MMGRwS7BzApy-TGoeWTZHog@mail.gmail.com>
Message-ID: <B085D893-C3CE-4D6D-8BB5-834328819E68@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 18, 2025 6:05:37 AM PST, Brian Gerst <brgerst@gmail=2Ecom> wrot=
e:
>On Tue, Feb 18, 2025 at 4:07=E2=80=AFAM Ingo Molnar <mingo@kernel=2Eorg> =
wrote:
>>
>>
>> * Brian Gerst <brgerst@gmail=2Ecom> wrote:
>>
>> >  #define R_X86_64_GOTPCREL    9       /* 32 bit signed pc relative
>> > -                                        offset to GOT */
>> > +#define R_X86_64_GOTPCRELX   41         offset to GOT */
>>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> > +#define R_X86_64_REX_GOTPCRELX       42
>>
>> Uhm, I'm pretty sure this won't even build, should any code use
>> R_X86_64_GOTPCRELX - which it doesn't currently=2E=2E=2E
>>
>> Also, each entry here has a comment explaining it - except these two
>> new GOTPCREL variants=2E
>
>Should we remove the non-REX version that isn't used by the kernel?
>This header is not exported to userspace=2E
>
>
>Brian Gerst
>

I would personally like to see them in there for the sake of documentation=
 at least=2E If something runs into this in the future then at least it wil=
l be a little quicker to debug=2E This is an ABI constant, after all=2E



Return-Path: <linux-kernel+bounces-421619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CC9D8DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2B4167DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402151C1F12;
	Mon, 25 Nov 2024 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RwOL0CQl"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFF1552FC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732568186; cv=none; b=oO6d7mNrpP+UZXTWvSf6bkqcFgE/5D5JjP5M0VUB7HZ8724Y7ExlE4XDyIzq/6H0x96TV1E4V9/eku1yz1wgZUjvR0c0m+ZNkeBxXvslIMlXmaxtc4gRY/nUz+2WALc8SRhoTEn9ye/C0/+41padSmF831WhY/mNj720+kyNiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732568186; c=relaxed/simple;
	bh=+G+s8v3b9ivTkcUbGcjfodZZE8uSBSoWWJRLo7lVSUA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tqRsQyuEuUfJjVPNxQBYj2W6EfPkEmS1TfFTaqSQ1WPqI59VjBUhlzDWzUeahJu6cgJOeJeQlbfbUUcnX6BGi0HnL2zp5J/agMeXoMYWGpqGKOkYlJrV9b980qYRJ3jIaaOFgIQ4FIviCi7D0LoSMeO67kWR8FKHvSfPHnqx3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RwOL0CQl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4APKtSuH1198373
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 25 Nov 2024 12:55:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4APKtSuH1198373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732568129;
	bh=Csittwh1C7jblOYXjXdXpKBgKx98psQNYYT7A74PDmM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RwOL0CQl9aIi8ddFqF9rVhPaDR+K5q/QLzvIYiRPYi2JWSmuu/4dPpaofSDvNRK4s
	 4Pg3ndFacM02WXEokhQSOJnSHOZIAdoT8eydS5tUUsxNPGIKlY3RSkaM+dc/FzHsUC
	 SVEeks5UcRa4ddcOG69UKqZrVfwOQ5A1pHnYWQ5kbWmbuKts2SjqwDEUot0874ZRCM
	 GtmRaTUaoXOG6tMKS12/NVY1tYnO/MeAHPbhVj9c53lVuLmBSs98QPcamfwHKxki+2
	 x2mPokHvyf5oBzkZ+fXVsaQA05vJhHzNHNosx59Om9qD87sEDFEReUfzKznXU6j/nr
	 kxCiF5XtgXxrA==
Date: Mon, 25 Nov 2024 12:55:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Cloud Hsu <cloudhsu@google.com>,
        Chris Koch <chrisko@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_x86/Documentation=3A_Update_?=
 =?US-ASCII?Q?algo_in_init=5Fsize_description_of_boot_protocol?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z0TheZLKzwqnoZfE@gmail.com>
References: <20241125083136.1540424-1-andriy.shevchenko@linux.intel.com> <d2dfc0a4-d9dc-4dd2-a669-097dcf3491b5@infradead.org> <Z0Q5MIjy0yx6jyNq@gmail.com> <Z0RVgdhYu17lINZz@smile.fi.intel.com> <Z0TheZLKzwqnoZfE@gmail.com>
Message-ID: <C76B9F75-2708-4161-A130-8258981D5DF3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 25, 2024 12:43:37 PM PST, Ingo Molnar <mingo@kernel=2Eorg> wrot=
e:
>
>* Andy Shevchenko <andriy=2Eshevchenko@linux=2Eintel=2Ecom> wrote:
>
>> On Mon, Nov 25, 2024 at 09:45:36AM +0100, Ingo Molnar wrote:
>> > * Randy Dunlap <rdunlap@infradead=2Eorg> wrote:
>> > > On 11/25/24 12:31 AM, Andy Shevchenko wrote:
>>=20
>> =2E=2E=2E
>>=20
>> > > > -	if (relocatable_kernel)
>> > > > -	runtime_start =3D align_up(load_address, kernel_alignment)
>> > > > -	else
>> > > > -	runtime_start =3D pref_address
>> > > > +    if ( relocatable_kernel ) {
>> > > > +      if ( load_address < pref_address )
>> > >=20
>> > > What's up with the extra spaces around ( and ) =2E=2E=2E and incons=
istent with
>> > > the lines below?
>>=20
>> I can remove them=2E This file has a lot of inconsistencies it seems=2E=
=2E=2E
>
>Feel free to send a followup patch that fixes up all of those other=20
>details and harmonizes the style=2E Quality of the boot protocol=20
>documentation demonstrably matters quite a bit in functional terms as=20
>well =2E=2E=2E
>
>>=20
>> > Also, even pseudocode should follow the kernel's coding style and use=
=20
>> > tabs in particular - which it already does in (some=2E=2E=2E) other p=
laces of=20
>> > this document, such as the 'Sample Boot Configuration' chapter=2E
>>=20
>> The problem is that reStructuredText syntax requires that indentation=
=2E
>> I may follow the rules after the rST requirements, though=2E
>
>That's a good solution - thank you!
>
>	Ingo

I, too, would really appreciate help in cleaning up the document and yes, =
the number of inconsistencies that have crept in over the years is quite fr=
ankly embarrassing=2E In a few places I will admit to thinking "did I actua=
lly write this?"

And as Ingo says, it matters, because experience shows that boot loader au=
thors don't ask for clarification, they make their own interpretation and n=
ow we are stuck with a legacy=2E=20

One part of the problem is that reviewing documentation changes in patch f=
orm hides inconsistencies because you only get a few lines of context=2E

On top of that, it would be great if the markup language could be used to =
insert rationale and commentary into the document=2E In some cases I think =
it would really help getting better compliance with the spec as intended, e=
xplain why we make certain recommendations as opposed to "well it seems to =
work", and help catch inconsistencies=2E



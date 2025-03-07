Return-Path: <linux-kernel+bounces-551178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB345A56908
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F412E16F03A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89D219A9F;
	Fri,  7 Mar 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HtYzgT21"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94013156F5D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354489; cv=none; b=KkNksYwd5Zc0g9J6YSy/drod//y9lioGC8kKts63BOonl6GogYj5jgvm7b0HDO3dEnt5FoNBsFlLr8t8EZ+4YHJ80wd2dfmnP9HnagrfT9edagRFMGSN+VNw/WjgjJUrjwj+2BYOn1YqNqnzxXetvbdcdbHcJ5raER5E6b7Kltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354489; c=relaxed/simple;
	bh=adACljFMV30gpVkeQ9nmj7IXI8LZjL3i23KtPXNuCzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JA8MZYXMbl84dkfEpgfIn7ohsVDGucRFK0MhpIt9UX1DsM4y5scXQt9EbYVDZ3EDKxJXDhnFLvnF0R/IdWwXk6m51VPawFi0PpZK3A7bIeOS/vYvDmwaAA0G3D6l28LdaWy8MOqEnGdHbJDkYNN4+hfrAlA2RHdZqve9GNCSr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HtYzgT21; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741354486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sZK01EUOdEdrQEjF3xaVhR3mhgYKF4noUM2m7XenC4=;
	b=HtYzgT216vEqgi1pRfc5y7x+TwE2TSzuid2jZcZztO6Q1n+EmdUdARaVsocsHRU5gfVSJ+
	MtmPUjNbL/JhbFRbnAWlqhe9wt1UvwQxW0tvB47dMRPX/nyvTeuLAZvXkOS92qvXqGLwwC
	jjB/cRAa85p7DMac2xDackDs1KNTP6U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-_zIq0XFkNSCj6oOAvMrBCQ-1; Fri, 07 Mar 2025 08:34:45 -0500
X-MC-Unique: _zIq0XFkNSCj6oOAvMrBCQ-1
X-Mimecast-MFC-AGG-ID: _zIq0XFkNSCj6oOAvMrBCQ_1741354484
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bc5a18c52so8171215e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354484; x=1741959284;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sZK01EUOdEdrQEjF3xaVhR3mhgYKF4noUM2m7XenC4=;
        b=aNm2Aip9NM3vCwd9FJ/zV5GhkuOpqStrDAiAvuD7FItkWDMfT0ieu2j9Yn18Lr6/gg
         czCoukipntOcq2bsXKLf38Ej6hA81xChduhctdiHr9h1umvrRWCfL0Rfo9rGGix20Ywh
         p3lkmoO6nAOjLDCsu7O97n8kaF5UdqWG+9ctL+Ooafm4jlFkWd/K65r0IZfoh9IChA3L
         Zav9mgrHnPw2oXHEYbtICyrxHiXLq3HE4eAJDDXdfUUbEpXF9HkLkzEavd3zdvdGmk6P
         xzlCnj05jKoO1E0iodRk5BvDQjnzIrkt9bZaE+zv2CxfRMcMSI4I9BEgnRLPkaPhSm0p
         Yg3g==
X-Forwarded-Encrypted: i=1; AJvYcCUG6gWQbyRCEj8y+1gR3zrN9QMZmctUtZ72XLbiVJ6xrFGhqvfj+pZHlm8ldRWtVcR5Pmp22hrFQSKMc9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynaXo7s2y5cO1gR0PtJ47DuLMS6YW/0KlQ0cpWGVcKwlANtMFM
	EPmfKY1acWxrkuWsWy6pXwjIS4SnRMVONXycunFjLuHlUlhkrNehiQzA0/l3lBfEt8cMzYhVL72
	Fw2PZQCOEAqOk0gCnGc0EKh907jQ+3ejBjWmXtqJigLP7tOoCP3Q/tgldHb8mEuHZD1u3CBhRhC
	LJiuSto8ZXu8LxT/51cfs/t+JtVwPls/t62R/3j+BG31JjRA==
X-Gm-Gg: ASbGnctMfcTrQUAFGH7QZc1KAtjEl6Z2EfQbGr9yufYYcgzxn6yP5GV4dkEaGPRRAf0
	qbWE1a+sFI/bnYGOQX2U0X29Vc6kTTC2keRu56telCLi1EzbBMm9BCq8HHvJVBOa4JlCZYtM1Ky
	Xsb66EbEixnOF7fAuk7sw7UyjVMm5v1GRKB5F5GJ6oVIGuiFU2IfNyIO21kT5viuMc3swG0JxAF
	BCXA8b8QmBW01z19q7IlLhP904RzbPA0gzwDqmUzk7OwD7T73Lh6TEv141o2BrOYtLFa2buZA8f
	TzmOZxmr8j4=
X-Received: by 2002:a05:600c:5112:b0:43b:daa3:33df with SMTP id 5b1f17b1804b1-43c68702810mr26616325e9.30.1741354483960;
        Fri, 07 Mar 2025 05:34:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDSBBGxJ/HRR1r18BXQ9hdCp1Gcrn38qVKWx/QFhNCrXXt3KMneKO54eZojjaxrGYhBzCufA==
X-Received: by 2002:a05:600c:5112:b0:43b:daa3:33df with SMTP id 5b1f17b1804b1-43c68702810mr26615985e9.30.1741354483416;
        Fri, 07 Mar 2025 05:34:43 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195casm5431778f8f.53.2025.03.07.05.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:34:42 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-efi@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter
 Jones <pjones@redhat.com>, Daniel Berrange <berrange@redhat.com>, Emanuele
 Giuseppe Esposito <eesposit@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, Luca Boccassi
 <bluca@debian.org>, Peter Zijlstra <peterz@infradead.org>, Matthew Garrett
 <mjg59@srcf.ucam.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] x86/efi: Add a mechanism for embedding SBAT section
In-Reply-To: <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
References: <20250305101744.1706803-1-vkuznets@redhat.com>
 <CAMj1kXF-c46Bdw_cmLK-TckxukefqkpAYkOhg3jzfvW6YucDog@mail.gmail.com>
Date: Fri, 07 Mar 2025 14:34:41 +0100
Message-ID: <87ecz9nevi.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> Hi Vitaly,
>
> Thanks for the elaborate writeup
>
>
> On Wed, 5 Mar 2025 at 11:18, Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> SBAT is a mechanism which improves SecureBoot revocations of UEFI binaries
>> by introducing a generation-based technique. Compromised or vulnerable UEFI
>> binaries can be prevented from booting by bumping the minimal required
>> generation for the specific component in the bootloader. More information
>> on the SBAT can be obtained here:
>>
>> https://github.com/rhboot/shim/blob/main/SBAT.md
>>
>> Previously, an attempt was made to add ".sbat" section to the linux kernel:
>>
>> https://lwn.net/Articles/938422/
>>
>> The approach was rejected mainly because currently there's no policy on how
>> to update SBAT generation number when a new vulnerability is discovered. In
>> particular, it is unclear what to do with stable kernels which may or may
>> not backport certain patches making it impossible to describe the current
>> state with a simple number.
>>
>> This patch suggests a different approach: instead of defining SBAT
>> information, provide a mechanism for downstream kernel builders (distros)
>> to include their own SBAT data.
>
> Why does this require a mechanism in the upstream kernel at all?
> Signing the kernel (which includes appending a cert table) does not
> require such changes, so why is this needed when adding an additional
> PE/COFF section?

Hi Ard,

strictly speaking this is not a must (and that's part of the RFC, thanks
for looking into it!). The main intention is to make distro's life
easier by providing a working mechanism upstream. Here is an example of
a downstream-only solution I've drafted for Fedora based distros:

https://gitlab.com/cki-project/kernel-ark/-/merge_requests/3581/diffs?commit_id=07005140712545cb4dfce09da03545d9c54515e6

nothing too complicated but not a trivial one-liner either. I'm fairly
sure kernel maintainers would very much prefer to have a simple
"CONFIG_EFI_SBAT_FILE=/my/distros/sbat/data" instead.

Additional motivation can be to avoid divergence between distros
(e.g. one distro may deside to do things the way this patch does, the
other decides to put it to the end, the third patches 'setup' and so on)
which may lead to some incompatibility and distro-specific workarounds
in bootloaders (e.g. shim) in the future. Third, having the SBAT
*mechanism* supported upstream raises the visibility of the technology
for those who do their own SecureBoot kernel signing.

>
>> This leaves the decision on the policy to
>> the distro vendors. Basically, each distro implementing SecureBoot today,
>> will have an option to inject their own SBAT data during kernel build and
>> before it gets signed by their SecureBoot CA. Different distro do not need
>> to agree on the common SBAT component names or generation numbers as each
>> distro ships its own 'shim' with their own 'vendor_cert'/'vendor_db'. Linux
>> upstream will never, ever need to care about the data unless they choose in
>> the future to participate in that way.
>>
>
> I'm sure this paragraph will make some skeptics happy.
>

It was a heated discussion last time so I had to :-)

>> Currently, shim checks .sbat data for itself in self-test and for second
>> stage bootloaders (grub, sd-boot, UKIs with sd-stub, ...) but kernel
>> revocations require cycling signing keys or adding kernel hashes to shim's
>> internal dbx. Adding .sbat to kernel and enforcing it on kernel loading
>> will allow us to do the same tracking and revocation distros are already
>> doing with a simplified mechanism, and without having to keep lists of
>> kernels outside of the git repos.
>>
>> Finding a place for SBAT section turned out to be a bit tricky. Current
>> PE layout looks like this:
>>
>> - without CONFIG_EFI_MIXED:
>>   +-----------------------------------+-------------------------------+
>>   | setup            [setup_signature]| compressed text | data [crc32]|
>>   +-----------------------------------+-----------------+-------------+
>>
>> - with CONFIG_EFI_MIXED:
>>   +-------+---------------------------+----------------+-------------+
>>   | setup | pecompat [setup_signature]| compressed text| data [crc32]|
>>   +-------+---------------------------+----------------+-------------+
>>
>> Limitations are:
>> - To avoid problems with signatures, all sections must be 4k aligned with
>>   no gaps between them.
>> - CRC32 must be at the end of the file.
>
> We never cared about the CRC32 before with signed EFI images, which
> gets clobbered when the image is signed. Why should we start caring
> about it now?

Oh, that's a good point, actually. As there's no reason to add SBAT to a
kernel which is not going to be signed and signing breaks CRC32 anyway,
we can as well add the section to the very end. Personally, I'd suggest
we then don't put any CRC32 there at all and clearly state that in the
documentation to avoid the confusion when people discover that there's a
CRC which doesn't match.

>
>> - Nothing can be put before 'setup'.
>> - Nothing can be squeezed between [setup_signature] and compressed text.
>> - The whole 'setup' (everything before '.text') must fit into 8 4k pages.
>>
>> Note: .pecompat contains only 8 bytes of useful data but to save the space,
>> the tail from .setup including [setup_signature] is also added to it (see
>> commit 1ad55cecf22f ("x86/efistub: Use 1:1 file:memory mapping for PE/COFF
>> .compat section")).
>>
>> With the limitations, there are three straightforward options:
>> - Put .sbat between .setup and .pecompat. Advantage: with normal sized
>> SBAT, kernel grows by 1 page only. Disadvantage: this one page comes from
>> the precious '8 pages' limit.
>>
>> - Put .sbat to the very end of the file. Advantage: no need to touch
>> 'setup'. Disadvantage: two pages are now needed as we don't want to make
>> CRC32 part of the SBAT section.
>>
>> - Put .sbat between '.text' and '.data'. Advantages: no need to touch
>> 'setup' and CRC32. 'CONFIG_EFI_MIXED' case doesn't seem to make much
>> difference either.
>>
>> Implement the last one as it doesn't seem to have obvious disadvantages.
>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> RFC part:
>> - General acceptance of the idea.
>> - .sbat section placement.
>>
>> The implementation is done for x86 only at this moment but I think it
>> shouldn't be that hard to extend it to other arches (and I hope the
>> solution for those which use common zboot mechanism will be the same).
>
> Please don't create a special case for x86 again - iff this needs to
> be in upstream (which I am not convinced about) it needs to be
> implemented for all architectures.

Oh, absolutely -- if we get past the 'general acceptance', then let's do
other UEFI supporting arches from day 1. 

>
> So I'd like to understand better what is preventing you from appending
> a PE/COFF section on an arbitrary bzImage (or EFI zboot image).
>
> Given an arbitrary PE/COFF image, I see
>
>   Section {
>     Number: 4
>     Name: .data (2E 64 61 74 61 00 00 00)
>     VirtualSize: 0x47000
>     VirtualAddress: 0x934000
>     RawDataSize: 4608
>     PointerToRawData: 0x934000
>     PointerToRelocations: 0x0
>     PointerToLineNumbers: 0x0
>     RelocationCount: 0
>     LineNumberCount: 0
>     Characteristics [ (0xC0000040)
>       IMAGE_SCN_CNT_INITIALIZED_DATA (0x40)
>       IMAGE_SCN_MEM_READ (0x40000000)
>       IMAGE_SCN_MEM_WRITE (0x80000000)
>     ]
>
> as the last section. There should be sufficient space in the header to
> add an additional section descriptor.
>
> So what is preventing us from just appending the SBAT data to the
> file, and creating a 5th section that lives right after .data both in
> the file view (at 0x934000 + 4608) and in the memory view (0x934000 +
> 0x47000). That should produce a valid PE/COFF image, no?

Yes, if we forget about the CRC32 (which we do anyway), then adding a
section to the end by external tool should work for as long as we have
enough space in the header to add a new section. As this is going to be
a downstream-only approach, nothing will guarantee that long term and
things may eventually break.

-- 
Vitaly



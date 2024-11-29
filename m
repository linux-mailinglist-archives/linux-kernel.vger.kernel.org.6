Return-Path: <linux-kernel+bounces-425268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2639DBFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5762281FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934551581EE;
	Fri, 29 Nov 2024 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSR3TF67"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F083155342
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864306; cv=none; b=kOx8KTXLJIbD5NizZ/HNOs4IPomVw4+8fScMqmokw3mlCraPD0vEtzgaoFYB6NIg0dLGUvjINlMaWQEG6Uxrc7Pz+KMDWInnmyIIPm7NVZwTggwF/bRhhX5ADTlj/p8HOa6mTmPHmy7PILxKrQu0Di9nNhQKO5dEZQrzpH6rKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864306; c=relaxed/simple;
	bh=8VcFjYDKaw3Qsc17Njnz6igX6rknkM4yf+dmt/yglcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYQ5wZ+BcaWiT8BPd8C067UKp9YS5tb7pH0DpEuUD1b2tLbxwrNJ4UouY5xthPAEHrnNbyRBCbkj4efKsL6JE+xTO9rfSAZpYjO5Z6eThebt1aoXIZwtW7EN7+CJ1di3S/YEmipKCz0z4usIxapAIJj87HofYI8VeCs8N6mv0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSR3TF67; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732864303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWT0OxMsEzDV+GInq5dR2gW9nX3HUCC+dF6QXlOVL+E=;
	b=fSR3TF67XiM19IKpjlDnb4NkiyBBMnFjh5r3psw87kzvsNMISkARjt7M/FsDk2H8xvIdL8
	OMr2A1U3XlbVoY1p93liV303AXzwSUc7jElB3iC/C541Shghc7AZDOGx7441tp1/6el9Jl
	DyEUzAfir5cKlgsvSo1LWf3C1EtS4SA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-RU1KxiC2MSe7V7HvOhNbFA-1; Fri, 29 Nov 2024 02:11:39 -0500
X-MC-Unique: RU1KxiC2MSe7V7HvOhNbFA-1
X-Mimecast-MFC-AGG-ID: RU1KxiC2MSe7V7HvOhNbFA
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso185842539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732864298; x=1733469098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWT0OxMsEzDV+GInq5dR2gW9nX3HUCC+dF6QXlOVL+E=;
        b=TNAW8indRNhZTo05XTtUPCyWtoMf6ZqvRmH2UWXtlUe5C2QyEX3CMnXMDQVlWYOARv
         4eb32ObJFrGI3ZW8oJYyLWLFoWvnnzQT5FCgVPZdDl6lP44Qj6nKTgpV9LwZQfH7Iltw
         XID4roX9WKYyFimpOhZmtDPLcJi3f2PaZTRSdqCvtMIxgo27JYtVfRgJWnJjnRESTItu
         G9UCfWpiD8uHAK0KTdFaLtpI3JQnS5M1as63FE8O8jTgWQicmdTW07/Aa8RJcn6lDtni
         tavlKlX9LodGVG00Vz9x+i57uvYbEsyYYeYbG8BYmvHtC9C5yxz/5/Zlgc4ldxzkX4CM
         6Ovw==
X-Forwarded-Encrypted: i=1; AJvYcCUGAp0bTYzrcT7wg4wRXAIyaHOtIFACf9XPMLptVjj7zl15WuSldJTivyn4vm1Mxi0Kc/jriaQAYnnQYPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1opnDDTzEUrwmYUdvuDlqZTPf388w/7vGV5gpzIeAdRaZAkH
	660wl/eYWT0Kl0nFMblLvmUboYkjbia/gE39M81woZK6BGcaR1xHhJcJfvCxShmyQ3ODj94gvVA
	j2TE0k7iqrnBCbNKDM/9p2VeKSdeclDwzAHNj9SDwHA1Mv86wv/G7xkmvUz0RRWr/E/FltCMLAQ
	3+hw9iQQkR1EtNZbx67oCtZghGr+rZ/7shAtmp
X-Gm-Gg: ASbGncvt40pE+8As932ez3c7ahrIhTg0u4TU+stdBTmfxiHN77eD3Xoj2mafvOXy3R/
	n6/gNpAjP/RZje+XbuT4cWPWIsGH+vfqU
X-Received: by 2002:a05:6e02:1b01:b0:3a7:9b16:7b6c with SMTP id e9e14a558f8ab-3a7cbd45e72mr58232275ab.9.1732864298347;
        Thu, 28 Nov 2024 23:11:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaJIDjEubmCy0aOLU9g/LdsGvxQayrOWZjhM4HHxnHxAtqspZGb5f7pNvetVWe16XLz7C0JNOwniYKeQx8YGA=
X-Received: by 2002:a05:6e02:1b01:b0:3a7:9b16:7b6c with SMTP id
 e9e14a558f8ab-3a7cbd45e72mr58232215ab.9.1732864298121; Thu, 28 Nov 2024
 23:11:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com> <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
In-Reply-To: <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 29 Nov 2024 15:11:33 +0800
Message-ID: <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Nicolas,

On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Hi Dave,
>
> On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> >>
> >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> >> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> >> the original kernel. Unfortunately, that function fails to reinstate
> >> EFI's memory attributes, which would've otherwise been set after
> >> entering virtual mode. Remediate this by calling
> >> efi_runtime_update_mappings() within kexec's routine.
> >
> > In the function __map_region(), there are playing with the flags
> > similar to the efi_runtime_update_mappings though it looks a little
> > different.  Is this extra callback really necessary?
>
> EFI Memory attributes aren't tracked through
> `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
> `__map_region()` after kexec will not honor them.

From the comment below the reason to do the mappings update is that
firmware could perform some fixups.  But for kexec case I think doing
the mapping correctly in the mapping code would be good enough.

        /*
         * Apply more restrictive page table mapping attributes now that
         * SVAM() has been called and the firmware has performed all
         * necessary relocation fixups for the new virtual addresses.
         */
        efi_runtime_update_mappings();

Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
create the virtual efi memmap,  but I think the __map_region is called
after kexecing into the 2nd kernel, so I feel that at that time the
mem attr table should be usable.

Anyway thanks for explaining about this.  It is indeed something to
improve.  I have no strong opinion as your code will also work.


>
> > Have you seen a real bug happened?
>
> If lowered security posture after kexec counts as a bug, yes. The system
> remains stable otherwise.
>
> Nicolas
>

Thanks
Dave



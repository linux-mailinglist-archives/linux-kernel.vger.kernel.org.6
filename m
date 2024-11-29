Return-Path: <linux-kernel+bounces-425277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59C69DBFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055A4B21B89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C5156885;
	Fri, 29 Nov 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAjwKXoZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADFB184F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732865521; cv=none; b=dfDWBv5n3VNamM9psstBAhhNvemngkx0STQ5g8tPTBicEtB/XkizJnRScCgUbDR0QKcJ9HO3NyMB2vuOSUULm7YjYxj05CX4M2RVvHjHE3vXvLql1h0Tqn+yo8cRDC9wvAZlLrt73qG8oSKpbKxnbH1Ti+qICsavf4fj+RA9FSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732865521; c=relaxed/simple;
	bh=xWaYTuZezpdtPQcdPqMmVue9U3gGtYVx84uQtss2cs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxtgYs6IX+NAIi1f8bfHeFp615yHdVbS/ckELmYDFxm3lkZiNf5uNsEl/Y2ldtZAeDTS1M99FmlVJ38LZOc+lkam7+e1wnDFLxM+GeFYVYXe9DV0T+u0oZBPyqXlPWWrdp3gy4Gsd2KpBhXULLsQWawYW0YfEcudH1UD4QcaHQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAjwKXoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732865518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znTNIV4yiUpsXZL1w3uAqvfGDGwGUOkw2J9EURHxCtI=;
	b=hAjwKXoZ+/cE2gi5EJAdsbbIaH9GRzTYiHAEz3VJC1/R9T1JAOJjAyR6zDO6yEond9HUo0
	0J3miv09ERLBP3gfy9DNneH/LtHq54/DRRKui8AmVD4lp2angVGMDJf3cnTsaGy9tH/Zrr
	cnMQWQxuGi37cr+5L3z9yiaHsvybyks=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-m6Q9RegvNRWj_TQ_bmxvqw-1; Fri, 29 Nov 2024 02:31:57 -0500
X-MC-Unique: m6Q9RegvNRWj_TQ_bmxvqw-1
X-Mimecast-MFC-AGG-ID: m6Q9RegvNRWj_TQ_bmxvqw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2126573a5b0so16598075ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 23:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732865516; x=1733470316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znTNIV4yiUpsXZL1w3uAqvfGDGwGUOkw2J9EURHxCtI=;
        b=CCoop0VLr4Jckawu+BmQBt5x1ovoWpht45frfagYU6F6oWd1TgPtr8Dv9LKr9m8Rs7
         1pfDYbyZ1bpTr/vRbI8XaLynGBXnWgsDXTq88bntQrT7zZDy/yRdDgKL1KqSXkABCFxQ
         1RWQvjnf37TVUIxkwGz1E1YBn9WPRSczBdPpJlSnjW4SIpNZ/BoUgyKsSFnqNb7UDqcA
         PtPZwKRwh46/dWZ+rz0HlJEHJoNkQbPSh6bno6ZW9/E0DA1bkPRVqivkKmSyZ4w1G3Rm
         hoZP6ux36M7xeHWsjfdtr/bu70JKlkV6t3snD07X55gHataAywSGrRDm2GM/Q0A1RiuO
         SpUA==
X-Forwarded-Encrypted: i=1; AJvYcCVe4q8gwbs8ae+CkvYc7rKuCpRVIB2xEzXqxGIfRd3uvsQNAgjhNjEZHA2f/NkURTmskmU29k/euJRAOuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrlW2ixH7AXSaHtjpbed209hXMQkyE4v4hREBGcyj6XfIrA+JS
	oNGDPpNFvzhNGau9G9vw6SOnKHZArcAHXe4td5DGwdgSyosY7j1VH2+tMBuZEL72CqlnSttEl/g
	K/Jxhbkucvr1+933kpRKRuIqeeUSqpgxChUqndA3kTfvbAdlHOv6WRHhn8n8kR1wntDGjAXhRYZ
	bMB8xIOLCPEsk40ExkKmDvvvJjkdJCTgZrT7Lx
X-Gm-Gg: ASbGnctDuElNaqFzqsa7YycU5TNSaEMgiYOrF0A+aXle1pvgdUIbfZk4HNMDu8eLhh/
	KHzkw8Z3NqArvr5Lz9fF7NykaBiN9YqQI
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id d9443c01a7336-21501381ba1mr114779955ad.21.1732865516090;
        Thu, 28 Nov 2024 23:31:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh9PVUdRddFYSNm3UAC8iohKaFfKlk5Hz1e9QnkR2ed+tnFKg6KvsdnxD7bVahLsd/3R//CZpc/mtOTZkKAJE=
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id
 d9443c01a7336-21501381ba1mr114779725ad.21.1732865515779; Thu, 28 Nov 2024
 23:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
 <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
 <D5XXP2PU3PUK.3HN27QB1GEW09@amazon.com> <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
In-Reply-To: <CALu+AoSDY6tmD-1nzqBoUh53-9C+Yr1dOktc0eaeSx+uYYEnzw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 29 Nov 2024 15:31:50 +0800
Message-ID: <CALu+AoTAQ_v7SL-_c_F74TfXWmwYMNV_MRD9zWVyiHuXfa6WtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 15:11, Dave Young <dyoung@redhat.com> wrote:
>
> Hi Nicolas,
>
> On Thu, 28 Nov 2024 at 23:58, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> >
> > Hi Dave,
> >
> > On Fri Nov 22, 2024 at 1:03 PM UTC, Dave Young wrote:
> > > On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
> > >>
> > >> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> > >> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> > >> the original kernel. Unfortunately, that function fails to reinstate
> > >> EFI's memory attributes, which would've otherwise been set after
> > >> entering virtual mode. Remediate this by calling
> > >> efi_runtime_update_mappings() within kexec's routine.
> > >
> > > In the function __map_region(), there are playing with the flags
> > > similar to the efi_runtime_update_mappings though it looks a little
> > > different.  Is this extra callback really necessary?
> >
> > EFI Memory attributes aren't tracked through
> > `/sys/firmware/efi/runtime-map`, and as such, whatever happens in
> > `__map_region()` after kexec will not honor them.
>
> From the comment below the reason to do the mappings update is that
> firmware could perform some fixups.  But for kexec case I think doing
> the mapping correctly in the mapping code would be good enough.
>
>         /*
>          * Apply more restrictive page table mapping attributes now that
>          * SVAM() has been called and the firmware has performed all
>          * necessary relocation fixups for the new virtual addresses.
>          */
>         efi_runtime_update_mappings();
>
> Otherwise /sys/firmware/efi/runtime-map is a copy for kexec-tools to
> create the virtual efi memmap,  but I think the __map_region is called
> after kexecing into the 2nd kernel, so I feel that at that time the
> mem attr table should be usable.

Another thing I'm not sure why the updated mem attr is not stored in
the memmap md descriptor "attribute" field, if that is possible then
the runtime-map will carry them,  anyway, the __map_region still needs
tweaking to use the attribute.

>
> Anyway thanks for explaining about this.  It is indeed something to
> improve.  I have no strong opinion as your code will also work.
>
>
> >
> > > Have you seen a real bug happened?
> >
> > If lowered security posture after kexec counts as a bug, yes. The system
> > remains stable otherwise.
> >
> > Nicolas
> >
>
> Thanks
> Dave



Return-Path: <linux-kernel+bounces-328048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588FB977E48
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8C9287122
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD991D86E6;
	Fri, 13 Sep 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTmx4zmm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542BD1D7997
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226032; cv=none; b=CnsV4wJUCV0vDrH1T7R3DEvyzwY/bDTFjEDBrjMWgzDDYCs4T6DORhKvYgLNpXsUjh8WhxS3cUEABSxa5AtlSxLNVWwggUuhi8nEeNL0LYtUBTn92wJtBQzrrjiczfPyDfycf7tJpLOMSYHw1EL/DXbVjRyuIk6+yIj8FjNNBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226032; c=relaxed/simple;
	bh=qviUKxj2ShBNT1+2oFVXBp5YaTG7MqEK1RKmcyVIQp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEMenasSMH5f1JVYAac21qZ2OHBEOXjBDKnHKk8AU1yTU2+e4jCi84ewH6Z3VNS1XrfJv2E7TyG5N+MYSG1ZiqrEMLPkm9R1IAVELMWY7BgyIepakMT4hC8Xhu/QLBt/yMorgBxuyHWiM8oOJ0H9lM8IOGpxHkErovUeafG2PuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTmx4zmm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726226030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MASR/9GQZ3+JJGeE8AwFTJhS8+TAiNPcAVjIePuGwyw=;
	b=UTmx4zmm4Jx0MaQnczsa4bLv6ZW2jbxn3veFpIUgP2lIBQrozBAZiuDfFm2HpJ+QoiqwpR
	GNn/5M2Q7M8r1hM1lQ4HQEdmwnBwFz/K0ZyJJd/Nky9p/TmTpCI/ENpgnFOEyrH6Gzep/J
	gA4vX+4I+WFda+zzNK+bnxfIamPitRc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-gZobtFdIPP2vnG0279GyQg-1; Fri, 13 Sep 2024 07:13:49 -0400
X-MC-Unique: gZobtFdIPP2vnG0279GyQg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a08cab4de9so4070425ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726226028; x=1726830828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MASR/9GQZ3+JJGeE8AwFTJhS8+TAiNPcAVjIePuGwyw=;
        b=hoTR9XnM5alC/fCAQXpyoeraLMXshvp7Sg5dO96xn4iQ7ChzhA8Q26dlVNf/S/tvXY
         hIvgOUWFJj1j8HhUlxhiVUUH1ggIaPONgtdvnlK7zRFazgjaQDMnTXc0D2Qz43Ex9ggc
         9sCw6aiEiuOg7k1PSy//5SQ/p81cw7s31xcGkWYExeSS4vADRKLs/STajPtqwsDlXH3y
         7QIBbvG9X+bvdiEZw6uNTnOoepbWbLhdyfXBvA57Xcy+1nSu9FPCVDo/P4/1stzHdOog
         lqLGdMs8aOvDYQ8yIMrcl4JgWgadyaO5BfaLdY3kcHqmGRETg8D4AhI53lLgTJqQnvsf
         eUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUkJbYNoSy7Kv8fW9rYw5qGcGa/D7jZSU2yOpdiIPnjJ+wQzLJpiPfPDYWhOwLJYHKRSy4u9gwlbUfaI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtJbZHP1yaZHSaU/sBt3wsk+jYpVuMDFTyoMyaNPpOXGPQnjbY
	zjlyz5MOiqQi5WRMJ15n5uDMSswwwlNv5FELq3zmkFx4nhSgeIbuo7p7nbXXn7PEn7aTdhVyuY0
	PK4Uot2hUJ3HgdwFgpRehoX5Rj+tlKIA29BZ2DAvfFa/XfE0mJiB4/5MFw8xrdJm5Kx8GExruxC
	SYwRmkgRt39jvhGGruL3QtwhgRTXMqAVR+aM8o
X-Received: by 2002:a92:b706:0:b0:3a0:8c8f:99ec with SMTP id e9e14a558f8ab-3a08c8f9aa5mr8882535ab.13.1726226028404;
        Fri, 13 Sep 2024 04:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsWFNdjlLRYC7/y0fJaPtKleRTR1PQe/Z3y/C8TCNPCol5vlzUbHhhMuwMbrDKD5nzJW0Xw4zuyyUIzT7g0uI=
X-Received: by 2002:a92:b706:0:b0:3a0:8c8f:99ec with SMTP id
 e9e14a558f8ab-3a08c8f9aa5mr8882345ab.13.1726226028010; Fri, 13 Sep 2024
 04:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com> <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
In-Reply-To: <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 19:13:57 +0800
Message-ID: <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 19:07, Usama Arif <usamaarif642@gmail.com> wrote:
>
>
>
> On 13/09/2024 11:56, Dave Young wrote:
> > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> (cc Dave)
> >
> > Thanks for ccing me.
> >
> >>
> >> Full thread here:
> >> https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> >>
> >> On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>
> >>> On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/09/2024 14:10, Ard Biesheuvel wrote:
> >>>>> Does the below help at all?
> >>>>>
> >>>>> --- a/drivers/firmware/efi/tpm.c
> >>>>> +++ b/drivers/firmware/efi/tpm.c
> >>>>> @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> >>>>>         }
> >>>>>
> >>>>>         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> >>>>> -       memblock_reserve(efi.tpm_log, tbl_size);
> >>>>> +       efi_mem_reserve(efi.tpm_log, tbl_size);
> >>>>>
> >>>>>         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> >>>>>                 pr_info("TPM Final Events table not present\n");
> >>>>
> >>>> Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> >>>> which is e820_table_firmware.
> >>>>
> >>>> arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> >>>> its end, just with e820_table_firmware instead of e820_table.
> >>>> i.e. efi_mem_reserve does:
> >>>>         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >>>>         e820__update_table(e820_table);
> >>>>
> >>>> while arch_update_firmware_area does:
> >>>>         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> >>>>         e820__update_table(e820_table_firmware);
> >>>>
> >>>
> >>> Shame.
> >>>
> >>> Using efi_mem_reserve() is appropriate here in any case, but I guess
> >>> kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> >>> table, and 3 (!) versions of the E820 table in the correct way
> >>> (e820_table, e820_table_kexec and e820_table_firmware)
> >>>
> >>> Perhaps we can put this additional logic in x86's implementation of
> >>> efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> >>> with configuration tables produced by the firmware that may not be
> >>> reserved correctly if kexec looks at e820_table_firmware[] only.
> >>
> >
> > I have not read all the conversations,  let me have a look and response later.
> >
> > The first glance about the patch is that I think the kexec_file_load
> > syscall (default of latest kexec-tools) will not use
> > e820_table_firmware AFAIK.  it will only use e820_table_kexec.
>
> I initially thought that as well. But it looks like kexec just reads /sys/firmware/memmap
>
> https://github.com/horms/kexec-tools/blob/main/kexec/firmware_memmap.h#L29
>
> which is e820_table_firmware.

That piece of code is only used by kexec_load

>
> The patch that Ard sent in https://lore.kernel.org/all/20240912155159.1951792-2-ardb+git@google.com/
> is the right approach to it I believe, and I dont see the issue anymore after applying that patch.
>
> >
> > Usama, can you confirm how you tested this?
> > kexec -c -l  will use kexec_load syscall
>
> I am currently testing in my VM setup with kexec_load. But production is running
> kexec_file_load and has the same issue.

Ok, I mean efi_mem_reserve should be able to work if you retest with
kexec_file_load.

>
> Thanks,
> Usama
>
> > kexec [-s] -l will use kexec_file_load syscall
> >
> > Thanks
> > Dave
> >
>



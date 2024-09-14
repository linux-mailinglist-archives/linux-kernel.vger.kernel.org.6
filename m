Return-Path: <linux-kernel+bounces-329189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB3978E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854A61F24BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE731AC882;
	Sat, 14 Sep 2024 06:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA/ca8XY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE91A42D6
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726296365; cv=none; b=VP0ulyR5mYN1jJy94uxWk35Qbfwrm19ylhD0NwB9331/DziKPpT6De3Qt2E2QTaA6GkOjtuG1IMCUgve3w4NfuhBnN/8fZdfkCYzWAK//mowKP/eDJPC6EX6AqewVThgnq0UOpbAsuDMKPrBfC36k5pflUkw0KfvrOm/InlDWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726296365; c=relaxed/simple;
	bh=B+tUlhexzHIKFHjAPKP/mBUd1RPqfSazamtOQbN+/2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLuTEnfBhB3tBM7Z+vQAyHiXRy1gEV2lE7ZaPjau4XRgQPCZhq6iNMUcC/eNsELtxofv0lFTDSxqmjrAIlVULl0a/KGEG3H7sEky36k43o8Q8IuzgQwBrWmOzieJGr3Dp3AFeyw2eYYZTXsZeX44oSN34e8LMV+S3T/96x4Icek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gA/ca8XY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726296360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eE+sUtCjdi/s3uFDNMp4FAK3ec8qOZ3QSC8oSZ6JDTs=;
	b=gA/ca8XYiBr2KFPQLV8C6Vh76njsxMtp9DBmiNHfnd9KRtsFLjDDYRw0MpCM0KGxQNjeIc
	ztrLbJuoFW9Lgtdgu3s/GN/64nzpe08AflKEXALddTJ0BV4UH1V1QT7DhQ0oFTtDcJRBul
	mzbuWs7ttlOra7qOFCevSpSlE4nIRTg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-TLAvEKw4PX2aCGDmGrAXXA-1; Sat, 14 Sep 2024 02:45:58 -0400
X-MC-Unique: TLAvEKw4PX2aCGDmGrAXXA-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso51436455ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726296358; x=1726901158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE+sUtCjdi/s3uFDNMp4FAK3ec8qOZ3QSC8oSZ6JDTs=;
        b=clOJ22njtZH2OlsEhoc2tP1jM29iHsQGoFHcOP8dc2ijysRrJnFjwatiHrpAtW+HO5
         R0An7nXHKwe3c9IRPf/l3+gzeyKvoXdO/Vjs0y/bV4g5N6AH2TkCNX6Zorny9YlJR0H2
         nRR2YJxZOvU5fH/NL9ufrfq4C7/5tDAh0Q3Lqo1Ni/kJetGsfTINFTR5BX84MW6MDsKr
         Dl+KDQzh7o2HMmGSi+R7U1v8pHs2qZ/KYZQmWSMhE1tXieN7IZHw8NSB0hPCelPZ+528
         eSStp8RLYGuCwLIQcNxdRk7C2s5CizNYE7Ptxxc6EENdB7k82tYXRGOS61dZAkkbRY4h
         /T/w==
X-Forwarded-Encrypted: i=1; AJvYcCXxs3hrVHmM8scRv7rCH0KZEcYHm/CefMA5vL15lti4v6hBfUyGoQnJAkWcvyGaHKe4Qysw8nMQ58SQSC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymY0J7MX5yUs10T82DMhtZaXG8Qc97hX5Xps/fyHt3R7ex0aLU
	xAE5QcKqocBclsyWj+WiRes3GKpUj7BAcEGV4n69ofhlGl5sF6ghk7K/YNRfhfnTxk8nEnQqfQT
	3gU3Je1KE3xkRYwJdFIHGCadr+P2CKRer5f3Bj1t8VSNoKlSKrFsPsePAEF7ZJBoeFgyO0XM7aI
	4xiRRpvxS94Ik616w98lrju8DPR7ZLEow3SNK6
X-Received: by 2002:a05:6e02:20c3:b0:3a0:65a0:460a with SMTP id e9e14a558f8ab-3a08b7853d2mr56807635ab.19.1726296358184;
        Fri, 13 Sep 2024 23:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKtOV06MvITuNSFqCNIuipejGNDZMGs5HGBfR92MW39oPD8LiixfpPzOKJFy295hNSsVybcQ9a493Mk9E08Vc=
X-Received: by 2002:a05:6e02:20c3:b0:3a0:65a0:460a with SMTP id
 e9e14a558f8ab-3a08b7853d2mr56807495ab.19.1726296357859; Fri, 13 Sep 2024
 23:45:57 -0700 (PDT)
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
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com> <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
In-Reply-To: <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 14:46:07 +0800
Message-ID: <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>, Usama Arif <usamaarif642@gmail.com>, 
	Breno Leitao <leitao@debian.org>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, 
	ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com, tglx@linutronix.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
>
> On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > (cc Dave)
>
> Thanks for ccing me.
>
> >
> > Full thread here:
> > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> >
> > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > >
> > > >
> > > >
> > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > Does the below help at all?
> > > > >
> > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > >         }
> > > > >
> > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > >
> > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > >                 pr_info("TPM Final Events table not present\n");
> > > >
> > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > which is e820_table_firmware.
> > > >
> > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > its end, just with e820_table_firmware instead of e820_table.
> > > > i.e. efi_mem_reserve does:
> > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > >         e820__update_table(e820_table);
> > > >
> > > > while arch_update_firmware_area does:
> > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > >         e820__update_table(e820_table_firmware);
> > > >
> > >
> > > Shame.
> > >
> > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > table, and 3 (!) versions of the E820 table in the correct way
> > > (e820_table, e820_table_kexec and e820_table_firmware)
> > >
> > > Perhaps we can put this additional logic in x86's implementation of
> > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > with configuration tables produced by the firmware that may not be
> > > reserved correctly if kexec looks at e820_table_firmware[] only.
> >
>
> I have not read all the conversations,  let me have a look and response later.
>

I'm still confused after reading the code about why this issue can
still happen with a efi_mem_reserve.
Usama, Breno, could any of you share the exact steps on how to
reproduce this issue with a kvm guest?

Thanks
Daev



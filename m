Return-Path: <linux-kernel+bounces-329289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CCF978F99
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4345286EEB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F461CDFD4;
	Sat, 14 Sep 2024 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLS0+6Kg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6833999
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307207; cv=none; b=YEV2fbEuziuhsS474gNFpcekCIIYylgP9AXQEvSUdVxoVLn8E60DN9VGIQktJrJ0eSu2QmgNZGy1V+QMaFSeCY/r8DdtWvRmYCbuTSrm9EZYe3lVCyc7qtRvJwnUt84Nl6DiDaVSnP2WiAy4rBdjE4TmnkZkyfS4F4MkO1YFXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307207; c=relaxed/simple;
	bh=HfDs9vKKpUMXKBktOYCjRMqkPLi1l0HAt9gIy7hkfnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mY8bpJpzKkH8qBkCcb6yiIpJ6gDQQv2g7Zy6i2DkYvVHCq/Xs3lirgIgQrXlf3PdOl6vnVPhTuHtYpcdKtpCt8GCySnGU8heCOdji3JhQ8yoABvah/He8AlPv6W+sz2tzPWMlpUqLQAKr+88YVggXdRrQKi9g4u7yfqWqAlLlhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLS0+6Kg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726307204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxxOFQJCqEB32Xbl36OLM2qVBup0qK/FWWJmZiWVi+c=;
	b=OLS0+6KgEjN/ISMUBTBQN/zq5DXTfBa7i5tpwvWIzOshJv8/9PgEvKYOWO9JdYlLg7rNf/
	1tHehnp22gJ+oaY7fff480nP5Z5njHPvOKB5+TD6Fjd236tPa37d61vvpkmIhJuFUWD4n4
	oRCaqoISOU6V+Ejek+Yr0bkyZxUVHCY=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-dAF0CPwFNAm7VL5yLvJSgA-1; Sat, 14 Sep 2024 05:46:43 -0400
X-MC-Unique: dAF0CPwFNAm7VL5yLvJSgA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf2a9da36so327593639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726307202; x=1726912002;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxxOFQJCqEB32Xbl36OLM2qVBup0qK/FWWJmZiWVi+c=;
        b=wvuFCVDG0Fw2y4l/tm2azdEyRrMJuLWCnCpD4NYCDxQlPt/KI+92M+mydhenmkp74Q
         qHDhtkGjyKKyRYq7yprlUCSdk7MyJI8nrIc16112u3g/KmoZHEVMs/im4Y2OOIZ7z+Hu
         B0lUeKEjjSrlYiQCEVScjI+Pb10rZSA1pJKQN80KKAVPJUmYh7E5elIvt1cv2D78IC0g
         MdkZUBMIM24OsG4hU8Ni7dtXwHcD1Hj5pg57wDa0+SirI+tx9hxipp6G/JF9trwqN3tX
         eH5nC8D5nKNPJbEWsOmhQ0GZqWe8drTU7lhr7MwlUA+xSlEvHz2DLPohF7mF3Afggahe
         4tAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5A3fk1STqPkGhWNXub6yU5fsrDCdwaMCH8quU7p61VSDMHCdXOIwfwxJ+otccTr5JzToD+FanNhkVsvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rahEJRrxGJ/CKPc73m4X7FOWOlz0DbUQsJAQf+7O044ArmU/
	8mB5MyeQO5sUS7IFYgqTXNyXc1ekB7Y9OGXSqWZH8UaSyq1ZzLtrW3Wgw+s3eNKXdBdMBubuF2X
	D+d++yWwtLp5u04QrxsWuZkbJxQwdj1yZYsQVL69D5hWp+wUdoiAOE5t1WOdjpXwz19xk+OPKRG
	5ux2qk0+z7pK6Ak1gEfmK/2At+SO+3y+EPx9vb
X-Received: by 2002:a05:6e02:1d86:b0:397:6dfc:993a with SMTP id e9e14a558f8ab-3a08b7a94b0mr45629685ab.21.1726307202212;
        Sat, 14 Sep 2024 02:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIEuPHrZGBWWZc7Rwb3xSzsldHkhVkQXmjDXeLX8wKGTKKCnEJ2HsxTey1fcAd2uKlGSJCk/nMrJhmDcqEzGo=
X-Received: by 2002:a05:6e02:1d86:b0:397:6dfc:993a with SMTP id
 e9e14a558f8ab-3a08b7a94b0mr45629465ab.21.1726307201800; Sat, 14 Sep 2024
 02:46:41 -0700 (PDT)
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
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
 <CALu+AoTQ6NFDuM6-5ng7yXrDAmezdAsdsPvh7KKUVdW4FXPe7w@mail.gmail.com>
 <CAMj1kXEXH2YvWtzEJEEOnTLqACsRhan3Lf9OCLYDjKf6gxDmBQ@mail.gmail.com> <CALu+AoSp1ZryfH_j6RYqeCCjG5mFf6JkgaF4V9UwgPp+pE+mjA@mail.gmail.com>
In-Reply-To: <CALu+AoSp1ZryfH_j6RYqeCCjG5mFf6JkgaF4V9UwgPp+pE+mjA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Sat, 14 Sep 2024 17:46:50 +0800
Message-ID: <CALu+AoQto=vnvhv1K+7_Lm85+Rw9WqmKD6zB8mH9T9xkvX-T4w@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Sept 2024 at 17:24, Dave Young <dyoung@redhat.com> wrote:
>
> On Sat, 14 Sept 2024 at 16:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Sat, 14 Sept 2024 at 08:46, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > On Fri, 13 Sept 2024 at 18:56, Dave Young <dyoung@redhat.com> wrote:
> > > >
> > > > On Thu, 12 Sept 2024 at 22:15, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > (cc Dave)
> > > >
> > > > Thanks for ccing me.
> > > >
> > > > >
> > > > > Full thread here:
> > > > > https://lore.kernel.org/all/CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com/T/#u
> > > > >
> > > > > On Thu, 12 Sept 2024 at 16:05, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, 12 Sept 2024 at 15:55, Usama Arif <usamaarif642@gmail.com> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On 12/09/2024 14:10, Ard Biesheuvel wrote:
> > > > > > > > Does the below help at all?
> > > > > > > >
> > > > > > > > --- a/drivers/firmware/efi/tpm.c
> > > > > > > > +++ b/drivers/firmware/efi/tpm.c
> > > > > > > > @@ -60,7 +60,7 @@ int __init efi_tpm_eventlog_init(void)
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > > > > > > > -       memblock_reserve(efi.tpm_log, tbl_size);
> > > > > > > > +       efi_mem_reserve(efi.tpm_log, tbl_size);
> > > > > > > >
> > > > > > > >         if (efi.tpm_final_log == EFI_INVALID_TABLE_ADDR) {
> > > > > > > >                 pr_info("TPM Final Events table not present\n");
> > > > > > >
> > > > > > > Unfortunately not. efi_mem_reserve updates e820_table, while kexec looks at /sys/firmware/memmap
> > > > > > > which is e820_table_firmware.
>
> Updating e820_table should be good enough, it depends on where the
> corruption is happening.
>
> kexec will find a suitable memory for the kernel via searching through
> the system ram resources.   So efi_mem_reserve will update e820_table,
> then reserve in the resources list as E820_TYPE_RESERVED, thus it
> should not be a problem.
> During the 2nd kernel boot phase, it is carried as EFI_LOADER_DATA
> with EFI_MEMORY_RUNTIME attribute, I think it is also fine,  and later
> efi_mem_reserve will be called as what have been done in previous
> kernel.
>
> So I think no need to update the e820_table_kexec and e820_table_firmware


Hmm,  oops, I again forgot the kexec_load code in userspace kexec-tools.
The kexec-tools code still searching for memory ranges from e820_table_firmware

>
> > > > > > >
> > > > > > > arch_update_firmware_area introduced in the RFC patch does the same thing as efi_mem_reserve does at
> > > > > > > its end, just with e820_table_firmware instead of e820_table.
> > > > > > > i.e. efi_mem_reserve does:
> > > > > > >         e820__range_update(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > > > >         e820__update_table(e820_table);
> > > > > > >
> > > > > > > while arch_update_firmware_area does:
> > > > > > >         e820__range_update_firmware(addr, size, E820_TYPE_RAM, E820_TYPE_RESERVED);
> > > > > > >         e820__update_table(e820_table_firmware);
> > > > > > >
> > > > > >
> > > > > > Shame.
> > > > > >
> > > > > > Using efi_mem_reserve() is appropriate here in any case, but I guess
> > > > > > kexec on x86 needs to be fixed to juggle the EFI memory map, memblock
> > > > > > table, and 3 (!) versions of the E820 table in the correct way
> > > > > > (e820_table, e820_table_kexec and e820_table_firmware)
> > > > > >
> > > > > > Perhaps we can put this additional logic in x86's implementation of
> > > > > > efi_arch_mem_reserve()? AFAICT, all callers of efi_mem_reserve() deal
> > > > > > with configuration tables produced by the firmware that may not be
> > > > > > reserved correctly if kexec looks at e820_table_firmware[] only.
> > > > >
> > > >
> > > > I have not read all the conversations,  let me have a look and response later.
> > > >
> > >
> > > I'm still confused after reading the code about why this issue can
> > > still happen with a efi_mem_reserve.
> > > Usama, Breno, could any of you share the exact steps on how to
> > > reproduce this issue with a kvm guest?
> > >
> >
> > The code does not use efi_mem_reserve() only memblock_reserve().
>
> Yes, I see this, I just thought that Usama tested with changes to
> efi_mem_reserve and it still did not work, this is what I'm confused
> about.
>
> But maybe Usama did not test and only checked the code and assumed
> that we have to update the e820_table_kexec and e820_table_firmware.
> See my reply inline above.

Please ignore the above comment.   The userspace code does need the
e820_table_firmware.
So the best way to make it easier is to clean up the e820 tables and
maintain only one table then the kernel kexec_file_load behavior will
be the same as the userspace.   But need a closer look about the
details, eg. if the hibernate (mentioned in code comment) is happy.

Or to change userspace to go through the /proc/iomem instead of
checking the /sys/firmware/memmap

>
> Thanks
> Dave
> >



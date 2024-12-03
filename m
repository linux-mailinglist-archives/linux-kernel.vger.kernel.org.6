Return-Path: <linux-kernel+bounces-429581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBAA9E1FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26CC9B63295
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A81E1C3F;
	Tue,  3 Dec 2024 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVO5qO8a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA61E522
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233655; cv=none; b=boZQGsw6/t7/GHtia90CIJzJK13H8cFADrPoqah+0FAyhGD8FsGgvpdzOaOnUBc3fcJ5uUnsKNvZqpwP5e2zrMKTnbdIUtgvs6TTbu3uaJtn8TU0YY9SotVjqKMOTHaxnuM+4FAY8ENHu/gqC/a8OU8THr55R6MQ7FyxRdgn0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233655; c=relaxed/simple;
	bh=rW9anMd/h4WvBtrCWB5sEHm8Mq2O096NZSmZC+9OaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thXlFTnpMuiI6smZuWPf4Y5Uz2Rn5kjQ4J0SgRR64JNsMG2tpbLrz+xMhVswz3BaBdlR/K1s7t+iKT0vIV0eDjXE5YDCC77UD2bWEkqV2uidL1v8ZDtgVQZH04hUyrrsm3ruUsFWnx/+aMr7rGGkLTFJoPFO8TfKSkaBH9QvnWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVO5qO8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A521C4CECF;
	Tue,  3 Dec 2024 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233655;
	bh=rW9anMd/h4WvBtrCWB5sEHm8Mq2O096NZSmZC+9OaTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVO5qO8a73vCXephEEvwTAVksGbv1y8BwyPkMUqV45slSJ88DMW61/sMXAwlmu2Fw
	 NuHGrfwppCzdP3+xXP/ojNtuAclWqCbRCymd8HjhejSufzr5W5s2o+/vJxwUxnKuu5
	 gHKgY0U1tMRXSdlSGO753HeCqF8DW6TxWNru8pOOxM4O1ecPmh5IkDk6SXvANn7VOk
	 Uav9EfiVhyUvpIFlJHLeuwpL5uaNnusKK981C6Z8Wh68Mj0aPMbFW1KBEtpIfsoMHg
	 kDGQRgtvOJ1QOfdAgM5CrVaTwEkJMYRI23YLZosvADF6XTBpLzJO9cBlA4IxRTGkei
	 FadMNoc0RYyMg==
Date: Tue, 3 Dec 2024 14:47:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241203144730.47b8ca86@foz.lan>
In-Reply-To: <20241203125143.7171892a@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
	<20241203125143.7171892a@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 3 Dec 2024 12:51:43 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 22 Nov 2024 10:11:30 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Currently, CPER address location is calculated as an offset of
> > the hardware_errors table. It is also badly named, as the
> > offset actually used is the address where the CPER data starts,
> > and not the beginning of the error source.
> > 
> > Move the logic which calculates such offset to a separate
> > function, in preparation for a patch that will be changing the
> > logic to calculate it from the HEST table.
> > 
> > While here, properly name the variable which stores the cper
> > address.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/acpi/ghes.c | 41 ++++++++++++++++++++++++++++++++---------
> >  1 file changed, 32 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 87fd3feedd2a..d99697b20164 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >      ags->present = true;
> >  }
> >  
> > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > +                                 uint64_t *cper_addr,
> > +                                 uint64_t *read_ack_register_addr)
> > +{  
> 
> 
> > +    if (!ghes_addr) {
> > +        return;
> > +    }  
> 
> why do we need this check?

It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
callback doesn't fill it properly, this will be zero.

> > +
> > +    /*
> > +     * non-HEST version supports only one source, so no need to change
> > +     * the start offset based on the source ID. Also, we can't validate
> > +     * the source ID, as it is stored inside the HEST table.
> > +     */
> > +
> > +    cpu_physical_memory_read(ghes_addr, cper_addr,
> > +                             sizeof(*cper_addr));
> > +
> > +    *cper_addr = le64_to_cpu(*cper_addr);  
>         1st bits flip, and then see later
> 
> > +
> > +    /*
> > +     * As the current version supports only one source, the ack offset is
> > +     * just sizeof(uint64_t).
> > +     */
> > +    *read_ack_register_addr = ghes_addr +
> > +			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> > +}
> > +
> >  void ghes_record_cper_errors(const void *cper, size_t len,
> >                               uint16_t source_id, Error **errp)
> >  {
> > -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;  
> 
> if get_hw_error_offsets() isn't supposed to fail, then we do not need to initialize
> above. So this hunk doesn't belong to this patch.

It may fail due to:

    if (!ghes_addr) {
        return;
    }

> 
> >      uint64_t start_addr;
> >      AcpiGedState *acpi_ged_state;
> >      AcpiGhesState *ags;
> > @@ -389,18 +416,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> >  
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> > -    cpu_physical_memory_read(start_addr, &error_block_addr,
> > -                             sizeof(error_block_addr));
> > +    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
> >  
> > -    error_block_addr = le64_to_cpu(error_block_addr);
> > -    if (!error_block_addr) {
> > +    cper_addr = le64_to_cpu(cper_addr);  
>                    ^^^^ 2nd bits flip turning it back to guest byte order again
> 
> suggest to keep only one of them in get_hw_error_offsets()

Ok, I'll drop this one.

> > +    if (!cper_addr) {
> >          error_setg(errp, "can not find Generic Error Status Block");
> >          return;
> >      }
> >  
> > -    read_ack_register_addr = start_addr +
> > -                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> > -
> >      cpu_physical_memory_read(read_ack_register_addr,
> >                               &read_ack_register, sizeof(read_ack_register));
> >  
> > @@ -421,7 +444,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> >          &read_ack_register, sizeof(uint64_t));
> >  
> >      /* Write the generic error data entry into guest memory */
> > -    cpu_physical_memory_write(error_block_addr, cper, len);
> > +    cpu_physical_memory_write(cper_addr, cper, len);
> >  
> >      return;
> >  }  
> 

Thanks,
Mauro


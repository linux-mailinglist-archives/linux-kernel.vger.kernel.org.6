Return-Path: <linux-kernel+bounces-417935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3DC9D5B00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C44128317E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FC176233;
	Fri, 22 Nov 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4b68gjf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F537230999
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263901; cv=none; b=nz/deIb3VCo+NYfYiyttVonGJX6rPD6CzUcx6n4d6vgZ90DNBKffgRspArDUO2obeWwJNM1AdseaQtX8Xr7pUb1f45Rv0BLalwb0hVGn1qpBRtMYRlqk5DxUcMvwCGU233FhgxC4kyHSYx3jMeQrM5u5oexDL9lfhI/CfkFqqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263901; c=relaxed/simple;
	bh=82IqythBJBaMRewCz8uu1EinmQlUf337AmmiKnmg5dM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKdo1bDhu+ewUvU3ep9d/l1DV4k/3fADfPVW93HZ36homoJBx5mDHC5KX3RU8AdWu7hEtxVvfu9g4jDsXJgKwfT0FrbB7+iP56sv+B0zLjVZ0sCjUaKxdWSARogkLhnFWg349xT3Joxb6MOw8nrDc24BoDJWPAKM+6PpSadeb9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4b68gjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA0EC4CECE;
	Fri, 22 Nov 2024 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732263900;
	bh=82IqythBJBaMRewCz8uu1EinmQlUf337AmmiKnmg5dM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p4b68gjfp3GfkyCiomz72kMFMhKhM4Abm53VM+JhoW+TWgiSH9ggd7O5jeg8Ah/2u
	 Aegw0QHOWbhFsmHURlsDB6jcre9xLlyCDHhyxb3aVlNLnEbAjSWnY61lYCJGkDoIhC
	 FrJLVgDW6k2WwOqxWbMM83+GzeukwrSI6pOcGI29pStY22VEzQ4A+4iQPYQTCfR5Ol
	 dEIyDiyU5Q1EB8KRuugXcji81YATsEdmWVkz+uNtQwwQrYYqZaiMR6qoVWsIVRmJhe
	 ymb4sfwl6R9kLhihnJRrNNh/N1qlOja0VLp3pcUNVjkJr+Q5AiArlbj9QKvyzt9XlN
	 mU5+aKZZccOew==
Date: Fri, 22 Nov 2024 09:24:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 08/15] acpi/ghes: make the GHES record generation
 more generic
Message-ID: <20241122092455.5e2584a4@foz.lan>
In-Reply-To: <20241120141838.000070c1@huawei.com>
References: <cover.1731406254.git.mchehab+huawei@kernel.org>
	<8227e881bec84f27861f04c7af62667eef2708e7.1731406254.git.mchehab+huawei@kernel.org>
	<20241120141838.000070c1@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 20 Nov 2024 14:18:38 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Tue, 12 Nov 2024 11:14:52 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Split the code into separate functions to allow using the
> > common CPER filling code by different error sources.
> > 
> > The generic code was moved to ghes_record_cper_errors(),
> > and ghes_gen_err_data_uncorrectable_recoverable() now contains
> > only a logic to fill GEGB part of the record.  
> GESB?

This name came from this part of the code at hw/acpi/ghes.c:

	/*
	 * Total size for Generic Error Status Block except Generic Error Data Entries
	 * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
	 * Table 18-380 Generic Error Status Block
	 */
	#define ACPI_GHES_GESB_SIZE                 20

I replaced it to:

	The generic code was moved to ghes_record_cper_errors(),
	and ghes_gen_err_data_uncorrectable_recoverable() now contains
	only a logic to fill the Generic Error Data part of the record,
	as described at:                            

	        ACPI 6.2: 18.3.2.7.1 Generic Error Data

to make it clearer.

> > 
> > The remaining code to generate a memory error now belongs to
> > acpi_ghes_record_errors() function.
> > 
> > A further patch will give it a better name.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Hi Mauro,
> 
> I've kind of forgotten how all this works. Anyhow, looking afresh
> I think there is a functional change in her which I wasn't expecting
> to see.
> 
> > ---
> >  hw/acpi/ghes.c         | 122 +++++++++++++++++++++++------------------
> >  include/hw/acpi/ghes.h |   3 +
> >  2 files changed, 73 insertions(+), 52 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index edc74c38bf8a..0eb874a11ff7 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -181,51 +181,30 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
> >      build_append_int_noprefix(table, 0, 7);
> >  }
> >  
> > -static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> > -                                      uint64_t error_physical_addr)
> > +static void
> > +ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
> > +                                            const uint8_t *section_type,
> > +                                            int data_length)
> >  {
> > -    GArray *block;
> > -
> > -    /* Memory Error Section Type */
> > -    const uint8_t uefi_cper_mem_sec[] =
> > -          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> > -                  0xED, 0x7C, 0x83, 0xB1);
> > -
> >      /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
> >       * Table 17-13 Generic Error Data Entry
> >       */
> >      QemuUUID fru_id = {};
> > -    uint32_t data_length;
> >  
> > -    block = g_array_new(false, true /* clear */, 1);
> > -
> > -    /* This is the length if adding a new generic error data entry*/
> > -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> >      /*
> > -     * It should not run out of the preallocated memory if adding a new generic
> > -     * error data entry
> > +     * Calculate the size with this block. No need to check for
> > +     * too big CPER, as CPER size is checked at ghes_record_cper_errors()
> >       */
> > -    assert((data_length + ACPI_GHES_GESB_SIZE) <=
> > -            ACPI_GHES_MAX_RAW_DATA_LENGTH);
> > +    data_length += ACPI_GHES_GESB_SIZE;  
> 
> After this change the data length passe dto acpi_ghes_generic_error_status is
> ACPI_GHES_MAX_RAW_DATA_LENGTH + ACPI_GHES_GESB_SIZE;
> I can't see why that would be the same as previous value of
>  ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH
> 
> So is this a functional change?  If so please call it out in the patch
> description with some info on why it doesn't matter.

Good point.

My understanding from the specs is that the generic error data part
is meant to contain the size of the entire space, and not only the
payload part.

Such change used to make more sense on some previous versions of the 
series, where ghes_gen_err_data_uncorrectable_recoverable() was called
by error injection. However, now the only place where this is used is
inside the code to return QEMU memory errors via SEA.

So, I removed the functional change from the series I'm currently
submitting, as it doesn't belong here. It could be relevant only when
we decide to implement other internal errors on QEMU that would reuse
ghes_gen_err_data_uncorrectable_recoverable() function.

So, I'll keep on my pile of QEMU patches, at the end, to be submitted
if/when we need it.

> >  
> >      /* Build the new generic error status block header */
> >      acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> >          0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> >  
> >      /* Build this new generic error data entry header */
> > -    acpi_ghes_generic_error_data(block, uefi_cper_mem_sec,
> > +    acpi_ghes_generic_error_data(block, section_type,
> >          ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> >          ACPI_GHES_MEM_CPER_LENGTH, fru_id, 0);
> > -
> > -    /* Build the memory section CPER for above new generic error data entry */
> > -    acpi_ghes_build_append_mem_cper(block, error_physical_addr);
> > -
> > -    /* Write the generic error data entry into guest memory */
> > -    cpu_physical_memory_write(error_block_address, block->data, block->len);
> > -
> > -    g_array_free(block, true);
> > -
> > -    return 0;
> >  }
> >  
> >  /*
> > @@ -383,15 +362,18 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >      ags->present = true;
> >  }
> >  
> > -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +void ghes_record_cper_errors(const void *cper, size_t len,
> > +                             uint16_t source_id, Error **errp)
> >  {
> >      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> >      uint64_t start_addr;
> > -    bool ret = -1;
> >      AcpiGedState *acpi_ged_state;
> >      AcpiGhesState *ags;
> >  
> > -    assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
> > +    if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> > +        error_setg(errp, "GHES CPER record is too big: %ld", len);
> > +        return;
> > +    }
> >  
> >      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> >                                                         NULL));
> > @@ -400,16 +382,16 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> >  
> >      start_addr = le64_to_cpu(ags->ghes_addr_le);
> >  
> > -    if (!physical_address) {
> > -        return -1;
> > -    }
> > -
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> >      cpu_physical_memory_read(start_addr, &error_block_addr,
> >                               sizeof(error_block_addr));
> >  
> >      error_block_addr = le64_to_cpu(error_block_addr);
> > +    if (!error_block_addr) {
> > +        error_setg(errp, "can not find Generic Error Status Block");
> > +        return;
> > +    }
> >  
> >      read_ack_register_addr = start_addr +
> >                               ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> > @@ -419,24 +401,60 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> >  
> >      /* zero means OSPM does not acknowledge the error */
> >      if (!read_ack_register) {
> > -        error_report("OSPM does not acknowledge previous error,"
> > -                     " so can not record CPER for current error anymore");
> > -    } else if (error_block_addr) {
> > -        read_ack_register = cpu_to_le64(0);
> > -        /*
> > -         * Clear the Read Ack Register, OSPM will write it to 1 when
> > -         * it acknowledges this error.
> > -         */
> > -        cpu_physical_memory_write(read_ack_register_addr,
> > -                                  &read_ack_register, sizeof(uint64_t));
> > -
> > -        ret = acpi_ghes_record_mem_error(error_block_addr,
> > -                                         physical_address);
> > -    } else {
> > -        error_report("can not find Generic Error Status Block");
> > +        error_setg(errp,
> > +                   "OSPM does not acknowledge previous error,"
> > +                   " so can not record CPER for current error anymore");
> > +        return;
> >      }
> >  
> > -    return ret;
> > +    read_ack_register = cpu_to_le64(0);
> > +    /*
> > +     * Clear the Read Ack Register, OSPM will write it to 1 when
> > +     * it acknowledges this error.
> > +     */
> > +    cpu_physical_memory_write(read_ack_register_addr,
> > +        &read_ack_register, sizeof(uint64_t));  
> Alignment of this could be more consistent with rest of the code around it.
> So perhaps align after (
> 
> > +
> > +    /* Write the generic error data entry into guest memory */
> > +    cpu_physical_memory_write(error_block_addr, cper, len);
> > +
> > +    return;
> > +}
> > +
> > +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +{
> > +    /* Memory Error Section Type */
> > +    const uint8_t guid[] =
> > +          UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
> > +                  0xED, 0x7C, 0x83, 0xB1);
> > +    Error *errp = NULL;
> > +    GArray *block;
> > +
> > +    if (!physical_address) {
> > +        error_report("can not find Generic Error Status Block for source id %d",
> > +                     source_id);
> > +        return -1;
> > +    }
> > +
> > +    block = g_array_new(false, true /* clear */, 1);
> > +
> > +    ghes_gen_err_data_uncorrectable_recoverable(block, guid,
> > +                                                ACPI_GHES_MAX_RAW_DATA_LENGTH);
> > +
> > +    /* Build the memory section CPER for above new generic error data entry */
> > +    acpi_ghes_build_append_mem_cper(block, physical_address);
> > +
> > +    /* Report the error */
> > +    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
> > +
> > +    g_array_free(block, true);
> > +
> > +    if (errp) {
> > +        error_report_err(errp);
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> >  }
> >  
> >  bool acpi_ghes_present(void)
> > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > index 9295e46be25e..8859346af51a 100644
> > --- a/include/hw/acpi/ghes.h
> > +++ b/include/hw/acpi/ghes.h
> > @@ -23,6 +23,7 @@
> >  #define ACPI_GHES_H
> >  
> >  #include "hw/acpi/bios-linker-loader.h"
> > +#include "qapi/error.h"
> >  
> >  /*
> >   * Values for Hardware Error Notification Type field
> > @@ -73,6 +74,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> >                       const char *oem_id, const char *oem_table_id);
> >  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
> >                            GArray *hardware_errors);
> > +void ghes_record_cper_errors(const void *cper, size_t len,
> > +                             uint16_t source_id, Error **errp);
> >  int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
> >  
> >  /**  
> 



Thanks,
Mauro


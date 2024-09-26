Return-Path: <linux-kernel+bounces-340563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF7598754D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AEB2816CF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA22A374EA;
	Thu, 26 Sep 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKeYqO+c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF121114
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360360; cv=none; b=USoCV7KrEjf5ffCfFe5fb8eNmcDzCb3w0bLoAlh45lNMw7h0SzB1FReZG37lqzihC+X2HdpTbq9xC1lV0HfPOWvnowCfNDt3SE1u4NDI3zzgYUyisiWu8/lrbeIOJMQ4WS+w7MkoXwuIILwHYfX9eCov/KXJ68Vg3VeGsBTEEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360360; c=relaxed/simple;
	bh=2osnQDz0LxKw4i1NaGRSjr4kpgAji49Rc3tJuNnxvYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHJT+MFpMEt2/YFUAXQvnpdxl9V6nYOP31ag3nKqOScBAMgPms3iVwlxz1L5e75dBazTNj/EnJhqp3iATDpf06OR4GdfNoGqYmofU7NchH/0RY0dT6TZihjYxBet4CHWOniffdCL909U/0IC+YRiQP/6EbfVYGTCCszuAzETicw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKeYqO+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2FC4CEC5;
	Thu, 26 Sep 2024 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727360359;
	bh=2osnQDz0LxKw4i1NaGRSjr4kpgAji49Rc3tJuNnxvYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gKeYqO+ce9pS5qu95pV6p0ksXn7YVD3O0XkWGMqelZ+nWaWPlgLVilDOvqg1c/eKb
	 Jg56HVwWZTAEd059/HhfFHK0KFnOum4mw7U/WMmTkjW5VsDv7Wg68MH1veITUV9Hwv
	 Hq1aowIB30BgpssImhGG5kUUSfhzj7EjB/LAi9SJp77uQm3llZKCHw1Ong6MxIoFbk
	 b+TC6pNb/SvH8XUNsGVaeVbXnWwfAWY+WJGXamIrZsYUWAhs2qDODezHScIi1Fa82P
	 q9zhDlY2Yp2zRC4iZ4F64SO6S7wR/CiOZcL420KsGiOw7EOUGXuJl6Uj3uBZUq3O2/
	 PfHMRObjYVR4g==
Date: Thu, 26 Sep 2024 16:19:15 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 09/15] acpi/ghes: make the GHES record generation more
 generic
Message-ID: <20240926161726.3945f835@foz.lan>
In-Reply-To: <20240926130056.00001e12@Huawei.com>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<9b256923695e2202f549cbbb11dc22982cb22abf.1727236561.git.mchehab+huawei@kernel.org>
	<20240926130056.00001e12@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 26 Sep 2024 13:00:56 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 25 Sep 2024 06:04:14 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Split the code into separate functions to allow using the
> > common CPER filling code by different error sources.
> > 
> > The generic code was moved to ghes_record_cper_errors(),
> > and ghes_gen_err_data_uncorrectable_recoverable() now contains
> > only a logic to fill GEGB part of the record.
> > 
> > The remaining code to generate a memory error now belongs to
> > acpi_ghes_record_errors() function.
> > 
> > A further patch will give it a better name.  
> 
> That bit is fine, I'm less sure about
> ghes_gen_err_data_uncorrectable_recoverable()
> Maybe you refactor that later, but I'd suggest doing so in this
> patch to make it 
> ghes_gen_data() with the uncorrectable and recoverable bits
> passed in as parameters.

For now, no need. When using the error injection script, such
function is not used. The script can already play with what's
defined there.

Besides that, I tried to generalize it, but it is not trivial,
as passing some things as parameter is really hard. So, instead,
I opted to keep the code as-is. It can be changed later once we
add internal events that require a different setting than what
we have with ARMv8 memory errors via SEA.
> 
> Jonathan
> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c         | 118 +++++++++++++++++++++++++----------------
> >  include/hw/acpi/ghes.h |   3 ++
> >  2 files changed, 74 insertions(+), 47 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 340a0263faf8..307b5a41d539 100644
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
> 
> That's an ugly name .  Suggestion below on instead passing parameters
> for the uncorrectable and recoverable parts and amking this
> ghes_gen_err_data()
> 
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
> Maybe should just pass in ACPI_CPER_SEV_RECOVERABLE 
> and ACPI_GEBS_UNCORRECTABLE in parameters.
> 
> Main advantage being that should allow reuse for other combinations
> and it gets rid of the nasty function name!
> 
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
> > @@ -399,14 +378,19 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >      ags->present = true;
> >  }
> >  
> > -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> > +void ghes_record_cper_errors(const void *cper, size_t len,
> > +                             uint16_t source_id, Error **errp)
> >  {  
> 
> > -    return ret;
> > +    read_ack_register = cpu_to_le64(0);
> > +    /*
> > +        * Clear the Read Ack Register, OSPM will write it to 1 when
> > +        * it acknowledges this error.
> > +        */  
> 
> Indent issue.
> 
> > +    cpu_physical_memory_write(read_ack_register_addr,
> > +        &read_ack_register, sizeof(uint64_t));
> > +
> > +    /* Write the generic error data entry into guest memory */
> > +    cpu_physical_memory_write(error_block_addr, cper, len);
> > +
> > +    return;
> > +}  
> 



Thanks,
Mauro


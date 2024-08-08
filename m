Return-Path: <linux-kernel+bounces-279983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9091B94C426
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823F8B22322
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD113C814;
	Thu,  8 Aug 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfKeYEaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3DC8C0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141149; cv=none; b=S1/1Xm/FiAAqDmc3mvvsjeE/515YNTtqiixLBXcsfHg07FZqrQWl2c6NwYr+UuD+s3dedDzfnBJr9+RvnYne2AI7dKTzE8uIjK9QySiNOpcTxuasNlTYfDhyncJhouEKeh3XUcXcO4alZVvNKfv/FCUCir1Fi5VsKr06WvXFLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141149; c=relaxed/simple;
	bh=lNtv5zBgXCvx+K+5RYRjAeXGbTDns12ucj1yqMgqPeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPul96EfIwa7Q5Afki7A4z2RArKpPFfMZcLU0A05u7CNHAP9V2UFBpzxfyyd8YBZzS9O8oA4lAZpwzpAhVLnja8iZKCqbq8ICZN4wJK+wDIuLnJ/6oGmiaZ4BiH4WvDcopHQN8nGDAUNmDKQf/NbU4JUeRIS6vYU2iR7cDTKFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfKeYEaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E51BC32782;
	Thu,  8 Aug 2024 18:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723141148;
	bh=lNtv5zBgXCvx+K+5RYRjAeXGbTDns12ucj1yqMgqPeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TfKeYEaX1uiiBliJJdsFgDl8rhjC7angIR1yD0eu+3JQo5MAPVvTbJhslw0Fl+N2d
	 L/Hf2yLg2PUUw1i7MKYDDxVws8Dq5pZYjfwgWcZ0t/JdmdG+tMO6PlWu7ygDFSlsv8
	 Q+giDNG0cqsBsFNjqMafKe9Uivfl/jYddlwqgSmQwy+++HcOp+Jw/CngY+NT0C/kL+
	 jTQkJ4cmMWovGV5rJdhZoss+bB1SOGLNlOx9V03zhK5ne1vwh06hFY4zblPvke8HDq
	 tKTd0Dzpht+mzjx7ktA6WC0HI2FUrjqoXha9jSoSfl/EGM+IGJ6BtZtRkNry5ZTV6A
	 Y/K22nDvbmFpw==
Date: Thu, 8 Aug 2024 20:19:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240808201903.077093ca@foz.lan>
In-Reply-To: <20240808101107.105a124f@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240807152547.000058fd@Huawei.com>
	<20240808101107.105a124f@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 8 Aug 2024 10:11:07 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 7 Aug 2024 15:25:47 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Tue, 6 Aug 2024 16:31:13 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Fri,  2 Aug 2024 23:44:01 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Provide a generic interface for error injection via GHESv2.
> > > > 
> > > > This patch is co-authored:
> > > >     - original ghes logic to inject a simple ARM record by Shiju Jose;
> > > >     - generic logic to handle block addresses by Jonathan Cameron;
> > > >     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> > > > 
> > > > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > > > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: Shiju Jose <shiju.jose@huawei.com>
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> > > >  hw/acpi/ghes_cper.c    |   2 +-
> > > >  include/hw/acpi/ghes.h |   3 +
> > > >  3 files changed, 152 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > index a745dcc7be5e..e125c9475773 100644
> > > > --- a/hw/acpi/ghes.c
> > > > +++ b/hw/acpi/ghes.c
> > > > @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > > >      ags->present = true;
> > > >  }
> > > >  
> > > > +static uint64_t ghes_get_state_start_address(void)      
> > > 
> > > ghes_get_hardware_errors_address() might better reflect what address it will return
> > >     
> > > > +{
> > > > +    AcpiGedState *acpi_ged_state =
> > > > +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> > > > +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> > > > +
> > > > +    return le64_to_cpu(ags->ghes_addr_le);
> > > > +}
> > > > +
> > > >  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > > >  {
> > > >      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > > > -    uint64_t start_addr;
> > > > +    uint64_t start_addr = ghes_get_state_start_address();
> > > >      bool ret = -1;
> > > > -    AcpiGedState *acpi_ged_state;
> > > > -    AcpiGhesState *ags;
> > > > -
> > > >      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> > > >  
> > > > -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > > > -                                                       NULL));
> > > > -    g_assert(acpi_ged_state);
> > > > -    ags = &acpi_ged_state->ghes_state;
> > > > -
> > > > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > > > -
> > > >      if (physical_address) {
> > > >          start_addr += source_id * sizeof(uint64_t);      
> > > 
> > > above should be a separate patch
> > >     
> > > >  
> > > > @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > > >      return ret;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Error register block data layout
> > > > + *
> > > > + * | +---------------------+ ges.ghes_addr_le
> > > > + * | |error_block_address0 |
> > > > + * | +---------------------+
> > > > + * | |error_block_address1 |
> > > > + * | +---------------------+ --+--
> > > > + * | |    .............    | GHES_ADDRESS_SIZE
> > > > + * | +---------------------+ --+--
> > > > + * | |error_block_addressN |
> > > > + * | +---------------------+
> > > > + * | | read_ack0           |
> > > > + * | +---------------------+ --+--
> > > > + * | | read_ack1           | GHES_ADDRESS_SIZE
> > > > + * | +---------------------+ --+--
> > > > + * | |   .............     |
> > > > + * | +---------------------+
> > > > + * | | read_ackN           |
> > > > + * | +---------------------+ --+--
> > > > + * | |      CPER           |   |
> > > > + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> > > > + * | |      CPER           |   |
> > > > + * | +---------------------+ --+--
> > > > + * | |    ..........       |
> > > > + * | +---------------------+
> > > > + * | |      CPER           |
> > > > + * | |      ....           |
> > > > + * | |      CPER           |
> > > > + * | +---------------------+
> > > > + */      
> > > 
> > > no need to duplicate docs/specs/acpi_hest_ghes.rst,
> > > I'd just reffer to it and maybe add short comment as to why it's mentioned.
> > >     
> > > > +/* Map from uint32_t notify to entry offset in GHES */
> > > > +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> > > > +                                                 0xff, 0xff, 0xff, 1, 0};
> > > > +
> > > > +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> > > > +                          uint64_t *read_ack_addr)
> > > > +{
> > > > +    uint64_t base;
> > > > +
> > > > +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> > > > +        return false;
> > > > +    }
> > > > +
> > > > +    /* Find and check the source id for this new CPER */
> > > > +    if (error_source_to_index[notify] == 0xff) {
> > > > +        return false;
> > > > +    }
> > > > +
> > > > +    base = ghes_get_state_start_address();
> > > > +
> > > > +    *read_ack_addr = base +
> > > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > > +        error_source_to_index[notify] * sizeof(uint64_t);
> > > > +
> > > > +    /* Could also be read back from the error_block_address register */
> > > > +    *error_block_addr = base +
> > > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > > > +
> > > > +    return true;
> > > > +}      
> > > 
> > > I don't like all this pointer math, which is basically a reverse engineered
> > > QEMU actions on startup + guest provided etc/hardware_errors address.
> > > 
> > > For once, it assumes error_source_to_index[] matches order in which HEST
> > > error sources were described, which is fragile.
> > > 
> > > 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> > > in RAM migrated from older version might not match above assumptions
> > > of target QEMU. 
> > > 
> > > I see 2 ways to rectify it:
> > >   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
> > >        in guest RAM, like we do with etc/hardware_errors, see
> > >             build_ghes_error_table()
> > >                ...
> > >                tell firmware to write hardware_errors GPA into
> > >        and then fetch from HEST table in RAM, the guest patched error/ack addresses
> > >        for given source_id
> > > 
> > >        code-wise: relatively simple once one wraps their own head over
> > >                  how this whole APEI thing works in QEMU
> > >                  workflow  is described in docs/specs/acpi_hest_ghes.rst
> > >                  look to me as sufficient to grasp it.
> > >                  (but my view is very biased given my prior knowledge,
> > >                   aka: docs/comments/examples wrt acpi patching are good enough)
> > >                  (if it's not clear how to do it, ask me for pointers)    
> > 
> > Hi Igor, I think I follow what you mean but maybe this question will reveal
> > otherwise.  HEST is currently in ACPI_BUILD_TABLE_FILE.
> > Would you suggest splitting it to it's own file, or using table_offsets
> > to get the offset in ACPI_BUILD_TABLE_FILE GPA?  
> yep, offset taken right before HEST is to be created
> doc comment for bios_linker_loader_write_pointer() explains how it works
> 
> we need something like:
>        bios_linker_loader_write_pointer(linker,
>            ACPI_HEST_TABLE_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
>            ACPI_BUILD_TABLE_FILE, hest_offset_within_ACPI_BUILD_TABLE_FILE); 
> 
> to register new file see:
>    a08a64627 ACPI: Record the Generic Error Status Block address
>    and to avoid copy past error maybe
>    136fc6aa2 ACPI: Avoid infinite recursion when dump-vmstat
> for this needs to be limited to new machine types and keep
> old ones without this new feature. (I'd use hw_compat_ machinery for that)

Not sure if I got it. The code, after this patch from my v6:

	https://lore.kernel.org/qemu-devel/5710c364d7ef6cdab6b2f1e127ef191bdf84e8c2.1723119423.git.mchehab+huawei@kernel.org/T/#u

Already stores two of the three address offsets via 
bios_linker_loader_add_pointer(), e. g. it is similar to the
code below (I simplified the code to make the example clearer):

<snip>
/* From hw/arm/virt-acpi-build.c */
static
void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
{
    ...
    if (vms->ras) {
        build_ghes_error_table(tables->hardware_errors, tables->linker);
        acpi_add_table(table_offsets, tables_blob);
	/* internally, call build_ghes_v2() for SEA and GED notification sources */
        acpi_build_hest(tables_blob, tables->linker, vms->oem_id,
                        vms->oem_table_id);
    }
    ...
}

/* From hw/acpi/ghes.c */
static void build_ghes_v2(GArray *table_data,
                          enum AcpiGhesNotifyType notify,
                          BIOSLinker *linker)
{
    uint64_t address_offset, ack_offset, block_addr_offset, cper_offset;
    enum AcpiHestSourceId source_id;

    /* 
     * Get offsets for either SEA or GED notification - easy to extend
     * to all mechanisms like MCE and SCI to better support x86
     */
    assert(!acpi_hest_address_offset(notify, &block_addr_offset, &ack_offset,
                                     &cper_offset, &source_id));

    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                   address_offset + GAS_ADDR_OFFSET,
                                   sizeof(uint64_t),
                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
                                   block_addr_offset);

    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
                                   address_offset + GAS_ADDR_OFFSET,
                                   sizeof(uint64_t),
                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
                                   ack_offset);

    /* Current code ignores &cper_offset when creating HEST */
}

void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
                             enum AcpiGhesNotifyType notify)
{
    uint64_t cper_addr, read_ack_start_addr;

    assert(!ghes_get_hardware_errors_address(notify, NULL, &read_ack_start_addr,
                                         &cper_addr, NULL));

    /*
     * Use cpu_physical_memory_read/write() to
     *  - read/store at read_ack_start_addr 
     *  - Write cper block GArray at cper_addr
     */
}
</snip>

We may also store cper_offset there via bios_linker_loader_add_pointer()
and/or use bios_linker_loader_write_pointer(), but I can't see how the
data stored there can be retrieved, nor any advantage of using it instead
of the current code, as, in the end, we'll have 3 addresses that will be
used:

	- an address where a pointer to CPER record will be stored;
	- an address where the ack will be stored;
	- an address where the actual CPER record will be stored.

And those are calculated on a single function and are all stored at the
ACPI table files.

What am I missing?

Thanks,
Mauro


Return-Path: <linux-kernel+bounces-300216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E36D595E0B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644AE1F219E9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 02:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93134A3E;
	Sun, 25 Aug 2024 02:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btZbrGjn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5212F46
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724551375; cv=none; b=Du72+pWdH3rtuBPhMr+uVtbXODqf5vLpur7QRnEFTxFEYw66PHDGgn5TGKlfWXoHSyQyVQgCCFZDfzyFiLnKx8NUErzRojJDNFahivkNQ1jyJxwUnyVv1Vp9Si3uOdcXM1pOGL4VyO4EwlXtwOZusshAXuR+GuHGN7rSN+DsCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724551375; c=relaxed/simple;
	bh=oCdD5yhklSdnjR1i8uy81a7tmhqcol8uf1A6ZXWgaqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmhtbYIB2DodYulvzthRYdYdZKD2VZYaIupt6Mit0wT4/ac9sQbDFKa3u3gudGV3B/rRAIwH6zQCM1K3yJa++ljv67xb9UWhwSAa+8NJngODIxjTzoN2m5f7NRtx5dz3lzgSZGILVffXFulmPQwq4MowqPM0Zv/xUrotKSe/860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btZbrGjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06471C32781;
	Sun, 25 Aug 2024 02:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724551375;
	bh=oCdD5yhklSdnjR1i8uy81a7tmhqcol8uf1A6ZXWgaqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=btZbrGjnJ5HXN0QqkADK26nGId1WjKStUUev23kD30wxtqIsVxIPsF09YR/HyUQWi
	 T66//i44rAzE+s8kFyHbb/cVx4WAGqkxIlvNPKjQj7ci73pdqlIHrjIux7IgDfTRxd
	 p3vVH76LTU9eCRfo/fmCOz9Loap0qDl73UpqyUhsG1mV3tDJRMey1qGFGFHwYsk0Wb
	 6myjyzoQgqRq4ivpxX+ZO9cOifW8wbWqBma8H9IKfz5lEq8dZoDlZTZfo3gb3TeK8v
	 at3taIKlnxCXpB/2eoQ4mcrYeX7rFe4lveu6clLr/wAJ5Gj/yjn6v7Yc1QqqjwFx5u
	 l/dj6IY1L+/WA==
Date: Sun, 25 Aug 2024 04:02:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 05/13] acpi/ghes: rework the logic to handle HEST
 source ID
Message-ID: <20240825040230.3531a91c@sal.lan>
In-Reply-To: <20240819141037.12929696@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<97fc9d96b52a13f07a481d8b9fe0a92f4f550faf.1723793768.git.mchehab+huawei@kernel.org>
	<20240819141037.12929696@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 19 Aug 2024 14:10:37 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 16 Aug 2024 09:37:37 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The current logic is based on a lot of duct tape, with
> > offsets calculated based on one define with the number of
> > source IDs and an enum.
> > 
> > Rewrite the logic in a way that it would be more resilient
> > of code changes, by moving the source ID count to an enum
> > and make the offset calculus more explicit.
> > 
> > Such change was inspired on a patch from Jonathan Cameron
> > splitting the logic to get the CPER address on a separate
> > function, as this will be needed to support generic error
> > injection.  
> 
> patch does too many things, that it's hard to review.
> Please split it up on smaller distinct parts, with more specific
> commit messages. (see some comments below)

True, but there's not much that can be done when doing it and still
keeping the code working. I'll split the renames.

> 
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes-stub.c      |   3 +-
> >  hw/acpi/ghes.c           | 210 ++++++++++++++++++++++++---------------
> >  hw/arm/virt-acpi-build.c |   5 +-
> >  include/hw/acpi/ghes.h   |  17 ++--
> >  4 files changed, 138 insertions(+), 97 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> > index c315de1802d6..8762449870b5 100644
> > --- a/hw/acpi/ghes-stub.c
> > +++ b/hw/acpi/ghes-stub.c
> > @@ -11,7 +11,8 @@
> >  #include "qemu/osdep.h"
> >  #include "hw/acpi/ghes.h"
> >  
> > -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > +int acpi_ghes_record_errors(enum AcpiGhesNotifyType notify,
> > +                            uint64_t physical_address)
> >  {
> >      return -1;
> >  }
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index df59fd35568c..7870f51e2a9e 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -28,14 +28,23 @@
> >  #include "hw/nvram/fw_cfg.h"
> >  #include "qemu/uuid.h"
> >  
> > -#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
> > -#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> > +#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> > +#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"  
> split out renaming part into a presiding separate patch,
> so it won't mask a new code
> 
> > +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
> >  
> >  /* The max size in bytes for one error block */
> >  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> >    
> 
> 
> > -/* Support ARMv8 SEA notification type error source and GPIO interrupt. */
> > -#define ACPI_GHES_ERROR_SOURCE_COUNT        2
> > +/*
> > + * ID numbers used to fill HEST source ID field
> > + */
> > +enum AcpiHestSourceId {
> > +    ACPI_HEST_SRC_ID_SEA,
> > +    ACPI_HEST_SRC_ID_GED,
> > +
> > +    /* Shall be the last one */
> > +    ACPI_HEST_SRC_ID_COUNT
> > +} AcpiHestSourceId;
> >    
> this rename also should go into its own separate patch.

I opted to remove this completely and move it to arm/virt, as this specific
set of sources is for ARM.

On such split, I ended placing the QMP error injection as the first one,
as this is probably the first one that we'll be mapping on x86 and
other architectures.

This way, the code at ghes.c won't rely on any hardcoded values. They'll
be passed at target ACPI table preparation using this function:

    void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
                         BIOSLinker *linker,
                         const uint16_t * const notify,
                         int num_sources,
                         const char *oem_id, const char *oem_table_id)

On arm (at the rework patch, before adding GPIO method), the call
to the HEST build table (and etc/hardware_errors init) is done via:

    static const uint16_t hest_ghes_notify[] = {
        [ARM_ACPI_HEST_SRC_ID_SEA] = ACPI_GHES_NOTIFY_SEA,
    };

    void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
    {
	...
	if (vms->ras) {
        acpi_add_table(table_offsets, tables_blob);
        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
                        hest_ghes_notify, sizeof(hest_ghes_notify),
                        vms->oem_id, vms->oem_table_id);
        }
    ...

This way, adding support for a new notification type at the arch-specific code
is as easy as adding a new entry to hest_ghes_notify[].

> 
> >  /* Generic Hardware Error Source version 2 */
> >  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
> > @@ -63,6 +72,19 @@
> >   */
> >  #define ACPI_GHES_GESB_SIZE                 20
> >  
> > +/*
> > + * Offsets with regards to the start of the HEST table stored at
> > + * ags->hest_addr_le, according with the memory layout map at
> > + * docs/specs/acpi_hest_ghes.rst.
> > + */
> > +
> > +/* ACPI 4.0: 17.3.2 ACPI Error Source */
> > +#define ACPI_HEST_HEADER_SIZE    40
> > +
> > +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2 */
> > +#define HEST_GHES_V2_TABLE_SIZE  92
> > +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
> > +
> >  /*
> >   * Values for error_severity field
> >   */
> > @@ -236,17 +258,17 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
> >   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
> >   * See docs/specs/acpi_hest_ghes.rst for blobs format.
> >   */
> > -void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> > +static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> >  {
> >      int i, error_status_block_offset;
> >  
> >      /* Build error_block_address */
> > -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> > +    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
> >          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
> >      }
> >  
> >      /* Build read_ack_register */
> > -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> > +    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
> >          /*
> >           * Initialize the value of read_ack_register to 1, so GHES can be
> >           * writable after (re)boot.
> > @@ -261,20 +283,20 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> >  
> >      /* Reserve space for Error Status Data Block */
> >      acpi_data_push(hardware_errors,
> > -        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_GHES_ERROR_SOURCE_COUNT);
> > +        ACPI_GHES_MAX_RAW_DATA_LENGTH * ACPI_HEST_SRC_ID_COUNT);
> >  
> >      /* Tell guest firmware to place hardware_errors blob into RAM */
> > -    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
> > +    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
> >                               hardware_errors, sizeof(uint64_t), false);
> >  
> > -    for (i = 0; i < ACPI_GHES_ERROR_SOURCE_COUNT; i++) {
> > +    for (i = 0; i < ACPI_HEST_SRC_ID_COUNT; i++) {
> >          /*
> >           * Tell firmware to patch error_block_address entries to point to
> >           * corresponding "Generic Error Status Block"
> >           */
> >          bios_linker_loader_add_pointer(linker,
> > -            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
> > -            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> > +            ACPI_HW_ERROR_FW_CFG_FILE, sizeof(uint64_t) * i,
> > +            sizeof(uint64_t), ACPI_HW_ERROR_FW_CFG_FILE,
> >              error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
> >      }
> >  
> > @@ -282,16 +304,39 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> >       * tell firmware to write hardware_errors GPA into
> >       * hardware_errors_addr fw_cfg, once the former has been initialized.
> >       */
> > -    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
> > -        0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
> > +    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> > +                                     sizeof(uint64_t),
> > +                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
> > +}
> > +
> > +static bool ghes_notify_to_source_id(enum AcpiGhesNotifyType notify,
> > +                                     enum AcpiHestSourceId *source_id)
> > +{
> > +    switch (notify) {
> > +    case ACPI_GHES_NOTIFY_SEA:             /* ARMv8 */
> > +        *source_id = ACPI_HEST_SRC_ID_SEA;
> > +        return false;
> > +    case ACPI_GHES_NOTIFY_GPIO:
> > +        *source_id = ACPI_HEST_SRC_ID_GED;
> > +        return false;
> > +    default:
> > +        /* Unsupported notification types */
> > +        return true;
> > +    }
> >  }
> >  
> >  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> > -static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> > +static void build_ghes_v2(GArray *table_data,
> > +                          enum AcpiGhesNotifyType notify,
> > +                          BIOSLinker *linker)  
> 
> I'd suggest to drop this change as AcpiGhesNotifyType is not unique ID,
> in fact one can easily have several ID with the same type.

IMO, the best is to have different IDs for each type of notification on
a given guest type. The way I see, each supported notification type will
require a separate source ID, as different notification mechanisms will
use different ways to synchronize between QEMU, BIOS and OS.

So, with the new version I'll be sending, this will also use whatever table
with a notification/source_ID association is passed by target acpi init
code, so the way I'm designing it is that different archs may reuse the same
id numbers like:

    /* ARM acpi build logic - currently the only one implemented */
    static const uint16_t hest_ghes_notify[] = {
        [0] = ACPI_GHES_NOTIFY_GPIO,
        [1] = ACPI_GHES_NOTIFY_SEA,
    };

    /* x86 acpi build logic */
    static const uint16_t hest_ghes_notify[] = {
        [0] = ACPI_GHES_NOTIFY_SCI,
        [1] = ACPI_GHES_NOTIFY_MCE,
        [2] = ACPI_GHES_NOTIFY_NMI,
    };

    /* PPC acpi build logic */
    static const uint16_t hest_ghes_notify[] = {
        [0] = ACPI_GHES_NOTIFY_GPIO,
    }

   ...

Btw, I'm reserving 0 for QMP based event injection, as we don't know
in advance how much events each architecture will implement. So, basically
this will be added to ghes.h:

    /* Source ID associated with qapi/acpi-hest.json QMP error injection */
    #define ACPI_HEST_SRC_ID_QMP   0

And the actual binding on arm is done as:

    enum {
        ARM_ACPI_HEST_SRC_ID_GPIO = ACPI_HEST_SRC_ID_QMP,
        ARM_ACPI_HEST_SRC_ID_SEA,
    };

    static const uint16_t hest_ghes_notify[] = {
        [ARM_ACPI_HEST_SRC_ID_SEA] = ACPI_GHES_NOTIFY_SEA,
        [ARM_ACPI_HEST_SRC_ID_GPIO] = ACPI_GHES_NOTIFY_GPIO,
    };

Regards,
Mauro


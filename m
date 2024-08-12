Return-Path: <linux-kernel+bounces-282882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1233994EA04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFA3280D6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9578816DC1A;
	Mon, 12 Aug 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4ucGKjB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C2B16A954
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455549; cv=none; b=sIXzItnW1Yh+kF8ZWnJCF1SJZgsXTpg1A246XmRaoDNoWVGMqKIpxTuqUH+eGj0ieHa8b4GudU++xPWD5FU1wTaO89MCCvZj3TFZM/dBecZSTwzs1yT3PXHWly2mT3iDO+AivDpQUFsdnE3k3kl2NRld4qtN4R96f5XLbWWCDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455549; c=relaxed/simple;
	bh=MtoCqL/1mILJQAZtanBGmRmjVgxrxyQcE9CqwHl3mPI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnBOiAnkx8DChjTn4CSQTS2tJcsTmhLqM3ZBKD1rJOnZjoJX5VS4UBU7UrHGLoVQqOxtcSKQRzsx4j8/OzJGi6CHquu7nY5a2MYbYHv6ch3h3a/ZRTB3AxIJ+uTJnAYJ4VuwCUiX4LYX5JTnmTzXe6TgYSxH1uLF0TvTntqbuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4ucGKjB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723455545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NWGtZUJo6pEYJDKSLc4v/k6z5SFqu6cDFxa/E9GPvU=;
	b=E4ucGKjBy0vhrkf3j0PAYMtxKZztDt/Xeg0oHHtBJ0lVhTqNcz8GT1Tz63GuYVEYYWbQWU
	wezV+TUdjP8RgDVGmKkJrNxH41M1j9UhAlmZP5+uyWhQM0UwRJjFQhNi0/AbjNnX2Tntve
	gLJgfp5UN4Tp0UTF8L1i1RWAIsrvNz4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-HyDf5i1qMOSQYsYcKjyKhg-1; Mon, 12 Aug 2024 05:39:04 -0400
X-MC-Unique: HyDf5i1qMOSQYsYcKjyKhg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3685a5a765fso2507937f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723455543; x=1724060343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NWGtZUJo6pEYJDKSLc4v/k6z5SFqu6cDFxa/E9GPvU=;
        b=wDY713oN3dC+8+gxAJjB2nFu3ckUwUIDBpZo4nyM4/SylHEY9g5ehtmIYSQhIZmTiW
         P3oPIG4C9ItBMPPbLXTY43+DgLe7UXKCXtWxIcYxPQ0nChBiZgS1L4ZVDickceRITOBi
         LTirAH7UHgCyeZ+q8pJFsoomVOrS/OK60GABvUvc3auTSUa/sz1YtstlktmWLJyO9rWZ
         npQ3uqks8hdkt9RKG/bJueujj3IPFftAh1c4+KY11bApZhYajRYkZVZErmzw5i3tIPiA
         oeZIEY3gL3X280kA5LI2cKJr+v219qdx2UvJJkACW0qHqacnF5WUyVvqbhqY96fQ5IZ3
         0Qaw==
X-Forwarded-Encrypted: i=1; AJvYcCUGUJrILjBsr4i3Q2Z/Ho0hUe39oRctB3JRzBuUSNBi38NsT3PC/ht4bzaSy5doex1OGCPDf+Q16LD9MZYvtAmyhsz6shjydcLAqfJ6
X-Gm-Message-State: AOJu0Yy/3JWeKrE+jY6hQgdsGYlg6rwqKzId/i49Lc+vgdChqiYN4uhZ
	wWSxx2kpnFPEg4cymTNdmsgMr9fEYMgRDGXjobu87Qt9VzffX82UYCRFnYP2bfq1n8B+QGj+Bqg
	t8fs0ZtbsW2SkVPwM8GzoU7yKp+EAcBv+op4UIRbexrFeC9j6NUmxFLStzpYFqQ==
X-Received: by 2002:adf:f54f:0:b0:368:557a:c64d with SMTP id ffacd0b85a97d-36d5f2d103cmr5094109f8f.9.1723455543153;
        Mon, 12 Aug 2024 02:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsaF23DMlpT3zSDcW53NCpd3+wAHrQ/2AdjXm5/8WT4bEtzgvqOwoE6LQUbMPB85uNhIlIIg==
X-Received: by 2002:adf:f54f:0:b0:368:557a:c64d with SMTP id ffacd0b85a97d-36d5f2d103cmr5094094f8f.9.1723455542514;
        Mon, 12 Aug 2024 02:39:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36be6dsm7003011f8f.20.2024.08.12.02.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 02:39:02 -0700 (PDT)
Date: Mon, 12 Aug 2024 11:39:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240812113900.25078ccc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240808201903.077093ca@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240807152547.000058fd@Huawei.com>
	<20240808101107.105a124f@imammedo.users.ipa.redhat.com>
	<20240808201903.077093ca@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 20:19:03 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu, 8 Aug 2024 10:11:07 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Wed, 7 Aug 2024 15:25:47 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Tue, 6 Aug 2024 16:31:13 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >     
> > > > On Fri,  2 Aug 2024 23:44:01 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >       
> > > > > Provide a generic interface for error injection via GHESv2.
> > > > > 
> > > > > This patch is co-authored:
> > > > >     - original ghes logic to inject a simple ARM record by Shiju Jose;
> > > > >     - generic logic to handle block addresses by Jonathan Cameron;
> > > > >     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> > > > > 
> > > > > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > > > > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Cc: Shiju Jose <shiju.jose@huawei.com>
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > ---
> > > > >  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> > > > >  hw/acpi/ghes_cper.c    |   2 +-
> > > > >  include/hw/acpi/ghes.h |   3 +
> > > > >  3 files changed, 152 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > > index a745dcc7be5e..e125c9475773 100644
> > > > > --- a/hw/acpi/ghes.c
> > > > > +++ b/hw/acpi/ghes.c
> > > > > @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > > > >      ags->present = true;
> > > > >  }
> > > > >  
> > > > > +static uint64_t ghes_get_state_start_address(void)        
> > > > 
> > > > ghes_get_hardware_errors_address() might better reflect what address it will return
> > > >       
> > > > > +{
> > > > > +    AcpiGedState *acpi_ged_state =
> > > > > +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> > > > > +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> > > > > +
> > > > > +    return le64_to_cpu(ags->ghes_addr_le);
> > > > > +}
> > > > > +
> > > > >  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > > > >  {
> > > > >      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > > > > -    uint64_t start_addr;
> > > > > +    uint64_t start_addr = ghes_get_state_start_address();
> > > > >      bool ret = -1;
> > > > > -    AcpiGedState *acpi_ged_state;
> > > > > -    AcpiGhesState *ags;
> > > > > -
> > > > >      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> > > > >  
> > > > > -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > > > > -                                                       NULL));
> > > > > -    g_assert(acpi_ged_state);
> > > > > -    ags = &acpi_ged_state->ghes_state;
> > > > > -
> > > > > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > > > > -
> > > > >      if (physical_address) {
> > > > >          start_addr += source_id * sizeof(uint64_t);        
> > > > 
> > > > above should be a separate patch
> > > >       
> > > > >  
> > > > > @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > > > >      return ret;
> > > > >  }
> > > > >  
> > > > > +/*
> > > > > + * Error register block data layout
> > > > > + *
> > > > > + * | +---------------------+ ges.ghes_addr_le
> > > > > + * | |error_block_address0 |
> > > > > + * | +---------------------+
> > > > > + * | |error_block_address1 |
> > > > > + * | +---------------------+ --+--
> > > > > + * | |    .............    | GHES_ADDRESS_SIZE
> > > > > + * | +---------------------+ --+--
> > > > > + * | |error_block_addressN |
> > > > > + * | +---------------------+
> > > > > + * | | read_ack0           |
> > > > > + * | +---------------------+ --+--
> > > > > + * | | read_ack1           | GHES_ADDRESS_SIZE
> > > > > + * | +---------------------+ --+--
> > > > > + * | |   .............     |
> > > > > + * | +---------------------+
> > > > > + * | | read_ackN           |
> > > > > + * | +---------------------+ --+--
> > > > > + * | |      CPER           |   |
> > > > > + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> > > > > + * | |      CPER           |   |
> > > > > + * | +---------------------+ --+--
> > > > > + * | |    ..........       |
> > > > > + * | +---------------------+
> > > > > + * | |      CPER           |
> > > > > + * | |      ....           |
> > > > > + * | |      CPER           |
> > > > > + * | +---------------------+
> > > > > + */        
> > > > 
> > > > no need to duplicate docs/specs/acpi_hest_ghes.rst,
> > > > I'd just reffer to it and maybe add short comment as to why it's mentioned.
> > > >       
> > > > > +/* Map from uint32_t notify to entry offset in GHES */
> > > > > +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> > > > > +                                                 0xff, 0xff, 0xff, 1, 0};
> > > > > +
> > > > > +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> > > > > +                          uint64_t *read_ack_addr)
> > > > > +{
> > > > > +    uint64_t base;
> > > > > +
> > > > > +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    /* Find and check the source id for this new CPER */
> > > > > +    if (error_source_to_index[notify] == 0xff) {
> > > > > +        return false;
> > > > > +    }
> > > > > +
> > > > > +    base = ghes_get_state_start_address();
> > > > > +
> > > > > +    *read_ack_addr = base +
> > > > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > > > +        error_source_to_index[notify] * sizeof(uint64_t);
> > > > > +
> > > > > +    /* Could also be read back from the error_block_address register */
> > > > > +    *error_block_addr = base +
> > > > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > > > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > > > > +
> > > > > +    return true;
> > > > > +}        
> > > > 
> > > > I don't like all this pointer math, which is basically a reverse engineered
> > > > QEMU actions on startup + guest provided etc/hardware_errors address.
> > > > 
> > > > For once, it assumes error_source_to_index[] matches order in which HEST
> > > > error sources were described, which is fragile.
> > > > 
> > > > 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> > > > in RAM migrated from older version might not match above assumptions
> > > > of target QEMU. 
> > > > 
> > > > I see 2 ways to rectify it:
> > > >   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
> > > >        in guest RAM, like we do with etc/hardware_errors, see
> > > >             build_ghes_error_table()
> > > >                ...
> > > >                tell firmware to write hardware_errors GPA into
> > > >        and then fetch from HEST table in RAM, the guest patched error/ack addresses
> > > >        for given source_id
> > > > 
> > > >        code-wise: relatively simple once one wraps their own head over
> > > >                  how this whole APEI thing works in QEMU
> > > >                  workflow  is described in docs/specs/acpi_hest_ghes.rst
> > > >                  look to me as sufficient to grasp it.
> > > >                  (but my view is very biased given my prior knowledge,
> > > >                   aka: docs/comments/examples wrt acpi patching are good enough)
> > > >                  (if it's not clear how to do it, ask me for pointers)      
> > > 
> > > Hi Igor, I think I follow what you mean but maybe this question will reveal
> > > otherwise.  HEST is currently in ACPI_BUILD_TABLE_FILE.
> > > Would you suggest splitting it to it's own file, or using table_offsets
> > > to get the offset in ACPI_BUILD_TABLE_FILE GPA?    
> > yep, offset taken right before HEST is to be created
> > doc comment for bios_linker_loader_write_pointer() explains how it works
> > 
> > we need something like:
> >        bios_linker_loader_write_pointer(linker,
> >            ACPI_HEST_TABLE_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
> >            ACPI_BUILD_TABLE_FILE, hest_offset_within_ACPI_BUILD_TABLE_FILE); 
> > 
> > to register new file see:
> >    a08a64627 ACPI: Record the Generic Error Status Block address
> >    and to avoid copy past error maybe
> >    136fc6aa2 ACPI: Avoid infinite recursion when dump-vmstat
> > for this needs to be limited to new machine types and keep
> > old ones without this new feature. (I'd use hw_compat_ machinery for that)  
> 
> Not sure if I got it. The code, after this patch from my v6:
> 
> 	https://lore.kernel.org/qemu-devel/5710c364d7ef6cdab6b2f1e127ef191bdf84e8c2.1723119423.git.mchehab+huawei@kernel.org/T/#u
> 
> Already stores two of the three address offsets via 
> bios_linker_loader_add_pointer(), e. g. it is similar to the
> code below (I simplified the code to make the example clearer):
> 
> <snip>
> /* From hw/arm/virt-acpi-build.c */
> static
> void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> {
>     ...
>     if (vms->ras) {
>         build_ghes_error_table(tables->hardware_errors, tables->linker);
>         acpi_add_table(table_offsets, tables_blob);
> 	/* internally, call build_ghes_v2() for SEA and GED notification sources */
>         acpi_build_hest(tables_blob, tables->linker, vms->oem_id,
>                         vms->oem_table_id);
>     }
>     ...
> }
> 
> /* From hw/acpi/ghes.c */
> static void build_ghes_v2(GArray *table_data,
>                           enum AcpiGhesNotifyType notify,
>                           BIOSLinker *linker)
> {
>     uint64_t address_offset, ack_offset, block_addr_offset, cper_offset;
>     enum AcpiHestSourceId source_id;
> 
>     /* 
>      * Get offsets for either SEA or GED notification - easy to extend
>      * to all mechanisms like MCE and SCI to better support x86
>      */
>     assert(!acpi_hest_address_offset(notify, &block_addr_offset, &ack_offset,
>                                      &cper_offset, &source_id));
> 
>     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                    address_offset + GAS_ADDR_OFFSET,
>                                    sizeof(uint64_t),
>                                    ACPI_GHES_ERRORS_FW_CFG_FILE,
>                                    block_addr_offset);
> 
>     bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                    address_offset + GAS_ADDR_OFFSET,
>                                    sizeof(uint64_t),
>                                    ACPI_GHES_ERRORS_FW_CFG_FILE,
>                                    ack_offset);
> 
>     /* Current code ignores &cper_offset when creating HEST */
> }
> 
> void ghes_record_cper_errors(AcpiGhesCper *cper, Error **errp,
>                              enum AcpiGhesNotifyType notify)
> {
>     uint64_t cper_addr, read_ack_start_addr;
> 
>     assert(!ghes_get_hardware_errors_address(notify, NULL, &read_ack_start_addr,
>                                          &cper_addr, NULL));
> 
>     /*
>      * Use cpu_physical_memory_read/write() to
>      *  - read/store at read_ack_start_addr 
>      *  - Write cper block GArray at cper_addr
>      */
> }
> </snip>
> 
> We may also store cper_offset there via bios_linker_loader_add_pointer()
> and/or use bios_linker_loader_write_pointer(), but I can't see how the
> data stored there can be retrieved, nor any advantage of using it instead
> of the current code, as, in the end, we'll have 3 addresses that will be
> used:
> 
> 	- an address where a pointer to CPER record will be stored;
> 	- an address where the ack will be stored;
> 	- an address where the actual CPER record will be stored.
> 
> And those are calculated on a single function and are all stored at the
> ACPI table files.
>
> What am I missing?

That's basically (2) approach and it works to some degree,
unfortunately it's fragile when we start talking about migration
and changing layout in the future.

Lets take as example increasing size of 1) 'Generic Error Status Block',
we are considering. Old QEMU will, tell firmware to allocate 1K buffer
for it and calculated offsets to [1] (that you've stored/calculated) will
include this assumption.
Then in newer we QEMU increase size of [1] and all hardcoded offsets will
account for new size, but if we migrate guest from old QEMU to this newer
one all HEST tables layout within guest will match old QEMU assumptions,
and as result newer QEMU with larger block size will write CPERs at wrong
address considering we are still running guest from old QEMU.
That's just one example.

To make it work there a number of ways, but the ultimate goal is to pick
one that's the least fragile and won't snowball in maintenance nightmare
as number of GHES sources increases over time.

This series tries to solve problem of mapping GHES source to
a corresponding 'Generic Error Status Block' and related registers.
However we are missing access to this mapping since it only
exists in guest patched HEST (i.e in guest RAM only).

The robust way to make it work would be for QEMU to get a pointer
to whole HEST table and then enumerate GHES sources and related
error/ack registers directly from guest RAM (sidestepping layout
change issues this way).

what I'm proposing is to use bios_linker_loader_write_pointer()
(only once) so that firmware could tell QEMU address of HEST table,
in which one can find a GHES source and always correct error/ack
pointers (regardless of table[s] layout changes).


> Thanks,
> Mauro
> 



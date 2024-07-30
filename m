Return-Path: <linux-kernel+bounces-267362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F3D9410AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC31C234AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F0E19E83D;
	Tue, 30 Jul 2024 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHKssXBF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F5419E81D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339404; cv=none; b=sbKLV3LUJyzuCxgNqbkIbUFwBeaHt/pYBGjW5tGh6zy74IgB5xVE3Kxk8rzU6RuVLwi2NW4e0BfxXcS1h8lisaDsT76iA/biiG3sSYKEyG2mnh4L2l8F7MasUdF34hj6BUdTj7gf9HlkZiyf2OF+JkHayVmO1IYxBNFeaNejr5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339404; c=relaxed/simple;
	bh=bUc1iTOLcmwPvcBSOSF8OntjLHlOpM1e+US95f3p0+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcwvfewGCmPLfZZvHhfxVSoXfPwGOw/IN/Pg1cfEa2Hqysve6M6l+/GmqJmFEM0YpBfy5jqrLo99XdxwabmI7wCt3TvjcZgtwEDP05H8JMRM4Vrvuux2zplnFCF8k5YoYgD+MsYVqpT4vmFjartCpRcFiFW7btGvRS2s9XUoBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHKssXBF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722339401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MhlZfGAJ0otC0ssjOAlnO2L85Oh2aojhs/WkLFKmkY=;
	b=YHKssXBFtjxqkVkxrQl3GyjpAf157LucpYPiwME1MCKOUUZLju8ZUL9i+vIfcQkVjdHA7T
	4sLG4cvqUv41d4tisOEj+aE/adkZ0RF0rIJF9mvcfSz6AdizGeiNuDsd5MBR8TD0M68c2K
	DMflVf7TCyrc51P5N5qjstv/99eZY7E=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ClEqf4p7P5ugRMhOfvvBEQ-1; Tue, 30 Jul 2024 07:36:40 -0400
X-MC-Unique: ClEqf4p7P5ugRMhOfvvBEQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a7b5bd019cso4604410a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339398; x=1722944198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MhlZfGAJ0otC0ssjOAlnO2L85Oh2aojhs/WkLFKmkY=;
        b=CEQC4/rTG9v+Vpi5Tn3sP+HPl8TPixbi43cuSTu0zPbg0mszB5KcLXnb7bnKUwVUGz
         4YtUP0AoVCdUM7gHS5+W2nBV0+OdEpLd0adUnkCa/pjvndA0/PT2ooN0g9tU+Eko95zD
         0sV0xJJ/5lqQyiVs6g0AJKJDIKtRv07Q/bZGoRhWamWg8VTyIs4XxiqXJvG+f5xYprVK
         6M8pu+a/MdC4TSEa/AO5nQoYlef1f5hkzEjOuFNzk0sNdH0SrrklJWE5qinmjBnwasWF
         o25MFjdrBlxZAC6IJwnN2jrwDT4Vg0p+uRhN/FywOS4OUg1HaAVeq99gwjZs+RnBl3EL
         5nBg==
X-Forwarded-Encrypted: i=1; AJvYcCUO5ObfA/N+r1uHZPM932Qo/vTE5jVDXquSOa7RYpNL+Hi2SgRDktQk7gDf3uRowfMFfZ0WDATP44irr10hYTsup9EaEOp3MYjOzLsL
X-Gm-Message-State: AOJu0YyyfeL/6b9ErJvG8aXjyKRHQsOYtq78sMQyEE2wSmoEbnYobhiD
	CDoA6nnhGt7nw8MVZ7MRXL9GNHLSFozPwerYTdviAwXCpKHdafqEDnYG2o1nlzSCCrl37CezlyR
	0Am9XVwAvd8d5MW54xbL9/jo3PS7WqIUR3dpYY8G6kWnxyegDqKlFuGr6PoTgeVOhAMZmmA==
X-Received: by 2002:a50:935a:0:b0:595:71c7:39dd with SMTP id 4fb4d7f45d1cf-5b0223d9958mr7248117a12.34.1722339398279;
        Tue, 30 Jul 2024 04:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoEfmkzTd2XZ8H9toEV0ZkYQuZCySmnvSomwkMLT2qy5O8MDswyrwxNLJfAEGY8tBTxObrpw==
X-Received: by 2002:a50:935a:0:b0:595:71c7:39dd with SMTP id 4fb4d7f45d1cf-5b0223d9958mr7248088a12.34.1722339397440;
        Tue, 30 Jul 2024 04:36:37 -0700 (PDT)
Received: from redhat.com ([2.55.35.236])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590d1esm7155100a12.27.2024.07.30.04.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 04:36:36 -0700 (PDT)
Date: Tue, 30 Jul 2024 07:36:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 6/7] acpi/ghes: update comments to point to newer ACPI
 specs
Message-ID: <20240730073447-mutt-send-email-mst@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <66c1ab4988589be99ae925c6361548f55fea58b0.1721630625.git.mchehab+huawei@kernel.org>
 <20240730132430.44d9e4ae@imammedo.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730132430.44d9e4ae@imammedo.users.ipa.redhat.com>

On Tue, Jul 30, 2024 at 01:24:30PM +0200, Igor Mammedov wrote:
> On Mon, 22 Jul 2024 08:45:58 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > There is one reference to ACPI 4.0 and several references
> > to ACPI 6.x versions.
> > 
> > Update them to point to ACPI 6.5 whenever possible.
> 
> when it comes to APCI doc comments, they should point to
> the 1st (earliest) revision that provides given feature/value/field/table.

Yes. And the motivation is twofold.
First, guests are built against
old acpi versions. knowing in which version things appeared
helps us know which guests support a feature.
Second, acpi guys keep churning out new versions.
It makes no sense to try and update to latest one,
it will soon get out of date again.

> 
> > There's one reference that was kept pointing to ACPI 6.4,
> > though, with HEST revision 1.
> > 
> > ACPI 6.5 now defines HEST revision 2, and defined a new
> > way to handle source types starting from 12. According
> > with ACPI 6.5 revision history:
> > 
> > 	2312 Update to the HEST table and adding new error
> > 	     source descriptor - Table 18.2.
> > 
> > Yet, the spec doesn't define yet any new source
> > descriptors. It just defines a different behavior when
> > source type is above 11.
> > 
> > I also double-checked GHES implementation on an open
> > source project (Linux Kernel). Currently upstream
> > doesn't currently handle HEST revision, ignoring such
> > field.
> > 
> > In any case, revision 2 seems to be backward-compatible
> > with revison 1 when type <= 11 and just one error is
> > contained on a HEST record.
> > 
> > So, while it is probably safe to update it, there's no
> > real need. So, let's keep the implementation using
> > an ACPI 6.4 compatible table, e. g. HEST revision 1.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c | 48 ++++++++++++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 20 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 6075ef5893ce..ebf1b812aaaa 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -45,9 +45,9 @@
> >  #define GAS_ADDR_OFFSET 4
> >  
> >  /*
> > - * The total size of Generic Error Data Entry
> > - * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> > - * Table 18-343 Generic Error Data Entry
> > + * The total size of Generic Error Data Entry before data field
> > + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> > + * Table 18.12 Generic Error Data Entry
> >   */
> >  #define ACPI_GHES_DATA_LENGTH               72
> >  
> > @@ -65,8 +65,8 @@
> >  
> >  /*
> >   * Total size for Generic Error Status Block except Generic Error Data Entries
> > - * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
> > - * Table 18-380 Generic Error Status Block
> > + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> > + * Table 18.11 Generic Error Status Block
> >   */
> >  #define ACPI_GHES_GESB_SIZE                 20
> >  
> > @@ -82,7 +82,8 @@ enum AcpiGenericErrorSeverity {
> >  
> >  /*
> >   * Hardware Error Notification
> > - * ACPI 4.0: 17.3.2.7 Hardware Error Notification
> > + * ACPI 6.5: 18.3.2.9 Hardware Error Notification,
> > + * Table 18.14 - Hardware Error Notification Structure
> >   * Composes dummy Hardware Error Notification descriptor of specified type
> >   */
> >  static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
> > @@ -112,7 +113,8 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
> >  
> >  /*
> >   * Generic Error Data Entry
> > - * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> > + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> > + * Table 18.12 - Generic Error Data Entry
> >   */
> >  static void acpi_ghes_generic_error_data(GArray *table,
> >                  const uint8_t *section_type, uint32_t error_severity,
> > @@ -148,7 +150,8 @@ static void acpi_ghes_generic_error_data(GArray *table,
> >  
> >  /*
> >   * Generic Error Status Block
> > - * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> > + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> > + * Table 18.11 - Generic Hardware Error Source Structure
> >   */
> >  static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
> >                  uint32_t raw_data_offset, uint32_t raw_data_length,
> > @@ -429,15 +432,18 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> >          0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
> >  }
> >  
> > -/* Build Generic Hardware Error Source version 2 (GHESv2) */
> > +/*
> > + * Build Generic Hardware Error Source version 2 (GHESv2)
> > + * ACPI 6.5: 18.3.2.8 Generic Hardware Error Source version 2 (GHESv2 - Type 10),
> > + * Table 18.13: Generic Hardware Error Source version 2 (GHESv2)
> > + */
> >  static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> >  {
> >      uint64_t address_offset;
> > -    /*
> > -     * Type:
> > -     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> > -     */
> > +    /* Type: (GHESv2 - Type 10) */
> >      build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
> > +
> > +    /* ACPI 6.5: Table 18.10 - Generic Hardware Error Source Structure */
> >      /* Source Id */
> >      build_append_int_noprefix(table_data, source_id, 2);
> >      /* Related Source Id */
> > @@ -481,11 +487,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> >      /* Error Status Block Length */
> >      build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
> >  
> > -    /*
> > -     * Read Ack Register
> > -     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
> > -     * version 2 (GHESv2 - Type 10)
> > -     */
> > +    /* ACPI 6.5: fields defined at GHESv2 table */
> > +    /* Read Ack Register */
> >      address_offset = table_data->len;
> >      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
> >                       4 /* QWord access */, 0);
> > @@ -504,11 +507,16 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> >      build_append_int_noprefix(table_data, 0x1, 8);
> >  }
> >  
> > -/* Build Hardware Error Source Table */
> > +/*
> > + * Build Hardware Error Source Table
> > + * ACPI 6.4: 18.3.2 ACPI Error Source
> > + * Table 18.2: Hardware Error Source Table (HEST)
> > + */
> >  void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
> >                       const char *oem_id, const char *oem_table_id)
> >  {
> > -    AcpiTable table = { .sig = "HEST", .rev = 1,
> > +    AcpiTable table = { .sig = "HEST",
> > +                        .rev = 1,                   /* ACPI 4.0 to 6.4 */
> >                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> >  
> >      acpi_table_begin(&table, table_data);



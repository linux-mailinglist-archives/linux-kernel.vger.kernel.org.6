Return-Path: <linux-kernel+bounces-279072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FB94B8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98711C2074E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F191891C7;
	Thu,  8 Aug 2024 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNUCfgqv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D0A188CC5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104676; cv=none; b=iiI4s/XyMy/5sj3CWycEBcZdPdImbna758Zyj9+jXGkb9iaDV7nVwE+/m0VzoBNv681ek8yVKo3ZNImCHAgFkcU9LUPItZYR4znlTKDBjmPB/uIDU0bHSflzSpcfN6rNjS0G7wvWfvtQ6M6KyGuEW1LaWdAAxuqvaP+fSwmq+h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104676; c=relaxed/simple;
	bh=wpb4duVuszJ6xhrhFKaEGdQaVr9EEUfUA9zeZtqRnOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LngFaAOIen2hI/LMNibItwCK41JTVFM1oi/AFJoJ6p2amdqkb+jszLHQhcR0z1al9Ev0RYzdtje3dSaV9vfYYio6MHa11oxOoc0fCz5LzZM9JGWmY0SjSJcQpfIE3rzpbSt+RtIcsC6X+WLPtwvG9sa8KhOs1clf3QowmkB2wE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNUCfgqv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723104673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNHI/L4vlvGksF8p9K8eTN2Ci20cAuoEW6eGCMZ9ao4=;
	b=DNUCfgqvVOt2ZhPV+4xa4wvQ6M6TQV717Yt+7ODKD5p1bSkla8NSZlB6zZtvrVsyMpFuG5
	cqIwa+4kx1sCEC+BC33u6vLZGoWpqrHggAn4E32TthPMYSVrJnHVVrdmh7HeFHiKhmg8Zz
	zdB88wxg88LIEKl5Bvv7c8lKubZnGfU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-c1L6ZsYHNNmzrqs0cJHCzw-1; Thu, 08 Aug 2024 04:11:12 -0400
X-MC-Unique: c1L6ZsYHNNmzrqs0cJHCzw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso5233215e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 01:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104671; x=1723709471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNHI/L4vlvGksF8p9K8eTN2Ci20cAuoEW6eGCMZ9ao4=;
        b=hITzZpz1IIFohskRRi/r3qnYRDrXNuTHYTWVbrZQcfEfR6SusOr5YPeCGNhf+9T4DD
         cHERXOcJwjxHmErQLYoc0mn5IO1uvHPfT6DVb6nlI50DlX9nhRfJICeU/GXb4YB3hrjF
         BUP1AibyJeyKYacpsmBbNiGSn1UnlHtu4mOgpFWzppBWCZnuj0CUPkHFJsitFNtrMd09
         8EQD52snWU8rT7ZLBuuN1RQGi7MN8qnksVYsMtwb8sqaG08aVZi6UkhusLxl42y8y4D8
         TBITND9PtJA08iDJC1WeFlkVD0SDfWaRAtRkOKj6VyyBjdgFGKOrR06v2NGTEm4+6ICz
         kYMw==
X-Forwarded-Encrypted: i=1; AJvYcCVonj32ygx9ZwPl6DHZhJVetXp2YoMEJtBCz5jX4ySABPe3ecBiF1J4q+ALOWqNvB6TJmiWtTpB0/++4IMB8qAFwRuqaeUWmlbtw1ef
X-Gm-Message-State: AOJu0YzyDr2BQrvsflLpS3TZQUWbDd5hKsnvnr5eB1QHU5zp9aBWa9e0
	AE/cCKtMLjQ1MDqRPW64VA+breuYZX5+0TvaDzHcin0qJCX52uGjJo7Un0ZQbw7RBlRemuL264H
	2H9RM5rX3YaaumYbjfPceDq68xoGIpRMYzNQU9zAgi57hzsGKhoYYgAyDsLnKLg==
X-Received: by 2002:a05:600c:4689:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-4290af0ff08mr7220025e9.30.1723104670896;
        Thu, 08 Aug 2024 01:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOeNai7tCrc/Ff3wEyME20VmRZuQbs+TYp64T/yY6ucAE9oqlwBRMxH7c7oo//sgO5I2OXrQ==
X-Received: by 2002:a05:600c:4689:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-4290af0ff08mr7219785e9.30.1723104670279;
        Thu, 08 Aug 2024 01:11:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2724c72asm1047259f8f.113.2024.08.08.01.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:11:09 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:11:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240808101107.105a124f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240807152547.000058fd@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240807152547.000058fd@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 15:25:47 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 6 Aug 2024 16:31:13 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri,  2 Aug 2024 23:44:01 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Provide a generic interface for error injection via GHESv2.
> > > 
> > > This patch is co-authored:
> > >     - original ghes logic to inject a simple ARM record by Shiju Jose;
> > >     - generic logic to handle block addresses by Jonathan Cameron;
> > >     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> > > 
> > > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Shiju Jose <shiju.jose@huawei.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> > >  hw/acpi/ghes_cper.c    |   2 +-
> > >  include/hw/acpi/ghes.h |   3 +
> > >  3 files changed, 152 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index a745dcc7be5e..e125c9475773 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > >      ags->present = true;
> > >  }
> > >  
> > > +static uint64_t ghes_get_state_start_address(void)    
> > 
> > ghes_get_hardware_errors_address() might better reflect what address it will return
> >   
> > > +{
> > > +    AcpiGedState *acpi_ged_state =
> > > +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> > > +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> > > +
> > > +    return le64_to_cpu(ags->ghes_addr_le);
> > > +}
> > > +
> > >  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > >  {
> > >      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > > -    uint64_t start_addr;
> > > +    uint64_t start_addr = ghes_get_state_start_address();
> > >      bool ret = -1;
> > > -    AcpiGedState *acpi_ged_state;
> > > -    AcpiGhesState *ags;
> > > -
> > >      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> > >  
> > > -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > > -                                                       NULL));
> > > -    g_assert(acpi_ged_state);
> > > -    ags = &acpi_ged_state->ghes_state;
> > > -
> > > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > > -
> > >      if (physical_address) {
> > >          start_addr += source_id * sizeof(uint64_t);    
> > 
> > above should be a separate patch
> >   
> > >  
> > > @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > >      return ret;
> > >  }
> > >  
> > > +/*
> > > + * Error register block data layout
> > > + *
> > > + * | +---------------------+ ges.ghes_addr_le
> > > + * | |error_block_address0 |
> > > + * | +---------------------+
> > > + * | |error_block_address1 |
> > > + * | +---------------------+ --+--
> > > + * | |    .............    | GHES_ADDRESS_SIZE
> > > + * | +---------------------+ --+--
> > > + * | |error_block_addressN |
> > > + * | +---------------------+
> > > + * | | read_ack0           |
> > > + * | +---------------------+ --+--
> > > + * | | read_ack1           | GHES_ADDRESS_SIZE
> > > + * | +---------------------+ --+--
> > > + * | |   .............     |
> > > + * | +---------------------+
> > > + * | | read_ackN           |
> > > + * | +---------------------+ --+--
> > > + * | |      CPER           |   |
> > > + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> > > + * | |      CPER           |   |
> > > + * | +---------------------+ --+--
> > > + * | |    ..........       |
> > > + * | +---------------------+
> > > + * | |      CPER           |
> > > + * | |      ....           |
> > > + * | |      CPER           |
> > > + * | +---------------------+
> > > + */    
> > 
> > no need to duplicate docs/specs/acpi_hest_ghes.rst,
> > I'd just reffer to it and maybe add short comment as to why it's mentioned.
> >   
> > > +/* Map from uint32_t notify to entry offset in GHES */
> > > +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> > > +                                                 0xff, 0xff, 0xff, 1, 0};
> > > +
> > > +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> > > +                          uint64_t *read_ack_addr)
> > > +{
> > > +    uint64_t base;
> > > +
> > > +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Find and check the source id for this new CPER */
> > > +    if (error_source_to_index[notify] == 0xff) {
> > > +        return false;
> > > +    }
> > > +
> > > +    base = ghes_get_state_start_address();
> > > +
> > > +    *read_ack_addr = base +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        error_source_to_index[notify] * sizeof(uint64_t);
> > > +
> > > +    /* Could also be read back from the error_block_address register */
> > > +    *error_block_addr = base +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > > +
> > > +    return true;
> > > +}    
> > 
> > I don't like all this pointer math, which is basically a reverse engineered
> > QEMU actions on startup + guest provided etc/hardware_errors address.
> > 
> > For once, it assumes error_source_to_index[] matches order in which HEST
> > error sources were described, which is fragile.
> > 
> > 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> > in RAM migrated from older version might not match above assumptions
> > of target QEMU. 
> > 
> > I see 2 ways to rectify it:
> >   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
> >        in guest RAM, like we do with etc/hardware_errors, see
> >             build_ghes_error_table()
> >                ...
> >                tell firmware to write hardware_errors GPA into
> >        and then fetch from HEST table in RAM, the guest patched error/ack addresses
> >        for given source_id
> > 
> >        code-wise: relatively simple once one wraps their own head over
> >                  how this whole APEI thing works in QEMU
> >                  workflow  is described in docs/specs/acpi_hest_ghes.rst
> >                  look to me as sufficient to grasp it.
> >                  (but my view is very biased given my prior knowledge,
> >                   aka: docs/comments/examples wrt acpi patching are good enough)
> >                  (if it's not clear how to do it, ask me for pointers)  
> 
> Hi Igor, I think I follow what you mean but maybe this question will reveal
> otherwise.  HEST is currently in ACPI_BUILD_TABLE_FILE.
> Would you suggest splitting it to it's own file, or using table_offsets
> to get the offset in ACPI_BUILD_TABLE_FILE GPA?
yep, offset taken right before HEST is to be created
doc comment for bios_linker_loader_write_pointer() explains how it works

we need something like:
       bios_linker_loader_write_pointer(linker,
           ACPI_HEST_TABLE_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
           ACPI_BUILD_TABLE_FILE, hest_offset_within_ACPI_BUILD_TABLE_FILE); 

to register new file see:
   a08a64627 ACPI: Record the Generic Error Status Block address
   and to avoid copy past error maybe
   136fc6aa2 ACPI: Avoid infinite recursion when dump-vmstat
for this needs to be limited to new machine types and keep
old ones without this new feature. (I'd use hw_compat_ machinery for that)

while at it we should rename
  ACPI_GHES_DATA_ADDR_FW_CFG_FILE -> ACPI_GHES_ERRORS_ADDR_FW_CFG_FILE




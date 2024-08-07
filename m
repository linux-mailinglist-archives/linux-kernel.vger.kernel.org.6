Return-Path: <linux-kernel+bounces-278045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2E94AA0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE5B2047D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD06F312;
	Wed,  7 Aug 2024 14:25:57 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925456458
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040756; cv=none; b=r/eaICdEvgfw7uYLVqYNWTcLnuVKvXkWxgXpWaKuGpvRUUDP1vbugRjSwFV4x2fpOcy7O1UmtJWNy60dv6lrF4rb5FD2JQWqBdb5xZYWjwTU7xhyhhkhIokIeiHmjuRW/xFvllmYVLKDGcl+7j3vA0WYv3gnfkkChOehhpCbBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040756; c=relaxed/simple;
	bh=jW4eBRDjiyEBvtx2/oCOXrGyM+xYe7d8BQZcdpmDHME=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZuPZak9Lx8jnXdLatVDCrQK+YHubELB+rSXHrC2oxPrVDo0zKfrR6AH1+tNEtA7y36JSnn8Chr2bm53teVDbNhxSnjxdRDPg2yzeT2uGq78jEPswa1p3/hs9kLNWTUSnCOCJcdvMyIqsNsnLpu3cmcWV0DHf8TYVX7dTpSWwVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WfC8K6R0Vz6K5nm;
	Wed,  7 Aug 2024 22:23:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 242E6140B35;
	Wed,  7 Aug 2024 22:25:49 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 Aug
 2024 15:25:48 +0100
Date: Wed, 7 Aug 2024 15:25:47 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
	<anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240807152547.000058fd@Huawei.com>
In-Reply-To: <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Aug 2024 16:31:13 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri,  2 Aug 2024 23:44:01 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Provide a generic interface for error injection via GHESv2.
> > 
> > This patch is co-authored:
> >     - original ghes logic to inject a simple ARM record by Shiju Jose;
> >     - generic logic to handle block addresses by Jonathan Cameron;
> >     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> > 
> > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> >  hw/acpi/ghes_cper.c    |   2 +-
> >  include/hw/acpi/ghes.h |   3 +
> >  3 files changed, 152 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index a745dcc7be5e..e125c9475773 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> >      ags->present = true;
> >  }
> >  
> > +static uint64_t ghes_get_state_start_address(void)  
> 
> ghes_get_hardware_errors_address() might better reflect what address it will return
> 
> > +{
> > +    AcpiGedState *acpi_ged_state =
> > +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> > +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> > +
> > +    return le64_to_cpu(ags->ghes_addr_le);
> > +}
> > +
> >  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> >  {
> >      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > -    uint64_t start_addr;
> > +    uint64_t start_addr = ghes_get_state_start_address();
> >      bool ret = -1;
> > -    AcpiGedState *acpi_ged_state;
> > -    AcpiGhesState *ags;
> > -
> >      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> >  
> > -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > -                                                       NULL));
> > -    g_assert(acpi_ged_state);
> > -    ags = &acpi_ged_state->ghes_state;
> > -
> > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > -
> >      if (physical_address) {
> >          start_addr += source_id * sizeof(uint64_t);  
> 
> above should be a separate patch
> 
> >  
> > @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> >      return ret;
> >  }
> >  
> > +/*
> > + * Error register block data layout
> > + *
> > + * | +---------------------+ ges.ghes_addr_le
> > + * | |error_block_address0 |
> > + * | +---------------------+
> > + * | |error_block_address1 |
> > + * | +---------------------+ --+--
> > + * | |    .............    | GHES_ADDRESS_SIZE
> > + * | +---------------------+ --+--
> > + * | |error_block_addressN |
> > + * | +---------------------+
> > + * | | read_ack0           |
> > + * | +---------------------+ --+--
> > + * | | read_ack1           | GHES_ADDRESS_SIZE
> > + * | +---------------------+ --+--
> > + * | |   .............     |
> > + * | +---------------------+
> > + * | | read_ackN           |
> > + * | +---------------------+ --+--
> > + * | |      CPER           |   |
> > + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> > + * | |      CPER           |   |
> > + * | +---------------------+ --+--
> > + * | |    ..........       |
> > + * | +---------------------+
> > + * | |      CPER           |
> > + * | |      ....           |
> > + * | |      CPER           |
> > + * | +---------------------+
> > + */  
> 
> no need to duplicate docs/specs/acpi_hest_ghes.rst,
> I'd just reffer to it and maybe add short comment as to why it's mentioned.
> 
> > +/* Map from uint32_t notify to entry offset in GHES */
> > +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> > +                                                 0xff, 0xff, 0xff, 1, 0};
> > +
> > +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> > +                          uint64_t *read_ack_addr)
> > +{
> > +    uint64_t base;
> > +
> > +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> > +        return false;
> > +    }
> > +
> > +    /* Find and check the source id for this new CPER */
> > +    if (error_source_to_index[notify] == 0xff) {
> > +        return false;
> > +    }
> > +
> > +    base = ghes_get_state_start_address();
> > +
> > +    *read_ack_addr = base +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        error_source_to_index[notify] * sizeof(uint64_t);
> > +
> > +    /* Could also be read back from the error_block_address register */
> > +    *error_block_addr = base +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > +
> > +    return true;
> > +}  
> 
> I don't like all this pointer math, which is basically a reverse engineered
> QEMU actions on startup + guest provided etc/hardware_errors address.
> 
> For once, it assumes error_source_to_index[] matches order in which HEST
> error sources were described, which is fragile.
> 
> 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> in RAM migrated from older version might not match above assumptions
> of target QEMU. 
> 
> I see 2 ways to rectify it:
>   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
>        in guest RAM, like we do with etc/hardware_errors, see
>             build_ghes_error_table()
>                ...
>                tell firmware to write hardware_errors GPA into
>        and then fetch from HEST table in RAM, the guest patched error/ack addresses
>        for given source_id
> 
>        code-wise: relatively simple once one wraps their own head over
>                  how this whole APEI thing works in QEMU
>                  workflow  is described in docs/specs/acpi_hest_ghes.rst
>                  look to me as sufficient to grasp it.
>                  (but my view is very biased given my prior knowledge,
>                   aka: docs/comments/examples wrt acpi patching are good enough)
>                  (if it's not clear how to do it, ask me for pointers)

Hi Igor, I think I follow what you mean but maybe this question will reveal
otherwise.  HEST is currently in ACPI_BUILD_TABLE_FILE.
Would you suggest splitting it to it's own file, or using table_offsets
to get the offset in ACPI_BUILD_TABLE_FILE GPA?


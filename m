Return-Path: <linux-kernel+bounces-535912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A1A478F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC6018905A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B29227BB6;
	Thu, 27 Feb 2025 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPJQO7dp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68388227B83
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740648185; cv=none; b=NzuG+PCeA6DqRugZb7eDTZcmaHUi95oUuCUPn4b0ZOW3lZmNYn5rGuB4P6mhFVRVSCGvtnv3IWU6EsBsPlStrdMCxNXR+pgtKjH/o12yQpiPDGTO0xGFmbUzgrfZd1BRTptzLHJz0vi5exbHSa+jUGrYE5FcVPrkCwAUDzJ8S1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740648185; c=relaxed/simple;
	bh=5r14wDsAjXtTkY07ZCTOJH7TvV7VykQeoyunhC1ud8I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6STCznIcULySuOeRz1JF9Y4HzFDTy52F5VTb9NrVOXKP/pc7eRoBpRaItC1L8K4+cUpau+dOdjlO0XczDI5o1COV6xbPpWlUEH8ZKYWfTKmd07OjUNXqrT0BjrXahWv5aQavwY6X0CJlPRHCQybuMqrTU0GYsuZu09QlXHsKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPJQO7dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740648182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvc3U+oxlRfGkjPKGcsbVZOouyuZCVX/xbNNQfW1YfE=;
	b=RPJQO7dpHkOh8H86YwWSLuWZxcpGhHWh4q5z2zM19XdlQRB0XPkqcJR+J1xp+alUVNJb+4
	nw0+d17LiRzFvq2lFIKzQP/ntqjOsBSxd67J/NTh6FTviJBW4HOprCOL+GCAa2yzu89PvR
	zdVV+9XduR8BlpyYIwKFo5EXN0EbKWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-gbOmeM_9NmiIkY33KceufA-1; Thu, 27 Feb 2025 04:23:00 -0500
X-MC-Unique: gbOmeM_9NmiIkY33KceufA-1
X-Mimecast-MFC-AGG-ID: gbOmeM_9NmiIkY33KceufA_1740648179
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso244248f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740648179; x=1741252979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvc3U+oxlRfGkjPKGcsbVZOouyuZCVX/xbNNQfW1YfE=;
        b=fYgtJEZjNBLvlc+odE9WSl21lR9Hb5w5i7RNikxy31wNjIkMqhxRtA0le0fP6BM/CK
         tVmNjkpR0UnuDu7zCiK0/Fc4jw37kE7rkJ1nCYhU5HHnUJHWBsA5Wgp8wSs822UTz73A
         Se+/0xA8tj3s0UkZAGRMDQjw6TA97ARfaEYkZl7Xy42EkWHsKXQSYOOzJ39P/eqHCO2K
         q4Dbz0LS8ngaF+GRIpe02Vllf/5SF9SHwGD8vxdBQRp243mGHK/5FedR0LwQ9MFNFtzV
         UQwRpUgHBc2XJ7KBbsISsJuOrIs1NvFJPkTefWnb9fLf4wtv6UhfeuibatYqh3sGoudH
         brvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyDrr1Nm9DbDy9AKoWJJGQPX9k98ZKon+ar2UTsmmGqyL6vPBf2zuif0PbrfgbDBBRODE0llOa0fzkqAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznr+xl/6+Myn5fgIvgVlCvlJ8rPDpvP42IgoJB/jOVVD0Hiw23
	0tE5fLQ9YTFEFXvdBGlB24GtC1ksCp8bLGu/yERZ6rdHmfuzIc4VLSB5+tdScCHSX3BkqlH30zD
	5EscdTkUPA0eQoeY52RQlQW0y3EDBQaGgxMaq6833EXNsrglu9GwtG7WlB66d+A==
X-Gm-Gg: ASbGncuKSb+lyQ5Yhjb0m46NNkKzGR9MyDPWDabERBNsE1ITaC0OGRmWwNtLjzHx+Li
	LPevh5rTmozSrEQp9eIbTv5DcPY/7foFqJGHvBeBH9V+nd1CySdbsa6XSxoLJaLFIsr6h+2JpnI
	eCaQWzZWuynJ5ivuC382deW7eBMhQFz9LEfZwy7ZWpEv6D0SLCxfUMGdPgQolF2mXxjzOUSbQ0O
	lDdKZs4VfqdOWl3qtXrHTyZqttJDyy42zZG9mZEbIKiyyXbFKbydC7nsCrFaZ8tHeydAUrfzhFk
	x7kVEvi4orXAdQWmQYY9mXTuHR+jL4MJKMk/94Ih6xdJPuNM/sjoOhTN9hkZmvc=
X-Received: by 2002:a05:6000:4021:b0:38e:d4b3:9454 with SMTP id ffacd0b85a97d-390cc63234amr7744995f8f.34.1740648179000;
        Thu, 27 Feb 2025 01:22:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY54InkZjeoTNKzDwyztQKqMxzMHIajou66g+i8NzPePg0lroQPT6XK0MIss9/huXJWUf8uQ==
X-Received: by 2002:a05:6000:4021:b0:38e:d4b3:9454 with SMTP id ffacd0b85a97d-390cc63234amr7744969f8f.34.1740648178606;
        Thu, 27 Feb 2025 01:22:58 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm1404033f8f.27.2025.02.27.01.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:22:57 -0800 (PST)
Date: Thu, 27 Feb 2025 10:22:55 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250227102255.6843705e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250226171406.19c2de6b@sal.lan>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
	<9610ff88cf6fdc59cbfc8871d653fd890391be1e.1738345063.git.mchehab+huawei@kernel.org>
	<20250203153423.3e4de17c@imammedo.users.ipa.redhat.com>
	<20250221070221.329bdfb0@foz.lan>
	<20250225104327.0a2d1cb4@imammedo.users.ipa.redhat.com>
	<20250226171406.19c2de6b@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 17:14:06 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 25 Feb 2025 10:43:27 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 21 Feb 2025 07:02:21 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Em Mon, 3 Feb 2025 15:34:23 +0100
> > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > >     
> > > > On Fri, 31 Jan 2025 18:42:44 +0100
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > >       
> > > > > There are two pointers that are needed during error injection:
> > > > > 
> > > > > 1. The start address of the CPER block to be stored;
> > > > > 2. The address of the ack.
> > > > > 
> > > > > It is preferable to calculate them from the HEST table.  This allows
> > > > > checking the source ID, the size of the table and the type of the
> > > > > HEST error block structures.
> > > > > 
> > > > > Yet, keep the old code, as this is needed for migration purposes.
> > > > > 
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > ---
> > > > >  hw/acpi/ghes.c         | 132 ++++++++++++++++++++++++++++++++++++-----
> > > > >  include/hw/acpi/ghes.h |   1 +
> > > > >  2 files changed, 119 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > > > index 27478f2d5674..8f284fd191a6 100644
> > > > > --- a/hw/acpi/ghes.c
> > > > > +++ b/hw/acpi/ghes.c
> > > > > @@ -41,6 +41,12 @@
> > > > >  /* Address offset in Generic Address Structure(GAS) */
> > > > >  #define GAS_ADDR_OFFSET 4
> > > > >  
> > > > > +/*
> > > > > + * ACPI spec 1.0b
> > > > > + * 5.2.3 System Description Table Header
> > > > > + */
> > > > > +#define ACPI_DESC_HEADER_OFFSET     36
> > > > > +
> > > > >  /*
> > > > >   * The total size of Generic Error Data Entry
> > > > >   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> > > > > @@ -61,6 +67,25 @@
> > > > >   */
> > > > >  #define ACPI_GHES_GESB_SIZE                 20
> > > > >  
> > > > > +/*
> > > > > + * Offsets with regards to the start of the HEST table stored at
> > > > > + * ags->hest_addr_le,        
> > > > 
> > > > If I read this literary, then offsets above are not what
> > > > declared later in this patch.
> > > > I'd really drop this comment altogether as it's confusing,
> > > > and rather get variables/macro naming right
> > > >       
> > > > > according with the memory layout map at
> > > > > + * docs/specs/acpi_hest_ghes.rst.
> > > > > + */        
> > > > 
> > > > what we need is update to above doc, describing new and old ways.
> > > > a separate patch.      
> > > 
> > > I can't see anything that should be changed at
> > > docs/specs/acpi_hest_ghes.rst, as this series doesn't change the
> > > firmware layout: we're still using two firmware tables:
> > > 
> > > - etc/acpi/tables, with HEST on it;
> > > - etc/hardware_errors, with:
> > > 	- error block addresses;
> > > 	- read_ack registers;
> > > 	- CPER records.
> > > 
> > > The only changes that this series introduce are related to how
> > > the error generation logic navigates between HEST and hw_errors
> > > firmware. This is not described at acpi_hest_ghes.rst, and both
> > > ways follow ACPI specs to the letter.
> > > 
> > > The only difference is that the code which populates the CPER
> > > record and the error/read offsets doesn't require to know how
> > > the HEST table generation placed offsets, as it will basically
> > > reproduce what OSPM firmware does when handling	HEST events.    
> > 
> > section 8 describes old way to get to address to record old CPER,
> > so it needs to amended to also describe a new approach and say
> > which way is used for which version.
> > 
> > possibly section 11 might need some messaging as well.  
> 
> Ok, I'll modify it and place at the end of the series. Please
> see below if the new text is ok for you.
> 
> ---
> 
> [PATCH] docs/specs/acpi_hest_ghes.rst: update it to reflect some changes

s/^^^/docs: hest: add new "etc/acpi_table_hest_addr" and update workflow/

> 
> While the HEST layout didn't change, there are some internal
> changes related to how offsets are calculated and how memory error
> events are triggered.
> 
> Update specs to reflect such changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> diff --git a/docs/specs/acpi_hest_ghes.rst b/docs/specs/acpi_hest_ghes.rst
> index c3e9f8d9a702..f22d2eefdec7 100644
> --- a/docs/specs/acpi_hest_ghes.rst
> +++ b/docs/specs/acpi_hest_ghes.rst
> @@ -89,12 +89,21 @@ Design Details
>      addresses in the "error_block_address" fields with a pointer to the
>      respective "Error Status Data Block" in the "etc/hardware_errors" blob.
>  
> -(8) QEMU defines a third and write-only fw_cfg blob which is called
> -    "etc/hardware_errors_addr". Through that blob, the firmware can send back
> -    the guest-side allocation addresses to QEMU. The "etc/hardware_errors_addr"
> -    blob contains a 8-byte entry. QEMU generates a single WRITE_POINTER command
> -    for the firmware. The firmware will write back the start address of
> -    "etc/hardware_errors" blob to the fw_cfg file "etc/hardware_errors_addr".
> +(8) QEMU defines a third and write-only fw_cfg blob to store the location
> +    where the error block offsets, read ack registers and CPER records are
> +    stored.
> +
> +    Up to QEMU 9.2, the location was at "etc/hardware_errors_addr", and
> +    contains an offset for the beginning of "etc/hardware_errors".
> +
> +    Newer versions place the location at "etc/acpi_table_hest_addr",
> +    pointing to the beginning of the HEST table.
> +
> +    Through that such offsets, the firmware can send back the guest-side
       ^^^^^^^^^^^^^^^^^^^^^^^^^ can't parse that, suggest to just drop the phrase

> +    allocation addresses to QEMU. They contain a 8-byte entry. QEMU generates
> +    a single WRITE_POINTER command for the firmware. The firmware will write
> +    back the start address of either "etc/hardware_errors" or HEST table at
                ^^^^ drop this?

> +    the correspoinding address firmware.
>  
>  (9) When QEMU gets a SIGBUS from the kernel, QEMU writes CPER into corresponding
>      "Error Status Data Block", guest memory, and then injects platform specific
> @@ -105,8 +114,6 @@ Design Details
>       kernel, on receiving notification, guest APEI driver could read the CPER error
>       and take appropriate action.
>  
> -(11) kvm_arch_on_sigbus_vcpu() uses source_id as index in "etc/hardware_errors" to
> -     find out "Error Status Data Block" entry corresponding to error source. So supported
> -     source_id values should be assigned here and not be changed afterwards to make sure
> -     that guest will write error into expected "Error Status Data Block" even if guest was
> -     migrated to a newer QEMU.
> +(11) kvm_arch_on_sigbus_vcpu() report RAS errors via a SEA notifications,
> +     when a SIGBUS event is triggered.
 
>       The logic to convert a SEA notification
> +     into a source ID is defined inside ghes.c source file.
that's cheating and not documentation by any means

> 
> 
> 



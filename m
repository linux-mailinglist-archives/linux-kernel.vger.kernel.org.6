Return-Path: <linux-kernel+bounces-530921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B42A43A26
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C646D1895570
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14B266191;
	Tue, 25 Feb 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcV+8by0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AF2627F1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476616; cv=none; b=FXAYqfAPxT910OoRQcAUukPyNYZjhUxRUfK1Kf15cbnQxv07pycvvSRC3vc0SkjI5D9oziHXH8100sArsjlMvGvEjZXSeXuw29BI65e6s1PokyDWS0fyFI9fAjRf8TZESkbqTeLBwCMqu1VIkxAGniPw62st91gC/HxSFwxX4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476616; c=relaxed/simple;
	bh=QH8HT1UuDS6VviZFTBNZOaM0PQX0cxRd7F9k0oVT9mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6eOGXa61vk2B9tRLV3V8mKsaxOeBSk5Dt6p4D0fEEBqYY3u7+7/+AdW3ihUcel7Iyt4opMifz0OrvNb9rcEjgk9OvsiSvQSPCZd4hYHXk957KLxFNx8Bu/3DOuygDoCNFTL+LTo0RD7HYDVPvZiHRHmL2XMP7iHQHbREzeUDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcV+8by0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740476613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5IuXbVC/fE2fpy28ItJZlJGmOxKbKIqaMashXqUdLM=;
	b=BcV+8by0it2plCjkpekCUOUHjsH9OSBeOMGFVa+v+oNiFCtHCHhlw3dhiEElrCqUiiK/mb
	0kHkeIN/k/gKAN/I4klTfigyOnPSt0ASnACtsGwMHKtypztP5jytDIEX0ClqdRxu46rSeR
	qAIIkWJxIhXmB56+UuB/dL1hxMEYato=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-AzVKpqwVPbmMXit9L2vrow-1; Tue, 25 Feb 2025 04:43:31 -0500
X-MC-Unique: AzVKpqwVPbmMXit9L2vrow-1
X-Mimecast-MFC-AGG-ID: AzVKpqwVPbmMXit9L2vrow_1740476610
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4393e89e910so29789745e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476610; x=1741081410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5IuXbVC/fE2fpy28ItJZlJGmOxKbKIqaMashXqUdLM=;
        b=CJnan6NBMUKWIml2ytpu8BI5sDdTjaZHvYS+8UzJ54dUiL85NJ8s3Uqpn1hGgfqCuH
         RdczQnlIWP76seNXqFy1x7/pdmgOeuEWZhpw7VAWgMfHQt8qi2YnFMS5atROPnDppeZ2
         T1wIxIdxMrbET73zo3M9GzoOBwgxMbjdkQtet5K6nzMjpwhBxz8+w8583NklL1mRDIqx
         UlNR6KFIt3VM0kdFHS5zDLrQGxXPEm3B3tIbuh+AjtxXp9Q6LzH5oTXoB56pMbfkWfoU
         CXBhpdHva+fk3jM72tpUIs8KiUMoT34bgws7+mGQ5sRgDk64SYYkhUk0wr3ruhwTq8YH
         S8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWwF2I3yItoKnsMn8yx3stv3tcybpalbjb5WOD/pp0iaa9W2psbiWKgKK66uCxX0AT5pWnI2iBw05nMTrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ml1XUTZAZZxUtWv6yQW7G8wMLE7RDiQYX/XfgcLpez2REsfA
	7vWTYBOfylzOoIH1l9tsZNwo5ZUuyeeglHG287B3cJanKk9AXDtkm3ZZKCYS2f/d2ZMmt0qYjA0
	aanzmKA0NYqJMptF4YaPZBNfD2YGj5DRVzcZatwFBuLOLsj+0uYd87UMnMpjGwg==
X-Gm-Gg: ASbGncv/9bnhT72QmU/aAHYGzY97TWJQJxeFi/xDyrMm2NeDkAo4kra8gfsrTWBGvbO
	YQeUS/PhK2qeg+/+vo5lFNumeUXDikFRXbKlyJPJdLlAmTvAjqMSNSlMNGxi19rjlQ+7GHzOIxJ
	uDhkrG389pBUUgb43czP1jNH+RHQYSSTwRNGe9TD4z4Df/MNeTrhoVZoVzln4fZd2vuc3BkxbOI
	pC+wUMew6eY/6S/7fJtgsqRw6wOsDRXBI5FdP/JQYcr9rYFAbqxGFHTpaQVEuiUGV5ONaN1EA8a
	XcIq1Vi9symzalxrutFc7tAVkNRJ4Vj+CUJZ2yhNLfrnLj2f2W5PKnt+1Tu/FRg=
X-Received: by 2002:a05:600c:3c87:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43ab0ecc2f2mr24089295e9.0.1740476610523;
        Tue, 25 Feb 2025 01:43:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7SWWZtXumX0waBhzuzJJUOBFPNpCyr81evlpTXBUdvLowN5fEohw657IpPbZDbBNIzb4b3A==
X-Received: by 2002:a05:600c:3c87:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43ab0ecc2f2mr24088975e9.0.1740476610069;
        Tue, 25 Feb 2025 01:43:30 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce615sm134946725e9.5.2025.02.25.01.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:43:29 -0800 (PST)
Date: Tue, 25 Feb 2025 10:43:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/14] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250225104327.0a2d1cb4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250221070221.329bdfb0@foz.lan>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
	<9610ff88cf6fdc59cbfc8871d653fd890391be1e.1738345063.git.mchehab+huawei@kernel.org>
	<20250203153423.3e4de17c@imammedo.users.ipa.redhat.com>
	<20250221070221.329bdfb0@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 07:02:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 3 Feb 2025 15:34:23 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 31 Jan 2025 18:42:44 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > There are two pointers that are needed during error injection:
> > > 
> > > 1. The start address of the CPER block to be stored;
> > > 2. The address of the ack.
> > > 
> > > It is preferable to calculate them from the HEST table.  This allows
> > > checking the source ID, the size of the table and the type of the
> > > HEST error block structures.
> > > 
> > > Yet, keep the old code, as this is needed for migration purposes.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  hw/acpi/ghes.c         | 132 ++++++++++++++++++++++++++++++++++++-----
> > >  include/hw/acpi/ghes.h |   1 +
> > >  2 files changed, 119 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 27478f2d5674..8f284fd191a6 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -41,6 +41,12 @@
> > >  /* Address offset in Generic Address Structure(GAS) */
> > >  #define GAS_ADDR_OFFSET 4
> > >  
> > > +/*
> > > + * ACPI spec 1.0b
> > > + * 5.2.3 System Description Table Header
> > > + */
> > > +#define ACPI_DESC_HEADER_OFFSET     36
> > > +
> > >  /*
> > >   * The total size of Generic Error Data Entry
> > >   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> > > @@ -61,6 +67,25 @@
> > >   */
> > >  #define ACPI_GHES_GESB_SIZE                 20
> > >  
> > > +/*
> > > + * Offsets with regards to the start of the HEST table stored at
> > > + * ags->hest_addr_le,    
> > 
> > If I read this literary, then offsets above are not what
> > declared later in this patch.
> > I'd really drop this comment altogether as it's confusing,
> > and rather get variables/macro naming right
> >   
> > > according with the memory layout map at
> > > + * docs/specs/acpi_hest_ghes.rst.
> > > + */    
> > 
> > what we need is update to above doc, describing new and old ways.
> > a separate patch.  
> 
> I can't see anything that should be changed at
> docs/specs/acpi_hest_ghes.rst, as this series doesn't change the
> firmware layout: we're still using two firmware tables:
> 
> - etc/acpi/tables, with HEST on it;
> - etc/hardware_errors, with:
> 	- error block addresses;
> 	- read_ack registers;
> 	- CPER records.
> 
> The only changes that this series introduce are related to how
> the error generation logic navigates between HEST and hw_errors
> firmware. This is not described at acpi_hest_ghes.rst, and both
> ways follow ACPI specs to the letter.
> 
> The only difference is that the code which populates the CPER
> record and the error/read offsets doesn't require to know how
> the HEST table generation placed offsets, as it will basically
> reproduce what OSPM firmware does when handling	HEST events.

section 8 describes old way to get to address to record old CPER,
so it needs to amended to also describe a new approach and say
which way is used for which version.

possibly section 11 might need some messaging as well.


> 
> Thanks,
> Mauro
> 



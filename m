Return-Path: <linux-kernel+bounces-279494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1800A94BDF4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8591C23434
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0E18C925;
	Thu,  8 Aug 2024 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0fxnr17"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73025EEC5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121125; cv=none; b=aL808wjn6pooNcHl9wZfBjbgIMFc2XnptvFlhC0axRuBvzItumCG4PA+qmPs07SNHzCLA3mbdnk8Sx3kyLLEgG6vzXU5P8lWgWhSe9aoYj/vIvCJMpjrOfWl2HT2GBfJe21OtpLHYZG4x6r3vV01MTu0BYZytfnmjSAL/1JAyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121125; c=relaxed/simple;
	bh=pP3nAFdQy/THlHDKbLfLtBqxAMj/cweGr8i1+GAiO+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDC+2zbdoIoUiuzxbtH8kCoYxWkKYhkAQ/uucQnavG7JKMgYF2jv46LpzvqFdSpJZGP1CAdll010Xd2HXFiqhlwtw+mqxyfr8NprWV2hYVNpxuKCU7N1GRML24nWBeLk8aROCXWrLePfJljsm0FG2wlpycjP3cfkoC0CvQZaQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0fxnr17; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723121122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptKDxgrGdse9UED2SWQeru7lsVTSreNqiYvZX807YgA=;
	b=e0fxnr17cHBedrcdcj26kp0j2jtSl6eU+FeYGn6EBkQOwLAAPoXnaAgP7qh3fzIuNHqk/O
	mKmd+XJh2X4nRY9hnv8woC6lI8r1970BKyB1WA2yFckFuPAFgYxI6K989iNq1sx6QNxgq3
	DluhLwGGmUHKUrr0sjmCFmiTVZMP1Fw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-dFYw3myWMaeBRMo0qp2h7Q-1; Thu, 08 Aug 2024 08:45:20 -0400
X-MC-Unique: dFYw3myWMaeBRMo0qp2h7Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef23ec8dceso8324741fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723121119; x=1723725919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptKDxgrGdse9UED2SWQeru7lsVTSreNqiYvZX807YgA=;
        b=SE9YNr1j7f6+1n5LxH1bG4Bt0EmF+mxdP2TaXM7f5vkMQG/5az68MncRE2MwsLh3+8
         VnpFDAvTgSLsUudexasowkMkGBsPuVIRIMkO1DwILirMcdaA2V6ZyECKDB30W/oNOuv1
         XHdaYglznjWk+vtlikLZDvz9sDoQWSJAs7EKGSWG9tqdvtZ+CfdEd3seRVIu1HLyT6x4
         pGuj+DhmlwV8OpnrZeg1qfFQck+yQupZxx9ML+mN+fqv6GMK0MR/IUYQOV4WIL6hxfz7
         PBw+ru/PBTPPj12uw+rYfJXks6PFR5sHTSv/1Ex8AziYZ5oIGPY52q9AIz4AquUSTEZJ
         papA==
X-Forwarded-Encrypted: i=1; AJvYcCWETGQCUXite6N/O1Rrvvk05AlLxd4/f6q504dOEWIiTPnIoiQ5f/ea1+NOnykiB7DGIH6AG0vfA0ojge9FQSm34Uh09ek5RYLfyU4v
X-Gm-Message-State: AOJu0YzFd4zJSYfyRf9Ts58o0GAG+RHzCWmqiaTfHP4EkARD2tpWd1p9
	TMAL1Znjxa9ZMfmd/eJa7tR+JejT/jAibGYJHC+xWOSJKuV09MEi3XahyL6kEp8JiZvc8DHpdH1
	xs164hyrGbpBeKT2jVCjoD7WgXTyGJyrEdpcJNPKLrheyud/hwynZHssiYo80TA==
X-Received: by 2002:a05:651c:204:b0:2ef:22ed:3818 with SMTP id 38308e7fff4ca-2f19de759f9mr11082531fa.32.1723121118859;
        Thu, 08 Aug 2024 05:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvp8ayaTFQjj9t66k/5w3gC1rs6hkHc9HoxalxOhOyJ/hFVqfNEib82fRz9Ou0AziP0J7oNQ==
X-Received: by 2002:a05:651c:204:b0:2ef:22ed:3818 with SMTP id 38308e7fff4ca-2f19de759f9mr11082211fa.32.1723121118172;
        Thu, 08 Aug 2024 05:45:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059cf83dsm71238425e9.47.2024.08.08.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:45:17 -0700 (PDT)
Date: Thu, 8 Aug 2024 14:45:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240808144514.399e9e4b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240808141114.3b021f80@foz.lan>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
	<20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
	<20240808141114.3b021f80@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 14:11:14 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 6 Aug 2024 16:31:13 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
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
> That sounds a better approach, however...
> 
> >   2nd:  sort of hack based on build_ghes_v2() Error Status Address/Read Ack Register
> >         patching instructions
> >                bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,                
> >                    address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),                      
> >                    ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
> >                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^
> >         during build_ghes_v2() also store on a side mapping
> >              source_id -> error address offset : read ack address
> > 
> >         so when you are injecting error, you'd at least use offsets
> >         used at start time, to get rid of risk where injection code
> >         diverge from HEST:etc/hardware_errors layout at start time.
> > 
> >         However to make migration safe, one would need to add a fat
> >         comment not to change order ghest error sources in HEST _and_
> >         a dedicated unit test to make sure we catch it when that happens.
> >         bios_tables_test should be able to catch the change, but it won't
> >         say what's wrong, hence a test case that explicitly checks order
> >         and loudly & clear complains when we will break order assumptions.
> > 
> >         downside:
> >            * we are are limiting ways HEST could be composed/reshuffled in future
> >            * consumption of extra CI resources
> >            * and well, it relies on above duct tape holding all pieces together  
> 
> I ended opting to do approach (2) on this changeset, as the current code
> is already using bios_linker_loader_add_pointer() for ghes, being deeply 
> relying on the block address/ack and cper calculus.

I consider (2) as a fallback in case (1) can't be done with reasonable effort.
At this point, (1) looks doable and I'm not convinced that duct tape
is necessary and that we badly need to rush in this series.
Hence I'd strongly prefer (1).

See my other reply to Jonathan, setting write pointer is not hard.
Parsing HEST doesn't have to be a full tables parser as long as
it respects table types/length/revision then we can cheat by using 
documented offsets from ACPI spec as is, for fields we
need to access.


> To avoid troubles on this duct tape, I opted to move all offset math
> to a single function at ghes.c:
> 
> 	/*
> 	 * ID numbers used to fill HEST source ID field
> 	 */
> 	enum AcpiHestSourceId {
> 	    ACPI_HEST_SRC_ID_SEA,
> 	    ACPI_HEST_SRC_ID_GED,
> 	
> 	    /* Shall be the last one */
> 	    ACPI_HEST_SRC_ID_COUNT
> 	} AcpiHestSourceId;
> 
> 	...
> 
> 	static bool acpi_hest_address_offset(enum AcpiGhesNotifyType notify,
>         	                             uint64_t *error_block_offset,
>                 	                     uint64_t *ack_offset,
>                         	             uint64_t *cper_offset,
>                                 	     enum AcpiHestSourceId *source_id)
> 	{
> 	    enum AcpiHestSourceId source;
> 	    uint64_t offset;
> 
> 	    switch (notify) {
> 	    case ACPI_GHES_NOTIFY_SEA:      /* Only on ARMv8 */
> 	        source = ACPI_HEST_SRC_ID_SEA;
> 	        break;
> 	    case ACPI_GHES_NOTIFY_GPIO:
> 	        source = ACPI_HEST_SRC_ID_GED;
> 	        break;
> 	    default:
> 	        return true;
> 	    }
> 
> 	    if (source_id) {
> 	        *source_id = source;
> 	    }
> 
> 	    /*
> 	     * Please see docs/specs/acpi_hest_ghes.rst for the memory layout.
> 	     * In summary, memory starts with error addresses, then acks and
> 	     * finally CPER blocks.
> 	     */
> 
> 	    offset = source * sizeof(uint64_t);
> 
> 	    if (error_block_offset) {
> 	        *error_block_offset = offset;
> 	    }
> 	    if (ack_offset) {
> 	        *ack_offset = offset + ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
> 	    }
> 	    if (cper_offset) {
> 	        *cper_offset = 2 * ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t) +
> 	                       source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> 	    }
> 
> 	    return false;
> 	}
> 
> I also removed the anonymous enum with SEA/GPIO source IDs, using
> only the ACPI notify type as arguments at the function calls.
> 
> As there's now a single point where the offsets from
> docs/specs/acpi_hest_ghes.rst are enforced, this should be error
> prone.
> 
> The code could later be changed to use approach (2), on a separate
> cleanup.
> 
> Thanks,
> Mauro
> 



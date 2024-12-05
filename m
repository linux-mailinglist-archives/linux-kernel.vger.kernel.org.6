Return-Path: <linux-kernel+bounces-432864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F849E5132
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A682287F7A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EA1D619F;
	Thu,  5 Dec 2024 09:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0zyIGzh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92F1D514B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390547; cv=none; b=UP43CUTAqU1bNAdIBFEhZolfKOkVz8LNlG13yQlUq2O+FTrBubAWCqLRlY6hLtxla1e0vZNE14q6bnXZRhO4ofVk5cIbUgYUI322qbf0hiU7botHE3jMr13AoC45qNKa8JIZPLQwXxGxSILZ+Jtum/UV4dz/2NAyY+nP1aYtUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390547; c=relaxed/simple;
	bh=3rzigxSwbvWo7S8K8raXtPYFCQaJ22o4ySbtaaE/20M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCmaMTLVP+yqaemQLYCbm38IszkO2gbT4YWdduACSzfSfanDhuBXM/t4WS0aDuYdmA3f7NhdyfWtZMTeGh/MVb5T+OnvU+mu/X0B/fzb33WR3xxVi/R2H6Nnzu2zw8+kUTa8I26OiMS9QXUbOHiT4yGJXREsvjccDq8V+f4ZosE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0zyIGzh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733390543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGhsvxIAa/RUDZNcykbYv+PGXT3hSqjfx5KJygYAroU=;
	b=N0zyIGzh6Bv10cMKqFb58RKAbYcnQXJItTMwmk1kFGnFKRoyreXjoqgkAoN9uF8/JJrlrr
	2z+gxP/tvT/B1g7mbjvPW+t7HdHUReUbjal01TadyiAfBonVm+XRVxyo17FWu94rUeuiSO
	qike88VaX44PI5pSSEEJO4opBubj9V8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-Es10tabtNUqaIpM1BhillQ-1; Thu, 05 Dec 2024 04:22:22 -0500
X-MC-Unique: Es10tabtNUqaIpM1BhillQ-1
X-Mimecast-MFC-AGG-ID: Es10tabtNUqaIpM1BhillQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434a104896cso6189535e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733390541; x=1733995341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGhsvxIAa/RUDZNcykbYv+PGXT3hSqjfx5KJygYAroU=;
        b=T4MOULhMC4Esl/RUt5SgLuiByhUvZUUuS1mSDAUgtVPPakYp2yb2VK6hR0Jy4Jh8W7
         nykX0fFhSNFziYNAoGCX8fBo0FykI/5vX5lASAlwMKUfq+EJHe7lql5VO/0st783cNy2
         e57VQTD2M375CTF8NFp+o1IObTZqnN2WrGIm2nODabqynoB6deHX3fsWZZUcD5uMR8L2
         avKDEz2PMZaOXJ5musNdQScmLDPV9z51KFRRyPPOvEGQTg/0tXBiE0l6Jqm3z49BfLn0
         EKErqct5MgJM1zHfU0mk5Fd9UsfzU++r4N3Td74s9tLpyD47cRj2fu2pw3cCkgxS5YlF
         Aizw==
X-Forwarded-Encrypted: i=1; AJvYcCVTEcYXtOXUDa/8ESrycCzCzB0hj7ZHJj8fUX2o7nitwQ/29g9V69t/IeMGEpVNGpFRONnm35FDbsX3Xsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43UHQo2PC2okQwlCl/ExO7LwROzLmdJLptjPZ5uAeiAx59iVZ
	OYEIWrCVKYr84JSPCW+pkzXexim7UNT7CJDwLM4fsUZ1xU5G8zZmSPn05klsYkC0mA1CiE+jLqZ
	P4ZopZY9AmAhK0KkEk5WmGT1XTBTPiQ7eEMi0ZNLYL9Q7encb8e9kVBSXf/bgsA==
X-Gm-Gg: ASbGncsq/cQgeUukVFYqWj3M+W8Q/cjkboZLVtifQmz2FQqXJhqPQFYYt5mz4VGHrhP
	6qmb1Fyce/ASpEsViQTAwUgmcdmys147ELE1ANxZfiCCTL7798yOA1CLqeLuucfjUdbi9P4e8PO
	tOuPtSG+Xg1x1RA+eSf9yC1uY4K7LbRnmyqOy6w3lWgy9avjOGFnndrF0JSxeqb1Iza31dj/u8j
	br6ET6N2I5fcRJJ4gU2YFNVusnHGCnBc0IxcXRm3IlH3rtETBfMPkVrwS+QiaP83Wj+MczCu4zT
	aGzUhY9MRsWh4lqazZZFjw==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr95742375e9.30.1733390541405;
        Thu, 05 Dec 2024 01:22:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT4EGxhQ2he7SyDsdfd8Wk6mjcV8wUeXsFxJYCRu67z9LwO9sq7p4sNrm4N4vKaCBEjHCYOQ==
X-Received: by 2002:a05:600c:4ecf:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-434d0a14eb7mr95742175e9.30.1733390541030;
        Thu, 05 Dec 2024 01:22:21 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52723fasm53651195e9.10.2024.12.05.01.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:22:20 -0800 (PST)
Date: Thu, 5 Dec 2024 10:22:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 13/16] acpi/ghes: better name the offset of the
 hardware error firmware
Message-ID: <20241205102219.274e3d27@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241205085959.2223d079@foz.lan>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
	<20b003136d8c008fd54e8d40c806f13867336e13.1733297707.git.mchehab+huawei@kernel.org>
	<20241204173759.6f02561a@imammedo.users.ipa.redhat.com>
	<20241205085959.2223d079@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 08:59:59 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 4 Dec 2024 17:37:59 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Wed,  4 Dec 2024 08:41:21 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > The hardware error firmware is where HEST error structures are    
> >       ^^^^^^^^^^^^^^^^^^^^^^^ I can't parse this, suspect you've meant something else here
> >   
> > > stored. Those can be GHESv2, but they can also be other types.
> > > 
> > > Better name the location of the hardware error.
> > > 
> > > No functional changes.  
> 
> I meant this fw_cfg file:
> #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> 
> What about changing description to:
> 
> 	The etc/hardware_errors fw_cfg file is where the HEST error
> 	source structures are stored. Those can be GHESv2, but they can also
> 	be other types.

As I understand it, etc/hardware_errors is a blob
for '18.3.2.7.1. Generic Error Data' with some extra fields
to accommodate GHESv2 handling (i.e. err addr indirection and ack reg).

While error sources are described in HEST (and only GHES ones would
reference  etc/hardware_errors via error status addr/read ack register addr)

> 
> 	For more details about error source structure, see:
> 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source
> 
> 	Better name the address variable from ghes_error_le to hw_error_le
> 	to better reflect that.
> 
> 	No functional changes.
> 
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/acpi/generic_event_device.c | 4 ++--
> > >  hw/acpi/ghes.c                 | 4 ++--
> > >  include/hw/acpi/ghes.h         | 2 +-
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index 663d9cb09380..17baf36132a8 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -364,7 +364,7 @@ static const VMStateDescription vmstate_ghes = {
> > >      .version_id = 1,
> > >      .minimum_version_id = 1,
> > >      .fields = (const VMStateField[]) {
> > > -        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > > +        VMSTATE_UINT64(hw_error_le, AcpiGhesState),
> > >          VMSTATE_END_OF_LIST()
> > >      },
> > >  };
> > > @@ -372,7 +372,7 @@ static const VMStateDescription vmstate_ghes = {
> > >  static bool ghes_needed(void *opaque)
> > >  {
> > >      AcpiGedState *s = opaque;
> > > -    return s->ghes_state.ghes_addr_le;
> > > +    return s->ghes_state.hw_error_le;
> > >  }
> > >  
> > >  static const VMStateDescription vmstate_ghes_state = {
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index 52c2b69d3664..90d76b9c2d8c 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -359,7 +359,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > >  
> > >      /* Create a read-write fw_cfg file for Address */
> > >      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> > > -        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> > > +        NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> > >  
> > >      ags->present = true;
> > >  }
> > > @@ -385,7 +385,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> > >      }
> > >      ags = &acpi_ged_state->ghes_state;
> > >  
> > > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > > +    start_addr = le64_to_cpu(ags->hw_error_le);
> > >  
> > >      start_addr += source_id * sizeof(uint64_t);
> > >  
> > > diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> > > index 21666a4bcc8b..39619a2457cb 100644
> > > --- a/include/hw/acpi/ghes.h
> > > +++ b/include/hw/acpi/ghes.h
> > > @@ -65,7 +65,7 @@ enum {
> > >  };
> > >  
> > >  typedef struct AcpiGhesState {
> > > -    uint64_t ghes_addr_le;
> > > +    uint64_t hw_error_le;
> > >      bool present; /* True if GHES is present at all on this board */
> > >  } AcpiGhesState;
> > >      
> >   
> 
> 
> 
> Thanks,
> Mauro
> 



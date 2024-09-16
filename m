Return-Path: <linux-kernel+bounces-330540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C168979FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07253B21129
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C114E2C2;
	Mon, 16 Sep 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG1ntE+C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC313A89B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484715; cv=none; b=WRw+HyvldFi8csj+oGkhM+gLfseB1jXR2/RqLRvF/EOLEosFj4+gqu9WP1jdytSewhvxKXLLSP7mOaf/fYpJzkPVDE39mr86UtcA4I6KrsKicu4+N0wtdordKaP6nmz5IsfSO5hSDgEcjNvCprRmVcFWmpZ8xMh4ta6riFtkRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484715; c=relaxed/simple;
	bh=M7tDSbv+mJnJUqI3/GfT9wksRnwe9eJotynOTdVGduk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDeeZEJ1cL2waTIHBWLbeRj8KYY2vxuPjkcZcNPRgkrRtYEm96Chq0Z1dZLqKcR6y1/G9Tvz5+EVygAbupj3haUG7VBFdO0bv3B/b7GXOLAzHBCK+F15Yh5WR+QIJiUnA+DsgXccAn7RVh/HfB46gwUXapPuq6ShYgJiLIHoeBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iG1ntE+C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726484712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8L8zrjU0hX7xuCGfStZpPVLIWkvOYEq0KXroIh7oBo=;
	b=iG1ntE+CsotsSnraI0qzIm25aA4VriwarlEaYRklXfU4S9J6HcPKirSt5rSGm1yhxE18yh
	j5Ht08mFe21Nihw4Zz69pXfEddL/0H5vu8WZqIAvcsxvQkYtjRT0yyNzUPYN6HBx3GlKsa
	TDNXr8Czj5eeIUPI+2TXbsi/SRpO8hc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-wlO6G8-QNMaGjJtAgOyWXA-1; Mon, 16 Sep 2024 07:05:11 -0400
X-MC-Unique: wlO6G8-QNMaGjJtAgOyWXA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb6ed7f9dso29664545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726484710; x=1727089510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8L8zrjU0hX7xuCGfStZpPVLIWkvOYEq0KXroIh7oBo=;
        b=oTsqtmZVrkQsJIdMTfWHzvxhhj39hmJfN17ZeMRqc7jfOSlbrpVdjS2KdEIoHIeZOR
         mO15pE7bs3c1riGmIrcsA/d/TTPfl9ob5gpz2aGZ8IyLNtY7ErpMZ2xHjhWpmnjsGV72
         KdZ7PPrOL/7kAjCzMFPiKMEt/P6OMyYG1ETLxVgMVIWbvpK7Eb7JOjX8336XBmIaoFZF
         Gz5n4zr/DlSYNXDRp2sCygDz/YlKalmGausPw/E8JmvEuKKz1bYa5pMY1SS5mWmKDFMO
         aehThaH1breg8F1Dl2gAXkhV0DAFJgwvaKz0j3QqWcXc+N2S1oJ6rO6kXtUzOi102ti3
         PGFA==
X-Forwarded-Encrypted: i=1; AJvYcCWvSsVU6W6GaIQ2TFZqiXspmy3YX6gWu3pVhBk9n/dbJbyR4w38bZ/UT+OZJSVot/oh8mtaAo8mLD5FDMY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0P8uzmRGfoUwpXmMOjx6NsteN6ro2mcc/KIaYBj+K+ta7UyRg
	K4Y2AUOK4Wrgn7Xy2V21/17janUF58dDePszEsh5gweUnE72Mmp2PUcRX4AspbBuspO1ZIF9XYB
	N1jXsq4UW2mftXCFeL8QdX5+1Kaljot+WpByG+XnJjgr+XtMDulMaXr2hcI34Tg==
X-Received: by 2002:a05:600c:4e94:b0:42c:b8c9:16b6 with SMTP id 5b1f17b1804b1-42d9070a24cmr110057695e9.2.1726484710058;
        Mon, 16 Sep 2024 04:05:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbPcog3aj8YawkxoSUaT7AsICVRNpQrYgJvWdmbobj8F6CJaBO8tJhm6kohsywnotfNUjwiw==
X-Received: by 2002:a05:600c:4e94:b0:42c:b8c9:16b6 with SMTP id 5b1f17b1804b1-42d9070a24cmr110056915e9.2.1726484708823;
        Mon, 16 Sep 2024 04:05:08 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b05d707sm107580425e9.14.2024.09.16.04.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 04:05:07 -0700 (PDT)
Date: Mon, 16 Sep 2024 13:05:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20240916130506.293ab543@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240914073314.46368ff6@foz.lan>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
	<20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
	<20240913074435.0eea2552@foz.lan>
	<20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
	<20240914073314.46368ff6@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 07:33:14 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Hi Igor,
> 
> Em Fri, 13 Sep 2024 15:25:18 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > > > in addition to this, it needs a patch on top to make sure
> > > > that we migrate hest_addr_le.
> > > > See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
> > > > and fixes on top of that for an example.      
> > > 
> > > Hmm... If I understood such change well, vmstate_ghes_state() will
> > > use this structure as basis to do migration:
> > > 
> > > 	/* ghes.h */
> > > 	typedef struct AcpiGhesState {
> > > 	    uint64_t hest_addr_le;
> > > 	    uint64_t ghes_addr_le;
> > > 	    bool present; /* True if GHES is present at all on this board */
> > > 	} AcpiGhesState;
> > > 
> > > 	/* generic_event_device.c */
> > > 	static const VMStateDescription vmstate_ghes_state = {
> > > 	    .name = "acpi-ged/ghes",
> > > 	    .version_id = 1,
> > > 	    .minimum_version_id = 1,
> > > 	    .needed = ghes_needed,
> > > 	    .fields      = (VMStateField[]) {
> > > 	        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> > > 	                       vmstate_ghes_state, AcpiGhesState),
> > > 	        VMSTATE_END_OF_LIST()
> > > 	    }
> > > 	};    
> > 
> > current code looks like that:
> >                                                                                  
> > static const VMStateDescription vmstate_ghes = {                                 
> >     .name = "acpi-ghes",                                                         
> >     .version_id = 1,                                                             
> >     .minimum_version_id = 1,                                                     
> >     .fields = (const VMStateField[]) {                                           
> >         VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),   <<===                         
> >         VMSTATE_END_OF_LIST()                                                    
> >     },                                                                           
> > };                                                                               
> >                                                                                  
> > static bool ghes_needed(void *opaque)                                            
> > {                                                                                
> >     AcpiGedState *s = opaque;                                                    
> >     return s->ghes_state.ghes_addr_le;                                           
> > }                                                                                
> >                                                                                  
> > static const VMStateDescription vmstate_ghes_state = {                           
> >     .name = "acpi-ged/ghes",                                                     
> >     .version_id = 1,                                                             
> >     .minimum_version_id = 1,                                                     
> >     .needed = ghes_needed,                                                       
> >     .fields = (const VMStateField[]) {                                           
> >         VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,                              
> >                        vmstate_ghes, AcpiGhesState),                             
> >         VMSTATE_END_OF_LIST()                                                    
> >     }                                                                            
> > };  
> > 
> > where 
> >     VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > explicitly defines field(s) within structure to be sent over wire.
> > 
> > we need to add a conditional field for ghes_addr_le
> > which will be sent only with new machine types, but not with old ones
> > to avoid migration breakage.
> > 
> > I don't know much about migration, but maybe we can get away with
> > similar condition as in ghes_needed(), or enabling QMP error injection
> > based on machine type version.
> > 
> > Or maybe adding a CLI option to enable QMP error injection in which
> > case the explicit option would serve as a trigger enable QMP command and
> > to migrate hest_addr_le.
> > It might be even better this way, since machine wouldn't need to
> > carry extra error source that will be used only for testing
> > and practically never in production VMs (aka reduced attack surface).
> > 
> > You can easily test it locally:
> >   new-qemu: with your patches
> >   old-qemu: qemu-9.1
> > 
> > and then try to do forth & back migration for following cases:
> >   1. (ping-pong case with OLD firmware/ACPI tables)
> >      start old-qemu with 9.1 machine type ->
> >        migrate to file ->
> >        start new-qemu with 9.1 machine type -> restore from file ->
> >        migrate to file ->  
> 
> As I never used migration, I'm a little stuck with the command line
> parameters.
> 
> I guess I got the one to do the migration at the monitor:
> 
> 	(qemu) migrate file://tmp/migrate
> 
> But no idea how to start a machine using a saved state.

see https://www.linux-kvm.org/page/Migration
'savevm/loadvm to an external state file (using pseudo-migration)' section

> 
> >        start old-qemu with 9.1 machine type ->restore from file ->
> >        
> >   2.  (ping-pong case with NEW firmware/ACPI tables)
> >       do the same as #1 but starting with new-qemu binary
> > 
> > (from upstream pov #2 is optional, but not implementing it
> > is pain for downstream so it's better to have it if it's not
> > too much work)  
> 
> If I understood the migration documentation, every when new fields
> are added, we should increment .version_id. If new version is
> not backward-compatible, .minimum_version_id is also incremented.
> 
> So, for a migration-compatible code with a 9.1 VM, the code needs to
> handle the case where hest_addr_le is not defined, e. g. use offsets
> relative to ghes_addr_le, just like the current version, e.g.:
> 
>     uint64_t cper_addr, read_ack_start_addr;
> 
>     AcpiGedState *acpi_ged_state =
>         ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
>     AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> 
>     if (!ags->hest_addr_le) {
>         // Backward-compatible migration code
>         uint64_t base = le64_to_cpu(ags->ghes_addr_le);
> 
>         *read_ack_start_addr = base +
>             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>             error_source_to_index[notify] * sizeof(uint64_t);
> 
>         *cper_addr = base +
>             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
>             error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
>    } else {
>         // Use the new logic from ags->hest_addr_le
>    }
> 
> There are two problems with that:
> 
> 1. On your reviews, if I understood right, the code above is not
>    migration safe. So, while implementing it would be technically
>    correct, migration still won't work;
> 
> 2. With the new code, ACPI_GHES_ERROR_SOURCE_COUNT is not
>    defined anymore, as the size of the error source structure can
>    be different on different architectures, being 2 for new
>    VMs and 1 for old ones.
> 
>    Basically the new code gets it right because it can see a
>    pointer to the HEST table, so it can get the number from there:
> 
> 	hest_addr = le64_to_cpu(ags->hest_addr_le);
> 	cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
> 
>    But, without hest_addr_le, getting num_sources is not possible.
> 
>    An alternative would be to add a hacky code that works only for
>    arm machines (as new versions may support more archs).
> 
>    Something like:
> 	#define V1_ARM_ACPI_GHES_ERROR_SOURCE_COUNT 1
> 	#define V2_ARM_ACPI_GHES_ERROR_SOURCE_COUNT 2
> 
>    And have a hardcoded logic that would work before/after this
>    changeset but may break on newer versions, if the number of
>    source IDs change, if we add other HEST types, etc.
> 
>    Now, assuming that such hack would work, it sounds too hacky to 
>    my taste.
> 
> So, IMO it is a lot safer to not support migrations from v1 (only
> ghes_addr_le), using a patch like the enclosed one to ensure that.
> 
> Btw, checking existing migration structs, it sounds that for almost all
> structures, .version_id is identical to .minimum_version_id, meaning that
> migration between different versions aren't supported on most cases.

let me try to find more examples on how to implement migration bits
hopefully more comprehensible. 

> 
> Thanks,
> Mauro
> 
> ---
> 
> [PATCH] acpi/generic_event_device: Update GHES migration to cover hest addr
> 
> The GHES migration logic at GED should now support HEST table
> location too.
> 
> Increase migration version and change needed to check for both
> ghes_addr_le and hest_addr_le.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index b4c83a089a02..efae0ff62c7b 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -351,10 +351,11 @@ static const VMStateDescription vmstate_ged_state = {
>  
>  static const VMStateDescription vmstate_ghes = {
>      .name = "acpi-ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -362,13 +363,13 @@ static const VMStateDescription vmstate_ghes = {
>  static bool ghes_needed(void *opaque)
>  {
>      AcpiGedState *s = opaque;
> -    return s->ghes_state.ghes_addr_le;
> +    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
>  }
>  
>  static const VMStateDescription vmstate_ghes_state = {
>      .name = "acpi-ged/ghes",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .needed = ghes_needed,
>      .fields = (const VMStateField[]) {
>          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> 
> 



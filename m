Return-Path: <linux-kernel+bounces-328251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCC978110
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CD6B23F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EA1DA630;
	Fri, 13 Sep 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTYMUUBt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E51E892
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233925; cv=none; b=vEnJF8mDJ0YcpkB+qK1bivJ9AGBRvMZIr9LGZUPejWUGFEm/oBVzJhFecmvVu44pgYpFAaWFFUAp50BK2f+Fa2AegO3UgFP+ETUdkVnoLnnMkk7aSeVQ41fRB/lEo6js+r3PDQRKtzugHiysKpxPzvjGewXG/XaZ9up/B1ZYURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233925; c=relaxed/simple;
	bh=Exl13x9XkciuAqStFfOqJeI0seOnAaEtkdjxyIhREjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzSRfvOA+BUf6Lx4XIKlTjIATxTjxHLBjRy/qUU6c3TfgC6thAPCzfABkxt1CXiDdozLEuL34Y+zf+VBqXLIS6gz86YTUsSokLRLIFA/Bu/hzFOG+RlDFf0UI6ThQyL86Q/b7MYUZlYHrcSJu5feNUmc7wzEl0qckgci5DCWSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTYMUUBt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726233922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NPe0SUBJEdHvLb4sF5N4GC0rJ9nP/aoSGOggzvDbl8g=;
	b=MTYMUUBt8gTdtBLWs4ZyQoJNurPBbJJ+vcheT04PbZpLjvJi2lVxPjWOUE7HHGyiDQzd4a
	2Y+CCVNSipDzOCpXF0A4MPE45XZ/CbEh8ZG8uGL7zfAlOIXaXfi51Vx+nnonqPX+ELfzw9
	2rmUxlpX8mmC7yY0aFSLkOJGYNQS+Ik=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-6oGCK3ckOvaPSZKpTuHF7Q-1; Fri, 13 Sep 2024 09:25:21 -0400
X-MC-Unique: 6oGCK3ckOvaPSZKpTuHF7Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42ca8037d9aso6813395e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233920; x=1726838720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPe0SUBJEdHvLb4sF5N4GC0rJ9nP/aoSGOggzvDbl8g=;
        b=mbNerIkWYLiLU2V/sXo4pu4OrQ0fE1CqU86vvVIHr4cKR0jygHCaxJxrg4Px824HUj
         RHe8f1S6kpLLBmqWEtDAECl1G7CfvWXUrH/SKjvCy8tWqOVd70RcvVwhUiu6Y/YT19aI
         2Vbksc5Wo/tdweu7xgqGlzSH8PR2OFEER4i8R4KXnbnrEQ5y5k/5fT8zA7XwacVH3m2u
         BTSLBCO6hRIRPjo5fGd5NIcPqytK9SdM27ja/m0rT+PrK/yd/m238Wg1aNu9dDZ970qx
         mV4ob5BHhiI9cdXTK0Cc+dSv1vF9uRVkGCw9aqYRzK7urKEwgtYQ21VxfQ6wQwqNSWek
         xiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXLh/7Xxqm5zSycnUmrDSY9/a05geMMqSt2YuLdQXD4qo05DZngyD9pn3cA+BL2Ow8esuObP9buxk5cAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+ITRno56C6s1sNdK5QyTV3pOsmIJ58UG1ODH2Ig+yzXRiQTd
	Gnw56tbtZTbn0syXx8V8NL41CwasorU4T7p+83hoheGY9jiFVqLyzxywXMMquBwC2WL0eIcAPK5
	cjOzCxszTR3B24YawL6EI+P28JclPrCCFDrvh11J2Hl0LcW/j6GciPyy2rVPI/A==
X-Received: by 2002:a5d:4cc6:0:b0:368:5a8c:580b with SMTP id ffacd0b85a97d-378d61e2b19mr1816919f8f.19.1726233919946;
        Fri, 13 Sep 2024 06:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0CWqp6VUNlYFtn66EgOGFI6WMHtPVYF+6fIDqre+6lLpa6ilT1SI2rwIcw8Qy8bM+8GJkNg==
X-Received: by 2002:a5d:4cc6:0:b0:368:5a8c:580b with SMTP id ffacd0b85a97d-378d61e2b19mr1816895f8f.19.1726233919319;
        Fri, 13 Sep 2024 06:25:19 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d35e5sm17032360f8f.76.2024.09.13.06.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:25:18 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:25:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240913074435.0eea2552@foz.lan>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
	<20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
	<20240913074435.0eea2552@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 07:44:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 11 Sep 2024 15:51:08 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Sun, 25 Aug 2024 05:45:56 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Store HEST table address at GPA, placing its content at
> > > hest_addr_le variable.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > 
> > This looks good to me.
> > 
> > in addition to this, it needs a patch on top to make sure
> > that we migrate hest_addr_le.
> > See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
> > and fixes on top of that for an example.  
> 
> Hmm... If I understood such change well, vmstate_ghes_state() will
> use this structure as basis to do migration:
> 
> 	/* ghes.h */
> 	typedef struct AcpiGhesState {
> 	    uint64_t hest_addr_le;
> 	    uint64_t ghes_addr_le;
> 	    bool present; /* True if GHES is present at all on this board */
> 	} AcpiGhesState;
> 
> 	/* generic_event_device.c */
> 	static const VMStateDescription vmstate_ghes_state = {
> 	    .name = "acpi-ged/ghes",
> 	    .version_id = 1,
> 	    .minimum_version_id = 1,
> 	    .needed = ghes_needed,
> 	    .fields      = (VMStateField[]) {
> 	        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> 	                       vmstate_ghes_state, AcpiGhesState),
> 	        VMSTATE_END_OF_LIST()
> 	    }
> 	};

current code looks like that:
                                                                                 
static const VMStateDescription vmstate_ghes = {                                 
    .name = "acpi-ghes",                                                         
    .version_id = 1,                                                             
    .minimum_version_id = 1,                                                     
    .fields = (const VMStateField[]) {                                           
        VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),   <<===                         
        VMSTATE_END_OF_LIST()                                                    
    },                                                                           
};                                                                               
                                                                                 
static bool ghes_needed(void *opaque)                                            
{                                                                                
    AcpiGedState *s = opaque;                                                    
    return s->ghes_state.ghes_addr_le;                                           
}                                                                                
                                                                                 
static const VMStateDescription vmstate_ghes_state = {                           
    .name = "acpi-ged/ghes",                                                     
    .version_id = 1,                                                             
    .minimum_version_id = 1,                                                     
    .needed = ghes_needed,                                                       
    .fields = (const VMStateField[]) {                                           
        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,                              
                       vmstate_ghes, AcpiGhesState),                             
        VMSTATE_END_OF_LIST()                                                    
    }                                                                            
};  

where 
    VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
explicitly defines field(s) within structure to be sent over wire.

we need to add a conditional field for ghes_addr_le
which will be sent only with new machine types, but not with old ones
to avoid migration breakage.

I don't know much about migration, but maybe we can get away with
similar condition as in ghes_needed(), or enabling QMP error injection
based on machine type version.

Or maybe adding a CLI option to enable QMP error injection in which
case the explicit option would serve as a trigger enable QMP command and
to migrate hest_addr_le.
It might be even better this way, since machine wouldn't need to
carry extra error source that will be used only for testing
and practically never in production VMs (aka reduced attack surface).

You can easily test it locally:
  new-qemu: with your patches
  old-qemu: qemu-9.1

and then try to do forth & back migration for following cases:
  1. (ping-pong case with OLD firmware/ACPI tables)
     start old-qemu with 9.1 machine type ->
       migrate to file ->
       start new-qemu with 9.1 machine type -> restore from file ->
       migrate to file ->
       start old-qemu with 9.1 machine type ->restore from file ->
       
  2.  (ping-pong case with NEW firmware/ACPI tables)
      do the same as #1 but starting with new-qemu binary

(from upstream pov #2 is optional, but not implementing it
is pain for downstream so it's better to have it if it's not
too much work)

> 	/* hw/arm/virt-acpi-build.c */
> 	void virt_acpi_setup(VirtMachineState *vms)
> 	{
> 	    ...
> 	    if (vms->ras) {
> 	        assert(vms->acpi_dev);
> 	        acpi_ged_state = ACPI_GED(vms->acpi_dev);
> 	        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
> 	                             vms->fw_cfg, tables.hardware_errors);
> 	    }
> 
> Which relies on acpi_ghes_add_fw_cfg() function to setup callbacks for
> the migration:
> 
> 	/* ghes.c */
> 	void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> 	                          GArray *hardware_error)
> 	{
> 	    /* Create a read-only fw_cfg file for GHES */
> 	    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
> 	                    hardware_error->len);
> 
> 	    /* Create a read-write fw_cfg file for Address */
> 	    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
> 
> 	    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> 	        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> 
> 	    ags->present = true;
> 	}
> 
> It sounds to me that both ghes_addr_le and hest_addr_le will be migrated
> altogether.

fwcfg callbacks are irrelevant to migration, they tell firmware what to do
with specified addresses (in our case, write into ags->hest_addr_le address
of HEST), so that HW (qemu) would know where firmware placed the table.
But that's about all it does.

> 
> Did I miss something?
> 
> Thanks,
> Mauro
> 



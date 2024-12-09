Return-Path: <linux-kernel+bounces-437067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF79E8EB3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1D1883D04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5665B1EB3D;
	Mon,  9 Dec 2024 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR81/dmv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252D2144D4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736476; cv=none; b=GGSWr+EUbLbHHS9FgxSrY5urYo2iVq+vxaQpEuqKLxhxaqVXvYEcbAUJEcktvSi5C98XUHwoVgpjoPy9kX3BPuOPEyhIGrzH2sR+EAWMunsSsVw7yMAIOB06bo71mlOpKxONmDTp/amvTrTo+AlnjF7C1ghXLDvlGImcxVRvqBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736476; c=relaxed/simple;
	bh=dzYUBItc4irdACdEPJd49K0RlN9o6WNX96pXvrHVGak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0tzaD8yptPTZzSMTT+DXtmQa8uTsi252joh1nLfNBoEml9YvCH8gOaTGriE52L/yGpGT1tDWbc+md7i69pwUv21pXz3Q0HN0WYbnkZd9o3XOSQPcn/Locd3+8fz6CVPfD+SRh3DMCY+xvqEuEJO+EwEeWUqRS4YaZAGWK0Ij1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR81/dmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0977FC4CED1;
	Mon,  9 Dec 2024 09:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733736476;
	bh=dzYUBItc4irdACdEPJd49K0RlN9o6WNX96pXvrHVGak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RR81/dmv+dBfwl8aSlkPenAiQgPdAO67pgFqilnYYneyuLTq3oJ8UbEuD6vUGtiKA
	 ZwQa4einWUMG9dVddbKqKN3qwnaEO/Wn5OP24JfMV7+6kK0TCCXvJ6rJ1QCGEfu7Ul
	 l2QBCZLJvuSDV2ifF4NAmm9eEcT3AqbV9Qi04A9FwhI7+dYQHG+zNLqXB+MlMOUSE9
	 ynV8Q658MAEdzsqdat5gFx9v4QYaLJavhlaPcEDTR1flaSi5dr5s2skfUyng6841YV
	 IisT2N+F/S3pwx3jF3lpBAsmNpGa7+P7G2xlhH1ILPXKWZ7mbXsB7eR1Ju10uits/+
	 OMI2VAnCsKWpw==
Date: Mon, 9 Dec 2024 10:27:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 13/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241209102750.03bc6ec5@foz.lan>
In-Reply-To: <20241204102413.31c8d76d@imammedo.users.ipa.redhat.com>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
	<e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org>
	<20241203125143.7171892a@imammedo.users.ipa.redhat.com>
	<20241203144730.47b8ca86@foz.lan>
	<20241204085440.4640a476@imammedo.users.ipa.redhat.com>
	<20241204095635.512a44d5@foz.lan>
	<20241204102413.31c8d76d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 4 Dec 2024 10:24:13 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 4 Dec 2024 09:56:35 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Wed, 4 Dec 2024 08:54:40 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Tue, 3 Dec 2024 14:47:30 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Em Tue, 3 Dec 2024 12:51:43 +0100
> > > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > > >       
> > > > > On Fri, 22 Nov 2024 10:11:30 +0100
> > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > > >         

...

> > > > > > +static void get_hw_error_offsets(uint64_t ghes_addr,
> > > > > > +                                 uint64_t *cper_addr,
> > > > > > +                                 uint64_t *read_ack_register_addr)
> > > > > > +{          
> > > > > 
> > > > >         
> > > > > > +    if (!ghes_addr) {
> > > > > > +        return;
> > > > > > +    }          
> > > > > 
> > > > > why do we need this check?        
> > > > 
> > > > It is a safeguard measure to avoid crashes and OOM access. If fw_cfg 
> > > > callback doesn't fill it properly, this will be zero.      
> > > 
> > > shouldn't happen, but yeah it firmware job to write back addr
> > > which might happen for whatever reason (a bug for example).
> > >    
> > 
> > The main reason I added it is that, after the second series, it could 
> > also happen if there's something wrong with the backward compat logic.
> > 
> > So, both here and after switching to HEST-based offsets, I opted
> > to explicitly test.
> >   
> > > Perhaps push this up to the stack, so we don't have to deal
> > > with scattered checks in ghes code.
> > > 
> > > kvm_arch_on_sigbus_vcpu() looks like a goo candidate for check
> > > and warn_once if that ever happens.
> > > It already calls acpi_ghes_present() which resolves GED device
> > > and then later we duplicate this job in ghes_record_cper_errors()
> > > 
> > > so maybe rename acpi_ghes_present to something like AcpiGhesState* acpi_ghes_get_state()
> > > and call it instead. And then move ghes_addr check/warn_once there.
> > > This way the rest of ghes code won't have to deal handling practically
> > > impossible error conditions that cause reader to wonder why it might happen.    
> > 
> > I'll look on it.

Wrote the cleanup patch. See enclosed. I'll place it at the end of the
second series.

> > Yet, if ok for you, I would prefer dealing with this
> > once we have a bigger picture, e.g. once we merge those tree series:
> > 
> > 	- cleanup series (this one);
> > 	- HEST offset (I'll be sending a new version today);  
> ok, lets revisit this point after this series.
> Since at this point we should have a clean picture of how new code
> works.

 
Thanks,
Mauro

[PATCH] acpi/ghes: Cleanup the code which gets ghes ged state

Move the check logic into a common function and simplify the
code which checks if GHES is enabled and was properly setup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index 7cec1812dad9..fbabf955155a 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -16,7 +16,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     return -1;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
-    return false;
+    return NULL;
 }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index a9c5315c1936..17aada9ee352 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -420,10 +420,6 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
                                  uint64_t *cper_addr,
                                  uint64_t *read_ack_register_addr)
 {
-    if (!ghes_addr) {
-        return;
-    }
-
     /*
      * non-HEST version supports only one source, so no need to change
      * the start offset based on the source ID. Also, we can't validate
@@ -451,10 +447,6 @@ static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
     uint64_t err_source_struct, error_block_addr;
     uint32_t num_sources, i;
 
-    if (!hest_addr) {
-        return;
-    }
-
     cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
     num_sources = le32_to_cpu(num_sources);
 
@@ -513,7 +505,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp)
 {
     uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
-    AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
 
     if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
@@ -521,13 +512,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
         return;
     }
 
-    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
-                                                       NULL));
-    if (!acpi_ged_state) {
-        error_setg(errp, "Can't find ACPI_GED object");
+    ags = acpi_ghes_get_state();
+    if (!ags) {
         return;
     }
-    ags = &acpi_ged_state->ghes_state;
 
     if (!ags->hest_lookup) {
         get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
@@ -537,11 +525,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                                 &cper_addr, &read_ack_register_addr, errp);
     }
 
-    if (!cper_addr) {
-        error_setg(errp, "can not find Generic Error Status Block");
-        return;
-    }
-
     cpu_physical_memory_read(read_ack_register_addr,
                              &read_ack_register, sizeof(read_ack_register));
 
@@ -606,7 +589,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
     return 0;
 }
 
-bool acpi_ghes_present(void)
+AcpiGhesState *acpi_ghes_get_state(void)
 {
     AcpiGedState *acpi_ged_state;
     AcpiGhesState *ags;
@@ -615,8 +598,14 @@ bool acpi_ghes_present(void)
                                                        NULL));
 
     if (!acpi_ged_state) {
-        return false;
+        return NULL;
     }
     ags = &acpi_ged_state->ghes_state;
-    return ags->present;
+    if (!ags->present) {
+        return NULL;
+    }
+    if (!ags->hw_error_le && !ags->hest_addr_le) {
+        return NULL;
+    }
+    return ags;
 }
diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 2e8405edfe27..64fe2b5bea65 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -91,10 +91,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
                              uint16_t source_id, Error **errp);
 
 /**
- * acpi_ghes_present: Report whether ACPI GHES table is present
+ * acpi_ghes_get_state: Get a pointer for ACPI ghes state
  *
- * Returns: true if the system has an ACPI GHES table and it is
- * safe to call acpi_ghes_memory_errors() to record a memory error.
+ * Returns: a pointer to ghes state if the system has an ACPI GHES table,
+ * it is enabled and it is safe to call acpi_ghes_memory_errors() to record
+ * a memory error. Returns false, otherwise.
  */
-bool acpi_ghes_present(void);
+AcpiGhesState *acpi_ghes_get_state(void);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4260467f8b9..7802c32fb7e0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2369,7 +2369,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
-    if (acpi_ghes_present() && addr) {
+    if (acpi_ghes_get_state() && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {


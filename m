Return-Path: <linux-kernel+bounces-329144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7089A978E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A338B1F2439E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A082C184;
	Sat, 14 Sep 2024 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su4Y9vGE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB517996
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 05:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726292000; cv=none; b=qgqM+Qs6kLSlQvP5wg4VoTr4f5izUw5ZysJNxXaXoQMc+8iLGoqqMV4UFS8xRSBtnBylHjm6WFNpsFN+p8tPiMh603DJmyslIwYyvHiuWlVCmM6q3ThD5Vn+kyw27XCYKfzZtzQjPp1J52H1iWz7rm/ZbFMSisg//x92D2Tryeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726292000; c=relaxed/simple;
	bh=CFNEyhLfApEzvLmDlCEmRoURoMpdLlzz/GQmI4jYQJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsO+FfjOO1xfL08ofZjl7wAphYaxlq3G2Tmrga8A2rUkhg3xE2bjzo7R0ZZV5J+hrs25BMJICZSNUtpdn42B3sPYFnDex9Rx2gJeIeC0a+/WzOZvUf1rDSSAT7l53G/NUO8ofKXWHb1MxzblDlEdfdwJKCqVDDdSLrEVKjbeYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su4Y9vGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11442C4CEC0;
	Sat, 14 Sep 2024 05:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726291999;
	bh=CFNEyhLfApEzvLmDlCEmRoURoMpdLlzz/GQmI4jYQJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=su4Y9vGECKrjyou0Wd1VKAgfOszfxjwbUg0Ew4CJBknX32D4YJGc34oWgjoaEAERO
	 Snd2A4dVbUraP7++Q9xJTEfAd456zkmSLzKPVdSBAHYaZ80p3sEi+QeBi+BeHJogt8
	 JWz4kxlOjJ7YnJWK2xCpdFj1Lkj0T+9KnSHWqM6fbVWMEnncyYneQ+SmeymSOuNM9Z
	 x9Wt8dCPvj1BlfBkyriDAmfoQyQodHup/M8GPXt9HKGCeD0tYpUiWLMFLU4AApdFgn
	 uLnDxYPpcvp442kBN0brpOixGhmiGsMs0VaPw/Df9viaciPGbcqYujGLrG+YsIo3yv
	 pUia0dlvTPY2A==
Date: Sat, 14 Sep 2024 07:33:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20240914073314.46368ff6@foz.lan>
In-Reply-To: <20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
	<20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
	<20240913074435.0eea2552@foz.lan>
	<20240913152518.2f80ab1e@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Igor,

Em Fri, 13 Sep 2024 15:25:18 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > > in addition to this, it needs a patch on top to make sure
> > > that we migrate hest_addr_le.
> > > See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
> > > and fixes on top of that for an example.    
> > 
> > Hmm... If I understood such change well, vmstate_ghes_state() will
> > use this structure as basis to do migration:
> > 
> > 	/* ghes.h */
> > 	typedef struct AcpiGhesState {
> > 	    uint64_t hest_addr_le;
> > 	    uint64_t ghes_addr_le;
> > 	    bool present; /* True if GHES is present at all on this board */
> > 	} AcpiGhesState;
> > 
> > 	/* generic_event_device.c */
> > 	static const VMStateDescription vmstate_ghes_state = {
> > 	    .name = "acpi-ged/ghes",
> > 	    .version_id = 1,
> > 	    .minimum_version_id = 1,
> > 	    .needed = ghes_needed,
> > 	    .fields      = (VMStateField[]) {
> > 	        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> > 	                       vmstate_ghes_state, AcpiGhesState),
> > 	        VMSTATE_END_OF_LIST()
> > 	    }
> > 	};  
> 
> current code looks like that:
>                                                                                  
> static const VMStateDescription vmstate_ghes = {                                 
>     .name = "acpi-ghes",                                                         
>     .version_id = 1,                                                             
>     .minimum_version_id = 1,                                                     
>     .fields = (const VMStateField[]) {                                           
>         VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),   <<===                         
>         VMSTATE_END_OF_LIST()                                                    
>     },                                                                           
> };                                                                               
>                                                                                  
> static bool ghes_needed(void *opaque)                                            
> {                                                                                
>     AcpiGedState *s = opaque;                                                    
>     return s->ghes_state.ghes_addr_le;                                           
> }                                                                                
>                                                                                  
> static const VMStateDescription vmstate_ghes_state = {                           
>     .name = "acpi-ged/ghes",                                                     
>     .version_id = 1,                                                             
>     .minimum_version_id = 1,                                                     
>     .needed = ghes_needed,                                                       
>     .fields = (const VMStateField[]) {                                           
>         VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,                              
>                        vmstate_ghes, AcpiGhesState),                             
>         VMSTATE_END_OF_LIST()                                                    
>     }                                                                            
> };  
> 
> where 
>     VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> explicitly defines field(s) within structure to be sent over wire.
> 
> we need to add a conditional field for ghes_addr_le
> which will be sent only with new machine types, but not with old ones
> to avoid migration breakage.
> 
> I don't know much about migration, but maybe we can get away with
> similar condition as in ghes_needed(), or enabling QMP error injection
> based on machine type version.
> 
> Or maybe adding a CLI option to enable QMP error injection in which
> case the explicit option would serve as a trigger enable QMP command and
> to migrate hest_addr_le.
> It might be even better this way, since machine wouldn't need to
> carry extra error source that will be used only for testing
> and practically never in production VMs (aka reduced attack surface).
> 
> You can easily test it locally:
>   new-qemu: with your patches
>   old-qemu: qemu-9.1
> 
> and then try to do forth & back migration for following cases:
>   1. (ping-pong case with OLD firmware/ACPI tables)
>      start old-qemu with 9.1 machine type ->
>        migrate to file ->
>        start new-qemu with 9.1 machine type -> restore from file ->
>        migrate to file ->

As I never used migration, I'm a little stuck with the command line
parameters.

I guess I got the one to do the migration at the monitor:

	(qemu) migrate file://tmp/migrate

But no idea how to start a machine using a saved state.

>        start old-qemu with 9.1 machine type ->restore from file ->
>        
>   2.  (ping-pong case with NEW firmware/ACPI tables)
>       do the same as #1 but starting with new-qemu binary
> 
> (from upstream pov #2 is optional, but not implementing it
> is pain for downstream so it's better to have it if it's not
> too much work)

If I understood the migration documentation, every when new fields
are added, we should increment .version_id. If new version is
not backward-compatible, .minimum_version_id is also incremented.

So, for a migration-compatible code with a 9.1 VM, the code needs to
handle the case where hest_addr_le is not defined, e. g. use offsets
relative to ghes_addr_le, just like the current version, e.g.:

    uint64_t cper_addr, read_ack_start_addr;

    AcpiGedState *acpi_ged_state =
        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
    AcpiGhesState *ags = &acpi_ged_state->ghes_state;

    if (!ags->hest_addr_le) {
        // Backward-compatible migration code
        uint64_t base = le64_to_cpu(ags->ghes_addr_le);

        *read_ack_start_addr = base +
            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
            error_source_to_index[notify] * sizeof(uint64_t);

        *cper_addr = base +
            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
            error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
   } else {
        // Use the new logic from ags->hest_addr_le
   }

There are two problems with that:

1. On your reviews, if I understood right, the code above is not
   migration safe. So, while implementing it would be technically
   correct, migration still won't work;

2. With the new code, ACPI_GHES_ERROR_SOURCE_COUNT is not
   defined anymore, as the size of the error source structure can
   be different on different architectures, being 2 for new
   VMs and 1 for old ones.

   Basically the new code gets it right because it can see a
   pointer to the HEST table, so it can get the number from there:

	hest_addr = le64_to_cpu(ags->hest_addr_le);
	cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));

   But, without hest_addr_le, getting num_sources is not possible.

   An alternative would be to add a hacky code that works only for
   arm machines (as new versions may support more archs).

   Something like:
	#define V1_ARM_ACPI_GHES_ERROR_SOURCE_COUNT 1
	#define V2_ARM_ACPI_GHES_ERROR_SOURCE_COUNT 2

   And have a hardcoded logic that would work before/after this
   changeset but may break on newer versions, if the number of
   source IDs change, if we add other HEST types, etc.

   Now, assuming that such hack would work, it sounds too hacky to 
   my taste.

So, IMO it is a lot safer to not support migrations from v1 (only
ghes_addr_le), using a patch like the enclosed one to ensure that.

Btw, checking existing migration structs, it sounds that for almost all
structures, .version_id is identical to .minimum_version_id, meaning that
migration between different versions aren't supported on most cases.

Thanks,
Mauro

---

[PATCH] acpi/generic_event_device: Update GHES migration to cover hest addr

The GHES migration logic at GED should now support HEST table
location too.

Increase migration version and change needed to check for both
ghes_addr_le and hest_addr_le.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index b4c83a089a02..efae0ff62c7b 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -351,10 +351,11 @@ static const VMStateDescription vmstate_ged_state = {
 
 static const VMStateDescription vmstate_ghes = {
     .name = "acpi-ghes",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
+        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -362,13 +363,13 @@ static const VMStateDescription vmstate_ghes = {
 static bool ghes_needed(void *opaque)
 {
     AcpiGedState *s = opaque;
-    return s->ghes_state.ghes_addr_le;
+    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
 }
 
 static const VMStateDescription vmstate_ghes_state = {
     .name = "acpi-ged/ghes",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = ghes_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,




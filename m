Return-Path: <linux-kernel+bounces-338223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48919985505
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC58B1F21011
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F195157487;
	Wed, 25 Sep 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ6IjScG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A0148849
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251487; cv=none; b=WQyyoVSI9oMRfuUhxKXazWnWrHwhM+c4rGBzlModhMOfrGBdVz4gUu7GryADhyUf7NEdq7QAfiJSebxNoVJcpdwekxdDoX7biTv4YkSjiVc58XWIMIALq9gVwbEpm8AAac5hsxiKHfGNyFkAwyLpHdjENgcK21ysDQr5158Pr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251487; c=relaxed/simple;
	bh=XtTR+0xNDM4kXU9yTQYoYa57KB86//G17A4RfWnZ188=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc5KaMMiCZmaSZJa7vtqo9s9uW0liJYX0sAl5+Q2uy2SQrpEwZudv4biC7EGZrIjG3pWwTWDkorEvIcnSn87w8dsqco3bxUArlOgO5RWLmJtSJj9UDCoNN/sU3J1BVwLXILyAjxFhMSKrsL+qyaI2G+fkcy3TWph9bic0RTYMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ6IjScG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1118BC4CEC3;
	Wed, 25 Sep 2024 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727251486;
	bh=XtTR+0xNDM4kXU9yTQYoYa57KB86//G17A4RfWnZ188=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJ6IjScG7UBcmzhhkAjyhX58+TQg5ouqzFWdHJeruf/9Y5ar3O03lMTj7HdFP+Z/x
	 hbkUsB3ConnnjJJbGTz6jtmMlfbp9d/xlesXJat702M9qOAJVf5FfetDf/A914IH+E
	 zatJDvh5I5iudsMbgzq9JOwvuEZ6Sdf83oF98NzLsFKMTJNBqAQA0YToWTynQ2oxng
	 DEr7eZMxCa1wiOcv+U4b731Fy6MFRcPLldDrsgHXiuYineQqIXEpEgQPBxaABI4jW/
	 hoF+QRRen6qZJswZhV0J/Y9RlcXEPDmmH5vOSzMG2TKBVC2c+DRWLCccgZlE23eZDw
	 +oomspFu6VsyQ==
Date: Wed, 25 Sep 2024 10:04:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <20240925100441.229790ba@foz.lan>
In-Reply-To: <ZumetxyRro8RfC8h@x1n>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
	<bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
	<20240917111921.7e95726b@imammedo.users.ipa.redhat.com>
	<ZumetxyRro8RfC8h@x1n>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 17 Sep 2024 11:22:31 -0400
Peter Xu <peterx@redhat.com> escreveu:

> On Tue, Sep 17, 2024 at 11:19:21AM +0200, Igor Mammedov wrote:
> > On Sat, 14 Sep 2024 08:13:23 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   

> > what I would do:
> >   add ghes_needed_v2(): return  s->ghes_state.hest_addr_le;
> > 
> > and then instead of reusing vmstate_ghes_state would add new
> > vmstate_ghes_v2_state subsection that migrates only 
> >   VMSTATE_UINT64(hest_addr_le, AcpiGhesState)
> > field.
> > 
> > btw: we probably don't need ghes_addr_le for new code that
> > uses HEST to lookup relevant error status block.
> > but we should still keep it for 9.1 and older machine types
> > as they expect/use it. Separate subsections would work with
> > this req just fine.  

Ok, so, if I understood it right, the enclosed patch should do the
job, right?

> Right, if we need bi-directional migration we need above and a compat
> property (or VMSTATE_UINT64_TEST() would work too, iiuc).
> 
> OTOH VMSD versioning only works for forward migration, not backward.

I don't think bi-directional migration would work. See, with
old version, we have:

- Just one Error source block structure, only for ARMv8 using synchronous
  notification (SEA).
- The offsets to access the error block structure and the memory
  position where the OSPM will acknowledge the error assumes a single
  error source;
- such offsets come from ghes_addr_le bios pointer (we will rename it to
  hw_addr_le at the cleanup patch series).

With the new versions, we'll have:

- at least two notification sources on ARMv8 (SEA and GPIO). We may
  end adding more with time;
- other architectures may also have support for bios-first hardware
  errors;
- the number of error block structures is now read from HEST table
  (so it needs that hest_addr_le will be stored at AcpiGedState;
- the offsets to retrieve the addresses are now relative to the offset
  at hest_addr_le.

The new error injection code, which uses either hest_addr_le or
ghes_addr_le (now hw_addr_le) should be able to properly generate
errors from a VM created on 9.1, as it will check if hest_addr_le
is not zero. If it is zero, it will call a backward-compatible
code:

    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                       NULL));
    if (!acpi_ged_state) {
        error_setg(errp, "Can't find ACPI_GED object");
        return;
    }
    ags = &acpi_ged_state->ghes_state;

    if (!ags->hest_addr_le) {
	/* Assumes just a single source_id */
        get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
                         &cper_addr, &read_ack_register_addr);
    } else {
	/* do a for at the HEST table seeking for an specific source_id */
        get_hest_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
                         &cper_addr, &read_ack_register_addr, errp);
    }

Now, a VM created with 9.2 will have multiple sources. The location of the
read_ack_register_addr depends on the number of sources, which can't be
retrieved without a VIOS pointer to the location of the HEST table
(e. g. ags->hest_addr_le).

So, a 9.1 QEMU with a VM created on 9.2 won't be doing the right thing
with regards to the vaule of the ack offset, thus with RAS errors not
working. I can't see any way to make it work.

> >   
> > >  static const VMStateDescription vmstate_ghes_state = {
> > >      .name = "acpi-ged/ghes",
> > > -    .version_id = 1,
> > > -    .minimum_version_id = 1,
> > > +    .version_id = 2,
> > > +    .minimum_version_id = 2,  
> 
> (and IIUC if we set min ver=2, even forward migration should fail.. better
>  test it with an old binary, migrating back and forth)
> 
> > >      .needed = ghes_needed,
> > >      .fields = (const VMStateField[]) {
> > >          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,  
> >   
> 
> Thanks,
> 

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
index c5acfb204e5f..bd996d01390c 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -377,6 +377,34 @@ static const VMStateDescription vmstate_ghes_state = {
     }
 };
 
+static const VMStateDescription vmstate_hest = {
+    .name = "acpi-ghes",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static bool hest_needed(void *opaque)
+{
+    AcpiGedState *s = opaque;
+    return s->ghes_state.hest_addr_le;
+}
+
+static const VMStateDescription vmstate_hest_state = {
+    .name = "acpi-ged/ghes",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hest_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
+                       vmstate_hest, AcpiGhesState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_acpi_ged = {
     .name = "acpi-ged",
     .version_id = 1,
@@ -388,6 +416,7 @@ static const VMStateDescription vmstate_acpi_ged = {
     .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
         &vmstate_ghes_state,
+        &vmstate_hest_state,
         NULL
     }
 };



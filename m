Return-Path: <linux-kernel+bounces-536178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFDCA47C72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1726D3A378B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F13C1624CE;
	Thu, 27 Feb 2025 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e11cxfxT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36366FB0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656743; cv=none; b=rQtcmdOyiWoWHeYTtJcU9U3czpqoxzxAwu5wfuHuXkOLH5El66XYQq4z01lnTaJL1AltGt5U0xerYD87lrUPyACPnPUTMpOHzjz/FWdu6trGtIDEWJRk9+zWm7WcFuspsfwkGEPShZJzCb3soyO059QE/oDJtnpkMRIqIlLOOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656743; c=relaxed/simple;
	bh=RbApozzYBuV1XvJ4VezhGxrAHX++zrZ0W8FPqStcTYw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aClfxBnAgy5H9/8d4TGKSNFNrDs+4JXxv5jTa0tToo8zZybQQ7AE6gCecbUN/yVeY4vIJgiZieXVj983KVIkMoldmaH4vUqr7VvXcwA9QMeD43icL8JzLCrbjERYOI+VWoS1wc2gMEgEnwUZVCK4hXioK4sVsWZlDRxRegVaMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e11cxfxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2270C4CEDD;
	Thu, 27 Feb 2025 11:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740656743;
	bh=RbApozzYBuV1XvJ4VezhGxrAHX++zrZ0W8FPqStcTYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e11cxfxTuj0kBUHpM7kvJNlAipl9h2iRj2UT7uCU9ruFW2Rs6bCYfNlyZt6vheCcI
	 DN4KpT3iXyxK/kjMHyQnkCF1+GJ3dzDZ6oj00cJdy3e0GcsxDXPwr0G6H9ICLFjE4G
	 OP8KMKsftjEjSEPS4a2AxfyNM0ca30+9e+xan4fj76tFiPKVM+FfNvPCF2Wtx/kvt+
	 MsK69+5xk8wYgoc4C7sdshO017fxp/GhXAYqMyTN3MORws3w9mEEyeO1A7yXJ6Lt7m
	 fQzHsmJwwfJOExrghLZ6jdxjWnydspoWlpGT9BqD+vDjHZ4fYR+eFd1t0/dcl08hcm
	 IOCG038XBbvHw==
Date: Thu, 27 Feb 2025 12:45:38 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] acpi/ghes: prepare to change the way HEST
 offsets are calculated
Message-ID: <20250227124538.7a2191e0@foz.lan>
In-Reply-To: <20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<9eeaabf88e7ddc4884633702b7bc419075975bc8.1740148260.git.mchehab+huawei@kernel.org>
	<20250226153714.20c57efe@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 26 Feb 2025 15:37:14 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 21 Feb 2025 15:35:10 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 

> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 3ac8f8e17861..8ab8d11b6536 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -946,9 +946,18 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
> >      build_dbg2(tables_blob, tables->linker, vms);
> >  
> >      if (vms->ras) {
> > -        acpi_add_table(table_offsets, tables_blob);
> > -        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> > -                        vms->oem_id, vms->oem_table_id);
> > +        AcpiGedState *acpi_ged_state;
> > +        AcpiGhesState *ags;
> > +
> > +        acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,  
>                             ^^^ will explode if object_resolve_path_type() returns NULL
> > +                                                       NULL));  
> 
> it's also expensive load-wise.
> You have access to vms with ged pointer here, use that
> (search for 'acpi_ged_state = ACPI_GED' example)

Ok, but the state binding on ghes were designed to use ACPI_GED. I moved
the code that it is using ACPI_GED() to the beginning of v5 series,
just after the HEST table test addition.

With that, ACPI_GED() is now used only on two places inside ghes:

- at virt_acpi_build(), during VM initialization;
- at acpi_ghes_get_state().

If you want to replace it by some other solution, IMO we should do
it on some separate series, as this is not related to neither error
injection nor with offset calculation to get read ack address. 

> > +        if (acpi_ged_state) {  
> 
>                 hence, this check is not really needed,
>                 we have to have GED at this point or abort
> 
>                 earlier code that instantiates GED should take care of
>                 cleanly exiting if it failed to create GED so we would never get
>                 to missing GED here

I dropped this check on v5.

Thanks,
Mauro


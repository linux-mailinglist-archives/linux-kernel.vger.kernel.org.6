Return-Path: <linux-kernel+bounces-535727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B02A47674
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FD8188AD09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C9220687;
	Thu, 27 Feb 2025 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNuiow7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772B13777E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641205; cv=none; b=KVCnGkkSxIQVb4PNf5Qcp8pan+h1WcW01mBLQqnE9gBFO82+iNLhu05QG+4NpOJ3jqhFAl5dI+PWAJ6TRITYvri1nwLI3JixQPHcik35MWIIrNm9J3j7eAsoUzZjGEaGTCm/O1/aAU5Es6n+68NPJP20MX3RNw15/3BK/uDyhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641205; c=relaxed/simple;
	bh=41nmpp5KDbERU9SbSANLYVIk9B28KAHdXRn1eUEpQ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTj51D4e39NjUZYGwUtpMCZMSs7r3PBH7M9ikaTfyjgniPiJZQ1dlyJ+l/6IMQeWg/hR6gxW5DXPW/o9yJcpKLl9cCDPRjm2fQE/fKCYstBnv6T5k61dUmV82mDzeIR6YFCKC5gdGTkxPK1eAtZZ9cdbuTpZw116jNX4O+h8pDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNuiow7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED916C4CEDD;
	Thu, 27 Feb 2025 07:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740641205;
	bh=41nmpp5KDbERU9SbSANLYVIk9B28KAHdXRn1eUEpQ6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dNuiow7FIYRNbE/filmO2qq1r5obkAwoY+YUY+n5iXQZ+yOAV5/qpFn5T45fII7/c
	 IKWiHUPOEJmZVeNoTiOOYD426DXuEz2cxlv6XgBUd8fpFUmfkUQRCxrMkyGfszqHKh
	 v0FheXupVnu0NyTy6wyq1QCR4ks/ydF3Ea9qtauQYh9oJD1JEZv1rP5VtXOsV7rhxq
	 8PTIFRqQ+V+7cr6ap0qewi9ye77u/bxU9wLbubRBeDE3CYnYFUjbVZDec1+oiWOFs1
	 zUJHo4TsE9DXBp3RMPgECzehRGotqHCqvZpuEPR/HrPphI4QKyVUrySypmxn6vULr7
	 ZAc87g8prv8rw==
Date: Thu, 27 Feb 2025 08:26:38 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/14] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250227082638.7db90257@foz.lan>
In-Reply-To: <20250227081927.726a1938@foz.lan>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
	<20250226165226.49b88429@imammedo.users.ipa.redhat.com>
	<20250227081927.726a1938@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 27 Feb 2025 08:19:27 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Wed, 26 Feb 2025 16:52:26 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 21 Feb 2025 15:35:17 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> 
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index 5346cae573b7..14d8513a5440 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> > >  
> > >  static const Property acpi_ged_properties[] = {
> > >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),    
> > 
> > you below set it for 9.2 to false, so
> > shouldn't it be set to true by default here?  
> 
> Yes, but it is too early to do that here, as the DSDT table was not
> updated to contain the GED device.
> 
> We're switching it to true later on, at patch 11::
> 
> 	d8c44ee13fbe ("arm/virt: Wire up a GED error device for ACPI / GHES")

Hmm... too many rebases that on my head things are becoming shady ;-)

Originally, this was setting it to true, but you requested to move it
to another patch during one of the patch reorder requests.

Anyway, after all those rebases, I guess it is now safe to set it
to true here without breaking bisectability. I'll move the hunk back
to this patch.

Thanks,
Mauro


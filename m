Return-Path: <linux-kernel+bounces-535721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7EA47666
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A459616F96D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8513777E;
	Thu, 27 Feb 2025 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrOS7tKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E51F9F5C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640774; cv=none; b=LPBbuN68F/tleYOC7S7Tigb8svpNO9JGx0hO7pC70JeKMOLkhuOg2MW9q7tdPwWLQJB7ZBEae60d3CpTq9Z+3Jzf8PjRuIIc1veeggkshrHPuKfJTSTVr5lH9LEj8R6BiDq9bFehsQ2NVEgJtS7r0dFBsE3WnpebcNzvoNDTtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640774; c=relaxed/simple;
	bh=uTordXA6MaEuH41ZSrokwDn9YzrrXK3YvPjwk15VGEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8K2lqe/+T131jarXOu9g37ujfriBALIJPjYiiRvb0KpVwPUtfMDb2Y0H0T6V55Ac+rv5ZizDbDXRiTut6NQ41FSMIvZWgg4fj07aWQXIKUT/KM7HLFc3dBrUht8aMl2sSVxkhHyedQDAFtvjv2pXoMeubSOpbJ0U7/N3neFRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrOS7tKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD6BC4CEDD;
	Thu, 27 Feb 2025 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740640773;
	bh=uTordXA6MaEuH41ZSrokwDn9YzrrXK3YvPjwk15VGEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BrOS7tKFkZRzASt4b8/eCJhLAdguSzcQpduJsd61+sxwYKUchK7jsqEAdSVTSVgYu
	 vKjxCD6tWLLT2DZlUxJvdDDQvjbCF0TWnNsUIteWhCrVNKfGxfUY4jnP8TI6GYbVZY
	 R5yKx4nbOqPOf8ywzYUT50fPmYAFl8y3VflnckPuYlE6Z1ljYn63tSCUydeB7+ti44
	 wOHmjpwqJ84+f0PtMu8EdY6fSV7VsMUHBd2M5OlTkFyoqRI9qog9G7N22LLb/nhskm
	 /0l+eJDaO2bxGyONN8Sa4DzTojvXDYgLlqqmpGOXIn2YC/ND1PGHWzqw6HDvOZiGjT
	 x1gGQHu5bwIew==
Date: Thu, 27 Feb 2025 08:19:27 +0100
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
Message-ID: <20250227081927.726a1938@foz.lan>
In-Reply-To: <20250226165226.49b88429@imammedo.users.ipa.redhat.com>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<e9e0aafd7cc8613709171ec5d8a6d9d9be62d7c1.1740148260.git.mchehab+huawei@kernel.org>
	<20250226165226.49b88429@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 26 Feb 2025 16:52:26 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Fri, 21 Feb 2025 15:35:17 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 

> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 5346cae573b7..14d8513a5440 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> >  
> >  static const Property acpi_ged_properties[] = {
> >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),  
> 
> you below set it for 9.2 to false, so
> shouldn't it be set to true by default here?

Yes, but it is too early to do that here, as the DSDT table was not
updated to contain the GED device.

We're switching it to true later on, at patch 11::

	d8c44ee13fbe ("arm/virt: Wire up a GED error device for ACPI / GHES")

Thanks,
Mauro


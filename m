Return-Path: <linux-kernel+bounces-305731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A389963392
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E4E2833EC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915AF1AE038;
	Wed, 28 Aug 2024 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fo4IHB6N"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5311AD9F8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879140; cv=none; b=FISrFSZrRonrJxFOicgvFSfAU/O86pc9KGRZyrWGYxCRSnPAbyjFbxgLIj7TI+uT29cfoOafKW193t1xf+7AEx/SsQ9KhWhg6RJizFOwn1MlcoWS1lx6l1XsePM6Y64h+jRNev2Fcyk8+KArwrK1+YCR/uwpJBn3E28oSMGYUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879140; c=relaxed/simple;
	bh=O9b/h1jt0My8mMuBRswwTJvmsfyAIhLbUG7uWzm2irg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAlF707fDA21wo7s8i7kUk3S5sxHB6sEohQkYdEv3jvw8qxDzeTsz3hVSQKojVs8mtQRUOogGGMWS0VMJb2ejidQ+rJWFtfQ2CMngSALgYrbEGO8u6wTb+dn5XCF8YaOYrJq33phzKWk0EVxkpgvQ1HPtZ616K/dR/W8ozDG+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fo4IHB6N; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-273cf2dbf7dso4647741fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724879138; x=1725483938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HA3aO0qLDpyT16ckHiIzKiYud21+kmk7/MoRxGGoBJw=;
        b=Fo4IHB6NCoGzvsJJqULklTZvWvol7Y/v+5q8/0qNXa48J6LXS+eiHop5OyDtQ60wr2
         EJpanHwA4sSdVujAG4QlMpm39HFESTi3WnYlnWjiy6edWJR+2p1Rewk9kxukn733u2yn
         L93+1GnowxhJ5spXjZ60f588Lu74BDFigKqm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879138; x=1725483938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA3aO0qLDpyT16ckHiIzKiYud21+kmk7/MoRxGGoBJw=;
        b=tXSsnMcfVAVQ3gOJ8GvUT8XGyS/gmDTakqgBYoTlpxplMAq31/h/4pkb5ErxJc2iX6
         YHBBaP9KVOTLTT3ieHb9o9mMXT3QqbPQSejXwpOM7seB47HbZJWMn/kQ/MC0/0RB72m3
         7tkhmjqxW0HX8wHxAcKmB1ndmd+Xw3HuvKsATR5pTm6jTw1r83T5bdt9VGO1rKS9OO0R
         tY4oa/60mCfGJWJg7zkG3TLqdtqMDmKTVIiTTuagaII6qit3hQE7aYfUEyNgx+erLrWb
         Bf1iguiIFmdzHLIyum8xwVIDf7oqT+LA3ghZ6sqRaWzdHKu+cloN93BYJmZ2i+WavBiU
         UtIg==
X-Forwarded-Encrypted: i=1; AJvYcCVLOFiGxJCSrKccqshTW6BeKAQCpCuEpoNcwJEmZ0qShcNqzgaI5zIk6POajqZ+y2SsvD28Yz67bLoPWQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7gPuxsidGmZsoSA9J98DiYy/Gzk0OhDH4fxoR1BjtOZNdmfu
	u/7L0Rfkz1jQzbjXi0wM1EXhseEhgEeiEt/YtY0PXF6NU6APDdbyZuVUtl+ltTaq/n8BMKBIF97
	Fi0UJVhHup/ywMzwWHKw9cqYYKIsSNMCqtIrF
X-Google-Smtp-Source: AGHT+IFkr3UUR7vNkihwV0658E6D/8y47NeG4vVj6D6jdZc4LVGV+LUY7bY+mTRSOKkQNEJpatTy/+JmHeXTT68DFDY=
X-Received: by 2002:a05:6870:d6a3:b0:264:956e:6207 with SMTP id
 586e51a60fabf-2779013e008mr992999fac.27.1724879138177; Wed, 28 Aug 2024
 14:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824042635.GM1532424@black.fi.intel.com> <20240824162042.GA411509@bhelgaas>
In-Reply-To: <20240824162042.GA411509@bhelgaas>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 28 Aug 2024 17:05:27 -0400
Message-ID: <CA+Y6NJEm8UH5H1zE1Kgz9sKcv2xKKUzR5n=xNdOqyBYocyyCgg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rajat Jain <rajatja@google.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 12:20=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Sat, Aug 24, 2024 at 07:26:35AM +0300, Mika Westerberg wrote:
> > On Fri, Aug 23, 2024 at 04:12:54PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > > > Some computers with CPUs that lack Thunderbolt features use discret=
e
> > > > Thunderbolt chips to add Thunderbolt functionality. These Thunderbo=
lt
> > > > chips are located within the chassis; between the root port labeled
> > > > ExternalFacingPort and the USB-C port.
> > >
> > > Is this a firmware defect?  I asked this before, and I interpret your
> > > answer of "ExternalFacingPort is not 100% accurate all of the time" a=
s
> > > "yes, this is a firmware defect."  That should be part of the commit
> > > log and code comments.
> > >

I like how Lukas explained it here:
https://lore.kernel.org/all/ZstGP0EgttNAxjp2@wunner.de/

It's a bit unclear whether this is firmware implemented incorrectly or
the spec not being specific enough.
Being that I see this interpretation of the spec on all devices with
discrete Thunderbolt chips (across different manufacturers)--that
makes me think that this is an ambiguity on the spec's part.

Given that, how do you suggest I modify the commit log and code comments?

> > > > 2) If a root port does not have integrated Thunderbolt capabilities=
, but
> > > >    has the ExternalFacingPort ACPI property, that means the manufac=
turer
> > > >    has opted to use a discrete Thunderbolt host controller that is
> > > >    built into the computer.
> > >
> > > Unconvincing.  If a Root Port has an external connector, is it
> > > impossible to plug in a Thunderbolt device to that connector?  I
> > > assume the wires from a Root Port could be traces on a PCB to a
> > > soldered-down Thunderbolt controller, OR could be wires to a connecto=
r
> > > where a Thunderbolt controller could be plugged in.  How could we tel=
l
> > > the difference?
> >
We may assume this both because of how the spec is worded, and how
I've seen it implemented in the case of a discrete Thunderbolt
controller, across all cases.
https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie=
-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4=
-to-usb4-host-routers

"ExternalFacingPort" is only used when there is an externally exposed
PCIe hierarchy. (Never otherwise)
I don't know any other examples of externally exposed PCIe hierarchies
other than Thunderbolt.
Therefore I assume, that if there is "ExternalFacingPort", that means
the device has Thunderbolt capabilities.
If we have confirmed that the device has no integrated thunderbolt
capabilities, that means the device MUST expect a discrete thunderbolt
chip outside of its ExternalFacing root port.

That is my understanding of this. Also let me know how I can reword
here as well.


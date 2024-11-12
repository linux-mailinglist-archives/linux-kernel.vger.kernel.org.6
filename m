Return-Path: <linux-kernel+bounces-405466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B1F9C5226
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B240FB27941
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55C20D4F4;
	Tue, 12 Nov 2024 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pqr3wnfP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281311AA1DB;
	Tue, 12 Nov 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403247; cv=none; b=bhBipAZeEHu/p+vxhzCqkLu9cc4GN91A8fMspuaWlHh82YQlfO6KU6UA/+YqG57wepYOso86tRtSUq5HH+eTrnoPwlHr7l9973UpXXOkj58ypf4fCvaHv2cv8mZr+e4BxH0APVEe0IPJ2fL2OgYOcRidzHqzFGLoV7ZAj7udXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403247; c=relaxed/simple;
	bh=wAWx/SGA2EXYdjiNXUC9oPhYTPYTn/PCtaLOpByk+/M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pw0exTUTMcSyESFAwKPI4zHRJKwgKjv8qL/jMv6rJLECUHFaIC+JpXl84GNE7bGpcd8fTztsRGZR8JGt2yYvk6gXwUK8mq89qLjMlL1XCA22s0jJBrTh2amahwwYyta5fqSZEsj7eldE79VdgLIgxUcX1mLyqrvPkMXXvrau+5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pqr3wnfP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731403247; x=1762939247;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wAWx/SGA2EXYdjiNXUC9oPhYTPYTn/PCtaLOpByk+/M=;
  b=Pqr3wnfPpKnI3JkkRgV4687R8U76nsDniFSEmChDxFV5s5uA1SKzq0cE
   72mO8jtZkmekNXEuij8xCof6LYXqiyJUZoNTGq/uNtSx7tEcTGT7Iaqyf
   AN4E9hXlAu+fieQKGqFNaYT7PTyH84pbhYtedmDv3RlwoZd9ugIhlaxKN
   hvGolRoejEZV8t536xYNPoRGnwhJLOqQj/JrNjUTMEONE/7ex1SiA/vB6
   d3ckyNjy1N9ja+6dLlbhgL5INqGwil1mDHUOVIY7+slJaumOVs9vT6giL
   0Ucz5MsXZtEK6PrZ/Tft7/HbpHKTB1iO638KovDB+CYKPvp9T4hldMyme
   Q==;
X-CSE-ConnectionGUID: PiMYtC3xTL2pRDBWRv6EeA==
X-CSE-MsgGUID: LVgMqa3HT2aNBbE8tzwpEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="53781118"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="53781118"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:20:46 -0800
X-CSE-ConnectionGUID: 5h21Fj1ZSyKvbe4L99cjgA==
X-CSE-MsgGUID: armBer0LSGu+mND6YZ91qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="92301038"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 01:20:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 11:20:35 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    "Maciej W . Rozycki" <macro@orcam.me.uk>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v9 3/9] PCI: Store all PCIe Supported Link Speeds
In-Reply-To: <20241111203023.GA1816689@bhelgaas>
Message-ID: <2703fd74-ea61-17a8-267c-24d357e6b0f7@linux.intel.com>
References: <20241111203023.GA1816689@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2131621588-1731403235=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2131621588-1731403235=:961
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Nov 2024, Bjorn Helgaas wrote:

> On Mon, Nov 11, 2024 at 02:23:35PM +0100, Lukas Wunner wrote:
> > On Fri, Oct 18, 2024 at 05:47:49PM +0300, Ilpo J=C3=A4rvinen wrote:
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index be5ed534c39c..a02b77fe7865 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -303,6 +303,7 @@ enum pci_bus_speed {
> > >  =09PCI_SPEED_UNKNOWN=09=09=3D 0xff,
> > >  };
> > > =20
> > > +u8 pcie_get_supported_speeds(struct pci_dev *dev);
> > >  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
> > >  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> >=20
> > I realize this is now already queued as commit 73ee11953294 on pci/bwct=
rl,
> > nevertheless one belated comment:
> >=20
> > Since there are no callers of pcie_get_supported_speeds() outside the
> > PCI core, the above declaration should probably rather live in
> > drivers/pci/pci.h.
>=20
> I moved them, thanks!

Thanks for taking care of that.

> I noticed duplicate declarations for pcie_get_speed_cap() and
> pcie_get_width_cap(), so I'll add a patch to drop them from
> drivers/pci/pci.h.

I also noticed the same. FWIW,

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

for that patch of yours.

--=20
 i.

--8323328-2131621588-1731403235=:961--


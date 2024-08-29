Return-Path: <linux-kernel+bounces-306066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE5F9638C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC96285F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E153A1DA;
	Thu, 29 Aug 2024 03:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s3R2FJnU"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA10136345
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901875; cv=none; b=snjXsQchAzn7HxCRhokaegjezB+N5kx2pryxG9xCQQPA+ZclWnFyr+Ze2BVH1mTU+ltY1YhPYt+Ee4UncDrigFA0iqP/HjhOQvbzcEU86R815+a+G38q39adEwzx2K+3BYmjiBFzrgnud4jN7HODwOuKMmZ/JW6jToKB37z05/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901875; c=relaxed/simple;
	bh=sLXpgJf9tT7+B0B9W1R3a1tBTBF1AejBn13Zgl36xvc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtEfkizJWubr/cxYytBtOIlm5u8127vqnddyZakCFGdmmYajYKaSHGwcKlfUPdTdOpzoOYfKM6yrrgZIy9PAiy5U6OymupZEV8QR8zHA2YL0MakH9IyTXa0J/jw6Xxx3wOWqki+rfvNTOFEzRaWb7fAJZ30XRmVuLx1niQEASfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s3R2FJnU; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T3OOMu068344;
	Wed, 28 Aug 2024 22:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724901864;
	bh=W6DfAT3AuHsggu/0DEl9SBiZeYhcNd7I5bQT9NcSrf4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=s3R2FJnU2SaZGZ0qzS7kWkW1J/GgXzlc05vTrS0m6ntfhWlr1gV4MjYIMD2stJDJr
	 QW8uSoewQ8/neMRE/kONBjn4q9iY+Dd6RYTkmV/08lK6ntWFssdXTbG4LuDFGIxvFf
	 ggtasXCkJUXRQi61PJwHZjsAmLX5iXVRHkVnmY6w=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T3OOWE030648
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 22:24:24 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 22:24:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 22:24:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T3ON1G062467;
	Wed, 28 Aug 2024 22:24:23 -0500
Date: Wed, 28 Aug 2024 22:24:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Kevin Hilman <khilman@baylibre.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>
Subject: Re: [PATCH v10 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20240829032423.ou3hqw2sq5wj2ue6@oversight>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
 <20240826164346.e73vfvd4jzezlbc7@cherisher>
 <56kmiba5cr7re6rdzak5g72pprwfgvme5v4tq6rovrxrd6kefe@5mx5xxdfs7dp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56kmiba5cr7re6rdzak5g72pprwfgvme5v4tq6rovrxrd6kefe@5mx5xxdfs7dp>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 21:54-20240828, Markus Schneider-Pargmann wrote:
> Hi Nishanth,
> 
> thanks for your review. I will integrate fixes for all your comments
> into the next version.
> 
> On Mon, Aug 26, 2024 at 11:43:46AM GMT, Nishanth Menon wrote:
> > On 08:39-20240814, Kevin Hilman wrote:
> > [...]
> > > diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> > > index 1f1871e23f76..4ba9e520a28f 100644
> > > --- a/include/linux/soc/ti/ti_sci_protocol.h
> > > +++ b/include/linux/soc/ti/ti_sci_protocol.h
> > > @@ -199,6 +199,47 @@ struct ti_sci_clk_ops {
> > >  #define TISCI_MSG_VALUE_IO_ENABLE			1
> > >  #define TISCI_MSG_VALUE_IO_DISABLE			0
> > >  
> > > +/* TISCI LPM wake up sources */
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
> > > +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81
> > 
> > ^^ I assume these are daisy chain sources. - will these remain OR do we
> > have to consider the wake sources SoC dependent? If so, the
> > sci_protocol.h will be SoC agnostic..
> 
> These are all wakeup sources from LPM for the AM62 family of SoCs, not
> only daisy chain sources. The currently defined wakeup sources are
> relevant for am62x/a/p but will also be reused for others where
> possible. Otherwise these can be extended in the future for other wakeup
> sources.
> 

OK -> I should have been clear, but, I think you also caught on it
when you said am62x/a/p extended for future wakeup sources - sure..
with 32 bits you can indeed reach a large range.. BUT:

MAIN_DOMAIN, MCU_DOMAIN are specific to a SoC part architecture, it is
not a generic K3 SoC family architecture concept - the power domains
will vary depending on device - same with the list of peripherals used
as wakeup source - is WKUP_I2C0 always present in all devices with
wakeup, Do all K3 devices have USB0 and 1 always? We should not bet on
that.

ti_sci_protocol.h is meant as a generic SoC family level header. I see
these as possibly hardware specific description.

Lastly, I do not see the macros used either in the patch series.. I
understand the ti_sci_protocol.h is meant to standardize stuff in
other driver (I tried searching to see if some other series used
it[1], but I could not find a reference)..

So, wondering: Is DT the right place for that - With a DT header ABI
header that is shared between driver and dt? I don't understand the
modelling of how wakeup_reason is getting used from this series, so I
cannot comment better..

[1] https://lore.kernel.org/all/?q=TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


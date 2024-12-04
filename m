Return-Path: <linux-kernel+bounces-430562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E00E9E32D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E00283BE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0ED18452C;
	Wed,  4 Dec 2024 05:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LkYJodZQ"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD702500D2;
	Wed,  4 Dec 2024 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733288526; cv=none; b=YWn6qG0o+egs1MN5+upjh4bLCgxYj4XVZd3I3eE9CAd6haj/+LLmvObHJTNqkA6CgS8+Z2JbwqXKRyeYjmEnKOeN8CNmsmWVjXwBDwFr38jdLC/PCQvMiIgjglHsMjFALgKgWDiQNHqi4pbRQqZrfV/yNzmx3X9wSpU0fPBJFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733288526; c=relaxed/simple;
	bh=GnlVFOTcxvnw7IjZn/QE30JbutuH7Q8Nof7P5Bi1Png=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT1fY2oyVhVlM2UVv5I3S5fz13Al5C9H1XtWU561CeRYs0zt4FBZBs5jmEsFO69xH09el0GGmMnzB4Ldd+B0cN78HOnrB9VBY7ZIvu75+9JhPIFpcPIKzutXvbRBCwZYMsHsRng1OuLmzKnjGlBmz4SGNQ/m2b0juBzFc58hrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LkYJodZQ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B451rh91719832
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 23:01:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733288513;
	bh=7DhUtPoGTteIH7DDUn9cBBWATVGD5xciR65qwj35AMo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LkYJodZQptK5Ov/2agxu1hQJFiQq9ogLyzt9ycpuU136ErY6+CfHi4uatuuYQE+lk
	 UZ1TgL+tAJVstYkd0l06JjIZafmT+t+iJjN2RSDAd/cxjtivzgzuRe7vKIFJcLhKgX
	 sate8IUHbWjMbtbSd5rZiQr97iCMhTNLEMDDDDCQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B451r6S015782
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Dec 2024 23:01:53 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Dec 2024 23:01:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Dec 2024 23:01:52 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B451pSo018690;
	Tue, 3 Dec 2024 23:01:52 -0600
Date: Wed, 4 Dec 2024 10:31:50 +0530
From: s-vadapalli <s-vadapalli@ti.com>
To: Enric Balletbo i Serra <eballetb@redhat.com>
CC: s-vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya
	<sabiya.d@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: Add USB SuperSpeed support
Message-ID: <o37g5m3qvod4mydnjytyubobmvit7zjmh5xhv6jxjze3reiqct@wkwm36yvftyr>
References: <20241126-am69sk-dt-usb-v1-1-aa55aed7b89e@redhat.com>
 <2nuncc5rscu6h74ylaiu6yozg34aoigaj5d4uzvdtolt5q7bmv@6hacpxyb2532>
 <CALE0LRtUN2N_Z05jH_BMSg7yvirSRob0pSErmQxTu8AatmODgw@mail.gmail.com>
 <CALE0LRu-Sx5oTVNY3hm+Msu-zb04a7_ZD+r3xF1eRfR_WtK0VA@mail.gmail.com>
 <wbsg3fmco6rwjj7vtiqtqv7trfjor73j7rjx7efnlafo4pz4bc@awixm2iygd55>
 <CALE0LRvZNnNJ8jBG35bU8Ev5Fvr2400O5qXUsRn0zufkidJeJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALE0LRvZNnNJ8jBG35bU8Ev5Fvr2400O5qXUsRn0zufkidJeJw@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue, Dec 03, 2024 at 04:29:02PM +0100, Enric Balletbo i Serra wrote:
> Hi,
> 
> On Thu, Nov 28, 2024 at 10:58 AM s-vadapalli <s-vadapalli@ti.com> wrote:
> >
> > On Thu, Nov 28, 2024 at 10:47:42AM +0100, Enric Balletbo i Serra wrote:
> > > Hi,
> >
> > [...]
> >
> > > So I changed the dr_mode to otg instead of host and tried to configure
> > > a usb mass storage gadget but unfortunately didn't work, but this
> > > could be a driver problem, I got the following error
> > >
> > >   UDC core: g1: couldn't find an available UDC
> > >
> > > As the devicetree should describe the hardware, and as far as I can
> > > see it should support the type-c port act as a gadget, I'm fine with
> > > changing the dr_mode, unless anyone have more information about this,
> > > the thing that makes me think a bit more is that, in the TI kernel
> > > this is set to host, so I'm wondering if I'm missing something or is
> > > just that was never tested.
> >
> > Are all interfaces (Type-A and Type-C) functional as Host when the
> > dr_mode is set to "otg"? (Do USB devices connected to the interfaces
> > enumerate on AM69-SK?) If yes, then it could be a DIP Switch setting
> > that is related to OTG mode of operation or a USB-C Mux that needs to be
> > configured.
> >
> 
> Yes, all interfaces (Type-A and Type-C) are functional as host when
> the dr_mode is set to "otg". Looking at SK-AM69 Processor Start Kit
> User's Guide (Rev. A) [1] I don't see any DIP Switch related to the
> OTG  mode. Looks like the type-c connector connects directly to the
> SoC through a USB HUB (TUSB4041).
> 
> [1] https://www.ti.com/lit/ug/spruj70a/spruj70a.pdf?ts=1733215039014

In that case, please post the patch setting "dr_mode" to "otg". As to
why "peripheral"/"gadget" operation doesn't work could be addressed
separately and seems to be independent of the device-tree. The reason
for suggesting "otg" instead of "host" is to ensure that the device-tree
describes the Hardware. Since "host" mode is still functional with
"dr_mode" set to "otg", at-least for the use-cases that you have in mind,
I believe that "otg" should be acceptable.

Regards,
Siddharth.


Return-Path: <linux-kernel+bounces-303082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D338960725
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446CF1F26820
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83672FB2;
	Tue, 27 Aug 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EYLbRnGT"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23DD19DF9A;
	Tue, 27 Aug 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753236; cv=none; b=g/qDhBb35kmtnRD81QPLXLjPDwcN4QjjTYSk5KolNN/rTMlfdvhtUMD50THYJAp1BdFLJBqLaa+Ct4BiiWcOPxWdObxi6VKPaoBv9KCuCsHHftG8n7RM2nEqug53lR5n/Bwkwgnc3OvkWKl7Mbxxzu3ayI+PALVnDQFasjDFk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753236; c=relaxed/simple;
	bh=8wYnWhNT07PfewWScnNdFqqcpkmHXshJhSS5aUywgqc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy/olDKgNVkjHefDUc3hneDCaRHHpv5iGd8O6NAszQUww4Q47ndIS34BgwMz2uPFS4ZHFk5Z5/+leIO4R97KKE8zqvKj/xjAxjTah8RyncmUpApEPSB5noHHNMPNw+3LVeBONJrKLsq560FepwSMZbPkbJhBk3QK115JBka8v5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EYLbRnGT; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47RA6pLc099417;
	Tue, 27 Aug 2024 05:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724753211;
	bh=qU/Lmzk4lcyCdDfcmmCqkFpz0BEGSIthJ1hZhYq9fnk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EYLbRnGT+z6JhcMgCOXwVNWkyuqQlvPMxPOq5DXnSGkB7wghUS0uHPDxcGhpB1w4Z
	 +xDbj9aHgi9gFO8h0zKocSp47vVJXCm+dTXK4J0WU8OB5DIVFUb/VTMckVV3Um/Bdq
	 AjnWpOJhaDCPwD7Mqt7Bpnow4yoN42/Nqnv8kA/o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47RA6pXo048763
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Aug 2024 05:06:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Aug 2024 05:06:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Aug 2024 05:06:50 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47RA6n7x001554;
	Tue, 27 Aug 2024 05:06:50 -0500
Date: Tue, 27 Aug 2024 15:36:49 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
        Bao
 Cheng Su <baocheng.su@siemens.com>,
        Hua Qian Li <huaqian.li@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: PCI: ti,am65: Extend for use with PVU
Message-ID: <ada462d5-157a-4e11-ba25-d412a2bb678f@ti.com>
References: <cover.1724709007.git.jan.kiszka@siemens.com>
 <82ac9e266f6aca42699ec4a3c8f10887789ee6bf.1724709007.git.jan.kiszka@siemens.com>
 <afyz3i4xihir4fnt4djo45saytz5ubu3wel6munq7cinwcb55m@ohdelne4xf34>
 <6c28d580-9961-4bac-adcd-1724de68c9fb@siemens.com>
 <0ca0fc20-421e-4bbc-bcda-9e5c2ea3b1b4@kernel.org>
 <2bb6b337-d83b-4cbe-aff2-bbd0c7d17c2b@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2bb6b337-d83b-4cbe-aff2-bbd0c7d17c2b@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, Aug 27, 2024 at 11:32:02AM +0200, Jan Kiszka wrote:
> On 27.08.24 11:29, Krzysztof Kozlowski wrote:
> > On 27/08/2024 11:22, Jan Kiszka wrote:
> >> On 27.08.24 08:37, Krzysztof Kozlowski wrote:
> >>> On Mon, Aug 26, 2024 at 11:50:04PM +0200, Jan Kiszka wrote:
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> Describe also the VMAP registers which are needed in order to make use
> >>>> of the PVU with this PCI host. Furthermore, permit to specify a
> >>>> restricted DMA pool by phandle.
> >>>
> >>> That's an ABI break without explanation why it is necessary.
> >>>
> >>
> >> It is needed in order to support the PVU, as written above.
> > 
> > Above say only that you want a new feature and that's not really
> > suitable explanation for ABI break, because answer to this is: add new
> > feature without breaking existing users. But maybe there is a bug or
> > something does not work or never work or there are no users, don't know.
> > 
> >>
> >> Previous versions of this binding likely didn't consider this use case
> >> and therefore didn't describe all registers associated with the hardware.
> >>
> >> BTW, if you see a way to add the required registers without breaking
> >> more than needed, I'm all ears. At least the kernel driver will continue
> >> to work with older DTs when you disable PVU support or do not add a DMA
> >> pool to the DT.
> > 
> > If there is no ABI break, because driver still handles correctly old
> > DTB, then mention it in the commit msg.
> 
> Well, this is strictly spoken not a topic for this commit because this
> one should have no clue about what drivers do with DTs according to this
> binding. But I can put a hint and go into details in the driver patch.

Based on the Techincal Reference Manual for AM654 and the driver
implementation in patch 5/6, I think that the following might be one way
of hinting that ABI won't break:

The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices to
specific regions of host memory. Add the optional property "memory-regions"
to point to such regions of memory when PVU is used. Since the PVU deals
with system physical addresses, utilizing the PVU with PCIe devices also
requires setting up the VMAP registers to map the Requester ID of the
PCIe device to the CBA Virtual ID, which in turn is mapped to the system
physical address. Hence, describe the VMAP registers which are optionally
configured whenever PVU is used for PCIe.

Regards,
Siddharth.


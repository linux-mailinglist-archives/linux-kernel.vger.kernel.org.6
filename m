Return-Path: <linux-kernel+bounces-302128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279BB95FA3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BF21C21624
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1E199E84;
	Mon, 26 Aug 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rQhuyVGx"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FE1EEE0;
	Mon, 26 Aug 2024 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702462; cv=none; b=BdxAisPiVsOEwvJpuIZ6lHOJtCVGTVnLGLMPUm3CcthKZK2nJSvYsAEctSlofS1t4c84gCkXf7H/RhfVVF6OijTGlWCQvv1j3yHc+iABjL4QdVXiSQv2JyWaaldF7kk9+Aq9feE4P7GkU7As3hXAyuZJQfDvBRYpelUhWPo6JXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702462; c=relaxed/simple;
	bh=i8b2/3fpffPE7CwL6nUMN/hgNxZHYPJAWsR36w/3Wpo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJyMhbVB0To2Tzd1WGNQDpRAtiyHEDWazHZ6E2mNZiC1ZSJYeTDTWjmL4nIPlGx/I6/AerbRE7OJyrf7z1kaueLks54F1/gvSamSuHnO2DDnQdk4syQBEZznJI2bsEEC17Ilq/fK3Ofb0VPSSyNpdue8y3+LyHy/4OHWNteW0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rQhuyVGx; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QJxU6s080126;
	Mon, 26 Aug 2024 14:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724702370;
	bh=PoQ1GbwjydY0m7ZMYSEqW1TJtwmFz8MtKPN1W40p+7U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=rQhuyVGxs4DXmBAIEfpEDVI7n8jDEsyM6EZz1H3RSdbtByW/5SrTJ0G98n8NjHNZB
	 J+z1L7TyM2wOPDsu9MkZ7Si/WCtgw5jz9IZ7Cqd9Eo3QOqMwUzV9GJM/su3niSwQzL
	 JtpYMhYcZjQhvuBdLxi2y7ZaN53oeuqNP+96wHqs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QJxUDL022545
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 14:59:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 14:59:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 14:59:30 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QJxUIx026103;
	Mon, 26 Aug 2024 14:59:30 -0500
Date: Mon, 26 Aug 2024 14:59:30 -0500
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: soc: ti: am645-system-controller:
 add child nodes used by main domain
Message-ID: <20240826195930.c7bylbgu6qma2v3c@siren>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
 <20240824175825.bedufmhfkx4btv5n@anything>
 <992d6ff9-3181-4a71-9e21-3ba6465693d6@siemens.com>
 <20240826114259.ynxf5a5qwbm2co4u@press>
 <7ee8c6c0-3e1d-4262-840e-435407521324@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ee8c6c0-3e1d-4262-840e-435407521324@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:01-20240826, Jan Kiszka wrote:
> On 26.08.24 13:42, Nishanth Menon wrote:
> > On 13:31-20240826, Jan Kiszka wrote:
> >> On 24.08.24 19:58, Nishanth Menon wrote:
> >>> On 18:37-20240814, Jan Kiszka wrote:
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> Expand bindings to cover both the MCU and the main usage of the AM654
> >>>> system controller.
> >>>>
> >>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> ---
> >>>>  .../soc/ti/ti,am654-system-controller.yaml    | 19 +++++++++++++++++++
> >>>>  1 file changed, 19 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> >>>> index e79803e586ca..cb9da3ec39a8 100644
> >>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> >>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> >>>
> >>> As per linux-next, this file does not exist? looks like you might need
> >>> to rebase on latest next?
> >>>
> >>
> >> "This goes on top of
> >> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org/"
> >>
> >> Is that series obsolete by now?
> > 
> > This dependency information would have been useful when provided under the
> > diffstat section of the representative patch. :(
> > 
> 
> Yeah, who reads cover letters? ;) Will try to do that next time.

Looking at what we included in v6.11, looks like the above series from
krystoff will need to be re-thought through.
[1] makes the patches un-necessary to an extent by modelling the node as
a simple-bus - Looks like k3-am62-wakeup.dtsi was missed, but it should
be trivial enough fixup. Did you try applying the series on latest next?
it should not apply anymore (Doesn't apply on master either).

[1] https://lore.kernel.org/all/20240628151518.40100-1-afd@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


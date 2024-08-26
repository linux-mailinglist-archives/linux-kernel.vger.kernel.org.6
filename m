Return-Path: <linux-kernel+bounces-301399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA9195F008
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B861C218DB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F5154C11;
	Mon, 26 Aug 2024 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YOVL2IUA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C51482E3;
	Mon, 26 Aug 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672599; cv=none; b=Rxbq0TnsvCiBf66zM53AKe/hUnrKKOH/IXcYAIGyVnzYv6JiRLBMsxH0OTS54bvHh/zdiy3dCzcmnW5nkpoNehKcNDgxojGS6+W9UnP1ttSc+Jyr+kjM7tMacYuw+xtW2RfoQGh9ONzfCfFQlotqKgaJCvgOb2ZigsDgsWE4tZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672599; c=relaxed/simple;
	bh=nUD2Ble7OtDak98lULBxlQNC6gDMuAxF5O/ElCRD96s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imEq9EGiw/W5Bgi5ha/mp1Uh/z1zF4z5ZYywuxkYf1n+LZQ6EGk6eqFEoTSPzx817kFXhy1VJxjWscux6AYo2pXkSEx63qTUqobWNJCvkdaurnzr6/s+NCdb5IGjcNrACCGFZncxo5qgPyTYUWWSSRy7C0MAAvq4zmgSGeurtH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YOVL2IUA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QBh0A1080639;
	Mon, 26 Aug 2024 06:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724672580;
	bh=irAI8edorAyEOpbTVCZvuSi5yEf7XuCcDoANh6w8A0c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YOVL2IUAPme6U0PSnQpYVgPFhGWXwuRi+DXDBaxV9N6/510rJKzrtLpvU/XtPaSN5
	 x8ZAb8GMGuImJ1/bBhe7ORpajTRqZB0CPFSyw0xvVT2OT6bqpXuViWBWhkgKUJ9mhH
	 YNR6HvgHKji5Y1fvjglpTJmLbt4hp8v9sbcDHW9I=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QBh0tk005433
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 06:43:00 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 06:43:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 06:42:59 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QBgxFS123040;
	Mon, 26 Aug 2024 06:42:59 -0500
Date: Mon, 26 Aug 2024 06:42:59 -0500
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
Message-ID: <20240826114259.ynxf5a5qwbm2co4u@press>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
 <c6bbb3884e9270a203ee39d298c34f6676b3911e.1723653439.git.jan.kiszka@siemens.com>
 <20240824175825.bedufmhfkx4btv5n@anything>
 <992d6ff9-3181-4a71-9e21-3ba6465693d6@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <992d6ff9-3181-4a71-9e21-3ba6465693d6@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 13:31-20240826, Jan Kiszka wrote:
> On 24.08.24 19:58, Nishanth Menon wrote:
> > On 18:37-20240814, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Expand bindings to cover both the MCU and the main usage of the AM654
> >> system controller.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>  .../soc/ti/ti,am654-system-controller.yaml    | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> >> index e79803e586ca..cb9da3ec39a8 100644
> >> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-system-controller.yaml
> > 
> > As per linux-next, this file does not exist? looks like you might need
> > to rebase on latest next?
> > 
> 
> "This goes on top of
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org/"
> 
> Is that series obsolete by now?

This dependency information would have been useful when provided under the
diffstat section of the representative patch. :(

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


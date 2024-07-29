Return-Path: <linux-kernel+bounces-266074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8078393FA60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BD4283ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32BE15B113;
	Mon, 29 Jul 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kopz85o8"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E27FBAC;
	Mon, 29 Jul 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269602; cv=none; b=rlTaaX2aAMMYRmzlnJvew2jL47kSQN23kWC7ZqzBiSVYhn0BVPWwiBYBJhU/jPV9hZy167qwsMSKdsQ5Ukkd04QKbhs6dkDy/8KXS2MwF5qCbR9E+AsREbvgD65n3ZgDW5EbJFacWiECpp/g42Sr8dfX7JqZ/XixvROTKUr+QuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269602; c=relaxed/simple;
	bh=ek7XeP30ypUlvSu396c56pnbk1rTEksECiHqJedq7hs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxTp5KiN+tSlX53fgigtgsWc7ED0ULHwEyFboc0hMgtt+l+6tPRUPgpY7ViGal3migvtrDDSVN7JoytutPre9ESRquabJS47kuQbGfe/g6ZGApI13o5eNz7CXYV69dzxhGhO5IXULxwEbUEcti0EHDLRkvtbwcR6fiET7eVEneo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kopz85o8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TGD6r2112913;
	Mon, 29 Jul 2024 11:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722269586;
	bh=xRAJJ8NgSRfHqtC4Hh2uG+3wnZbaQtbP4LrKYXolxw0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kopz85o86x+wvjKrC0IZn1AC6RrQ3EEMfy904t/bvMYe8QiXXmfE1A5HVwcriwiJp
	 jMZ8qSnXm8T63nVYCAQupRPnGPxjIELt/7iUctKvWgHfUu1g69VWzhT5XbRW2KqvZ1
	 jPwru2hxavcEiRUkBxHjbTp+bTY7YTCeOl7ZP2Ac=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TGD6rD046801
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 11:13:06 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 11:13:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 11:13:06 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TGD5w2036861;
	Mon, 29 Jul 2024 11:13:06 -0500
Date: Mon, 29 Jul 2024 21:43:04 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Rob Herring <robh@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lee@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: syscon: Add
 ti,j784s4-acspcie-proxy-ctrl compatible
Message-ID: <a98b975d-ec8b-432b-9437-aef07240257b@ti.com>
References: <20240729064012.1915674-1-s-vadapalli@ti.com>
 <20240729160453.GA805559-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729160453.GA805559-robh@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, Jul 29, 2024 at 10:04:53AM -0600, Rob Herring wrote:
> On Mon, Jul 29, 2024 at 12:10:12PM +0530, Siddharth Vadapalli wrote:
> > The ACSPCIE_PROXY_CTRL registers within the CTRL_MMR space of TI's J784S4
> > SoC are used to drive the reference clock to the PCIe Endpoint device via
> > the PAD IO Buffers. Add the compatible for allowing the PCIe driver to
> > obtain the regmap for the ACSPCIE_CTRL register within the System
> > Controller device-tree node in order to enable the PAD IO Buffers.
> > 
> > The Technical Reference Manual for J784S4 SoC with details of the
> > ASCPCIE_CTRL registers is available at:
> > https://www.ti.com/lit/zip/spruj52
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on linux-next tagged next-20240729.
> > v1: https://lore.kernel.org/r/20240715120936.1150314-2-s-vadapalli@ti.com/
> > Changes since v1:
> > - Rebased patch on next-20240729.
> > - Separated this patch from the series.
> > - Collected Acked-by tag from:
> >   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >   https://lore.kernel.org/r/04d94188-5e30-4cab-b534-e97c0b2a61f3@kernel.org/
> > 
> > NOTE: Though it was mentioned on 25th July 2024 that this patch was applied:
> > https://lore.kernel.org/r/172190301400.925833.12525656543896105526.b4-ty@kernel.org/
> > since I did not find the commit in the MFD tree and the Linux-Next tree,
> > I am reposting this patch.
> 
> That's because it was in the middle of the merge window and only fixes 
> get published during that time. That's now over, so it should get 
> published soon. However, maintainers get busy on other work or take 
> vacation, so it could be delayed.
> 
> Unless a maintainer updates their tree with other later patches and your 
> patch is not there, no reason to worry and resend.

I was under the assumption that a commit ID is mentioned after the patch
gets applied to the Maintainer's tree and is visible publicly. Thank you
for clarifying the details regarding the process followed. I will make
sure to wait long enough before resending any patches in the future.

Regards,
Siddharth.


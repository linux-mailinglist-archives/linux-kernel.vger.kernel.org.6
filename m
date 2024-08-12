Return-Path: <linux-kernel+bounces-282721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABCB94E7E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32011F239BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32D15886B;
	Mon, 12 Aug 2024 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q8VticFr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF314F138;
	Mon, 12 Aug 2024 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448087; cv=none; b=EITxEQTm0cFWqPAd6w79ZIKuNpwvE8FMd1Cqr9NZx+nXR8i+2WwTZfDlLRGdvcmQcbvFVrtndbRbXcoEfVfnZu2+W0wyDSHySwa4T254CVB5wFqct/IyaYeSD/Q1DDwRZpldYPCuXjwT1Yf6abMljHaq0Xu570yv7q4YJRoDW4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448087; c=relaxed/simple;
	bh=igp2yX5tzVVG0xxkLs3tedpyhHunjPdjwnvcAFbVgj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfSjtwfS/K+4VpyArfJ1+IeSRnK2faYpYNOoIrtNeGBbJY7jyPbuPEpxiIjyIAp73XC0igPGLcWEeGT4DxIumhOIRQTXBF247HNtyE3L9bqbjuxRjVAhFjLl4pW/zLVWLhXznibmNDrN8DvfF84YAiaoQua464Of+0AmxArlpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q8VticFr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47C7YcmZ077759;
	Mon, 12 Aug 2024 02:34:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723448078;
	bh=JvE3NbYhhdYAjYYAv//x8xzNUxqRDHrsqwEjZmLTLrM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Q8VticFr1yOtygyd0XSbcdIvG272Ul9EGD/4Mt3uKCdbr8m8AWPKX9E7Yw75Hc4tv
	 EBKY0TriPGhbfpntbY6GrmgvwFwyHv6W+ulPZsq94X6PqabpeOwM/JXYpeqLZ+yW5L
	 S1lpSC8LWO22NhAFiT9MJpt6N+hnvCcAeR3eXT7g=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47C7Yc88107193
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Aug 2024 02:34:38 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 02:34:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 02:34:38 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47C7Ybc9087472;
	Mon, 12 Aug 2024 02:34:38 -0500
Date: Mon, 12 Aug 2024 13:04:37 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <sinthu.raja@ti.com>,
        <n-francis@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am68-sk-base-board: Add clklb pin
 mux for mmc1
Message-ID: <20240812073437.l7prhefqnryajat3@uda0497581>
References: <20240809072231.2931206-1-b-kapoor@ti.com>
 <20240812051058.ooq7uxd6xdbhgjln@uda0497581>
 <413dc315-e8d0-4971-af23-ba21833eb855@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <413dc315-e8d0-4971-af23-ba21833eb855@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya,

On 12:23-20240812, Bhavya Kapoor wrote:
> HI Manorit, please review again for the limitation you found in the v1.

What I meant is that my R-by stands but I can understand the confusion..

> 
> Thanks and Regards
> 
> On 12/08/24 10:40, Manorit Chawdhry wrote:
> > Hi Bhavya,
> > 
> > On 12:52-20240809, Bhavya Kapoor wrote:
> > > mmc1 is not functional and needs clock loopback so that it can
> > > create sampling clock from this for high speed SDIO operations.
> > > Thus, add clklb pin mux to get mmc1 working.
> > > 
> > > Fixes: a266c180b398 ("arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board")
> > > Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> > > Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> > > ---
> > > 
> > R-by already given in v1 [0]
> > 
> > [0]: https://lore.kernel.org/all/20240808050914.4jleprwmlrtv4alb@uda0497581/
>

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

 > 
> > Regards,
> > Manorit


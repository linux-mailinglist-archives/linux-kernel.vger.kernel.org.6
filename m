Return-Path: <linux-kernel+bounces-230072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8491780E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBC028357D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE835143882;
	Wed, 26 Jun 2024 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k+dVMxjn"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD628DDF;
	Wed, 26 Jun 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379500; cv=none; b=jQgkkFKhCbC1vQr7fU/qKwLRSNjMxJuJuQgNQ578aBHlIjJ1eqaw4+Wtd+kT/WlIuVhPVetWwQfZ/uJBOIRA0ymoayZkIXlrj25f3dCnm2XfIQIFD4obTyLDn3zawUqy9TSckl34JOW5WADfWQP+jQWSHW2oZr8/g5JRZP20Vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379500; c=relaxed/simple;
	bh=wp16woBkAvOTlitk4bxYO7c5wPm2CZ+vyie4mIuxV34=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bJmEgrnh+YGdBDpdzex9B75aAuf+BsVLPkAFvKvY3jW63if8Pi2R1P6xP4ykTMC/SICGoIa9x+IgsfNPozkmrALMVzY4URU+70EBLF6Kmr6uw5bBh09SdVFSvxQF4/Qqg8SWaVU/wLbi2RoEZ44ey0ld7CxkR9/O1k7iZlmJf1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k+dVMxjn; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45Q5OU3k014856;
	Wed, 26 Jun 2024 00:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719379470;
	bh=GC+txUZD6XBbGCO0hZ81+OWYjnG29RhcGAvym7/4oFI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=k+dVMxjndnBbKC1Be4MDbIYpasqVcSIQ7rGy8WvvIR4SgKvqlAaicGou5f89+Vaj7
	 ztqppU/6qlDIkZXK2KVzVdH2i4Z2byV0J67eHCYiiyeInG5578WmNTa0e/Jy9AIrL3
	 MlzMoGvtbxOioY07hCyNz8//lt3dYp+MxbEmIag4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45Q5OU9h092436
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 00:24:30 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 00:24:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 00:24:30 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45Q5OQtH028762;
	Wed, 26 Jun 2024 00:24:27 -0500
Message-ID: <594c8c93-f9ae-4589-a4c3-116ed2d96f73@ti.com>
Date: Wed, 26 Jun 2024 10:54:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: k3-am625-verdin: enable nau8822 pll
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>
CC: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240418105730.120913-1-andrejs.cainikovs@gmail.com>
 <20240425135610.6c6ysoejefuazm63@privatize>
 <20240625165851.GA26676@francesco-nb>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240625165851.GA26676@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 25/06/24 22:28, Francesco Dolcini wrote:
> Hello Nishanth, Vignesh,
> 
> On Thu, Apr 25, 2024 at 08:56:10AM -0500, Nishanth Menon wrote:
>> On 12:57-20240418, Andrejs Cainikovs wrote:
>> [...]
>>
>>> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
>>> ---
>>> This patch requires https://lore.kernel.org/all/20240409121719.337709-1-andrejs.cainikovs@gmail.com/ to be applied,
>>> if not the audio will just stop working because no code will ever enable the required clock to the codec.
>>
>> Thanks. lets wait for the dependency patch to be merged to master, and
>> once done, please resubmit this patch. I am going to guess for the next
>> cycle.
> 
> Would you mind picking up this patch? The dependency is now merged and
> this should apply cleanly. I can also resend if needed, just let me
> know.
> 
> Francesco
> 
> 

Sure, added to my review queue. Thanks!

-- 
Regards
Vignesh


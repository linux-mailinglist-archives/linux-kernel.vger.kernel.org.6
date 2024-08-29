Return-Path: <linux-kernel+bounces-307418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52861964D64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D6A1C22D37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5EE1AD9DE;
	Thu, 29 Aug 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zonm92hL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC61AED4B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724954743; cv=none; b=ZqUKEJbxVqFw9KMcUkrVi71mIAL3eoxuy173hdQ9S4vLzlvo5JBw+FQ40+ZaMXfShcFhsWWWNZxEjorSuqJby9Gj/P4oJXbubigUYw+Z/Kcrl4RFWZqPXTLEFmiUM/ff6Q8B9+5brA9j1aM1nTGOW+xcHzAb6q4sjT1Kh2FHi4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724954743; c=relaxed/simple;
	bh=DoK3pv1GElS+aUjmzROSEEWhhKMF0TSaWa3rNhKarbc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhREV8Ub/1s4oyoaV/kPkyIDHluZP4bJBpooNFbedD1H/DUs914uDt5qc5aeviIc6/K7Ep8O2V/Wk0/8yzQBfIbiDOHJa3sYvObZknIedsZT/7/l71FAQfmDuCDczsB+E0FTpT6ig7Ci/V3RYgenOk6HH7cvKy/mD/h848bzm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zonm92hL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TI5KJE072994;
	Thu, 29 Aug 2024 13:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724954720;
	bh=jEB24TZ6Qs/9kIyUi3KVfuDw3ckRCJD1Buwmvnbjt08=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Zonm92hLbM4Eq5d7uL/44AlHSKhqQvG4oTqPhLdYSEkVGmXBUV3tl8oS8CnNfKfzx
	 1xVCDR3V6kndFvNm8MsQbxV/E2zgiIG9zmgyeaI1B9JXQSpJz/0GrvaSuOF4A7EOHj
	 LcnZCu6tkevXzNG+y/6FKg1sTjW1yNFaFfzb6+Sk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TI5KVN011912
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 13:05:20 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 13:05:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 13:05:19 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TI5JBr075169;
	Thu, 29 Aug 2024 13:05:19 -0500
Date: Thu, 29 Aug 2024 13:05:19 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Kevin Hilman <khilman@baylibre.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Akashdeep Kaur
	<a-kaur@ti.com>
Subject: Re: [PATCH v10 3/4] firmware: ti_sci: Introduce Power Management Ops
Message-ID: <20240829180519.bftb7qxh4oj65oew@postnasal>
References: <20240814-lpm-constraints-firmware-msp-v10-0-bee4314bbdc8@baylibre.com>
 <20240814-lpm-constraints-firmware-msp-v10-3-bee4314bbdc8@baylibre.com>
 <20240826164346.e73vfvd4jzezlbc7@cherisher>
 <56kmiba5cr7re6rdzak5g72pprwfgvme5v4tq6rovrxrd6kefe@5mx5xxdfs7dp>
 <20240829032423.ou3hqw2sq5wj2ue6@oversight>
 <rowimkyghjzuwt5hmwgl24oyyyjpth2zpvljc2mnyp5h5o7fyg@tdsdtsvwxfbx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <rowimkyghjzuwt5hmwgl24oyyyjpth2zpvljc2mnyp5h5o7fyg@tdsdtsvwxfbx>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:47-20240829, Markus Schneider-Pargmann wrote:
[...]
> Thanks for explaining. So should I add the header already with this
> series although it is unused right now, or should we add it together
> with the first actual user later on, so there is no unused header in the
> meantime?

Thinking deeper: we have two options:
a) dt bindings update with the property without knowing how the driver
  changes will be accepted or not.
b) drop the header changes for the macros.

I think (a) at this point is risky given the driver usage model is
un-clear - the APIs are abstract enough to be used in any way of choice,
but we do not want to be stuck with binding that then has to be
backward-forward compatible fixup..

So. (b) is better approach, IMHO..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


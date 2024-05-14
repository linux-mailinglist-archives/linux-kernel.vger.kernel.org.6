Return-Path: <linux-kernel+bounces-178323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21728C4BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E24A1F2294F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DB318029;
	Tue, 14 May 2024 05:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rE+d+vpB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E672B645;
	Tue, 14 May 2024 05:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715663554; cv=none; b=hDLWmK+8HJ4J/09GimMB0mCO10jarqrD5Y9gO8SnlyDt7h/6McGOidiyFKfwhIKq8XCfIjwu0SXrWXI6wyJ6/p8Gvs2Di6eyY57oUCIK6ZrV8TnUE+4M684uLNYm6kWV6yzR/iEdw65t7sox6nSYc9rNUIJd6wuRynme//jReOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715663554; c=relaxed/simple;
	bh=88SW/MGZ+GOKNBKUNTIXm42jTLcp4Mc3uOZanHI0HCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UTeehP3cG9ouBTa/ktrkVnKtAp/uMHuLYYOtDHq0+SXDpVliiLWj0mgfTvNS8eZ9ETyOh+KNPR4LAKqRyswTSt1w64wdq7AeMKBfRY0FDFdt5LmGweDhkpZdsplue1K6/F/K8RAh2//khyujMl2h9EUWj9WhhouJ2XsiO7aZGTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rE+d+vpB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E5C613103074;
	Tue, 14 May 2024 00:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715663526;
	bh=hz8tJbFUiS5XgjGMjOmZXYP7Cn+E9jHLIHe7YXMzvwE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rE+d+vpBJdUvr8rNMDNIIl9RDdRpLtEJsqxn/bY3qhdLpfJQfYeHHZQAQChF3rXFX
	 L+S/lNW37UsWDhJTTtc+Al+TR1lXu19FDwRzNj6EZ3cWYu8RWzG4m6quPgBRajMjEh
	 xrYY06LsLos9eXGZVy5m/0rPt3sfPJr1CBcp7Flw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E5C6DH019367
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 00:12:06 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 00:12:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 00:12:06 -0500
Received: from [10.249.131.75] ([10.249.131.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44E5Bu8M056360;
	Tue, 14 May 2024 00:11:57 -0500
Message-ID: <db1e0a3c-99c9-4eab-9e42-f4e771a03031@ti.com>
Date: Tue, 14 May 2024 10:41:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: display: ti,am65x-dss: Minor Cleanup
To: Rob Herring <robh@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        DRI Development List
	<dri-devel@lists.freedesktop.org>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Alexander
 Sverdlin <alexander.sverdlin@siemens.com>,
        Randolph Sapp <rs@ti.com>, Devarsh
 Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>
References: <20240511193055.1686149-1-a-bhatia1@ti.com>
 <20240511193055.1686149-2-a-bhatia1@ti.com>
 <20240513191943.GA2982709-robh@kernel.org>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240513191943.GA2982709-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 14/05/24 00:49, Rob Herring wrote:
> On Sun, May 12, 2024 at 01:00:52AM +0530, Aradhya Bhatia wrote:
>> Reduce tab size from 8 spaces to 4 spaces to make the bindings
>> consistent, and easy to expand.
> 
> "Re-indent the example" would be more specific than "minor cleanups" in 
> the subject.

That would be better. Will reword this in v2.
Thank you!

Regards
Aradhya

> 
> Otherwise,
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>  .../bindings/display/ti/ti,am65x-dss.yaml     | 54 +++++++++----------
>>  1 file changed, 27 insertions(+), 27 deletions(-)
> 


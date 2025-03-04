Return-Path: <linux-kernel+bounces-545404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32ECA4ECA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E828C1675A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276EB259C8A;
	Tue,  4 Mar 2025 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZXqPpcW5"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79035253F2A;
	Tue,  4 Mar 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115010; cv=none; b=LYPycg1/Guus0vYpz8/z45ibYFFs6Z4rUKtEleQbHRAxQtvVqk03WQ14vsZaZLWBt2A6rRCVRnm49LtDAnZONSa4BK3DoxBkTQWGebT1iyzyRN82/VoWp3q6cc9dpffWBL67GfRRmU+HvycCFjlgFaOdXvjkE9X29+MrWsuPvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115010; c=relaxed/simple;
	bh=q0P2BDYxP/21rNb3gJW+RLQdOs1LW/uQ/6J50K5IbS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lGt7B83NoVZ+qgTC5WIWaj4Icb2UvnfGrpBWQ66aQRHJhuTKPFWKhQ+tz9hra/L7G+5Pf8eK9TC0HghDOPwtIFZfc37/oDMmiXOOxmpZzDagf0xXfN3P2PX+0kIYlmi4hS/0lY03uCbxQbdYqsuiFoO7D0llY6kjILngVFBVKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZXqPpcW5; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524J3L8K3736527
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 13:03:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741115001;
	bh=npNmZUsz4PzuVsmva2/HxiISBOjQ9cagggGB11fsN5Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZXqPpcW521d6UGZNgpErU5ws2F3M9BtLIBVJk92WEQCYfxUSpv7dlftGUfx9G+EiE
	 uAHs4MwqK/zoilELY2hnnyngARUeGW5ooq4XJ9ChXDHTMtlPSchGrVECvnySqjw1qM
	 ZT6NJ2Qwtu919UsClM8dv3OsMewS5v/ndUSE3UCY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524J3LUd009671
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 13:03:21 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 13:03:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 13:03:21 -0600
Received: from [10.249.135.49] ([10.249.135.49])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524J3HKZ069921;
	Tue, 4 Mar 2025 13:03:18 -0600
Message-ID: <66283781-69d6-4d0a-ada4-3a6bf4744a37@ti.com>
Date: Wed, 5 Mar 2025 00:33:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/2] devicetree: bindings: mux: reg-mux: Update
 bindings for reg-mux for new property
To: Rob Herring <robh@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth
 Menon <nm@ti.com>
References: <20250304102306.2977836-1-c-vankar@ti.com>
 <20250304102306.2977836-2-c-vankar@ti.com>
 <20250304153959.GA2654372-robh@kernel.org>
Content-Language: en-US
From: "Vankar, Chintan" <c-vankar@ti.com>
In-Reply-To: <20250304153959.GA2654372-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Rob,

On 3/4/2025 9:09 PM, Rob Herring wrote:
> On Tue, Mar 04, 2025 at 03:53:05PM +0530, Chintan Vankar wrote:
>> DT-binding of reg-mux is defined in such a way that one need to provide
>> register offset and mask in a "mux-reg-masks" property and corresponding
>> register value in "idle-states" property. This constraint forces to define
>> these values in such a way that "mux-reg-masks" and "idle-states" must be
>> in sync with each other. This implementation would be more complex if
>> specific register or set of registers need to be configured which has
>> large memory space. Introduce a new property "mux-reg-masks-state" which
>> allow to specify offset, mask and value as a tuple in a single property.
> 
> Maybe in hindsight that would have been better, but having 2 ways to
> specify the same thing that we have to maintain forever is not an
> improvement.
> 
> No one is making you use this binding. If you have a large number of
> muxes, then maybe you should use a specific binding.
> 

Thank you for reviewing the patch. The reason behind choosing mux
subsystem is working and implementation of mmio driver. As we can see
that implementing this new property in mux-controller is almost
identical to mmio driver, and it would make it easier to define and 
extend mux-controller's functionality. If we introduce the new driver
than that would be most likely a clone of mmio driver.

Let me know if implementation would be accepted by adding a new
compatible for it.


Regards,
Chintan.

> Rob


Return-Path: <linux-kernel+bounces-398820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7CC9BF670
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6F1C22352
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C049209694;
	Wed,  6 Nov 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OuM3bfgw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FC18FC70;
	Wed,  6 Nov 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921301; cv=none; b=m9O/NwwNXauzZF9PcEteiGg6gQcJ7GCpZdyiaoJXZa0Vay0qGw9snsLyGs8Qu0mwkaTphI9vSzfStP78scKB5LGcpr/3+q7ZFl6aLJRoaNQZVFdLdVT/chiwR0vMeV4jBo3lnVmSTjN1Xv5nR5Uj2u/jS/mWhT9buOxwbBou+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921301; c=relaxed/simple;
	bh=VpT7mCqv/qDD22c2wJ4iIB7FKFIbqbbt4GZ8iMMqjcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IytfXQbnVuejf1dr4HnO9HoIG3Ln+JX9QZAgvuc7QwbZkzNz53XRRsruK97zoE6cH3CXUtiF+2uH6uJ9t6TGVBxM0QuJrVqt1vwFzQ7gdtK33iDlqF6klklJqoqU9E5bBq2YvtXkBCDz8jHcqnSeS4FrvK+ch/p5eTn5CaVDVok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OuM3bfgw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A6JS1Cp059816;
	Wed, 6 Nov 2024 13:28:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730921281;
	bh=OmW9YJ4a8eYvgIsVKSCPmHj6MoOFzCxyOx5EZEj2qDs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OuM3bfgwWyatKDkfmEhbD9A8NFyOVg6e7J1WeOjKq5fzeBJI2zGOgduT4OlCpKQ9e
	 vwx4+0hzv4MgLmK8z+ZXH5fMVXnXx/PAlqNHnGu/fwcmJVCw6iEEYKLe5Cj/rnYTdr
	 qC8WMlENfgyL4tJYJdfF1jOLyWur3b08yxwfDE5w=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A6JS18D090907
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 13:28:01 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 13:28:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 13:28:00 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A6JS0er095001;
	Wed, 6 Nov 2024 13:28:00 -0600
Message-ID: <610d6b2d-a041-48cb-90f1-d53114e475f7@ti.com>
Date: Wed, 6 Nov 2024 13:28:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] dt-bindings: gpu: img: Allow dma-coherent
To: Conor Dooley <conor@kernel.org>, Matt Coster <Matt.Coster@imgtec.com>
CC: Frank Binns <Frank.Binns@imgtec.com>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Randolph Sapp <rs@ti.com>, Darren
 Etheridge <detheridge@ti.com>
References: <20241105-sets-bxs-4-64-patch-v1-v1-0-4ed30e865892@imgtec.com>
 <20241105-sets-bxs-4-64-patch-v1-v1-4-4ed30e865892@imgtec.com>
 <20241105-linseed-steadfast-98cd8abe898c@spud>
 <5e26957f-dc79-42ef-a8a1-597fb386ae51@imgtec.com>
 <20241106-dried-spoils-f6ddd8020f40@spud>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241106-dried-spoils-f6ddd8020f40@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/6/24 12:30 PM, Conor Dooley wrote:
> On Wed, Nov 06, 2024 at 10:18:06AM +0000, Matt Coster wrote:
>> On 05/11/2024 18:06, Conor Dooley wrote:
>>> On Tue, Nov 05, 2024 at 03:58:10PM +0000, Matt Coster wrote:
>>>> This attribute will be required for the BXS-4-64 MC1 and will be enabled in
>>>> the DTS for the TI k3-j721s2 in a subsequent patch; add it now so
>>>> dtbs_check doesn't complain later.
>>>
>>> Sounds like the property should be made required for that integration.
>>
>> This is something I went back and forth on. Where is the line drawn
>> between things that should be enforced in bindings and things that only
>> ever need to be specified once, so should just be left to the dt itself
>> to be the source of truth?
>>
>> Having said that, I realise TI could spin a new SoC with a new dt but
>> use the same compatible string for the GPU;
> 
> No they can't. New SoC, new compatible.
> 

We don't need to make a new SoC for that, our bus infra allows us to
selectively include or exclude peripherals from coherency. The GPU
being `dma-coherent` is selectable at boot time.

Andrew

>> the "single" source of truth
>> then wouldn't be so single anymore. I guess by making this property
>> required for this compatible string, we're saying any use of it must
>> behave in exactly the same way, right?


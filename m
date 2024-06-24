Return-Path: <linux-kernel+bounces-227601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45459153EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5101F24451
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4B19DFAC;
	Mon, 24 Jun 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mqc/hYk6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FF19DF6F;
	Mon, 24 Jun 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246832; cv=none; b=fWmhtW86UjMbGveLeyF63eUX4HDyJmXJn6iOuP2qd7V/fyI6Vop5kkAq8eE41iHbsOxAoWboaJY9rb5Aks4hQmAxbAYY9bjE8dqGr/Gp4KzQpr78qVspyRbaqQ06qHeaSLt50+U1RHvTK0lNNgY1pS/VuTDH214PH5TUai+E5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246832; c=relaxed/simple;
	bh=IGbwXdFzVVVC8J3LcQvvs47dT5JIygTgPvdjH3cUZV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UDosmVnUsQ7PGTJXtOGpQ0hCoGTIj59QLoRadh23QX5xKzZLIAq7Nx1u3X+mzgrxeC7Xb6oCPIrEk14QnOpNnHc21r0029KJaB98p7bPsemUpyliXrM74L6AOKMAnCpWaH2+7S/LXgiS6qylVcm79Xu4oe0n/GDzXStypX/Q3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mqc/hYk6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45OGXhjW093075;
	Mon, 24 Jun 2024 11:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719246823;
	bh=LyzxEtnalIOT3X/WHYQzI/uymtmHBLKKY4oKDuw6WiQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mqc/hYk6nq6ypK9kp0vNS2KHxHsmb2GU6CmBQhpgxNC2PiYJg82kTa/tRkVEcF5LR
	 5gIznpo+KpiOAIlkuhzodn+YH/QspwG0YrtLzMG7MYlRIUEbxJ1osD+3xqlEhZuPSI
	 z/CfcyBMSxqsTXu88SKSFoiSaQTsLsLZJg674fgo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45OGXhB0072426
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 11:33:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 11:33:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 11:33:42 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45OGXgwd127091;
	Mon, 24 Jun 2024 11:33:42 -0500
Message-ID: <24c0ed06-3c32-4cc3-922c-4717d35a1112@ti.com>
Date: Mon, 24 Jun 2024 11:33:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add global CMA reserve area
To: Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
References: <20240613150902.2173582-1-devarsht@ti.com>
 <D1ZXO8F3XN2I.3CTTE245I0TYY@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <D1ZXO8F3XN2I.3CTTE245I0TYY@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/14/24 12:58 PM, Randolph Sapp wrote:
> On Thu Jun 13, 2024 at 10:08 AM CDT, Devarsh Thakkar wrote:
>> Add global CMA reserve area for AM62x, AM62A and AM62P SoCs.
>> These SoCs do not have MMU and hence require contiguous memory pool to
>> support various multimedia use-cases.
>>
>> Brandon Brnich (1):
>>    arm64: dts: ti: k3-am62p5-sk: Reserve 576 MiB of global CMA
>>
>> Devarsh Thakkar (2):
>>    arm64: dts: ti: k3-am62x-sk-common: Reserve 128MiB of global CMA
>>    arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA
>>
>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 9 +++++++++
>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 7 +++++++
>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++++++
>>   3 files changed, 24 insertions(+)
> 
> I'm still a little torn about putting this allocation into the device tree
> directly as the actual required allocation size depends on the task.
> 

That is the exact reason this does not belong in DT. For everyone *not*
using the most extreme case (12x decodes at the same time), this is
all wasted space. If one is running out of CMA, they can add more on
the kernel cmdline.

> If it's allowed though, this series is fine for introducing those changes. This
> uses the long-tested values we've been using on our tree for a bit now. The only
> thing that's a little worrying is the missing range definitions for devices with
> more than 32bits of addressable memory as Brandon has pointed out. Once that's
> addressed:
> 
> Reviewed-by: Randolph Sapp <rs@ti.com>
> 
> Specifying these regions using the kernel cmdline parameter via u-boot was
> brought up as a potential workaround. This is fine until you get into distro
> boot methods which will almost certainly attempt to override those. I don't
> know. Still a little odd. Curious how the community feels about it.
> 
> Technically the user or distro can still override it with the cmdline parameter
> if necessary, so this may be the best way to have a useful default.
> 

The most useful default is one that doesn't eat 576 MiB of memory "just in case".
Needing that much CMA is the exception case and should be the one that requires
adding something to the kernel cmdline.

If the kernel cmdline option does not work in some cases then we should
fix that instead of hard-coding a workaround here in DT. We are robbing
ourselves of a better solution here.

Andrew


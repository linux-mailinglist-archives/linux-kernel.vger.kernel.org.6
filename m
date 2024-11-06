Return-Path: <linux-kernel+bounces-398888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759EB9BF794
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C78B1F21EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2420C012;
	Wed,  6 Nov 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0rmALPBs"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972B20BB46
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730922467; cv=none; b=U9HWcsq4a3aJrgOnOyzmRJB4Bn3YyLzGxnjipbiWTqjhZe2DNnPUiiBvpuhmX2UtI70rQpVRi6XH5u7nygmDdldXdS+qTilz5ioUSFwT89qZf/FWf9PUfV/RZIz+Rvw5TrhhanIiYC/6YKF8wYNgJQfN5WLyQOuZYzpoQnWh0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730922467; c=relaxed/simple;
	bh=nfhOeOMNhx9ro9r5EU5bckyL1gdmm5pMCHqroYTsqXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6e0kIS7LS55QYkb5zqu7nIswZQUIK9tHGx2mex9o04IBD8YxJ9TpmlhzuwTnrGPtQWzr+uShlEYSJuNyEWwXkSn6lp0LZiBvLrnRaE1MnMIvUZuxY10AahYKBsWLES4XjGokd9K9omsJgxTjw11me5iDk0uORxbdgCu1inUpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0rmALPBs; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A04BE2C01F6;
	Thu,  7 Nov 2024 08:47:42 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1730922462;
	bh=ScnBUtaeifvVVpugBAsbHCHfD79Y+oTex2Xsw6PXO/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=0rmALPBsk3KpDQon2NIfxmI5YGmR8qtmfG47c6yl0Svgg53uDndquPoraimagPC+1
	 MroiuHdN/1BN90MmoNhdcM87Qsozu4IkFUsY4Tc2qjljo7Y5mZDqz9hkTJkL43cp7I
	 R8ab9gLvAgKpPBiWXxgAwxf/+l1EuhZRSSqSqf/5ZL161LtjNzAjnLj+p1vVGFXlIC
	 QV5aLFBZ2nPlpZ/O48/GCcIcNtZwqPFlQGwRGBbcPEHUaARzQYGM/MIkimTkXEkiGD
	 yOnahh76/7A0h06A1KW4adYKZGw4F69xegWjbgNQZDw5Rnb49aNyewHqf1pshCYGEO
	 Mg6k4dh9WZ4Yg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B672bc7de0000>; Thu, 07 Nov 2024 08:47:42 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 73C5C13ED6B;
	Thu,  7 Nov 2024 08:47:42 +1300 (NZDT)
Message-ID: <d7ceaf59-8e39-4c76-9b9f-88746a22176d@alliedtelesis.co.nz>
Date: Thu, 7 Nov 2024 08:47:42 +1300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v9 4/4] i2c: Add driver for the RTL9300 I2C controller
To: Andi Shyti <andi.shyti@kernel.org>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 tsbogend@alpha.franken.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-i2c@vger.kernel.org
References: <20241106001835.2725522-1-chris.packham@alliedtelesis.co.nz>
 <20241106001835.2725522-5-chris.packham@alliedtelesis.co.nz>
 <vn6t6qxqry2ay4tbvo3cb4rbjv53pnyl56vangul36vvvxibwp@q3pssbthesef>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <vn6t6qxqry2ay4tbvo3cb4rbjv53pnyl56vangul36vvvxibwp@q3pssbthesef>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=672bc7de a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=62ntRvTiAAAA:8 a=jdP34snFAAAA:8 a=VwQbUJbxAAAA:8 a=ovCuDd3x2qG2uVDzZbIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=jlphF6vWLdwq7oh3TaWq:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 6/11/24 22:57, Andi Shyti wrote:
> Hi Chris,
>
> On Wed, Nov 06, 2024 at 01:18:35PM +1300, Chris Packham wrote:
>> Add support for the I2C controller on the RTL9300 SoC. There are two I2C
>> controllers in the RTL9300 that are part of the Ethernet switch register
>> block. Each of these controllers owns a SCL pin (GPIO8 for the fiorst
>> I2C controller, GPIO17 for the second). There are 8 possible SDA pins
>> (GPIO9-16) that can be assigned to either I2C controller. This
>> relationship is represented in the device tree with a child node for
>> each SDA line in use.
>>
>> This is based on the openwrt implementation[1] but has been
>> significantly modified
>>
>> [1] - https://scanmail.trustwave.com/?c=20988&d=pL2r5zHAPsW8d92uECdR2T8Eh4fYX_ZwrCyklfTCzQ&u=https%3a%2f%2fgit%2eopenwrt%2eorg%2f%3fp%3dopenwrt%2fopenwrt%2egit%3ba%3dblob%3bf%3dtarget%2flinux%2frealtek%2ffiles-5%2e15%2fdrivers%2fi2c%2fbusses%2fi2c-rtl9300%2ec
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Thanks for following up with v9. I think nothing prevents us from
> already merging this 4/4 patch, right?
>
 From my end yes it's all good to go. Lee's just applied the mfd binding.

The only thing outstanding are the mips dts changes. I'll wait for a bit 
and chase those up. Hopefully they can make it in the 6.13 window but 
it's not the end of the world if they don't.



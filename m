Return-Path: <linux-kernel+bounces-317216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2049796DB07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E2B283FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0928119D8BC;
	Thu,  5 Sep 2024 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="FFphVU9R"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66B19D063
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544995; cv=none; b=Z8krRO2PXIxugk8fjPPX32awmuNuPahcw8OGZIdZY6aUbX/FxkE6opWICgkpmexkgbmD575Ck9BiDTES5E2kh/OGY9HNA55DytfzvqtuGOJpaiGtsI/k4pgmbVs12nY1REqRiKterxlkYxIwJT3WDboRx++KGuk8OSwsnNjJ9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544995; c=relaxed/simple;
	bh=qVVmZHEGo3YPLLnhYn/749edEQt5zJWBDyIPA6BVyiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZDABDxzgDj/7P7MUmk+8Rfos9c3mLrik7hcSBQdhrlmpt+xULpfclz5qU5+Kem/vZymuOcviPS7Ydn3l46XkSUJ6YJDL2sjqeav7qUEDFYFjcc/+wIuldjnYCSjVmiW3Kqait14E/+J01YtrL6fHW0XhPVbRsWRtyXw4cjw70mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=FFphVU9R; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C13E1C0004;
	Thu,  5 Sep 2024 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1725544984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Omm3nbKM0g5DEI2dhVeOtf3EKb1ifBOqrNP1BMzEfjo=;
	b=FFphVU9RS3dfUGreSD5t+FjwIv9fasMiLi3r4ZeOrRMGmDiIu4Z73FkHKrLspGwCOGevH5
	UghrV06Hbz3mRmmB8zprIxw8qiilCUaN1XZAKH1L765OD8/7+GMTj7vZTc+wOMoFGX43Z1
	fecyVCzxZ90dMh/jEfaFk88723XIr+t4fd+TU57LqmpMu7TxWWILcuFeupCA0RsY9Dz9z7
	reX9JcKzQNKoC6W2pMgl5WOE7uRSMoyakqOtltELbVG6TucFbXvTCOVUOdJvHJgTDW4XZo
	32xQQgWdOJwSBAHEvzej59D/SfjIQC0z33FOSPeHSxWrCW3mh8657oHmWeAO1w==
Message-ID: <cc318d16-941c-49e5-b54a-1c52c5f47011@yoseli.org>
Date: Thu, 5 Sep 2024 16:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] m68k: disable SRAM at startup
To: Greg Ungerer <gerg@linux-m68k.org>, philippe.demuyter@macq.eu
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20240904-fix-cf-virt-mem-sram-v1-1-fb007028d717@yoseli.org>
 <30445b83-50eb-40ae-a2db-43b98d0c3224@linux-m68k.org>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <30445b83-50eb-40ae-a2db-43b98d0c3224@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Greg,

On 05/09/2024 09:52, Greg Ungerer wrote:
> Hi JM,
> 
> On 5/9/24 00:26, Jean-Michel Hautbois wrote:
>> Some of the internal SoC registers have a higher priority over the MMU
>> virtual mappings. The SRAM bank is one of them. If the bootloader
>> enables the internal SRAM at address 0x80000000, virtual memory access
>> at this address will not hit the MMU - so no TLB data misses would
>> occurr.
>>
>> Since 0x80000000 is the virtual start address of all applications that
>> bit of memory is getting stomped over with inconsistent code and data
>> access.
>>
>> Fix it by disabling the internal SRAM at startup.
>>
>> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
>> Tested-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
>> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> 
> I know this change fixed your specific problem, but it is not going
> to work as a general solution.
> 
> For one not all ColdFire parts have an SRAM region and thus not all have
> a valid %rambar register. Secondly some ColdFire parts (like the 5249)
> have 2 SRAM regions, with mapping control registers named %rambar0
> and %rambar1.

Thanks for this clarification. TBH, I sent the mail and thought about it 
after :-(.
The patch is in my branch, and solves the issues in [1], so I decided to 
send it.
*But* I should have asked first your approval as you are the one who 
found it and mark it as RFC probably. I'm sorry for that...

[1]: 
https://lore.kernel.org/linux-m68k/mvmed8dlewg.fsf@linux-m68k.org/T/#m0e4c8f0b9df0a03f3d0b5cf2246661d0bb3a370b

> 
> Some ColdFire uClinux applications use the mapped SRAM, so a blanket
> disable is not the best idea in any case.
> 
> I am thinking it would be better to have a new Kconfig option that
> allows disabling by the startup code for those ColdFire parts that
> have SRAM (so appropriate "depends on"). That way it will only be
> disable when that is what is needed. Maybe also have that configuration
> allowing to configure and set the rambars so that a mapping
> can be forced on if wanted.

Interesting.
I will keep this patch for my own case for now, as it does not apply and 
wait for this Kconfig option to make it clean !

JM


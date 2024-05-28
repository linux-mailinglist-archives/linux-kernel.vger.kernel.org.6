Return-Path: <linux-kernel+bounces-192145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C98D1913
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8FDB21EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7513E3F6;
	Tue, 28 May 2024 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Pe8RHyiH"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA0F1D53C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894084; cv=none; b=Qw+3tYJqRIynqIJvhxAWHRJHFUQj06HUJy3qMu0D9iHDIUZBM2P4IXzcOPvXzyQFGJTkEIqXq9WRNzS2WfdW13gvaQ6jQntjqIqAYETCNkzIM2zCdcjYmNKnClmK7m9DrhmYneoGAnQxsxuEQ7ovJGs7TO+IhVj1nA5DWD8qNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894084; c=relaxed/simple;
	bh=qHBg++ZXUpCyhoDHP9xsGXpvWY1GcL8iyx14Q9IhRGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UhmkJIaeIWGJvFgLQkfmZS8FRrjWa1ZrqZ0VO1/g63+2EnKNJihr4g9KrfwqBoW8WIAiBfrCWhBszwGBK/VyEXQtLfToy23mMhPYZYEE0H8kDCuKHvvmBqGYWkPFHqoJJicDscqMWBBdamIDK6rLgve3NqGwAsoSTQoucf7H68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Pe8RHyiH; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Hs/HaD02iDeto1uLspqeiJWInIgpGjlvaek2azNHp58=; b=Pe8RHyiHjJYpdVm8fFoeYeRPkS
	3xkMMMGxye0zx+UtVGsa64mID/7Afu8Td7szz69x6LWa+osV9j5lKjZS7UEKaKuH39HTthO8lh2WZ
	BWZw/TCFkjOgBQpRcVsQwh5iyY+3FrHLc1d7+PCpC17S8lnuEAqopJ3VtwSOaPRvydmS8Zk2K/kF/
	BgDY6YL5aRzQe4W6n7mABxANtdo5EowU8Tft/ND0T/LUtahPJiBmagekAtGqdnjut7BnUpMffWCWQ
	t9wkjbaDvLC1kfIq67FXTuLdIMlZWmNoNt8z2o3DBZkyXrpXPayG1LRs0wmBW8cC94+dpP0rsoK0x
	5kWplkaA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBuZy-000PLs-Td; Tue, 28 May 2024 13:01:18 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBuZy-000AHn-2B;
	Tue, 28 May 2024 13:01:18 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <ccdacf52-1b31-43a1-a8fd-33a252e24d51@kernel.org> (Krzysztof
	Kozlowski's message of "Tue, 28 May 2024 12:21:02 +0200")
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
	<979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org>
	<87cypc38gu.fsf@geanix.com>
	<9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org>
	<87le3zoatn.fsf@geanix.com>
	<6c166ad5-8004-4bc4-9107-a47ba9a72161@kernel.org>
	<87ttijaglp.fsf@geanix.com>
	<c045f1a4-9ddf-4c53-a69b-22ceb68a1ce8@kernel.org>
	<87msobaes6.fsf@geanix.com> <87ikyzae7v.fsf@geanix.com>
	<e3aa72af-c824-4b71-a99d-c0b9294bfd8a@kernel.org>
	<87y17ul0cb.fsf@geanix.com>
	<ccdacf52-1b31-43a1-a8fd-33a252e24d51@kernel.org>
Date: Tue, 28 May 2024 13:01:17 +0200
Message-ID: <87plt6kxoi.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 28/05/2024 12:03, Esben Haabendal wrote:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 27/05/2024 09:47, Esben Haabendal wrote:
>>>>
>>>> Ok, I seem to still be confused as to what you want from me. If you are
>>>> saying that the kernel is not supposed to care about out-of-tree DTS
>>>> (and thereby any bootloader provided DTB), I would like to bring your
>>>> attention to arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts in upstream:
>>>>
>>>> &ifc {
>>>>         #address-cells = <2>;
>>>>         #size-cells = <1>;
>>>>         /* NOR Flash on board */
>>>>         ranges = <0x0 0x0 0x0 0x60000000 0x08000000>;
>>>>         status = "okay";
>>>>
>>>>         nor@0,0 {
>>>>                 #address-cells = <1>;
>>>>                 #size-cells = <1>;
>>>>                 compatible = "cfi-flash";
>>>>                 reg = <0x0 0x0 0x8000000>;
>>>>                 big-endian;
>>>>                 bank-width = <2>;
>>>>                 device-width = <1>;
>>>>         };
>>>> };
>>>>
>>>
>>> I don't understand why it took so many emails to answer that (my first)
>>> question...
>> 
>> Because I did not understand the question. Primarely because I was (and
>> is) surprised that out-of-tree DTS is not supported. I was convinced
>> that out-of-tree DTS was the right way for hardware which is not
>> commonly available.
>
> Even some non-GA hardware could, and IMHO should, be upstreamed, at
> least some parts of it. This gives the user/upstreamer reason to do
> changes. Otherwise you might get questions for contributions: why you
> are doing and why this is worth?
>
> Downstream or any fork is not really answer to such questions, because
> they are allowed to make whatever stupid choices they want (not saying
> it was done here, but in general), which should not be a reason to do
> anything upstream. If downstream creates wrong DTS files, shall we
> create wrong device drivers or bindings for them? No.

Of-course not. But to be fair, in this case, there has not been any new
bindings created, and no creative usage of existing bindings. Only
straight forward usage of existing drivers (IFC and physmap MTD driver),
which I am surprised no one else had seen the need to fix in upstream.

But do you/we really want to open the flood gates for DTS maintenance of
a gazillion embedded boards that only a few in the world have an
interest in? I suspect it would create quite a lot of patches to flow
through maintainers, with very litle benefit to most people. But for me
(as in the companies doing such these kind of embedded hardware), it is
a clear benefit to put upstream DTS files.

But what about boards where device-tree is created/modified dynamically
by bootloader? Is that also not really supported?

>>> Sounds good, however you did not update the existing select.
>>> Drivers are not supposed to select user-visible symbols (leads to
>>> issues), so you need to change it to depends and update defconfigs.
>> 
>> Do you wan this split into multiple commits, or a single commit changing
>> the Kconfig to make FSL_IFC user-visible, and changing select of it to
>> DEPENDS, and updating the related defconfig(s)?
>
> One commit for Kconfigs (nand and memory), additional commits for
> defconfigs, one per each arch, because defconfigs might go via arch tree.

Sounds good. I will send a v2 with that.

/Esben


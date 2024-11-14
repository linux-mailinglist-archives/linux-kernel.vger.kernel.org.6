Return-Path: <linux-kernel+bounces-409578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414FD9C9030
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03212B2D559
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F45318E044;
	Thu, 14 Nov 2024 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NYdB1QUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T8N/2fmM"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F83433C4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599136; cv=none; b=fzl/ahriv/ezi32zJjKPEoovPfBqFWdjPmkCnmnViFl2L91vsLUA7uLw+sYgTm4QePlSJRBUHza++/kYya4LnbZcs8r4Ded0LYyMDcwuje29Z0/BtvZP2LR7fs80AJT+Rzkj9NWz2lF/IRmRm7eaLrnN+6XJySH63116rZW+T+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599136; c=relaxed/simple;
	bh=dZZpctvg4cXmi7QP+x1Z7D9U2+hXXw/04WokTnCvB+4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OB7HY6CsTkoMaIqd2NqgKzPa302aa/Dwz7cpH+bWK1optul14TmfqJigxa3k20PGapxSb+/b5aK3kaL6X9vmdwG85lab6f3txZ5LHlDDDQru09sD9g5R2Rk48GzeBeVZM1VkB1QEyubw84RzUwJHFHfXWHWhgWn2MD8Fx0EPXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NYdB1QUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T8N/2fmM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 40C28138052E;
	Thu, 14 Nov 2024 10:45:34 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 10:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731599134;
	 x=1731685534; bh=dZZpctvg4cXmi7QP+x1Z7D9U2+hXXw/04WokTnCvB+4=; b=
	NYdB1QUftjiu8yfKZSVsZA7OM6nGKB5Mled5FHNvEo98Ou6uwaHmqDn5nveL0sk6
	ApXUvEZRvwoSPyEerdMQJvLvAD/GHx5hpT1j9BP0AGELp32NlpPElBXwUJT4Rob6
	Myvsy8+4gKw2LPbYMqT6aUrLAO/Jq/t59+SNUN5HXS92wpSvc5WFDVaT/LUgaoJD
	yolnzy1Vlg5G1qNEOW7cF9djA5cfOmv0t+oYEBaB11S8uSXV0pP9jYJdqJeBluRu
	KJ0dodE6njkX22gLtGsL0OGchkKd4ARDtLc8/EbvX4wxh8SNFw9uxQ0fuAljt2Fr
	1YWKNrMpxpaRByBAEeaugA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731599134; x=
	1731685534; bh=dZZpctvg4cXmi7QP+x1Z7D9U2+hXXw/04WokTnCvB+4=; b=T
	8N/2fmMfngFGh2rrTJ2h3Zmc6TZ4rIFZprR54GDAjjo1OHgnmTA+I0C+kw5OkD2T
	5nxgTeohz5bhPQ9OfGCdsVKzXoaTDl3g3PX1z08KSR7+l75rNP1pkDNOn8EPX630
	NpCZe8sK9P4mJjfLcJJKj0RYg3ohLEAWG0r6w9dhDZh48PrMdzi5CtLLL0Jp97y2
	Vib+5Nm5EByCWZuzg1nrQuwu94/FUMF0sNNVxT7OxAnV4vbAMUiP47PchQKHpuQR
	n+s/yNGVmdzIEjDiUwfJtqnTta5+R8I9qv+VRcSxyezMffE4dJRRkXKzEfsbNEYo
	C3B9kR1yv+URO3uQtJA1A==
X-ME-Sender: <xms:Hhs2Z8rSh6Q8mt9z6de7FBXWRuzEsG8qnnhAX4DDJ9d8lvihUiaGdA>
    <xme:Hhs2ZypYZNvP9hZ9G_DShkyxiQVgihEG0yn0NxGHm77q4nbdncOkMaPIxBqie1uGq
    y7cvwHbh_EZTCNUn2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeej
    vdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrihgurd
    gruhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphht
    thhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Hhs2ZxOeBzumBig847DmLOftFZN_o2HFA-13jIpyznx2XYe3V9aOdA>
    <xmx:Hhs2Zz7MqnJUWCq5xP5HVv6gjlTjWoczs4e2a6lm_2LTM3eN_9FAGA>
    <xmx:Hhs2Z75upI_PvdXUQ2VeKvL-i_C6zaMEaUhdCw8hmHWN-3THoHl0hw>
    <xmx:Hhs2Zzh3kECjJhxfTRbPt_5jBhw0hdAHHhBN_DIJRLbFhJzen93n8Q>
    <xmx:Hhs2Z9mLa_WxExSrbcQYpZ4-eSAjyIDa2GEYP_BeTJfAjB8O0AoM9pUb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EDFEA2220071; Thu, 14 Nov 2024 10:45:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 14 Nov 2024 16:43:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Michael Ellerman" <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <acec6edb-59a0-4c9e-91ca-b152381a6542@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdWBZJvVaKiWk_VaHY0ZQiaezn9Kqa0XpTXKzf0gh_rG+g@mail.gmail.com>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <CAMuHMdWBZJvVaKiWk_VaHY0ZQiaezn9Kqa0XpTXKzf0gh_rG+g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024, at 15:31, Geert Uytterhoeven wrote:
> On Thu, Nov 14, 2024 at 2:11=E2=80=AFPM Michael Ellerman <mpe@ellerman=
.id.au> wrote:
>> CHRP (Common Hardware Reference Platform) was a standard developed by
>> IBM & Apple for PowerPC-based systems.
>>
>> The standard was used in the development of some machines but never
>> gained wide spread adoption.
>>
>> The Linux CHRP code only supports a handful of machines, all 32-bit, =
eg.
>> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possib=
ly
>> some from Motorola? No Apple machines should be affected.
>>
>> All of those mentioned above are over or nearing 20 years old, and se=
em
>> to have no active users.
>>
>> So remove the CHRP support. If there's interest in still supporting s=
ome
>> of the machines that can be brought back from the git history.
>>
>> Note there are still some references to CHRP/chrp in various comments
>> and some in the code, because later standards (eg. RPA, PAPR) used so=
me
>> elements of CHRP or copied the CHRP behaviour. These will need to be
>> cleaned up on a case-by-case basis to either refer to newer standards=
 or
>> left as-is when that's correct.
>>
>> The CHRP code was copied from arch/ppc, and before that it mostly
>> predates git, so the original authorship is largely lost. If anyone
>> wrote any of this code and would like a CREDITS entry just let me kno=
w.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>

Whole series

Acked-by: Arnd Bergmann <arnd@arndb.de>


Return-Path: <linux-kernel+bounces-389437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3F9B6D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EC47282D90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E11D0400;
	Wed, 30 Oct 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uPt6kKOo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0Uk18Jr"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30E1D0DE6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317860; cv=none; b=T9D8fOcr8H0cOan9QsT91QtzqDIkVYSrmJriKcKCi0W/Clctp/dggkrk5tIuMoUkQMNzWXDhkMVDI8GJnf+mOdUpx1srwDfNLGzMLf17wi9AFK9JAvNz84WGzvQLS+rzae3tieWN76cg4fBnqNvGW8gGg/PvLREdsAVdQHrDr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317860; c=relaxed/simple;
	bh=+nzOCBc/wjXtHobKLUDFTq6IHeq4topcyWsXuWINEdM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sa5X5w9dHtAaBba95/RkPO/v1pHtCmvR8M8WK2IMoPfWberBTlP2ms2A3+wsQyZz7eOv6Qc7bBsgAA/6kLB0efyNr3FhoW1B7fPVi5XNoi+X9CGDj6E8KUE1U4LUFA+Mu8qNc7so1/CqrgOGVjPe4+TL10TlbAD3yq40dwbWzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=uPt6kKOo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0Uk18Jr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B18C25400F9;
	Wed, 30 Oct 2024 15:50:55 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 15:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730317854;
	 x=1730404254; bh=Weyhm/0lKDkxwZ9NlzdP58yGW7aBHjGRbeLW9BvpyXQ=; b=
	uPt6kKOo9PDGuuhJHkisxP5GrxUlevekmm8trTkWTrOzTKq2EoulPqJ6Baajko65
	lHoLYYy/Ctbhw1luJchuuy7xETES54PuWS7ZWQjUtzUnAOQUbysMq/hGgISFnxma
	aDgCMqTrS4cOoxkbj66cI3hQ01SJzZ1l0DM/cwjwvkepVXDka+VB3Zur1SM9f3wz
	xrcaCJtlD7gGkpUDOc6D4pZYzms0Z0gUMEddPYVG1z9muCcswT4X8zolZn8NiNre
	00A8efQ7Q8xdLFBbtJCnCNZm9iKHLILeQOcVcRuErEUzf2EZKbXZS/+6dClaPE1I
	KMJDqbUgF01zNoOyuucEtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730317854; x=
	1730404254; bh=Weyhm/0lKDkxwZ9NlzdP58yGW7aBHjGRbeLW9BvpyXQ=; b=i
	0Uk18Jr76emzGxvwwqCVd33VPjL+y5Ekv+UIU/izPELwtURULc99+vadOoeU9zQB
	zJ7wKa/fc2pKKtzNf8lYDyx6a8ZRCb/g5POf4wD7tE5YbMAa2235ZH71yLy4q9n7
	NSr4zIJLKKY6jZDmvEPrpL2veLDazKmtuBpNn2Z3ohUkEhBlDJsoy81FWrMhWlWy
	Cqk6Fh6UUWYtJYBSoLRfksEZNQoEdBF1xF63e9axulsymmSiliDX4GmfGFfgmUEP
	Qb89cLmcLXhCNtdI9XcpiJ4meyTRGPyW20yOezl3u6+W0eXR2TdEeMnHh79i3Xbp
	NZeZdVPG6wUgrx50lMBMw==
X-ME-Sender: <xms:Ho4iZ22p3jWCyF-xwhFYVIeQImwLDXgYdR8rTZ17liLzCT5NV8XJ7g>
    <xme:Ho4iZ5EtePrP_YMaE9Isk2ROL2RdqXIusju4PVecdYSBq2rY9hlod3lRkygKiAgge
    z3qA34E0wp782Ad4gI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekfedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpd
    hrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgvggvrhht
    sehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehgvghrgheslhhinhhugidqmh
    eikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhn
    uhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ho4iZ-4EKFVdfJBxBgo2OLkOe3eyoGpEN5Zp7dznwXUf70M1hVubYw>
    <xmx:Ho4iZ31Zw2ro_P6qXMconOvqtY5_UR-Yrz-59fMTG3rTcM3mKGWJKg>
    <xmx:Ho4iZ5EsExmrHmR8G5qRxAAhE4XF5Mhbs5qlctcPmKAUx7VfFRNEAQ>
    <xmx:Ho4iZw_cxjsMgSCX8OQG30DNqfjhrNEyCOSxiTR6aGzlQSu69JpXOQ>
    <xmx:Ho4iZyMiCQ1BeGnh6FsfJ_pdn9DgueVKay4-bbHqmf3TnFU4ZGdmtmV3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 05DDE2220071; Wed, 30 Oct 2024 15:50:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Oct 2024 20:50:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "kernel test robot" <lkp@intel.com>, "Greg Ungerer" <gerg@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <23106647-abcd-42ee-8e09-cca4cb9cc0ee@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdVC-FUSA5C9aNrvP3=RaRWrchhUEC5UYcSGMz_ep1PEhg@mail.gmail.com>
References: <20240803140115.3305547-1-arnd@kernel.org>
 <CAMuHMdVC-FUSA5C9aNrvP3=RaRWrchhUEC5UYcSGMz_ep1PEhg@mail.gmail.com>
Subject: Re: [PATCH] m68k: move sun3 into a top-level platform option
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024, at 13:08, Geert Uytterhoeven wrote:
> On Sat, Aug 3, 2024 at 4:01=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:

>> +       help
>> +         This option enables support for the Sun 3 series of worksta=
tions
>> +         (3/50, 3/60, 3/1xx, 3/2xx systems). These use a classic 680=
20 CPU
>> +         but the custom memory management unit makes them incompatib=
le with
>> +         all other classic m68k machines, including Sun 3x.
>
> Yes, it's a good idea to factor out at the top level machines that
> need special handling.
>
> However, the name of the choice now sounds a bit odd. Perhaps it should
> be changed to "CPU/machine family support"?
> Likewise for M68KCLASSIC.

Changed for v3 now.

>> -if M68KCLASSIC
>> +endchoice
>>
>>  config M68000
>> -       def_bool y
>> -       depends on !MMU
>> +       def_bool M68KCLASSIC && !MMU
>
> I think this is unrelated, and should be spun-off into a separate patch
> to fix the "no CPU type selected" issue?

This change is actually needed here since I'm moving
it out of the 'if M68KCLASSIC' block. There is no change
in behavior here, only adapting to the other changes.

>>         select CPU_HAS_NO_BITFIELDS
>>         select CPU_HAS_NO_CAS
>>         select CPU_HAS_NO_MULDIV64
>> @@ -56,7 +66,8 @@ config M68000
>>           a paging MMU.
>>
>>  config M68020
>> -       bool "68020 support"
>> +       bool "68020 support" if M68KCLASSIC
>> +       default !(M68030 || M68040 || M68060)
>
> Part of the "no CPU type selected" fix?

It turns out this was just wrong an broke COLDFIRE builds.
I've replaced it with a separate patch that works.

>>         depends on MMU
>>         select FPU
>>         select CPU_HAS_ADDRESS_SPACES
>
> You also need:
>
>     config M68KFPU_EMU
>             bool "Math emulation support"
>    -        depends on M68KCLASSIC && FPU
>    +        depends on (M68KCLASSIC || SUN3) && FPU

Added.

>> --- a/arch/m68k/kernel/Makefile
>> +++ b/arch/m68k/kernel/Makefile
>> @@ -5,16 +5,8 @@
>>
>>  extra-y                        +=3D vmlinux.lds
>>
>> -obj-$(CONFIG_AMIGA)    :=3D head.o
>> -obj-$(CONFIG_ATARI)    :=3D head.o
>> -obj-$(CONFIG_MAC)      :=3D head.o
>> -obj-$(CONFIG_APOLLO)   :=3D head.o
>> -obj-$(CONFIG_VME)      :=3D head.o
>> -obj-$(CONFIG_HP300)    :=3D head.o
>> -obj-$(CONFIG_Q40)      :=3D head.o
>> -obj-$(CONFIG_SUN3X)    :=3D head.o
>> -obj-$(CONFIG_VIRT)     :=3D head.o
>> -obj-$(CONFIG_SUN3)     :=3D sun3-head.o
>> +obj-$(CONFIG_M68KCLASSIC)      :=3D head.o
>> +obj-$(CONFIG_SUN3)             :=3D sun3-head.o
>
> Nice cleanup ;-)
>

This also needed a small fixuup to not break dragonball,
using CONFIG_MMU_MOTOROLA instead of CONFIG_M68KCLASSIC.

      Arnd


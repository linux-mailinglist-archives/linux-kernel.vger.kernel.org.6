Return-Path: <linux-kernel+bounces-379423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A749ADE82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6181C21780
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0451AF0C4;
	Thu, 24 Oct 2024 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y6zDDair";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cxKxF3cN"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB84189BB3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757361; cv=none; b=PAVYUs/Loitfdjl7KZrsEsoaKEpzf9xqjllgoBo3IFHYYEHQbGOfr3GvBYSZm2ExQtiLo4qhZR6hXaA+QeAXksYIlEy8iQxHd6cDWihNOvsEVQC12v260j7jOR1SV+tyoY0m19IYGBPmAdbZeRrZMw2SK9KBYgwmaSSWVL5Y4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757361; c=relaxed/simple;
	bh=WOqw0Djbc9Hh1hvZsJrtM4woJlLdorFI6wJMRtv0hfg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tx/a0mlHElvK1HilOmawyH4t0P6vlI2XZ3ovqv6aIU6dNt98KteY/DG8TsaSiK0CMKTOR1NkvZX865bryHfJQlb04jy9w3sL7eQrV8fzIVqIdl5Strgunx28dOdBZbWWRX1ECZbbe611saSz3yECghn008iV+I46pPDqVxkGzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y6zDDair; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cxKxF3cN; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9641313806C7;
	Thu, 24 Oct 2024 04:09:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 24 Oct 2024 04:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729757357;
	 x=1729843757; bh=gQaF+79cQZijj/qtQUTCeQHllpXrfS9t+GtV65dW5Oc=; b=
	Y6zDDair2auGgJ9yJm7Xao/KZ5t61AUvksK8EAMlltt3bkedIhgVWL+c954aObHN
	FmcnLvlXPzy1lJZeO0ACOpk0TwpOXv3XB3v9bLwbP8OGY85vk5bnKqASCLqW/Lbq
	oYxLtq5XvquwNfcdHc4AyZSrUIDvGcLRruy9rwkpR3Gsab1YhHu1VewkwA+isKzO
	dgq7TcsZn2E5b2Rp8quz2IVmqK4H+dV88Dn9ONLgBmbwrQJoxRWcMRvWofL7N5fd
	QLF6W7ZB+MJVRjnIs32MEvi5iEP82jhtknw2pWJKPIP1tjxelafRoB4UiFsBTcfX
	yviDVOIc+G/XFZutPeBmiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729757357; x=
	1729843757; bh=gQaF+79cQZijj/qtQUTCeQHllpXrfS9t+GtV65dW5Oc=; b=c
	xKxF3cNKAaNnqqX6Rc3YFMnYG4hFQo9LHPNz5xRKI83FuWoMtOxYYrOcPFcWKfZu
	tBnA6PJ2qDM7Jzz1Yrhct2XZqZ2hywxRB3hh9aqG3ODefpAc6OvGc/lvjVleq1zz
	GLNxUgmJ6hWIlqCqVV1u2hNVlZxysfJL9e2CsPtK4tcRpuyXIr80T1c1mEUGCdl2
	8sLT+k/kACPvbM9vVOFZ4VLC0SYOoe7/zFEJQ4gOnpym1bTDDh05XnT0/8waOKjD
	GQDtI4/5WRXwvDFxhhTkdaUp+IzF6edAd1ek8ROW4BmaWKlf4Ao46Jdg7ZbbbH6F
	jT65P+QdebciGlZt54TyQ==
X-ME-Sender: <xms:rAAaZ0Bhc7XczeK7eJeFtem9jzEH9pHq_cPfYCwlqXKnBxNyVOcZgA>
    <xme:rAAaZ2gEdlovl0LfbO7md2A-DpV9UeMaaCFB2TdxgGzGRnwWxNimid-hoezmtqEBl
    XwMC7dENMj9YANpv7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeikedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghishhhfigrrhihrgdrthgtvh
    esrghrmhdrtghomhdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhm
    rdgtohhmpdhrtghpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtg
    homhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrsggvnhhnvggvsehlihhnrghrohdrohhrghdprhgtphhtthhopegrnhguvg
    hrshdrrhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehnrghrvghshhdr
    khgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhi
    guvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhho
    nhhigidruggv
X-ME-Proxy: <xmx:rAAaZ3modcPYmbhmjeiCKDtq1LQcqMDT6wTUWXA8ugMbAeSZpb2lQA>
    <xmx:rAAaZ6zd5HCKTVOV2laCRu2xpkuq87wrPKzjkDwENLJlDjPpax8Xww>
    <xmx:rAAaZ5Subm_pW2L-7btFlIz6r-p7ZlGl2Z15yV-KvOzhsZkWLCtOmg>
    <xmx:rAAaZ1bpT6zSiigOeFaPihqe_9PBzNZSqHFZUqkJ6s7ILjQ1XQgQEg>
    <xmx:rQAaZ1ptADW4yRrMP2pxR7aC5TT7GSVjggQF4VNbW3S-BOAgiM4BeCha>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 988442220071; Thu, 24 Oct 2024 04:09:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 08:08:53 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>, qemu-devel@nongnu.org,
 "Mark Brown" <broonie@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Aishwarya TCV" <Aishwarya.TCV@arm.com>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <16c7546e-ab87-4da7-bc36-14723675dba3@app.fastmail.com>
In-Reply-To: <87bjzalhzc.fsf@draig.linaro.org>
References: 
 <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
 <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com>
 <87bjzalhzc.fsf@draig.linaro.org>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024, at 19:47, Alex Benn=C3=A9e wrote:
>> On Sun, Oct 20, 2024, at 17:39, Naresh Kamboju wrote:
>> On non-LPAE arm32, this broke the existing behavior for
>> large 32-bit memory sizes. The obvious fix is to change
>> back the PAGE_MASK definition for 32-bit arm to a signed
>> number.
>
> Agreed. However I think we were masking a calling issue that:
>
>     /* Actual RAM size depends on initial RAM and device memory settin=
gs */
>     [VIRT_MEM] =3D                { GiB, LEGACY_RAMLIMIT_BYTES },
>
> And:
>
>   -m 4G
>
> make no sense with no ARM_LPAE (which the kernel didn't have) but if y=
ou
> pass -machine virt,gic-version=3D3,highmem=3Doff (the default changed =
awhile
> back) you will get a warning:
>
>   qemu-system-arm: Addressing limited to 32 bits, but memory exceeds i=
t=20
> by 1073741824 bytes
>
> but I guess that didn't trigger for some reason before this patch?

I did not look at the full log, but I don't think there is a
problem between kernel and qemu, this is just a kernel regression
that can happen on any real or virtual platform with a lot of
memory.

I would guess that "highmem=3Doff" was not even set here, so
there was probably no warning, and you would still see the
same kernel bug with qemu-system-aarch64 and its larger
limit for highmem=3Doff.

      Arnd


Return-Path: <linux-kernel+bounces-388361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA12C9B5E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633B41C20917
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6D1E1A37;
	Wed, 30 Oct 2024 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Tjv0oTZ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWyDur+U"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640491D14FD
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279139; cv=none; b=m7axti1Dz886YV3abAdV/fhcNuKbMxn2VqqLvLjDD2qvgmsikqktmELXZKsvqS4mpHz2MlByECbYV3RzjFfijBi4wiDU5y0GWMcrb+Ub80sTA9nyaDIGBW2QA0jV3IEZsGI5/1g8+HPoYIfAo+aE1uamYdB9K2ra5wgK+BXLOsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279139; c=relaxed/simple;
	bh=bp+JgEDWs8OFuOoiA27PU0rAVpObcNn3SiyCddilbTQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IgKI86jyPsQhcWoKYA63eAqbyzirP9bu/jeDqoGRUxD1jcy1GOT7Qc6VVAOC6eqa9vxlGpY5wddOZCvynKur1VvvZMNJ9xQloxdy/SGlwS+iTxGvXFmrQFdfzrQkGkzeDRcvTfIqMcag7tkpNDtMn4wdhqeXV/nf9+vD31Mpapw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Tjv0oTZ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BWyDur+U; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 758531380193;
	Wed, 30 Oct 2024 05:05:36 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 30 Oct 2024 05:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730279136;
	 x=1730365536; bh=xC6fNzFRBF89Rad9OIH48BQaW5JzVFcqT4eOvVZneBY=; b=
	Tjv0oTZ1iXbfBhgqdMTTv0JTDYnxm1uQJdCeyTlmfOP/jeOuOlf+dX+Nly3TcNVc
	bEF/q2Rj6vC0bGcOFj41ZOq8fJetvwg4KmUCCDUbVGqyiUc4lOy+4wx/jEzMNJWW
	6C3nnqM9YuSp1qkpsSF4vuBfdKM3T6iR41TYFAq8wZQnvftRM8xDRSApA8Ep2sOH
	Xda8La/CFAieTDXcJsqXnzhQSbNLETfgRoQKfFiE0JSO1icFmII27hf6HVfRTR5O
	s4rpv8voiGhDWO5q+UnL1cFlNkDIwFhpSRJ+q/YYydq0Ejxvfi7P+BXte5l4tMvl
	Qj5VCaVQlSUilaLDJBDHnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730279136; x=
	1730365536; bh=xC6fNzFRBF89Rad9OIH48BQaW5JzVFcqT4eOvVZneBY=; b=B
	WyDur+UWpv7g6TZkD+JJ4M43ix+eGvixguPKZdgRiK2dkkEaxc18LH4uLt7pkXnk
	fr9+iXhrongkLAZv/Z2v5nNzTwPq7Ra1BOwAkmKza25Kj6SsdWwC0RrpgOobpZyr
	FDA/09Q9dG/utLwtzFPgchxEVs+Gfki7e1XGb5zzCOx5PzUBHmiEYcp7GszD57uC
	pWiFaYnA7EVl3wSlajJrF72CZzezBEZ/DxGCDA9vl0JhigcS+a6ldpRyJtbQCvEG
	b5lGHVrq45yqQEVKy9C8cRl3OvKI7R9EGSATpzEM3nwigILCpoIKqMJdXw519oEB
	Dob/8t5tJfntuJWiuexAg==
X-ME-Sender: <xms:4PYhZ5uFN5LDK9admUv7vNYUAoY9xUkw10bKz72aWS4-x5dPWyft_g>
    <xme:4PYhZydBhwAZzgfqm6AXc25f9-vmRkv1x8SYargAsCzSaCW0bk5vdZx0z1V-7m1U-
    ZhxgaggRGk0ewromS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeekvdeuhfeitdeuieejvedtieeijeefleevffef
    leekieetjeffvdekgfetuefhgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhhinhgtvghniihordhfrhgrshgtihhnohesrghrmhdrtghomhdprhgtphht
    thhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthht
    ohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepohgvqdhksg
    huihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4PYhZ8wfdJc0SWDeu7--3A3nMNtLR-LO8QoJa6dDoN0NuUv7zogTTQ>
    <xmx:4PYhZwM-9k2RmwHgAiqtVzMouOZHAJOyb9FN7-qb9DVhAN2Y31u1qg>
    <xmx:4PYhZ5_dlm5Q3Jszuy5_popYJ1PZ7ThJFtPNSvFFznNbjy5BkwasGA>
    <xmx:4PYhZwXT01Le0RzRFuK7kbDkzcLPwYWRI0sMDKEXDE6pVb5CUNCTCQ>
    <xmx:4PYhZ5yHzeT458mcgAdF9-mBQnkZUzicTd3z2BDLYuFxEcuKS6YpPhvq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 061E72220071; Wed, 30 Oct 2024 05:05:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Oct 2024 09:05:15 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
 "kernel test robot" <lkp@intel.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Message-Id: <b2b3d30d-12ad-4022-a12b-e2d011952f0f@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdUAdV5Qv1AXKqLGi4xoM=9uiygSDKqhLnZ5YxzXsN6SxA@mail.gmail.com>
References: <202410290639.TBG289SO-lkp@intel.com> <87ttcuzjy7.ffs@tglx>
 <1d6a10ca-3d86-452a-bdba-03a1204dd232@app.fastmail.com>
 <CAMuHMdUAdV5Qv1AXKqLGi4xoM=9uiygSDKqhLnZ5YxzXsN6SxA@mail.gmail.com>
Subject: Re: [tip:timers/vdso 11/13] include/vdso/page.h:15:39: error:
 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean
 'CONFIG_LOG_BUF_SHIFT'?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024, at 08:49, Geert Uytterhoeven wrote:
> On Tue, Oct 29, 2024 at 11:05=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> On Tue, Oct 29, 2024, at 21:18, Thomas Gleixner wrote:

>> I have previously suggested a similar but more extensive patch
>> to address the problem:
>>
>> https://lore.kernel.org/all/CAMuHMdVC-FUSA5C9aNrvP3=3DRaRWrchhUEC5UYc=
SGMz_ep1PEhg@mail.gmail.com/
>>
>> I can rebase that one if Geert still wants it. I think I sent
>
> I am still interested ;-)
>
>> an updated version somewhere but can't find it now.
>
> AFAIK you haven't, so there are still outstanding review comments on
> the last version you sent...
> Thanks!

Ok, sorry it slipped through, I'll send an updated version
later today then.

       Arnd


Return-Path: <linux-kernel+bounces-194313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518CC8D39ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0671E1F262A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561C15AD81;
	Wed, 29 May 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ETPwraHf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/AY5GUH"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DE8D27E;
	Wed, 29 May 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994133; cv=none; b=KbcfdMrEtMrUhEEUbfwGmZE5yYyphN39T+KSbYdFhzg0erAOENcAvB0MuMWAproZT+QohqY6lsETP8n0HeVcarr8m7hxzBZO77Lb8TeexVhA4d837ZL/cx4ijKIEhXLdE6aCF7yyBlAVuRR9aRjKXdqDgiUpAuuwvJGLyE17T5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994133; c=relaxed/simple;
	bh=7y0P0CDTFl239vi3bzVOFC5AtctqcwjVbtdER6f+BmE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=X/2v8xMN1xbgSSPONKdQFr2dT4LXz8Y8199z3uHEDfzcTlsmKnv1TcLTOEvsqEU9WKm06vO0KjY1mZrwZLtdFKeVYWiNixZr17DVhisMAu36Ue0S74xNQdoqDWqaX+ybQ/2DD1hbOKPxH2dzuL+B2uTRXH9RidQ2sZKGUFYHdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ETPwraHf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/AY5GUH; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 8EA941C00157;
	Wed, 29 May 2024 10:48:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 10:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1716994130;
	 x=1717080530; bh=sUWKp0C9FotWW9QV9/CRQdelpobHjogebTFsLlDkrSE=; b=
	ETPwraHfS/RJSBZkl/5hL7DrtEDger5n/TQhYvRgFytt37ZBvoXdTKrVhjBg9fAI
	qVvRrNE5der0/f1OCRXlkJPqUojuEpVlj3q1wNWaq0Ya0e/YkMdGflyRVR+oEsb1
	GzYOnqRw8+XCRSbTb6Axcufs+KkspWPBYx67iv0esIOhhTGhfZZi8+E1gRUA29Ue
	O/GOazeCQZ7OmIZJpDwcRnjOQKyywgzUVgBCHfvHJhKoKwjfX6EGwNNthr8d8ww8
	2I/uaTFVwip6oLLjYsyiRS27nxOni701nUmznMbQn2ITlxsAmST99sox7BJBXSPm
	ElhJjQtAkb1fAQQNitoG4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716994130; x=
	1717080530; bh=sUWKp0C9FotWW9QV9/CRQdelpobHjogebTFsLlDkrSE=; b=i
	/AY5GUHzaUsmZ1wBaahUxPxJQCnww8dJ6Eg8jiLQ+e2BqiMxao7W2wsAU/dJxRAb
	LkAogPYZH68HQzsRrAkkGb1nVtblkjQM+3RF0a/Qn58mN2PnJOnT/wPk1TiHLj30
	2npTOoZZ2WYS/Rci+SaFtLGmauku+Rfsx4st/KMCLB1bAiOyn0uxsXfdMNCw+lzn
	0G6yJSiDTXtscckZqj9y4EqUyGecwegw65pj/bYVJAph1bbeI7Hf8GpPrV+ziGey
	eDvRN+eOFvkyI4YaxLa8xfdFsj6P/dAQiK3wQbbQz64xMeLUga7tPm63J2otKw2b
	XHCcfVtzt4sZ8l78d3Ysw==
X-ME-Sender: <xms:UUBXZopdEyCccWoaCq9oLb1nDmhjvDE6usHIfBUWxBFRxwmoaRzF_A>
    <xme:UUBXZurrdj08bn-xxj7MMN8JPxw_jZWrHJqIPzREC5HV-F20i1t8DhrTeQrxoQibj
    EWh4uY3csSKgBDPa-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:UUBXZtMGr2LxdrelyERdrsqg_16mvoNKGPdO3KCf7KU-4exMUoIrBA>
    <xmx:UUBXZv7lDs79ypzCk5ExfFDqa6tFS2KPnyr7lpTmhgX8R777u8_j2A>
    <xmx:UUBXZn7lZaUkIT5AxO9rbZKfqtNjXJSbdjN-XQ4REGWUGW6q4elq5Q>
    <xmx:UUBXZviGoE0mZh0YoUv-VG8OS_QYpLg2H01c6mUHz59Hmti6fNWqCQ>
    <xmx:UkBXZks5mxnPL4BNiDbwEj3iMnW9NYsoxjzYFPA1ZD_IoqawYk_Gcl7J>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A4D48B6008D; Wed, 29 May 2024 10:48:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3fa493d3-51bb-48bf-b91f-57493be23937@app.fastmail.com>
In-Reply-To: 
 <CAHp75VcVdwxv5Mm3GEv7SmsCiN3ZACpejNb7V_Ld1NBTxcXixQ@mail.gmail.com>
References: <20240529095009.1895618-1-arnd@kernel.org>
 <CAHp75VdRuK_sOF=25xP0azp8sOJ8DY_SRpLq9mUSaNEmWj5EAg@mail.gmail.com>
 <436667b5-308a-4a0b-b66e-230667ce0cc3@app.fastmail.com>
 <CAHp75VcVdwxv5Mm3GEv7SmsCiN3ZACpejNb7V_Ld1NBTxcXixQ@mail.gmail.com>
Date: Wed, 29 May 2024 16:48:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Daniel Scally" <djrscally@gmail.com>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: int3472: make common part a separate module
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024, at 16:28, Andy Shevchenko wrote:
> On Wed, May 29, 2024 at 5:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Wed, May 29, 2024, at 15:41, Andy Shevchenko wrote:
>> > On Wed, May 29, 2024 at 12:50=E2=80=AFPM Arnd Bergmann <arnd@kernel=
org>=20
> It's different from the exported namespace.
> The function prefixes are needed due to C language, as we can't have
> two functions named the same. The export OTOH is what used for linking
> modules and if there is no need to have it exported globally, if, for
> example, compiling in this one.
>
> So, can we move to the exported namespace at the same time?

Maybe you can come up with a patch then? I have no idea
which namespace to use here, seeing that there are already
six differnet namespaces in use in drivers/platform/x86/intel/
but none of them seem to be a good fit for this one.

Are you asking to just define another namespace here?
How would I define what the rules about using this namespace
are, and where are they documented?

     Arnd


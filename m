Return-Path: <linux-kernel+bounces-235138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF0391D0A5
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609F01C20B36
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55F12C54B;
	Sun, 30 Jun 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R4NyR9AH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pbgfmiqe"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301D39AF4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719736918; cv=none; b=rIuDwQb9wgeD/msV6+4KO1HqCRNFts7e7is6SRPoBKi1X0CQ1pck3K8ErQSBZFVHsysz9beCcYJCXuUkLvyzPBRKwjaLdE4rH3kvyzAFDl0a7O8cZFKDK+lRs4pJlbDKu5u3Zy8xE1aLCC8q0e5U96TpedGH+H79pE+IMMT6gyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719736918; c=relaxed/simple;
	bh=Lcc8qXlzhGATMFJRhGlIwCV/tE6b+e4ghq06jHhIDI4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aRZu0fzoUD9ZuKIOJnGM0Jwnc/MsmD6ZOZpxbDbm/sLVBckU+ehfn/6S+PwovR2hw2hM9oIpfVl4ZyBvFoF0bBY+7YNfgTzvHp5ENjgBmm62jnH0lOvxIHMxVmUnZA8Pl2VjbEMTVtevhOhH3z0ukPEtY/vngqOY3FUX0kEHvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R4NyR9AH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pbgfmiqe; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2D9F71380248;
	Sun, 30 Jun 2024 04:41:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 30 Jun 2024 04:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1719736915;
	 x=1719823315; bh=VvAaUclb6Rtxg1lwqBiSTbFrF4mkSFAdG0oWO0fgMR8=; b=
	R4NyR9AHu70IkxlKyKolLi0sqaW/xJQg80/C7p15nxk8NDLMkM6DzL/XA2CkD9+b
	Y5/AkE8ONHpn88llfRGGQD3sdKx46aQZlwuN402Plob1p8zrjX/5xIGp/etINUhj
	Vyb7pJbk/F5JPvEUyJCaDNufAlOvUGTuXULW58z6sAs90RezWKGam1R1r3hvtdAR
	VV6tQkZgYicnxouUehNqqWPVNlBOb08duw2tHSf3tymVvBrfYXKESXFbUCpu1Mh9
	/zoYLGp8IqPXox1MaTXwcsbVrAPCmi2mh+rluRkuOW5m8SOZYnV4tt4WMQ4WGZ80
	Ij2Z0aue98gAO7pZRR4erw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719736915; x=
	1719823315; bh=VvAaUclb6Rtxg1lwqBiSTbFrF4mkSFAdG0oWO0fgMR8=; b=p
	bgfmiqemeD4qE57YXsSqlK67MZ/TUe69ZPT7AtP/4KOXUHaY3mQaYAjW23ai5yEm
	Eg98Hu/SQEjISIrlHSpjTBQirEP62/wgf8TCKZYGj5Qyj4KTZELxkVFLprz3MsmB
	1zEN5uqYMvpgegj7loPQhpxszEcphKjTdm35owRsc7RQv3qZ8xVAsunVfQcdUUjh
	RTlX9598YqL95iOa23HYpZuz8Bn8RiROO1N6R7Hb6twK06HEGtVQY8HMSJQnZzOJ
	FLd6U4bpHWIP2KTfGvJgF9g/MFgooudOfpohj8MazWaSdg6e/geT3gUIDdtbfH42
	cYL4P3XmGPwTkyzjCa/uQ==
X-ME-Sender: <xms:UhqBZuQziVF0YOn2JjU_mV3rvTrhQ2nNJW77maE-iIURmX7bNk8usg>
    <xme:UhqBZjwMMNKdgfMyRXNCVTGyz_tCzwGipbhKINs4dQ7FvqsM01zUUlF7gbS28n3Fn
    yzrhzhDA2hlQr2PfMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UhqBZr11I_DTv2N9QdJwH_bVy3K9bP3b156sedGNChEs4kI-tW24Sg>
    <xmx:UhqBZqBbANC7ecmIK8vRWvovYNufkhoDsIbpItEbwH5spuwkTVIw0Q>
    <xmx:UhqBZniHPFalNV4qFc7zoV3n98jeDY2xTeFa6OzMRHkWIuAOYrwEcA>
    <xmx:UhqBZmoaAo28GRvHVHzRnTv0JIIRK__mwN7Y3FDg7cdEqpNgYU1xGA>
    <xmx:UxqBZngd5burRCzrzHghbSWtLuFd5JzlyY5X1sx5NLXIaTIthrroA8eP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CF7A6B6008D; Sun, 30 Jun 2024 04:41:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <773543e6-9a1f-4a97-9802-bec63c8c8f55@app.fastmail.com>
In-Reply-To: 
 <CACRpkdYA9BCtNNf31uGkF4_Zp7uUZ-Zp6-PLa-qVVSi6NJ-_sA@mail.gmail.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
 <CACRpkdYA9BCtNNf31uGkF4_Zp7uUZ-Zp6-PLa-qVVSi6NJ-_sA@mail.gmail.com>
Date: Sun, 30 Jun 2024 10:41:34 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Daniel Mack" <daniel@zonque.org>, "Robert Jarzmik" <robert.jarzmik@free.fr>,
 soc@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] ARM: pxa: use software nodes/properties for GPIOs
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024, at 10:07, Linus Walleij wrote:
> On Fri, Jun 28, 2024 at 8:09=E2=80=AFPM Dmitry Torokhov <dmitry.torokh=
ov@gmail.com> wrote:
>
>> This series converts legacy pxa boards (spitz, gumstix) to use softwa=
re
>> nodes/properties to describe various GPIOs instead of relying on GPIO
>> lookup tables. The benefit is that structure and behavior is closer to
>> DT-described GPIOs.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> for the patches I didn't write myself.

Thanks for the review!

> What this really needs is testing... :/
>
> If nobody is testing, I think you should just send a pull request
> to soc@kernel.org and users can find out the hard way and help
> fixing regressions. It's a bit hopeless to work on this sometimes.

No need, the patches are already in my patchwork queue and I
will just apply them directly.

       Arnd


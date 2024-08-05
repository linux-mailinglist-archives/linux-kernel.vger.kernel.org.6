Return-Path: <linux-kernel+bounces-275490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BBC94866F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50311C2226A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF48616EB7C;
	Mon,  5 Aug 2024 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="XwKGKIV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTrF2MVs"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B714830D;
	Mon,  5 Aug 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902167; cv=none; b=C/+ZcwFSQQnXrf0jT4ni/kwf8Oaf998DhWMOF0a5kpzGndq2XyqyCdVvyoZeE8ViWEKlHc6EGk+LUJpDLlqSbTeJsz+QaOGRSlcYScQQpTJxO+5d4MXJdn9A/NvmiK8/oi5EaaZj2zk6uPAoXeVjD4DjXJPaEfra3gOkWtBR/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902167; c=relaxed/simple;
	bh=4eI0JUd6/zNvlt2MhrP+SoFgTCVUeQgg+yJVpc4Wqhw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D4f1iAkhgD0MZ6iGy62e2cVDCY3oCGKEs3iqAuDqONOf2VfDsiXUWUT0BlnYECWm/K/Lyf+l0SWFuRYaSUHQEf2lQfi0mhs4D4t9pt2ss5EzBk9HQgZS1oc0IxtiCPAyXX7XCLVOnOGsccbaJ1bcMv0cCuXhsiE3FWCIpIN6Q3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=XwKGKIV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTrF2MVs; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3ED201150F35;
	Mon,  5 Aug 2024 19:56:04 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 19:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1722902164;
	 x=1722988564; bh=oE+3ZfruGY1fMvepJ0d+0bVupG0OFO/5bEwsKkD/E1E=; b=
	XwKGKIV2uxMsZBLCucn35E58qNstdaPkEIJ2NJecpqzMqn91pUkumWr9vavk+OPz
	PncyyuDBm8UOf5bgeZmEhAiQjYKxAyXiAKiVlfUhl/kA9UMFpm11E77tpshBxQCc
	MRew3PrCErJUempRnvASHe8A3kbMMp6D4fsk/6aU0DjFV4CdZjz9Nrtse198ssCZ
	fhys8VZffMCBV/ylYTNIwhsFuogz46pJi3QIIBL9ceBgCPT09va6HJd4qwx8jNsH
	gA62XEgCKTob14fzCrS/YQ1ZF9XTYQooKJBXx/Cq6Z48liJ8xis6Tsut9iCzStV/
	6IChQa3/ktEK+eSuYIjEHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722902164; x=
	1722988564; bh=oE+3ZfruGY1fMvepJ0d+0bVupG0OFO/5bEwsKkD/E1E=; b=U
	TrF2MVsLGZ+tpWh2VT/2hlIfLrpTp5BS2j19cP1mfao5QVcm7nEojXfHwxlBDU20
	juN2WQP5SbQpVwTsXJiWi9XHh9wXLUfIGpfixFNBFoerf68+iyannWjuIwMGj3bI
	LmXTVy/PN2OxYm4khwdjyEGkUYxPKPrIQtT9KpWnf30PdrU3BYpm3GY9IGHJg0KB
	C0LZPwbUyRM/bkaK2a9VBgmjZdSUMiOtq1oMVbpdvZTJXkLf0rmu3iWC3rEgpqEI
	xui197I+8s7i8RDwz74qP+XXPWoAJiP8/YINTEjHULLxvLH9yFiNcDXtdyyGFXef
	hpolBBUpasstYW3ynvFKw==
X-ME-Sender: <xms:lGaxZkJo8W10HO-ZwbTbahuZsngAGVvUYZtD3iIwLvx8Ur2TQ-plKg>
    <xme:lGaxZkLMQlS9m5vJlGnwzivyVtBOwhzQqSmIp4wQPAqSfIQ-3OQlP0cn0pKgY4srH
    z7mlIleg6WNjxmejYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfnuhhk
    vgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrthhtvg
    hrnhepheetudfgleegledtveevtdelfffhtefgtdejhfekgfdujeefueeufedvjeduuddt
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhukh
    gvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:lGaxZkucLGQ3TXH4_ik5kDewZJtszVJ-mD0tpWt9ZBgqIz1khLhBmQ>
    <xmx:lGaxZhZacR9JcF-Z7S-sYaaHewSb7r7h4Gk5GjHHRGYP2QC9YobL9w>
    <xmx:lGaxZrbjvpaD5QTOch5AWTK5uD7_bRN5BPGYSE7tzN5-zNxx5B4tBQ>
    <xmx:lGaxZtAUi_BRhgINSyss_k5hsyxJ4Aj-GgXx_Gkiy7YrfTTztd0wTQ>
    <xmx:lGaxZnFEk3tmahyceGHi4XRBA1qwpViZRqQ3OEwqXz4dzfYrR6SN3AOf>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 143382340080; Mon,  5 Aug 2024 19:56:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Aug 2024 11:55:43 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Message-Id: <14b9f092-3118-4c71-8ad8-c40ac983abbe@app.fastmail.com>
In-Reply-To: <8533dbf2-05cf-9747-c61c-e57fd7bbdc4b@linux.intel.com>
References: <20240713075940.80073-1-luke@ljones.dev>
 <20240713075940.80073-3-luke@ljones.dev>
 <8533dbf2-05cf-9747-c61c-e57fd7bbdc4b@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: don't fail if platform_profile already
 registered
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024, at 3:45 AM, Ilpo J=C3=A4rvinen wrote:
> On Sat, 13 Jul 2024, Luke D. Jones wrote:
>=20
> > On some newer laptops it appears that an AMD driver can register a
> > platform_profile handler. If this happens then the asus_wmi driver w=
ould
> > error with -EEXIST when trying to register its own handler leaving t=
he
> > user with a possibly unusable system - this is especially true for
> > laptops with an MCU that emit a stream of HID packets, some of which=
 can
> > be misinterpreted as shutdown signals.
> >=20
> > We can safely continue loading the driver instead of bombing out.
> >=20
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  drivers/platform/x86/asus-wmi.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 4c129881ce28..7d87ff68f418 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -3836,8 +3836,13 @@ static int platform_profile_setup(struct asus=
_wmi *asus)
> >  asus->platform_profile_handler.choices);
> > =20
> >  err =3D platform_profile_register(&asus->platform_profile_handler);
> > - if (err)
> > + if (err =3D=3D -EEXIST) {
> > + pr_warn("%s, a platform_profile handler is already registered\n", =
__func__);
> > + return 0;
> > + } else if (err) {
> > + pr_err("%s, failed at platform_profile_register: %d\n", __func__, =
err);
>=20
> Please don't print __func__ to user in warnings or errors, and try to=20
> write in English what is the reason (instead of resorting to use funct=
ion=20
> names).

Sorry, I do know this. The patch must have been submitted after your adv=
ice on it last time. Not sure.

In either case v2 incoming. I'll skip cover letter due to the tiny size.
=20
> >  return err;
> > + }
> > =20
> >  asus->platform_profile_support =3D true;
> >  return 0;
> > @@ -4713,7 +4718,7 @@ static int asus_wmi_add(struct platform_device=
 *pdev)
> >  throttle_thermal_policy_set_default(asus);
> > =20
> >  err =3D platform_profile_setup(asus);
> > - if (err)
> > + if (err && err !=3D -EEXIST)
> >  goto fail_platform_profile_setup;
> > =20
> >  err =3D asus_wmi_sysfs_init(asus->platform_device);
> >=20
>=20
>=20


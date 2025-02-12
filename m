Return-Path: <linux-kernel+bounces-511463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4113FA32B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB661882F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C139211A2C;
	Wed, 12 Feb 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="dYd+v54K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ED1ZDPAc"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68306271838;
	Wed, 12 Feb 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377143; cv=none; b=i1fZufyI17WDOesx/iyCCAAY7GxCBojrUVqyuucZ6WGI7/gTDmmhNY1HjfSI1NKT5cjtK/GSu7Jaj6cRLtb/RebeXnTt6e1pDZ0fzpechUqYHbTcdLMB8nb+NPBxk/UEyrxR5fIKZeYzrIjd100JDCK5yJxVA+uWajtSR4PPhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377143; c=relaxed/simple;
	bh=fd1rIWNKriThu5rXMUK4vGL5RkrKeBtxW8qklvaN7Pc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AjCByNWJbRM6rkpOzmrozUEEOmw7qC40ydM9B4K0goj0NMXX3ggyD2ERzDshuzY6mhY8E38AbTMb88jVEvWcuHp+0HP02lX94qL30OxUzF9UYxyFtVrc4VrQdfGneJ4rQWrsWjb3YlrJwlz++E91DaHAWoKYOyPpgRwL/1cxFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=dYd+v54K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ED1ZDPAc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B4BD1380187;
	Wed, 12 Feb 2025 11:18:59 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-02.internal (MEProxy); Wed, 12 Feb 2025 11:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1739377139;
	 x=1739463539; bh=trX84HWVK09hJRuBlQRaYQRJ4SXe28SbidelccD92CM=; b=
	dYd+v54K2k3nKF5j8jMqk5gvfPhQyz5OuaWJcRI0+vy9AegID6/p8hJfe51RgWT0
	qj3/5VRViE1B8eFtzCUu/VdNATAZc2essu/Amu08pHn5/Rgcxs9vxc2BS6Y5HCN5
	6kxHskw2TjOe4KW3LaeC/BSE9Lat9BUtvibPFykp0w+8K61w4gNruSymeH6NNiNN
	u3Gx/YuzCgLRWeb4Wu4nW4CL/Gi6CkqHbJnWkyW1mTu1Z5A18sKRET2Ywo+Dy9FR
	QaKs1SY1MXUScg6NLXZI+cnwooRislnqwjEXVvyxSWAq9whtNVMxRDx1sZs+ZLg0
	nJStPt/e0a3t5lrGLE41TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739377139; x=
	1739463539; bh=trX84HWVK09hJRuBlQRaYQRJ4SXe28SbidelccD92CM=; b=E
	D1ZDPAcADbkRVcqY0+FfTrI8fBOfU8aJDVnGEOyGg0NeihyHnutEPN0xcC/OPHSD
	f3RLEQH3bJOUaRnRJFqAyqrJoeiQKdRPvQ/oLvhrowW/KQkKTo7QA5qZwA6Td9I6
	nqIQAGM22MSUWj6YBJ2JGk4DwkXe+IeIXGlDAJw32tzbpjUPHTdBfoG3X4N93MTL
	EJHV6iwGDT6AQwAyqG3manD7iM8U+RxvR9SBvo/tn+KpkFbuN6zUnBhFa9wvQHVi
	ZvXlfgZbBzZRtHochuuS3alt7/n5Mt7TrP7BUt7vRVySaQAcuHPGzqvrV/V/fLTc
	6+zJSG52f2ZHvEjH3IysA==
X-ME-Sender: <xms:88msZx_pETY8sGcRp9bCZn2p47yhvsyMB4rUqPuS8Nimx2w7LHnLVg>
    <xme:88msZ1s4nC-Da5UHkW8U8znTTgzYSGUOMNZeWeGQoIVd9jRwfb1CJMCuEL8WyhbdG
    lr0WQ7mmDB-q74KHhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfevkeejueeukeef
    hfelleejheeuudfgteffvdetkeffjeduleffvdejkeefhedvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepkhhuuhhrthgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhl
    phhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhlrghtfhhorh
    hmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:88msZ_AYanWMMrDeB_NlW4EAW1-O-2mvN3iRSbroPVEEwQrZEYNYVQ>
    <xmx:88msZ1eqt7I4XV9T66ke-kARspIJkyh2OBQ8mMakm7zXiCiruTBn_g>
    <xmx:88msZ2N1tdE4Xd01E9VJl7KMVOi15G3ECvPnhUlJVg9YyQgPdpwf5g>
    <xmx:88msZ3mJ5OMvakrO-0sznubxvQ6_KPv1rI1utD8MIC7vMcwzc-0P7w>
    <xmx:88msZzo1FHqZdbY0OsnALn5pYDY-XUZxh3OuBuGun1zbgc3eyB17wZxs>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 074AB1F00072; Wed, 12 Feb 2025 11:18:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 11:18:38 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Message-Id: <20c82ad3-03c2-45df-9835-b8dd63fdbb9e@app.fastmail.com>
In-Reply-To: <6112b35f-fdb4-4beb-490e-03569ce9f17e@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250211173620.16522-1-mpearson-lenovo@squebb.ca>
 <D7PSW9W74P7I.GBMKQD7EGPXT@gmail.com>
 <6112b35f-fdb4-4beb-490e-03569ce9f17e@linux.intel.com>
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: Fix registration of tpacpi
 platform driver
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025, at 6:50 AM, Ilpo J=C3=A4rvinen wrote:
> On Tue, 11 Feb 2025, Kurt Borja wrote:
>
>> On Tue Feb 11, 2025 at 12:36 PM -05, Mark Pearson wrote:
>> > When reviewing and testing the recent platform profile changes I had
>> > missed that they prevent the tpacpi platform driver from registerin=
g.
>> > This error is seen in the kernel logs, and the various tpacpi entri=
es
>> > are not created:
>> > [ 7550.642171] platform thinkpad_acpi: Resources present before pro=
bing
>> >
>> > This happens because devm_platform_profile_register() is called bef=
ore
>> > tpacpi_pdev probes (thanks to Kurt Borja for identifying root cause)
>> >
>> > For now revert back to the old platform_profile_register to fix the
>> > issue. Will work on re-implementing this later as more testing is n=
eeded
>> > for full solution.
>
> Hi Mark,
>
> I've applied this to the review-ilpo-branch. I had to rewrite parts of=20
> your changelog though to not say "I did/will do this and that". In fut=
ure,
> please just state the simple facts. What the issue is and so on, do no=
t=20
> write a story about how you came to find that out. :-)
>
Ah - apologies, and thank you.
Mark

> --=20
>  i.
>
>> > Tested on X1 Carbon G12.
>> >
>> > Fixes: 31658c916fa6 ("platform/x86: thinkpad_acpi: Use devm_platfor=
m_profile_register()")
>> >
>> > Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>>=20
>> I believe this is done now!
>>=20
>> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
>>=20
>> > ---
>> > Changes in v2:
>> > Modified approach to instead revert to old platform_profile_register
>> > method. Will revisit using devm_ version in the future as more test=
ing
>> > needed.
>> > Changes in v3:
>> > Add check if tpacpi_pprof is valid before releasing.
>> >
>> >  drivers/platform/x86/thinkpad_acpi.c | 11 +++++++++--
>> >  1 file changed, 9 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platfor=
m/x86/thinkpad_acpi.c
>> > index 1fcb0f99695a..9f6d7e26e700 100644
>> > --- a/drivers/platform/x86/thinkpad_acpi.c
>> > +++ b/drivers/platform/x86/thinkpad_acpi.c
>> > @@ -10646,8 +10646,8 @@ static int tpacpi_dytc_profile_init(struct =
ibm_init_struct *iibm)
>> >  			"DYTC version %d: thermal mode available\n", dytc_version);
>> > =20
>> >  	/* Create platform_profile structure and register */
>> > -	tpacpi_pprof =3D devm_platform_profile_register(&tpacpi_pdev->dev=
, "thinkpad-acpi",
>> > -						      NULL, &dytc_profile_ops);
>> > +	tpacpi_pprof =3D platform_profile_register(&tpacpi_pdev->dev, "th=
inkpad-acpi-profile",
>> > +						 NULL, &dytc_profile_ops);
>> >  	/*
>> >  	 * If for some reason platform_profiles aren't enabled
>> >  	 * don't quit terminally.
>> > @@ -10665,8 +10665,15 @@ static int tpacpi_dytc_profile_init(struct=
 ibm_init_struct *iibm)
>> >  	return 0;
>> >  }
>> > =20
>> > +static void dytc_profile_exit(void)
>> > +{
>> > +	if (!IS_ERR_OR_NULL(tpacpi_pprof))
>> > +		platform_profile_remove(tpacpi_pprof);
>> > +}
>> > +
>> >  static struct ibm_struct  dytc_profile_driver_data =3D {
>> >  	.name =3D "dytc-profile",
>> > +	.exit =3D dytc_profile_exit,
>> >  };
>> > =20
>> >  /*****************************************************************=
********
>>


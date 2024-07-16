Return-Path: <linux-kernel+bounces-253214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD8931E38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E35F1C2150F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C93FF1;
	Tue, 16 Jul 2024 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="ouxfkW+B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sGY2JAb6"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7A81E;
	Tue, 16 Jul 2024 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091685; cv=none; b=LsNrwltHgvvckBPPW5gzqIAjHjgJvI1H83Xd+HYuwklw/Qz5wFAgNOwzGzl7GNR1qe2ZbydNaIOTOGdHTkES0uSVGbH/5nN37W5f7DV8kTzVYj3TGHppBKx7Rta9VOFUBmHwDBHVJEExArLiW1yAZOg4gq1Zc9Xjv6G/aaS/G/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091685; c=relaxed/simple;
	bh=+kESzPcU6FYVWsCXJDMjYqtyWItPzTxVTh63Wp202l8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=lRNxRRZCmZvDQztgdZyNC2i/ORsviLSEtoOW36T0HhhHpEaXDBnaqvCqlHJ4eUV1eBmQnhEThXsy5HMKtDIwH03tza/LGKy0rMmc3mWWdBzNgy+ISMKRDlhsMmYjIdJxccCMmgLnxOHiWUb0m/Eh+i0Dv0H9a2mbdc8IPLkqRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=ouxfkW+B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sGY2JAb6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0A8641388BED;
	Mon, 15 Jul 2024 21:01:22 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 15 Jul 2024 21:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1721091682;
	 x=1721178082; bh=LoQl1KaY9jWU8dz/m/EGWs761V1/ril2HmvUxHNSN9o=; b=
	ouxfkW+BCNnaUnxhmK6wVTuS9iFQKSGzgmlldR+Tv5aSATkg/zZc0opzVUGOorBj
	ZI7ZV+NLMh7XEVZ60/My6ON153t2qqEvZa+ZfR5osetug640FSaU49WNwCLNb9Da
	62F5Gvyj4o1CyRDXOqtvuEcLA96Wv5TYalyXvUauPbgENUVL+dKzTZygxq76uqBZ
	URY4aOZIgvWok5uDDmPTTZeb1xS3AWUmZugm9wzIR2kFswdD/yw54UwTHUtiiuZt
	5vQTp3yw5/AHibGd2C5Hwwumc7MYXMY1eVbtvVkOhrrVtAWG3CdCh+2O9JNd8HYV
	kloeKfm6PZt8COTqUSPObg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721091682; x=
	1721178082; bh=LoQl1KaY9jWU8dz/m/EGWs761V1/ril2HmvUxHNSN9o=; b=s
	GY2JAb6pW43KJ89gNTGgWHF4Yes11fQgP2cpj4K10fpmG5/pEkU2FUCgZyCEdGDt
	MMv3QA0Kn/MaLsPA8LeW0Wgql1Kbs+5ZIaVhp2Ie+bnyNvv3WSl1wGfvSO9uvErH
	cDv9P74VmbXtHF0x9DnTRoEQcKCFWdYidaLGzlbQ7Nkk/KXpQJdJpy8xH37CB+lE
	b3B2Hh94ZuOhezCwab7nKL2J7nByT96w/bCzKccnVaUcwWxZemw+jCXPSla+qju3
	wIxQPF1N+UakVxwX35X/L2Wi3eBUmB/3tZdMdQt0IxRgtpZxUT/EjHYtpY3S3y+k
	3QwcafNZQ+HcKH08uosvw==
X-ME-Sender: <xms:YMaVZuH1M7z8qCjqgDkqzK6r_7-nqkBM-VZtDXyq9ZCh-EWP2-ruiQ>
    <xme:YMaVZvXyaeJTtNFFvEzyQrsjfvJjEsidUklidV_hLyK5egDKlFTtXwlfPokKHtfOb
    l3q5X139OKKtbxjAug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeefgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpeefuefghfdvueefheeiledvgeefffevgeelhedtvdehgeekteeugedtgeeuhedv
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:YMaVZoLooP6g8mNdu3eJ9Tf3zqIZQisfYQPeFdAFVMy26w5tcxQO2g>
    <xmx:YMaVZoE3I1SOJxb7ajev-zxF7tb5HwTXiBJT5f6hFRyU6xK5kG6IJw>
    <xmx:YMaVZkVMDLzVG0zrDmQQIg4_DArVf9cXVrQkMXMN4CGHeHcSei3XDQ>
    <xmx:YMaVZrMTRcRnTFWfvjb-DQ0GDDuvtiLpUIMtkdl_Cr7QH05oPrRO_A>
    <xmx:YsaVZiyQKJ4FiOHc6rIGURWdn9Shs_T6hxN5a12ZLEc8fKGJbTrJkSpu>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A67F52340080; Mon, 15 Jul 2024 21:01:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <18eabcb8-06a6-497a-ac12-c04c9f0db70c@app.fastmail.com>
In-Reply-To: <5c4ef8d8-2806-5bb6-2946-368cf1ebbac6@linux.intel.com>
References: <20240713074005.66254-1-luke@ljones.dev>
 <5c4ef8d8-2806-5bb6-2946-368cf1ebbac6@linux.intel.com>
Date: Tue, 16 Jul 2024 13:00:59 +1200
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, corentin.chary@gmail.com,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "Denis Benato" <benato.denis96@gmail.com>
Subject: Re: [PATCH] Fixes: ae834a549ec1 ("platform/x86: asus-wmi: add support variant
 of TUF RGB")
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jul 2024, at 9:27 PM, Ilpo J=C3=A4rvinen wrote:
> On Sat, 13 Jul 2024, Luke D. Jones wrote:
>=20
> > In kbd_rgb_mode_store the dev_get_drvdata() call was assuming the de=
vice
> > data was asus_wmi when it was actually led_classdev.
> >=20
> > This patch corrects this by making the correct chain of calls to get=
 the
> > asus_wmi driver data.
> >=20
> > Tested-by: Denis Benato <benato.denis96@gmail.com>
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
>=20
> Your tags seem messed up, Fixes is in Subject in place of shortlog tha=
t is=20
> completely missing.
>=20
> Could you please correct these issues and resubmit, thank you.

Looks like I misunderstood something somewhere. Will resubmit.

>=20
> --=20
> i.
>=20
> > ---
> >  drivers/platform/x86/asus-wmi.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/=
asus-wmi.c
> > index 799d928c7d3d..2935af013535 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -879,10 +879,14 @@ static ssize_t kbd_rgb_mode_store(struct devic=
e *dev,
> >  struct device_attribute *attr,
> >  const char *buf, size_t count)
> >  {
> > - struct asus_wmi *asus =3D dev_get_drvdata(dev);
> >  u32 cmd, mode, r, g, b, speed;
> > + struct led_classdev *led;
> > + struct asus_wmi *asus;
> >  int err;
> > =20
> > + led =3D dev_get_drvdata(dev);
> > + asus =3D container_of(led, struct asus_wmi, kbd_led);
> > +
> >  if (sscanf(buf, "%d %d %d %d %d %d", &cmd, &mode, &r, &g, &b, &spee=
d) !=3D 6)
> >  return -EINVAL;
> > =20
> >=20
>=20


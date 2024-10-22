Return-Path: <linux-kernel+bounces-376847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001479AB6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F721F244D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC471CB30A;
	Tue, 22 Oct 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="bELYHvwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H6zspTfZ"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB2145A1C;
	Tue, 22 Oct 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624875; cv=none; b=LH55ai7sFNvVSSKvKZEBqBfYizLjU8Dmv6gDCEnuEv20R6+O9w0qHUOtdYuWhhX+Q7CyA9qxKg3Z2ZE/mA27J7fcJnDVxo+TsIFH7SuR9GftYuxDh/r8hR6paRmoRf9Gm/aFETrivNAEii2LqMsjx4xDrx19LmnENhiDxYk2FrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624875; c=relaxed/simple;
	bh=8hqHwDO0XlcLjjZBbacn4BFLTsGpQmiwPIKeRXlimLo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hKydjGIdj78lG/eixjDVROySRlcy/lUh299OMVnzI9aOxXsn1ob3cRn+98SeLct6kUlqbs8X9VBjQoT0fYbiNGKAbVPzXd+2Wt30pxhWuGIG10uEFc+xcf5XQRa7x3CZ7vRLId8rB1BmF2UdKcctYLcR617vaUVbEUO+TpmuoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=bELYHvwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H6zspTfZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06E5B25400B7;
	Tue, 22 Oct 2024 15:21:11 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-02.internal (MEProxy); Tue, 22 Oct 2024 15:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729624870;
	 x=1729711270; bh=YHB2IYFWfTwBLpy762QpSjMtmDROEmTXcySdS9WRAhs=; b=
	bELYHvwZZKmVwLK3nDNvaxwcPBwFkOq4OpoVCw0j/BRXWetiavR9nn3lw3SkNNwn
	PV/eV2JK6HIk2grvgL89AB08tXRKggy98jJSA6a85jW4kL2lum+UCHghlJ0v4rr4
	692ZZTpAKBrO7D2WoPqHzxhBOPUtTduqUqk66FNxVoc5pBcCGSJP74gX1wASWAf0
	TLSJz0kukfKsey9EwJfIipiZnxhPJPVUnl312x0L9gwL4PoPpt+A0vufPk++vTAs
	HtrFC7IlGlyk3rJhYQaaqr0XJ5sVP8kPMq8sFCl8Fbm3Zkwa6w2prc1zuXSUYwuC
	sN2GFuYoilW2+t+6LTuTWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729624870; x=
	1729711270; bh=YHB2IYFWfTwBLpy762QpSjMtmDROEmTXcySdS9WRAhs=; b=H
	6zspTfZlh4TUlusn/j/Dyh3Q0op8h5A4kn+3PQ3v4yUaWmMHmeygnBtCDg++vxwl
	++x2RyvWl5mIeYSc6ZaVk7q2B2HN4coVUfiu6udHJba+RpWNq1wxj2GnfgRbR60q
	knzBU9gDs707V1im9212HNBcKK1yYQkkkVCHLDhaXPf3HQjP9/y5nZaonot86T9u
	+ZTW6g+Rmx0so8SwFGwUvw+oxB40B5C+p1P0kt3kBl9su2lMxAtf0N9LHYeHWqGc
	4LxUdmwwR2ZnroZQrTaxISUfyv4uI9MhYZfNRnyoK+z0ui9H9b7oHsZ2pAec3m0f
	rj1tK7EvBNzu+9imwpqtA==
X-ME-Sender: <xms:JvsXZznpfbCTvm9yPQ0PsxqHIRdLWTGJVnV1J0VQnDKBRUrZVbZ4aA>
    <xme:JvsXZ22fp_uUSo_hSu4pWM7mixR_47uEeBiXVqm2JoWWmbYVl0CxsQDvf3BKHscfr
    oiTdU4kvJn89qOJ3d0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfevkeejueeukeef
    hfelleejheeuudfgteffvdetkeffjeduleffvdejkeefhedvnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdr
    tghomhdprhgtphhtthhopehhuggvghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhlrghtfhhorhhmqdgurhhivhgvrhdqgiekieesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:JvsXZ5ondzVpjtEPgaXCTp3nZHXmZa9TMFjAElajzVVr4wSRNGwvUw>
    <xmx:JvsXZ7mkKyRcTJfii_OPi7d14ixqkphGkMCsYThuxFwQn-Jgkj6uJw>
    <xmx:JvsXZx0dYyEmQvIhG0Db_g2_DZwK1FkLa0lUWFtirzLNHoanMCwP8A>
    <xmx:JvsXZ6sP_sBfpzQHly_IoKNxzK-UbL8waeNjYFmpRMmdvLmAjXdOzw>
    <xmx:JvsXZ6yf2grjlqmEFtAY5aAKdQ4tEPe-u-7SvC09zYrdpFHrtuPBbCOO>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4F8B03C0066; Tue, 22 Oct 2024 15:21:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 15:19:23 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <7b3de78f-fa9f-4213-b9c2-3dfb9c7f3e45@app.fastmail.com>
In-Reply-To: <6ced79c1-4bff-f44c-c61c-56ae7d9758c3@linux.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20241021193837.7641-1-mpearson-lenovo@squebb.ca>
 <20241021193837.7641-3-mpearson-lenovo@squebb.ca>
 <6ced79c1-4bff-f44c-c61c-56ae7d9758c3@linux.intel.com>
Subject: Re: [PATCH 3/4] platform/x86: think-lmi: Allow empty admin password
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ilpo

On Tue, Oct 22, 2024, at 3:59 AM, Ilpo J=C3=A4rvinen wrote:
> On Mon, 21 Oct 2024, Mark Pearson wrote:
>
>> SVP =3D BIOS Supervisor/Admin password
>> SMP =3D BIOS System password
>>=20
>> If SMP ACL is enabled in the BIOS then the system allows you to set t=
he
>> SMP without a SVP password configured. Change code to allow this.
>> BIOS will return permissions error if SVP is required.
>>=20
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/platform/x86/think-lmi.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/=
think-lmi.c
>> index 46ab82fb2898..751e351dfc42 100644
>> --- a/drivers/platform/x86/think-lmi.c
>> +++ b/drivers/platform/x86/think-lmi.c
>> @@ -469,7 +469,12 @@ static ssize_t new_password_store(struct kobject=
 *kobj,
>>  		if (ret)
>>  			goto out;
>> =20
>> -		if (tlmi_priv.pwd_admin->pwd_enabled) {
>> +		/*
>> +		 * Note admin password not always required if SMPControl enabled i=
n BIOS,
>
> is not always required
>
>> +		 * So only set if it's configured.
>> +		 * Let BIOS figure it out - we'll get an error if operation not pe=
rmitted
>
> operation is not permitted.
>
> Please reflow the comment to fit into 80 chars (this only relates to=20
> comments to keep their line lengths readable without large eye movemen=
t).
>
>> +		 */
>> +		if (tlmi_priv.pwd_admin->pwd_enabled && strlen(tlmi_priv.pwd_admin=
->password)) {
>>  			ret =3D tlmi_opcode_setting("WmiOpcodePasswordAdmin",
>>  					tlmi_priv.pwd_admin->password);
>>  			if (ret)
>>=20
>
> --=20
>  i.

Thanks for the review.
I'll update those. I'll give it a couple of days in case there is any ot=
her feedback
Mark


Return-Path: <linux-kernel+bounces-436966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 599D69E8D33
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146652808BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361B621519B;
	Mon,  9 Dec 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eX3dknxc"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B115215075;
	Mon,  9 Dec 2024 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732405; cv=none; b=bg0X7fjpLmNen+sSLMcAur6EAQo8URRdRjK7017p4A65CWruOc1Rjf169/eir1qxETNuHi1zHI/uhMkg7UfJ51v6uHC1umBgar6YmsoBTL/0+vd/EGpaOTbXCvsgZ+/h+Du2qpRhHyqb2zvMakBGs+3ErG87tYpnf4mYTpxlFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732405; c=relaxed/simple;
	bh=K9moFDoizrc3zjDX2/5OHV2TsYNaF4HSoc+DYblkQAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NRpeXFE/+qlHEFwX7/msOt99x3bcxwC+mIKQg/aVhu3mnvp3r9gMz+LKGwyAYeV6Hm94JCEPXmagCMCxOn18vtIIuRb+EByaLF1mvRdPtv0PyUKD5daIU5KkhISX9YDZByxOu4kdC0rIH0lk2wh8eKq+EbqwaRbipBAFF3DnlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eX3dknxc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B97QH8Q002203;
	Mon, 9 Dec 2024 09:19:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0iv2sDYqhII/oUdzq8z/89H/h95qof5i2GIADRNucOE=; b=eX3dknxczKyW1cnH
	DZ1ySSrixcO8k8S8b6PKSdq+TZz8rMS17tWlXesA6SuKEB0nDLsn2zC9BSb/jzqM
	VDKonYX+0GosyUPUMpxNCfH+TqNhQnAGDe5xJo9QUNeaILC5PbC0iK4cdlTYCAVL
	h70c8lBf54Mc1QzNSRu3fbAyOMZMQHjDI7sTbovdImu61tvuFr/tamuIr6i8QqkR
	Df9SOQqriN9DYr2kDOEn3o6fGwFGLVyR+PZSbSl3KZOl5W8IE+xNXt3TcksH7o01
	yQifRAXk3VvBGRXuTCcs2k7zNBLj95xtWY8N5YYAa+52pP11H61GZ5HcYrb5ClJ/
	3HMXFw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccc8phmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 09:19:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B889E40085;
	Mon,  9 Dec 2024 09:18:19 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4FFA24A484;
	Mon,  9 Dec 2024 09:16:24 +0100 (CET)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 09:16:24 +0100
Received: from SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0]) by
 SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0%13]) with mapi id
 15.01.2507.037; Mon, 9 Dec 2024 09:16:24 +0100
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sudeep
 Holla" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: round rate bisecting in
 discrete rates
Thread-Topic: [PATCH v2 2/2] firmware: arm_scmi: round rate bisecting in
 discrete rates
Thread-Index: AQHbRapDtK1zP5F5+E+8H5T6eqOTIbLZnqSAgAP4mXw=
Date: Mon, 9 Dec 2024 08:16:24 +0000
Message-ID: <4c39a5a437fa42d483d1f704ec7ab4ac@foss.st.com>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-3-etienne.carriere@foss.st.com>,<7fe840af-d56d-4cb6-8d82-d42631409b2a@stanley.mountain>
In-Reply-To: <7fe840af-d56d-4cb6-8d82-d42631409b2a@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hello Dan,

Thanks for looking at this change.

On Friday, December 6, 2024, Dan Carpenter wrote:
>=20
> On Tue, Dec 03, 2024 at 06:39:08PM +0100, Etienne Carriere wrote:
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index 09ccd6cea7f2..7bbb2ee55f4f 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -61,13 +61,20 @@ static long scmi_clk_round_rate(struct clk_hw *hw, =
unsigned long rate,
> >       struct scmi_clk *clk =3D to_scmi_clk(hw);
> >
> >       /*
> > -      * We can't figure out what rate it will be, so just return the
> > +      * In case we can't figure out what rate it will be when the cloc=
k
> > +      * describes a list of discrete rates, then just return the
> >        * rate back to the caller. scmi_clk_recalc_rate() will be called
> >        * after the rate is set and we'll know what rate the clock is
> >        * running at then.
> >        */
> > -     if (clk->info->rate_discrete)
> > +     if (clk->info->rate_discrete) {
> > +             ftmp =3D rate;
>=20
> No need for this assignment.

It is needed. The round_rate handler in scmi clock protocol driver=20
I added in drivers/firmware/arm_scmi/clock.c expects the argument
to carry the target rate as input value and provide the closest reachable
rate as output value, hence initializing @ftmp above. I needed to preserve
the value @rate since used if this round_rate handle is not available
or returns with an error.

Note that I could have changed scmi_proto_clk_ops->round_rate()=20
function ABI to split input target rate and output rounded rate into
2 separated explicit arguments.

Regards,
Etienne

>=20
> > +             if (scmi_proto_clk_ops->round_rate &&
> > +                 !scmi_proto_clk_ops->round_rate(clk->ph, clk->id, &ft=
mp))
> > +                     return ftmp;
> > +
> >               return rate;
> > +     }
> >
> >       fmin =3D clk->info->range.min_rate;
> >       fmax =3D clk->info->range.max_rate;
>=20
> regards,
> dan carpenter
> =


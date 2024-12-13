Return-Path: <linux-kernel+bounces-444681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDFA9F0AED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E09162392
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB71DE4F9;
	Fri, 13 Dec 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nX0aIA0N"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46451D9353;
	Fri, 13 Dec 2024 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089188; cv=none; b=g+5bX9qf4u9a6BYbWcqoA8oZKr39zz8PcsofU6Hn1utbP3LLUfM1EmwVQAGCYsYenT+ArmTgP+XR4B6NLcfMbh4jxoOCZdnynnsKjzZNP6HUWQ+uv7trna/P9ul8/JUSb+3qSt9OhCIxXsjFk3p9V7QXsI7RaNuxAbuUQMQq39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089188; c=relaxed/simple;
	bh=TOvdrY6ZK03lS7952dPZDMgLr1EpXZjEA+isc/DBTlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sWAmj3yTcRgcHF4zSxPpKnUArLRhc2L5qwTmGX/4ChULhvLKyBzWYbg7K2xkuY93XxGvZQRTRXqrQclc9owoX4V2VWIPVe138nQQxN2MG9zOKto1XhEhPJWhjUm0iWoNxyUzUVcUyETz1VlxsDB+AvXI/hlhuzC9JUdhMLVABAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nX0aIA0N; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDAwCCD007389;
	Fri, 13 Dec 2024 12:25:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	TOvdrY6ZK03lS7952dPZDMgLr1EpXZjEA+isc/DBTlo=; b=nX0aIA0N2vd095Qk
	zjlywg33Qq22QUrLPcu5++yxKf46EcwbgwN8HJ0/F03UGwTT1i+veXljzaaJWbUY
	TA1scFnKyf9MNCwLmFVlj8lwEgzhRiQjN2Q+++pihvqhkFKSYz6pU7syKvTZ0Tq2
	1IL4rHx3eC9/hwJkFTC88vKXuxezG9Iro9d2s8fmbCu7GrDrDrUusWwK40T7z5+L
	pjgFZKdipnq1wGlg5Xeos2S4eoC/aZSM7/5NUko6mVe+vbCTPoJ0it0hK+RpVPel
	2W+LoK244qN08XMGNIWBg+mXZxuRnZ8b3cdTlrkj2iXDQbMkw1xOhMI3Kdj85QhB
	J+xA7Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ffwc82gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 12:25:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0A4F54004A;
	Fri, 13 Dec 2024 12:25:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0AC425B04F;
	Fri, 13 Dec 2024 12:24:30 +0100 (CET)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 13 Dec
 2024 12:24:30 +0100
Received: from SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0]) by
 SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0%13]) with mapi id
 15.01.2507.037; Fri, 13 Dec 2024 12:24:30 +0100
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Cristian
 Marussi" <cristian.marussi@arm.com>,
        Michael Turquette
	<mturquette@baylibre.com>,
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
Thread-Index: AQHbRapDtK1zP5F5+E+8H5T6eqOTIbLdsy4AgAAr30uAAD/MAIABMogogASvjhk=
Date: Fri, 13 Dec 2024 11:24:30 +0000
Message-ID: <24d1fce2660a4d8296dd7c699020932a@foss.st.com>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-3-etienne.carriere@foss.st.com>
 <Z1bKlOeHJFHpe9ZU@bogus>
 <ed164b6704ab4086b2fb22ae51658f31@foss.st.com>,<Z1ck5tFkb41wReZP@bogus>,<aac4c00dc3ba4599aaa91392dac71d6d@foss.st.com>
In-Reply-To: <aac4c00dc3ba4599aaa91392dac71d6d@foss.st.com>
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

On Tuesday, December 10, 2024, Etienne CARRIERE - foss wrote:
> On Monday, December 9, 2024, Sudeep Holla wrote:
> > On Mon, Dec 09, 2024 at 12:59:58PM +0000, Etienne CARRIERE - foss wrote=
:
> (...)
> > > > I would like to avoid this extra query if not required which you se=
em to
> > > > have made an attempt but I just want to be thorough and make sure t=
hat's
> > > > what we need w.r.t the specification.
> > >
> > > Sure, I indeed prefer clear and robust implementation in the long ter=
m,
> > > being the one I propose here or another one.
> > >
> >
> > Good then, we can work towards achieving that. If you can specify how s=
low
> > or memory hungry is it without these changes and how much this change h=
elps
> > your platform, we can take it up with spec authors and see if they are =
happy
> > to provide some alternative to deal with this in a generic way.
>=20
> The platforms we target usually have plenty of RAM, lets say hundreds of =
MBytes.
> Not that much for some system but enough I guess to store a few hundreds =
of
> clock rates for a few dozen of clocks (few kByte of RAM).

During last SCMI monthly meeting [1], there was a suggestion to use a lazy
query of the full clock discrete rates list: the first time clk_round_rate(=
)
is requested on an SCMI clock with discrete rates, we can allocated and get
the full rate list once in struct scmi_clock_info. It will be ease to local=
ly bisect
or scan into these supported rates for clk_round_rate() operations.

It would prevent to store the full discrete rates list for all SCMI clocks =
when
clk_round_rate() is queried only for a very few of them.

Do you think it would be a good compromise?=20

[1] https://linaro.atlassian.net/wiki/spaces/SCMI/overview#Meetings

BR,
Etienne

>=20
> That said, thinking more and more about this, I really belive a dedicate =
SCMI
> clock protocol command would better fit platform needs in the long term.
>=20
> BR,
> Etienne
>=20
> >
> > --
> > Regards,
> > Sudeep
> >
>=20


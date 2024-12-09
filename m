Return-Path: <linux-kernel+bounces-437605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93219E95CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484161884686
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5F22145C;
	Mon,  9 Dec 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FqALfb43"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5121E0AE;
	Mon,  9 Dec 2024 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749361; cv=none; b=XLhHItKAJyPtKZhZwd2PoIFK986wMy1zvyj8rqSrFtrL/8uA/Mhks0cy56kYky/2GQWIopqbT0iP53ZB6nVNgSJdAihScwGbZ8V7bcex8LL7FuzCk30+SZBBo2WDSmDk51TKAvmL0sgs+NWRlRVK3AQVYYWikNJJLyuSMANgWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749361; c=relaxed/simple;
	bh=bTrjZtnsr0f8sYU+43fbvMOXAZ9kPaU3gQvDVsaA/9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qiRUA4R4WAkEpnlPyZRXtq8XxVxG0QLzq9MejUv9MP7toRWIP8r5HisuimM3TS+XbGw/U8alrg0PiKw/DX1FnU1d3CrC4519Dp3Bv/UI89GVS6nJGzgxCzw1au4vU/Ge+tU1ngPQPwEX2hCfMV8KHL4omIHrIboh9pK5RTIgHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FqALfb43; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9D2B0A004434;
	Mon, 9 Dec 2024 14:02:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	bTrjZtnsr0f8sYU+43fbvMOXAZ9kPaU3gQvDVsaA/9M=; b=FqALfb43wGHL81wT
	c4sIcZ3284A8HcGlizDub3eGdJI8khgK0mEGqyFwYGeDTYn3qgpc26nj7UDDSG0J
	/kMOq/ERgjkq9Egw4Ll+Z1CUjx2U7+p6faLuYmvb4I3H+KoS/B8CZu2AhUq1xu0W
	ILS7InWxhyISlTcQM8tBo77iVdjQvstw8mKYwU+30jP+8T2utV+fD3jvKU7nbcwj
	sLQfTIG0u4pFilSQQRCOnFrPZ1ti9RSAB9/KwEi6MZ3YNpWf/JRc3eFy7MxLV4mV
	/9hJ3Wi/e+gXm2ab9kxK3i6tJmC086S5/OoTBV90PCGLqiK9DmHB9T7glFnys+om
	Bmt39w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43cek1qts4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 14:02:19 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 460C840047;
	Mon,  9 Dec 2024 14:01:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9FC71277BFD;
	Mon,  9 Dec 2024 13:59:58 +0100 (CET)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 13:59:58 +0100
Received: from SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0]) by
 SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0%13]) with mapi id
 15.01.2507.037; Mon, 9 Dec 2024 13:59:58 +0100
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
Thread-Index: AQHbRapDtK1zP5F5+E+8H5T6eqOTIbLdsy4AgAAr30s=
Date: Mon, 9 Dec 2024 12:59:58 +0000
Message-ID: <ed164b6704ab4086b2fb22ae51658f31@foss.st.com>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-3-etienne.carriere@foss.st.com>,<Z1bKlOeHJFHpe9ZU@bogus>
In-Reply-To: <Z1bKlOeHJFHpe9ZU@bogus>
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

Hello Sudeep,

 On Monday, December 9, 2024 11:46 AM, Sudeep Holla wrote:=20
> On Tue, Dec 03, 2024 at 06:39:08PM +0100, Etienne Carriere wrote:
> > Implement clock round_rate operation for SCMI clocks that describe a
> > discrete rates list. Bisect into the supported rates when using SCMI
> > message CLOCK_DESCRIBE_RATES to optimize SCMI communication transfers.
>=20
> Let me stop here and try to understand the requirement here. So you do
> communicate with the firmware to arrive at this round_rate ? Does the
> list of discreet clock rates changes at the run-time that enables the
> need for it. Or will the initial list just include max and min ?

I don't expect the list to change at run-time. The initial list is
expected to describe all supported rates. But because this list may
be big, I don't think arm_scmi/clock.c driver should store the full list
of all supported rates for each of the SCMI clocks. It would cost to
much memory. Therefore I propose to query it at runtime, when
needed, and bisect to lower the number of required transactions
between the agent and the firmware.

>=20
> > Parse the rate list array when the target rate fit in the bounds
> > of the command response for simplicity.
> >
>=20
> I don't understand what you mean by this.

I meant here that we bisect into supported rates when communicating
with the firmware but once the firmware response provides list portion
when target rate fits into, we just scan into that array instead of bisecti=
ng
into. We could also bisect into that array but it is likely quite small
(<128 byte in existing SCMI transport drivers) and that would add a bit
more code for no much gain IMHO.


>=20
> > If so some reason the sequence fails or if the SCMI driver has no
> > round_rate SCMI clock handler, then fallback to the legacy strategy tha=
t
> > returned the target rate value.
> >
>=20
> Hmm, so we perform some extra dance but we are okay to fallback to defaul=
t.
> I am more confused.

Here, I propose to preserve the exiting sequence in clk/clk-scmi.c in case
arm_scmi/clock.c does not implement this new round_rate SCMI clock=20
operation (it can be the case if these 2 drivers are .ko modules, not
well known built-in drivers).

>=20
> > Operation handle scmi_clk_determine_rate() is change to get the effecti=
ve
> > supported rounded rate when there is no clock re-parenting operation
> > supported. Otherwise, preserve the implementation that assumed any
> > clock rate could be obtained.
> >
>=20
> OK, no I think I am getting some idea. Is this case where the parent has
> changed and the describe rates can give a different result at run-time.

This does not deal with whether parent has changed or not. I would expect
the same request sent multiple times to provide the very same result. But
as I said above, I don't think arm_scmi/clock.c should consume a possibly
large array of memory to store all supported rate each of the SCMI clocks
(that describe discrete rates).

An alternate way could be to add an SCMI Clock protocol command in the
spec allowing agent to query a closest supported rate, in 1 shot. Maybe
this new command could return both rounded rate and the SCMI parent
clock needed to reach that rounded rate, better fitting clk_determine_rate(=
)
expectations.

>=20
> I need to re-read the part of the spec, but we may need some clarity so
> that this implementation is not vendor specific. I am yet to understand t=
his
> fully. I just need to make sure spec covers this aspect and anything we
> add here is generic solution.
>=20
> I would like to avoid this extra query if not required which you seem to
> have made an attempt but I just want to be thorough and make sure that's
> what we need w.r.t the specification.

Sure, I indeed prefer clear and robust implementation in the long term,
being the one I propose here or another one.

Regards,
Etienne

>=20
> --
> Regards,
> Sudeep
>=20


Return-Path: <linux-kernel+bounces-439406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0849EAEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470B5160669
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6521578C;
	Tue, 10 Dec 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EBBDPnRm"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437E51D5CE8;
	Tue, 10 Dec 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828106; cv=none; b=QoBVCudik/n2f5U07P1JV90iCLFFtA399Z3SjSFdEzJppIVzTfmYOsSC4E7mQPHR13QWueiBbU+J/gY74WUYmorK7O4aKkEfP4+yZ0Bqmvv83XzC753gZjrgkYkyHOXXaxfGMC2QURbwtUzzBw7Hnd9IOmKyy11QqvVyMmPPZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828106; c=relaxed/simple;
	bh=tcL2vnPk4Uo0JIrBOrkTI0QFy+X6OH0TPmC6bSGM7a0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V1TJNugvO2FaySss1r6GwZ21Y1KMtyd8SH5hTQnAAK2NCHWVYF4UJIAf+m+ahUQeHOoZ5tyK7Zrtc2851UeBJfcLwjqWQtF+gXULoeBRtlZvjWzHiqw3QLNEo7Zdk7WlWD42kGeQEWLNDeNRuNBxEIolQKxXfEa2ZZ+o+H5RyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EBBDPnRm; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA8JTPP013783;
	Tue, 10 Dec 2024 11:54:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	IZeE9h1il+DsauaUC8/Tt9EQJI2HmML+xYXUzSuaNCE=; b=EBBDPnRmvTeMFUQu
	rQueLTvQotmaBGL/Vz0IOHPGLDs8zB/PAqIIaqW1DOpPd1Y9gycxQMpKcf55xrbs
	0JmP8oCcHGC9IDv3yKjpVFFcvduElckBzcfVYYawT3byQhbkDfrJ8LaJXU6KNEvq
	It2RUdJES2aXkOTXrdBjW3/9s0jWMaHcFni5SXvkAsVi9fEkqrt/m6VPnbrsYRe3
	13TIs+yRQqT/u7oaekZlZQsGehMmF1sclluGZJMoiJSnAOeBkwYH72XW0MKUGzFK
	vznxqTmxJRe0x0oCmiweFQjaiGhGMTjsufsY2ju85kS3tMKq0pDISmOggB4QTmSm
	GXmxpA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccnm4g0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 11:54:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D4BBC40050;
	Tue, 10 Dec 2024 11:53:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 81ED8244283;
	Tue, 10 Dec 2024 11:52:15 +0100 (CET)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 11:52:15 +0100
Received: from SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0]) by
 SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0%13]) with mapi id
 15.01.2507.037; Tue, 10 Dec 2024 11:52:15 +0100
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
Thread-Index: AQHbRapDtK1zP5F5+E+8H5T6eqOTIbLdsy4AgAAr30uAAD/MAIABMogo
Date: Tue, 10 Dec 2024 10:52:15 +0000
Message-ID: <aac4c00dc3ba4599aaa91392dac71d6d@foss.st.com>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-3-etienne.carriere@foss.st.com>
 <Z1bKlOeHJFHpe9ZU@bogus>
 <ed164b6704ab4086b2fb22ae51658f31@foss.st.com>,<Z1ck5tFkb41wReZP@bogus>
In-Reply-To: <Z1ck5tFkb41wReZP@bogus>
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

On Monday, December 9, 2024, Sudeep Holla wrote:
> On Mon, Dec 09, 2024 at 12:59:58PM +0000, Etienne CARRIERE - foss wrote:
> > Hello Sudeep,
> >
> >  On Monday, December 9, 2024 11:46 AM, Sudeep Holla wrote:
> > > On Tue, Dec 03, 2024 at 06:39:08PM +0100, Etienne Carriere wrote:
> > > > Implement clock round_rate operation for SCMI clocks that describe =
a
> > > > discrete rates list. Bisect into the supported rates when using SCM=
I
> > > > message CLOCK_DESCRIBE_RATES to optimize SCMI communication transfe=
rs.
> > >
> > > Let me stop here and try to understand the requirement here. So you d=
o
> > > communicate with the firmware to arrive at this round_rate ? Does the
> > > list of discreet clock rates changes at the run-time that enables the
> > > need for it. Or will the initial list just include max and min ?
> >
> > I don't expect the list to change at run-time. The initial list is
> > expected to describe all supported rates. But because this list may
> > be big, I don't think arm_scmi/clock.c driver should store the full lis=
t
> > of all supported rates for each of the SCMI clocks. It would cost to
> > much memory. Therefore I propose to query it at runtime, when
> > needed, and bisect to lower the number of required transactions
> > between the agent and the firmware.
> >
>=20
> Ah so, this is nothing to do with set_parent, but just an optimisation.
> This change optimises for space but some other platform may have all the
> space but the communication with SCMI platform is not good enough to make
> runtime calls like this change. How do we cater that then ?

This change does not optimize memory. It implements a real clk_round_rate()
operation for SCMI clocks that have a discrete supported rates list. The
existing implementation does not support it, it behaves as if the
requested clock is supported and let caller change the clock rate to
find out which rounded rate it effectively gets. This does not suit=20
audio and video clock constraints.

How to deal between platforms with large memory/slow SCMI=20
communication and those with the opposite? I think the easiest way
would be to have a dedicated SCMI Clock protocol command.

>=20
> We need some spec-ed way or a unique way to identify what is best for
> the platform IMO. We can change the way you have done in this change set
> as someone else may complain in the future that it is costly to send
> such command every time a clock needs to be set. I am just guessing here
> may not be true.
>=20
> > >
> > > > Parse the rate list array when the target rate fit in the bounds
> > > > of the command response for simplicity.
> > > >
> > >
> > > I don't understand what you mean by this.
> >
> > I meant here that we bisect into supported rates when communicating
> > with the firmware but once the firmware response provides list portion
> > when target rate fits into, we just scan into that array instead of bis=
ecting
> > into. We could also bisect into that array but it is likely quite small
> > (<128 byte in existing SCMI transport drivers) and that would add a bit
> > more code for no much gain IMHO.
> >
> >
> > >
> > > > If so some reason the sequence fails or if the SCMI driver has no
> > > > round_rate SCMI clock handler, then fallback to the legacy strategy=
 that
> > > > returned the target rate value.
> > > >
> > >
> > > Hmm, so we perform some extra dance but we are okay to fallback to de=
fault.
> > > I am more confused.
> >
> > Here, I propose to preserve the exiting sequence in clk/clk-scmi.c in c=
ase
> > arm_scmi/clock.c does not implement this new round_rate SCMI clock
> > operation (it can be the case if these 2 drivers are .ko modules, not
> > well known built-in drivers).
> >
>=20
> I don't think it would work if it is not built on the same kernel anyways=
.
> I don't work much about this use-case.

Using the same kernel will not enforce the driver was not modified regardin=
g
the vanilla upstream version. This may be also true for built-in modules
I guess.

>=20
> > >
> > > > Operation handle scmi_clk_determine_rate() is change to get the eff=
ective
> > > > supported rounded rate when there is no clock re-parenting operatio=
n
> > > > supported. Otherwise, preserve the implementation that assumed any
> > > > clock rate could be obtained.
> > > >
> > >
> > > OK, no I think I am getting some idea. Is this case where the parent =
has
> > > changed and the describe rates can give a different result at run-tim=
e.
> >
> > This does not deal with whether parent has changed or not. I would expe=
ct
> > the same request sent multiple times to provide the very same result. B=
ut
> > as I said above, I don't think arm_scmi/clock.c should consume a possib=
ly
> > large array of memory to store all supported rate each of the SCMI cloc=
ks
> > (that describe discrete rates).
> >
>=20
> Right, my assumption was totally wrong. Thanks for confirming.
>=20
> > An alternate way could be to add an SCMI Clock protocol command in the
> > spec allowing agent to query a closest supported rate, in 1 shot. Maybe
> > this new command could return both rounded rate and the SCMI parent
> > clock needed to reach that rounded rate, better fitting clk_determine_r=
ate()
> > expectations.
> >
>=20
> May be that would be ideal but you need to make a case for such a spec ch=
ange.

We need effective round_rate support for STM32MP2 platforms where audio
and video clocks are provided by a clock exposed by the SCMI server. These
drivers detect the (possibly external) device needs at runtime and need
to select an input clock that fits some constraints for quality reason.
Audio quality is the most sensible to clock rate inaccuracy.

>=20
> > >
> > > I need to re-read the part of the spec, but we may need some clarity =
so
> > > that this implementation is not vendor specific. I am yet to understa=
nd this
> > > fully. I just need to make sure spec covers this aspect and anything =
we
> > > add here is generic solution.
> > >
> > > I would like to avoid this extra query if not required which you seem=
 to
> > > have made an attempt but I just want to be thorough and make sure tha=
t's
> > > what we need w.r.t the specification.
> >
> > Sure, I indeed prefer clear and robust implementation in the long term,
> > being the one I propose here or another one.
> >
>=20
> Good then, we can work towards achieving that. If you can specify how slo=
w
> or memory hungry is it without these changes and how much this change hel=
ps
> your platform, we can take it up with spec authors and see if they are ha=
ppy
> to provide some alternative to deal with this in a generic way.

The platforms we target usually have plenty of RAM, lets say hundreds of MB=
ytes.
Not that much for some system but enough I guess to store a few hundreds of
clock rates for a few dozen of clocks (few kByte of RAM).

That said, thinking more and more about this, I really belive a dedicate SC=
MI
clock protocol command would better fit platform needs in the long term.

BR,
Etienne

>=20
> --
> Regards,
> Sudeep
>=20


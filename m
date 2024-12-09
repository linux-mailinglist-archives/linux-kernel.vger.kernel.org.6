Return-Path: <linux-kernel+bounces-437732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45399E97C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD961166B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4A1ACED9;
	Mon,  9 Dec 2024 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7ms22kXM"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69F1ACEAA;
	Mon,  9 Dec 2024 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752210; cv=none; b=fMP78ZsZrGyhAcM7rpxAPDMXHjm1fRU2t6EJGJC20X7w76AnpVyJCh2Zhi3Wi/bqJ5fyRo+kmRtL+0D4ETmjrXYzjATyvAJiNzTyDVbp7rCml915ZQduNqOa8ci6jof7LnltNQzVlcmsJvt20q8WsHepHLGw9ldYJmgLCngGYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752210; c=relaxed/simple;
	bh=Psa+YU3cfq0yUGgmZOTG77vQgbttwuxULBjwDamDVeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+/YgjW0WdXaSmN3bRsirABjs+7MbE6lEEg2g77bBLzY6wUb3s2odrXFBjw4MuuR8GSdmbGOY9W/+n9KndM1xNLd4NMwAA7RJ0lZoQkn1UPL80BZx2y9+fQDGrG+5VMUr7hVvj0m1KRqYdGNCXugCR0lyGTKxasfY28VonEe9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7ms22kXM; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9B746e014441;
	Mon, 9 Dec 2024 14:49:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ApqDR59Bz5QrChxrwP0ZQ76X6NNQKG7JHxhDlDsT6xg=; b=7ms22kXMThn6fbqu
	Pj2D32hgbWhnMDZPVblSImuZilEYvndYQRO1UaFtORMRtiw+8MFbl56IyRITe/wP
	1GRl/wWnhOgFRiJvweVAwGoGbUAPapi0fIACBsr7ZwAUeNmMh+gMFLyEpz0pZ2xG
	ffHlCD2TqihEzkbk2oHGTZN/5su4S7PjrDbNxkuRmP5KVmVRgqVxB6TcHmL/GTdW
	iPc1tX3Dt8EHfepoeYZBizZQVS2FfcdLiZQn/4RyzS1fXrLHy2dUrKpx7hJXgM3g
	shS1JQ8KxC8EAX+7sB3UjvsWIUdamGoeEYhYgEK/Lir86b9QUEy/KtriK1aAVvdq
	ObI89w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccc8r42t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 14:49:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8E61F40053;
	Mon,  9 Dec 2024 14:48:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 078CD27C4C1;
	Mon,  9 Dec 2024 14:48:49 +0100 (CET)
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 14:48:48 +0100
Received: from SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0]) by
 SHFDAG1NODE1.st.com ([fe80::b848:dbeb:cd0:84a0%13]) with mapi id
 15.01.2507.037; Mon, 9 Dec 2024 14:48:48 +0100
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
Subject: Re: [PATCH v2 1/2] firmware: arm_scmi: get only min/max clock rates
Thread-Topic: [PATCH v2 1/2] firmware: arm_scmi: get only min/max clock rates
Thread-Index: AQHbRapDJ7ccjxlxv0mHV7BZdhy65bLdr4SAgAA7caE=
Date: Mon, 9 Dec 2024 13:48:48 +0000
Message-ID: <22ff786d1e034169be21ef7dc32c4a3a@foss.st.com>
References: <20241203173908.3148794-1-etienne.carriere@foss.st.com>
 <20241203173908.3148794-2-etienne.carriere@foss.st.com>,<Z1bHgf_4qqZgSnDt@bogus>
In-Reply-To: <Z1bHgf_4qqZgSnDt@bogus>
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
> On Tue, Dec 03, 2024 at 06:39:07PM +0100, Etienne Carriere wrote:
> > Remove limitation of 16 clock rates max for discrete clock rates
> > description when the SCMI firmware supports SCMI Clock protocol v2.0
> > or later.
> >
> > Driver clk-scmi.c is only interested in the min and max clock rates.
> > Get these by querying the first and last discrete rates with SCMI
> > clock protocol message ID CLOCK_DESCRIBE_RATES since the SCMI
> > specification v2.0 and later states that rates enumerated by this
> > command are to be enumerated in "numeric ascending order" [1].
> >
> > Preserve the implementation that queries all discrete rates (16 rates
> > max) to support SCMI firmware built on SCMI specification v1.0 [2]
> > where SCMI Clock protocol v1.0 does not explicitly require rates
> > described with CLOCK_DESCRIBE_RATES to be in ascending order.
> >
> > Link: https://developer.arm.com/documentation/den0056 [1]
> > Link: https://developer.arm.com/documentation/den0056/a [2]
> > Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> > ---
>=20
> [...]
>=20
> > +
> > +static int scmi_clock_get_rates_bound(const struct scmi_protocol_handl=
e *ph,
> > +                                   u32 clk_id, struct scmi_clock_info =
*clk)
> > +{
>=20
> This new function seem to have unwraped the scmi_iterator_ops(namely
> prepare_message, update_state and process_response instead of reusing the=
m.
> Can you please explain why it wasn't possible to reuse them ?

Since we're interested here only in min and max rates, let's query the
first and last rates only. This can save a bit of useless transactions betw=
een
agent and firmware in case there are many clocks with somewhat large
the discrete rate lists.

I though using the iterator for this specific case would add a bit more
complexity: it's expected to iterate (st->desc_index incremented from the
common scmi_iterator_run() function) whereas here I propose to send
only 2 messages.

BR,
Etienne

>=20
> --
> Regards,
> Sudeep
>=


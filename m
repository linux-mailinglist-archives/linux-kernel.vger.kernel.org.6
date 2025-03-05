Return-Path: <linux-kernel+bounces-546434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC1FA4FAA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329E41892DED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B3F2054FA;
	Wed,  5 Mar 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cZFNLMc8"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056992054E6;
	Wed,  5 Mar 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168368; cv=none; b=eqQSQK5DjB0OhUMMgqMPkR2TYYyDHbJvWgSDIt6opPml92A2zakvrxEu+4jY0x0vdZVGFojXPAqn6IIlZufe9ux9C1jB4r3Zqg/QASB1AwyF7P/3pB9uBioppCzPUmyltVqBe83k+GObncUb9Dacd3I5ACOSt7XSFuZ6auVlrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168368; c=relaxed/simple;
	bh=f1mtud/yW9wQbOh1V2OywbZmiXFNmrbADFJ8CE9Hmn4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NX5jamp57RffKIZ1krIxFS1gohy44ot8WuaK7a2ZYdSFpN4r0UniD2LutqhrdX4JrecNz+KwwoiDDjglnIeTTkuHepb7or+ruDp9AUfdibGh8CdM4HFrVGuVs/EOUf8O4o/tUKl9HjgpJnILMGshPRedhu6CUMrd/f7GUXYSHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cZFNLMc8; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5253vccD015864;
	Wed, 5 Mar 2025 03:52:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=l4O2tAc3nHmi1ElovV
	b0CMq8ms8e2pPhJCOKTF4kppU=; b=cZFNLMc82MkmtpUQ3zZB+OajgUx/YdPxmb
	W85CcuVF694+JOpfdLvW86m2xGGK6abacjO8HKAum1zLwmAoyNLdeuULervLnPAp
	O1H9uD3qwfdekGR/LojP0ZCZPnTSUmK/Je0vPcQ/+AXwP1AIVIqE5wcD2TZiUDoL
	B1aGwu/jML9hMbFd/ZFvr3k4RECdMcPnTOt/INjF7sRyMzwjfIuHMcc475fry/j/
	T2ZI1uxOIlyOqn61dACKNWcOz5u3oWM/5G2g0HaaVrrjadsy3soOFArkw3c43vK7
	PcUxmJkCL/aVkVIsG85H3vxC231dGd0TuUe8nxApk851F32tNVsg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 455fyym3uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 03:52:13 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 5 Mar
 2025 09:52:11 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 09:52:11 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id EE9E0820248;
	Wed,  5 Mar 2025 09:52:10 +0000 (UTC)
Date: Wed, 5 Mar 2025 09:52:09 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Ernest Van Hoecke <ernestvanhoecke@gmail.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Saravana Kannan
	<saravanak@google.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        <patches@opensource.cirrus.com>,
        Ernest Van Hoecke
	<ernest.vanhoecke@toradex.com>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Francesco
 Dolcini" <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <Z8geyb9ilUPmDUXk@opensource.cirrus.com>
References: <20250224155500.52462-1-francesco@dolcini.it>
 <20250224155500.52462-4-francesco@dolcini.it>
 <20250225-delicate-tortoise-of-management-e43fa2@krzk-bin>
 <er4bcixggriqp6idl6xmr7bjetf5kkhadyeplkbyxvrffuiknc@ews752x4ugh7>
 <f690d858-a427-4db4-81ee-d5eb6223368c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f690d858-a427-4db4-81ee-d5eb6223368c@kernel.org>
X-Proofpoint-GUID: Y0SbGx_LqAM5I0nHUEImwHbaW5SidVM0
X-Proofpoint-ORIG-GUID: Y0SbGx_LqAM5I0nHUEImwHbaW5SidVM0
X-Authority-Analysis: v=2.4 cv=DaftqutW c=1 sm=1 tr=0 ts=67c81ecd cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=fwLFyu2rHDo0oW4pvNQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Reason: safe

On Wed, Mar 05, 2025 at 07:45:50AM +0100, Krzysztof Kozlowski wrote:
> On 27/02/2025 16:34, Ernest Van Hoecke wrote:
> > On Tue, Feb 25, 2025 at 09:41:17AM +0100, Krzysztof Kozlowski wrote:
> >> On Mon, Feb 24, 2025 at 04:54:58PM +0100, Francesco Dolcini wrote:
> >>> +  wlf,drc-cfg-regs:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint16-array
> >>> +    description:
> >>> +      Default register values for R40/41/42/43 (DRC).
> >>> +      The list must be 4 times the length of wlf,drc-cfg-names.
> >>> +      If absent, DRC is disabled.
> >>> +
> >>> +  wlf,retune-mobile-cfg-names:
> >>> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>> +    description:
> >>> +      List of strings for the available retune modes.
> >>> +      If absent, retune is disabled.
> >>
> >> How is this retune supposed to be used? If by user-space I can easily
> >> imagine that static DTS configuration won't be enough, because you need
> >> to factor for example temperature or some other minor differences
> >> between same boards.
> > 
> > This is intended for integrators to be able to specify some EQ options,
> > mirroring the previous behaviour that was possible via platform data.
> > 
> > I expect most users to use the first five Retune Mobile registers and
> > not care about the rest, which require a proprietary tool and are not
> > well documented. The example in the binding shows how some simple
> > static EQ can be configured. Anyone interested in the extended config
> > can also use it (statically).
> > 
> > If someone requires dynamic behaviour at runtime that could be a
> > separate patch that should not be hindered by this static config.
> 
> 
> No, if this is suitable for dynamic configuration then it's a proof it
> is not suitable for DT.
> 

Whilst I can see the argument that this could be exposed as an
ALSA control. I would also suggest that this is not adding some new
feature, these values have been filled in from pdata for 16 years
now. Changing the way such a vintage part works at this point feels
more problematic to me than a slightly iffy DT property.

On the flip side of the argument, the parameters that are filled
into this are almost certainly specific tuning for the hardware,
so in many ways this is hardware description and there is a
certain appeal to shipping the tuning with the hardware (ie. in
DT).

Thanks,
Charles


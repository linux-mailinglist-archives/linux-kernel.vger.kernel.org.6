Return-Path: <linux-kernel+bounces-381301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F40F9AFD5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F18B213AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4C21D3586;
	Fri, 25 Oct 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hqsrgJcM"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C9F1D2B2A;
	Fri, 25 Oct 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846700; cv=none; b=l4e/r5MfummAwNYfFpvYZyxvUihZlAakBiURTSvJNC/fIcC0ou0oP0eOfCLyb6h3TenVnUEzmCHS8b491YceX9PaDgHeUug26Ijv5PFyZhFIMhW2TsM+S2NIr6+yxB3vou4BMidNL1sZwQHg1nG1BiXU3viDHSbnOtZgO6wr3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846700; c=relaxed/simple;
	bh=v/W+YknXo/T42S2dWJN85T5BzMNhpxIRXwhTm5D/liU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehIRzVgsdKuIkzC/k44rKFslJWVYyDMRx+J5AzcaAkOC9y/y2sdDDkZvlYDO8jibvCA3a5XQFmDcixUbtrNWz4IiFussKQQkfzykF/wzFs6gJ+thXjcyKYo26nP9Vgoi207Itli6Te5GBMzYzcoPmUT9RRpbMyZljXP9RgCP9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hqsrgJcM; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P2dkrb030685;
	Fri, 25 Oct 2024 03:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=6grNDwF5Gp/yr9tznEQV4KlcT6PdAw9hA5hTHyKyfcc=; b=
	hqsrgJcMzv30LVXJrVYqEHUAB5wmHEgk+I3sO9R5ryByxIQLA/MM/YY1TcbOwTSf
	r+HAhvMUiXbBaONoEgOA5xAMwnzfFV/TYcnZsA4VX4uEp+FcRA1pRyuKq7lR9iVa
	7dddKux/zbEPdTGZc0uUZgYp3ssenE7b4YkZ5gFZ+7a7zbpSxQPWqjjZCS64n5Ml
	BdcF/l3QaBm3kEJBZu+c6gYgHJ0kelEwxPryuds8tL1gVifuJocsR4rjGjQVg/+T
	N7nXcC0yFQetb/14jxaTOyY0VTdhQcHf3KlbmLSGh+F3RKTq6j4VfS6F6RT9yhAg
	FBAjAv/40ZhQHIUKRafWjg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42c96jfpbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 03:58:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Oct
 2024 09:58:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 25 Oct 2024 09:58:05 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id E1249820241;
	Fri, 25 Oct 2024 08:58:04 +0000 (UTC)
Date: Fri, 25 Oct 2024 09:58:03 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: anish kumar <yesanishhere@gmail.com>
CC: <perex@perex.cz>, <tiwai@suse.com>, <corbet@lwn.net>,
        <linux-sound@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Docs/sound: Update codec-to-codec documentation
Message-ID: <Zxtdm9moPrV4Whp9@opensource.cirrus.com>
References: <20241020163706.87123-1-yesanishhere@gmail.com>
 <ZxkgCL2/JtDDJ9N1@opensource.cirrus.com>
 <CABCoZhDQCYwReG2q9pGNPaLaOxd2OjjQ8j14QgujTFDNmG1Seg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABCoZhDQCYwReG2q9pGNPaLaOxd2OjjQ8j14QgujTFDNmG1Seg@mail.gmail.com>
X-Proofpoint-GUID: DTHwN0AMcJ-a8hrowwlGPFtMNwP3MXLZ
X-Proofpoint-ORIG-GUID: DTHwN0AMcJ-a8hrowwlGPFtMNwP3MXLZ
X-Proofpoint-Spam-Reason: safe

On Thu, Oct 24, 2024 at 01:27:51PM -0700, anish kumar wrote:
> On Wed, Oct 23, 2024 at 9:10 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > Bringing the "dummy" into this is quite misleading, that really
> > relates to DPCM setups. DPCM lets one select any number of back
> > ends to service a given front end PCM, and often are abused to
> > achieve things that should really be implemented as C2C links.
> 
> Aha, understood. For C2C we need a thin dummy codec driver
> which acts as a cpu driver in the ASoC code right?
> 

No there is no need for any dummies or thins anywhere, a codec to
codec link is simply a mechanism for hooking two codec drivers
together.

> Based on the code from bells.c, below is the C2C and we do provide
> a CPU driver, even though in actual it is a codec driver.
> 
> SND_SOC_DAILINK_DEFS(wm2200_dsp_codec,
> DAILINK_COMP_ARRAY(COMP_CPU("wm0010-sdi2")),
> DAILINK_COMP_ARRAY(COMP_CODEC("wm2200.1-003a", "wm2200")));
> 

Yes you are providing a CPU side to the link, but as you say that
is actually a CODEC driver. Although I guess really this is really
more historical accident since links were originally defined between
CPUs and CODECs.

> Perhaps, I can just remove the "dummy" from the diagram above.
> 

Yeah it has no place in this document.

> > > +single ``cpu_dai`` with both ``codec_dais``. Boot-up logs will
> > > +display messages similar to:
> >
> > That is definitely not what should be happening with a C2C link.
> > In the system you showed the diagram for above there should be a
> > connection between the CPU and codec-2, then two separate links
> > between codec-2 and codecs 1 and 3. No links should be present
> > between the CPU and codecs 1 or 3.
> 
> Got it, I will try to convey the same in the diagram but ascii art is hard :)
> 

Apart from the dummy bit the diagram is fine here, it is the
description in the text that is wrong.

> Can you help clarify my understanding (based on the dapm code walkthrough),
> when the mixer control is triggered, the CPU widgets gets triggered
> thereby triggering codec2 widgets and as there is a static connection
> between codec1 and codec2 it gets also triggered and the same thing
> happens to codec3 as it is also linked to codec2?
> 
> Also, as the widgets are linked to dai ops, all the ops gets triggered as well.
> 

DAPM will power up anything that is between an active source and
an active sync. I would imagine from the diagram shown above
there would likely be two obvious use-cases:

Host music playback:
CPU -> CODEC2 -> CODEC3 -> Speaker

When something on the host plays some audio this will inform DAPM
that the main CPU DAI is now an active source. This will propogate
through the graph until it finds the speaker sink. The act of
playing music will power up the CPU -> CODEC2 dailink. Then DAPM
will power the C2C link between CODEC2 and 3 since it is on the
audio path.

Cellular call:
CODEC1 -> CODEC2 -> CODEC3 -> Speaker

In this case the host is not involved at all. The modem is audio
source and DAPM powers up everything between it and the sink ie.
the speaker. That would involve the two C2C links between CODEC1
and 2, and between CODEC2 and 3.

> >
> > > +
> > > +.. code-block:: bash
> > > +
> > > +   ASoC: registered pcm #0 codec2codec(Playback Codec)
> > > +   multicodec <-> cpu_dai mapping ok
> > > +   connected DAI link Dummy-CPU:cpu_dai -> codec-1:dai_1
> > > +   connected DAI link Dummy-CPU:cpu_dai -> codec-2:dai_2
> > > +
> >
> > Yeah this is definitely mixing in a fair amount of DPCM stuff and
> > does not match the rest of the description.
> 
> I guess what you meant is that C2C doesn't care about the above
> connection as it uses DAPM widget connection to trigger the path
> right? So, even if this connection doesn't exist C2C will still work.
> 
> Reason why I am asking is that I saw the above logs when I
> added a C2C connection.
> 

That I can't really be sure it depends on how your system was put
together.  There are two things that are reasonably likely:

As I said it is quite likely your system is using Dynamic PCM (DPCM)
this is a mechanism to attach multiple "Backend End" devices to a
single "Front End" DAI link. It is often used by systems that have
a DSP built into the host, which might select different places to
send the audio to. In many ways this accomplishes the same thing as
C2C links, such a system could equal well be represented with the
DSP being a codec driver and each of the "backends" being C2C links.

Alternatively, in the deep dark of history some people did implement
a "dummy link" from the host to the cellular for the purposes
of configuring the params on the modem, even though the audio
technically when through some other route. But this was always a
hack and we should probably not be detailing it in the documentation.

> >
> > > +To trigger this DAI link, a control interface is established by the
> > > +DAPM core during internal DAI creation. This interface links to
> > > +the ``snd_soc_dai_link_event`` function, which is invoked when a
> > > +path connects in the DAPM core. A mixer must be created to trigger
> > > +the connection, prompting the DAPM core to evaluate path
> > > +connections and call the ``snd_soc_dai_link_event`` callback with
> > > +relevant events.
> > > +
> > > +It is important to note that not all operations defined in
> > > +``snd_soc_dai_ops`` are invoked as codec-to-codec connections offer
> > > +limited control over DAI configuration. For greater control, a
> > > +hostless configuration is recommended. The operations typically
> >
> > It is not clear to me what a "hostless configuration" is here.
> 
> What I meant to convey is, if the user wants all pcm ops to get called in
> order then he can use "Hostless FE" and connect to backend use as a normal PCM.
> 

All the talk of front ends and back ends has nothing to do with
codec to codec links and should not be relevant for this
document.

> > > +In a codec-to-codec scenario involving multiple codecs (above
> > > +bootup logs are for multicodec scenario), it is not feasible to
> > > +control individual codecs using dummy kcontrols or DAPM widgets.
> >
> > I really am not sure what this means. What are we controlling
> > using dummy kcontrols? Why are we not using the real kcontrols
> > from the codec to control the codec?
> 
> Our system includes a DSP that can generate audio(not audio to be
> honest but can be considered as a audio channel) independently,
> without CPU involvement. This audio needs to be sent to speakers
> via codecs, even when playback isn't occurring.
> 
> We modeled all codecs as a C2C having one single snd_soc_dai_link
> with multiple codecs. So, now we can control all codecs using mixer
> control which we created as a part of C2C path completion.
> 

Have you by any chance tried to combine the usual DPCM
implementation for host side DSPs with a bunch of C2C links? It's
not necessarily wrong but it seems like an odd choice. Either
represent the DSP using DPCM or C2C links.

> However, we got a new usecase where we shouldn't turn on all the
> codecs when mixer control is used for C2C, instead user should be able
> to specify which codec should get turned on.
> 
> So, I attempted to add one more dummy mixer as part of C2C mixer
> path, follishly thinking that if the dummy mixer is not enabled, C2C
> won't allow the corresponding codec to get turned on. After reading
> the code, I saw that in C2C implementation it doesn't check for
> widget power status when turning on the path and nor check if the
> path is complete or not before calling the pcm ops.
> 

This doesn't seem accurate either, DAPM will only turn on things
between an active source and an active sink. So it should not be
enabling links that are not on a complete path. Although that
said the complete path might be one you didn't intent to exist
it will take any available route between a source and sink.

The more typical way to handle this would be to define a
PIN_SWITCH for the sink on each CODEC then you can enable/disable
those sinks and the CODECs in question should not get powered up
if they have no valid sinks.

Thanks,
Charles


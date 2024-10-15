Return-Path: <linux-kernel+bounces-366254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B299F2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D246D1F240BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C141DD0E6;
	Tue, 15 Oct 2024 16:31:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DCF38F83;
	Tue, 15 Oct 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009900; cv=none; b=PtjnQt+Dn9p6YXh1mwXxnrdNtrYIIqU6xwMEsDlDDcewGW7hANzPMC2QECn70EpXCDB3bYinGwPk4T4cHDfuCI19e9+tqEIa4mT1Uj+pZljDS6vnrn9xZ+Tsz5ucaF+cYIAeX/tLnD/a8L/hTM51i1eitKreW52ndkDAb6FYm8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009900; c=relaxed/simple;
	bh=bSCSYWJmJEbWZ9zVkazQwzn9JzgBDna48aN/PMASXvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt9i+vIXhrGUE4atgeG3XJJ+++inNXswNzgBW5ZDMXwn20Z21maj/RDVfboPL5dIdB8/WS2BYhT5DEiMTiy7d4kjTOySZCrOWJ3kJFJ4k8P/0rfpEOjv9ib3E/bZ0t5/p7nXYCMayb0LyEy07HrsUb8MgxweSIuT8qtcAuw4qyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E30D1763;
	Tue, 15 Oct 2024 09:32:06 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AC9E3F71E;
	Tue, 15 Oct 2024 09:31:33 -0700 (PDT)
Date: Tue, 15 Oct 2024 17:31:26 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@foss.st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/8] firmware: arm_scmi: Make SMC transport a standalone
 driver
Message-ID: <Zw6Y3rT9LbODoZ22@pluto>
References: <20240707002055.1835121-1-cristian.marussi@arm.com>
 <20240707002055.1835121-6-cristian.marussi@arm.com>
 <ffb76411-7119-4024-acaa-3cf40f81ed95@quicinc.com>
 <Zov3VppLHotmIO3l@pluto>
 <273d23f5-c354-43cf-8903-d07f42778c3a@quicinc.com>
 <ZowJ9m3uMfImEulE@pluto>
 <c93cb17d-8f4f-40c9-87af-e5965593b603@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c93cb17d-8f4f-40c9-87af-e5965593b603@quicinc.com>

On Mon, Jul 08, 2024 at 10:59:33AM -0700, Nikunj Kela wrote:
> 
> On 7/8/2024 8:47 AM, Cristian Marussi wrote:
> > On Mon, Jul 08, 2024 at 08:23:56AM -0700, Nikunj Kela wrote:
> >> On 7/8/2024 7:27 AM, Cristian Marussi wrote:
> >>> On Sun, Jul 07, 2024 at 09:52:49AM -0700, Nikunj Kela wrote:
> >>>> On 7/6/2024 5:20 PM, Cristian Marussi wrote:
> >>>>> Make SCMI SMC transport a standalone driver that can be optionally
> >>>>> loaded as a module.
> >>>>>
> >>>>> CC: Peng Fan <peng.fan@nxp.com>
> >>>>> CC: Nikunj Kela <quic_nkela@quicinc.com>
> >>>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >>>>> ---
> >>>>>  drivers/firmware/arm_scmi/Kconfig             |  4 ++-
> >>>>>  drivers/firmware/arm_scmi/Makefile            |  2 +-
> >>>>>  drivers/firmware/arm_scmi/common.h            |  3 --
> >>>>>  drivers/firmware/arm_scmi/driver.c            |  5 ---
> >>>>>  .../arm_scmi/{smc.c => scmi_transport_smc.c}  | 31 +++++++++++++++----
> >>>>>  5 files changed, 29 insertions(+), 16 deletions(-)
> >>>>>  rename drivers/firmware/arm_scmi/{smc.c => scmi_transport_smc.c} (89%)
> >>>>>

Hi Nikunj,

> >>>>> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig

[snip]

> >>>
> >>>> Would it make sense to associate scmi descriptor(scmi_smc_desc) with
> >>>> compatible as driver/platform data so we have flexibility to replicate
> >>>> it and modify parameters such as max_timeout_ms etc. for our platform?
> >>>>
> >>> Mmmm...not sure to have understood, because the scmi_smc_desc is
> >>> effecetively passed from this driver to the core via a bit of
> >>> (questionable) magic in the mega-macro
> >>>
> >>> DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_of_match, &core);
> >>>
> >>> ...and it will end-up being set into the dev.platform_data and then
> >>> retrieved by the core SCMI stack driver in scmi_probe...
> >>>
> >>> ...OR...do you mean being able to somehow define 3 different
> >>> scmi_smc_desc* and then associate them to the different compatibles
> >>> and then, depending on which compatible is matched by this isame driver
> >>> at probe time, passing the related platform-specific desc to the core...
> >>>
> >>> ...in this latter case I suppose I can do it by playing with the macros
> >>> defs but maybe it is also the case to start thinking about splitting out
> >>> configuration stuff from the transport descriptor...
> >>>
> >>> I'll give it a go at passing the data around, and see how it plays out
> >>> if you confirm that this is what you meant...
> >> Hi Cristian,
> >>
> > Hi,
> >
> >> I wanted to send a patch for review(with older driver code) that will
> >> allow us to override transport parameters(e.g. max_timeout_ms,
> >> max_msg_size etc.) on Qualcomm platform. There could be multiple
> >> approaches- 1) add callbacks (similar to get_msg_size) in transport_ops
> >> and override the default or 2) replicate the descriptors for different
> >> compatible and change those values as needed. I was going with the
> >> second option but then I saw your patch and thought of throwing this at
> > :P 
> >
> >> you ;) I don't want you to hold your patch series for this but if you
> >> have a better way to achieve or a preferred way between the two
> >> mentioned before, please let me know. If you do want to add this feature
> >> in this patch series, that would be great!
> >>
> > Interesting, because there is also this thread flying around from Peng:
> >
> > https://lore.kernel.org/linux-arm-kernel/20240703031715.379815-1-peng.fan@oss.nxp.com/
> Thanks Cristian for the link. I was under the impression that DT binding
> that don't describe HW are not acceptable to DT maintainer. But if this
> patch goes through, I am fine using it. I would also like to have
> max_msg_size(and maybe max_msg) configurable.
> >
> > ...which I was planning in embedding in this series; Peng's proposal is
> > limited to timeout and based on DT (and title is a bit misleading...the
> > series is not mailbox-only related)....
> >
> > ...now I am NOT saying that we should dump all configs into the DT, but
> > just that this issue about configurability of transports is already sort
> > of a known-problem, and it is a while that it floats in the back of my mind...
> > i.e. the fact that the transport runtime configurations should be *somehow*
> > independent of the transport descriptor and *somehow* configurable....so now
> > only remains to *somehow* figure out how to do it :D
> >
> > ... I'll have a though and maybe cannibalize your ideas and Peng's one and then
> > we could have a discussion around this on the list to address eveybody's needs...
> >
> > ...and maybe, in the meantime, you could also post your proposed series about
> > this even though based on the old code, but as an RFC, just to make a point and
> > detail the needs...but yeah only if it does not require a bunch of extra work from
> > you given that it is only to be used as a basis for discussion ....
> >
> > ...up to you what do you prefer.

I am in the middle of some rework around these SCMI transport characteristics,
(max_msg / max_msg_size) that by itself currently are not so well defined in
terms of semantic and usage in the codebase, so I am trying to remove any
ambiguity and fix innaccuracies. (i.e. even before any DT transport-related
binding is introduced).

I was trying to understand better how you will use this new binding....
...I mean, of course you will use it to describe new sizes for the shmem areas
and the number of in-flight messages, but is this related to the RIDE platform
setup where you use a high number of SCMI instances ?

...if it is, should I guess that you will tailor somehow all of these shmem
areas' size to the specific/limited use of those scmi nodes ? (in terms of
protocols and messages I mean)...

...or you just need more space in general so you bumped the existing shmem
descriptors depending on the platform and you need to align max_msg_size
accordingly to the transport needs for that platform ?

..or I am overthinking ? :D

IOW what are your use-cases...so that I can try to fit them all in a general
way (possibly)...

Thanks,
Cristian


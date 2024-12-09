Return-Path: <linux-kernel+bounces-436745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BF79E8A36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95277280D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A6156F41;
	Mon,  9 Dec 2024 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bVOcZ5rB"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9651487DC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733717914; cv=none; b=sh1/9LMkABDllX7qHeNgXhAdDTCJa5J090u4BrpVHF3HHJ7pd6fi7y83zvJRnEMJviLp1xqcW4O0fEqoRqT98Mz7ete88P44y0p2zi+ZuP3xGc1p94uLyHQmuUx5wx4pr10QwUHRyj7HVxf/K9+RkJ2D9ZdeUSAJxAbUVsunUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733717914; c=relaxed/simple;
	bh=fdDzit6VdNWYlkbAt5bnOYr1HpZkx+B3FwG1ZnPAWyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+MX5mxqGCGPu8b1eq3cLk/pKQkUo5HIkO+FEwkQgkPiVIw3WiT/uHA33QyWWlll22m+yEzZ5ErLOjsv802FFMit0JPTiqU4eCk0QYecaBD2iyPajGgEIAz9ZHx+UWvGXy7qE9m8Y1BHD561stzQ8oxl+Hp7lwmE2xluxasvX7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bVOcZ5rB; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <56d4fc51-d30a-4467-9df0-6aba5818989f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733717909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CLRMrE1NI/5klhfE3kmyF+H27MvukwsIlJRIa5ZNCI=;
	b=bVOcZ5rB33oZFYQgAIpbKYj5IoVwq5uLMua5cpRUQ5WzYef132s/+FYnz92Ts/3FpLqeQE
	LbMhl1TcGggDOfevWDkSUjcBAVg2IfRbbkWJfIY8eK0qLU1mlw5RJZDHYuANb+R7Z3FO2r
	wWx0XE0rxVt3XbFkXlFCZWZQPPAofAw=
Date: Mon, 9 Dec 2024 09:47:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] drm/tidss: Add OLDI bridge support
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Max Krummenacher <max.oss.09@gmail.com>,
 DRI Development List <dri-devel@lists.freedesktop.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simona Vetter <simona@ffwll.ch>
References: <20241124143649.686995-1-aradhya.bhatia@linux.dev>
 <8b57d6a4-6bc1-4542-abf4-8bc4a3120c25@ideasonboard.com>
 <b8bde033-13a8-4726-a9ff-2fa4eff898e1@linux.dev>
 <9ade7a5d-dd87-4a08-9fdd-c24eb20e733c@ideasonboard.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <9ade7a5d-dd87-4a08-9fdd-c24eb20e733c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 04/12/24 00:06, Tomi Valkeinen wrote:
> Hi,
> 
> On 03/12/2024 20:14, Aradhya Bhatia wrote:
>> Hi,
>>
>> On 03/12/24 17:42, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 24/11/2024 16:36, Aradhya Bhatia wrote:
>>>> Hello all,
>>>>
>>>> This patch series add support for the dual OLDI TXes supported in Texas
>>>> Instruments' AM62x and AM62Px family of SoCs. The OLDI TXes support
>>>> single-lvds
>>>> lvds-clone, and dual-lvds modes. These have now been represented
>>>> through DRM
>>>> bridges within TI-DSS.
>>>>
>>>>    - Some history and hardware description for this patch series.
>>>>
>>>> This patch series is a complete re-vamp from the previously posted
>>>> series[1] and
>>>> hence, the version index has been reset to v1. The OLDI support from
>>>> that series
>>>> was dropped and only the base support for AM62x DSS was kept (and
>>>> eventually
>>>> merged)[2].
>>>>
>>>> The OLDI display that the tidss driver today supports, could not be
>>>> extended for
>>>> the newer SoCs. The OLDI display in tidss is modelled after the DSS
>>>> and OLDI
>>>> hardware in the AM65x SoC. The DSS in AM65x SoC, has two video-ports.
>>>> Both these
>>>> video-ports (VP) output DPI video signals. One of the DPI output (from
>>>> VP1) from
>>>> the DSS connects to a singular OLDI TX present inside the SoC. There
>>>> is no other
>>>> way for the DPI from VP1 to be taken out of the SoC. The other DPI
>>>> output
>>>> however - the one from VP2 - is taken out of the SoC as is. Hence we
>>>> have an
>>>> OLDI bus output and a DPI bus output from the SoC. Since the VP1 and
>>>> OLDI are
>>>> tightly coupled, the tidss driver considers them as a single entity.
>>>> That is
>>>> why, any OLDI sink connects directly to the DSS ports in the OF graphs.
>>>>
>>>> The newer SoCs have varying DSS and OLDI integrations.
>>>>
>>>> The AM62x DSS also has 2 VPs. The 2nd VP, VP2, outputs DPI signals
>>>> which are
>>>> taken out of the SoC - similar to the AM65x above. For the VP1, there
>>>> are 2 OLDI
>>>> TXes. These OLDI TXes can only receive DPI signals from VP1, and don't
>>>> connect
>>>> to VP2 at all.
>>>>
>>>> The AM62Px SoC has 2 OLDI TXes like AM62x SoC. However, the AM62Px SoC
>>>> also has
>>>> 2 separate DSSes. The 2 OLDI TXes can now be shared between the 2 VPs
>>>> of the 2
>>>> DSSes.
>>>>
>>>> The addition of the 2nd OLDI TX (and a 2nd DSS in AM62Px) creates a
>>>> need for
>>>> some major changes for a full feature experience.
>>>>
>>>> 1. The OF graph needs to be updated to accurately show the data flow.
>>>> 2. The tidss and OLDI drivers now need to support the dual-link and
>>>> the cloned
>>>>      single-link OLDI video signals.
>>>> 3. The drivers also need to support the case where 2 OLDI TXes are
>>>> connected to
>>>>      2 different VPs - thereby creating 2 independent streams of
>>>> single-link OLDI
>>>>      outputs.
>>>>
>>>> Note that the OLDI does not have registers of its own. It is still
>>>> dependent on
>>>> the parent VP. The VP that provides the DPI video signals to the OLDI
>>>> TXes, also
>>>> gives the OLDI TXes all the config data. That is to say, the hardware
>>>> doesn't
>>>> sit on the bus directly - but does so through the DSS.
>>>>
>>>> In light of all of these hardware variations, it was decided to have a
>>>> separate
>>>> OLDI driver (unlike AM65x) but not entirely separate so as to be a
>>>> platform
>>>> device. The OLDI TXes are now being represented as DRM bridges under
>>>> the tidss.
>>>>
>>>> Also, since the DRM framework only really supports a linear encoder-
>>>> bridge
>>>> chain, the OLDI driver creates a DRM bridge ONLY for the primary OLDI
>>>> TX in
>>>> cases of dual-link or cloned single-link OLDI modes. That bridge then
>>>> attaches
>>>
>>> How does the clone case work, then? There are two panels, what does the
>>> second one connect to?
>>
>> For the clone case, the devicetree will show the true connections - as
>> they are in the hardware.
>>
>> 2 endpoints from a single DSS VP devicetree port will be connected to 2
>> OLDIs, OLDI0 and OLDI1. The outputs of these OLDIs will be connected to
>> 2 distinct single-link panels.
>>
>> The driver and DRM side of things do not show the same picture, however.
>> The tidss_oldi code creates and registers a drm_bridge only for the
>> primary OLDI. The driver is capable of detecting the expected OLDI mode,
>> and if a companion OLDI is present, then the primary OLDI drm_bridge
>> keeps a note of that.
>>
>> The clock and config resources are shared between the primary and
>> companion OLDI hardware. So configuring the primary OLDI takes care of
>> the companion too.
>> The only case where it is not shared is the OLDI IO bit in the Control
>> MMR (ctrl_mmr) region. But, since the primary OLDI drm_bridge remains
>> aware about the presence of companion OLDI, it makes sure to enable /
>> disable the comapnion OLDI IO when required.
> 
> But if there's just one bridge (for the first oldi), how is the second
> panel connected to the DRM pipeline? Who e.g. calls the
> drm_panel_funcs.enable() in the panel driver for the second panel?
> 
> Or, say, if we have two LVDS->HDMI bridges, with the cloning setup, how
> does all the plumbing work if "DRM framework only really supports a
> linear encoder-bridge chain"?
> 

Right... The driver does not account for such a case at present. The
simple panels don't require any additional programming, which is why a
clone mode with them just happens to work out.

Since there is still only 1 VP behind this, there could only be a single
crtc. Perhaps, we can have an additional tidss encoder (connected to the
same crtc) to start this another encoder-bridge chain. I am still murky
with the details here, but I will try to see what needs to be done.

Thank you! =)


-- 
Regards
Aradhya



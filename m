Return-Path: <linux-kernel+bounces-316770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337DA96D433
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E053B284066
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43F194A45;
	Thu,  5 Sep 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hitbfVy8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF42194A64
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529770; cv=none; b=HQobax4KiyLACv/p/RHEWHeXzyx+7d3/0/cmItY2EBtBokXHgGIQQ8smWxWN3iNrROf99gcMwgwCIPLCrIORk0m+wJxwkcqehC3UYppXc5MuGWKA+LYC1dRgLeCEFJSafJitIdqXx6VHt7zIIXk/NfQQhLyLSX9FoLcc1T7RcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529770; c=relaxed/simple;
	bh=nH8Atn3L+aPW8XuxA02/FDlH3BF6dLRVbi4LLnqDeFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR3GL5xFlG01Y12NMxN17WjQ0Oc05bazXK9M6RLz6CQG1TJImO6Pnguu+CmOun8PWkRJ2fMw8r111NgsLMDc0ihlZ0no3GUy4cf1Dfu2+y1J0RtF2vUZuKCbbKhOSbS0r4N9nsAzbJ9dZHIIivYgicRiMhp1Uc8xIasevPfguXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hitbfVy8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3787f30d892so320320f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725529765; x=1726134565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajsi2J0ggLeyG252quBxawrZ5p8Nah60ezK6XPT3tHQ=;
        b=hitbfVy8oUXqFGq8GNyZj2lhha2aUl6SA6C+cCspCIPUzEOe+zNXXw1NkUu3LeVnYN
         8mWfTwmQm98dVS0cHAwQBbx4yXR7rK/JaVbdAB/+BH6/gGe98SAGSMXcqqSBH9GI43uc
         fI+Mi3BkQIx8SJMTRkSGRJhh///og+ob5xf4XszgwZD0GleC/RsrVVbASfhSHGVhtPt2
         NMxhnPB6+MERi1UhybSSOmm1jFoRoAafOgKRJuybY7J5WGAf54LTTDRwZ054dOW0Q25s
         jmD/vJvzYuULKCxwG+u5bOaTbBviFKdfqkhCZQEUiT7pQK6e27kZ5TR4j2e/MSDFKNPh
         vnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529765; x=1726134565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ajsi2J0ggLeyG252quBxawrZ5p8Nah60ezK6XPT3tHQ=;
        b=icWLmwW4gHHXJ6JY/mPS6aVxrurdr5y/bFHPTYWrsO0Z+iDMJdU+dzWZcCd480eRws
         +DOF8hcgBdTz5tVq/r8Z5cKKTzWiZITBsK7NIM9qivCV7JTifnbvsaU46hFWjLpXekCG
         xHr9tw21NOaxIZpw9ptU8opcER76o/r5H8jp1iZK1zCzh5pTP1L4XnrETngzffiEVAvJ
         zk9FdzwB6DVMQ6CBe2hnlOdaa3Scw2WfS5IZJZumnHe5gwc5zZToSIty0kaIj1fgi4Vn
         jjSlgXmI8y2+VTzZmFEiHuKtcwdEZQoM8Ods5AJZVzPkzcP8MNZ1+UJFfu2kWRcI3xTT
         ORag==
X-Forwarded-Encrypted: i=1; AJvYcCUfDk0dfjCktv2AQtZb5V8LVrXO1K+tv0HsY1c/DsIQoYvb6pxTJDso0e1mkYOX0aqhhVR53HzvaNEVcrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkOGET9mX2tlukP4eLuhcZwLzjYpav78/lmMMBupiE0CfNxfc4
	n7x93+OeRAQq9+6QehD92t424ea1NTCzbGZckDbe/KyS8K5tLFndgP8Q+wV6Y54=
X-Google-Smtp-Source: AGHT+IHDFmIV1wFMjjwEtr/Qx3K4SulTMcfQCQfKJ/zC+fCZq/1r6s2lg+nXTHZKCRKIlMAyyclWcw==
X-Received: by 2002:adf:f98a:0:b0:36b:bb84:33e2 with SMTP id ffacd0b85a97d-374bf184398mr11819525f8f.37.1725529764578;
        Thu, 05 Sep 2024 02:49:24 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4ddc8sm18872157f8f.21.2024.09.05.02.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:49:23 -0700 (PDT)
Date: Thu, 5 Sep 2024 11:49:22 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: ti, sci: Add property for
 partial-io-wakeup-sources
Message-ID: <h4kapqs5vpparh5b3tter54fbnxubq6gpnb4yrqjdio66tj37w@l3xzum2bq5sz>
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-2-msp@baylibre.com>
 <f0f60af7-8561-433a-a027-811015fc5e16@kernel.org>
 <ti4ffymrixcpptlrn3o5bytoyc4w5oovdrzgu442ychai2fjet@wtdhrmwrozee>
 <44feed5a-95a7-4baa-b17e-514c0f50dae6@kernel.org>
 <sf2pklbnlkpgnkemv3wevldpj55kk2xqh4fabbmkcbh2tvnbzr@gg3gxgztq6pt>
 <d2eb4faf-c723-453b-a9d8-68693c96fb42@kernel.org>
 <fa11631e-48f9-4e95-95c4-20b77cb0a1be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa11631e-48f9-4e95-95c4-20b77cb0a1be@kernel.org>

On Thu, Sep 05, 2024 at 11:25:48AM GMT, Krzysztof Kozlowski wrote:
> On 05/09/2024 11:15, Krzysztof Kozlowski wrote:
> > On 05/09/2024 11:08, Markus Schneider-Pargmann wrote:
> >> On Tue, Aug 06, 2024 at 10:03:00AM GMT, Krzysztof Kozlowski wrote:
> >>> On 06/08/2024 09:11, Markus Schneider-Pargmann wrote:
> >>>> Hi Krzysztof,
> >>>>
> >>>> On Tue, Aug 06, 2024 at 08:18:01AM GMT, Krzysztof Kozlowski wrote:
> >>>>> On 29/07/2024 10:00, Markus Schneider-Pargmann wrote:
> >>>>>> Partial-IO is a very low power mode in which nearly everything is
> >>>>>> powered off. Only pins of a few hardware units are kept sensitive and
> >>>>>> are capable to wakeup the SoC. The device nodes are marked as
> >>>>>> 'wakeup-source' but so are a lot of other device nodes as well that are
> >>>>>> not able to do a wakeup from Partial-IO. This creates the need to
> >>>>>> describe the device nodes that are capable of wakeup from Partial-IO.
> >>>>>>
> >>>>>> This patch adds a property with a list of these nodes defining which
> >>>>>> devices can be used as wakeup sources in Partial-IO.
> >>>>>>
> >>>>>
> >>>>> <form letter>
> >>>>> This is a friendly reminder during the review process.
> >>>>>
> >>>>> It seems my or other reviewer's previous comments were not fully
> >>>>> addressed. Maybe the feedback got lost between the quotes, maybe you
> >>>>> just forgot to apply it. Please go back to the previous discussion and
> >>>>> either implement all requested changes or keep discussing them.
> >>>>>
> >>>>> Thank you.
> >>>>> </form letter>
> >>>>
> >>>> I tried to address your comment from last version by explaining more
> >>>> thoroughly what the binding is for as it seemed that my previous
> >>>> explanation wasn't really good.
> >>>>
> >>>> You are suggesting to use 'wakeup-source' exclusively. Unfortunately
> >>>> wakeup-source is a boolean property which covers two states. I have at
> >>>> least three states I need to describe:
> >>>>
> >>>>  - wakeup-source for suspend to memory and other low power modes
> >>>>  - wakeup-source for Partial-IO
> >>>>  - no wakeup-source
> >>>
> >>> Maybe we need generic property or maybe custom TI would be fine, but in
> >>> any case - whether device is wakeup and what sort of wakeup it is, is a
> >>> property of the device.
> >>
> >> To continue on this, I currently only know of this Partial-IO mode that
> >> would require a special flag like this. So I think a custom TI property
> >> would work. For example a bool property like
> >>
> >>   ti,partial-io-wakeup-source;
> >>
> >> in the device nodes for which it is relevant? This would be in addition
> >> to the 'wakeup-source' property.
> > 
> > Rather oneOf. I don't think having two properties in a node brings any
> > more information.
> > 
> > I would suggest finding one more user of this and making the
> > wakeup-source an enum - either string or integer with defines in a header.
> 
> I am going through this thread again to write something in DT BoF but
> this is confusing:
> 
> "Partial-IO is a very low power mode"
> "not able to do a wakeup from Partial-IO."
> "wakeup-source for Partial-IO"
> 
> Are you waking up from Partial-IO or are you waking up into Partial-IO?
> 
> And why the devices which are configured as wakeup-source cannot wake up
> from or for Partial-IO?

Sorry if this is confusing. Let me try again.

Partial-IO is a very low power mode. Only a small IO unit is switched on
to be sensitive on a small set of pins for any IO activity. The rest of
the SoC is powered off, including DDR. Any activity on these pins
switches on the power for the remaining SoC. This leads to a fresh boot,
not a resume of any kind. On am62 the pins that are sensitive and
therefore wakeup-source from this Partial-IO mode, are the pins of a few
CAN and UARTs from the MCU and Wkup section of the SoC.

These CAN and UART wakeup-sources are also wakeup-sources for other low
power suspend to ram modes. But wakeup-sources for suspend to ram modes
are typically not a wakeup-source for Partial-IO as they are not powered
in Partial-IO.

I hope this explains it better.

Best
Markus


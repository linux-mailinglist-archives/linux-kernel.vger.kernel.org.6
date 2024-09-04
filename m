Return-Path: <linux-kernel+bounces-315187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C696BEFF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3481F271D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78971D9335;
	Wed,  4 Sep 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I930DrXP"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BA4C96;
	Wed,  4 Sep 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457614; cv=none; b=uDEsN5zkzUXzcrTaJUW01B1vDrRud6b/7aViHo4k6F8Y7DcEe6A3RJDdWxiKc9BPS9RawLS2Z/gvQwiLg3FmXmavKwr0aSFA1arnWdfua8E6WXN8EcV2byS1V0Ha8UUJhHgINcfJhDCMVcx1FTIWswMxXfvSWU0Vbkatk9dmQDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457614; c=relaxed/simple;
	bh=AjpnI5qp5wSl9R+DpXde2r7+CO38FpagY+Ve8gS9etk=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUm9mLBD1GDSwdxnBOsdD97CI9lMXfn2mU1gtaKALDS0vMga1gSYJENJMVIw/mTTghVQjZ4QPPs5h9ApGj4f0F+P4w5cA22htU/a+qAaEhl33a95q9a8vT7MDrBZWSkxeaYyQaL2PBLnle14DwsBsJFzD2dQJ1h4PybtxuEjcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=I930DrXP; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4844i0ic006144;
	Wed, 4 Sep 2024 08:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=dL34FBVTjgHT8QW2Am75+/hWuPFunEOFpjLE1kFYkho=; b=
	I930DrXPhgWl7p/EJGC4I/rz7cVBJ31Et1psAaSpqBIT58ILwtJX7NwSwo5EpVbQ
	PSjarKBguzeMaSjVdB1/JBIn0kNoE5oJ5Ffu5J6OUNVlx3aFPDhm7WjpWf6gxtsG
	A9OawqPgb5z8M1b8TRtOvqATXYzuLx4DJVbFndjOO27T8NyZvtFq/J4Wx5UqGJFu
	2DgoHOSstXf4P3tJXgqz69qTLHzy/QSPIYD/N3+hbEhcSdCg8U/0ziBb8TT0oQY3
	F+2dMggy5+L725z3V7O0v5Z/D1IXrq/DLd18245it0sf+B4VOHRHYBXrezKf+2SN
	1J1nBbCYmmPDpl7c3bVOLw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 41bykkckyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:46:32 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 14:46:30 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 4 Sep 2024 14:46:30 +0100
Received: from EDIN6ZZ2FY3 (unknown [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 9E3E182024A;
	Wed,  4 Sep 2024 13:46:30 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Mark Brown' <broonie@kernel.org>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240904120700.188644-1-simont@opensource.cirrus.com> <e1aeb66c-ecb3-4778-b306-f3a212caf879@sirena.org.uk>
In-Reply-To: <e1aeb66c-ecb3-4778-b306-f3a212caf879@sirena.org.uk>
Subject: RE: [PATCH] ASoC/HDA cs35l56: Remove redundant IRQ handling
Date: Wed, 4 Sep 2024 14:46:30 +0100
Message-ID: <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQKHzAIo361Zljfa9iRBQSN4dy/XOQEQvrcusOV2n+A=
X-Proofpoint-GUID: T5wFkE1A2qVSP_Pao5lY3hzYA-hzzW2G
X-Proofpoint-ORIG-GUID: T5wFkE1A2qVSP_Pao5lY3hzYA-hzzW2G
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 04, 2024 at 12:25:00PM +0000, Mark Brown wrote:
> On Wed, Sep 04, 2024 at 12:07:00PM +0000, Simon Trimmer wrote:
> > The IRQ handling in the cs35l56 driver was purely informational. It was
> > not necessary to support the HDA or ASoC driver functionality and added
> > unnecessary complexity to the drivers.
> >
> > As the IRQ signal GPIO line could be connected and shared with other
> > components the handling is replaced with a regmap patch to ensure the
> > cs35l56 IRQ sources are masked and will not generate interrupts that go
> > unhandled.
> 
> Given that the code is there now and has been since the driver was
> introduced about 18 months ago what's the ongoing cost of having it?
> The information it's providing is notification of hardware faults,
> reporting those does seem useful.

Originally we were expecting to use the IRQ mechanism for an event logging
stream that would function in a similar manner to compressed streams to be
able to get an information feed for debug and tuning tools, but those were
never created and the logging infrastructure not implemented.

It's quite a spread of code and a lot of complexity in the regular execution
paths managing them / synchronizing the contexts, there is more going on in
the SoundWire bus variant compared to the conventional i2c/spi that it is
hard to justify maintaining it all for a couple of log messages - in the
event that someone did encounter the two situations being reported the
regmap dump would point us to the cause pretty quickly.

-Simon




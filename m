Return-Path: <linux-kernel+bounces-315539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FB896C3F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 893DFB26947
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF691E0B9D;
	Wed,  4 Sep 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="K9uG+68N"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07051DB55E;
	Wed,  4 Sep 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466802; cv=none; b=HniNKVgraSXq7LIgYLq/R7LI3otoKUV1dQcBavchL1UJLxt364Yjoc5CfqOEe7O870vL46TAKx1m0qKih0eNz6OYojBebDd2tOj4VNGzdIf/CSn7VpdgV04QUR4aBptYP0lSpNxAIyxesXK5Y36J/C35+o+54Gwd6vl0rvgXk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466802; c=relaxed/simple;
	bh=QpCF2EcCr823CZTZEr74srNB7EvaKB2j2fP3kYYsUcM=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oli5DjqaUqNg8ykdtbzBMeog3Mksa7s6nNtUm5ytvsDuEuZ3tQkIMlPITQY7XpT98tHTHCeDoq62fplJqUo3Rb15NQfKwDzE2sA0w2UiG1Gt9+yeIpE4pNKsowA1XBg6jwolIL/4mHHzZf3NkTzikJj+uTIAcZ6zL+bcl4gvoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=K9uG+68N; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484As7kh004907;
	Wed, 4 Sep 2024 11:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7MRbvudIjt/ekH04rmXTHtiizoxZ4eaQvQXwLxu/c64=; b=
	K9uG+68NjLDmx9ntDZMMlw0gUDE6ngaW0iOMeeP54zqS822RutGN58Nrwz7tQlij
	VqkeLFeW0tQ2WZcDyDb04/rGFpfe583vqVGYj0YOTYb+Kqu9QoJrL9LVvk1Pd4Xw
	6KrCYkz/pTnaAhiNiOeuWxvVxqgAdvlwih/IieBpKcn87w4KE6rGUDRwK3i+dnF3
	sGva26a5H3lXgPyKIoDD/mdb0+puzLoXsPqo7h8KcB9RuE7Ch/bYpBwESMYq/5bm
	hbXJdaXwIcjqLQEBdphtN5dPt16p0NzHUrw+eXpwlwvezWPrSvhoajbd3Fm8RsOb
	dmxnexH1gPOxu+8xHZ7Qhw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 41c0jxcyve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 11:17:54 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 17:17:51 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 4 Sep 2024 17:17:51 +0100
Received: from EDIN6ZZ2FY3 (unknown [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 974DF820244;
	Wed,  4 Sep 2024 16:17:51 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Mark Brown' <broonie@kernel.org>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240904120700.188644-1-simont@opensource.cirrus.com> <e1aeb66c-ecb3-4778-b306-f3a212caf879@sirena.org.uk> <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com>
In-Reply-To: <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com>
Subject: RE: [PATCH] ASoC/HDA cs35l56: Remove redundant IRQ handling
Date: Wed, 4 Sep 2024 17:17:51 +0100
Message-ID: <006301dafee5$fdb00c70$f9102550$@opensource.cirrus.com>
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
Thread-Index: AQKHzAIo361Zljfa9iRBQSN4dy/XOQEQvrcuAYmGn2uw2V/tEA==
X-Proofpoint-ORIG-GUID: Oyai2-nBQdNx8TilC22DZeG_82szV4zS
X-Proofpoint-GUID: Oyai2-nBQdNx8TilC22DZeG_82szV4zS
X-Proofpoint-Spam-Reason: safe

On Wed, Sep 04, 2024 at 13:47:00PM +0000, Simon Trimmer wrote:
> On Wed, Sep 04, 2024 at 12:25:00PM +0000, Mark Brown wrote:
> > On Wed, Sep 04, 2024 at 12:07:00PM +0000, Simon Trimmer wrote:
> > > The IRQ handling in the cs35l56 driver was purely informational. It
was
> > > not necessary to support the HDA or ASoC driver functionality and
added
> > > unnecessary complexity to the drivers.
> > >
> > > As the IRQ signal GPIO line could be connected and shared with other
> > > components the handling is replaced with a regmap patch to ensure the
> > > cs35l56 IRQ sources are masked and will not generate interrupts that
go
> > > unhandled.
> >
> > Given that the code is there now and has been since the driver was
> > introduced about 18 months ago what's the ongoing cost of having it?
> > The information it's providing is notification of hardware faults,
> > reporting those does seem useful.
> 
> Originally we were expecting to use the IRQ mechanism for an event logging
> stream that would function in a similar manner to compressed streams to be
> able to get an information feed for debug and tuning tools, but those were
> never created and the logging infrastructure not implemented.
> 
> It's quite a spread of code and a lot of complexity in the regular
execution
> paths managing them / synchronizing the contexts, there is more going on
in
> the SoundWire bus variant compared to the conventional i2c/spi that it is
> hard to justify maintaining it all for a couple of log messages - in the
> event that someone did encounter the two situations being reported the
> regmap dump would point us to the cause pretty quickly.

Hi Mark and Takashi,
Hold off merging this one - we should think about it a bit more and people
are off on PTO.
-Simon



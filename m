Return-Path: <linux-kernel+bounces-219427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C323290D128
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6341F23CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEB619E81A;
	Tue, 18 Jun 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ioXuKhAe"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441EC1581F6;
	Tue, 18 Jun 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716025; cv=none; b=OO0OmJ3rM05RwsoKdT+9U1t/SMVL/CtibfO5zeWNi47t/+6yZVfZc7LL4OS0xl0aGXi8etemotrPIvnhhqjTouHTWcuUH2Q1yPBCeSHHAhoLOU9TZhBwATmEAJ6NFBuGuPxvtQVJQh4hk1LZBgZztJi4I9HEFT41YzCSy8WmcKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716025; c=relaxed/simple;
	bh=bJe8JzhPEEkXJ5ptIUtmGtaGPiiJiEhyUtbBuK49e5I=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLPlvPfhvOXtt3m4iAQPJB19wkn23aUNRr4gtHtEvOKZ+Diq22ERuUgSnlACPw9Yp+LvLG85jgMqtcHxGD4uBz6pe/QFcSvR2Hlp1V5XQWw6xB874miGPO7W+IN8URrhqZO3BiHt9b2o2vCrc//ulWJmlBp7BqGz0sJfAQoutic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=ioXuKhAe; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I62OUg026682;
	Tue, 18 Jun 2024 07:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bJe8JzhPEEkXJ5ptIUtmGtaGPiiJiEhyUtbBuK49e5I=; b=
	ioXuKhAeMmmzgRbgc3z+824NmAt1MkOoxzkDI9ANYoPLPKVLHpfQO8k/oaG4NBeQ
	gn/5/cSHbnmtSTDlKLI+akGtAWg8WrYBw8vZDQmZLrE6HhAwN6jL5gaPmJ4KL7v9
	xCW4m79EahunCC929G4UyNdcM6PnKgvyRpmshfpuR17IxfKEox85hfbB8JFYXV85
	fCEuiqkuJMHCJ6mDFN3WHsk0nU12ovk7lDkdDvE7krUmkqhxVCiUxzabGgtkzxN6
	PjgbJTbfkpo+CICv8EpPJt3RxPT6Zz1MXO/7Ic1G0lwvHHEJYtcEV0YNysrPotAb
	QFWYy5bGmKAqWlDBllR7eA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cju2u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 07:59:58 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 13:59:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 18 Jun 2024 13:59:57 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id DC0C6820248;
	Tue, 18 Jun 2024 12:59:56 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240618125325.61173-1-simont@opensource.cirrus.com>
In-Reply-To: <20240618125325.61173-1-simont@opensource.cirrus.com>
Subject: RE: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the background
Date: Tue, 18 Jun 2024 13:59:56 +0100
Message-ID: <000b01dac17f$6b84e5d0$428eb170$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQMEbY4a5v39dJc50MgieJ5kS4EI6K96Incw
X-Proofpoint-GUID: YLFvuopG_geV1876tYYya2jGB8yS-az5
X-Proofpoint-ORIG-GUID: YLFvuopG_geV1876tYYya2jGB8yS-az5
X-Proofpoint-Spam-Reason: safe

On Tue, Jun 18, 2024 at 1:53=E2=80=AFPM Simon Trimmer
> Subject: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the =
background
>=20
> It is possible that during system boot when there multiple devices
> attempting simultaneous initialization on a slow control bus the
> download of firmware and tuning data may take a user perceivable =
amount
> of time (a slow I2C bus with 4 amps this work could take over 2
> seconds).
>=20
> Adopt a pattern used in the ASoC driver and perform this activity in a
> background thread so that interactive performance is not impaired. The
> system_long_wq is a parallel workqueue and driver instances will =
perform
> their firmware downloads in parallel to make best use of available bus
> bandwidth.
>=20
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Sorry Takashi this should have had v2 in the Subject - when fixing up v1 =
we
found all the things that triggered the series of hda_component changes
so it fell off my mental queue as something I'd published before.

I'll do a re-send with that corrected for Lore.

-Simon



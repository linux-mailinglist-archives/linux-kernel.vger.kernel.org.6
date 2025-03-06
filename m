Return-Path: <linux-kernel+bounces-549066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A261DA54CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2E3188C457
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32B13D897;
	Thu,  6 Mar 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Hixp/vSU"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB09E13B791;
	Thu,  6 Mar 2025 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269566; cv=none; b=bytq9hydvXRPJaVdcSqvtvTOF969VXQJa95ze/On6ev4/eBSAueRlq754gwip9q1diHnM4YtiyYXJBVfVG2Fx5+ZAQfxAmme7Y9Ncg+vhBvrvcPj5cE0VhPoN/KIJ/+wuj2sFC58yWTJk7OcBri5up3orYFXcuTrWqsZ+FSQHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269566; c=relaxed/simple;
	bh=bol620wlA8oFXEl+/VOP1C5bUp+RHHYaVpeT6V2BsQg=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MU86RCP63k18V8zH+o1No6xe/NBUx95FgynhmuvQBXEiLf61Y42L1er5Ka+ZmrQs4Jux5o7KiRnBrXAyyaolj26LDVMjVpjZ+9t2u5Ei0PKwHf31rWDdUmz28cqTVGU3lYQgSzwsBR2WnC4zIbPVgKYNvQSS2eRZu42Aq7C+ijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Hixp/vSU; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5264Mlbf028765;
	Thu, 6 Mar 2025 07:59:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=bol620wlA8oFXEl+/VOP1C5bUp+RHHYaVpeT6V2BsQg=; b=
	Hixp/vSU/cHFlmU9d4T93x+yg6L0MJPKQg8K9aEGiLHfcFoAELlX/m/syEi3TD6W
	L88Fq/7X3toQDY0Scy7fr/EXswEq2ypTx81eNayPdR8h5sBnNP0AYXcziUVEEdZY
	JsiCkX3U8k5LqNijyVjyGCzP/c+Z150sXgf7+R03EYeK8GC36kxscjY1CzmbozS0
	rnPzAHsZGHP+rgENAPThMuKMXktowubAlYNqhGxw1b5+Db76MLi1yBvNIXQ91L7m
	LVAo3P3EXZalCwdgFQNDi1tDq3WHBFntRf5MlQa7FFI+P457tRpHSR4Nghnj25SS
	u8EtrM0RY6F70pT9SHHsAw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4571nu1625-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 07:59:07 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Mar
 2025 13:59:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Thu, 6 Mar 2025 13:59:05 +0000
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 723A5820248;
	Thu,  6 Mar 2025 13:59:05 +0000 (UTC)
Message-ID: <93d5a3926e37fa297ba0c8f3266d2d4fcd429182.camel@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Arnd Bergmann <arnd@kernel.org>, David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>
CC: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Date: Thu, 6 Mar 2025 13:59:05 +0000
In-Reply-To: <20250305172738.3437513-1-arnd@kernel.org>
References: <20250305172738.3437513-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 1eGop7Y0KJkxM395FLksWTGHS8ONk7vA
X-Authority-Analysis: v=2.4 cv=Lqxoymdc c=1 sm=1 tr=0 ts=67c9aa2b cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=bADtR2mNskJhKBtCSccA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: 1eGop7Y0KJkxM395FLksWTGHS8ONk7vA
X-Proofpoint-Spam-Reason: safe

W=C2=A0dniu =C5=9Bro, 05.03.2025 o=C2=A0godzinie 18=E2=88=B627=E2=80=89+010=
0, u=C5=BCytkownik Arnd Bergmann
napisa=C5=82:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The custom suspend function causes a build warning when
> CONFIG_PM_SLEEP
> is disabled:
>=20
> sound/soc/codecs/cs42l43.c:2405:12: error: unused function
> 'cs42l43_codec_runtime_force_suspend' [-Werror,-Wunused-function]
>=20
> Change SET_SYSTEM_SLEEP_PM_OPS() to the newer SYSTEM_SLEEP_PM_OPS(),
> to avoid this.
>=20
> Fixes: 164b7dd4546b ("ASoC: cs42l43: Add jack delay debounce after
> suspend")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Maciej Strozek <mstrozek@opensource.cirrus.com>

--=20
Regards,
Maciej


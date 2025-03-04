Return-Path: <linux-kernel+bounces-544347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B9A4E03D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983627A4BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4C204F91;
	Tue,  4 Mar 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Tku9cEQN"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD5205AC1;
	Tue,  4 Mar 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097185; cv=none; b=DK/n3+BTv/x9Ge/DaeHNGEKaWc2pAX0Bsu59tKqS2oyN1N61Q4zwcYmgW88/GUoB3+ILqSMvAiWaZw7dO2ClxJab74/hhq0QsCR+Df+1gfMooNWIpYx+2uyTyaAUDBRHJvOx5JDvTaMVUvC6cDNgtRrNEq2uIiWkqVdbf0TonEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097185; c=relaxed/simple;
	bh=BV70LCl0n++b51ukHZr0pCr+VwV+YG6P8cY1u/ijnlw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2NXr3g84UpdaR342Fwe4CW6X9/8stFBq5LDxUuteXkYWuc8RrB7Vuueu9l8sAC75Fub5oCXBNbIDBzuiIpTzcgb8W6cqttDcK3n39wEwN7vYKZPTko4aeAMe/KwfmLSRVrrYUEQBFFxbMHqaVWplshxgqgfUAg6+4C6yYKs6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Tku9cEQN; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5246bSMg010811;
	Tue, 4 Mar 2025 08:06:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Adc1cByzmPRzz3pyBb
	B865XR0MMLr1Lzy0On0A44ZXg=; b=Tku9cEQN4F7gB6prSgA0TwiVCVSlXnJmQL
	1MBdBytDW4Yh9PeJEt+X9cLgdVSEawtsD1RMZVoecb8/lcK9+i1P7l/df2OkAwQV
	iGRuLOt6X01QscXVh4C8k0H7zbGu2+oz+FYvbhRW+nNBUuZ3n0K1tcDEL4VuZ6om
	Gc8QaaQNW/hnuPg+BoAVfUqbWmKe+yXi1ohmVRfZJqpCh4RjocwXd5m/Q8zRnNSA
	jROOmXdrG7gJxhQHvXiK5QMRbcQbBKI5PNzq7GgsZU6Py9RxGR9KuH2gsjuA5pXc
	mZhx4GmLqHTm9CsAaYoqSFwhTIFI9xJ5IJwr+elgIsdcIgcXF6Ww==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmf9qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 08:06:20 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 14:06:18 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 14:06:18 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 94A76820248;
	Tue,  4 Mar 2025 14:06:18 +0000 (UTC)
Date: Tue, 4 Mar 2025 14:06:17 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Liam
 Girdwood" <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42l43: Add jack delay debounce after suspend
Message-ID: <Z8cI2d1nmRROMUyh@opensource.cirrus.com>
References: <20250304140504.139245-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304140504.139245-1-mstrozek@opensource.cirrus.com>
X-Proofpoint-ORIG-GUID: b3ZXRb0CPk2_uPl4YXBORm1Vxt6JF55b
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c708dc cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=qK-piZbxyVT5VIhOeIsA:9 a=CjuIK1q_8ugA:10
 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: b3ZXRb0CPk2_uPl4YXBORm1Vxt6JF55b
X-Proofpoint-Spam-Reason: safe

On Tue, Mar 04, 2025 at 02:05:04PM +0000, Maciej Strozek wrote:
> Hardware reports jack absent after reset/suspension regardless of jack
> state, so introduce an additional delay only in suspension case to allow
> proper detection to take place after a short delay.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


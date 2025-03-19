Return-Path: <linux-kernel+bounces-568354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F23A69450
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B9E428091
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72E71DE4E7;
	Wed, 19 Mar 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="DYf+UT15"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F131DE3C8;
	Wed, 19 Mar 2025 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400341; cv=none; b=Lb/XpByby2mnXnmx3lZGaSMDIJ0qBE1N6M9UpuDAxTHa0mpcRrZnjkbABx2wiZFtJCGLMmzy5zPgaOOmL2dB4X18ecn2KEoQEUJThKeek8nLWOynuTtVdi8MTFixucwTATZBXVdbHkTtWfdqhdW9/XqLg2IdAo+LXzMOeGcXKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400341; c=relaxed/simple;
	bh=RW64X/teWwNMpQr9/mY+TL0fnZ+0aV8TDGaDi6J9BC0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhBHKQdf2rPzK9ttvvmqCDUheU1/LVUOelXKH8ONl4ZG1hXQ/eVafn+TeokAr0cAvMvqUke7+3lbmlugu092No8Q4H5NWz6I4N6Vd0DdG0lcHpq7Hp2y6fDyxZZHg3HVrQU6pgJ3ZoOZXW3t3YYWZxaLxPZozdsmnC5UvV6yxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=DYf+UT15; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J5OEcU031622;
	Wed, 19 Mar 2025 11:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=7OgdpVqb9pIwgdd830DoW+VuqcHMk4tD9PfXj/TVj5A=; b=
	DYf+UT156iQIp4FJyqflNeaOVWR8ulbBme6z+hYtq3/aH9m+V8Z06wtbM0mxnkvX
	L5izYqc1HFq0sO/rfh/Hsc7ubeu/MuM9SRmYF/+5U8VgmcehptYVxCRpOl3r7boh
	elMTfk6pDsbASEk36auOKyMYYgb9Lf3B3+4It2K9EoG/rUOH507utR/jCoGnN9K2
	MXcsS731E0S8Ceb4NvNPN8iNseqUK1rfn0QVlKZK2DDe2RQm1nV1TkLT5B2PwRWc
	gtr7nVzZNFfPRhALmAzivVJN/bhmsTVX4mmkzRUExnw6d7rZwr7sh5gpfkjUyTQr
	Adk2YoWgRZuePg170RbikA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45dc0mt8ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:05:15 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Mar
 2025 16:04:58 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 16:04:58 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id A9F95822563;
	Wed, 19 Mar 2025 16:04:58 +0000 (UTC)
Date: Wed, 19 Mar 2025 16:04:57 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 13/15] ASoC: ops: Factor out common code from get
 callbacks
Message-ID: <Z9rrKd1PoZ0WEaa6@opensource.cirrus.com>
References: <20250318171459.3203730-1-ckeepax@opensource.cirrus.com>
 <20250318171459.3203730-14-ckeepax@opensource.cirrus.com>
 <1d6d7537-1dcf-4bbe-a16b-902705efa860@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d6d7537-1dcf-4bbe-a16b-902705efa860@sirena.org.uk>
X-Proofpoint-GUID: vHAhANNwVBIdA6uPj3k1VZeyBIOEQiJO
X-Proofpoint-ORIG-GUID: vHAhANNwVBIdA6uPj3k1VZeyBIOEQiJO
X-Authority-Analysis: v=2.4 cv=XY+JzJ55 c=1 sm=1 tr=0 ts=67daeb3b cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=fExjZ7oZFv1sFj6PVPQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe

On Wed, Mar 19, 2025 at 03:12:56PM +0000, Mark Brown wrote:
> On Tue, Mar 18, 2025 at 05:14:57PM +0000, Charles Keepax wrote:
> > There are only two differences between snd_soc_get_volsw() and
> > snd_soc_get_volsw_sx(). The maximum field is handled differently, and
> > snd_soc_get_volsw() supports double controls with both values in the
> > same register.
> 
> This breaks an x86 allmodconfig build:
> 
> /build/stage/linux/sound/soc/soc-ops.c: In function ‘snd_soc_get_volsw_sx’:
> /build/stage/linux/sound/soc/soc-ops.c:374:22: error: unused variable ‘reg2’ [-W
> error=unused-variable]
>   374 |         unsigned int reg2 = mc->rreg;
>       |                      ^~~~
> /build/stage/linux/sound/soc/soc-ops.c:373:22: error: unused variable ‘reg’ [-We
> rror=unused-variable]
>   373 |         unsigned int reg = mc->reg;
>       |                      ^~~
> cc1: all warnings being treated as errors
> 
> Please ensure your serieses are bisectable.

Sorry those do get cleaned up in the next patch but will respin
to move them into this patch, must have got muddled in the rebase
at some point.

Thanks,
Charles


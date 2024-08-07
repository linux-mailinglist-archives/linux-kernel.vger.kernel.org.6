Return-Path: <linux-kernel+bounces-277868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED95194A77F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D2D2830C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF52C1E4F05;
	Wed,  7 Aug 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Y+ABNLz8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864F1CCB45;
	Wed,  7 Aug 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032470; cv=none; b=lsEWfM/FOwRRWg23Z54V1AWJYgj7KJKdY+/i6Cbln/vWVsf5hUL6/aeaJQMK8k5MiE1K841ytXI7yMN9+m0EAi+P2ICeLrpTjywXK4OsF8EG0YylxC5VHVjJJYa6WAYTFCBVN0ZkyGAmeiXaHj1OnRJRwzOMCKnwIN0wkaJBgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032470; c=relaxed/simple;
	bh=MDDNu/zajjfFpykkUwCqlLc2ljXZwowVHH4+J5jVMIU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu/CLzmUOqCtlBXaQLjtK5xuSK2rrrvSA7/KyZauzEkcTMYLY0nQksTeAQVTWMFgnmZE3oANqKSgMfqCJGLkZH6Uuq/a3mDw0/H6UOuwgLqE1//UFwtJpSeJp1Sys+Fm4JV3FFs9JF8Oa3tc7gotT0tu86t3WbtGjWWKfHv6vvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Y+ABNLz8; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47700RE1025336;
	Wed, 7 Aug 2024 07:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=6jY5QYeGmEHK54GJH2
	dhb4cGIv8f9TreS6EMGG3Fk3A=; b=Y+ABNLz8CbDp9UnVCRY6kbiK2VQp64N0ma
	mp7CjNqBwUPs4g5rqe1lWhfwDyNMH0an+KtuiRFK6tqT2gbB2frzt5Ms4n78oOzv
	B/j2NBh4qaKBShOAmrDoJNmTCHur1ImipX0HuVeyFgpZO3iTtqRzPGLgfXMjmsOh
	X79M0F/FPiMklp8iybEanYN19byeJxy/CCp10ZgPke6GQuS0MJPKropHw9ujvw0e
	byB6wOALPtFkO8JMfsd7M2tf3Z+vCkBCxImU5OA0LJTEbclxxvvszHQnuVWsZzhz
	UnFQQ7oQxypxSBcBGchqWSiGkWnmAQlfsNrR0CiuzPqNUlEKlJHg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40sgyhvae3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 07:05:24 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 Aug 2024
 13:05:22 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 7 Aug 2024 13:05:22 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id C0476820241;
	Wed,  7 Aug 2024 12:05:22 +0000 (UTC)
Date: Wed, 7 Aug 2024 13:05:21 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs43130: Constify struct reg_sequence and
 reg_sequences
Message-ID: <ZrNjAdV7wG1SvX9G@opensource.cirrus.com>
References: <5b906a0cc9b7be15d0d6310069f54254a75ea767.1722951770.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5b906a0cc9b7be15d0d6310069f54254a75ea767.1722951770.git.christophe.jaillet@wanadoo.fr>
X-Proofpoint-ORIG-GUID: PY5ysZ-wbzARALhasRhm8SICPhdPLjzM
X-Proofpoint-GUID: PY5ysZ-wbzARALhasRhm8SICPhdPLjzM
X-Proofpoint-Spam-Reason: safe

On Tue, Aug 06, 2024 at 03:43:00PM +0200, Christophe JAILLET wrote:
> 'struct reg_sequence' and 'struct reg_sequences' are not modified in this
> drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   54409	   7881	     64	  62354	   f392	sound/soc/codecs/cs43130.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   55562	   6729	     64	  62355	   f393	sound/soc/codecs/cs43130.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


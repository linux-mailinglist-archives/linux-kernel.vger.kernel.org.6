Return-Path: <linux-kernel+bounces-377884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698819AC810
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8392828D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865B01A0AF0;
	Wed, 23 Oct 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GA2HRKk1"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D221CA84;
	Wed, 23 Oct 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679914; cv=none; b=HGwXO/InIkGiuD7taNWB9rNm+c0kkB3Sd5Q7JQ/1XPT3kJOgsF4oKS2rrkcqpBp+e+lJceZhyraXUIl50BWzfDALsxnG6mlj0Us4Rf/XFltu88Wp5sXPAvE4ol2ws4cANThCkBMzGrPR9pVwnGkKdduuvlPbqMgDcuyA8FXSjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679914; c=relaxed/simple;
	bh=dGrUkReW/jmU2friNXD2xLiCuXEVtZVo4FJ7ZK9AQTg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB4i5/gFZ+G7wtunH0Ak28a+Imt1YdXGkZNSBQvTVrjyla42o5g1TzfP4A0pjGUHlBqp1y6CUjReyFIpKwqt46YE6U/6qV9eHCGCx0yojq3vGrW+nCNxvXKwiWIX6srgAAShz8ZBKV/EnDkpiQyEF0CwK9s7i8dFbhtY5kgl9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GA2HRKk1; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N2bpEp023824;
	Wed, 23 Oct 2024 05:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=YlIPwoifJWw+ux8fJL
	Lw+ug+EejR1tLOpfYAWah2kPU=; b=GA2HRKk14HrgVFcQ0l1fLJ1YevJePZdwBQ
	U5hUv/0p5Jqlqr/ZFJO2p72EtQ3yGzJKVX1tldKbcpU8YcmefUYYAepjcIdG7rFy
	sCH5LvPyLd0rWKsM1DSZ28A4g3apAqOqKW2MNQRBy9S79lOfdRUK65w4lxXc2LR5
	0nLvRLMOLVkamThMPI/lgU/aP7BUpuk/AUHqA7Sm5vawabOEHrHa4C21pjoNWqSl
	kDE3HWVCix/UwHRa+spciCZFmGZq9+dDqClhi85un1C0jB/7o8At5x3SV2MZunWS
	FjgTr8b1yf4VqsTBZ3ylmzQG5QzUVN6lV0BWBCGOIEcwVJeEFdDQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42c96jcpk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 05:38:26 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 11:38:25 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 23 Oct 2024 11:38:25 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 14BE4822563;
	Wed, 23 Oct 2024 10:38:25 +0000 (UTC)
Date: Wed, 23 Oct 2024 11:38:24 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
CC: Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: cs42l43: Prepare support for updated bios patch
Message-ID: <ZxjSIBpW5syCULnZ@opensource.cirrus.com>
References: <20241023100636.28511-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241023100636.28511-1-mstrozek@opensource.cirrus.com>
X-Proofpoint-GUID: Tu7ytfnWM6FImtN-cecc04lRP9jJGvt6
X-Proofpoint-ORIG-GUID: Tu7ytfnWM6FImtN-cecc04lRP9jJGvt6
X-Proofpoint-Spam-Reason: safe

On Wed, Oct 23, 2024 at 11:06:34AM +0100, Maciej Strozek wrote:
> Newer bios patch firmware versions now require use of the shadow register
> interface, which was previously only required by the full firmware, update
> the check accordingly.
> 
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


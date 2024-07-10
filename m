Return-Path: <linux-kernel+bounces-247580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DA292D170
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB641F26051
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF469191477;
	Wed, 10 Jul 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="keWugzRq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC777D412;
	Wed, 10 Jul 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614016; cv=none; b=gMPUlLm3FpT+Ugtri18ZYO9soodYtctMoEtlomh6SRk8hnKvi5NHp+hluAg8tIBXSXXm8fZbE6Glp8tc2+/3rs5gO5jhq8FHKnlVY1xUKMZ60uweBb5WlF5WFYtCoOlCbhPgLgx4Qqp4GzWYuMP3Wdr/SeDOdf/mHQZpR0hpr4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614016; c=relaxed/simple;
	bh=WkU9BfW3pAExft9EM42LNfPQ5lLYTbNJeLEt6/5L3U4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNkFPOJKsaCcjHO+816efwG5u9H9NzJemlyHFccoiUE6ttY+6er5XG5lc/ojRtq6xm4V4g3jtYw9SOgA1VMGTi3mF1TFOP8AW1g0iVrnSVDC8ygRWhmiDnd+N7JTV+h07ag0mDmIYSgfibDTjSfHvVNYZzrKHUhCAv2vJAG/iS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=keWugzRq; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AAoWrX023331;
	Wed, 10 Jul 2024 07:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=/9T282nrPufNecAfzI
	OmDR/SirUSNMBN8IkI2jQajq8=; b=keWugzRqABpcqvjLfRq0KquBRyyQLj+Abe
	Q0bM+uZQbRXyDOcdE2dnnqo8S/fyVnibU84GgqiGFaW6DGTFQvtYLBTxmkFZkmlR
	W3FPjDhFplTu69eUqEBBIQujK6eiszOQ+trdmwr8HRw/JRYSYKp93sDZSrQh5GjP
	Yw+ZoA0f2kgG/RT/tNMAVTMx2on7+WqT699yhG5apNdnlSE/wYRyAeR5q7LAYB6t
	tOHwcpGUPk8SpOK6MHXbxTqB/ppTzB/Jm4sckhuY5ujpL+ebGuQuReMO8cqgtTCH
	82udK33OI3MBV0YfR9yavc0Ac1FLva9vRGJG1S4VT2fQow96Loxw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 409b72rpku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 07:20:06 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 13:20:04 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Jul 2024 13:20:04 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 47152820244;
	Wed, 10 Jul 2024 12:20:04 +0000 (UTC)
Date: Wed, 10 Jul 2024 13:20:03 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
CC: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] firmware: cs_dsp: Some small coding improvements
Message-ID: <Zo58c0J11bbAiEdO@opensource.cirrus.com>
References: <20240710103640.78197-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710103640.78197-1-rf@opensource.cirrus.com>
X-Proofpoint-ORIG-GUID: EU7ANkoBC7lrXUyDenlwZoXswcwZ2qGS
X-Proofpoint-GUID: EU7ANkoBC7lrXUyDenlwZoXswcwZ2qGS
X-Proofpoint-Spam-Reason: safe

On Wed, Jul 10, 2024 at 11:36:36AM +0100, Richard Fitzgerald wrote:
> Commit series that makes some small improvements to code and the
> kernel log messages.
> 
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


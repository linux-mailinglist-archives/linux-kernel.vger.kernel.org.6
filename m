Return-Path: <linux-kernel+bounces-449035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47E9F48D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E72A16BA59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DF1E1C30;
	Tue, 17 Dec 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KwdgH1bd"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315F91DDC3F;
	Tue, 17 Dec 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431168; cv=none; b=h/yuVMlzlsGVq+lhdGshEjFVsG1ajtvFBW3xR9O/fbD2ZoU/piSQMZ1+fMMZpR3i767AuJsbkBcKdHQkOzKCf/W4CT+MZce7LYR0ivhpr9SJJa5er9cB980N5a51Ku+jvSQwQ3EXfNn9MNNb8lQ9rlQYGaA+pi4qLGtW8m5gfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431168; c=relaxed/simple;
	bh=lqHw+hupG5mSRafe+QaFncERJyQxMhaY37IXYW2iCMM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOk6FP8okIrmwKRzGOkf1wDq08q3IGMpH0c6e5i0T/LQJiJhNNOHnCTBVLrUX4hCme7WkYiwEwfXa80iwmF73LV1awJO1AawixRDEmxkry397Ui3x5fFZEKpkplODfpscZR0pgoB8Ed0dKnwjiTaf2Quba+PrEE5YjJ350VSFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KwdgH1bd; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH5hMJU020942;
	Tue, 17 Dec 2024 04:25:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=AnGIWHeYE4P3kZQU+L
	FsA2DmuK6EvLXnD1X6DUh23eo=; b=KwdgH1bdZLCJC2WpR7RgblDbyeG6sYsEdD
	tVhBWpny52lon07WDU/y56doJMC3Ex3H7NMbLcZQs4ChJFThNwX6SD+xkQZXOHTL
	bUIPKhKQFsc7GjkPWn7Tos2RddqHXYG7SQDyA/hJp/+l5+g9U4YCyDa/y2hX06Wf
	MTEJkp7LMVoU4gz+AjhkvQ+JGJXuSuixjnmEjaNZvOVcesTBPXSTdgU2ygxHZ01m
	xSGfz6OAp/tAg+TkAK1OMdbxZQFSNyOSCnZDLqX9YTy4uikdbS4IEh2gdZp4U6FF
	VUjVISEMF1fS5oqmXxBuJys0Ref5hqwcQIRdJM/Qt+YBmemVRXDw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7akb4xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 04:25:43 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Tue, 17 Dec
 2024 10:25:41 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Tue, 17 Dec 2024 10:25:41 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id E0941820248;
	Tue, 17 Dec 2024 10:25:41 +0000 (UTC)
Date: Tue, 17 Dec 2024 10:25:40 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: <linux-kernel@vger.kernel.org>, David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l43: don't include '<linux/find.h>' directly
Message-ID: <Z2FRpGokwmWmxZ/N@opensource.cirrus.com>
References: <20241217070545.2533-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241217070545.2533-2-wsa+renesas@sang-engineering.com>
X-Proofpoint-GUID: JM2RmZKPgaJ2AhhPYLvhkjJVvNqRQ0Dk
X-Proofpoint-ORIG-GUID: JM2RmZKPgaJ2AhhPYLvhkjJVvNqRQ0Dk
X-Proofpoint-Spam-Reason: safe

On Tue, Dec 17, 2024 at 08:05:45AM +0100, Wolfram Sang wrote:
> The header clearly states that it does not want to be included directly,
> only via '<linux/bitmap.h>'. Replace the include accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


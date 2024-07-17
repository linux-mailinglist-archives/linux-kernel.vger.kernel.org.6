Return-Path: <linux-kernel+bounces-254880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C625B9338DC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C3CB23181
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73838F97;
	Wed, 17 Jul 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jWuQpBb8"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3317376E9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204409; cv=none; b=gHzyCypuWbplhnUux199wYK69HVec9xL/cxBV4qBCBjUSNeCAhfaCcpOXE7itgqBwgLdGBO8/a5zHknPgdGz7PrTYjnhS3HM/V/sORQutfcR8Y4wGY+OrxGa7pRjaR/J4UKKDLzefj2wEe1ekxDx/j1a0a0VoZ9Wqqo8DYpMN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204409; c=relaxed/simple;
	bh=e6u5DXYvWe9AfBIeunZ32rLwBUOnL07mqu6HnKz+Hd0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAwmPGPAPdDLGki6Vn/vHiHUb3zQpkbcH/z+VPe2LqRvIX6cqVQ2vFzaUiTBiL0Ao+nUqslwSu4L3xCF3k61ip63DfsYSkG69DyOWUkWFCRWlpWYP2DrX3Dwz7DMK6cO1ssGLtt4Qe5Y+TboDKa14wm9QuVXXBHgjqQg5KH3J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jWuQpBb8; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H5srGi013138;
	Wed, 17 Jul 2024 03:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Vrysff8VaQmuw4qwsy
	PYQ4a+6HDU2sFXDQK0pKW5lR0=; b=jWuQpBb8Y94BfXrHf2tkJZ6W8BKeZ78Ibw
	XZ1EShFwUXuFJ8xEZwTiGdugylzG8ByB1q3lj2Pf3secic7AcB5WxjkdiWoHJuz5
	r72CtC1ygzbXYJqUTI4zwmlNF3nd8rYeSD846D6qkOUubcTw8HuI0LKO9Rsc99ks
	zKGgv0yJ9BEvIap6f0v3H0Dy8G72gOA4U7zgDWxfhJqYWl0LwzboVkHfP2ZUm+/c
	XkQc0NRf8CQltwmtTynDv/xLPRxJoDgWHlcztrbYYwdR9NcHEQEfuFcfsuI/E4g/
	wqWLWx3J6/Sz7SULXjQjKMJuksQpVaEtWJt4ko3N/SoMVvxL2iRA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40dwengkqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 03:19:48 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 09:19:46 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 17 Jul 2024 09:19:46 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 2B8F0820244;
	Wed, 17 Jul 2024 08:19:46 +0000 (UTC)
Date: Wed, 17 Jul 2024 09:19:45 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Chen Ni <nichen@iscas.ac.cn>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <axel.lin@ingics.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: wm831x-isink: Convert comma to semicolon
Message-ID: <Zpd+oXtUsC0z08d6@opensource.cirrus.com>
References: <20240716085115.1252817-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240716085115.1252817-1-nichen@iscas.ac.cn>
X-Proofpoint-ORIG-GUID: RElDV-OUkLaXNRkjyfe7xU6IOAlrxW1j
X-Proofpoint-GUID: RElDV-OUkLaXNRkjyfe7xU6IOAlrxW1j
X-Proofpoint-Spam-Reason: safe

On Tue, Jul 16, 2024 at 04:51:15PM +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Fixes: d48acfd0377f ("regulator: wm831x-isink: Convert to use regulator_set/get_current_limit_regmap")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


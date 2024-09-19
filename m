Return-Path: <linux-kernel+bounces-333704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FE897CC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEDF1C229BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4EC1A0705;
	Thu, 19 Sep 2024 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dUQnOKhY"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCEB1A01B8
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726764300; cv=none; b=FQ//unmc+Zm/TpoUPNEbNE59/dZNtj8uMcpv2JBNCFY6F9amXdMgH1bEZ53cM8LqMerIpV7syRENG7dJmjdprh7Ww9jiyWEU1Y2yx2ywCxzeyHN0FXPbM+laZKyf94IfqIzFakZtMkBOumxc6IES/P0w+0wimqQSmk0KrMDs0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726764300; c=relaxed/simple;
	bh=fGLwGNvhSyUN4tqy0B8fOiB+Akxq1PKmNmdksMZgeAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVUICPt6hIou7X+jrbCLjNe5KPOPsysq+Vp4PqBHjrDGZPIsKgsEdcSeRmUo2BzLEKODg5qOa4d5VkwN3+eQF7/gy/kYzgEetEWkMGp/5c80hV2kiAiRDbEjpGKM5UHjQ4SsUdGUmNkfygAv9FVaPTSNaS0HW4WgtsCpxSAoJLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dUQnOKhY; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J5eFFQ010089;
	Thu, 19 Sep 2024 11:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Y8HDrDZcq5CrBJHhSm
	2kcFKekp/6O3KZeOV0pu87RQI=; b=dUQnOKhYgtM2aqZdY1KwFIfdyJvnW8XfP9
	vL7IeCwN9v2wPpYqd0FsvQ+kVXJ8KHeb6OOTLkeSmYpgG+JwvuwECi6M0Ybu71Lb
	qBWf62hkY1DpMVHJLgUXhgAsKPk0bg5GP0mE0vx3y8IWjt5eruAYO96XiRevANrH
	mMt6e3UGX9NdsmnUqByXftYlXIxNAW+Ad1yz6rjetABzJlp6n3maEJE529/y/S06
	75XbFS3LS4G+rrT2Wdbd63DACjp4TJJCX93/Wp7f7P/aiuo4yeHngxztel/ozwiA
	46xP2BVG9TZEXomF2drPSUojUXjFHg5NZHMF4CSOoEvHwPG4EDSA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 41n6wjp896-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 11:44:33 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Sep
 2024 17:44:31 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 19 Sep 2024 17:44:31 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id B322A820248;
	Thu, 19 Sep 2024 16:44:31 +0000 (UTC)
Date: Thu, 19 Sep 2024 17:44:30 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
CC: David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs35l45: Corrects cs35l45_get_clk_freq_id function
 data type
Message-ID: <ZuxU7tjueKOkE+d1@opensource.cirrus.com>
References: <20240919151654.197337-1-rriveram@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240919151654.197337-1-rriveram@opensource.cirrus.com>
X-Proofpoint-GUID: URMPacK92kHMxA_bqBMt9HDVXFD1CHyH
X-Proofpoint-ORIG-GUID: URMPacK92kHMxA_bqBMt9HDVXFD1CHyH
X-Proofpoint-Spam-Reason: safe

On Thu, Sep 19, 2024 at 03:16:52PM +0000, Ricardo Rivera-Matos wrote:
> Changes cs35l45_get_clk_freq_id() function data type from unsigned int
> to int. This function is returns a positive index value if successful
> or a negative error code if unsuccessful.
> 
> Functionally there should be no difference as long as the unsigned int
> return is interpreted as an int, however it should be corrected for
> readability.
> 
> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


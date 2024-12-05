Return-Path: <linux-kernel+bounces-433356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4909E575E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CCD284109
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27B9218ACD;
	Thu,  5 Dec 2024 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="meXEYwJV"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45536C;
	Thu,  5 Dec 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405990; cv=none; b=AtgdjcVoNMABgnG+CcnK82g0elJnCYrYWHZzKOGllMgfqDPHIxTrmxwoCLd4+fX40XEgHj5x6QJxTHpMSxXcMn6Ov9I9Txw23FQMRkP7xILlOTs4xcx5nsa9JSLjXISZg5yVbEmDiwzmcc0WtFqFgGoPZx7o98xig2zea8FW64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405990; c=relaxed/simple;
	bh=3TalG+fQvuVcl6qlH6a3g68GrMatWcukWXt9dvrqCCk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAP4nkMkbciZxs+s+ZpP3lchwQY0AiwG6lxyhUgiNhW7nmDcDTGjEbYAy6RMaDTQ6e6sdWoBYGXh9KX8vcuZICi1VukhARRkNKfg7MltCmA7Pk//iMiD6z4Vo6Y+TOQJu8JQUudQQpTpfOWnUYnP+VqxFCymIq2WRYtALxSjOCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=meXEYwJV; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B58OKdA011724;
	Thu, 5 Dec 2024 07:39:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=mwHrasWI7OIzdccU2t
	YUBifYMW3YIbQB/3qFmWvokyk=; b=meXEYwJV/2J2TGsxoMzlJ+j3XWbxdLZLfM
	H+z3KzV2HsdcA+4heYNBwP0kUAJfYMcYFu7htIA1y/M9XiMk9nUbgBOjPcGxlHVo
	xzR+seO4Y+sImBTQZyTu3YfkoHBZqOBMT86mQHyqBX7wJKJZOrPHMr8EJdb2M/5D
	c8qiIMMiwar5qnOdhggFBHgiSKxLl1OsRacnJcLErdlEuyI7xqNoMaM5XNlyCKn3
	4AznUidCnr/URFXp8y91f/DBFEc20T9YuF1+kVmEdl3pgyQ7o8hpjaLZENYV1Pne
	AV6GUrn/6wDR0YspaM9ga6GsdhFEsbwwAk9sFxaO0M0+eJjDapTQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43ap2b9twq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 07:39:28 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 5 Dec
 2024 13:39:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 5 Dec 2024 13:39:27 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 34DBC820247;
	Thu,  5 Dec 2024 13:39:27 +0000 (UTC)
Date: Thu, 5 Dec 2024 13:39:26 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andrew Davis <afd@ti.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Marek Vasut <marex@denx.de>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 20/21] ASoC: wm8904: Remove use of i2c_match_id()
Message-ID: <Z1GtDvuJAUSNrOq6@opensource.cirrus.com>
References: <20241203200001.197295-1-afd@ti.com>
 <20241203200001.197295-20-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241203200001.197295-20-afd@ti.com>
X-Proofpoint-GUID: udCdSbBI7IQwbOZZwArODVkD3Uk06UoE
X-Proofpoint-ORIG-GUID: udCdSbBI7IQwbOZZwArODVkD3Uk06UoE
X-Proofpoint-Spam-Reason: safe

On Tue, Dec 03, 2024 at 02:00:00PM -0600, Andrew Davis wrote:
> The function i2c_match_id() is used to fetch the matching ID from
> the i2c_device_id table. This is often used to then retrieve the
> matching driver_data. This can be done in one step with the helper
> i2c_get_match_data().
> 
> This helper has a couple other benefits:
>  * It doesn't need the i2c_device_id passed in so we do not need
>    to have that forward declared, allowing us to remove those or
>    move the i2c_device_id table down to its more natural spot
>    with the other module info.
>  * It also checks for device match data, which allows for OF and
>    ACPI based probing. That means we do not have to manually check
>    those first and can remove those checks.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles


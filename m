Return-Path: <linux-kernel+bounces-390405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9059B7970
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CDC2853A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943E19AA43;
	Thu, 31 Oct 2024 11:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hHmpXcD5"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC513A869;
	Thu, 31 Oct 2024 11:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373250; cv=none; b=jjyrQrkjwT5FJc2fKYSW5WpL9l6G70LuDnUvOAVO/VqgVB8lTnAl4LQ6pNBRTSrAeC07wOt4UUGGge9KUESCwFFCM3UBgZiBDX7Q/jYUUf9KnebXLqPL837QIerq6FGEpHF6Xb6qz7v4L+utLCfzvnWmpCnvcB6BGZUFHGeQcMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373250; c=relaxed/simple;
	bh=GfY6uEgX/ususpsUcZOx7OWF5IJU0mwMlBmVQZiOSsE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8G4U9iJWkn+jsxdMjGacmiAzkY/jvch8aXmgu/bovNCAmlaIlmiRvzYB7MBd3JA8PvguhrTcirZsNFWyXew/ymfabYiviHPJSTeu7X1hAKy7pXgb+W82oIg79v2hBrLVC8aMeoj6d6jtO98qVhgtGaBuZCj833qJJsgPdkU4TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hHmpXcD5; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V6nioL009687;
	Thu, 31 Oct 2024 06:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=YYC/8DnwoAIbtcz0I+
	v3DJqMUw3+Qmf/MjyCT7t5k1E=; b=hHmpXcD5x9m2K/9IXPzvJOBy7nF1TxUAvs
	M3WKAFt8CYVMlmxI9A7ySoezAfL1xV1XDPMWP0gcX7SrI6kJc3lWvJLZNB8hSPa/
	ve6NjwEa6C6x+oc7g26GpLMdNiX9ZO+Eka4mEs9hoipjotp7bhpx5zGy6Ly40b0+
	9GOh39UxfWqdpCxv2J7BtIxxfeH6GM171N5BJb2N2zRllNjmwU1SUPijxo7palXe
	TKwjIjx2JMY9a/sStRfFJx0aGwmlbeOO48mGSl+ftuxw2zX766qLOhdlfmYG3Nb0
	D6KXZYO9zj1j0kJsAWFo0tVn7d0h1MVuusekZdQhTSRlRL5ugiCw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 42gvuje4vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 06:13:52 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 31 Oct
 2024 11:13:50 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 31 Oct 2024 11:13:50 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 9ABBC820241;
	Thu, 31 Oct 2024 11:13:50 +0000 (UTC)
Date: Thu, 31 Oct 2024 11:13:49 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: anish kumar <yesanishhere@gmail.com>
CC: <perex@perex.cz>, <tiwai@suse.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH V3] Docs/sound: Update codec-to-codec documentation
Message-ID: <ZyNmbQ88HbvkaSe8@opensource.cirrus.com>
References: <20241028194121.41993-1-yesanishhere@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028194121.41993-1-yesanishhere@gmail.com>
X-Proofpoint-GUID: r-wnKOItCPaFgg7dN0ce5OH3aXa1sIN5
X-Proofpoint-ORIG-GUID: r-wnKOItCPaFgg7dN0ce5OH3aXa1sIN5
X-Proofpoint-Spam-Reason: safe

On Mon, Oct 28, 2024 at 12:41:21PM -0700, anish kumar wrote:
> Updated documentation to provide more details
> for codec-to-codec connection.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
> v3: took care of comments from Charles Keepax and
> as advised modified some details.

This still has all the DPCM bits in it.

Thanks,
Charles


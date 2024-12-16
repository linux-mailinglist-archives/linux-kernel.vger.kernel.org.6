Return-Path: <linux-kernel+bounces-447334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72719F30B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649F21884759
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F728204C0B;
	Mon, 16 Dec 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GcjnhCrO"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4A1B2194
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352793; cv=none; b=AOlW6oKQylt6OtExaE4uS0t5v1xsQvc5mLGZTncRQvJQuY8+eu8ko3kT9TDHsW4X3V5mWPEM9RxhMnV/dA2fscryaYMX+JgYf4hJdvcQ20qypbZD/8mc3Ox/QVafPPmFoeq52OzwGy2GA0+KJx3/mEwuYDAicGorJXrMIFu+mLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352793; c=relaxed/simple;
	bh=pJEjw6EzQYkWiQVE22OwDMseYB07tCS4DHUWU3Ile5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z98GFgwyTSqTxm/079mbkIh67GscIjCOTDGDFq4eCIxTocG0bTqTH0gsBzWwM7urfkFifRQbXCrlG2Nz8O8khawwKOjl8cfagONco+1XogT4hhFrSdR7ag3zfZ6JdtwZjMUqEGS5PD95thb13YEsezkT2uSlel+y6/91KLiqypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GcjnhCrO; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5V8UJ015483;
	Mon, 16 Dec 2024 06:39:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=DQuyqVvwj9ONaU5MhEF4WkZTeAPtFXKmvIFuxXlber0=; b=
	GcjnhCrOflJHUd8ex3RdMa1X85XgP3GquC+dKMiQSQYvIDyxcFBqD3YZuk8rAKyD
	4IscSCrgxOEUSEPlDML4asZG4ZRdiYZUB4RQAVnVpGr3ZaSTeaNnt3YQ4nAtyCyY
	Ai30dXuZbz7wpmFXOvDV0dRzl2StDSww1KYycHVk8qmNlC174NEuwKweUMSQJfsZ
	aiGMwrbKKRw66U2i6kocD/a/Qlakmbjxg2jShRZ6gs3cHz/3WDJn6IMcLX6fn4T+
	f33m9dnGLPd6bUZpMF4KBPp3x17BjjXSidZjUicQthgh0S0hby++prwYXxrv+a1d
	g5SamGl+28SoKfgXQCc5Bg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43h7ak9vp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 06:39:46 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 16 Dec
 2024 12:39:44 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Mon, 16 Dec 2024 12:39:44 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E1AC1820248;
	Mon, 16 Dec 2024 12:39:44 +0000 (UTC)
Message-ID: <b1bf6353-1aa8-4457-8d4a-09b7e9aec97a@opensource.cirrus.com>
Date: Mon, 16 Dec 2024 12:39:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] firmware: cs_dsp: avoid large local variables
To: Arnd Bergmann <arnd@kernel.org>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20241216121541.3455880-1-arnd@kernel.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20241216121541.3455880-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Jz9TAl_CEbDBMlMZ2gbGfWR8Kan4ZiYK
X-Proofpoint-ORIG-GUID: Jz9TAl_CEbDBMlMZ2gbGfWR8Kan4ZiYK
X-Proofpoint-Spam-Reason: safe

On 16/12/2024 12:15 pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Having 1280 bytes of local variables on the stack exceeds the limit
> on 32-bit architectures:
> 
> drivers/firmware/cirrus/test/cs_dsp_test_bin.c: In function 'bin_patch_mixed_packed_unpacked_random':
> drivers/firmware/cirrus/test/cs_dsp_test_bin.c:2097:1: error: the frame size of 1784 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Use dynamic allocation for the largest two here.
> 
> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file download")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2 changes:
>   - use kunit_kmalloc() as suggested by Richard Fitzgerald
>   - use KUNIT_ASSERT_NOT_NULL
> ---
>   .../firmware/cirrus/test/cs_dsp_test_bin.c    | 33 +++++++++++--------
>   1 file changed, 19 insertions(+), 14 deletions(-)
> 
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks for doing this.



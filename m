Return-Path: <linux-kernel+bounces-447164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D263F9F2E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CD118862AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1CE202F9C;
	Mon, 16 Dec 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ny45pzCM"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0B91CD1E0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345494; cv=none; b=fScu/ABApQmtOF2Z/wmWjfF4d8lhUnQpL17TtnN6AG5z/93nMgv+n3NzorWTwY3szKixcwIaYRuDU0iekIZpsn6iClzuOSb57YQdIigX+ioGcuUWzKHxFKBBkC+ImIg/j2mrDNiVCUtMUM0Sb7bqL3kx/UD2Ru/lLqrjBu9dTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345494; c=relaxed/simple;
	bh=EGtSWG4Rut1Ia8UPgSmiXqdwlwP/qEPwRaOH7D+U828=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OHNpSSqhGHY0VX7StvVzZM1uRIOL92JFCJzVGmk2xpH/4QVGpG4wJilw96YGuL3HcnH8iIxEI9SUniTDiGD4tt2Yo8bGBDD6amB0YZtuW91xEG7G/zlWhcNv5+lLwnTfruiyB5wQ64WMmmZrt0o3lf4KIyedj8gPbw3iiHG7AIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ny45pzCM; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG6OVHd012187;
	Mon, 16 Dec 2024 04:38:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ud4Kmnsu8tLnlY1m7ZcF+1EeHkir3Do1FUvzucqQGt4=; b=
	Ny45pzCMGK4SV+e4RnjQ99bOoT7ZMyQX16pY15T23ps8gGoUeGKHv+e2e2uWZ/W3
	tEOoU7Jz9aCV0ydSQrzNwwJoiGWNrY2qYI4rSZwxC11ptyV5NeqghUIfmFL7N6M7
	hoaTQfjPPoXCBzvMHNA+QjxSaPXr0TD7QaecY6sq242MAbdYIVQPmDbPpTOy2PD4
	xBRiO8/ChmIsZniHGDJEVRSLtyTmAOJi9VyzECXC9G8mkIMFoESyC/kzGFfW4zxe
	VAPi/AOsmKKkyYmcskzhEs9qJHdBgu+cyzxZXRXI1wFpgMQk+ICOojPyVM5j/gHU
	wJBVOJl9TK+IlevWXoliXQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 43h8a21rmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 04:38:07 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Mon, 16 Dec
 2024 10:38:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Mon, 16 Dec 2024 10:38:05 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 67D16820248;
	Mon, 16 Dec 2024 10:38:05 +0000 (UTC)
Message-ID: <940e60d3-2617-4156-945e-01b1e345c27e@opensource.cirrus.com>
Date: Mon, 16 Dec 2024 10:38:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: avoid large local variables
To: Arnd Bergmann <arnd@kernel.org>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20241216083350.1866908-1-arnd@kernel.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20241216083350.1866908-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YxaiVQLKZNVRpShyPgNYlsoLDSItq3zZ
X-Proofpoint-GUID: YxaiVQLKZNVRpShyPgNYlsoLDSItq3zZ
X-Proofpoint-Spam-Reason: safe

On 16/12/2024 8:33 am, Arnd Bergmann wrote:
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
>   .../firmware/cirrus/test/cs_dsp_test_bin.c    | 36 +++++++++++--------
>   1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
> index 689190453307..f1955813919c 100644
> --- a/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
> +++ b/drivers/firmware/cirrus/test/cs_dsp_test_bin.c
> @@ -1978,8 +1978,10 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
>   		 4, 51, 76, 72, 16,  6, 39, 62, 15, 41, 28, 73, 53, 40, 45, 54,
>   		14, 55, 46, 66, 64, 59, 23,  9, 67, 47, 19, 71, 35, 18, 42,  1,
>   	};
> -	u32 packed_payload[80][3];
> -	u32 unpacked_payload[80];
> +	struct {
> +		u32 packed[80][3];
> +		u32 unpacked[80];
> +	} *payload;
>   	u32 readback[3];
>   	unsigned int alg_base_words, patch_pos_words;
>   	unsigned int alg_base_in_packed_regs, patch_pos_in_packed_regs;
> @@ -1988,8 +1990,12 @@ static void bin_patch_mixed_packed_unpacked_random(struct kunit *test)
>   	struct firmware *fw;
>   	int i;
>   
> -	get_random_bytes(packed_payload, sizeof(packed_payload));
> -	get_random_bytes(unpacked_payload, sizeof(unpacked_payload));
> +	payload = kmalloc(sizeof(*payload), GFP_KERNEL);

Should be kunit_kmalloc() so the kunit framework frees it automatically
if any test case fails and the test terminates early.

Apart from that it looks ok to me.


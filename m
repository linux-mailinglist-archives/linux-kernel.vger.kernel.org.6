Return-Path: <linux-kernel+bounces-427142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B19DFD2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59C0281D1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABC41F9F60;
	Mon,  2 Dec 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bP9QtALF"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327F3398B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131889; cv=none; b=I6pkNUsnMDEK603IW2jKYFU9LkQJeFfsoWY6CBl4765KRmC85/jOXjbaB6N51R9PEWGgdKpsGAZbQshagn5BmLmr2HxnCsWYhWjcDlG+Db01IebQ8nved3Q4wQh5DAmjsdyN2ABrm03E0AwhnKdiR/1dYuoSRKG6D92gKR0kuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131889; c=relaxed/simple;
	bh=JD7IQN6zHNlBZQ6W5cpyN+b7BjBP6VxBGWe5dvbYbZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=k335wB9JduVlZQdCEEOc1ZHA4JPxDNtphCsT6NVfKb2UU3FpBiq2FIw/H1WjKBlUA5JDvuSJ+2KANUgDm2PCN+aRC+Bpx3epRlVdjj5oHZXapxqbJMMXOwGe8FhODz/BbVIRST1mRUchdJYRKqRD4vaV/Mdq22/+i76He8u1eLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bP9QtALF; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241202093119euoutp028cbc59317ebd246b6100b81aac750846~NUkMO4pv31506215062euoutp02Y
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241202093119euoutp028cbc59317ebd246b6100b81aac750846~NUkMO4pv31506215062euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733131879;
	bh=bNLCIvm+oM39D/4v5xSquqtfCBDIka5GUXMW3ab8YE8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bP9QtALFsYvKT8G2e0oTRFB+f6QQNkuKUwQIMox3RhDDbbs4GW8TPMvjzCsZOuCRF
	 ILAqAaOk46YRrCoHuvMqCyiI4ffilK84J2rELA7gQv2VCGO/YO+9vNeuP8UV1Ws5fp
	 4tLUMpXjcc94BZKeEwBdJ/afqizssuIkhW8G0fN0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241202093119eucas1p2ff26482687ca1648e9faf9e0327d0c87~NUkMCbzCQ2770627706eucas1p2P;
	Mon,  2 Dec 2024 09:31:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 43.20.20397.76E7D476; Mon,  2
	Dec 2024 09:31:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241202093119eucas1p1b14d09e2f688812cafb71c1fba5ebaa0~NUkLuHU2W2786627866eucas1p1k;
	Mon,  2 Dec 2024 09:31:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241202093119eusmtrp1449739753e480deb07af0e5ec7592f07~NUkLthy512968429684eusmtrp1u;
	Mon,  2 Dec 2024 09:31:19 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-40-674d7e67ac12
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 8B.DB.19920.66E7D476; Mon,  2
	Dec 2024 09:31:18 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241202093118eusmtip1c9c3819652fa5a9227c7491196233cb9~NUkLOnZ0v1680416804eusmtip1g;
	Mon,  2 Dec 2024 09:31:18 +0000 (GMT)
Message-ID: <90d4515c-835f-4aaa-8c9f-263f23bdfdb2@samsung.com>
Date: Mon, 2 Dec 2024 10:31:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: th1520: Fix a NULL vs IS_ERR() bug
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <bda05d7b-5a6e-4f57-a124-ba56f51da031@stanley.mountain>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsWy7djPc7rpdb7pBh0PBC0+zGtlt7h3aQuT
	xYu9jSwW11bMZbfYekva4vKuOWwW2z63sFm07J/C4sDhsXPWXXaPTas62TzuXNvD5rF5Sb1H
	y9pjTB7v911l8/i8SS6APYrLJiU1J7MstUjfLoEr487h+ewFJzgqjtx/wN7A2M7excjJISFg
	IrH//kEgm4tDSGAFo8S/o7NZIZwvjBJTdx9mgXA+M0ps2PeOGabl24rZTBCJ5YwSz54fg3Le
	Mko0/N7PBlLFK2An8W9dAwuIzSKgInHmyxMWiLigxMmZELaogLzE/VszgJZzcAgLOEisWFIK
	EhYR0JH493cy2GZmgSeMEp23joJtZhYQl7j1ZD4TiM0mYCTxYPl8VhCbU8BF4mnfTDaIGnmJ
	7W/nQF36hUNixvEQkPkSQDWrvrpBhIUlXh3fAvW/jMTpyT0sEHa+xIOtn6BaayR29hyHsq0l
	7pz7xQYyhllAU2L9Ln2IsKPEkvczWSCm80nceCsIcQCfxKRt05khwrwSHW1CENVqElN7euGW
	nluxjWkCo9IspCCZheTFWUhemYWwdwEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA
	xHT63/GvOxhXvPqod4iRiYPxEKMEB7OSCO/y9d7pQrwpiZVVqUX58UWlOanFhxilOViUxHlV
	U+RThQTSE0tSs1NTC1KLYLJMHJxSDUx5b2akvQgr0+zUsapbu+bX2XN7AkN1BTwXSdwrUYqc
	Krvho9VVdz77O7dVKyNn/HyZ98Y48oK5XjbfofoJiS8blryZlbI/64mmdFVXzTSmLasVRA6s
	YN00dV+J/subD864+BcI9O3/aRF9dO6Bipab57PvMm123X+n4ZuM1sckSZE+hjqbCsHjX35L
	ND8pku5hizxfcnbt1V9Z13O7fB/d2r/vq/RNwa+7pmxOFV2dJmByt9xX+GVZp1wXX4/G8b3r
	mR015q6c88Y7XtVOX0pb70X2562OzYe8d696z1i6d2voKb1YpomR2mrPIlZoJCQZt6vv2OcX
	eP2R4JQfdXZX52+O9uU7HmXzfEmlUYMSS3FGoqEWc1FxIgAwr73WuwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xu7ppdb7pBt3HLS0+zGtlt7h3aQuT
	xYu9jSwW11bMZbfYekva4vKuOWwW2z63sFm07J/C4sDhsXPWXXaPTas62TzuXNvD5rF5Sb1H
	y9pjTB7v911l8/i8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/O
	JiU1J7MstUjfLkEv487h+ewFJzgqjtx/wN7A2M7excjJISFgIvFtxWwmEFtIYCmjxNTL+hBx
	GYlr3S9ZIGxhiT/Xuti6GLmAal4zSnzYMAcswStgJ/FvXQOYzSKgInHmyxOouKDEyZkQtqiA
	vMT9WzOAlnFwCAs4SKxYUgoSFhHQkfj3dzILyExmgSeMEg+bmlggFkxnlLg87ykzSBWzgLjE
	rSfzwa5jEzCSeLB8PiuIzSngIvG0byYbyFBmAXWJ9fOEIMrlJba/ncM8gVFoFpIzZiGZNAuh
	YxaSjgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY3HbsZ+bdzDOe/VR7xAjEwfjIUYJ
	DmYlEd7l673ThXhTEiurUovy44tKc1KLDzGaAoNiIrOUaHI+MBnklcQbmhmYGpqYWRqYWpoZ
	K4nzul0+nyYkkJ5YkpqdmlqQWgTTx8TBKdXANHe/7T/HiP1uLzcWnQhpXBYkoXT2SviTdie2
	aSv+OH8VSryitfLKrDkX4057vC+qTnd+tMWJt8Q38+1how+KX8/lFvZeyJaSmJ5yQczRZFL3
	47zlKyUKPbJK2cw8gvQn3ru3c/5RzXOFh/4ITjqov+LHsn/i67/phi8ymLs/3PDVl4JpKzon
	fy+cL9tjZ5Mv457z5m7wzAsJq5llFJkFY7zjpzr96mz5tfDFz79f0j3/5nxokHP9UK23Menn
	KbE92r+UhfezmTUmbJr5omzdQ50D2VJV26vXzhSbs/pL4dYrQWnWZocY1pycs3k+j6BG9smg
	kJMlhifSAjfsTFkq8kSrWuVCt/d2h2UbLN4buiqxFGckGmoxFxUnAgDocfa9TgMAAA==
X-CMS-MailID: 20241202093119eucas1p1b14d09e2f688812cafb71c1fba5ebaa0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241130100751eucas1p25283ed89679b086be2863092149236b8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241130100751eucas1p25283ed89679b086be2863092149236b8
References: <CGME20241130100751eucas1p25283ed89679b086be2863092149236b8@eucas1p2.samsung.com>
	<bda05d7b-5a6e-4f57-a124-ba56f51da031@stanley.mountain>



On 11/30/24 11:07, Dan Carpenter wrote:
> The devm_ioremap() function doesn't return error pointers, it returns
> NULL.  Update the error checking to match.
> 
> Fixes: 5d4d263e1c6b ("mailbox: Introduce support for T-head TH1520 Mailbox driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/mailbox/mailbox-th1520.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/mailbox-th1520.c b/drivers/mailbox/mailbox-th1520.c
> index 4e84640ac3b8..e16e7c85ee3c 100644
> --- a/drivers/mailbox/mailbox-th1520.c
> +++ b/drivers/mailbox/mailbox-th1520.c
> @@ -387,8 +387,10 @@ static void __iomem *th1520_map_mmio(struct platform_device *pdev,
>  
>  	mapped = devm_ioremap(&pdev->dev, res->start + offset,
>  			      resource_size(res) - offset);
> -	if (IS_ERR(mapped))
> +	if (!mapped) {
>  		dev_err(&pdev->dev, "Failed to map resource: %s\n", res_name);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	return mapped;
>  }


Looks good, thanks !
Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>


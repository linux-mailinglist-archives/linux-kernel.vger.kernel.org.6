Return-Path: <linux-kernel+bounces-356330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58651995FA6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF5621F24000
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE94170A0C;
	Wed,  9 Oct 2024 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="feTbCPI3"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684517A58F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454844; cv=none; b=rvF71dS22nraEN83vm4SdaIjwqDoczmEkp80logIv4eqXnYcd3Ddaeo/iLDySaGfyjjcvsaKottpFPmtmBgy9r0Gygu9GlEMz7L0j6u8DPeb0Hx6Gst3kynhAk95UInqa9mpHnQmm4Xiihm9pn0W8zaiohUiTQYHBu1BdmoTsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454844; c=relaxed/simple;
	bh=yFgO7jhXfB/ty1l/kjkAbqR/q7tSNDx2b7y05UDQbSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ep2EYn2wHimIm6hQ1FWUJkqXn4ONr9iivNP5Aek9yaCX9jeQMg0GqdgaF25Gj7SV+C0PtLbuxEhdEsPi0WIUZ2XT68mddRLMGfXG/fTbotEQ0/A+yWTll1SlHQ590fylQRXvbyMfrJyg8NXaeRzpKCEJXGBTrPF/TUGOK4rFtuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=feTbCPI3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20241009062039euoutp0223e3328158f7cf16e2fd22e592db895c~8tITHg_ga1607616076euoutp02k
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20241009062039euoutp0223e3328158f7cf16e2fd22e592db895c~8tITHg_ga1607616076euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728454839;
	bh=rGZxDIIt+P6nhdJeY+kYzi7xn4/VYg+OL990l1SUIqk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=feTbCPI35a45H1xcsS2I97RiiILuUrPD9hkBqSxMRyK6GFvkDwPciQ97a0sPeleMZ
	 BvL2NtkTPeW3yhkqn7ZBG1wJsXbs6b/o/LJvUwIJOSpZlbnkTyVmB6R4adq2qYVfDf
	 14etX8U3eoKlG7Iv1f8beUgW2gcLvhRvllyZ8cZc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241009062039eucas1p294c63693a33fd4e9a458f8884c47e50e~8tIS3_6-g0852408524eucas1p2z;
	Wed,  9 Oct 2024 06:20:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 58.4E.09875.7B026076; Wed,  9
	Oct 2024 07:20:39 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241009062038eucas1p12371920e5f76d3c51927feecfca320e9~8tISmyEfF3240932409eucas1p1E;
	Wed,  9 Oct 2024 06:20:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241009062038eusmtrp1166963eb9c013a98d1bc1f15667bc7d2~8tISmPT1T0267002670eusmtrp1W;
	Wed,  9 Oct 2024 06:20:38 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-0e-670620b7f8c6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.5D.19096.6B026076; Wed,  9
	Oct 2024 07:20:38 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241009062037eusmtip2ebb275811b84e5bec6cf276ebbb7c20a~8tIRhlOoJ1101611016eusmtip2c;
	Wed,  9 Oct 2024 06:20:37 +0000 (GMT)
Message-ID: <09072cb7-bedc-4957-9b1e-cb8623c5297c@samsung.com>
Date: Wed, 9 Oct 2024 08:20:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/vc4: Match drm_dev_enter and exit calls in
 vc4_hvs_lut_load
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, Maxime Ripard
	<mripard@kernel.org>, Raspberry Pi Kernel Maintenance
	<kernel-list@raspberrypi.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241008-drm-vc4-fixes-v1-1-9d0396ca9f42@raspberrypi.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTuvffu7m4xu23JDpVpo6ICNaXogpYFios+tH74Y9DHyMuSdNqu
	WhbUCsqPPlwm6FaZWmqO0JofqSXVSmdIOioyLNPELLO1llaumua8Vv57nuc85zznvLwULq0X
	zKcStKmsTqtOVJBior7V3Rl4O4DUrLKX4kxbVynGOC5fJZjn35wk4zQacOZZ0yWSKXHVEcyp
	7HIBc/HzPSFT++m8YINI2fy9mFA2mnqESos5m1QWPd6u7D1tw5QnW34Sypr2I8oRy6JYSiUO
	j2cTE9JZXfD6PeJ9ba+GyJSh2YdePPHTow5RDhJRQK+GiYr3RA4SU1L6OoLe2psYT0YRVPRc
	mCYjCJqz7gv/ttwdNAj4QgWCupGxaeJC0J3/DXldEno9uLLPEl5M0EvA9mNcyOtz4bFxYEr3
	pf2ht7twSpfRKrDkX58aNI9+iMFEpkngLeD0RvDk1uE8lkP3wBXMi0k6BHIcOaQXi+hosHa9
	nfb7w23HJdw7COgxCsbf/Mb5vSNhsLGO4LEMPtpqp+9ZCO0XzhB8QyaC4l+9GE8MCPTvuxHv
	CoPXHT8n46jJiBVQ3RTMyxth+I5R4JWB9oGXjrn8Ej6QV1+A87IEsk5JefcyMNmq/sU+sD/F
	DUhhmvEuphlnmmacY/qfW4wIM5KzaVyShuVCtezBIE6dxKVpNUF7k5MsaPJrtY/bRhtQxUdX
	kBVhFLIioHDFPElgiUAjlcSrMw6zuuTdurRElrOiBRShkEuWxvuzUlqjTmX3s2wKq/tbxSjR
	fD3GlsqORQ0Fl52MapVL7C8T1rrDF4ubCywNfp7weKrftcov1Nlwzq911zHPsrhap1tG64/O
	Pi31pPeNPHRPyIcLBqJjt6dKtyYPdrjuBUcKU1yFlbkPXjfF3t9sbsmrItetzPWtrL5Bmj9b
	A898qdJxSJERPlbed+Dgq/zCPe4tqne7TowtX1CdfTSixaeI2931Zkd0wI7+W5V3bm2LTC2L
	Myy1x2RwYQODLqMx1DT0NUYbNSewkfIN0bTJSz/ctVbZVxi0zDARBzX1jcMps8yyaxE1j/o6
	W0aNSRs26ZesCbsRwwTIrqnW9qukrbHHFxY/2dnjSO/MzR+fKDJ6nAqC26cOWYnrOPUfbjr2
	a8kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7rbFNjSDa4v1rU4cX0Rk8XbuYtZ
	LK58fc9m8X7mBGaLy7vmsFks/LiVxaKtcxmrxex3+9kttryZyOrA6bH32wIWj52z7rJ7bFrV
	yeYx72Sgx/3u40werUd/sXhsPl3t8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
	nqGxeayVkamSvp1NSmpOZllqkb5dgl7Gidsv2QpecldcOyvbwHiOs4uRk0NCwERiz7MJrF2M
	XBxCAksZJSbc3ckKkZCRODmtAcoWlvhzrYsNoug9o8TfL98YQRK8AnYSHzt7WUBsFgEViePf
	/7FDxAUlTs58AhYXFZCXuH9rBlhcWCBKYtOUFWDbRAQOM0l0v/8BtoFZwFHib/9WZogN1xkl
	fh+8yQKREJe49WQ+E4jNJmAo0fUW5AxODk4Bd4lD1x9CNZtJdG3tYoSw5SW2v53DPIFRaBaS
	Q2YhGTULScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbptmM/t+xgXPnqo94h
	RiYOxkOMEhzMSiK8ugtZ04V4UxIrq1KL8uOLSnNSiw8xmgJDYyKzlGhyPjBN5JXEG5oZmBqa
	mFkamFqaGSuJ87JdOZ8mJJCeWJKanZpakFoE08fEwSnVwBS44vKMUO3jszXfxMboHqlTmcNZ
	OWPrpj97y83d1n09fzeg0+XzHyvDPDkXhwg9M7fDCg45FnHJBx+27vtcs9pSyFiC99EFyf/T
	3eJ38gktMVRqOeL7yt2k7luR4zO7mGPfHvzJThCTP/W+Y+/Oab3u3eGtmy/fWvFw60YLG1t2
	/cmzn75VZT342kL0VXKz7Cfun2x/HkfNyg1cPW1TeppM4yexuKscL6SvaLgwfL3+gc+yrunY
	xtfnUyW/HfvqOHOJA8PytMx/r30rHDSuHBB7WPud7Wx7L1uTx5dPr6b8EmbLiGtwcO6VXjNf
	+le1UoxfCNuBX3PvH0rpDW5WN9QUtuZ9s7Pnc4OEYoGirxJLcUaioRZzUXEiAFl2VDJbAwAA
X-CMS-MailID: 20241009062038eucas1p12371920e5f76d3c51927feecfca320e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241008164452eucas1p15e51e5d3d953efd48a9900f1e6406b55
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241008164452eucas1p15e51e5d3d953efd48a9900f1e6406b55
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
	<CGME20241008164452eucas1p15e51e5d3d953efd48a9900f1e6406b55@eucas1p1.samsung.com>
	<20241008-drm-vc4-fixes-v1-1-9d0396ca9f42@raspberrypi.com>

On 08.10.2024 18:44, Dave Stevenson wrote:
> Commit 52efe364d196 ("drm/vc4: hvs: Don't write gamma luts on 2711")
> added a return path to vc4_hvs_lut_load that had called
> drm_dev_enter, but not drm_dev_exit.
>
> Ensure we call drm_dev_exit.
>
> Fixes: 52efe364d196 ("drm/vc4: hvs: Don't write gamma luts on 2711")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/dri-devel/37051126-3921-4afe-a936-5f828bff5752@samsung.com/
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/vc4/vc4_hvs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 2a366a607fcc..546ee11016b2 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -225,7 +225,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
>   		return;
>   
>   	if (hvs->vc4->gen == VC4_GEN_4)
> -		return;
> +		goto exit;
>   
>   	/* The LUT memory is laid out with each HVS channel in order,
>   	 * each of which takes 256 writes for R, 256 for G, then 256
> @@ -242,6 +242,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
>   	for (i = 0; i < crtc->gamma_size; i++)
>   		HVS_WRITE(SCALER_GAMDATA, vc4_crtc->lut_b[i]);
>   
> +exit:
>   	drm_dev_exit(idx);
>   }
>   
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



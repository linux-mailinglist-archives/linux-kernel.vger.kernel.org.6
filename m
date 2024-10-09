Return-Path: <linux-kernel+bounces-356332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9091995FA8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0531F23EF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9B8176AB5;
	Wed,  9 Oct 2024 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P3L3+nXW"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FDA17BB21
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454856; cv=none; b=uk7PYlQl9VY+7UdJWA/1A7YWQEp6/kmMeirYcJgFxZNdJz8pgWY0tWlOG4X29j57CIeILUPPRcxu8V+2gpbVMph3V51YzHmdtXFMLk+99llBL2byvu6URjeKNvlnbqE7654JuBuLJaue2x26+yxxx3DgLfIFvMQ9rtviypshO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454856; c=relaxed/simple;
	bh=SHrG0flilfyJjax2sK6VkmGOnKLEdwb361ywQYl4KSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=psBX3KzTlMLw183DIP7Cjf2TCT6kwpHfKF91aD6Df7gOKURr9cNqQe3OA4+hnI8PCaIBZ4dBur4obxzqlEBaZrmnp9obCBwrJe4bVeh13JXXTFi5AevGnNvG0KGl+QyrSh0ew/X2B+FJ8siS0YjWOZH+4jjU6xlcFARpHDjcpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=P3L3+nXW; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241009062052euoutp01b6e7495f62b25b55653a5baf87f8af51~8tIfsX4aW0787307873euoutp01u
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241009062052euoutp01b6e7495f62b25b55653a5baf87f8af51~8tIfsX4aW0787307873euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728454852;
	bh=Yziyztyl3bk7q8TWorQwwpsD5PZXgJn1w33HBPiUrl0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=P3L3+nXW+iC5IO6N+Ww4lWQL6f0GetyGonaZUbTaanVs6btLuLCh1eQB6oNOI9sT8
	 xjwSNtZxq4untuc9+3qXq11kTmpzDXozhNrp+np/RfZHPdd3pkFYvEtQoImsSZG3n8
	 gJBzMIjQt8h+9qTDjRM3O3i39TDOpYTYxkQfsuzg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241009062051eucas1p25ba5a62aa1398299cc46b2cb631a078b~8tIexj_nM1264312643eucas1p26;
	Wed,  9 Oct 2024 06:20:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0F.42.09620.3C026076; Wed,  9
	Oct 2024 07:20:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241009062051eucas1p14a71ea515c9bce04c1be10020a7a60b2~8tIeckukW0660406604eucas1p1o;
	Wed,  9 Oct 2024 06:20:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241009062051eusmtrp1cfa3b97fbab35e18826fd3aeb4836743~8tIecErIR0225102251eusmtrp1b;
	Wed,  9 Oct 2024 06:20:51 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-27-670620c3fe60
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 83.6D.19096.3C026076; Wed,  9
	Oct 2024 07:20:51 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241009062050eusmtip2868641c031890ffceb7423f242f7c83e~8tIdVZKL41645216452eusmtip2P;
	Wed,  9 Oct 2024 06:20:49 +0000 (GMT)
Message-ID: <52e469a0-2dcb-4f6f-b4af-89568ef41864@samsung.com>
Date: Wed, 9 Oct 2024 08:20:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/vc4: Correct generation check in
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
In-Reply-To: <20241008-drm-vc4-fixes-v1-3-9d0396ca9f42@raspberrypi.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsWy7djP87qHFdjSDV4cNLY4cX0Rk8XbuYtZ
	LK58fc9m8X7mBGaLy7vmsFks/LiVxaKtcxmrxex3+9kttryZyOrA6bH32wIWj52z7rJ7bFrV
	yeYx72Sgx/3u40werUd/sXhsPl3t8XmTXABHFJdNSmpOZllqkb5dAlfGlImfWAqucVY0dqc1
	MP5j72Lk5JAQMJF4tHgBaxcjF4eQwApGiU2r5zFBOF8YJb40zmaBcD4zSuzed5EJpuXJg0uM
	EInljBIT/09ihnA+MkocXnOQEaSKV8BO4u2CjWBLWARUJLZPP8sEEReUODnzCQuILSogL3H/
	1gywGmGBAInnjxeygwwSETjMJPG/fRYrSIJZwFHib/9WZghbXOLWk/lgg9gEDCW63naxgdic
	Au4S869CnMcMNHT72zlgF0kI/OeQmDitiRXibheJeXtWMELYwhKvjm+BBoGMxOnJPSwQDe2M
	Egt+32eCcCYwSjQ8vwXVYS1x59wvoHUcQCs0Jdbv0ocIO0ps/HyGFSQsIcAnceOtIMQRfBKT
	tk1nhgjzSnS0CUFUq0nMOr4Obu3BC5eYJzAqzUIKl1lI3pyF5J1ZCHsXMLKsYhRPLS3OTU8t
	Ns5LLdcrTswtLs1L10vOz93ECExap/8d/7qDccWrj3qHGJk4GA8xSnAwK4nw6i5kTRfiTUms
	rEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQWgSTZeLglGpgUmTg4J2/7c1G39At
	1zyzhFz0PDZlfn4+LXD9rnMMy4Wcf+1sbzX7594rWbRgGtcN49VuCWkP92WKLHzAIH5FKGuF
	q42BvwaP0t7Ke6onTY6wi/7maKuzuDFN8e/2E9Nebsu9G6+2suDPoslT2hm4qmJ3lBcs42v4
	lfJjabnicU4z/UapTWHfNOWncLDdn1Wsf0urbtKT3IC0uhP2p+XntpU9+zpLfU/fTrUdOuv/
	vgz+oLZ3lpV8pPLDyUoztix+n92ycg2vd5riuc7Xq94VtJ7nUE6aoLlz3QYLCzV+5wm9Wrmn
	vpQJC5rGLmZ6dVVP6c2zc64LKq+7se5yPT9vyqObx/cIRAvWHuuJM9iVq8RSnJFoqMVcVJwI
	AETQ87vJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsVy+t/xe7qHFdjSDfZckLQ4cX0Rk8XbuYtZ
	LK58fc9m8X7mBGaLy7vmsFks/LiVxaKtcxmrxex3+9kttryZyOrA6bH32wIWj52z7rJ7bFrV
	yeYx72Sgx/3u40werUd/sXhsPl3t8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
	nqGxeayVkamSvp1NSmpOZllqkb5dgl7GlImfWAqucVY0dqc1MP5j72Lk5JAQMJF48uASYxcj
	F4eQwFJGic/fulkhEjISJ6c1QNnCEn+udbFBFL1nlLj67BBYglfATuLtgo1gk1gEVCS2Tz/L
	BBEXlDg58wkLiC0qIC9x/9YMsBphAT+J7RNfsYAMEhE4zCTR/f4H2CBmAUeJv/1bmSE2XGeU
	OLJpJRNEQlzi1pP5YDabgKFE11uQMzg5OAXcJeZfvQhVYybRtbWLEcKWl9j+dg7zBEahWUgO
	mYVk1CwkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGKXbjv3csoNx5auPeocY
	mTgYDzFKcDArifDqLmRNF+JNSaysSi3Kjy8qzUktPsRoCgyNicxSosn5wDSRVxJvaGZgamhi
	ZmlgamlmrCTOy3blfJqQQHpiSWp2ampBahFMHxMHp1QD007R98dKNBq4F5tvv1awpuXJST+N
	G66z5i+ZdDWB5fmuFsvqzH0csv7vwgzK11qtzNCRYOH/tnZut+HZvgJD+YL3/ddSOP3O9Qu5
	ygl9uTHv8kn3hV9UFO9l3V98vOs8t/L2d1rSptN0f3IJSz3o/OF14e+Nbd6Xt/w96+rrfTH7
	f+upt/pSwYqNjC5/7iyKnzl3eajjt5Tnsfv2uXtECy/kydNYenPi+v9lihxnt287981Yx+GT
	TsdylYOmTjs0bnOvuyT6Z8vXTfr3guUFfJ8nzVnI9nLVX97ttY9nPtzhc/jsBsmCMx5fHwbP
	DUsOy9pxq+F1dtKPQ39OfPJ4o7pkzXeOiLkN4rx36t/N/tGgxFKckWioxVxUnAgA6X/DhVsD
	AAA=
X-CMS-MailID: 20241009062051eucas1p14a71ea515c9bce04c1be10020a7a60b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241008164454eucas1p228b8e16fd136e3922b2f25fee8ce4b99
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241008164454eucas1p228b8e16fd136e3922b2f25fee8ce4b99
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
	<CGME20241008164454eucas1p228b8e16fd136e3922b2f25fee8ce4b99@eucas1p2.samsung.com>
	<20241008-drm-vc4-fixes-v1-3-9d0396ca9f42@raspberrypi.com>

On 08.10.2024 18:44, Dave Stevenson wrote:
> Commit 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
> incorrectly swapped a check of hvs->vc4->is_vc5 to
> hvs->vc4->gen == VC4_GEN_4 in vc4_hvs_lut_load, hence breaking
> loading the gamma look up table on Pi0-3.
>
> Correct that conditional.
>
> Fixes: 24c5ed3ddf27 ("drm/vc4: Introduce generation number enum")
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/vc4/vc4_hvs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index c5ebc317188a..1edf6e3fa7e6 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -224,7 +224,7 @@ static void vc4_hvs_lut_load(struct vc4_hvs *hvs,
>   	if (!drm_dev_enter(drm, &idx))
>   		return;
>   
> -	if (hvs->vc4->gen == VC4_GEN_4)
> +	if (hvs->vc4->gen != VC4_GEN_4)
>   		goto exit;
>   
>   	/* The LUT memory is laid out with each HVS channel in order,
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland



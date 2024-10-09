Return-Path: <linux-kernel+bounces-356331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB872995FA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D7F282CBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000441714D0;
	Wed,  9 Oct 2024 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h8/PP25r"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A74154430
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454851; cv=none; b=bU8d1ziVcK81TQYrERaDPydLo5Jlp7RJukOnpzki6K2sF3/DnY1lxIKsNZaaUGXojhfbcRr4huac/NIryqz1iOGCjbgMTdqfJODh7q9dl3HTKgDQqdsKd32S7DTo6o98og9mQ65hzyTMtqnXCdHUGmGdcxGdgs+9hkQWnqZ0NTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454851; c=relaxed/simple;
	bh=whtMIx5iAGqk8jIno5SD9q1QIkqpbDH1yEYmLVX+wVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=U0dDwrabsbz82lVleqpMwOED9/H9VQiEYx0ekj5SbhUdEw5TwMSRXqoVFvo5l+OkhqSwkOMyhwZSvw8WFyPGTIvhxLgNYJGCzY589OLl0VcFbb1/EAtau/kUdfr3eppqndORlM7TuSItupLIoPZcfLc61/2q8Klp54+0ARE8eS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h8/PP25r; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241009062046euoutp01bf4c024ae3dd44d54032c72150aded5b~8tIZhxGsH0684406844euoutp01w
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:20:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241009062046euoutp01bf4c024ae3dd44d54032c72150aded5b~8tIZhxGsH0684406844euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728454846;
	bh=wvz5mKvstXMNmZj0WOW5JVSzsyXVJpxHmaqeU89lAYs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=h8/PP25rkEn9/IQ5iHCH8wujyvnWc8dZHEBIVIBRjHKA5nG2SGpvFpNDq7iCqJo4j
	 RyC0K3zsjToFH1nX9VkXikvELIOoEbdS3oXPllJwYQGfVLIbTrid6eqO/+jO/fz0Gw
	 627CQjIaMMNnYACeaYDOR+c41HXY/Y30ChxkGXq4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241009062046eucas1p2c4a3e5b18f511977d21b93a7bed486f5~8tIZUH9bf1265312653eucas1p25;
	Wed,  9 Oct 2024 06:20:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 2B.4E.09875.DB026076; Wed,  9
	Oct 2024 07:20:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241009062045eucas1p25c68504b8660b2918b529fc45f26ab84~8tIZDM60r1263612636eucas1p2y;
	Wed,  9 Oct 2024 06:20:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241009062045eusmtrp1a95b11a9e5195c9344bc487366b5919d~8tIZCp7rF0267002670eusmtrp1b;
	Wed,  9 Oct 2024 06:20:45 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-1f-670620bd6ad3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 90.6D.19096.DB026076; Wed,  9
	Oct 2024 07:20:45 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241009062042eusmtip20869c2a0be20e9b368a8114f4563d97d~8tIWWDtaP1101611016eusmtip2e;
	Wed,  9 Oct 2024 06:20:42 +0000 (GMT)
Message-ID: <3ab32439-1abb-40cd-8afc-7e790d931805@samsung.com>
Date: Wed, 9 Oct 2024 08:20:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/vc4: Match drm_dev_enter and exit calls in
 vc4_hvs_atomic_flush
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, Maxime Ripard
	<mripard@kernel.org>, Raspberry Pi Kernel Maintenance
	<kernel-list@raspberrypi.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
	<tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241008-drm-vc4-fixes-v1-2-9d0396ca9f42@raspberrypi.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7p7FdjSDdr7LS1OXF/EZPF27mIW
	iytf37NZvJ85gdni8q45bBYLP25lsWjrXMZqMfvdfnaLLW8msjpweuz9toDFY+esu+wem1Z1
	snnMOxnocb/7OJNH69FfLB6bT1d7fN4kF8ARxWWTkpqTWZZapG+XwJWxb9p/poIfnBWfZmk0
	MHZzdDFyckgImEgsObGcqYuRi0NIYAWjxKkZ+9kgnC+MEncvTGOGcD4zSvxatJyli5EDrOX6
	FQGI+HJGiX8XtzCDjBIS+MgoceecP4jNK2AnMfXzO3YQm0VARWLR/TY2iLigxMmZT1hAbFEB
	eYn7t2awg8wUFoiT2HzBGWSmiMBhJon/7bNYQWqYBRwl/vZvZYawxSVuPZnPBGKzCRhKdL3t
	ApvJKeAusfzNHiaIGnmJ7W/ngB0tIdDMKbF6928WiD9dJK4+P8wMYQtLvDq+hR3ClpE4PbmH
	BaKhnVFiwe/7TBDOBEaJhue3GCGqrIE++8UGciqzgKbE+l36EGFHiUfdPcyQUOGTuPFWEOII
	PolJ26ZDhXklOtqEIKrVJGYdXwe39uCFS8wTGJVmIQXLLCRvzkLyziyEvQsYWVYxiqeWFuem
	pxYb5aWW6xUn5haX5qXrJefnbmIEpqvT/45/2cG4/NVHvUOMTByMhxglOJiVRHh1F7KmC/Gm
	JFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTB5BE+rXv0sxeTX
	o6e+WUfO8BSGiZg4fOEN/rqPxYfX58WF1HcfPAomrtDI5RHxzrR55s21XrdjaxI3322BbI/A
	2L0L2g8J3f7EoGUt5p13YprDbLO/i15VZLHtLVgfLdWpqPNA6feHP/l/0rdpcmn5fl786V6U
	xtGQwtUhzNrlvflLlRZfOqXSar927XTGn0tMrJ177p7Ub/59gWlt5Pa9N87bO52I5OpSmRHQ
	t3PWxC1SWWs/ZzxPe76qpat+6u2Ft/2N1E93PW5UTjuw4UnHzS2WX0pelchIWxX8/yn/ZsY/
	nu0eGwLWzJP8uzX8lPdHpq/KJmelZ+yu4a7b6WSzRnZe18S6YoYp+5K2r3qgxFKckWioxVxU
	nAgA8YLBb8YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7p7FdjSDZ5+1LA4cX0Rk8XbuYtZ
	LK58fc9m8X7mBGaLy7vmsFks/LiVxaKtcxmrxex3+9kttryZyOrA6bH32wIWj52z7rJ7bFrV
	yeYx72Sgx/3u40werUd/sXhsPl3t8XmTXABHlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
	nqGxeayVkamSvp1NSmpOZllqkb5dgl7Gvmn/mQp+cFZ8mqXRwNjN0cXIwSEhYCJx/YpAFyMX
	h5DAUkaJS9MusHQxcgLFZSROTmtghbCFJf5c62KDKHrPKLFl/R82kASvgJ3E1M/v2EFsFgEV
	iUX326DighInZz4BGyQqIC9x/9YMdpBlwgJxEpsvOIPMERE4zCTR/f4H2AJmAUeJv/1bmUFs
	IYHrjBLTenkg4uISt57MZwKx2QQMJbredoHN5xRwl1j+Zg8TRI2ZRNfWLkYIW15i+9s5zBMY
	hWYhOWMWklGzkLTMQtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmB8bjv2c8sOxpWv
	PuodYmTiYDzEKMHBrCTCq7uQNV2INyWxsiq1KD++qDQntfgQoykwLCYyS4km5wMTRF5JvKGZ
	gamhiZmlgamlmbGSOC/blfNpQgLpiSWp2ampBalFMH1MHJxSDUyNx+Pmm33Pm8O0ZJZG8uS9
	zilLQ8/sv/jnfMExdsvlT5QClC5vfs90OcLwaszKlI1mb+2f+B/tdZ66tEPTJ/qfkHuyvMIN
	F1Wby0lVogGL9144lP7EX2mm3JpTUmn3vweoeoYFF0/omv+FrYv11jzhZT5Zppd97KT6Y/rF
	r6x88l7vcV+M3ATzkKrpDTb6LII5LP2Ho+9fl+bdtlzvZYzvx5xIjW9PnrrO91rYWTLl1GX+
	PssTb3Nyr61rK/iQW7DafCc/c6XNJR3WNbaO8Wws+/32TbBsWhFUO1lwaZ5JyLfMYrlJt9Zb
	//3ZM/WaZI3b5hvfNh/M5/R+PrWocdaRR0GhL/YoPFizaMIRFX0lluKMREMt5qLiRACw1Upv
	WAMAAA==
X-CMS-MailID: 20241009062045eucas1p25c68504b8660b2918b529fc45f26ab84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241008164452eucas1p1c2fbff8dea8d06460d8a26b177e4286f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241008164452eucas1p1c2fbff8dea8d06460d8a26b177e4286f
References: <20241008-drm-vc4-fixes-v1-0-9d0396ca9f42@raspberrypi.com>
	<CGME20241008164452eucas1p1c2fbff8dea8d06460d8a26b177e4286f@eucas1p1.samsung.com>
	<20241008-drm-vc4-fixes-v1-2-9d0396ca9f42@raspberrypi.com>

On 08.10.2024 18:44, Dave Stevenson wrote:
> Commit 92c17d16476c ("drm/vc4: hvs: Ignore atomic_flush if we're disabled")
> added a path which returned early without having called drm_dev_exit.
>
> Ensure all paths call drm_dev_exit.
>
> Fixes: 92c17d16476c ("drm/vc4: hvs: Ignore atomic_flush if we're disabled")
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/vc4/vc4_hvs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 546ee11016b2..c5ebc317188a 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -603,7 +603,7 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
>   	}
>   
>   	if (vc4_state->assigned_channel == VC4_HVS_CHANNEL_DISABLED)
> -		return;
> +		goto exit;
>   
>   	if (debug_dump_regs) {
>   		DRM_INFO("CRTC %d HVS before:\n", drm_crtc_index(crtc));
> @@ -686,6 +686,7 @@ void vc4_hvs_atomic_flush(struct drm_crtc *crtc,
>   		vc4_hvs_dump_state(hvs);
>   	}
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



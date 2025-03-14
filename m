Return-Path: <linux-kernel+bounces-561803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA5A6166D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975AF3AA7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8E2036ED;
	Fri, 14 Mar 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hDbiAUy1"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071C156C79
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970367; cv=none; b=Mn6NTKL3h5Om1LMdhS0DO+SKtC2MMsLji1/zgoChq+Pg3tg+9bM099GGRR1uphY/lXxWGEaJjq1QQ2XbE3xUyHpJXIk2BB3faJxb5CFWXDdKY/GgubSfci3T0iw6YpN9v9iBOXUUtAz/smLGFHFwr5j1mx3ExlICamlsb4GUbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970367; c=relaxed/simple;
	bh=b2CDGTHEdr5TqAfo7dRyPvR+VI//VpkqVSraMSMASI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YYANci7G8E+qe2WYFr/q1OYUusQw6NyJeWX23Llk4pnj1yq26ua5TbZsFmhlpYew6dqVd9gHOOv8Y8HTouuL7UbvHc0o5ZU7afk4jjzxK9zKzCZdl9L+Vq2cxBygMDKruhBPxr3xDflfVWYd34H1067tgFmwt/ele/s/ypyj4mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hDbiAUy1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250314163922euoutp01c4db5bdfa79a43e7ec9bf60ddbcfbfe4~suNCpajsB1096110961euoutp01M
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:39:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250314163922euoutp01c4db5bdfa79a43e7ec9bf60ddbcfbfe4~suNCpajsB1096110961euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741970362;
	bh=dzOCOe3jSYGQUYrbxXDJcmvsZO+JY8Q+Bt4sctrFBbQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hDbiAUy15byHcEO5qZWfpygu715rJ2NeEFcoXkAc/Z8tukH3ZZS2ltQfmOA+88dbQ
	 +OJgzuBOrPABYUF6DKJNu60QyNPa+a9cDgNxZaGyxF9unnjPrmahbgQF14LkeURKp4
	 eS3ywUy0Wxm1ZfB4S6mXDhv1Y01GRq4XhsinG8ew=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250314163921eucas1p1316e47fdbbbdec736e4d586d6cc6d740~suNCWW1BS2043720437eucas1p1Q;
	Fri, 14 Mar 2025 16:39:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 0B.6E.20409.9BB54D76; Fri, 14
	Mar 2025 16:39:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250314163920eucas1p262769c736d910231bd8ec798578b99be~suNBabrkU1864618646eucas1p2h;
	Fri, 14 Mar 2025 16:39:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250314163920eusmtrp23292ba24cbbd8ba914e4b41076e8c141~suNBYj6tf1144611446eusmtrp2m;
	Fri, 14 Mar 2025 16:39:20 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-29-67d45bb90057
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 29.AB.19654.8BB54D76; Fri, 14
	Mar 2025 16:39:20 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250314163920eusmtip29bead9a32087e6d3e1013b8809a8762f~suNA0eaom0371903719eusmtip2b;
	Fri, 14 Mar 2025 16:39:20 +0000 (GMT)
Message-ID: <d9f3b44e-a1f7-4441-a731-ea99990de871@samsung.com>
Date: Fri, 14 Mar 2025 17:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: thead: add CONFIG_MAILBOX dependency
To: Arnd Bergmann <arnd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Drew Fustini <drew@pdp7.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Guillaume La Roque
	<glaroque@baylibre.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Prasad Pandit <pjp@fedoraproject.org>, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20250314154816.4045334-1-arnd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7o7o6+kG7TNN7D4O+kYu8W2LZtY
	Le5d2sJksXDyXDaLva+3sltc3jWHzeLzr4usFp9uxVkcXxvuwOnx+9ckRo/3N1rZPabca2Hz
	2LSqk83jzrU9bB4ta48xeXzeJBfAHsVlk5Kak1mWWqRvl8CVsbtVvmA/d8W2nUkNjPc4uxg5
	OCQETCS+3g/pYuTiEBJYwSjx8N0VNgjnC6PEkn/b2LsYOYGcz4wSZ+4KgtggDd+eHGeGKFrO
	KPF/zToo5y2jRPed5ywgVbwCdhJNM34zgdgsAqoS907eYoSIC0qcnPkErEZUQF7i/q0ZYBuE
	BZwlmu+tZgWxRQQyJRYfb2EEGcos8INRYvv+HWANzALiEreezAcbyiZgJPFg+XywBk4Bc4kd
	e7ezQtTIS2x/OwfsIgmBHxwS827MZYW420Vix5d1bBC2sMSr41vYIWwZif87IYZKCORLPNj6
	iRnCrpHY2XMcyraWuHPuFxsowJgFNCXW79KHCDtKvP05kx0SjnwSN94KQpzAJzFp23RmiDCv
	REebEES1msTUnl64pedWbGOawKg0CylUZiF5chaSZ2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84
	Mbe4NC9dLzk/dxMjMEGd/nf8yw7G5a8+6h1iZOJgPMQowcGsJMK7R+VKuhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXHeRftb04UE0hNLUrNTUwtSi2CyTBycUg1MnRwKcYFirSt6lGqC4lqtr326
	+XTamSWMDLzPyn4HhBXnrPfsrTN/77M07kLsVqvQj6uqJbY8kPtles899H2lYamaqHvGrbV/
	lK/t/S05QyR1get3UZVjm7g4TvZ8ajhuKJy8+5ZlByfnU8VXflMWnL0hu+DRsr74Wz++NHE8
	4BdI//AypvdO/sd5k07xnlDMy9klJPv1vo47z5HKKW+05P/svDFxfvC+Tt5lj9flq+TWPTjS
	nqd4+93kR20N0ScWXFUPPfDkBqN+oTWrc2xbU2/z2U1MO39nVc5s+LvouNiOCQUGIZK16fcu
	rloZFXi2OyOk3KUkR0Pj0NovOrM3ndZx7k59p75kz4VmAS5RJZbijERDLeai4kQAjdLjsL8D
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7o7oq+kGyzdrmfxd9IxdottWzax
	Wty7tIXJYuHkuWwWe19vZbe4vGsOm8XnXxdZLT7dirM4vjbcgdPj969JjB7vb7Sye0y518Lm
	sWlVJ5vHnWt72Dxa1h5j8vi8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzW
	yshUSd/OJiU1J7MstUjfLkEvY3erfMF+7optO5MaGO9xdjFyckgImEh8e3KcuYuRi0NIYCmj
	xLb1bUwQCRmJa90vWSBsYYk/17rYIIpeM0p86P/OBpLgFbCTaJrxG6yBRUBV4t7JW4wQcUGJ
	kzOfgDWLCshL3L81gx3EFhZwlmi+t5oVxBYRyJSYcv4NC8hQZoEfjBKX57RBbehilJjRfZUZ
	pIpZQFzi1pP5YBvYBIwkHiyfD9bNKWAusWPvdiCbA6hGXWL9PCGIcnmJ7W/nME9gFJqF5I5Z
	SCbNQuiYhaRjASPLKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCo3Hbs55YdjCtffdQ7xMjE
	wXiIUYKDWUmEd4/KlXQh3pTEyqrUovz4otKc1OJDjKbAsJjILCWanA9MC3kl8YZmBqaGJmaW
	BqaWZsZK4rxsV86nCQmkJ5akZqemFqQWwfQxcXBKNTB5tHM5a/SXm8qkmcfG71JYqN0icWj2
	wgm+s2adMrl2osQgufXq+mW9/EfKzyy4pX3PYe/kxbmFFszfN4cb15rZ6lTpfr17oVRzvnex
	wtxcxuDlP1enl5W+Xft5v5f7Hs5FNWFzVr7cGuDHsDD/8ZO8qScnFM7/dcjIjnvL/NtCB1zP
	MH5Y6NLocm317uJ1Jtv6n7z922Kqdnv+crOQS05pUU+T954UKCkXW2d4ppZbYqnuneD+TfMb
	Xycda4tdF3uZNaF9ao7mrakC+9srrd3Nv04w79tm794yZ8GK/rUfmdK5o1hr5h6Pn3F2/81m
	nboP+UkJv2MOLl9WU1n2qdDjRl9HUY6l2M6GXxJX45crsRRnJBpqMRcVJwIALnpjBVMDAAA=
X-CMS-MailID: 20250314163920eucas1p262769c736d910231bd8ec798578b99be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250314154826eucas1p20139736cab789432ed0884b020eec244
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250314154826eucas1p20139736cab789432ed0884b020eec244
References: <CGME20250314154826eucas1p20139736cab789432ed0884b020eec244@eucas1p2.samsung.com>
	<20250314154816.4045334-1-arnd@kernel.org>



On 3/14/25 16:48, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without this, the driver fails to build:
> 
> ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_call_rpc':
> thead,th1520-aon.c:(.text+0x28): undefined reference to `mbox_send_message'
> ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_deinit':
> thead,th1520-aon.c:(.text+0x17e): undefined reference to `mbox_free_channel'
> ld: drivers/firmware/thead,th1520-aon.o: in function `th1520_aon_init':
> thead,th1520-aon.c:(.text+0x1d9): undefined reference to `mbox_request_channel_byname'
> 
> Fixes: e4b3cbd840e5 ("firmware: thead: Add AON firmware protocol driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/firmware/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 42e3dd1c387a..6ab9f7ca7ff1 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -239,6 +239,7 @@ config SYSFB_SIMPLEFB
>  config TH1520_AON_PROTOCOL
>  	tristate "Always-On firmware protocol"
>  	depends on ARCH_THEAD || COMPILE_TEST
> +	depends on MAILBOX
>  	help
>  	  Power, clock, and resource management capabilities on the TH1520 SoC are
>  	  managed by the E902 core. Firmware running on this core communicates with

Thanks, looks good shouldn't have missed that.

Reviewed-by: Michal Wilczynski <m.wilczynski@samsung.com>



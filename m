Return-Path: <linux-kernel+bounces-333046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9A197C2B5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EA1281B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17FF1BC44;
	Thu, 19 Sep 2024 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gFx5UiyB"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034F182AE
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726710493; cv=none; b=kBNckCl9FZZyAwZ7pKAwLFRO09KACSiVHIho3M7Qs4dvfpS2uramfAQjI9Fytfly9GvpkUhKBf78NbzG3OzwcMGmPXkdDqJaF1/v3twAA98PGTBvWVPc0mWTyb60AeOQ2uwYbIvrTU/mr053C5FiTRxBrxUZG55ELBj9NKlf6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726710493; c=relaxed/simple;
	bh=pqkE2vT7+u+CoySrWrolwRxzKhdX9j2GAqXbHAcxrMc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=I38wAbRRlItljUkFS5tsBoC0sgeN9dKF9PrAwt/Dgghs/PLBbUDSuuopeQ/pFQUPtRHsiCLh8rYKDOWblUA5wYkTj9VP8JRAlScVi2LPxyD78L5B3qWKnNO73a4Y3+ArScNhQAPIv598Stjc95U/fg7ojnrAQnv1rChltytOckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=gFx5UiyB; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240919014803epoutp02c87304f8c82a50d0d072eed6fed65001~2ggkvrHHN3088830888epoutp02I
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:48:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240919014803epoutp02c87304f8c82a50d0d072eed6fed65001~2ggkvrHHN3088830888epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726710483;
	bh=rb1rBTehHHnRSOKalZMxxKpc26ophhoIP8ZNoi+El1o=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=gFx5UiyBJF9V8s2FkTQtjhyxeU3L795Y+bCUZcKX3IOeyNjjX2mIyvwnGxW03QhhQ
	 tEc9J69/AFwr36MAD4GcszcNot092aEhfM5QsHJvc9pEHDuYZMWSDsMFAvvhXAP6tj
	 0zPTKIbgZtBJ38ICln2EnGLXyWTwT/daFXmSgCFQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240919014802epcas1p1598ddbd43bc9db7ccbc165b0d72830ee~2ggkWKzvM2895628956epcas1p1m;
	Thu, 19 Sep 2024 01:48:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4X8JLp4c5Zz4x9Q3; Thu, 19 Sep
	2024 01:48:02 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240919013807epcas1p11de9b8fecb848696ea60a1d6eb9d4985~2gX5ntxZg0153201532epcas1p1k;
	Thu, 19 Sep 2024 01:38:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240919013807epsmtrp2f64ed7115b4366c1515610f8c786f634~2gX5nD1q90075300753epsmtrp23;
	Thu, 19 Sep 2024 01:38:07 +0000 (GMT)
X-AuditID: b6c32a28-e95f970000001d8f-86-66eb807e2924
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F4.DA.07567.E708BE66; Thu, 19 Sep 2024 10:38:06 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240919013806epsmtip2406e2b1febe086a1fdb6dad138a31b0f~2gX5en-0p1193411934epsmtip2X;
	Thu, 19 Sep 2024 01:38:06 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <Jacky.Cao@sony.com>,
	<Wataru.Aoyama@sony.com>, <Daniel.Palmer@sony.com>, <cpgs@samsung.com>
In-Reply-To: <PUZPR04MB6316617B76FF4DE05E2DD10281662@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1] MAINTAINERS: exfat: add myself as reviewer
Date: Thu, 19 Sep 2024 10:38:06 +0900
Message-ID: <1891546521.01726710482634.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHbKEb6nuZDhaSR8B++xvE4JpgwEwHmlr4Osk7ff/A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvG5dw+s0gyXzbCxeHtK0WNOzjN3i
	1KJZTBYTpy1ltri8aw6bxccHuxktrr95yOrA7rFpVSebR9+WVYwe7RN2Mnt83iQXwBLFZZOS
	mpNZllqkb5fAlbHx/ULWgjVsFa37V7A3ME5m7WLk5JAQMJHY/ekSUxcjF4eQwG5GiR1vTjN2
	MXIAJaQkDu7ThDCFJQ4fLoYoec4ocWV2DwtIL5uArsSTGz+ZQWwRAVOJL5dPsIEUMQt0MEpc
	XvKSDaJjHaPEktnLwTo4BWIlXh67xgRiCws4SZx4s4UVZAOLgKrEoZ3ZICavgJXEmWW8IBW8
	AoISJ2c+YQEJMwvoSbRtZAQJMwvIS2x/O4cZ4nwFoPOPgg0RAepc/zgQokREYnZnG/MERuFZ
	SAbNQhg0C8mgWUg6FjCyrGKUTC0ozk3PTTYsMMxLLdcrTswtLs1L10vOz93ECI4cLY0djPfm
	/9M7xMjEwXiIUYKDWUmEV/zDyzQh3pTEyqrUovz4otKc1OJDjNIcLErivIYzZqcICaQnlqRm
	p6YWpBbBZJk4OKUamAxOGCS+M1a8x53jssxjbvQf/t/nP/aKLivk+mXHMmXP2r2qT5e80iq4
	vV9PwNvLZcqeLa9T3SXjMrRMWq506d1J13B6uGm7jqfG8bT0c1walWHi3w6Xf2T7onk3WP95
	xlS9v9We0e9DlFy9RMsu/3j64eD1i/9eZG/aVVv1c/6ikNqLU9X959v8X6+x3HreI//7cz+r
	qU/UcOH9UFzC9Ln28227aZkzPwrK67h/k3H8/ED0cpuI9VfeA6wvVA3rcjrVHtecXiC/2Nfb
	5pfCz8DOn4Gfq1JEw7gtJ3wp7nGcsoXdo9eH68k7uQvX1gTUfzCP7YzgeuDUnrYnZMvZG2vS
	LQSc3H7VBaxhuP7ppRJLcUaioRZzUXEiAPqjE7ILAwAA
X-CMS-MailID: 20240919013807epcas1p11de9b8fecb848696ea60a1d6eb9d4985
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20240914030000epcas1p3ea5fbfcf2a139d61193ff4eea5bf6042
References: <CGME20240914030000epcas1p3ea5fbfcf2a139d61193ff4eea5bf6042@epcas1p3.samsung.com>
	<PUZPR04MB6316617B76FF4DE05E2DD10281662@PUZPR04MB6316.apcprd04.prod.outlook.com>

> I have been contributing to exfat for sometime and I would like to help
> with code reviews as well.

Thank you for your active involvement in improving exFAT.
Acked-by: Sungjong Seo <sj1557.seo@samsung.com>

> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 82f19f0f0752..031fd91a4e57 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8378,6 +8378,7 @@ N:	binfmt
>  EXFAT FILE SYSTEM
>  M:	Namjae Jeon <linkinjeon@kernel.org>
>  M:	Sungjong Seo <sj1557.seo@samsung.com>
> +R:	Yuezhang Mo <yuezhang.mo@sony.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
> --
> 2.34.1





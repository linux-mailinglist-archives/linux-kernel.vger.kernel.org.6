Return-Path: <linux-kernel+bounces-305358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F155962D76
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AF7B237A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB11A2C22;
	Wed, 28 Aug 2024 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rm9vIo+M"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E2189BAA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861723; cv=none; b=lHBAByS+SdPAasg3cFRaSTvhS/0sGM9i73cvpgHRiTS+2M7dQwkHIsQArR9b7XU7MFzaxEsrsbPRMEK0jzQenJqaV1buNRl1MDJrFnDGmQJvh1UvNrqS4TVDtX/oEd3z2kVE9P4yELftTEegpzIeu80iI2gH0jKntWRa2ej0SKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861723; c=relaxed/simple;
	bh=vS0JM2WxR5KtYE5L1XEoTZ9ENuthPVf/54bNlaPf0wk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=FO77dM/qlmPjFrrRVbn52y2c8LxAsEgFGPgoWq6JXpTf+xZrGj8zJya12hqljHkjUFSwZVkDDUFlRg0OKd+I1VhHOfIF88wnCX1tQNXMQ/RFecWEldnGK0j09rGVgXkoaetXzsbP1rc4fVh9/g059JkJOWOtsuJuUjtLNTNNsiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rm9vIo+M; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240828161519epoutp0339b60cfe48b7af607fb7c4ff9b0beb19~v8JhNjbC13090630906epoutp03h
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:15:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240828161519epoutp0339b60cfe48b7af607fb7c4ff9b0beb19~v8JhNjbC13090630906epoutp03h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724861719;
	bh=vS0JM2WxR5KtYE5L1XEoTZ9ENuthPVf/54bNlaPf0wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rm9vIo+M+XhyXTIIbuO9bTytk8QIxlj6zj8+PgbgylPkrUUzytpZqnzO/Hxokkywd
	 rQtD/7hQ6Mf6ktCgH1iOn7bHthyOp6U6LeYl8EtnfzSQ+lC1kiHBH7cb6DsY3z/LDZ
	 zjM6CAm2G1YkZsy/dFwKQELVRZFm+zrD2A3mYJ/o=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240828161518epcas5p15045320301b2fa95f4190ee68a8958cf~v8Jg2lX_b1502715027epcas5p1j;
	Wed, 28 Aug 2024 16:15:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wv8dd4RSKz4x9Pq; Wed, 28 Aug
	2024 16:15:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A4.61.09640.51D4FC66; Thu, 29 Aug 2024 01:15:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240828095322epcas5p134935f60a199bc085198b06871cd33ba~v28CAccW40840408404epcas5p1C;
	Wed, 28 Aug 2024 09:53:22 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828095322epsmtrp1234caec0be77e195d9b287cc91375a35~v28B-wj1G2560425604epsmtrp1i;
	Wed, 28 Aug 2024 09:53:22 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-6d-66cf4d154d73
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.7A.07567.193FEC66; Wed, 28 Aug 2024 18:53:21 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240828095320epsmtip236d52ca600f940aec91bef7a23e2f579~v28AXO2qf1869918699epsmtip2E;
	Wed, 28 Aug 2024 09:53:20 +0000 (GMT)
Date: Wed, 28 Aug 2024 15:15:50 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240828094550.56id5x4x6neitsec@green245>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827132327.1704-1-pjy@amazon.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuq6o7/k0g5cflCxW3+1ns1i5+iiT
	xaRD1xgtLu+aw2Yxf9lTdovrD6Qsdk9rZ7ZY9/o9iwOHx4oLXawe5+9tZPG4fLbUY9OqTjaP
	zUvqPXbfbGDz+LxJLoA9KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
	1VbJxSdA1y0zB+gkJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
	ul5eaomVoYGBkSlQYUJ2xpRHzawF/5gqbv/7yNrAeJ+pi5GDQ0LARKJhW0oXIxeHkMBuRone
	LWvZIJxPjBKH5y1jgXC+MUr8un+SsYuRE6zj+eJJ7BCJvYwSK9ZPhXKeMUpc3TgPrIpFQFWi
	q3ULC4jNJqAuceR5K1hcREBZYuGsxUwgDcwCdxglph3/AVYkLBAhsbbpP9hRvAJmEluepoCE
	eQUEJU7OfAJWwilgLLF/8xRmEFtUQEZixtKvzCBzJAR6OSSunHzACvGQi8TP3kCIS4UlXh3f
	wg5hS0m87G+DstMlflx+ygRhF0g0H9sH9Zm9ROupfmaQMcwCGRLzH+lDhGUlpp5aB1bOLMAn
	0fv7CVQrr8SOeTC2kkT7yjlQtoTE3nMNULaHxOruHdAgbWOUWHfqJfMERvlZSF6bhbBuFtgK
	K4nOD02sEGFpieX/OCBMTYn1u/QXMLKuYpRMLSjOTU8tNi0wzEsth0d3cn7uJkZwetXy3MF4
	98EHvUOMTByMhxglOJiVRHhPHD+bJsSbklhZlVqUH19UmpNafIjRFBhTE5mlRJPzgQk+ryTe
	0MTSwMTMzMzE0tjMUEmc93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGJrv6DwxPd25cy/A9dnJx
	XdWZD7teWO1SM3z8WcVrYUT/5oCz4kzaHyw/M6x2ELv3lOHPAT3VD4wGRxUrp719u635XOXq
	3LYojehpz+aaFjz8ksGXcWJr6eody9IcOQSPM/rFML9R2rBc8sbLynpVo7YFfor285xv31o2
	t+/CGgbJWezZZ+U9ZgZcqb2iOufbyekP+G69tt1958S209xPrjgHvLDSMu96nVK6K//8TlWd
	rL2uU/ukzkyR/a4oLMDDW3Pb/k6owdpdmy4lJP8MP5E0TfDW6U0qHZNWzja3PXCftSXp/PL7
	c5/5Lp1RuHt5obvYR/ZtU1jnH90qFHVqdcSSsv2S8aXPJnQ3qThkP4xTYinOSDTUYi4qTgQA
	wl+lVTgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvO7Ez+fSDJquWVusvtvPZrFy9VEm
	i0mHrjFaXN41h81i/rKn7BbXH0hZ7J7Wzmyx7vV7FgcOjxUXulg9zt/byOJx+Wypx6ZVnWwe
	m5fUe+y+2cDm8XmTXAB7FJdNSmpOZllqkb5dAlfGzQfz2QsMKt62L2JtYNTuYuTkkBAwkXi+
	eBI7iC0ksJtR4uOzOIi4hMSpl8sYIWxhiZX/ngPVcAHVPGGUmLe2kw0kwSKgKtHVuoUFxGYT
	UJc48rwVrEFEQFli4azFTCANzAJ3GCWu7rsBtkFYIEJibdN/oAQHB6+AmcSWpykQi40kph3Z
	ANbLKyAocXLmE7CZzEAl8zY/ZAYpZxaQllj+jwMkzClgLLF/8xRmEFtUQEZixtKvzBMYBWch
	6Z6FpHsWQvcCRuZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBUaGlsYPx3vx/eocY
	mTgYDzFKcDArifCeOH42TYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWp
	RTBZJg5OqQamq2K/k35wlk39fN1Gj/kzz0IDfevt0zgehCnbLj3TtLrrXuOWusnbFin+TtGc
	srvwRPsRpW1htrv3vxHZq6skGHCtxG3vnd+XD6nZdfH1ROaZM1tOT3Yz4311ryg120HSODj/
	pUDxpbTDUjOrci7E7KqL+i0f9EMx7sLC6nNT+nsPlgVf769e/VzGZb/BXNbG9S/Fa1Y9n3VA
	MTz+tumCWuGMttAzCis6LpoV/LLiZl3z8u56xll/ZxZ+ZuF64p/XkbbNs71t35NIfmuum63n
	Tizbdc380bZuxsdbp4Yzp/N3LxaQ7WF/FtFdIXPuTsjdVUUL69ZuMAutiymZrtmdskbm9krW
	Mxfb3fq1711SYinOSDTUYi4qTgQAF3N5MvkCAAA=
X-CMS-MailID: 20240828095322epcas5p134935f60a199bc085198b06871cd33ba
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----wG8aeMZ_I9uC6yBdj_JCG0W3RU-IZGBujJEAuAycL.OUxp4R=_dcb61_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240828095322epcas5p134935f60a199bc085198b06871cd33ba
References: <20240827132327.1704-1-pjy@amazon.com>
	<CGME20240828095322epcas5p134935f60a199bc085198b06871cd33ba@epcas5p1.samsung.com>

------wG8aeMZ_I9uC6yBdj_JCG0W3RU-IZGBujJEAuAycL.OUxp4R=_dcb61_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

------wG8aeMZ_I9uC6yBdj_JCG0W3RU-IZGBujJEAuAycL.OUxp4R=_dcb61_
Content-Type: text/plain; charset="utf-8"


------wG8aeMZ_I9uC6yBdj_JCG0W3RU-IZGBujJEAuAycL.OUxp4R=_dcb61_--


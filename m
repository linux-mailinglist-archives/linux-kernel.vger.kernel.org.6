Return-Path: <linux-kernel+bounces-261769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9703F93BBE7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0F21C233A3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD5208D0;
	Thu, 25 Jul 2024 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M3VBoPMp"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E61CAB2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883504; cv=none; b=Rm14SFixTj0HiIj47TYxC/mnD9qftFmbZFTMBe6op1SzNuMB6t1q9Ia4bO0LC5QsXIg/PA5YVJ6dJnedwKg064d9cet1bd1AvpdUZkK+bIyY+Fe3wstuvBr+OybXcpchvIPxzFha5kGh/DJj8YfLM6fcm/WQLpFDTOQByOImbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883504; c=relaxed/simple;
	bh=hm6FD2Ug5c3pOe9Qm89s7IFoHzb9JCpzfyhKV9uY+fU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=iy71ElOU/tvCtcLPlGxDH/lX43YxCnY5sNA7S9tkib49t0O/LhlSH0jxi2V9aZQBXOz0QXgfY4eBh4S+ZYYhup9c1IONEz8gXzgp1KYW7qtdzXroBIhdtgsPa6pkaTrZ/+wGZc9NW8wUVU59UFDUeM34RlvRw7Nz7Mc+BbBiWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M3VBoPMp; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240725045819epoutp03ebaadd53a07b93b6551abd362e98d4b1~lW_uIaKMW1831918319epoutp03y
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:58:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240725045819epoutp03ebaadd53a07b93b6551abd362e98d4b1~lW_uIaKMW1831918319epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721883499;
	bh=hm6FD2Ug5c3pOe9Qm89s7IFoHzb9JCpzfyhKV9uY+fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3VBoPMpYPCK48D2wsTvNc0NAeN7XL8xZCu0wsyHVsB3pWFrZePs3E2FWsdsyIvjp
	 s5ZqlKjcbuK951eWPP4+nX6NvWdUtd5p04wpCBybSNEwI+rBmzdTjsVx4cMsdBOMWV
	 QVn8o8IcPHd634nnVeCUQqI5tL+ebAW8Rw/n1Ur0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240725045819epcas5p165872ae10ae773175616c5d486fa04d8~lW_tusTvW2882328823epcas5p1G;
	Thu, 25 Jul 2024 04:58:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WTzDB0kw8z4x9Pr; Thu, 25 Jul
	2024 04:58:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	52.70.09640.96BD1A66; Thu, 25 Jul 2024 13:58:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29~lOEKj4BT52025820258epcas5p3E;
	Wed, 24 Jul 2024 18:04:51 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240724180451epsmtrp12840ad44c1adeaa3848969e7cc400b23~lOEKjMiLZ2369423694epsmtrp1X;
	Wed, 24 Jul 2024 18:04:51 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-97-66a1db699e3e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.6A.07567.34241A66; Thu, 25 Jul 2024 03:04:51 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240724180449epsmtip1b78a4c96b9f589188d3e4e90108e90cf~lOEJO5Qad1370813708epsmtip16;
	Wed, 24 Jul 2024 18:04:49 +0000 (GMT)
Date: Wed, 24 Jul 2024 23:27:35 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky
	<leonro@nvidia.com>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <20240724175735.lndoof76kovv5ge6@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmum7m7YVpBhuXaFmsvtvPZjHr9msW
	i5WrjzJZTDp0jdFiyq+lzBabNjxhsbi8aw6bxfxlT9kt1r1+z+LA6XH+3kYWj8tnSz02repk
	89i8pN5j980GNo/e5ndsHp83yXm0H+hmCuCIyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUz
	MNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpOSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQ
	klNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8fT5UsaCPraKWWeKGhi3s3YxcnJICJhIvO7a
	x9jFyMUhJLCbUeLX9wZmCOcTo8TC++uZIJxvjBL7WnYwwbRcWNUK1bKXUeLssgMsEM5nRomJ
	Vy6ygVSxCKhKPLh8D6iDg4NNQFvi9H8OkLAIUHjlgrusIPXMAnOZJJ5sbWAESQgLREqs3jab
	EaSeV8BZomuiJEiYV0BQ4uTMJywgNqdAmMT235fAdkkITOWQ+DNvBzvERS4Sp99vg3pIWOLV
	8S1QcSmJl/1tUHa5xMopK9ggmlsYJWZdn8UIkbCXaD3VzwyymFkgQ+L9FkGIsKzE1FPrwD5m
	FuCT6P39BOp7Xokd82BsZYk16xewQdiSEte+N7KBjJEQ8JCYed0BEiYrGSXauu4xTWCUm4Xk
	n1kI22aBbbCS6PzQxAoRlpZY/o8DwtSUWL9LfwEj6ypGydSC4tz01GLTAsO81HJ4FCfn525i
	BCdXLc8djHcffNA7xMjEwXiIUYKDWUmE98mruWlCvCmJlVWpRfnxRaU5qcWHGE2BsTORWUo0
	OR+Y3vNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamDKbgr7z3qL
	uevCIpcJfeE2hS+CbmpO2Wx5dcXRuPUfCx4zudwwu/BiHdvD9dv5vj+bIaE4PyTp+RqHZiun
	BJ5uw/nc3gtOLvHZvzn901eHn/VN+rKlC06l8ih7b8j7smHLe82p7I7vo90k1Z/GxM6cdOOm
	d05+rHyuhvLOR+9U7tzZcov7dU+jzl4xM3WZt4WmAkEnYya+FFv1SMDMRrg1m/Wr36IFnp5a
	p0Vmdl15k1Hezrvw8NbnsuZF85dG++1bJRic/Ma4qvTghXcap/cvO1vlssFrtbzjthg7RjnG
	JJ3JFkoHN1i3av17sPTRvP6Lq55FXt8Vezbtzs/XhmXH/wa6TK+2Mhb8y8a1c42JEktxRqKh
	FnNRcSIAD4X0KjcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK6z08I0g2ObhC1W3+1ns5h1+zWL
	xcrVR5ksJh26xmgx5ddSZotNG56wWFzeNYfNYv6yp+wW616/Z3Hg9Dh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm0dv8zs2j8+b5DzaD3QzBXBEcdmkpOZklqUW6dslcGXcatzAUnCAueLWnpmM
	DYzNzF2MnBwSAiYSF1a1MnYxcnEICexmlJj5/j4LREJSYtnfI1BFwhIr/z1nB7GFBD4ySnT+
	YwOxWQRUJR5cvsfUxcjBwSagLXH6PwdIWAQovHLBXVaQmcwC85kkZry6xQqSEBaIlFi9bTYj
	SD2vgLNE10RJEFNIIFTiwxFTkApeAUGJkzOfgF3ALGAmMW/zQ2aQEmYBaYnl/8CmcwqESWz/
	fYllAqPALCQds5B0zELoWMDIvIpRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzgmtDR2
	MN6b/0/vECMTB+MhRgkOZiUR3iev5qYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtFSCA9
	sSQ1OzW1ILUIJsvEwSnVwDRN75SQsZjfQfNDXAdePTGZo6+1SOqQQO0kleM3vupbteRNCrKR
	+vY7MOXAcQNlq9eG8yMfrtkvcLjh7ueTb/nm/TzZulB9xef9Tb5y3c3N61Ti1wRtkSv+69dd
	rM9/fkric/1zFw9mu2n21BRaV88zDzN8LeX078nWVSuEzkUrc0hsUQl/+qmopYfj78FjiiFu
	qasz3U6+/qqQ9mjyS2eZjhWXCvh9LFzSzrAtEqvaJ7pv8ptbNaf3O7l7WVws13N/YfboIK+H
	iV1b7Mb+yaxswfOzAzRcezcy3X+zdM+aasM41lD+COe7kU+aboUteTP1MEtN6d2AWUsrQwOY
	HHUTBH+0v5/pZv/4tyvfaSWW4oxEQy3mouJEAG1HVCb4AgAA
X-CMS-MailID: 20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
	<CGME20240724180451epcas5p3cffc89fcc59156ca49078a60851f1e29@epcas5p3.samsung.com>

------tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 24/07/24 01:31PM, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>nvme_map_data() is called when request has physical segments, hence
>the nvme_unmap_data() should have same condition to avoid dereference.
>
>Fixes: 4aedb705437f ("nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data")
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_
Content-Type: text/plain; charset="utf-8"


------tv00kGafDAKugJLLWPAFdl2KPkYaKdNcKQc3tmj5W0zcLjXE=_3e4fd_--


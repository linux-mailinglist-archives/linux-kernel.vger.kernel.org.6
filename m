Return-Path: <linux-kernel+bounces-228082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9280E915AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F188728A8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6013A1A2FAA;
	Mon, 24 Jun 2024 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UZdwP4GS"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2831A0732
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719272032; cv=none; b=RlYpM0TE7SUgiKbXnc4FUqfRc1gh6YNMaxgXs8xvz96iFVTUx51La9T2ToCBViG1flUFEJVFmlL1gxwce6vNobFLMzbCriJKCdhwKTWZg3REBYiIooF1oXK5XBnaUcOMBzv89sHOmrIQdI1uCXd9VTZDUIDC8FDKDJprKz8d2bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719272032; c=relaxed/simple;
	bh=PJBJs7wnrIjbVjyRdEF0Mibpa3gB9r03JLYAbwEoj9w=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=UstG7eqZmNuHdS+Lx8YaGIE5FUVX6Ps2SkrGJGy8psLJVI9ykPjx/qM12xjGBrbTsAhdXF4xn0x4ULImAqmusoPEVMO1nnkpv1zV23K6F4mewOze+A/XEISyjDpdlZ1YJzyDeatNqi9ApKmeZ5hbNIgzM9mOV/6+wD425BHLYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UZdwP4GS; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240624233348epoutp03252874d07e9ef2d697c0cd7d3ef9bc2d~cFMz8i2YB2222322223epoutp037
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:33:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240624233348epoutp03252874d07e9ef2d697c0cd7d3ef9bc2d~cFMz8i2YB2222322223epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719272028;
	bh=3ImCeEfh/Ra1qJMJwGnWtMgllCYvieBq5YplBv0iy9U=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=UZdwP4GS5CciNAT3vQAMYtq3FliN5A7SvhxlcqIJHfLAkpRVRKz/RwjOALjQt82/M
	 rzeEmZ0SHvhOh7yJNvxjeuBZLf69gTEDbPY2BqtsMmH7iwlKmfvdxcl9tjKXQ8Katt
	 4R2ZqUM+5uW9+0RZnk9QwC3LQy8aM8t4GObHySmc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240624233347epcas2p4a904ace9d029c5a306a5d09eb88784dc~cFMzZIiM51759817598epcas2p4K;
	Mon, 24 Jun 2024 23:33:47 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.102]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4W7PRb3Dxsz4x9Q3; Mon, 24 Jun
	2024 23:33:47 +0000 (GMT)
X-AuditID: b6c32a47-ecbfa7000000264e-60-667a025b1845
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	FD.68.09806.B520A766; Tue, 25 Jun 2024 08:33:47 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2] f2fs: add support single node mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Chao Yu <chao@kernel.org>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Seokhwan Kim <sukka.kim@samsung.com>, Dongjin Kim
	<dongjin_.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>, Jaeyoon
	Choi <j_yoon.choi@samsung.com>, Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo
	Jung <siu.jung@samsung.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <a4ae575c-9eee-47fe-b49d-c71737022d24@kernel.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240624233246epcms2p234a0027e14c8285e1674cbbe5680842c@epcms2p2>
Date: Tue, 25 Jun 2024 08:32:46 +0900
X-CMS-MailID: 20240624233246epcms2p234a0027e14c8285e1674cbbe5680842c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmuW40U1WawdZeYYvTU88yWTw50M5o
	8fKQpsWqB+EWP06aWPTvbmexeLJ+FrPFwrYlLBaXFrlbXN41h82i5Y+TxfmJr5ksVnXMZbSY
	ev4IkwOfx6ZVnWweuxd8ZvJY3DeZ1aNvyypGj8+b5AJYo7JtMlITU1KLFFLzkvNTMvPSbZW8
	g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4COVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
	F5fYKqUWpOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZzxZ+46t4D9jxe1NF5gbGA8zdjFy
	ckgImEh0zZ/H1MXIxSEksINRouF9D3sXIwcHr4CgxN8dwiA1wgK2Etsm3wSrFxJQklh/cRY7
	RFxP4tbDNWBxNgEdiekn7rODzBER2MckserZQbChzAIzmCTmne5lg9jGKzGj/SkLhC0tsX35
	VrBuTgE7iZ6LnewQcQ2JH8t6mSFsUYmbq9+yw9jvj82HulpEovXeWagaQYkHP3dDxSUlbs/d
	BFWfL/H/ynIou0Zi24F5ULa+xLWOjWA38Ar4Sqzd1g4WZxFQlXjxA2aOi8SVl41gNcwC8hLb
	385hBgUKs4CmxPpd+iCmhICyxJFbUBV8Eh2H/7LDfNiw8TdW9o55T5ggbDWJdT/XM01gVJ6F
	COlZSHbNQti1gJF5FaNYakFxbnpqsVGBMTxyk/NzNzGC06uW+w7GGW8/6B1iZOJgPMQowcGs
	JMI7vb4sTYg3JbGyKrUoP76oNCe1+BCjKdCXE5mlRJPzgQk+ryTe0MTSwMTMzNDcyNTAXEmc
	917r3BQhgfTEktTs1NSC1CKYPiYOTqkGpnI2kTeqsV82nbukLXv/bsDJjaZHprFfyWiRddY5
	0iEd73X+0cL/167UNGUu2H/4xs4lO58elfrWG7P27zvvBXmH15xSeuXSWt5RbHOmp2Xit8Tz
	Wx+vO/KLYe4k2Ry95+sqtvWYvbvy4pvLQdXly5p6VYIzGiexlZV0xC9RzKsQ3jqxyXXrUn+m
	Yks2bfPLxVve2llqq2pkT55rnljrp3znljZfzYvM4p+2/6/PUdDS/ngn9998m/BXWxnuXDBc
	ecChc9eRrdzMNf33X5+KePn/WumigJ5dG4Q2fdzf9Lz+W86MzUvClQsvr7pgwfMwVDXQtr75
	yV6djxkLav8x655fMzv6SZqj27950Wdtt7QrsRRnJBpqMRcVJwIAs9UdhTgEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240617045134epcms2p3f2f82336438f636b3f1ad58fd0c1cd29
References: <a4ae575c-9eee-47fe-b49d-c71737022d24@kernel.org>
	<20240617045134epcms2p3f2f82336438f636b3f1ad58fd0c1cd29@epcms2p3>
	<CGME20240617045134epcms2p3f2f82336438f636b3f1ad58fd0c1cd29@epcms2p2>

Hi Chao, 

>
>It looks complicated to enable single_node_sec mode dynamically, what do
>you think of making this as a feature which can only be eanbled by mkfs?

I think it is good idea, I will change this patch for mkfs tool.

Thanks,

Daejun


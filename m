Return-Path: <linux-kernel+bounces-407221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80919C6A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F48B23FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4E4189BBB;
	Wed, 13 Nov 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hSSJHIge"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F1189BBA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485489; cv=none; b=sCGbctOb7RS+sq90yYYNAkl8QhLovDVVCjRjySHzgVimuCSLxXigkso4aDzSVMpAE0qtpsA6X/P7Yo+fdWcxIKdm752bgTkdy8B5KHDhV/WS1caR1KzKji5y7UKgO0Cb8tgEuluwJtvB15UQ4VGYg5BROWo0DxqRc59/ws36Fpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485489; c=relaxed/simple;
	bh=kQyCBharMJdkEZtLHa1vtmF0/jTbWNDkBfdvHWEkQm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kB9RII7Z7f9H7MN0bk/7Uqin3ajEoE0ME3hTqeZkfI2uSrM0QFFRG5JRZUxhCxVk+dZVIDomV5e0MULKtFQVJEKgHRmYpJjFSKDpmFkOaWL7enrkCkebe3dw8r4KEDAI1XzOId+RT53jc2yOQH2q6yRAi7JmczP+B0/uG5fM+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hSSJHIge; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241113081119epoutp0118f2930d6f24266d70e60b89fca1c3e0~HeN6YqvkV1747617476epoutp01r
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:11:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241113081119epoutp0118f2930d6f24266d70e60b89fca1c3e0~HeN6YqvkV1747617476epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731485479;
	bh=kQyCBharMJdkEZtLHa1vtmF0/jTbWNDkBfdvHWEkQm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSSJHIgemTppYvubVnLVWcXvWVCwHAuxQy4M+E1FMTMa4hAJWb5ipvht/pHCsk8P5
	 EiS7rbE8H0lyKLuIvmeFbhH8AisKYJs7L3nJYlnonXYJar3j1LBOs9UkuqQdLORdEZ
	 Sks5K+xlYiFXZoubKrh7QujLli/tgFzzRN0D2YeA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241113081118epcas5p3a1adcd7b2fd910bc1a6004de744f4a16~HeN59ViuT2435524355epcas5p3L;
	Wed, 13 Nov 2024 08:11:18 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XpGFd3bmFz4x9Px; Wed, 13 Nov
	2024 08:11:17 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.DB.09770.52F54376; Wed, 13 Nov 2024 17:11:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241113062730epcas5p10bec3fe462b9b6e65d22a61c50902b78~HczRdLuOT2939829398epcas5p1c;
	Wed, 13 Nov 2024 06:27:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241113062730epsmtrp12d9a6ba53afcbeddbab88d3045113f7d~HczRcVvaR3041130411epsmtrp1W;
	Wed, 13 Nov 2024 06:27:30 +0000 (GMT)
X-AuditID: b6c32a4a-e25fa7000000262a-89-67345f256020
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B3.DF.18937.2D644376; Wed, 13 Nov 2024 15:27:30 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241113062729epsmtip16f389b4936b14bb2212005605db78fa0~HczQiWWlB0390603906epsmtip16;
	Wed, 13 Nov 2024 06:27:29 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: anuj20.g@samsung.com, asml.silence@gmail.com, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH liburing] test: add test cases for hybrid iopoll
Date: Wed, 13 Nov 2024 14:27:25 +0800
Message-ID: <20241113062725.3081236-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c0eb2b6f-1145-4ce3-a2b3-98d32cdfa623@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdlhTXVc13iTd4OoRMYumCX+ZLeas2sZo
	sfpuP5vFu9ZzLBa/uu8yWlzeNYfN4uyED6wO7B47Z91l97h8ttSjb8sqRo/Pm+QCWKKybTJS
	E1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOADlBSKEvMKQUK
	BSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfcb13N
	UvCOu6LpwmrWBsaTnF2MHBwSAiYSH7aLdzFycQgJ7GaUOPLyCzOE84lR4smjJQjOou+7GLsY
	OcE6Fq6bzAqR2MkocWb5dxaQhJDAD0aJK1trQGw2ASWJ/Vs+gDWICAhL7O9oBathFsiSOLh8
	DxOILSzgITFl0Xk2EJtFQFXi/s82sDivgLVE/8XlrBDL5CUW71jODGJzCthKnF2wkQ2iRlDi
	5MwnUDPlJZq3zga7VELgErvEno3rWCCaXSQenTjODGELS7w6voUdwpaSeNnfBmXnS0z+vh7q
	sxqJdZvfQfVaS/y7socFFEbMApoS63fpQ4RlJaaeWscEsZdPovf3EyaIOK/EjnkwtpLEkiMr
	oEZKSPyesAjqFw+Jx/uXMkICbgKjRNOCbSwTGBVmIflnFpJ/ZiGsXsDIvIpRMrWgODc9tdi0
	wCgvtRweycn5uZsYwWlSy2sH48MHH/QOMTJxMB5ilOBgVhLhPeVsnC7Em5JYWZValB9fVJqT
	WnyI0RQY4BOZpUST84GJOq8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU7NTUgtQimD4m
	Dk6pBqbM3GPLLPJuFGpW9rftZ+097JCwW+t/ffeRFYbBWdHSd2SOhj2zbzynWXogcnHeglU1
	ZvnM++fY/PLTl9kl8Me1qmPjQ6aFMww3rPi1/Nj2pleBPxbuDvOq2Ddt5dTTIY2p5/iiDpkL
	ejRv/525OexORoB63BXxgIT4Tp5TR499mX5Zcr3/rJCtlyVO83/uZ7DZIK50n3NCjWNg0OOM
	nVIuGus+/p8dfYBRxv7gI9eUhaWM7C9sLvVrqnT0bIyzarz0TfOP8MGp7Tv/39jbtPFVy3rb
	l2qtD/UYe/UEPzzZXTbDef6pNOOTC2T004tD/DacMypIdO/o2bd+Vv693DOtbvs7eNuV4l0C
	Y9RfrVBiKc5INNRiLipOBADr0mQUHAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnO4lN5N0gwdbRC2aJvxltpizahuj
	xeq7/WwW71rPsVj86r7LaHF51xw2i7MTPrA6sHvsnHWX3ePy2VKPvi2rGD0+b5ILYInisklJ
	zcksSy3St0vgyrjfupql4B13RdOF1awNjCc5uxg5OSQETCQWrpvM2sXIxSEksJ1RYvfzThaI
	hITEjkd/WCFsYYmV/56zQxR9Y5T4uukUG0iCTUBJYv+WD4wgtghQ0f6OVrBmZoE8iTdbWsBs
	YQEPiSmLzoPVswioStz/2cYEYvMKWEv0X1wOtUBeYvGO5cwgNqeArcTZBRvB6oUEbCS2rl3J
	AlEvKHFy5hOo+fISzVtnM09gFJiFJDULSWoBI9MqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxN
	jOAQ1grawbhs/V+9Q4xMHIyHGCU4mJVEeE85G6cL8aYkVlalFuXHF5XmpBYfYpTmYFES51XO
	6UwREkhPLEnNTk0tSC2CyTJxcEo1MOk8WXYuKN1Hq5Ch8m6eac6Le5eFlbL/l165vV/98Cal
	KmOdmTWs3VP/u3l8cBadme6t7ZZvZOTxfcJi/tVXJDo6mkxO6MmXvbz8QLR//t+3Jw6oVNS7
	NqzcP3+L3a4laVXMj7++1lnFvMaWk503LWlvnb6Pr1PgpwaTJIWlR3wOL3/6av2U1dHcGYf6
	rLrfLL3qwpxqVLmV4cBdj59dyj9EPZeaTGQWenU+Kk6lJy2Eb2JruwGnBdO+3W+XZAS+Whg3
	6dj9f3Oc3boTRWq4P798qHu0cfMv6Tt6vmZmK1x7DjHcfZUertxf936jTM/SFU8veul8Nl/P
	Vu2lIenPebhxenriwbx/PTcViu3ClFiKMxINtZiLihMBnkhmwdACAAA=
X-CMS-MailID: 20241113062730epcas5p10bec3fe462b9b6e65d22a61c50902b78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241113062730epcas5p10bec3fe462b9b6e65d22a61c50902b78
References: <c0eb2b6f-1145-4ce3-a2b3-98d32cdfa623@kernel.dk>
	<CGME20241113062730epcas5p10bec3fe462b9b6e65d22a61c50902b78@epcas5p1.samsung.com>

On 11/12/24 15:43, Jens Axboe wrote:
>On 11/12/24 3:44 AM, Anuj Gupta wrote:
>>> +utilization than polling. Similarly, this feature also requires the devices
>>> +to support polling configuration.
>> This feature would work if a device doesn't have polled queues,right?
>> The performance might be suboptimal in that case, but the userspace won't
>> get any errors.

>We've traditionally been a mix of lax and strict on this. IMHO we should
>return -EOPTNOTSUPP for IOPOLL (and IOPOLL|HYBRID) if polling isn't
>configured correctly. I've seen way too many not realize that they need
>to configure their nvme side for pollable queues for it to do what it
>needs to do. If you don't and it's just allowed, then you don't really
>get much of a win, you're just burning CPU.
>
>Hence I do think that this should strongly recommend that the devices
>support polling, that part is fine.
>
>Agree with your other comments, thanks for reviewing it!

>> This patch mostly looks fine. But the code here seems to be largely
>> duplicated from "test/io_uring_passthrough.c" and "test/iopoll.c".
>> Can we consider adding the hybrid poll test as a part of the existing
>> tests as it seems that it would only require passing a extra flag
>> during ring setup.
>
>Yeah I do think modifying test/iopoll.c to test all the same
>configurations but with HYBRID added would be the way to go, rather than
>duplicate all of this. Ditto for passthrough.

Got it, will add it and submit v2 patch.

--
hexue


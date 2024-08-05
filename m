Return-Path: <linux-kernel+bounces-274098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A9694735F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 04:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04634280F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 02:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD242D7B8;
	Mon,  5 Aug 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hD4kYVPi"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B918E3F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722825125; cv=none; b=JwwweX6xrrraMDcjunN0NVCsj/vX/cGWrklxLJofuW1SIVNn5aF6PSiv71RuNRTR+cKxYNZiZk9nqajxI8sczjKF5D97QaPLV67uaIV4nGm1lI4r9QuJwOovzmFPlknUqtgzAbNzdX9altOmp/VTE5wZ+r5e0WxBol1riy7/F1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722825125; c=relaxed/simple;
	bh=PTu3LwCYlsk4mGZJjMmoDWN6+L5zqP4928z77r6TfGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=axro6NaNz4ForJAT73IkxtzZSGndIdDpYd5CaxZdFRM9RTycO7aucBdLOMu4FTg42DE7XJouHowaTg9glnDY2kkwcFOHBOxY2GREnkavdf+zscZu8iH8jehVJKYi5iNf99NMVK7vRKabUXBbV3Dyx0ScL+RL4XRpTzIijAhlAcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hD4kYVPi; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240805023155epoutp01b568335cc2fbc635ceccc6524502daf5~otFB4tH200814108141epoutp01Y
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 02:31:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240805023155epoutp01b568335cc2fbc635ceccc6524502daf5~otFB4tH200814108141epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722825115;
	bh=U3/EOKMmRg2b+wEZlxO7EXZpG5799dYUSP8FtuCvBQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hD4kYVPi7S5DZKBwqWhacH1WeN9hcdKnPJmvMcQ7ktbueFc+wEWayej+OndKgYSXO
	 LuuK+8gJL0f4NMzM8F5Rb6YMl/tzSvJ+HJbf8vsoLhoEZyO1ZTlOBb1haCne2hkZIu
	 vrsVtDUIh25Fnp1D8v1qXvasPu0tJs+UPog2L9P0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240805023154epcas1p27e682c15075ef5ffd6937f8b930cf0ac~otFBiXofG2874128741epcas1p2l;
	Mon,  5 Aug 2024 02:31:54 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.222]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WcgSB59sSz4x9Pv; Mon,  5 Aug
	2024 02:31:54 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	61.76.10258.A9930B66; Mon,  5 Aug 2024 11:31:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240805023154epcas1p47037b2487d0d2c3623b96eba0d87d714~otFBHAuRz2670326703epcas1p4U;
	Mon,  5 Aug 2024 02:31:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240805023154epsmtrp1e56a30c3952b61124f2424572e9844ec~otFBGFAP41846318463epsmtrp1a;
	Mon,  5 Aug 2024 02:31:54 +0000 (GMT)
X-AuditID: b6c32a38-9ebb870000002812-7c-66b0399aa190
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.D1.08964.A9930B66; Mon,  5 Aug 2024 11:31:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.252]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240805023154epsmtip16a50dd5457ab787c8b7d6d0223988365~otFA5uD753076430764epsmtip1H;
	Mon,  5 Aug 2024 02:31:54 +0000 (GMT)
From: Sangmoon Kim <sangmoon.kim@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, jordan.lim@samsung.com,
	linux-kernel@vger.kernel.org, myoungjae.kim@samsung.com,
	sangmoon.kim@samsung.com, youngjae24.lim@samsung.com
Subject: RE: [PATCH] workqueue: add cmdline parameter
 workqueue.panic_on_watchdog/max_watchdog_to_panic
Date: Mon,  5 Aug 2024 11:31:47 +0900
Message-Id: <20240805023147.2984866-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZqlemexVxV0LQVGR@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmnu4syw1pBtMfq1tMXbubyeLGsjCL
	y7vmsFlM/yhmcetBI4vFr+VHGS227X3K5MDusXPWXXaPTas62Tz6tqxi9Pi8SS6AJSrbJiM1
	MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
	ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PlrW9M
	BU9ZK/q/XWdvYLzF0sXIySEhYCKx/PASpi5GLg4hgR2MEuuunWSHcD4xSrzeeZYFwvnGKPG8
	/x0bTMuU/8tYIRJ7GSXu34NxvjBK7Pq3hxmkik1AV+LLvMuMILaIgKzElWkPGUGKmAWWMkos
	XXYfqIiDQ1ggU+LCUyUQk0VAVeLLdCWQcl4Be4lNn34zQSyTl9h/8CzYSE4BfYlr7y8zQ9QI
	Spyc+QTsB2agmuats5lBxksIPGKXaHi9iRGi2UVi4ew7UI8KS7w6voUdwpaSeNnfxg7R0M8o
	caq7C6poCqPE3GuaELaxRG/PBbA7mQU0Jdbv0odYxifx7msPK0hYQoBXoqNNCKJaTeLxq7tQ
	a2Uk+u/Mh5roIdF9aTs0FJsYJR7/us02gVF+FpIfZiH5YRbCtgWMzKsYxVILinPTU4sNC0zg
	0Zqcn7uJEZwItSx2MM59+0HvECMTB+MhRgkOZiUR3md716YJ8aYkVlalFuXHF5XmpBYfYjQF
	BvBEZinR5HxgKs4riTc0sTQwMTMysTC2NDZTEuc9c6UsVUggPbEkNTs1tSC1CKaPiYNTqoGp
	yj7b8G5EfPPiTi+mrLX1bcu/hezJ3Zcw89+1RVdMbbc8TjTa/Ex/R4ht6vFDa4ytSm6bHHOv
	9t4ouKRT+Ud56+4pgZ6JngofgwWtg48Ycb21YL61+Y7bH9/JUy/l1MV3VF8sXxI1Oc3l/w5N
	LQNhMW+dvr3v5p63ODBPxOT95ppXnPaqy1olk7dNiI+bqpwzoWvH1tsbmudf+pZf0CG7kS32
	wuIjD6O2L2B/6ypiekBs4rMjjRUL5i4/tuCWbHlf2Z9ai7V7noU5c+mL9+abJ86TKZdKjLh2
	t7Uj4OeCTKH2o2HNk15ypZvFL7lv89NPdHLyxrVMOjcm1z/8JvVEfG9LT6PN6ozV8z60H45V
	YinOSDTUYi4qTgQA+W5iCw0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnO4syw1pBrf6BSymrt3NZHFjWZjF
	5V1z2CymfxSzuPWgkcXi1/KjjBbb9j5lcmD32DnrLrvHplWdbB59W1YxenzeJBfAEsVlk5Ka
	k1mWWqRvl8CVsfLWN6aCp6wV/d+uszcw3mLpYuTkkBAwkZjyfxlrFyMXh5DAbkaJlsb1rBAJ
	GYmdFzczdTFyANnCEocPF4OEhQQ+MUrMXpwNYrMJ6Ep8mXeZEcQWEZCVuDLtISPIHGaB1YwS
	fzeuBpsjLJAu8XDVEnaQOSwCqhJfpiuBhHkF7CU2ffrNBLFKXmL/wbPMIDangL7EtfeXmUHK
	hQT0JCY8y4IoF5Q4OfMJ2MnMQOXNW2czT2AUmIUkNQtJagEj0ypGydSC4tz03GLDAsO81HK9
	4sTc4tK8dL3k/NxNjOAQ1tLcwbh91Qe9Q4xMHIyHGCU4mJVEeJ/tXZsmxJuSWFmVWpQfX1Sa
	k1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgckqtX3ddz9l5vTCEx/5l2WHPLs5
	uef5K+3bHq+2J8s9U55zOuiZQ5ecpnLI02qt93Pab93yesex3HX7y+bZXYEx3rnhh6+1LmrO
	m61rb3N5qRGvWcauNxoFD/ZsdBeSzGU4+GhJ/KNWztb1rg6veqevzVjZHr5Tty499YpF0TnV
	4F/bv7dpXjzaoPM8b574eakph/R8Dx61sXZ58Jz3T6/NksZ9kmYatsYKJt2VP7q6tLTqD4pc
	mHo3ufy3prnLn6M3tx6p4Wgr9/98KPmsyKTKC4kevUJb1A3MGew7Z4fOC52+Xm/VB77DRc8f
	z+bfWZ0yr3VvxLyJDw9UbSiKj/+WXvRJv/vz7cy3Qk175JVYijMSDbWYi4oTAR9empDQAgAA
X-CMS-MailID: 20240805023154epcas1p47037b2487d0d2c3623b96eba0d87d714
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240805023154epcas1p47037b2487d0d2c3623b96eba0d87d714
References: <ZqlemexVxV0LQVGR@slm.duckdns.org>
	<CGME20240805023154epcas1p47037b2487d0d2c3623b96eba0d87d714@epcas1p4.samsung.com>


> -----Original Message-----
> From: Tejun Heo <htejun@gmail.com> On Behalf Of Tejun Heo
> Sent: Wednesday, July 31, 2024 6:44 AM
> 
> Hello,
> 
> On Tue, Jul 30, 2024 at 05:04:28PM +0900, Sangmoon Kim wrote:
> > +static bool wq_panic_on_watchdog;
> > +module_param_named(panic_on_watchdog, wq_panic_on_watchdog, bool, 0644);
> > +static unsigned int wq_max_watchdog_to_panic;
> > +module_param_named(max_watchdog_to_panic, wq_max_watchdog_to_panic, uint, 0644);
> 
> Can you combine the two into a single parameter? Maybe name it
> wq_panic_on_stall? 0 disables. >0 indicates the number of times before
> triggering panic, maybe?
> 
> Thanks.
> 
> --
> tejun

Okay. Let me do that.
Thanks for the review.

Sangmoon


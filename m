Return-Path: <linux-kernel+bounces-522920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A83A3D01F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69FF3B4C22
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849781D5ACE;
	Thu, 20 Feb 2025 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oH3gfmiA"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D2F4C6C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022917; cv=none; b=J3xbI6gig6rFgtLBZqHrM8ZwqcVMl47WXIDaiH/3xV0lGfVoePFJR7TWNObVHDmro6F5AgcADfcs5w3ZWX8Nzq4Nr6uB4OjRiY/Eg3JSYSLRHANlOtIXzdCvpxF91aPVrjCfTiQ4Hi66lPB6LZV+40h5l/VTEyB6B16QpEaptec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022917; c=relaxed/simple;
	bh=krYBnspnrzjnvwlTX5XpErfRhugw92dkZZXwRyzxP2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=biY8ma7O7HsBn0RaTYwd48etY0BBXjJMplGs762QSU0dBvoz2ZPnNkBgCoBZT+YHXMd9TKzqaYm2U8Wp/5mRlal04djQjNbrXRdqhuL/19Ojq+7/LQSkdeYdX7WXO9wsdzUCK6bHyebShfgsrH2UZJbytu6+YFCOvTW+VVlIoLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oH3gfmiA; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250220034152epoutp01167da4670bf05ee7c90bcbc4f46ac2d0~lzZ7Mndpn2022920229epoutp01g
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:41:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250220034152epoutp01167da4670bf05ee7c90bcbc4f46ac2d0~lzZ7Mndpn2022920229epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740022913;
	bh=wmrJMEYkabUuacOnL6nFEj1/RBSJM2hfnCMBg2NNKoQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oH3gfmiApDoz9q7p5ZbtD166BlnX2n06l47xUlaQR1STu3DqLsmlcww9FjvTTBLfS
	 GPtj4npwRjx6YZaDBAfDhkzzIZfotEUaQWC7DXZDEj8waJYOEanOlrZKVusN6K57CF
	 el5I5GY/p31DJXupYOgP3rDJ0TaoZMxjV21uUx7c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20250220034152epcas2p426b276c30cc9821167bfbc61856b7571~lzZ6sxbpp0354403544epcas2p4L;
	Thu, 20 Feb 2025 03:41:52 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.69]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yyzb360vbz4x9Q3; Thu, 20 Feb
	2025 03:41:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.3D.32010.F74A6B76; Thu, 20 Feb 2025 12:41:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250220034151epcas2p3e23d8496e872b49da28ced7a87edd4ad~lzZ5fIc2t1684616846epcas2p3-;
	Thu, 20 Feb 2025 03:41:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250220034151epsmtrp2e44d3dacb76368441774acb0cfd0857d~lzZ5eU_VK0153801538epsmtrp2d;
	Thu, 20 Feb 2025 03:41:51 +0000 (GMT)
X-AuditID: b6c32a4d-acffa70000007d0a-41-67b6a47f6d44
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.C7.33707.E74A6B76; Thu, 20 Feb 2025 12:41:51 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.95.142]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250220034150epsmtip24b12282efba95807f28944fbb80fbdc6~lzZ5SjZo-1561315613epsmtip23;
	Thu, 20 Feb 2025 03:41:50 +0000 (GMT)
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: 
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz, Hyesoo Yu
	<hyesoo.yu@samsung.com>, Christoph Lameter <cl@linux.com>, Pekka Enberg
	<penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim
	<iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, Roman
	Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm: slub: Enhanced debugging in slub error
Date: Thu, 20 Feb 2025 12:39:42 +0900
Message-ID: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhW79km3pBveW61tM7DGwmLN+DZvF
	9W9vGC3+dl5gtVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYspHJYuIaUYvZjX2MDjweO2fd
	ZfdYsKnUY9OqTjaPTZ8msXt0vb3C5HFixm8WjydXpjN5LGyYyuzRt2UVo8eZBUfYPT5vkgvg
	jsq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6XEmh
	LDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQ
	nbFw32fGgn9cFb8+9bE1MLZzdjFyckgImEhMvP6LuYuRi0NIYA+jxIK+76wgCSGBT4wS687Z
	QSSA7AmTf7DBdHRcPsMKkdjJKLF0wgKo9s+MEs8fHGYCqWITUJc4sWUZI4gtIsAisfL7dxaQ
	ImaBGcwS2w/tBisSFnCSeNFyHCjBwcEioCpxfDczSJhXwEZi2cm97BDb5CVurznJAhEXlDg5
	8wmYzQwUb946G2yxhMBEDokHp5+zQjS4SDxs7WOGsIUlXh3fAjVISuLzu71QLxRLbFsMcihI
	cwOjxOaO+1ANxhKznrUzghzELKApsX6XPogpIaAsceQW1F4+iY7Df9khwrwSHW1CEI3KEvuX
	zWOBsCUlHq1th7rGQ6JzZTMTJERjJT5PaWCawCg/C8k3s5B8Mwth7wJG5lWMUqkFxbnpqclG
	BYa6eanl8IhNzs/dxAhOwFq+Oxhfr/+rd4iRiYPxEKMEB7OSCG9b/ZZ0Id6UxMqq1KL8+KLS
	nNTiQ4ymwCCeyCwlmpwPzAF5JfGGJpYGJmZmhuZGpgbmSuK81Tta0oUE0hNLUrNTUwtSi2D6
	mDg4pRqYQm/X3nmx2lv4xPm+uN0plQKLnqfH+JmfePi07OJXJ/trl7fN/S7/8Pi53iNzI0xC
	5euMeWdNuhYeLvzG6YrFd4vCdo+/DWt+Hjt1ImSV4GpOvUufz5dcLF5g/9Qttcx66r7zHe9c
	T/n895SWSmOxCSyePvX83nP2qfVZbr3fug0OJ1y4kRm7hVf+ybmFH849LzYNKPHnvib/cKvZ
	wfxpbvK9S/mUnRRc2Q6Ktf+aoqKi8rJ92+0Z6hvLn8tffl57PSZifek8/af6ZleWPN5yvWuP
	X1n4QnHbD9fzlyXWZUwznHRqhwLv9Ofr244rKcz5vqTt/6a2O7NFdxarajpsSzC9FvJ3UT4b
	f4wna/BJViWW4oxEQy3mouJEAN8gSWhJBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWy7bCSvG79km3pBr8vMVlM7DGwmLN+DZvF
	9W9vGC3+dl5gtVjZ3cxmsXlOscXlXXPYLO6t+c9q0fb5H5BYshGofo2oxezGPkYHHo+ds+6y
	eyzYVOqxaVUnm8emT5PYPbreXmHyODHjN4vHkyvTmTwWNkxl9ujbsorR48yCI+wenzfJBXBH
	cdmkpOZklqUW6dslcGUs3PeZseAfV8WvT31sDYztnF2MnBwSAiYSHZfPsHYxcnEICWxnlPj7
	+QUrREJSYtbnk0wQtrDE/ZYjYHEhgY+MEt2XqkFsNgF1iRNbljGC2CICLBIrv39nARnELLCE
	WeLY/GnMIAlhASeJFy3HgRIcHCwCqhLHd4OFeQVsJJad3MsOMV9e4vaakywQcUGJkzOfgNnM
	QPHmrbOZJzDyzUKSmoUktYCRaRWjaGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcAxoBe1gXLb+
	r94hRiYOxkOMEhzMSiK8bfVb0oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGan
	phakFsFkmTg4pRqYIgqyezVvKM0SUemw3BrwcpnKfdlQLSsJ/2M7NtZsy4yYcyz63LHCWcJx
	D464MS12OqFf0i77aeN6z5RWvTPblfiTKpNfS+q//v8h+J6Kwbvzmu1ic6w3NMqE5hqJ5Lre
	fukY86Z5yUldJ2/fCPblJ86fZnoYtvlF4v09K3YrbH1kG3ZD6vSLjAbtpBql8ntSF/7ODX/w
	P6DZriHrbuYFF5MbweFHOJZUO+vufBXS+jJ1S0uY0kRz6fedLQZsYU6fXb9L70t+M4fziPbq
	DTs03l3Orkz2Tptxc5H8zEu8NkuMC8L3Fm71L7Ja5CObNltizpLK2U5Ze5qU1suXaW+7/Fry
	rkoR72zFS7Mz9dSVWIozEg21mIuKEwFwXkSh8AIAAA==
X-CMS-MailID: 20250220034151epcas2p3e23d8496e872b49da28ced7a87edd4ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220034151epcas2p3e23d8496e872b49da28ced7a87edd4ad
References: <CGME20250220034151epcas2p3e23d8496e872b49da28ced7a87edd4ad@epcas2p3.samsung.com>

Dear Maintainer,

The purpose is to improve the debugging capabilities of the slub allocator
when a error occurs. The following improvements have been made:

 - Added WARN() calls at specific locations (slab_err, object_err) to detect
errors effectively and to generate a crash dump if panic_on_warn is enabled.

 - Additionally, the printing location in check_object has been adjusted to
display the broken data before the restoration process. This improvement
allows for a better understanding of how the data was corrupted.

This series combines two patches that were discussed seperately in the links below.
https://lore.kernel.org/linux-mm/20250120082908.4162780-1-hyesoo.yu@samsung.com/
https://lore.kernel.org/linux-mm/20250120083023.4162932-1-hyesoo.yu@samsung.com/

Thanks you.

version 2 changes
 - Used WARN() to trigger a panic instead of direct calling of BUG_ON()
 - Print the broken data only once before the restore.

version 3 changes
 - Move WARN() from slab_fix to slab_err and object to call WARN on
 all error reporting paths.
 - Change the parameter t ype of check_bytes_and_report.

Hyesoo Yu (2):
  mm: slub: Print the broken data before restoring slub.
  mm: slub: call WARN() when the slab detect an error

 mm/slub.c | 60 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

-- 
2.28.0



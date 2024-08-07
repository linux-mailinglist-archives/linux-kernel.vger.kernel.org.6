Return-Path: <linux-kernel+bounces-277173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F4D949D76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1244A284310
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17B118FC9B;
	Wed,  7 Aug 2024 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PV+37hXE"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D1217B512
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995290; cv=none; b=O4OG0pBSC+fhz2LYfGWlXsYJ0vfGAWXhBW+iaQYeXAkfL30GhpX+Un3c689H8+v604N/2GTkhy+hZvws1KLnSsEvQJqXfAG/sTkHImkXD9yBKo+pE7mSzuCtRT1XCsP/xXTN9eSEeCEOjMi+lMOzJJOyfKAcHrz7j2aBZf5rZ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995290; c=relaxed/simple;
	bh=uXXuk8O/C5fw8iMTKl6d6NjZASgWI23sq9+6ArcBJgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=sOM67hkV/FxTWuXeFuIv3eYv0wtpFv1uftlAO1Xc3ezheqFF1ML/MybzkN/A6SoY/2DSGCYIybsgDqNZehYX95JUVX4gQRgBS8mQLwoRdYanM0kSacF33j22i6th8HxSCbo6Ul3tB5MgyO6JvDZ3Mabq25N7ln9qfoR1Xl71S3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PV+37hXE; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240807014804epoutp04bf5d5899bacb84a035d4b3b88874d3f4~pTxUr6NpK2965829658epoutp04p
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:48:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240807014804epoutp04bf5d5899bacb84a035d4b3b88874d3f4~pTxUr6NpK2965829658epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722995284;
	bh=VzpVl9vxNhCMJyW+KmgA7heFUgMrQBgTdlX0nnqYur4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PV+37hXEqu50M40yevH/tTAUT78ISqu1V/OJbqmsCPhq6w9QnUJWZ+CUu3OTmXR+j
	 27aBLFbmTSqQNwqe5B8Qh/hHKaOjbRC5z2q25oDrN1PSyWyxxCAlYRsSmERH+tQOq5
	 8tZSoYwsQKZTHFO0dKkbqruIfjA0JyCpL2K39+ns=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807014804epcas1p16c367cf2864c8452200be4b8b4d973e1~pTxUOdN4c1040610406epcas1p1b;
	Wed,  7 Aug 2024 01:48:04 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.243]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WdtNh1KwBz4x9Q7; Wed,  7 Aug
	2024 01:48:04 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.CB.09623.452D2B66; Wed,  7 Aug 2024 10:48:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240807014803epcas1p30b08d972ecf1f9341bbf052d060c2900~pTxTbx87i1453614536epcas1p3T;
	Wed,  7 Aug 2024 01:48:03 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240807014803epsmtrp2d5db1a45f5e3a8d61b52a7478accd6d8~pTxTa5odN1311713117epsmtrp2v;
	Wed,  7 Aug 2024 01:48:03 +0000 (GMT)
X-AuditID: b6c32a36-ef9ff70000002597-55-66b2d2542c1c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.3B.19367.352D2B66; Wed,  7 Aug 2024 10:48:03 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.252]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240807014803epsmtip1258ebb8a486e7219be97657cdbe98901~pTxTQZc4q2121121211epsmtip1O;
	Wed,  7 Aug 2024 01:48:03 +0000 (GMT)
From: Sangmoon Kim <sangmoon.kim@samsung.com>
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, jordan.lim@samsung.com,
	linux-kernel@vger.kernel.org, myoungjae.kim@samsung.com,
	sangmoon.kim@samsung.com, youngjae24.lim@samsung.com
Subject: RE: [PATCH v2] workqueue: add cmdline parameter
 workqueue.panic_on_stall
Date: Wed,  7 Aug 2024 10:47:56 +0900
Message-Id: <20240807014756.3948130-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZrKCkpr05sRN28nc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmvm7IpU1pBkv+slhMXbubyeLGsjCL
	y7vmsFlM/yhmcetBI4vFr+VHGS227X3K5MDusXPWXXaPTas62Tz6tqxi9Pi8SS6AJSrbJiM1
	MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdov5JCWWJOKVAo
	ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO+P5GseC
	FvaKmRfqGxj3s3YxcnJICJhI3F97jbmLkYtDSGAHo8SDhf9YIJxPjBLTV/Uwwzl9Zw6wwLQ8
	vreCCSKxk1Fi1rTfUC1fGCXmLFvPCFLFJqAr8WXeZTBbREBW4sq0h4wgRcwCSxklli67zwyS
	EBYIlti67ikTiM0ioCrRufA+2ApeAXuJL3N3MUOsk5fYf/AsmM0poC/Rs+YlE0SNoMTJmU/A
	6pmBapq3zga7VULgGrtEx67DUM0uErfadkPdLSzx6vgWdghbSuLzu71sEA39jBKnurugiqYw
	Ssy9pglhG0v09lwAGsQBtEFTYv0ufYhlfBLvvvawgoQlBHglOtqEIKrVJB6/ussIYctI9N+Z
	DzXRQ+Lk/NfskBBqYpT4cfo72wRG+VlIfpiF5IdZCNsWMDKvYhRLLSjOTU8tNiwwgkdrcn7u
	JkZwItQy28E46e0HvUOMTByMhxglOJiVRHibwzelCfGmJFZWpRblxxeV5qQWH2I0BYbwRGYp
	0eR8YCrOK4k3NLE0MDEzMrEwtjQ2UxLnPXOlLFVIID2xJDU7NbUgtQimj4mDU6qBqXfBqVD2
	s2yum4736RZ1vJpUe/SgrcJuq/PqlR+uZNaeqHz4qlHLSkY+1qHUfZfcgWlZC3KP+jTJTOhY
	Ha3hy9NdtDZRafab5F+2f+89tEnqPO663dr1zda1645kM2+5/oGzk8U1Ur7bU/nkpR8N8vqr
	pxX/a/sV9nTGjIUmwTtY72rnaEpJz/iqqqj0chuLqH0Jf8XhzZYiAavq1PXNZ/d8j+bmDhL5
	UFPyO6F5rsDrd85ad0Nb9YxS7zJFrFffkuHYs12/RSs7w0wqYM8XAXGdmZlG/lJBmhem3Iyt
	C6h0jnpnXXd97gnDeX+cAszDtnTp/6k6xzDb8VCV2/U174ISTRncJu2cdHXajwolluKMREMt
	5qLiRAAQLZ0FDQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnG7wpU1pBj1nxS2mrt3NZHFjWZjF
	5V1z2CymfxSzuPWgkcXi1/KjjBbb9j5lcmD32DnrLrvHplWdbB59W1YxenzeJBfAEsVlk5Ka
	k1mWWqRvl8CV8XyNY0ELe8XMC/UNjPtZuxg5OSQETCQe31vB1MXIxSEksJ1RoufHVjaIhIzE
	zoubgRIcQLawxOHDxRA1nxglzi9oAmtmE9CV+DLvMiOILSIgK3Fl2kNGkCJmgdWMEn83rmYF
	aRYWCJQ4+J0LpIZFQFWic+F9FhCbV8Be4svcXcwQu+Ql9h88C2ZzCuhL9Kx5yQRiCwnoSXz5
	+5wRol5Q4uTMJ2C9zED1zVtnM09gFJiFJDULSWoBI9MqRtHUguLc9NzkAkO94sTc4tK8dL3k
	/NxNjODQ1Qrawbhs/V+9Q4xMHIyHGCU4mJVEeJvDN6UJ8aYkVlalFuXHF5XmpBYfYpTmYFES
	51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MPULlLDX5sierbj6e/NGTY0XGxYyfSmy0vhaEC7C
	88X4pNDNio3Xj7xlDb3dH7N5X92Pi+zO/+vX1FmvsMhkff1q/9JLJ8SaLU6Y1U93Cq/zv6Ol
	NUP07DqmFYW5ORvtc3a4a/0Tq8uf6NJ9O/q6qezvpfXrp/3/6mb588Bip7wj9+sOHN+fOv/I
	DNaO6orrbDunXEjx5p243G6TYej7xP3TJbwWy+t+713IYlY4aU+YfkFJb0P9ljTWib09s6wY
	NW7LNYhcCDcyqlqexcAQZJzQFfiDS5f5VG/fY5fJSbJRTtbVIccdva8UaX98HSnEtCf93/HA
	+D62w26LGZd9S1mY1nPYcbfXLo7bP+1mK7EUZyQaajEXFScCAMuUMjnMAgAA
X-CMS-MailID: 20240807014803epcas1p30b08d972ecf1f9341bbf052d060c2900
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240807014803epcas1p30b08d972ecf1f9341bbf052d060c2900
References: <ZrKCkpr05sRN28nc@slm.duckdns.org>
	<CGME20240807014803epcas1p30b08d972ecf1f9341bbf052d060c2900@epcas1p3.samsung.com>


> -----Original Message-----
> From: Tejun Heo <htejun@gmail.com> On Behalf Of Tejun Heo
> Sent: Wednesday, August 7, 2024 5:08 AM
> 
> On Tue, Aug 06, 2024 at 02:12:09PM +0900, Sangmoon Kim wrote:
> > When we want to debug the workqueue stall, we can immediately make
> > a panic to get the information we want.
> >
> > In some systems, it may be necessary to quickly reboot the system to
> > escape from a workqueue lockup situation. In this case, we can control
> > the number of stall detections to generate panic.
> >
> > workqueue.panic_on_stall sets the number times of the stall to trigger
> > panic. 0 disables the panic on stall.
> >
> > Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
> 
> Appled to wq/for-6.12. Can you do a follow-up patch to document it in
> kernel-parameters?
> 
> Thanks.
> 
> --
> tejun

Okay. Let me prepare it.
Thanks

Sangmoon


Return-Path: <linux-kernel+bounces-205746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196838FFFBE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D5E288E9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D584515B96E;
	Fri,  7 Jun 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Qo806YPB"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C815B148
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753262; cv=none; b=rDHYOV6rKwvUVbAaBpwlRNYI3W+Uib0htzQbFt/Nc8CSgKhtwNS4odDznTYVFQvMWQwnZszZlSm0wzfye/8c2aubDE94qHehytXdzvyc/oZLVD3MTI/GbTe78M38maXI9fmH/5UICxspCuTeJvyRfMN5RvtQKW0Q6eKCjiDH1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753262; c=relaxed/simple;
	bh=vWwn6fNTvMlK4pId9dgBxn2n1khNlEr7ww85MkEHGS8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=QD+WUIAMNqLmaokyAJNw7MCXm8GLmZ6OiDCnXqNy5ktKIULNBod1Zpfy9Uvyvhijzlci3WVCrKNjJzb991BrRvDOMJJUmR+yt5l8sDgusdF9w206H6J+YUoUeok3q7Pz/omAG5wVMKFg34vUOZmX0uuf0mtzrDdeTKjaeEswNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Qo806YPB; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240607094058euoutp02a21d4dcb44468a5e9c64a5fd68ad251d~Wr3y74hvf2116021160euoutp02e
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:40:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240607094058euoutp02a21d4dcb44468a5e9c64a5fd68ad251d~Wr3y74hvf2116021160euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717753258;
	bh=IWBCTkTZYPMlXek+QLQnRtmei3pBxY66TSKRUwCX7y8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Qo806YPBBApPQSUUojUP0ElA8uFxl87EscLJQYzOLefki6qT/FaKyC3atk4EbwHb8
	 oruuA5dT+UJW/KPW0eGDiC0gQe6K6oG/W33GZmsTn9X1/QUD0bFleOuZqeLqlqx8bh
	 UzA66eHYnMhXXOxbIymQK21mqqvgGY1cCiMLPdi8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240607094058eucas1p2ddec8dec2da0a2ae46c33052d7041555~Wr3y1Ye_F0862708627eucas1p2D;
	Fri,  7 Jun 2024 09:40:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 97.D6.09875.9A5D2666; Fri,  7
	Jun 2024 10:40:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240607094057eucas1p262bd4506f596be24b2b007839e2ab57e~Wr3yW3bw30860708607eucas1p2I;
	Fri,  7 Jun 2024 09:40:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240607094057eusmtrp21988e5378a46975292758c82cdd44b70~Wr3yWLCAF0665006650eusmtrp2M;
	Fri,  7 Jun 2024 09:40:57 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-08-6662d5a99504
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.66.08810.9A5D2666; Fri,  7
	Jun 2024 10:40:57 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240607094057eusmtip2689723000433c216154645e2c28afa6e~Wr3yLqkRB1609616096eusmtip22;
	Fri,  7 Jun 2024 09:40:57 +0000 (GMT)
Received: from localhost (106.210.248.166) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 7 Jun 2024 10:40:56 +0100
Date: Fri, 7 Jun 2024 11:40:53 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
CC: Luis Chamberlain <mcgrof@kernel.org>, <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: Current state of the sysctl constification effort
Message-ID: <20240607094053.x3cmkhmrgaw6jqd3@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduznOd2VV5PSDH5vsLA4051rcXnXHDaL
	GxOeMlocejudzYHFY3bDRRaPTas62TxmL7nB4vF5k1wASxSXTUpqTmZZapG+XQJXxqv72gX3
	OCse3lzA3MD4j72LkZNDQsBEYkXvVOYuRi4OIYEVjBJNL6awgSSEBL4wSqx8GwmR+MwocaX7
	MVAHB1jHgZnZEPHljBLnmm+xQDQAFV2erQmR2MIosbVrFytIgkVARWLF8ydgU9kEdCTOv7nD
	DGKLCJhL3Dk4G8xmFsiVmHepG+wkYQE7iT0bloPZvAIOEss/9zJC2IISJ2c+YYGo15O4MRXk
	Ug4gW1pi+T8OiLC8RPNWiJGcAjYSM/bvYoP4Ulni1KppUHatxNpjZ9hB7pQQuMAhceHsKhaI
	hIvE6cO9rBC2sMSr41ugQSQj8X/nfCaIhsmMEvv/fYDqXs0osazxKxNElbVEy5UnUB2OEise
	LmeDBBefxI23ghDX8UlM2jadGSLMK9HRJjSBUWUWktdmIXltFsJrs5C8toCRZRWjeGppcW56
	arFRXmq5XnFibnFpXrpecn7uJkZgWjn97/iXHYzLX33UO8TIxMF4iFGCg1lJhNevOD5NiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoRTJaJg1Oqgcnfe+u3y1uLv09k
	UJ/k8/CWxUOLa0djv7GVBDJr9AXFWbk9nWIsqie6YqPDrPi0Aru3H25+qNl3g1n63XlBuXUm
	4mutV0RuND+kcuXY6UL12KLfcov3ax8+o7uQe8NnxyjJgJlnrp1reBZmHs3LIXDjW6zaulvr
	/y77+qewMoVp0ZTHu9dv+Xs7p/rnrdp6+e2sc0Oc8pav4jZdsKdNVmSpZ6qUdtRJ3pPr5V0j
	1rw9ffq4+Y1Nf3bN2vvDKe6a6bVco+wbQs+Z7Cau3Tc1MtrRLXZWYUbe/E88X6rTD2h1TLGo
	M3vl8e9B8SO/Ei2rEkfJXln+4r7Fy4w4X+XodIuZ/PB3UdBi+uNyd2VSZ6wSS3FGoqEWc1Fx
	IgAMSsWymgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7orryalGdz7IW1xpjvX4vKuOWwW
	NyY8ZbQ49HY6mwOLx+yGiywem1Z1snnMXnKDxePzJrkAlig9m6L80pJUhYz84hJbpWhDCyM9
	Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jFf3tQvucVY8vLmAuYHxH3sXIweHhICJ
	xIGZ2V2MXBxCAksZJaY2zWPtYuQEistIbPxyFcoWlvhzrYsNougjo8SLq80sEM4WRonfGy6x
	gVSxCKhIrHj+BMxmE9CROP/mDjOILSJgLnHn4Gwwm1kgV+LtiflgtrCAncSeDcvZQWxeAQeJ
	5Z97GSGG9jNK3Hk2hREiIShxcuYTFohmPYkbU6ewgZzNLCAtsfwfB0RYXqJ5K8R8TgEbiRn7
	d7FBXK0scWrVNCi7VuLV/d2MExhFZiGZOgvJ1FkIU2chmbqAkWUVo0hqaXFuem6xoV5xYm5x
	aV66XnJ+7iZGYNxtO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMLrVxyfJsSbklhZlVqUH19UmpNa
	fIjRFBhEE5mlRJPzgZGfVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TB
	KdXA5HmhPztv2teZto62zfktd/xNwkzZwuddD3G690BYwymO3bbMvnzhtGuqv1l0WZL+XJaO
	KHd9F+DgrMBYp3zsmve7m7uvGs60lNIPCDsqujb03/fu11sq0sTqO4w2rUmfYjk51WZuF6/3
	n28PM1Nu375ezXe+jbFzvv5vm4nyc4qiTrik3wiwMF4gPY+TtYLxDq/9Bb+2L092M2wrSpG3
	DTBKvj9N6dXXxyvCbH6ctDb+tXB5iGRTkQqPbPbZr5d/8/efYagzUzmn8O1HpVpS8xsj1d8z
	XFf/Cf1xO4v3x/owcdGApM3KLzUnnWzJKBY9v8vy+L4tcW5nrxi9/OmuxFAq6p2X/8ziB9eG
	l3VKLMUZiYZazEXFiQBop8OaRAMAAA==
X-CMS-MailID: 20240607094057eucas1p262bd4506f596be24b2b007839e2ab57e
X-Msg-Generator: CA
X-RootMTR: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2
References: <CGME20240531105042eucas1p1bcf3ee22d224c8d88aca633e5f01e0d2@eucas1p1.samsung.com>
	<7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>

On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> Hi Joel, Hi Luis,
> 
> most of the sysctl handler preparation patches have been picked up by
> the subsystem maintainers and are available in -next.
> 
> Only two are missing:
> 
> * utsname: constify ctl_table arguments of utility function [0]
> * sysctl: constify ctl_table arguments of utility function [1]
> 
> Both of them are going through the sysctl tree anyways.
> 
> With this done it should be possible to also queue up 
> sysctl: treewide: constify the ctl_table argument of handlers [2]
> for the bots to chew on in -next.
> 
> My local builds are still succeeding on the last submitted version of
> the patch.
> 
> 
> Thomas
> 
> [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net/
> [1] https://lore.kernel.org/lkml/20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com/
> [2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/

All this is coming together nicely. Is there anything left to do besides
what is being discussed in this mail, to start changing the ctl_tables
to `static const`?

Best

-- 

Joel Granados


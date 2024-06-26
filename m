Return-Path: <linux-kernel+bounces-230668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B95918037
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D317B283B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588E817FACE;
	Wed, 26 Jun 2024 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UhJ7Kj12"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFF16191A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402708; cv=none; b=g2NMxKC+PHHkjnITPRpo1N4M6ZhQa0iurhCkjqec8qsy4Rp+2OVIIF4DrQkrjLLrkOmkU7J5HHKgnlgEizA+zDqwgWCFy1j+f70JUzA1hQqxGdtdNjaaDh7D3dnr6Ef/l4Xjo4J496E9B9iP/4U0DnN5nDlLxWGA+26WL3ccegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402708; c=relaxed/simple;
	bh=k18fAcEbn65RP42MCFYhR0GqTJrkD9XGtc+51pdAhrc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=refxQSGYhU2HDqpL+Qrqc17qGix278BriUCKcXRvjDRN9gmLrKSVPsmVssSDzOnq7Tqedc+sh/KVc7KadW8W4/wudQclV2Nc2X7NyTXuscV1LOGawnfCQiSBG/1zazmH4HSIy4RDXcZnFcaTuo52nzChlukCoOdsbSy2XOl13Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UhJ7Kj12; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240626115142euoutp02d922707fca3549b2d68acf2ce0e6bb85~ci6XmQJQ51256912569euoutp02N
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:51:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240626115142euoutp02d922707fca3549b2d68acf2ce0e6bb85~ci6XmQJQ51256912569euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719402702;
	bh=Gup116Etv6fG5iPATTHumug5SYNCfIaRDyQkayHJmXI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UhJ7Kj12baKD6s3fZsmYPPX2DQ4zXCQbP2XVZm4xRKJqxBcv4zXMSTK1c/cLo8XsQ
	 qyazl5G5Dl7Ume650ij2e3YIIyJnlKvxTTVq87qoCA9X03iUNMuzVBGJL3u1cw4YOg
	 CYwgNibEs5SNVmxtWT1k0NJiXZ2/qUSGoGZLX/dI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240626115142eucas1p29c22141ea238938dd7aa31813e779af3~ci6XPuTN12504925049eucas1p2r;
	Wed, 26 Jun 2024 11:51:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 86.8E.09620.DC00C766; Wed, 26
	Jun 2024 12:51:41 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240626115141eucas1p2288e8d9e7385aad3627e97b6dca98446~ci6W6SeFq2560725607eucas1p25;
	Wed, 26 Jun 2024 11:51:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240626115141eusmtrp1aac1e56812e2870e0a94079177e07f3a~ci6W5rhXc1813418134eusmtrp1R;
	Wed, 26 Jun 2024 11:51:41 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-ce-667c00cd455e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.6E.08810.DC00C766; Wed, 26
	Jun 2024 12:51:41 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240626115141eusmtip13051a79315dab6f54c782d25d1c5e10d~ci6WuQgW00078300783eusmtip1K;
	Wed, 26 Jun 2024 11:51:41 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 26 Jun 2024 12:51:40 +0100
Date: Wed, 26 Jun 2024 13:51:34 +0200
From: Joel Granados <j.granados@samsung.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: Doug Anderson <dianders@chromium.org>, Jan Kiszka
	<jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: scripts/gdb: bring the "abspath" back
Message-ID: <20240626115134.fgkoocz6vlohmkpf@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQi2DSddEOk8v0wQQYsNC0DVXq5H_KUWrpWoH3Vgsfv3Q@mail.gmail.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7pnGWrSDKZOtLI4u+wgm8W9mzeZ
	LU51b2ayuLxrDpvFwwc3WB1YPWY3XGTx2LSqk81j+8lJTB6fN8kFsERx2aSk5mSWpRbp2yVw
	ZUxe8IS9YCt7xa+WOcwNjM9Yuxg5OSQETCR2/XzA1sXIxSEksIJRYumcS+wQzhdGic8rG1kg
	nM+MEp9W/GGEaTl84jcjRGI5o0Tf+hOscFXrZj2HcjYzSuzf8w1sC4uAqsSMXb1g7WwCOhLn
	39xhBrFFBLQk7iztAGtgFpjBKLFoxj+wBmEBJ4krT1aANfAKOEgcnDCPGcIWlDg58wnQURxA
	DZoS63fpQ5jSEsv/cYBUMAvISzRvnQ1WzSkQKLFuzyR2iKsVJb4uvscCYddKrD12BuxPCYEH
	HBIvF36AKnKRmP19MhOELSzx6vgWqLiMxOnJPSwQDZOBHvv3Aap7NaPEssavUB3WEi1XnkB1
	OErsWAsKCg4gm0/ixltBiOv4JCZtm84MEeaV6GgTmsCoMgvJZ7MQPpuF8NksJJ8tYGRZxSie
	Wlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZhoTv87/nUH44pXH/UOMTJxMB5ilOBgVhLhDS2p
	ShPiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQWgSTZeLglGpgMu672Xz7
	1G4GhUhVhnBNyQyPD9c/LufIFt/j21m1I03RQjn1zM5b//Q+NIlE+nkKLK68/9Xyf9XSkp2G
	d+d19p2urdla8uqb3fT9GswvZtW6XjTcdmee7EmHVAGxT5trRX+8Kfgg8qdoiSL31dqEZN4d
	1bPESwXv2nTkHH/E/UxGpqJ+DVOX5hIWIcWb/BPiszpXnFkQccrpT676XJ5ipoQNK+PXHO1g
	1txUNGeWjP5XbX/RlZlGCZ84j1fzbnm3NDC/++nEguMcCrkvow77N+/P81ZinNi+zcE+k/9t
	UGBI88uZQXy7TlfzlE23PSEpm6gyd7NK1YlkudITF6M+MR774H23Y41g7qVEI0UlluKMREMt
	5qLiRADTYWoqowMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7pnGWrSDC68UrY4u+wgm8W9mzeZ
	LU51b2ayuLxrDpvFwwc3WB1YPWY3XGTx2LSqk81j+8lJTB6fN8kFsETp2RTll5akKmTkF5fY
	KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZUxe8IS9YCt7xa+WOcwNjM9Y
	uxg5OSQETCQOn/jN2MXIxSEksJRRou32NKiEjMTGL1ehbGGJP9e62EBsIYGPjBLHXqVDNGxm
	lFh3ZB1YEYuAqsSMXb2MIDabgI7E+Td3mEFsEQEtiTtLO1hBGpgFZjBKLJrxD6xBWMBJ4sqT
	FWANvAIOEgcnzGOGmPqUSWL9/DlsEAlBiZMzn7B0MXIAdWtKrN+lD2FKSyz/xwFSwSwgL9G8
	dTbYLk6BQIl1eyaxQxytKPF18T0WCLtW4tX93YwTGEVmIRk6C2HoLIShs5AMXcDIsopRJLW0
	ODc9t9hQrzgxt7g0L10vOT93EyMwBrcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4Q0tqUoT4k1J
	rKxKLcqPLyrNSS0+xGgKDKGJzFKiyfnAJJBXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliS
	mp2aWpBaBNPHxMEp1cCUarzcLfJEv3plVLPrh+CGMCYNtTNB5SKqR7bPu7fmV5v9BScJq6Rj
	Icfaz2TlG6RNiyzYeWK2cdgTq3Pp8isrVV6usn3o8PHFvKS8efYzg1fkZ7vf3Nb64eTUb8nT
	CwOZHBMPbLeaV73ddOblv48eJO+9tf/Z+jdsvhseFzm82lz6VCbhxSMD0+Ot23UF7iw/1thy
	QWS++vSKvfeXiNVaVq6IiK6a3jbzRNyJj4cF9S6+8ttYV8LZm5widPWxwCWJU//M/EKn2qrO
	bzr1cIfj4ddr7i64M93umoFiQTP7uycP4pSlFjDeDlnXN/k2U2lt6LmemXftV8hP5r/38ODH
	OI4w2QsanzJeNf0/bDn9pxJLcUaioRZzUXEiAA1b55JKAwAA
X-CMS-MailID: 20240626115141eucas1p2288e8d9e7385aad3627e97b6dca98446
X-Msg-Generator: CA
X-RootMTR: 20240620215200eucas1p1ec09426a22ba26b3ce5ee0a949ad3c9f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240620215200eucas1p1ec09426a22ba26b3ce5ee0a949ad3c9f
References: <20240620-jag-fix_gdb_py_symlinks-v1-1-36a0f0217fbf@samsung.com>
	<CGME20240620215200eucas1p1ec09426a22ba26b3ce5ee0a949ad3c9f@eucas1p1.samsung.com>
	<CAD=FV=U3=d91J+Jw50=xKexhyKYjUQQ_WXQ_UdOTZeou4_=n3A@mail.gmail.com>
	<20240621101824.bzuupiqctfoeyqfh@joelS2.panther.com>
	<CAK7LNAQi2DSddEOk8v0wQQYsNC0DVXq5H_KUWrpWoH3Vgsfv3Q@mail.gmail.com>

On Wed, Jun 26, 2024 at 12:08:15AM +0900, Masahiro Yamada wrote:
> On Mon, Jun 24, 2024 at 3:20 PM Joel Granados <j.granados@samsung.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 02:51:41PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Thu, Jun 20, 2024 at 12:48 PM Joel Granados via B4 Relay
> > > <devnull+j.granados.samsung.com@kernel.org> wrote:
> > > >
> > > > From: Joel Granados <j.granados@samsung.com>
> > > >
> > > > Use the "abspath" call when symlinking the gdb python scripts in
> > > > scripts/gdb/linux. This call is needed to avoid broken links when
> > > > running the scripts_gdb target on a different build directory
> > > > (O=builddir).
> 
> For preciseness, please rephrase it to something like this:
> 
>  running the scripts_gdb target on a build directory located
>  directly under the source tree (e.g., O=builddir).
I'll add this to a V2. Thx for the feedback

Best

-- 

Joel Granados


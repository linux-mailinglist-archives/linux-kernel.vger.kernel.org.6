Return-Path: <linux-kernel+bounces-226711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDFB91429F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F281F213E8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9622067;
	Mon, 24 Jun 2024 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZWWBXKgz"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8351224D1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210009; cv=none; b=KkRen7uDdb0RzK2hXgCrKjjCKvvq89M8tI+1e/xIEc734W4Xp95cm4PNUc2tOW5FPahUaty2az4GuJHi7ZPPVad92g0JRr2cYdcrmujUoka+6iq5vhy2bhB5Qv1tABGYC7XRLwntbTf4tbrOpWJYKG7mJUHBBbHO1pGGvReXRcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210009; c=relaxed/simple;
	bh=dc114DBr0hp3/V/MvPnKV+46r+FSgtDxvicsYQlctL8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=MFQvHTCjl2VTFvM54hEFjiS/leKXcq0EEqp+PGIDsO5ZYi+idbIGOijgUFFmEoH0tXrAH63+t5z0S2EHGZt8jFG7LzhmVMklq4+bOH/TgVNyZRSdVQhjhHDK8YELvoYUcz+sQ/n38qYNbWk4f799c8vTIo+0+zGEDwzbvJniOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZWWBXKgz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240624061959euoutp01814befc302731b0937be7ede527903f2~b3GLHOhQA1372213722euoutp01Y
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:19:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240624061959euoutp01814befc302731b0937be7ede527903f2~b3GLHOhQA1372213722euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719209999;
	bh=PkrcwCTjaVnaGseSmaW6RB9ORmAgpdfIlDVHsVALsl8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZWWBXKgzDufnFxqeP2Xr7FVPqbEMZCNKi8x7fU8oVG3AtDa02hw4vUShdwIA7/oTb
	 fTTW6uZ89ZbASCTBWS5/jW0JlaN7+LhPq27GUW+inIRC0fr+LVS9wJHtHF7LuBT3OZ
	 kqa4JBRQydnOLS/cFXon8kKa3uBs5YENHOZ8L9z4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240624061959eucas1p210874972e0651e08ead73d6b8494e75a~b3GLCbWuZ1452814528eucas1p2r;
	Mon, 24 Jun 2024 06:19:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D0.5B.09875.F0019766; Mon, 24
	Jun 2024 07:19:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240624061959eucas1p2d7fe7d5a4b68fc349ce134504c76e8b1~b3GKx6Woz2046420464eucas1p2t;
	Mon, 24 Jun 2024 06:19:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240624061959eusmtrp1de03f85c2da0765d25e57bb2436fcc21~b3GKxWbA82621926219eusmtrp1c;
	Mon, 24 Jun 2024 06:19:59 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-55-6679100f67d4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 48.FE.08810.F0019766; Mon, 24
	Jun 2024 07:19:59 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240624061958eusmtip1542965ea45b4bdeef07ab2aae643611e~b3GKi9IK72380423804eusmtip19;
	Mon, 24 Jun 2024 06:19:58 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 24 Jun 2024 07:19:58 +0100
Date: Fri, 21 Jun 2024 12:18:24 +0200
From: Joel Granados <j.granados@samsung.com>
To: Doug Anderson <dianders@chromium.org>
CC: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham
	<kbingham@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: scripts/gdb: bring the "abspath" back
Message-ID: <20240621101824.bzuupiqctfoeyqfh@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=U3=d91J+Jw50=xKexhyKYjUQQ_WXQ_UdOTZeou4_=n3A@mail.gmail.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduznOV1+gco0g1PvJC3OLjvIZnHv5k1m
	i1Pdm5ksLu+aw2bx8MENVgdWj9kNF1k8Nq3qZPPYfnISk8fnTXIBLFFcNimpOZllqUX6dglc
	GX9fT2MteMlecXv/D+YGxgVsXYycHBICJhI7pk5j72Lk4hASWMEo8WD1N0YI5wujxPmlL6Ey
	nxklrl79xATT8vbLT6iq5YwSq+c/ZISr2rjhDRuEs5lR4uKhn0D9HBwsAqoS29qiQLrZBHQk
	zr+5wwxiiwhoSjxreMkMUs8sMJNR4vnHNrCEsICTxJUnKxhBbF4BB4kJe+eyQ9iCEidnPmEB
	mckM1Lx+lz6EKS2x/B8HSAWzgLxE89bZYFM4BQIlbh++zAJxtKLE18X3oOxaibXHzoB9JiFw
	h0Pi9YVfrBAJF4nzs2AahCVeHd/CDmHLSJye3MMC0TCZUWL/vw9Q3asZJZY1foWGi7VEy5Un
	UB2OEjvWPmcFuU5CgE/ixltBiOv4JCZtm84MEeaV6GgTmsCoMgvJZ7MQPpuF8NksJJ8tYGRZ
	xSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZhmTv87/mUH4/JXH/UOMTJxMB5ilOBgVhLh
	nV5flibEm5JYWZValB9fVJqTWnyIUZqDRUmcVzVFPlVIID2xJDU7NbUgtQgmy8TBKdXA5JPt
	UzDhwAqNiU8vrV0eckSQe/cm1cAF/4rKlPY6nzx15nTpwdOvX2k7f23nlhaqPrJS5kXq6wNV
	K4tO/D9fOXkd7/N/Uz7MuVx/JGzZ5wuZXJ495+4Xz990bIJgp+PT/niNdx8eGoRdfynIILJS
	1zDk699nBr0vz0z6ILD/0Mt7TFGOD07USDNe5Lkmv0Bs87yLxwP8eLmto/qcv+vfbvLglD4l
	Yr8o/PmcS6/XB68/m12p+DatpGDqvd8ma+vDSn493sS0/Z2Aj+6cjf7X83orb55fcTuZM+D1
	i4CvpWpfH6/TXt/7KSZkVvxZ9noG3pW/K8+Xzs1g0eg/c+Tln/c8ynJe3TN3HGhq/WJw+cJ9
	JZbijERDLeai4kQAFGbVE6IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7r8ApVpBvt6WC3OLjvIZnHv5k1m
	i1Pdm5ksLu+aw2bx8MENVgdWj9kNF1k8Nq3qZPPYfnISk8fnTXIBLFF6NkX5pSWpChn5xSW2
	StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX9fT2MteMlecXv/D+YGxgVs
	XYycHBICJhJvv/xk7GLk4hASWMoo8enTd6iEjMTGL1dZIWxhiT/Xutggij4ySsy6c4IdwtnM
	KNF15QlTFyMHB4uAqsS2tiiQBjYBHYnzb+4wg9giApoSzxpeMoPUMwtMZ5T49ncBWEJYwEni
	ypMVjCA2r4CDxIS9c6GGPmeUmNp6jAkiIShxcuYTFpAFzECT1u/ShzClJZb/4wCpYBaQl2je
	OhtsJKdAoMTtw5dZII5WlPi6+B6UXSvx6v5uxgmMIrOQDJ2FMHQWwtBZSIYuYGRZxSiSWlqc
	m55bbKhXnJhbXJqXrpecn7uJERiD24793LyDcd6rj3qHGJk4GA8xSnAwK4nwTq8vSxPiTUms
	rEotyo8vKs1JLT7EaAoMoInMUqLJ+cAkkFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKa
	nZpakFoE08fEwSnVwLTluydrzsZ2Gw3N+y1SMrwVBr2163cd/hbwy2jmyc6wgKMsMrMyYmwX
	86tFlX8Ve5HsGfOt2zdv5TSr24qe9R7m6dO5tHfVvZGfdZ/ByKvw0sKDYpXbDD7+CrvrbXmW
	ZdY/l939Ene0j9bNuHz07JXgvMVHb4uXV8qXr10tVqZqxLL0VIH3lU1OvAznM+st3opysqzp
	CK74JrOLe4kn1/roc/9suS2/nVzRqaARs8Lk6AauczZbpz04l/e6tf5NS5z07k2Va3+9dDXT
	fCln9dDr4KealGbBn2xhusw3zBfWLFHie2T1eX+I1UQP/gWX1z2awminuqRj6qPi2pv+Dv2B
	CvapEZrCyx8x3py2RYmlOCPRUIu5qDgRAAtMr6NKAwAA
X-CMS-MailID: 20240624061959eucas1p2d7fe7d5a4b68fc349ce134504c76e8b1
X-Msg-Generator: CA
X-RootMTR: 20240620215200eucas1p1ec09426a22ba26b3ce5ee0a949ad3c9f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240620215200eucas1p1ec09426a22ba26b3ce5ee0a949ad3c9f
References: <20240620-jag-fix_gdb_py_symlinks-v1-1-36a0f0217fbf@samsung.com>
	<CGME20240620215200eucas1p1ec09426a22ba26b3ce5ee0a949ad3c9f@eucas1p1.samsung.com>
	<CAD=FV=U3=d91J+Jw50=xKexhyKYjUQQ_WXQ_UdOTZeou4_=n3A@mail.gmail.com>

On Thu, Jun 20, 2024 at 02:51:41PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 20, 2024 at 12:48 PM Joel Granados via B4 Relay
> <devnull+j.granados.samsung.com@kernel.org> wrote:
> >
> > From: Joel Granados <j.granados@samsung.com>
> >
> > Use the "abspath" call when symlinking the gdb python scripts in
> > scripts/gdb/linux. This call is needed to avoid broken links when
> > running the scripts_gdb target on a different build directory
> > (O=builddir).
> >
> > Fixes: 659bbf7e1b08 ("kbuild: scripts/gdb: Replace missed $(srctree)/$(src) w/ $(src)")
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  scripts/gdb/linux/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Ah, good call. Yeah, this makes sense to me and also seems to produce
> reasonable symlinks. Sorry for not coming up with this originally.
No worries. Please tell me if you need me to do something else to
upstream this 

Best

-- 

Joel Granados


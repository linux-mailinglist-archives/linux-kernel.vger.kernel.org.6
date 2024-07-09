Return-Path: <linux-kernel+bounces-245728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579092B863
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C8FB20BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213F155744;
	Tue,  9 Jul 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HGVygQy4"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15255E4C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524937; cv=none; b=gsBkypu7aCX2p7DWPuXo4watbMCzQgcHdZC0XFF6uj7q5q9eLS3wY+tPd0t8IaOubcl1NMXVii6yk1gjawj79X2xz+eHreAegAxrV3V+iuft4JeES9t5tXgsmd1/YS2UOMLOYheeT3pNLvajm8tPboAFgx0LZCnsd5+/NIKcGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524937; c=relaxed/simple;
	bh=MN8tQlU/WjfJAm5vJUB/k6Sbg2NBCUv0pDcfrVCj4T0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=rmPLlys+TszfdbtZYM7ngELtyCVd/D9BvItt+EeKVEKiJsDqeAG61YaYkuqRuFH27+flcgnwJBtIsJ1VKNPnGeiSw3Tt+pz/KV1V50q90rnLbYLapD1nk9SdJF3rs3AuIT0u3dgj05v06h2fpNAvhvtEU1keKZVLJDTxNy/GTL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HGVygQy4; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240709113532epoutp04113d442178dfa9672a231ffafdb97789~giE9gK4Cx1199611996epoutp04l
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 11:35:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240709113532epoutp04113d442178dfa9672a231ffafdb97789~giE9gK4Cx1199611996epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720524932;
	bh=1/vAaKQvg/yK38AxX7tzEigXwlhSdwGh+WKBfS50Va0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HGVygQy4shpvOpMMxlQwY82C0LZ5854xzqS64pnx+dAEO8/3aconBI8FRsDRjvt9B
	 Xx+zpMeTX1Uzh8InF7ZA4RzvQPm3XCFppptA9FGZ0XECx1/mcGfrNzYeveD0puQSAQ
	 HOnF07gi3BO1ZMa2eGDOHDZ3TAL1ZiPV4a1/jzYY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240709113531epcas1p44ff51bb93c0ef9c60bddbb4c2a0272ac~giE9EbOps0486104861epcas1p45;
	Tue,  9 Jul 2024 11:35:31 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WJJnv1zSQz4x9Py; Tue,  9 Jul
	2024 11:35:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	FC.78.09847.3802D866; Tue,  9 Jul 2024 20:35:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240709113530epcas1p493461714f6a520e29ba42d132c0b4af1~giE8H_ZWT0486104861epcas1p44;
	Tue,  9 Jul 2024 11:35:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240709113530epsmtrp2aafe2cecd213d687aebf67bfb37ea3c8~giE8HQrJu2310623106epsmtrp2_;
	Tue,  9 Jul 2024 11:35:30 +0000 (GMT)
X-AuditID: b6c32a36-60dff70000002677-1e-668d20832a40
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C8.44.29940.2802D866; Tue,  9 Jul 2024 20:35:30 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240709113530epsmtip2bb740741224e63ca19c26fb3e3dbf6c9~giE76K2Fp3215932159epsmtip2g;
	Tue,  9 Jul 2024 11:35:30 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'OGAWA Hirofumi'" <hirofumi@mail.parknet.co.jp>
Cc: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<sj1557.seo@samsung.com>
In-Reply-To: <87bk37t3zl.fsf@mail.parknet.co.jp>
Subject: RE: [PATCH] fat: print s_dev via fat_msg
Date: Tue, 9 Jul 2024 20:35:30 +0900
Message-ID: <0c5c01dad1f4$1a46bd80$4ed43880$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHwcbNQtGVXTyWTefViKeJrDA01VgFnFHFwAi3Zi2MBwlUF6QGrmzuusYrholA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmnm6zQm+awd8eDos569ewWUyfu4HF
	4vKuOWwWW/4dYXVg8Tgx4zeLx/23iR59W1YxenzeJBfAEtXAaJNYlJyRWZaqkJqXnJ+SmZdu
	qxQa4qZroaSQkV9cYqsUbWhopGdoYK5nZGSkZ2oUa2VkqqSQl5ibaqtUoQvVq6RQlFwAVJtb
	WQw0ICdVDyquV5yal+KQlV8KcqZecWJucWleul5yfq6SQlliTinQCCX9hG+MGVsOaRQ84KnY
	P3sRawNjC1cXIyeHhICJRM+ClexdjFwcQgI7GCVuL2pkhnA+MUq0fumDynxjlNjTsJ6ti5ED
	rKX3DBtEfC+jxOOp3YwQzktGiZl/v7CCzGUT0JV4cuMnM4gtAtTw8yLIDk4OZoFoiZ2LDrKB
	2JwCBhLP/t1hArGFBQwlTvc1gdksAioS1yZ+BuvlFbCUuPLhGQuELShxcuYTFog58hLb385h
	hvhBQWL3p6OsIMeJCPhJTGnIgCgRkZjd2Qb2jYTAV3aJzgN9UPUuEid3r2SDsIUlXh3fwg5h
	S0l8freXDaKhm1Hi+Md3LBCJGYwSSzocIGx7iebWZnBIMAtoSqzfpQ+xjE/i3dceVogSQYnT
	17qZIYHFK9HRJgQRVpH4/mEnC8yqKz+uMk1gVJqF5LNZSD6bheSFWQjLFjCyrGIUSy0ozk1P
	LTYsMEKO7k2M4CSqZbaDcdLbD3qHGJk4GA8xSnAwK4nwzr/RnSbEm5JYWZValB9fVJqTWnyI
	MRkY1hOZpUST84FpPK8k3tDMzNLC0sjE0NjM0JCwsImlgYmZkYmFsaWxmZI475krZalCAumJ
	JanZqakFqUUwW5g4OKUamBSfpEmVxPP8Lrt0w77hE++FXs5muVeLnV7cK5149xx/YNmNV/JN
	gfOaSu6vC1oSmstefG/6I8OOprbtx0+9S2J/sV1rkvJWOe3Wp8oMhZttf72ISDPp4N/2jGvf
	DB6G5DuTTm66JPdif9ShO5HzHqilRZve/nk3c47TGSPJ6QpVLFc3B38Pb3/mclF8j1ukv6On
	yVW+OLX8OUkHT3VsXeSW09sTVXt8ZtCVohf7dQ69P8O5sPT4pZ5DbiVbmOsOexf9m6VTJjRh
	rtMusVmVxz2et+RZxT089PWYRf6ztZt635vJz3kyxf7V0t/sShK3DQ2rLk295tWbGPiiYQuP
	1eXdXx2dnuc9uHsjbMGjb/OVWIozEg21mIuKEwEuvB5tWQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvG6TQm+awfEuRYs569ewWUyfu4HF
	4vKuOWwWW/4dYXVg8Tgx4zeLx/23iR59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CVseWQRsED
	nor9sxexNjC2cHUxcnBICJhI9J5h62Lk4hAS2M0ose3RfFaIuJTEwX2aEKawxOHDxRAlzxkl
	Fs1Yx97FyMnBJqAr8eTGT2YQWwRozM+LK8HizAKxEtv/voSa2cokcebOWlaQBKeAgcSzf3eY
	QGxhAUOJ031NYDaLgIrEtYmfwQbxClhKXPnwjAXCFpQ4OfMJC8gRzAJ6Em0bGSHmy0tsfzsH
	rFxCQEFi96ejYCeLCPhJTGnIgCgRkZjd2cY8gVF4FpJBsxAGzUIyaBaSjgWMLKsYJVMLinPT
	c4sNCwzzUsv1ihNzi0vz0vWS83M3MYIjQ0tzB+P2VR/0DjEycTAeYpTgYFYS4Z1/oztNiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA9OaeXfaxdvylJfn
	x0pcOZsbMkHMa0tRqcIkO4V5R05ovxVkza97KZ9pkbY16VpDMZfpuwyXmZxmaoynwye4qglF
	TFylHHAiorSp0P10st7mfbP/y8/6uue7unloZ/uF23u/TtcMW2/wZ33ocv9TqpNenlqh8SPA
	6em5zfMnLpDd8Yq9bsG/npTiSf1Oyj++ceVy1EY87lZx2Cb7cX/sBb25dXzRNw6aPZkue7CA
	+8Hnzf9b7v7VPTk92HYbN/ftab9ya7f9epunsXzXkhNXJ0my9Se7KP9tjprnGBTw/PuMV8I/
	m27N3j9nydYLcvlB615z2zYfPNjRmH0n79u9lf/rYxdkTYz/KPO5N+1zkOVNJZbijERDLeai
	4kQAC6Lv4PsCAAA=
X-CMS-MailID: 20240709113530epcas1p493461714f6a520e29ba42d132c0b4af1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8
References: <CGME20240709041754epcas1p4ee6f7b1fd0dbf287e756b709aba321c8@epcas1p4.samsung.com>
	<20240709041734.3719513-1-sj1557.seo@samsung.com>
	<87frsjt9i2.fsf@mail.parknet.co.jp>
	<000001dad1ca$6b61c720$42255560$@samsung.com>
	<87bk37t3zl.fsf@mail.parknet.co.jp>

> "Sungjong Seo" <sj1557.seo@samsung.com> writes:
> 
> >> Sungjong Seo <sj1557.seo@samsung.com> writes:
> >>
> >> > To clarify MAJOR/MINOR number of a mounted device, fat_msg prints
> prefix
> >> > that includes them.
> >>
> >> Hm, why do we need the major/minor (why can't use sysfs to resolve if
> >> need), and why do you care only fat?
> >> Thanks.
> > You're right, if you can access to sysfs on a system, this might not
> > be useful. However, when analyzing problems based on logs, s_dev can be
> > very helpful for identifying devices. This is because, in systems like
> > Android, a filesystem gets mounted on a device node with a nickname
> > like public:179,1.
> >
> > I think it would be really useful if applied to representative
> filesystems
> > for removable storage devices such as fat and exfat. So I will send the
> > similar PR to exfat as well.
> 
> So this is for the naming policy like android?
Yes, but I think it is just one of examples.
>
> And why don't you care the other places (like vfs) that using ->s_id?
Because, I think it's enough to change fat-fs and exfat-fs.
> 
> Because I dislike to use the inconsitent stuff, some logs are "sda3" and
> some logs are "sda3[8:3]".
Do you mean consistency between all logs under Linux VFS?
If so, I think it's meaningless. As mentioned above, this patch
helps analyze removable storage devices, so it would be nice if it could
be applied to both fat-fs and exfat-fs.

Anyway, this is just my opinion and I think you might have a different one.
Thanks!
> 
> Thanks.
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



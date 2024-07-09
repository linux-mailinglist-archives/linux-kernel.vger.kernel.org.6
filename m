Return-Path: <linux-kernel+bounces-245259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F092B050
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDB51F24360
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A5146D6D;
	Tue,  9 Jul 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tfrzhTFi"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84A14373F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507040; cv=none; b=rIS3vytyo1OHD8eExJDA9FLtNAhyq7AWNxnHEPwnu84i0fBSV2dinVugfBFwUNOpy7QOtW/fui5w881VbULQNNvC9zEFJg33dD2qucSw/f5KFu5SQOhmHAsvNUkD8hzc2/0ejWPliWv4RACoNpDFZE80kIrE046CoOf6taYAu7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507040; c=relaxed/simple;
	bh=5SyPpb+HoHoBqDqxokN+nPWnLtHVbrHSH28b9s1U/1Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=bnnvnKaGSmcg3iyPftEwMPyclnLDlG0APKJHgdPF2B6V6mhusua6A04h0hX4KdGYiMY+0E8QSf0QxVliclbYqK7akHzm18ijnATYpar5TjXksKyTWtXGmjsIPXJF7favOTayxwk7sUaxaQdcz+4dxB5oBobngspUykmQhURgoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=tfrzhTFi; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240709063708epoutp03537dac00cfa390632fbcbd782c9e2f84~geAbz_yw12473724737epoutp03S
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:37:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240709063708epoutp03537dac00cfa390632fbcbd782c9e2f84~geAbz_yw12473724737epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720507028;
	bh=m/niC4qzjSHAZBJj6OiNoLKgIvp+ar4rnIrMn+sgUL0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=tfrzhTFiMiDUyZZQroc4OWZKL9AmW3uyW9gkrDwCn8LuS6Vk/5NbJwPkiEyFFTjqy
	 2Mou2Q5TqXA9WM2/ljpoUVqtd8wKov1Itp7tpdjAnXWblkS2J6hYhRdAQo+kzRyEUT
	 29V3nLjIMv/LFIbn7guDt6FUk5dFwuiyxEms7PLY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240709063708epcas1p1d0cdd12eb23bc02bde9fcd8cdb064bc7~geAbjh7rO0492004920epcas1p1q;
	Tue,  9 Jul 2024 06:37:08 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.222]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WJB9c1kLXz4x9Pq; Tue,  9 Jul
	2024 06:37:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	25.02.08602.49ADC866; Tue,  9 Jul 2024 15:37:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240709063707epcas1p3d36cc5c225a195dd9190d74367227b80~geAa2uD8X1209912099epcas1p3s;
	Tue,  9 Jul 2024 06:37:07 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240709063707epsmtrp2ba900e18ae336a66ac0814af754e9f45~geAa2CqRI1456314563epsmtrp2e;
	Tue,  9 Jul 2024 06:37:07 +0000 (GMT)
X-AuditID: b6c32a33-c9f8da800000219a-ee-668cda94291b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	66.34.18846.39ADC866; Tue,  9 Jul 2024 15:37:07 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240709063707epsmtip116d97b40776d31c9d14be51182116f81~geAanTJbj0318103181epsmtip1s;
	Tue,  9 Jul 2024 06:37:07 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'OGAWA Hirofumi'" <hirofumi@mail.parknet.co.jp>
Cc: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<sj1557.seo@samsung.com>
In-Reply-To: <87frsjt9i2.fsf@mail.parknet.co.jp>
Subject: RE: [PATCH] fat: print s_dev via fat_msg
Date: Tue, 9 Jul 2024 15:37:07 +0900
Message-ID: <000001dad1ca$6b61c720$42255560$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHwcbNQtGVXTyWTefViKeJrDA01VgFnFHFwAi3Zi2OxpfoPwA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmge6UWz1pBnvucVjMWb+GzWL63A0s
	Fpd3zWGz2PLvCKsDi8eJGb9ZPO6/TfTo27KK0ePzJrkAlqgGRpvEouSMzLJUhdS85PyUzLx0
	W6XQEDddCyWFjPziElulaENDIz1DA3M9IyMjPVOjWCsjUyWFvMTcVFulCl2oXiWFouQCoNrc
	ymKgATmpelBxveLUvBSHrPxSkDP1ihNzi0vz0vWS83OVFMoSc0qBRijpJ3xjzJjVwlPwSKhi
	a2sXYwPjX74uRk4OCQETib71d5hBbCGBHYwSy1ZJQNifGCUW9lnA2c2fjGHq9y5bygYR38ko
	8WpNBoT9klFi/UMbEJtNQFfiyY2fYDNFgOp/XlzJDmIzC0RL7Fx0EKyXU8BA4u7T1UwgtrCA
	ocTpviYwm0VAReLZq9tgvbwClhLHHvSwQtiCEidnPmGBmCMvsf3tHGaIexQkdn86ygqxy0ni
	9uPzjBA1IhKzO9ugat6yS7Qd54GwXSS2b1vNBmELS7w6voUdwpaS+PxuL1CcC8juZpQ4/vEd
	C0RiBqPEkg4HCNteorm1GaiIA2iBpsT6XfoQu/gk3n2FuFMC6M7T17qZQUokBHglOtqEIMIq
	Et8/7GSBWXXlx1WmCYxKs5B8NgvJZ7OQfDALYdkCRpZVjGKpBcW56anJhgWGyFG9iRGcPLWM
	dzBenv9P7xAjEwfjIUYJDmYlEd75N7rThHhTEiurUovy44tKc1KLDzEmA8N6IrOUaHI+MH3n
	lcQbmplZWlgamRgamxkaEhY2sTQwMTMysTC2NDZTEuc9c6UsVUggPbEkNTs1tSC1CGYLEwen
	VAOT9s+cJeEuQbu0H3a3LOOstp5rydstMFu58JOlH8u9W+Zs0VlRGZcNJ06tucy1e6dEBJPi
	606+ufp5rU2yMbYsOf+mH6pSO/ZTQ6n6Ygdr20P9X7ekHjhU6b88YWcydWP2kqlrTLgtV8pv
	LZ0qbvfl22SuHamerw6m/gz303t+7IjOvAs7eezYvmeEZZWLHtfeJmJ5XaWf1f72s1p15kXT
	LctDJs199o6TOdTqwL+1xQuXeTWmtM0rXTXxiETTCtVmC+4dBfeW7bb8vWDfF9F1HMxVj8K1
	9Y7KTJmd/FnDr5RZIM5ng1A2x/91J8NWRjAbR9hMWDSdp9NGbtXf/3c33z6tefh1n+G+rSpm
	k+yVWIozEg21mIuKEwFqUAOJVQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnO7kWz1pBvt/aVvMWb+GzWL63A0s
	Fpd3zWGz2PLvCKsDi8eJGb9ZPO6/TfTo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujFktPAWP
	hCq2tnYxNjD+5eti5OSQEDCR2LtsKVsXIxeHkMB2RolzL9uBHA6ghJTEwX2aEKawxOHDxSDl
	QgLPGSUmtnCB2GwCuhJPbvxkBrFFgMb8vLiSHcRmFoiV2P73JdTIzYwS/Uf+M4IkOAUMJO4+
	Xc0EYgsLGEqc7msCs1kEVCSevboNNohXwFLi2IMeVghbUOLkzCcsIDcwC+hJtG1khJgvL7H9
	7RxmiPMVJHZ/OsoKcYOTxO3H56FqRCRmd7YxT2AUnoVk0iyESbOQTJqFpGMBI8sqRtHUguLc
	9NzkAkO94sTc4tK8dL3k/NxNjOCY0Arawbhs/V+9Q4xMHIyHGCU4mJVEeOff6E4T4k1JrKxK
	LcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi4JRqYJq2INvYb/PJXXqVsZU6
	C5q9RB7Jm2f+kPIy6fx3ae6izr03fr+yVVzxQ6b6/MGqJ5POvX638pvWKv42uaOc6Q0zsq48
	41/Q9PDoLJs1ORxWhp51gkpJ/7LCVopZmTNunSthc5J566kTE5XP2Ml1/OfzvWXF9jwlbU3s
	d54f7lwC8+aFc2o/cysv7Xy4SMJ911MDgV0JCewee8vuML0Luno76KlV6tn1bGVdEeJsaddf
	Oj1inP4yvCKkvPNopJnuHHVnJnZD195Tf3QOr3K69mtV9cOCZL0s7djZwbt0IiXUm81CMnuu
	vr3IM2vzbZcPPs1HVJY9dprWt8pUNa0o+fDHQ2eYUsRXxWUuy096psRSnJFoqMVcVJwIANkc
	VFD4AgAA
X-CMS-MailID: 20240709063707epcas1p3d36cc5c225a195dd9190d74367227b80
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

> Sungjong Seo <sj1557.seo@samsung.com> writes:
> 
> > To clarify MAJOR/MINOR number of a mounted device, fat_msg prints prefix
> > that includes them.
> 
> Hm, why do we need the major/minor (why can't use sysfs to resolve if
> need), and why do you care only fat?
> Thanks.
You're right, if you can access to sysfs on a system, this might not
be useful. However, when analyzing problems based on logs, s_dev can be
very helpful for identifying devices. This is because, in systems like
Android, a filesystem gets mounted on a device node with a nickname
like public:179,1.

I think it would be really useful if applied to representative filesystems
for removable storage devices such as fat and exfat. So I will send the
similar PR to exfat as well.

Thanks.
> 
> > Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> > ---
> >  fs/fat/fat.h  | 2 +-
> >  fs/fat/misc.c | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fat/fat.h b/fs/fat/fat.h
> > index 66cf4778cf3b..538bcb3e28e1 100644
> > --- a/fs/fat/fat.h
> > +++ b/fs/fat/fat.h
> > @@ -435,7 +435,7 @@ void __fat_fs_error(struct super_block *sb, int
> report, const char *fmt, ...);
> >  #define fat_fs_error_ratelimit(sb, fmt, args...) \
> >  	__fat_fs_error(sb, __ratelimit(&MSDOS_SB(sb)->ratelimit), fmt , ##
> args)
> >
> > -#define FAT_PRINTK_PREFIX "%sFAT-fs (%s): "
> > +#define FAT_PRINTK_PREFIX "%sFAT-fs (%s[%d:%d]): "
> >  #define fat_msg(sb, level, fmt, args...)				\
> >  do {
\
> >  	printk_index_subsys_emit(FAT_PRINTK_PREFIX, level, fmt, ##args);\
> > diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> > index c7a2d27120ba..6672cefc5484 100644
> > --- a/fs/fat/misc.c
> > +++ b/fs/fat/misc.c
> > @@ -9,6 +9,7 @@
> >
> >  #include "fat.h"
> >  #include <linux/iversion.h>
> > +#include <linux/blkdev.h>
> >
> >  /*
> >   * fat_fs_error reports a file system problem that might indicate fa
> data
> > @@ -59,7 +60,8 @@ void _fat_msg(struct super_block *sb, const char
> *level, const char *fmt, ...)
> >  	va_start(args, fmt);
> >  	vaf.fmt = fmt;
> >  	vaf.va = &args;
> > -	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id, &vaf);
> > +	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id,
> > +		MAJOR(sb->s_dev), MINOR(sb->s_dev), &vaf);
> >  	va_end(args);
> >  }
> 
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



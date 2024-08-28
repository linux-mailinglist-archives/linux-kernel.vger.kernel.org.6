Return-Path: <linux-kernel+bounces-304512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23E96212F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751D3B2478F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738D158DC6;
	Wed, 28 Aug 2024 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cPw7N3q5"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19968158A33
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830444; cv=none; b=UjHfEtUCVYFw9ngrHAg2G/ALlMROUtYUFVKyNJNpu0hzKSvzaWsU88Z3/vieRujkEiIO1NLzw03XxTeDrCXg54ulMG2WXtHSFrXvZteDFlbijG/99fJFvVLppLXzlQyMlcU1M6Y9F+vVeaFw/OocxKb0VrzlLffeKfBcFzg5M0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830444; c=relaxed/simple;
	bh=otvnIfXHyfHnHH7Qu6ysQiK8zxlSfj54BaTYN5UUOZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=X1dYjli8MvqS/0gHg69/3FpuC/84koCPM+LFdrmsGaaW6OrYdclsXYH3byOi+XzZ5ynwob48VIQ22eq18aMnNgGioNIURcG5MJyOndQo0PmPnxSFgzRl7ERQs/Hdqt7W0ew9wsJtsQX7o1e0yLnNsuzraLWGPCYFi3YcXYs/lKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cPw7N3q5; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240828073358epoutp031fd5c59ca0d891311166ae952735c9df~v1CVKrP7I2664426644epoutp03B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:33:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240828073358epoutp031fd5c59ca0d891311166ae952735c9df~v1CVKrP7I2664426644epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724830438;
	bh=uDnEFHQI7uwzw/2OPKT6RO7BYiKFnaZwVEjT8s8ZdXE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=cPw7N3q5bKE9Hhaqyemnv6vDbfol8yqLjeSqJGxcfRT1vqsNZhFWuR7C2r2amjXb7
	 631RZS3skLeQvNyecov3DDzOVmbo0xww5KYXUX40rTHKUlyKewuC0Wn2Wo/8pBvW15
	 2XP7n5SVgtMCHERBYq06ttReqk+hZqb9+PRxYcnA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240828073358epcas5p1fe99baf26266981f31e280d9f83d455c~v1CUmadcP2848528485epcas5p1s;
	Wed, 28 Aug 2024 07:33:58 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wtx450GdJz4x9Pw; Wed, 28 Aug
	2024 07:33:57 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	63.46.19863.4E2DEC66; Wed, 28 Aug 2024 16:33:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37~v0plxhGJy1043310433epcas5p22;
	Wed, 28 Aug 2024 07:05:38 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240828070538epsmtrp29db64b1e65691884db50d9fd46ff1de1~v0plwqioL2427224272epsmtrp2N;
	Wed, 28 Aug 2024 07:05:38 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-5b-66ced2e46bad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A3.66.19367.24CCEC66; Wed, 28 Aug 2024 16:05:38 +0900 (KST)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240828070533epsmtip18c5f65f31b248013ebfa42f9a1f86d35~v0phUECwF0315803158epsmtip1Y;
	Wed, 28 Aug 2024 07:05:33 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
	royluo@google.com, paul@crapouillou.net, elder@kernel.org,
	yuanlinyu@hihonor.com, quic_kriskura@quicinc.com, crwulff@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	Selvarasu Ganesan <selvarasu.g@samsung.com>, stable <stable@kernel.org>
Subject: [PATCH] usb: gadget: udc: Add null pointer check for udc in
 gadget_match_driver
Date: Wed, 28 Aug 2024 12:35:04 +0530
Message-ID: <20240828070507.2047-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjNfa88Hl1KHpVudzUb5E0WJQFaKfV2lDkz557ZnBAzs7g5VuEJ
	pD/TH+hc4uqQIRBHRcdmocBAxlJc2cqPiWKQChY6USgIcQGmQjZF2KRlg0jc1lpw/vNyvpPz
	nXO/795H4vxfCSGZpzGyeo1CRRNcTvvlDesTpr3X9otq3Slo9oY9DNl6LxBovLYCQ5O9lQTy
	NH6DoYL6ZgKVd7Zx0MTtJQ4aPl9FoLpvC3Hk6/03DJXVezlo8f58GLIXV3FQkdlDoJ7GeQwN
	L3YEJNcHCWRZDnzKuwXoL58XvCZgmrxFBNNhnQhnap0mpurhSZxx2osJpst2Npw50XmYqZxY
	AswXrXbA+J0vpnP3KOW5rCKb1ceymixtdp4mJ41+a1fm65kpUpE4QSxDm+hYjULNptFb305P
	2JanCoxIx+YrVKYAla4wGOikV+V6rcnIxuZqDcY0mtVlq3QSXaJBoTaYNDmJGtb4ilgk2pgS
	EH6kzDWfHQjXzQkOmos3m8Ev/BIQQUJKAn92DYeVAC7JpzoBbKiqx0KFD8CF7xbwJ8XYlUZs
	taVhaJQTxHyqA8CKq2+GRIsAdnQXB7xIkqDE8Lc+eZCPppYALHH5OMECp85gsKWlmQh2r6H2
	wJGCmfAg5lBxsO9BDQhiHpUK66bu4aG0DfD7i51YiI+C/aenHyfjVAwsaKtc0YyQ8GaPOhgM
	qa3wwmdJIXoNnHG3hoewEPr/uEiE8CewaXyeCJ4HUkcBvDz994poM5zqvYMHffBAbvP5FZ8X
	4JceBxaKjYTHl6dXFsGD56pXcRz0HBle8V8LJ8+MhoUwA28UjuGhZe2FC81zmAXEWJ+axvrU
	NNb/k2sBbgdCVmdQ57BZKTpxgoY98ORis7RqJ3j80uPTz4GmHx4lugBGAheAJE5H8/rcA/v5
	vGzFx4dYvTZTb1KxBhdICez4BC4UZGkDv4rGmCmWyEQSqVQqkSVLxfRzvPuFtmw+laMwskqW
	1bH61T6MjBCasXgZZpljfnrn5Vup7sNvnO5TZtTs3LHAxEz0Jytde4loyXB3pe3OJocv7/ny
	2zbhOr7EVCo4NFN+qW8dcbJxMm7+lu29BeFXGUYki+qS+z+VJ9ccuPThMb/Ova+6yT11vU3a
	IxP9eSyfj79rSIvZklv0QdT7c3fvuniO35dk2NB4hqXsmd1lD1vWe8ktFf749hJfaWtDNanh
	WWYl8nnTLPfoPkeX8x/e8Wev7jDvdhpdHuPgVF3XI/H2wciy7TXKnTL7wGROav6PUZHXxrL6
	6+FLN5MPDnxtj3hwZWR2dIneVppkbT+ybPYKWvifc9dyhwiHZdc91Ub/sjRTFHsK0hxDrkIc
	j+sNiv8Ar5FqvHIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42LZdlhJTtfpzLk0g66/mhZvrq5itZh7dDeb
	xZ0F05gs7h2dzWZxavlCJovmxevZLCbt2cpicffhDxaLy7vmsFksWtbKbPHp6H9Wi/7Fl1gs
	vr/+yGqxqnMOi0V7wyk2iyPLPzJZXP6+E6jk/AU2iwm/gcSkg6IWXz9dYnQQ9Vh9qZ3NY+es
	u+weCzaVesz5NZnZY9OqTjaP/XPXsHtM3FPnMfvuD0aPvi2rGD0+b5IL4IrisklJzcksSy3S
	t0vgymhYc5a94K1oRUOnfQPjLaEuRk4OCQETiaUXr7F0MXJxCAlsZ5S43rmGESIhLfF6VheU
	LSyx8t9zdoiir4wSu67fYOpi5OBgEzCUeHbCBiQuItDCJNHfO58ZxGEW2MQk0b7wOyNIkbBA
	hMTvlTogg1gEVCVOfJgPNpRXwFpi0eOXzBALNCXW7t3DBBEXlDg58wkLiM0sIC/RvHU28wRG
	vllIUrOQpBYwMq1iFE0tKM5Nz00uMNQrTswtLs1L10vOz93ECI4qraAdjMvW/9U7xMjEwXiI
	UYKDWUmE98Txs2lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwc
	nFINTGtUvgVtVNbtu35icfzKvIx7GbPn/Gg6cHzp7iNfO9rfdNp9Wsr6q2Le/RffKyfeP+KZ
	EHjtvnhBzgGh+Qt3O5/c2O70eWrX95leQUlBJ5ZPezf1xVeDGLvdMT5BgopCs1wq57u0hUwT
	3ydxJS2wK5gx43SKfmYnk8/X+U94J9vcKmrdmrDjeUaDwGPRCr9ntxP/8U/OW7StTnLBrsub
	A/7/dlzzZk7amRe3P+lHTyitniWc970m/oaWmfGGR98Ph5edvCht27mg6vdavQszbm3eyHmt
	+y7vqtgsj3u7mGOeGUqozjNUsJ/lMufYBsemIodVO72fFGSfFdinKZRVV/xJsyyw2kHd3WOL
	bntC3EklluKMREMt5qLiRACUQ2OrGQMAAA==
X-CMS-MailID: 20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37
References: <CGME20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37@epcas5p2.samsung.com>

This commit adds a null pointer check for udc in gadget_match_driver to
prevent the below potential dangling pointer access. The issue arises
due to continuous USB role switch and simultaneous UDC write operations
performed by init.rc from user space through configfs.  In these
scenarios, there was a possibility of usb_udc_release being done before
gadget_match_driver.

[27635.233849]  BUG: KASAN: invalid-access in gadget_match_driver+0x40/0x94
[27635.233871]  Read of size 8 at addr d7ffff8837ead080 by task init/1
[27635.233881]  Pointer tag: [d7], memory tag: [fe]
[27635.233888]
[27635.233917]  Call trace:
[27635.233923]   dump_backtrace+0xec/0x10c
[27635.233935]   show_stack+0x18/0x24
[27635.233944]   dump_stack_lvl+0x50/0x6c
[27635.233958]   print_report+0x150/0x6b4
[27635.233977]   kasan_report+0xe8/0x148
[27635.233985]   __hwasan_load8_noabort+0x88/0x98
[27635.233995]   gadget_match_driver+0x40/0x94
[27635.234005]   __driver_attach+0x60/0x304
[27635.234018]   bus_for_each_dev+0x154/0x1b4
[27635.234027]   driver_attach+0x34/0x48
[27635.234036]   bus_add_driver+0x1ec/0x310
[27635.234045]   driver_register+0xc8/0x1b4
[27635.234055]   usb_gadget_register_driver_owner+0x7c/0x140
[27635.234066]   gadget_dev_desc_UDC_store+0x148/0x19c
[27635.234075]   configfs_write_iter+0x180/0x1e0
[27635.234087]   vfs_write+0x298/0x3e4
[27635.234105]   ksys_write+0x88/0x100
[27635.234115]   __arm64_sys_write+0x44/0x5c
[27635.234126]   invoke_syscall+0x6c/0x17c
[27635.234143]   el0_svc_common+0xf8/0x138
[27635.234154]   do_el0_svc+0x30/0x40
[27635.234164]   el0_svc+0x38/0x68
[27635.234174]   el0t_64_sync_handler+0x68/0xbc
[27635.234184]   el0t_64_sync+0x19c/0x1a0

Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
Cc: stable <stable@kernel.org>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/gadget/udc/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index cf6478f97f4a..77dc0f28ff01 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1338,6 +1338,7 @@ static void usb_udc_release(struct device *dev)
 	udc = container_of(dev, struct usb_udc, dev);
 	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
 	kfree(udc);
+	udc = NULL;
 }
 
 static const struct attribute_group *usb_udc_attr_groups[];
@@ -1574,7 +1575,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
 			struct usb_gadget_driver, driver);
 
 	/* If the driver specifies a udc_name, it must match the UDC's name */
-	if (driver->udc_name &&
+	if (driver->udc_name && udc &&
 			strcmp(driver->udc_name, dev_name(&udc->dev)) != 0)
 		return 0;
 
-- 
2.17.1



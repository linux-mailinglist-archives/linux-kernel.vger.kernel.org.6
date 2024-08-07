Return-Path: <linux-kernel+bounces-277781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8153694A665
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378D1283FE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF6A1DE841;
	Wed,  7 Aug 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZXsmjFDV"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAB1C8FC2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028121; cv=none; b=CZQzAPNR4oJVtVmIZ6M7oLWulANBgUkT8V3drX/flUBuaeTCgJDNAfK+2yiK5IKee6DCMNZeV1BLOIx6NGgn49l5FvUr6lvdASi6jnk2Ns6LgHYmUA+9nP/Slg2tHdP4yfFvDYbjVnle8p8nPBBCIo/IvsOtxJg8i3eD4RdiW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028121; c=relaxed/simple;
	bh=JY/Ro4iTTPMRFHirwH5JNATfaiTzvRqgqpq71UaYIK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=q/0S0F7S3yHygqd86g8yMn6Rt+Bm8s/wPeYSqlyqbQLqB6wCRfgyVMQb9A7gI7sEu7GfrVkbO1+9w62+8a91DyPfrOH8cGvGivr2ZI2iZxQRaem5HhRKGuIBOxF2oGV+b6DbXTIUQ1+hA2aS1+L2p5nLUfSXi0nKINpMOH+pvJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZXsmjFDV; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240807105516epoutp030dcf669d0ee7888946d770a74ef51f92~pbPF1FwjI0449604496epoutp03k
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:55:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240807105516epoutp030dcf669d0ee7888946d770a74ef51f92~pbPF1FwjI0449604496epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1723028116;
	bh=JDctnKHOm7eoeENOaE5hqc6Hiiosaq79K0o4jmvsBb8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZXsmjFDV+qXHP21Rcv+YrM6IJiPKyP8BkXb5pc345fC1D04CmzDYZh+Sy2H5oqGG0
	 mrMFVAOpU7vVId2pQMzgPis0cQarYIsevqJuyy7jXXM5QexQXCxL74I3RxV5VDswr8
	 CRZC5AZXIp/i6CWCyrvo7DiOCG8gf8qTVjHjSVB4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240807105515epcas1p1d86f7ec3b644eb3df781c32ff27393c1~pbPE9m8nH1850018500epcas1p1Y;
	Wed,  7 Aug 2024 10:55:15 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.240]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wf6X339yJz4x9Q5; Wed,  7 Aug
	2024 10:55:15 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.61.10258.39253B66; Wed,  7 Aug 2024 19:55:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240807105515epcas1p1e3d0893f404f5b294ce5628a4188293f~pbPEPT18g0950509505epcas1p1U;
	Wed,  7 Aug 2024 10:55:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240807105515epsmtrp1dcbb2a6b7934858c5cbc15f7daec1ebc~pbPEOoMNL3244532445epsmtrp1K;
	Wed,  7 Aug 2024 10:55:15 +0000 (GMT)
X-AuditID: b6c32a38-995ff70000002812-7b-66b352938e83
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	72.2E.07567.29253B66; Wed,  7 Aug 2024 19:55:14 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.105.252]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240807105514epsmtip2ad9dbcd2817d38747252f46b216800d7~pbPECizki0795807958epsmtip2X;
	Wed,  7 Aug 2024 10:55:14 +0000 (GMT)
From: Sangmoon Kim <sangmoon.kim@samsung.com>
To: Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jordan.lim@samsung.com, myoungjae.kim@samsung.com,
	youngjae24.lim@samsung.com, Sangmoon Kim <sangmoon.kim@samsung.com>
Subject: [PATCH] Documentation: kernel-parameters: add
 workqueue.panic_on_stall
Date: Wed,  7 Aug 2024 19:55:00 +0900
Message-Id: <20240807105500.3958276-1-sangmoon.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmvu7koM1pBneXiVk8OdDOaHFjWZjF
	wrYlLBaXd81hs5j+Uczi1oNGFotfy48yWmzb+5TJgcNj06pONo/FfZNZPfq2rGL0+LxJLoAl
	KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gIJYWy
	xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BWYFecWJucWleul5eaomVoYGBkSlQYUJ2
	RtOMDYwFKzgrPs7/zdLA+Iq9i5GDQ0LAROLcA5kuRi4OIYEdjBIbpjWyQzifGCVWzX3ECuF8
	Y5RY8+k6YxcjJ1jH29t3mCESexklnt84DeV8YZSY8ruLGaSKTUBX4su8y2AdIgL2EjP+zAcr
	YhbYzijRs38HWEJYIFDi6erbLCA2i4CqxLpVb8DivEAN/bObodbJS+w/eJYZIi4ocXLmE7B6
	ZqB489bZYEMlBM6xSzQuWcAM0eAiseTBCqhmYYlXx7ewQ9hSEi/729ghGvoZJU51d7FAJKYw
	Ssy9pglhG0v09lxgBgUNs4CmxPpd+hDL+CTefe1hhYQYr0RHmxBEtZrE41d3oVbJSPTfmQ81
	0UPi5KX3YHEhgViJXw9fsU1glJuF5IVZSF6YhbBsASPzKkax1ILi3PTUYsMCE3hUJufnbmIE
	pz4tix2Mc99+0DvEyMTBeIhRgoNZSYS3OXxTmhBvSmJlVWpRfnxRaU5q8SFGU2CgTmSWEk3O
	BybfvJJ4QxNLAxMzIxMLY0tjMyVx3jNXylKFBNITS1KzU1MLUotg+pg4OKUamCSLpmcsfyEQ
	O/Xf787E7hzBp0npHZ9fnH6zy9bJ1qolKD5TvcN4gsIX3m/vGl+9+rxxf+/Z83dur/Dt2ya2
	M1heu3tD4lw7/yP973q6Pz5eph3cP3HnxB6bfe8mn/i+qfL3Bqct+y4xSQd0Z/CtPB9zpSn+
	T42X7pmyDHH+KJU9izdoyr6obHBRXfQ55d36N1Mqg4+vYs2ZLyvxI+lCbv+1k5/LV15ze6H1
	YGfBrPT/EyadU7u1W2O1dswK51teiz/tXRH3gKMrZOeaik3/rBsqVl+y3RUaPn+Cs3H+Us1d
	bB/jd+9/v/+W5VmDTR7nXpas2mOo4b090P52zZTjKdO/nNCaODPl5ySu8i3HziRvV2Ipzkg0
	1GIuKk4EAMU+apkGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSvO6koM1pBne+WVk8OdDOaHFjWZjF
	wrYlLBaXd81hs5j+Uczi1oNGFotfy48yWmzb+5TJgcNj06pONo/FfZNZPfq2rGL0+LxJLoAl
	issmJTUnsyy1SN8ugSujacYGxoIVnBUf5/9maWB8xd7FyMkhIWAi8fb2HWYQW0hgN6PElQ4j
	iLiMxM6Lm5m6GDmAbGGJw4eLuxi5gEo+MUqcmrkSrJ5NQFfiy7zLjCC2iICjxIHTE1hBipgF
	9jJKbP+9kxUkISzgL/F65gImEJtFQFVi3ao3YA28AvYS/bObGSGWyUvsP3iWGSIuKHFy5hMW
	EJsZKN68dTbzBEa+WUhSs5CkFjAyrWKUTC0ozk3PTTYsMMxLLdcrTswtLs1L10vOz93ECA5Q
	LY0djPfm/9M7xMjEwXiIUYKDWUmEtzl8U5oQb0piZVVqUX58UWlOavEhRmkOFiVxXsMZs1OE
	BNITS1KzU1MLUotgskwcnFINTGku0usPrq6WFWfXXX2tpyT43yn2ac+i9yTK7eU4b3DY6YsQ
	31Tmw3+Tyz4dD//9/voKiczK4uD/j0pnLGH6aPMgOWmaaNbq7iOedg8enXkx1/GYX1D7T96m
	usuiKg9LXeLq4zYf35b9RPtZVX9YUt7PyGvRDEctRaeGK925bdS5/L7OpJobr5uW+la22cTI
	sH5L+r1p/QoPoWdf5mnqtC370JX79KxVQv4Nhz6ejLCg+ntu0ooCHYfqWQ+fnP06/NinRUz7
	co6rq1SLfXw0rUH0hGWP7BcVJSd+Tjvtpak1W7QLC6sWfAyS3RDJ7P1ywZk3c63r/H6alylN
	vL4lp03Bwnvlj2XrW1QmL5woocRSnJFoqMVcVJwIAMqqVtq/AgAA
X-CMS-MailID: 20240807105515epcas1p1e3d0893f404f5b294ce5628a4188293f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240807105515epcas1p1e3d0893f404f5b294ce5628a4188293f
References: <CGME20240807105515epcas1p1e3d0893f404f5b294ce5628a4188293f@epcas1p1.samsung.com>

The workqueue.panic_on_stall kernel parameter was added in commit
073107b39e55 ("workqueue: add cmdline parameter workqueue.panic_on_stall")
but not listed in the kernel-parameters doc. Add it there.

Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..561f42d8a48f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7354,6 +7354,13 @@
 			it can be updated at runtime by writing to the
 			corresponding sysfs file.
 
+	workqueue.panic_on_stall=<uint>
+			Panic when workqueue stall is detected by
+			CONFIG_WQ_WATCHDOG. It sets the number times of the
+			stall to trigger panic.
+
+			The default is 0, which disables the panic on stall.
+
 	workqueue.cpu_intensive_thresh_us=
 			Per-cpu work items which run for longer than this
 			threshold are automatically considered CPU intensive

base-commit: 073107b39e553a5ef911f019d4e433fd5a8601b7
-- 
2.34.1



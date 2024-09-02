Return-Path: <linux-kernel+bounces-310588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AAA967EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C892821D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6C14F9FE;
	Mon,  2 Sep 2024 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GFZi7ATm"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D0C382
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725254862; cv=none; b=W7yizHu8IU0pFzY6QdNdMTxzN3VO1ar9Qd2drn1E0fPmC9K6MjtMsU57CCoaGqMKQTlOZZZ+nzApT2ff8HHaj1eJUwBCL3P5nJY/gGur36U90xN+gxqN+I3DfZjD2+7ScJljGltw1ufrB0W9PGLRX00y+JYtuz3XEN1MohNvpd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725254862; c=relaxed/simple;
	bh=mc6zaj6rN5793qqEIdgWm/3dICddgEUXWhDKlNxx+lY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=egcUD44jzjJVyWuIoU2RDM+s4vD7q2XfhSDf6YJfFRcJxD0KTM+orcTHD1RT8nr3t9ZyueRh8oNPiWFvZEtroQzingH2xCbrGPLdY3epFzJimrkI0xGOEr0iN9IE+GAjIGWIhRDTMQinJh9M2VUiCSABZ68yjw0YiffRyjwpqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GFZi7ATm; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240902052732epoutp0171e191ec497bc44038082fd5fb0cd0fc~xViXAJJyu0805308053epoutp01D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 05:27:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240902052732epoutp0171e191ec497bc44038082fd5fb0cd0fc~xViXAJJyu0805308053epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725254852;
	bh=ITWBx7yf8vNGJ6PCnSt1wbV1pwh0Fe1mZqd+MoIc/+U=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GFZi7ATmZgtn+Am2jR2+rveLA4H+1vIeDbZ0pLHQusO/L0P2L3OX/b6p90o8E8r2d
	 13TNqcMzc6/VCWER7gWVnxuMf1gh1XOPa6+Mug7AZ1NebsJ9pz5EbysCLNtauM3eQL
	 4ySao4dYgS4PSRyLbel+wmEh7aTuJISeCNaPoazA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240902052731epcas1p49d379406402c5839792baddde54db32d~xViWnrsHc2288922889epcas1p4J;
	Mon,  2 Sep 2024 05:27:31 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.225]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wxy1v4ZxPz4x9QK; Mon,  2 Sep
	2024 05:27:31 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.21.09734.CBC45D66; Mon,  2 Sep 2024 14:27:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240902052723epcas1p14bde943e61f9e61c81db72245cb74c79~xViPF2rUT3215632156epcas1p1X;
	Mon,  2 Sep 2024 05:27:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240902052723epsmtrp19a2c48f5b29c627bfc9cfe2ce998ce0c~xViPFVTzH0602906029epsmtrp16;
	Mon,  2 Sep 2024 05:27:23 +0000 (GMT)
X-AuditID: b6c32a39-b5dfa70000002606-a4-66d54cbcb7fe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0F.F1.08456.BBC45D66; Mon,  2 Sep 2024 14:27:23 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.57.249]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240902052723epsmtip27bcd84de0c4b95ba04aee288a1ba2648~xViO7LIzF1571715717epsmtip2w;
	Mon,  2 Sep 2024 05:27:23 +0000 (GMT)
From: JeongHyeon Lee <jhs2.lee@samsung.com>
To: akpm@linux-foundation.org, jhs2.lee@samsung.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mempolicy: fix issues detected by checkpatch
Date: Mon,  2 Sep 2024 14:27:20 +0900
Message-Id: <20240902052720.754717-1-jhs2.lee@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmnu4en6tpBkdm8FnMWb+GzeLS/Tus
	Fpd3zWGzuLfmP6sDi8emT5PYPU7M+M3i0bdlFaPH501yASxR2TYZqYkpqUUKqXnJ+SmZeem2
	St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCuVFMoSc0qBQgGJxcVK+nY2RfmlJakK
	GfnFJbZKqQUpOQVmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZ3cvb2Qr6OCuajvSwNTD+Zuti
	5OSQEDCR2D1jAWMXIxeHkMAORolHZy8zQTifGCVuTtjHDOF8Y5S4f2k3I0zLrIevoVr2Mkr8
	2LyVBcL5zCjRsvs1O0gVm4C2xO2WTWC2iICxRNfO8ywgNjNQ9/3Wh6xdjBwcwgIOEjObeEHC
	LAKqEpM/LQW7iVfASmLa9eOsEMvkJWZe+s4OEReUODnzCdQYeYnmrbPBrpMQ2MYuser3UaiH
	XCS2LHgIZQtLvDq+hR3ClpJ42d8GZVdL7Fl3GKp5AqNE6+lzYAdJCNhLLDllB2IyC2hKrN+l
	D7GLT+Ld1x6oCl6JjjYhiClKEiv+XWOBsCUkNhzuhtrqIbFzNkicAxgksRLX/phNYJSbheSB
	WUgemIWwawEj8ypGsdSC4tz01GLDAlN4PCbn525iBCc0LcsdjNPfftA7xMjEwXiIUYKDWUmE
	d+mei2lCvCmJlVWpRfnxRaU5qcWHGE2BQTqRWUo0OR+YUvNK4g1NLA1MzIxMLIwtjc2UxHnP
	XClLFRJITyxJzU5NLUgtgulj4uCUamBi/8B6Ys8eZefSlOMb/Tsy1/aaVfLmO0TtO/LF4JjU
	47nrmOqEHy0MiuAXllu/5pU187x8jnDdrIvSEu9+pf3Z0OIT2f72tM4E0aa0imOxW3W+uE9v
	EwiJ+vKJf6lt/bYUF73+AxK+cmvXFfoYPvslMD/uyc5n79vW2BifYmCe4bGzxN9M5JPs/p5z
	v2scsquXGKdPMpx1ZvHFqj2NWlKudn+27Pvi+DrOVYnlhp9loUH/v+WXl1bH3mf8zv/x7fH1
	1qmqa91KeV7Z/7F/b2w92Ynd54N86BpDye1S974EZfyw/L+FsYjbQzUlc1Vhz//zM1n2nzQ6
	ubdm7teZHFmvbcMkIpl0GUInO0yzV1ZiKc5INNRiLipOBAAnTRdN8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSvO5un6tpBvc2GFvMWb+GzeLS/Tus
	Fpd3zWGzuLfmP6sDi8emT5PYPU7M+M3i0bdlFaPH501yASxRXDYpqTmZZalF+nYJXBndy9vZ
	Cvo4K5qO9LA1MP5m62Lk5JAQMJGY9fA1I4gtJLCbUeLdBlWIuITEhk1r2bsYOYBsYYnDh4u7
	GLmASj4ySjy7OZ8JpIZNQFvidssmdhBbRMBUYt76P6wg9cwCZhLb+tVATGEBB4mZTbwgFSwC
	qhKTPy0F28orYCUx7fpxVohN8hIzL31nh4gLSpyc+YQFxGYGijdvnc08gZFvFpLULCSpBYxM
	qxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgsNOS2sH455VH/QOMTJxMB5ilOBgVhLh
	XbrnYpoQb0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTLJe
	JkyZW53dBXd8SnjxwCA9yCVi4yLmZzoq7rzHFab971q1POveNRt1j8eqq7ZPujdfbuYl7b2q
	r95OEMlOXHdmxiWlS97CvscTBJROCB0Jj/CY8PfutX83RFWX/k/fXhuv8vpJ5r+uBaqyamYm
	CfM/hX6c2vDg/L4PMWaf1/7ob9llWBT5ZE+RS/Tyfwte/D5Vwbc8zSNZjCt6bcHH810S3asn
	hj8LlhRgt0swWt0bw/i1f5blrKVbav58tm36mb3gj7pU5L1owel7Jc49+LyhcRVPbcAsn6ZM
	ZsNfP3wyP/OvkBa88qdN/azZ0zmb7jKyfZ4gJ2D5x+DrlP6WS5OTy4T3PfM9r/PWLa1RyE2J
	pTgj0VCLuag4EQDxxpnzqgIAAA==
X-CMS-MailID: 20240902052723epcas1p14bde943e61f9e61c81db72245cb74c79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240902052723epcas1p14bde943e61f9e61c81db72245cb74c79
References: <CGME20240902052723epcas1p14bde943e61f9e61c81db72245cb74c79@epcas1p1.samsung.com>

- ERROR: code indent should use tabs where possible
- ERROR: that open brace { should be on the previous line

Signed-off-by: JeongHyeon Lee <jhs2.lee@samsung.com>
---
 mm/mempolicy.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b646fab3e45e..840da8ff9b9b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1161,7 +1161,7 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			 * do_migrate_pages() tries to maintain the relative
 			 * node relationship of the pages established between
 			 * threads and memory areas.
-                         *
+			 *
 			 * However if the number of source nodes is not equal to
 			 * the number of destination nodes we can not preserve
 			 * this node relative relationship.  In that case, skip
@@ -3148,8 +3148,7 @@ void numa_default_policy(void)
 /*
  * Parse and format mempolicy from/to strings
  */
-static const char * const policy_modes[] =
-{
+static const char * const policy_modes[] = {
 	[MPOL_DEFAULT]    = "default",
 	[MPOL_PREFERRED]  = "prefer",
 	[MPOL_BIND]       = "bind",
-- 
2.25.1



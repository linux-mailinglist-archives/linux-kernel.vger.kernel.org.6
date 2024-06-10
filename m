Return-Path: <linux-kernel+bounces-207600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3F901985
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A130C281A44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 03:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782556FBE;
	Mon, 10 Jun 2024 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QzY4ppZg"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6C3C30
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717989421; cv=none; b=tIx49PK69FW47V279clFutPr3/A75gELbAbWVPGWSN2rVxWwfYCsaXzB1SY4akCCt3oeUZwwJFS23rL8WlIeiYLZ8lySgtwK8nByFuXfYHM8ul1GOwdvAPhGn1t0gWUXL3G9s0a1LBMS6CYbMGUp585glpRUTX2zEj757v1D2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717989421; c=relaxed/simple;
	bh=QicgXxIlqpC31U/1Nxw3Hsoz4A8pKQPVMlH3jzLsGNQ=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=aGbH6iadmVAq7hvy8niCxMn0banXDcaJp4aUby1V6CoemjOWri+336qgseC7R6RkCRdEYv6tLlrXT2dWoAMLfU9UVZVV18NF5UKTERqfbx7vGteblK4vi+R5lfgb2J/Rf4PtrIVFGxbeN8Be/QAaLk6PTMsxJOO+WFjUZYRis0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QzY4ppZg; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240610031649epoutp014e789638552da75e72783886ebca938a~XhkQHxpvt0276102761epoutp01F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 03:16:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240610031649epoutp014e789638552da75e72783886ebca938a~XhkQHxpvt0276102761epoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717989409;
	bh=QicgXxIlqpC31U/1Nxw3Hsoz4A8pKQPVMlH3jzLsGNQ=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=QzY4ppZgLQe+Ud8Am3tA80rkyoJs0DUQ2HTCOTMcxXtgOPGF69urkCgLLig/Dte5v
	 +mxMEaHRZPWP16afaQvVyyweS9qJUu5VQ2czGCZadaAmREoPmeVqoMEoITJKLUtifO
	 QZlhcqoKiEttw+K8eaxe0AmzwvkDMRjacp/DKRvU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240610031648epcas2p4a08c957de2fbac2dd1b135cf86d8c2c1~XhkPfYPTT2295422954epcas2p4_;
	Mon, 10 Jun 2024 03:16:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VyH5r452Pz4x9Pt; Mon, 10 Jun
	2024 03:16:48 +0000 (GMT)
X-AuditID: b6c32a48-105fa70000002507-11-666670209a4c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.E0.09479.02076666; Mon, 10 Jun 2024 12:16:48 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [f2fs-dev] [RFC PATCH] f2fs: add support single node section
 mode
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Yongpeng Yang <yangyongpeng1@oppo.com>, "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Nayeon Kim <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>,
	Seokhwan Kim <sukka.kim@samsung.com>, Dongjin Kim
	<dongjin_.kim@samsung.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <0db07a4a-91da-402e-9601-46b196b8cf1b@oppo.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240610031547epcms2p526560bc9d2fd3a5f36615fe645640079@epcms2p5>
Date: Mon, 10 Jun 2024 12:15:47 +0900
X-CMS-MailID: 20240610031547epcms2p526560bc9d2fd3a5f36615fe645640079
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmha5CQVqaQUurrMXpqWeZLJ4caGe0
	eHlI02LVg3CLHydNLJ6sn8VssbBtCYvFpUXuFpd3zWGzaPnjZHF+4msmi1UdcxktFk36zebA
	67FpVSebx+4Fn5k8FvdNZvV4N0vJo2/LKkaPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD
	453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgG5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
	l9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnnGh7wF6wka1ixorHzA2M81i7GDk5
	JARMJHp3rWLpYuTiEBLYwSix+cIfpi5GDg5eAUGJvzuEQWqEBYIltr+ewAZiCwkoSay/OIsd
	Iq4ncevhGkYQm01AR2L6ifvsIHNEBD4xSZw58wFsKLPAUUaJL3ePM0Js45WY0f6UBcKWlti+
	fCtYnFPARqL/7xeoGg2JH8t6mSFsUYmbq9+yw9jvj82HqhGRaL13FqpGUOLBz91QcUmJ23M3
	QdXnS/y/shzKrpHYdmAelK0vca1jI9gNvAK+EhdPNTOB2CwCqhItJ44wQdS4SCx+sxCshllA
	XmL72znMoEBhFtCUWL9LH8SUEFCWOHILqoJPouPwX3aYDxs2/sbK3jHvCdR0NYl1P9czTWBU
	noUI6VlIds1C2LWAkXkVo1hqQXFuemqxUYEJPHKT83M3MYKTq5bHDsbZbz/oHWJk4mA8xCjB
	wawkwiuUkZwmxJuSWFmVWpQfX1Sak1p8iNEU6MuJzFKiyfnA9J5XEm9oYmlgYmZmaG5kamCu
	JM57r3VuipBAemJJanZqakFqEUwfEwenVAPTeofQPxEKE7Qyny5SfNmsl3990v/8zPdKJ66I
	mf/OT0pIO3rvwn2Jux/i/db+b6mo3GV05mzxpn8VMT27rIJFp2lO6gzcsrfSvihvStzcadkK
	lzz9A/UjX2hcPrD+2Aaf8gvdXXq/Pzsx+zdp7nafo7r6i5ta/8RV2w52L90nei3yqvz9heI7
	lvQ96jy8ZUniXc2PN48VLWS7sYTjWqJB4b62Xr8YD/WCjYYq3suPaFTezu3MO2zzuTLOd0Jw
	F9ez8JNGcr1GDs5Jn2Qm/mx9tISx8QejxALTrEMNXmfnOPKopwcyBeS/+ef3vaCP9UwKX8PJ
	yffCu1O8u9fvm3b8U7e58rnMEl65+48dGY2UWIozEg21mIuKEwFOJDN7NwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531074640epcms2p46c3cf8b7cc4e707948ae200115e28e39
References: <0db07a4a-91da-402e-9601-46b196b8cf1b@oppo.com>
	<20240531074640epcms2p46c3cf8b7cc4e707948ae200115e28e39@epcms2p4>
	<CGME20240531074640epcms2p46c3cf8b7cc4e707948ae200115e28e39@epcms2p5>

> Hi Daejun,
> 1. It is not compatible with "F2FS_OPTION(sbi).active_logs == 2".
> 2. Once has_enough_free_secs is false, F2FS cannot restore to multi-node
> sections even after has_enough_free_secs becomes true and the filesystem
> is unmounted and remounted. This seems unreasonable.

Hi Yongpeng Yang,

1. Yes, I will modify it so that it only applies when active_log is 6.
2. This technique is effective when utilization is high. Therefore, in my scenario, I assumed that only heavy users would use this option. So I assumed that the free section would not be sufficiently secured even after that.
Futhermore, if a new section is allocated to deactivate a single node whenever there is free space, then soon again insufficient free space may occur, resulting in more unnecessary GC.

Thanks,
Daejun


Return-Path: <linux-kernel+bounces-337953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2665985165
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1B3284E85
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5285C14A4D1;
	Wed, 25 Sep 2024 03:23:31 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1679149013
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727234611; cv=none; b=dZKigNTzbf8BFeVxd6uFE/sZrV76lvrSoKXMs5kZl4L+Us8arsqZvtkDFKTxgjGkwC7i3wnIA/Z7Ykn44N6UMfrWJduO40BEp8PsZ83vZQYzyc05jnh/1qdpbjZwPDI88LZ0HsZk/V2dCEd/xJainJ4o5pTkqRw7KRyFT5dWiDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727234611; c=relaxed/simple;
	bh=BrJSLgdf7u7m9FRiHhtMr65zOtJ2BdEF6QwN8xNXGro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tl+izO3WIPFDB0mR2SgMcw9PJt3kmdjxXLc+xL6eBXvQJj6l6QBvWix7cNl0NQEwwl8YvDAymbpnAdaklu1rOjLbXncaEeC+vbFkPSrvYNtDRI9EztUh8OhZgvm+xuzKI6RJQN5qcOWVaanXsBCNFxMAEFiPv1dHf76EdSyqypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48P3N36W053405;
	Wed, 25 Sep 2024 11:23:03 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XD20k750Gz2Mx63v;
	Wed, 25 Sep 2024 11:15:18 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 25 Sep 2024 11:23:00 +0800
From: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman
 Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <tkjos@google.com>,
        Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        Yuming Han <yuming.han@unisoc.com>
Subject: [PATCH 0/2] Introduce panic function when slub leaks
Date: Wed, 25 Sep 2024 11:22:54 +0800
Message-ID: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 48P3N36W053405

Hi all,

A method to detect slub leaks by monitoring its usage in real time
on the page allocation path of the slub. When the slub occupancy
exceeds the user-set value, it is considered that the slub is leaking
at this time, and a panic operation will be triggered immediately.

Fangzheng Zhang (2):
  mm/slub: Add panic function when slub leaks
  Documentation: admin-guide: kernel-parameters: Add parameter
    description for slub_leak_panic function

 .../admin-guide/kernel-parameters.txt         | 15 ++++
 mm/Kconfig                                    | 11 ++++++++
 mm/slub.c                                     | 76 +++++++++++++++++++

 3 files changed, 102 insertions(+)

-- 
2.17.1



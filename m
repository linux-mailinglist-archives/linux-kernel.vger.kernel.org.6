Return-Path: <linux-kernel+bounces-339145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17EC9860C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7761C266A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558751B012E;
	Wed, 25 Sep 2024 13:25:26 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55E18C933
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270726; cv=none; b=sZrZ4o3qUb2uCoMeez1MdlYOcg+5wuyZItsdgOySseMUvEw6mh78hPvZetrz3Ldn1VSVR8SEZZdCSCyVV1dCcIr8oDG84A5wRn3w75u+80vcHguDTt/tCYPV5UnWG2VFt59d+K2NTjEZzQYI7OnpsWZoAI2ykfVnUkGlXqNDLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270726; c=relaxed/simple;
	bh=BVOUDMg7klx6G/WyfMUyhUFQn3BxwJebQLX6aoZDge0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lgOThgu+8jCi5JU3/iU6zEJhlD01GaFM8xlpkspxTHPlKL8JgrpOla1ubX9dfCN9k01AdBSoF8sYO912ZKK9YuHFLXFFf13mRr8pMxL01fTDvXcReCpbCJ7C3PKR/nIPBzcNqYr2MTm8bJ+FUFV7T6IAcmccpSiH5nZlJQnYWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48PDPBUb031950;
	Wed, 25 Sep 2024 21:25:11 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XDHMV6Ykrz2K5B73;
	Wed, 25 Sep 2024 21:17:26 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 25 Sep 2024 21:25:09 +0800
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
Subject: [PATCH V2 0/2] Introduce panic function when slub leaks
Date: Wed, 25 Sep 2024 21:25:03 +0800
Message-ID: <20240925132505.21278-1-fangzheng.zhang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 48PDPBUb031950

Hi all,

A method to detect slub leaks by monitoring its usage in real time
on the page allocation path of the slub. When the slub occupancy
exceeds the user-set value, it is considered that the slub is leaking
at this time, and a panic operation will be triggered immediately.

Changes in v2:
- Fix error that unterminated conditional directive
- Avoid using #ifdef when referencing .h in .c files

Changes in v1:
- Add panic function when slub leaks
- Add parameter description for slub_leak_panic function

[1] https://lore.kernel.org/linux-mm/20240925032256.1782-1-fangzheng.zhang@unisoc.com

Fangzheng Zhang (2):
  mm/slub: Add panic function when slub leaks
  Documentation: admin-guide: kernel-parameters: Add parameter
    description for slub_leak_panic function

 .../admin-guide/kernel-parameters.txt         | 15 ++++
 mm/Kconfig                                    | 11 +++
 mm/slub.c                                     | 75 +++++++++++++++++++
 3 files changed, 101 insertions(+)

-- 
2.17.1



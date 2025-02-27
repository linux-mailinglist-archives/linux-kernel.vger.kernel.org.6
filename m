Return-Path: <linux-kernel+bounces-537467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4455A48C46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E33A84F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DB26E975;
	Thu, 27 Feb 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ5VjVad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D5277817;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697332; cv=none; b=hmE+l/Fo/MkHsECRyeUswuzN74AyKnigIc3qMtZrS2oJ6cxNT5mJfY6/SdnYYBQQVmoNbPWPz1qwAZmgJDjj0FPIz+Hq2Al9ajx0PZI/O2ziGCD9XUuvzHHiGbdtYG6P02qHgquAWciXAwdeN9gMlpzeurkHppIlOBosN/xZLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697332; c=relaxed/simple;
	bh=77mfKSU/7bUid7o9jDTk0QDdNak1HyZH2KPQxoAjUqg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d9BH9bgwyvVywy88GFTpe4+mkGhjsGnxKdylSZH7BlhApjsF+UWxZBZYYxdxPUzjzbTDJPMvb1UKpz1vE88lrTkVJAINITgBKiKcmDh6DzRgKwZQJkkZhQW92Fgj8wUZLU21TygY14TZPpSpDzJaj4vbVRChIO/3phS9xMqADTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ5VjVad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89D81C4CEDD;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740697331;
	bh=77mfKSU/7bUid7o9jDTk0QDdNak1HyZH2KPQxoAjUqg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=kJ5VjVadIYH14WN9A7Eo5CMk1ngHf+2Z7d2tCXlwfE2L8N9egHE9Lv0Wyd04syAyZ
	 GQiGjCMmvjOzeEAi3BCH0FGEfUjnffDrk/65fwucI2axX2enL34QMb0swYthZDQQpy
	 oY5pRB224vAN7JWaxEwZnrUXQ6uWpktxxWCKIENzzEDQJGYWGnTvg+zb+bJoRd0xjl
	 yyJyocKpv8oQ7qvs2gIkDzKkB5SxrIcWgNldwji/zAjI4mtZ6aekr0PVySCd/COpx1
	 YLcpPK/P/oYa9edlLnkJBdMtPgVXSjrWs/C7F26S/ymHltJUwNIxGtpPB/wTrlahp6
	 fIOrN8/LoeAWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFFC197BF;
	Thu, 27 Feb 2025 23:02:11 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Subject: [PATCH v3 0/3] Add a command line option that enables control of
 how many threads should be used to allocate huge pages.
Date: Fri, 28 Feb 2025 00:02:09 +0100
Message-Id: <20250228-hugepage-parameter-v3-0-2628e9b2b5c0@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHuwGcC/33NQQ6CMBAF0KuQrq0pBSy68h7GRZlOaROlTQuNh
 HB3CysXajKb/5P/ZiERg8VILsVCAiYbrRtyqA4FASOHHqlVORPOeMM4L6mZevQy914G+cQRA8W
 2qblWGphEkoc+oLavHb3dczY2ji7M+49Ubu1fLpWUUS3rsxQC2nxXmDsMU6Qjghncw/XzUSHZ6
 MQ/OfGV45kTqmvhpIDVTfWLW9f1DRVYK/QPAQAA
X-Change-ID: 20250221-hugepage-parameter-e8542fdfc0ae
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740697330; l=2949;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=77mfKSU/7bUid7o9jDTk0QDdNak1HyZH2KPQxoAjUqg=;
 b=9MUeqnBuqLbrQS5045xPrHI4IgCVsWVTUBuVD3OAtqS7we6JJlqgxV8uvskTuQNoPESsrgYVm
 o84ZIPyr5GTBHpV7LiQWNLpUR+QEgJaYo3w7hpJzfrKF5Aw7i/+vbWK
X-Developer-Key: i=thomas.prescher@cyberus-technology.de; a=ed25519;
 pk=T5MVdLVCc/0UUyv5IcSqGVvGcVkgWW/KtuEo2RRJwM8=
X-Endpoint-Received: by B4 Relay for
 thomas.prescher@cyberus-technology.de/20250221 with auth_id=345
X-Original-From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Reply-To: thomas.prescher@cyberus-technology.de

Allocating huge pages can take a very long time on servers
with terabytes of memory even when they are allocated at
boot time where the allocation happens in parallel.

Before this series, the kernel used a hard coded value of 2 threads per
NUMA node for these allocations. This value might have been good
enough in the past but it is not sufficient to fully utilize
newer systems.

This series changes the default so the kernel uses 25% of the available
hardware threads for these allocations. In addition, we allow the user
that wish to micro-optimize the allocation time to override this value
via a new kernel parameter.

We tested this on 2 generations of Xeon CPUs and the results
show a big improvement of the overall allocation time.

+-----------------------+-------+-------+-------+-------+-------+
| threads               |   8   |   16  |   32  |   64  |   128 |
+-----------------------+-------+-------+-------+-------+-------+
| skylake      144 cpus |   44s |   22s |   16s |   19s |   20s |
| cascade lake 192 cpus |   39s |   20s |   11s |   10s |    9s |
+-----------------------+-------+-------+-------+-------+-------+

On skylake, we see an improvment of 2.75x when using 32 threads,
on cascade lake we can get even better at 4.3x when we use
128 threads.

This speedup is quite significant and users of large machines
like these should have the option to make the machines boot
as fast as possible.

Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
---
Changes in v3:
- Fix log message (the name of the parameter was incorrect)
- Link to v2: https://lore.kernel.org/r/20250227-hugepage-parameter-v2-0-7db8c6dc0453@cyberus-technology.de

Changes in v2:
- the default thread value has been changed from 2 threads per node to
  25% of the available hardware threads
- the hugepage_alloc_threads parameter now specifies the total number of
  threads being used instead of threads per node
- the kernel now logs the time needed to allocate the huge pages and the
  number of threads being used
- update the documentation so that users are aware that this does not
  apply to gigantic huge pages
- Link to v1: https://lore.kernel.org/r/20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de

---
Thomas Prescher (3):
      mm: hugetlb: improve parallel huge page allocation time
      mm: hugetlb: add hugetlb_alloc_threads cmdline option
      mm: hugetlb: log time needed to allocate hugepages

 Documentation/admin-guide/kernel-parameters.txt |  9 ++++
 Documentation/admin-guide/mm/hugetlbpage.rst    | 10 ++++
 mm/hugetlb.c                                    | 67 +++++++++++++++++++------
 3 files changed, 70 insertions(+), 16 deletions(-)
---
base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
change-id: 20250221-hugepage-parameter-e8542fdfc0ae

Best regards,
-- 
Thomas Prescher <thomas.prescher@cyberus-technology.de>




Return-Path: <linux-kernel+bounces-388730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8E9B63A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC582826B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE6B1EB9E1;
	Wed, 30 Oct 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MjApR5/R"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66B1E3DD3;
	Wed, 30 Oct 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293441; cv=none; b=l9reofHJOdkNRgVwGBeg1jiJOQZEL84Lnyz8tapO7ILy5BpGOUfKtDq84RU5TLnnPwj6ZQspt8Paud6wmz3R3qD3i1PwlUNRtvGqnGBQuhvsmSKzyVE0X4ws5llRFUeRWYrzwoSwWk+iZJScIczkgpZ/bjH8i14PMEvQqcRgm+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293441; c=relaxed/simple;
	bh=Tv4MO7OuY7caM/m0Hx1onykFqDK85SYUjgJ+baehuh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZYY63ulRHLFnyP22G/zAEjLTM7/dA9pKvgyR6I5RhoorPgrUuzvOUiSrbeZvJ+OKWYwa8q7MJEtQ3HRkdhTtM8FVew+RfbRdoBSWSaahHu+FezfHwpA+05wgrdyRMeiWI5XzRx4MmM8MA8mtkirsLzDpPiNkpI7tn82neEUkYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MjApR5/R; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=JzDmzOGqmP2VU6V0H6Y8GpYlaNtoAgTzprRQuVfXuqc=; b=MjApR5/RVHg5aIEtDNvquzCRxB
	vsqqCKiJhg1CAV23sasMNzlGuaEj355fZ+VHNY0B4fZd3ti2+iYEFVaA99C7mIK74BUz23SJEQoAR
	0mNuwk1agbJ8nPBRxRKNk7z+e33vhx+ONpHqH8Wl/1Z8q3QDBBJtuwpAjD4Z9kYjU+xdtcpcJQnfX
	w0obD7vVvhrEZK8rFor8tPUoWjmuEm63Y8avfDOa1A3qKGA4bVwTQymYGH6G085TXqxxT9yb6x8/T
	O7h8f2cxlnBfk2TlyQ7NrJHi9l6/9b3rlT2/zp0okv+eBFERSlI3gb/C5Y614mFwlDx/397opTTit
	m/9/fvDg==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t68MD-00H5h8-9J; Wed, 30 Oct 2024 14:03:29 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 0/4] mm: add more kernel parameters to control mTHP
Date: Wed, 30 Oct 2024 09:58:54 -0300
Message-ID: <20241030130308.1066299-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces three patches related to the kernel parameters
controlling mTHP and a fourth patch replacing `strcpy()` for `strscpy()`
in the file `mm/huge_memory.c`.

The first patch is a straightforward documentation update, correcting
the format of the kernel parameter ``thp_anon=``.

The second and third patches focus on controlling THP support for shmem
via the kernel command line. The second patch introduces a parameter to
control the global default huge page allocation policy for the internal
shmem mount. The third patch implements a parameter similar to ``thp_anon=``,
but for shmem.

The goal of these changes is to simplify the configuration of systems that
rely on mTHP support for shmem. For instance, a platform with a GPU that
benefits from huge pages may want to enable huge pages for shmem. Having
these kernel parameters streamlines the configuration process and ensures
consistency across setups.

Let me know your thoughts.

v1 -> v2: https://lore.kernel.org/linux-mm/20241027175743.1056710-1-mcanal@igalia.com/T/

* [1/3] s/fix the format/fix the doc in the commit's subject (Barry Song & David Hildenbrand)
* [1/3] Add Barry's A-b to PATCH 1/3 (Barry Song)
* [1/3] s/64KB/64K (David Hildenbrand)
* [1/3] Add David's A-b to PATCH 1/3 (David Hildenbrand)
* [2/3] Create the function `shmem_valid_huge()` to reduce code-duplication (Baolin Wang)
* [3/4] New PATCH: generalize the function `setup_thp_anon()` and add it to common file
* [4/4] Fix typo in the documentation: s/shmem_anon/thp_shmem (Barry Song)
* [4/4] Reduce code-duplication (Barry Song)

v2 -> v3: https://lore.kernel.org/linux-mm/20241029002324.1062723-1-mcanal@igalia.com/T/

* [2/4] Apply Wang's suggestion (Baolin Wang)
* [3/4] Delete PATCH 3/4 from v2 and implement ``thp_shmem=`` just like in v1 (Barry Song)
* [4/4] New PATCH: "mm: huge_memory: Use strscpy() instead of strcpy()"

Best Regards,
- Maíra

Maíra Canal (4):
  mm: fix docs for the kernel parameter ``thp_anon=``
  mm: shmem: control THP support through the kernel command line
  mm: shmem: override mTHP shmem default with a kernel parameter
  mm: huge_memory: Use strscpy() instead of strcpy()

 .../admin-guide/kernel-parameters.txt         |  19 +-
 Documentation/admin-guide/mm/transhuge.rst    |  25 ++-
 mm/huge_memory.c                              |   4 +-
 mm/shmem.c                                    | 181 +++++++++++++++---
 4 files changed, 201 insertions(+), 28 deletions(-)

-- 
2.46.2



Return-Path: <linux-kernel+bounces-392576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D769B95C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B1283935
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2E1C9DD3;
	Fri,  1 Nov 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LGADidNV"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FDD1C9DFE;
	Fri,  1 Nov 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479446; cv=none; b=KzbPLLGaFOfFE3RfmSCYP2yCK4uSx5YCHmGnag8qOgmamUpJcZKjQWbo6Tf/8jZBIRXgs/ez3ZIr7voHMoLzXRBYQioQ6ocReu5/FGs2N9j/NAGEK0CIl5CnJAZnPvrcqKbbdO77w7+BUhRQDttEYmBPksmpWGXOCRcOVC0HaGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479446; c=relaxed/simple;
	bh=bUqsVhfSeHps+hqP02SlBUonivJAjSyzaEe3MLxZ0Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Szyiaurq7xTkIapRyqhCNF3jp5iNmNdvK3yi+1/igVWLh0n4BJTpInJOgSpxMtWsrBjmWJVfBOi+kmQUy2qLuTc9vQmSFO2WlPoQqD21+3Wfe0d7vUaT2PaNpFs7PV2lMxgjNanzWKz2Rtqdi5Ik0zBoVOtHNPLCqiee/YAeoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LGADidNV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IgTr55Xoec7l8zHhjo5z1BNhwtjJf/dOrOaf4emgx7c=; b=LGADidNV1if7DgUh/ZSuC06BqG
	616TqhMaQ3WUHklId5DX8gfWHxjLeRvHafL4Hhjrl+6zG3rNLW6wwgNvm621J/+vEhpn4wEcv4hwM
	n8P8qYpNvFfzcccjwHnxeJGp1KtDjrIpkY490E7hqqyJLUt4aKsQ/jwge06qzV1QCg87KCHBMlSCb
	gBX+Xdub4JUYBaZF+mn+IJ2jMxwhQ90PAshV58SwcB5CofjIC6qiXd0eBxJ2pBEPEH3gcAiqxJtID
	TcXhyCK6SVaYhYHMTHDsjioGf9xukzVYHQUusfI9x7l83JT3W+NcR3dWFKXXTOis+VMJifUn1IDWa
	trvR6VzA==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6ukY-000V38-4e; Fri, 01 Nov 2024 17:43:50 +0100
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
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v4 0/5] mm: add more kernel parameters to control mTHP
Date: Fri,  1 Nov 2024 13:38:41 -0300
Message-ID: <20241101164313.1073238-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces four patches related to the kernel parameters
controlling mTHP and a fifth patch replacing `strcpy()` for `strscpy()`
in the file `mm/huge_memory.c`.

The first patch is a straightforward documentation update, correcting
the format of the kernel parameter ``thp_anon=``.

The second, third, and fourth patches focus on controlling THP support for
shmem via the kernel command line. The second patch introduces a parameter to
control the global default huge page allocation policy for the internal
shmem mount. The third patch moves a piece of code to a shared header to ease
the implementation of the fourth patch. Finally, the fourth patch implements
a parameter similar to ``thp_anon=``, but for shmem.

The goal of these changes is to simplify the configuration of systems that
rely on mTHP support for shmem. For instance, a platform with a GPU that
benefits from huge pages may want to enable huge pages for shmem. Having
these kernel parameters streamlines the configuration process and ensures
consistency across setups.

Let me know your thoughts.

v1 -> v2: https://lore.kernel.org/linux-mm/20241027175743.1056710-1-mcanal@igalia.com/T/

* [1/3] s/fix the format/fix the doc in the commit's subject (Barry Song &
				David Hildenbrand)
* [1/3] Add Barry's A-b to PATCH 1/3 (Barry Song)
* [1/3] s/64KB/64K (David Hildenbrand)
* [1/3] Add David's A-b to PATCH 1/3 (David Hildenbrand)
* [2/3] Create the function `shmem_valid_huge()` to reduce code-duplication
				(Baolin Wang)
* [3/4] New PATCH: generalize the function `setup_thp_anon()` and add it to
				common file
* [4/4] Fix typo in the documentation: s/shmem_anon/thp_shmem (Barry Song)
* [4/4] Reduce code-duplication (Barry Song)

v2 -> v3: https://lore.kernel.org/linux-mm/20241029002324.1062723-1-mcanal@igalia.com/T/

* [2/4] Apply Wang's suggestion (Baolin Wang)
* [3/4] Delete PATCH 3/4 from v2 and implement ``thp_shmem=`` just like in v1
				(Barry Song)
* [4/4] New PATCH: "mm: huge_memory: Use strscpy() instead of strcpy()"

v3 -> v4: https://lore.kernel.org/linux-mm/20241030130308.1066299-1-mcanal@igalia.com/T/

* [2/5] Improve commit message by including details about the use of the kernel
        parameter (Andrew Morton)
* [2/5] Add Baolin's R-b to PATCH 2/5 (Baolin Wang)
* [2/5] Add David's R-b to PATCH 2/5 (David Hildenbrand)
* [3/5] New PATCH: "mm: move ``get_order_from_str()`` to internal.h" (Barry Song
				& David Hildenbrand)
* [4/5] Improve commit message by including details about the use of the kernel
        parameter (Andrew Morton)
* [5/5] Add Lance's R-b to PATCH 5/5 (Lance Yang)

Best Regards,
- Maíra

Maíra Canal (5):
  mm: fix docs for the kernel parameter ``thp_anon=``
  mm: shmem: control THP support through the kernel command line
  mm: move ``get_order_from_str()`` to internal.h
  mm: shmem: override mTHP shmem default with a kernel parameter
  mm: huge_memory: Use strscpy() instead of strcpy()

 .../admin-guide/kernel-parameters.txt         |  19 +-
 Documentation/admin-guide/mm/transhuge.rst    |  25 ++-
 mm/huge_memory.c                              |  42 ++---
 mm/internal.h                                 |  22 +++
 mm/shmem.c                                    | 177 +++++++++++++++---
 5 files changed, 234 insertions(+), 51 deletions(-)

-- 
2.46.2



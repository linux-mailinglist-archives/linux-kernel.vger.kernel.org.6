Return-Path: <linux-kernel+bounces-386097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2582B9B3F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581301C224B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0678F6E;
	Tue, 29 Oct 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NVEpLQIt"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874782F24;
	Tue, 29 Oct 2024 00:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161454; cv=none; b=CdkS2pG+ZXPGtO9E+KYKNbfUQKjpf9AfZQnQtDTGT+Hk/rcV7i5FMcYLHKhPBBxCiP7pRs5MwmBQm7N1wTrrq49Z9rzjnJeV9AfBBrJBtIgLyg5rv7+SCHer8A8QgQUS+aWiNURpePZZ/RbW4yP26EgTFjtYP9yUjVvB6EbgkHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161454; c=relaxed/simple;
	bh=ItBVawkyYZp0EWfT6+0yoKLozZTxgVKCBDrO8HsDXCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RpZU94TZFXF7fWX2Xc/uxPPsWJ+6HanhVqZxJKpMSjgJWPeKiVqaTMI/+TU8NLgpSC7I3I66qGUo8YUsYgRL5P3PmCvVYCR01XmO2SCPdBqlTru7U2H4M1r0t4JNrWpa5BUgARD/ZOnlUVX4x2TTKleyJx7RdBJqq/3KreJ8Ack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NVEpLQIt; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fFRnu4Vhx5cKk2OMgERMj2QYR1dV0sibmG9c5odqYW4=; b=NVEpLQItEvLlotnrUjSWwdx51r
	TLI7pFN3GbUCN0r/6IL209FWWEni3m9SkvRbYtyLhRvs36MCwqfXOb0jKlZt342cjdCkffZ7dY5Xl
	+X3/yMKAH8rcl1j4p0N0HHSMzfBEpv+AsuEe+JXiP7BBnRFYqNDnpQDdz4Coa+RxQy81Kw2I+t5+Z
	UuuEw6cWgb/0pCWafga7PLsTBWDQ3W19nIOMl986ukwjr4uGyuTBnvzNJ5Y6G2+bqEimoGYuBq+zB
	fHIVSuXeKGI9eRhTUvQLoV4ekTRw6SxJlRmZdDd49UQD4LmsHogc/O7UsKNdqwnA8/EFpYynusSV0
	D6BTaS8w==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t5a1P-00GIrd-PZ; Tue, 29 Oct 2024 01:23:44 +0100
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
Subject: [PATCH v2 0/4] mm: add more kernel parameters to control mTHP
Date: Mon, 28 Oct 2024 21:13:04 -0300
Message-ID: <20241029002324.1062723-1-mcanal@igalia.com>
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
controlling mTHP. The first patch is a straightforward documentation update,
correcting the format of the kernel parameter ``thp_anon=``.

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

v1 -> v2: https://lore.kernel.org/linux-mm/20241027175743.1056710-1-mcanal@igalia.com/T/

* [1/4] s/fix the format/fix the doc in the commit's subject (Barry Song & David Hildenbrand)
* [1/4] Add Barry's A-b to PATCH 1/3 (Barry Song)
* [1/4] s/64KB/64K (David Hildenbrand)
* [1/4] Add David's A-b to PATCH 1/3 (David Hildenbrand)
* [2/4] Create the function `shmem_valid_huge()` to reduce code-duplication (Baolin Wang)
* [3/4] New PATCH: generalize the function `setup_thp_anon()` and add it to common file
* [4/4] Fix typo in the documentation: s/shmem_anon/thp_shmem (Barry Song)
* [4/4] Reduce code-duplication (Barry Song)

Best Regards,
- Maíra

Maíra Canal (4):
  mm: fix docs for the kernel parameter ``thp_anon=``
  mm: shmem: control THP support through the kernel command line
  mm: generalize the implementation of ``thp_anon=``
  mm: shmem: override mTHP shmem default with a kernel parameter

 .../admin-guide/kernel-parameters.txt         |  19 ++-
 Documentation/admin-guide/mm/transhuge.rst    |  25 +++-
 include/linux/huge_mm.h                       |  29 +++++
 mm/huge_memory.c                              | 109 ++++++++----------
 mm/shmem.c                                    |  91 +++++++++++++--
 5 files changed, 201 insertions(+), 72 deletions(-)

-- 
2.46.2



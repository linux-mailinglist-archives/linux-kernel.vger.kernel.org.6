Return-Path: <linux-kernel+bounces-525854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D281A3F653
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D693A6685
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F86D20E6F6;
	Fri, 21 Feb 2025 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqIM6cEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7120E326;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740145747; cv=none; b=O9Cf3uowtJqSPUcs7QLOwtl5Ox3j498idU7sSWHLMNryh+y+Oy8sycaE3XzPJ8y00XUmnLl+0NPYFqX8ftIuD+XN3zUGDjn9tbLAE3hZXGQY0EFhsc/OOlVOGKXBD1IvSf3a7UkRDVQ/fE1J4UKIa302prktkhyBYT+XUZzb54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740145747; c=relaxed/simple;
	bh=UalauN8XWtUsTEbYj+PKqhYtpX3u+/YFSuhA5nmw7d8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uytRxnODpgsgOQ3LzFAdfTimyzFWo7kDp00EA43c6X1GwcR/NkODWmsxoImoO2PtpflC4W/kgtc8dIrSB9KLtn3O2vGuWqpqt3i0P4TVofhpFK5JlMiLaf2SbY5uJdzB+jBtS68Jv/PCJl4YED3VZvj/J5kbtHUgz9YodUaNb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqIM6cEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C192C4CED6;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740145747;
	bh=UalauN8XWtUsTEbYj+PKqhYtpX3u+/YFSuhA5nmw7d8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=OqIM6cEjo3PReFp0MiT4cETfcuDeJR++Qyi/nsQZIVM9FghBSr78fRoMt1IGLkEky
	 NMMAAONQX8UGJCYx5Q1I9bjESM+RtWoHGyq1U7kKBHsxQ39DGUXq6GOuQULzqMsn8R
	 qgqQBPkoV64wpPYAlR95a/XXzoiIupQiK5m6Kc/sLUYjhyfuqZg4KNoymJ2O7OVPN6
	 ARqSX9gE3y2P/0OCJGJ+0uO2bMhfe5iT9bYZdCx57NEEhyAXN3MEYwYwAS9krcH/Rw
	 yJdOiaBsnta9j4Q6G4btoRuKeeQ1wXwdnLkE7Oj3W3WzD3nOJpu7UgMBAufAiTZvmn
	 jGEf0SH3zuxdA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1101EC021B3;
	Fri, 21 Feb 2025 13:49:07 +0000 (UTC)
From: Thomas Prescher via B4 Relay <devnull+thomas.prescher.cyberus-technology.de@kernel.org>
Subject: [PATCH 0/2] Add a command line option that enables control of how
 many threads per NUMA node should be used to allocate huge pages.
Date: Fri, 21 Feb 2025 14:49:02 +0100
Message-Id: <20250221-hugepage-parameter-v1-0-fa49a77c87c8@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+EuGcC/x2M0QpAQBBFf0XzbGtNlPyKPEzcZR6wzSIl/27ze
 E6d81CCKRJ1xUOGS5PuW4aqLGhcZJvhdMpM7LnxzJVbzhlRso9isuKAObRNzWEKoxdQDqMh6P1
 P++F9P6ZOKcZkAAAA
X-Change-ID: 20250221-hugepage-parameter-e8542fdfc0ae
To: Jonathan Corbet <corbet@lwn.net>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Thomas Prescher <thomas.prescher@cyberus-technology.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740145745; l=1895;
 i=thomas.prescher@cyberus-technology.de; s=20250221;
 h=from:subject:message-id;
 bh=UalauN8XWtUsTEbYj+PKqhYtpX3u+/YFSuhA5nmw7d8=;
 b=JfCkdFsZg1zFxVgHw1RR2OOZrwWQQ4+CJPZufzTC/zoCX918Y1i8T5b22UG2JM5RDv9J1D80m
 Uwxd5zbJJTADWO9UMhCRe7u8qHjPlCmGfjpSD4XvLx4UDMa4ecmxOg0
X-Developer-Key: i=thomas.prescher@cyberus-technology.de; a=ed25519;
 pk=T5MVdLVCc/0UUyv5IcSqGVvGcVkgWW/KtuEo2RRJwM8=
X-Endpoint-Received: by B4 Relay for
 thomas.prescher@cyberus-technology.de/20250221 with auth_id=345
X-Original-From: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Reply-To: thomas.prescher@cyberus-technology.de

Allocating huge pages can take a very long time on servers
with terabytes of memory even when they are allocated at
boot time where the allocation happens in parallel.

The kernel currently uses a hard coded value of 2 threads per
NUMA node for these allocations. This value might have been good
enough in the past but it is not sufficient to fully utilize
newer systems.

This patch allows to override this value.

We tested this on 2 generations of Xeon CPUs and the results
show a big improvement of the overall allocation time.

+--------------------+-------+-------+-------+-------+-------+
| threads per node   |   2   |   4   |   8   |   16  |    32 |
+--------------------+-------+-------+-------+-------+-------+
| skylake 4node      |   44s |   22s |   16s |   19s |   20s |
| cascade lake 4node |   39s |   20s |   11s |   10s |    9s |
+--------------------+-------+-------+-------+-------+-------+

On skylake, we see an improvment of 2.75x when using 8 threads,
on cascade lake we can get even better at 4.3x when we use
32 threads per node.

This speedup is quite significant and users of large machines
like these should have the option to make the machines boot
as fast as possible.

Signed-off-by: Thomas Prescher <thomas.prescher@cyberus-technology.de>
---
Thomas Prescher (2):
      mm: hugetlb: add hugetlb_alloc_threads cmdline option
      mm: hugetlb: log time needed to allocate hugepages

 Documentation/admin-guide/kernel-parameters.txt |  7 +++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  9 +++-
 mm/hugetlb.c                                    | 59 ++++++++++++++++++-------
 3 files changed, 58 insertions(+), 17 deletions(-)
---
base-commit: 334426094588f8179fe175a09ecc887ff0c75758
change-id: 20250221-hugepage-parameter-e8542fdfc0ae

Best regards,
-- 
Thomas Prescher <thomas.prescher@cyberus-technology.de>




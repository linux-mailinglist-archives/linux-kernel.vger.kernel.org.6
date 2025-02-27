Return-Path: <linux-kernel+bounces-536783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA4A4842F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96FFA3A61D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94426E160;
	Thu, 27 Feb 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usLEb5qU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539441AAA05
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672063; cv=none; b=oc3HLqy/SZp2v0AOI7//n6A5X+mCrbuEeKyxMSusbMUUTqJxLpM6gkbIx5zJE/Hil7SXNDzBUQVcSPJ8mNWcmZwzKoP0bxB6HHqcS5yN7uZJ7jvkjkWh3TQXJK5ifuHGIAoA56G2/UB9zQAzJST8gWeArHQCLmE+Kxfd0m2q2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672063; c=relaxed/simple;
	bh=DA6h6NCIFzbHc/LBuE5Nc7E6U4uAC+b5NlL7eVnRDsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq8a81qi9EVJVgqgsmq8Nsv1VDu9pZzKc+8/L7Bo90H6QkGkMRqi+sSoElhakGNGG+Mhabc8iOhWWi14TyCS5SMdga0Sey6y2NCd/qvkSUBKp0ukZJQejUlGIgNtvusKq2Y0Bb0r676B53LfBwHJOJwq3yJm207JPnco2gtliVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usLEb5qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABC5C4CEF6;
	Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672062;
	bh=DA6h6NCIFzbHc/LBuE5Nc7E6U4uAC+b5NlL7eVnRDsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usLEb5qU1wRv+o2+n2D8TlO/RwEBj3VXtUlYZ5NNABe+2jYbgfLtQnFI6A7Aq4W6P
	 puDv2UD2lwXEum5jc4RmvjrLgxdubv4tD6Stk5VrVMg+7KKYSLO+TNVPh6cy7ZULII
	 d4ZQgw9rUi0Hea2k5bfKumqumALF0f1OmSKxLhOG04Jbw71cgJN0cgEOjLyt18opjg
	 cICATzPZaopFlQN+/biu1SlZurnD854etUTsLCIctJRK+j4DaWbFQEKjZjul9lPPfN
	 RcKdOvUOhxN9pCjuXNT8soe1pxiji8iXjvPndEy2Wm8abT8cVtIljoqddS61QIzr2x
	 eoKhzv21uSy8A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tngJp-000000023bX-0L9q;
	Thu, 27 Feb 2025 17:01:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/19] tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
Date: Thu, 27 Feb 2025 17:00:51 +0100
Message-ID: <9b15b83ec3726b6f29583d419e0c6c6aa01a9447.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

We'll be adding a new GED device for HEST GPIO notification and
increasing the number of entries at the HEST table.

Blocklist testing HEST and DSDT tables until such changes
are completed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..0a1a26543ba2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
-- 
2.48.1



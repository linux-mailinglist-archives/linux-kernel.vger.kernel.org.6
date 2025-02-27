Return-Path: <linux-kernel+bounces-536777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB475A48442
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CA174046
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90021B042C;
	Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7ieHFW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7681A8403
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672063; cv=none; b=le9tZtFdAPtn5mtvaXEm7py4h1Nu+GC6sqVDfLH3EAmYBIZ3NMvunnGgvDWEq+oASgutxiyNcmHmGF/F42n0ucrBitXO+FJmio4erlOjMCYNYpKffypSeWkZdW4rkUTC4gvA2wRFOn79TW+y5U0zPSvxkJDCEDSHCrNqNGaaRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672063; c=relaxed/simple;
	bh=2V2qGBdYTM/mEFLNcLhl2H0xSYVkrwUTZ+ehxBlBqLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVVdyZP4N4hrSUgPBJ191W5IpXXSoU4ePEnYxkiidaR27boWPb67EeoFJl6/y/7mZuIF5GbRJF5lNEruaDYn8QiURmF8LNhC7HniX9dNgzjcB7ui0w1gGRb3eNoQyJVjaDvCAQEATjv6ChEL79HVQEjlrirWPonoQLHIh9llLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7ieHFW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF96C4CEE7;
	Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672062;
	bh=2V2qGBdYTM/mEFLNcLhl2H0xSYVkrwUTZ+ehxBlBqLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7ieHFW40eJ+G80m492ZISdav7ZnrMklLD0iiW4WnUOiKgj9okzNzmZnq2L8xFha4
	 uKRlrZB1n31r4ByW+chYfEWZgNEPRxQrDsIZeBXKREmmQfTB8x+gF7S8uZyJudBG74
	 iGKm5YpiIiwnmKuZ0OOxvm5tTSoo0ix1JoG65KUfgG5EbsdAVj2BIpgqddeMqxs3dx
	 JJEiYwKFp2fdMIQUYAGo5iewf9hw14e9kGJZvdYxsH9KUgGf+CgPhJDvha63ASr+rH
	 SspHqPeSSrgJpOC8jOAAwj1p+1wboVk9afPfY+55bv0M1eJPRNUp81jwTixKSR4aGW
	 Iolif/t8kPxLw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tngJo-000000023at-3KcO;
	Thu, 27 Feb 2025 17:01:00 +0100
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
Subject: [PATCH v6 03/19] tests/acpi: virt: update HEST file with its current data
Date: Thu, 27 Feb 2025 17:00:41 +0100
Message-ID: <342f2cbf20eee9cafbee834adc66ae81aa4df37b.1740671863.git.mchehab+huawei@kernel.org>
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

Now that HEST table is checked for aarch64, add the current
firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/aarch64/virt/HEST           | Bin 0 -> 132 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4c5d8c5b5da5b3241f93cd0839e94272bf6b1486 100644
GIT binary patch
literal 132
zcmeZp4Gw8xU|?W;<mB({5v<@85#X$#prF9Wz`y`vgJ=-uVqjqS|DS;o#%Ew*U|?_n
dk++-~7#J8hWI!Yi09DHYRr~Kh1c1x}0RY>66afGL

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 39901c58d647..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/HEST",
-- 
2.48.1



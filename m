Return-Path: <linux-kernel+bounces-536776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAACA48425
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D547A2642
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1EB1B0430;
	Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epiYbi+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71B1A8402
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672063; cv=none; b=VINX28ahK5C41F+Ej6wuTgdVW9eirTdnGtA+PjgMqHLIn+gMVM/XbsIwrhIraTRR1njXIii09TsD+mfJ38bS6vJ7hruvME18fp0QBMsL8kEddm3gva7aQ2IeerXHZ9ngBumVT5ylTeSPaQj+nkuA5T8X8srK//zpSoincJaVk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672063; c=relaxed/simple;
	bh=iDgAO7mir8XQODJDtQvfnJPGdTIDX8Gz9fG7yH7/i1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBcSToMGxT+djEmYil5BK9bhLzwzONEMC0h+AZIc0HFeXKKWGzN5MjkhphuGUboIOG/RLRJ7YBBj9evxRVlPRuiYh+vdMIV8k4zsVnT5unW6Ml3sUSe3x+x9k35qv42pahrCIonDAFoJhyVsW9KpQouVbg6EMW2c3SIdJfwxLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epiYbi+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89229C4CEE6;
	Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672062;
	bh=iDgAO7mir8XQODJDtQvfnJPGdTIDX8Gz9fG7yH7/i1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epiYbi+uY5SNkVdb+9ROk3zLKivJAVj3NKoqPn/wlfovwB/LEpjdBKFzX4e3VvczO
	 LT3I75o/eSHOredN0+1gt9TuXzOkhHdpwBF8HGNN+R1pBKw3Pjhy6K0+YBzvRlN9E3
	 cfMNhh6uStbCQX4f5UN3wMbgxQABJu1bmdS1uJF/tcmZ8rIOxltZ10A8DnvpMA9NnP
	 bIreSLtkTrGTCAt5XVno4yG5ALvIUB6NQWpFbl+FQtQnwA6vtj+QJQznpGEPVhpMXK
	 WalRn5CvSW6LnkzitYooyDApefz1EtHV3YFFohOW8ntwCft3tui6yo7A1RmyuPiY9f
	 MunU2kcCZHqrQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tngJo-000000023al-36Z9;
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
Subject: [PATCH v6 01/19] tests/acpi: virt: add an empty HEST file
Date: Thu, 27 Feb 2025 17:00:39 +0100
Message-ID: <4d281b9312cac07460ecf7822512031e778ef6b8.1740671863.git.mchehab+huawei@kernel.org>
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

Such file will be used to track HEST table changes.

For now, disallow HEST table check until we update it to the
current data.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/aarch64/virt/HEST           | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/aarch64/virt/HEST

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..39901c58d647 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
-- 
2.48.1



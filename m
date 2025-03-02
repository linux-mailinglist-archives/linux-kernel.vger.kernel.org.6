Return-Path: <linux-kernel+bounces-540438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8151FA4B08C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B22C189346E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD71E4928;
	Sun,  2 Mar 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTe2e0ft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E31D7E37
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903737; cv=none; b=WCbxXtyqnQQO19c/B6hLsfleg8igAOFS2o8kb4D7sQ9RnpR1irRIfzbKBsUtxEzQ7mDwTAXEyMkYJGTOsUn9JynuKznQTSI8ZQ+OBXu2vh/QZrjIve4pMNms0jM+iydydvcF3PBKIcpjJrhh/fOW2xa9FMlO8x6xhSNs3DOS69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903737; c=relaxed/simple;
	bh=PiuWIkSjCkUR5cKMYl3R483tUjOwqr3t/DK02cU26Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep0A5veNfBHXLKi9LFoE02Hxg6Eu0pDaQCDZ6NAhe8AthukwWfk3qdE2H9zTnqszHtrZPFMo2EGr/PnPPfZIgPJxD+OGxAkrNaXC+p4NU2NjfNImxHOXXqD+xaH8BmiqMw3wdvM0LOeF3eRKGS5UVu11EN+6/W59vLEGpZe+918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTe2e0ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F132C4CEEE;
	Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740903737;
	bh=PiuWIkSjCkUR5cKMYl3R483tUjOwqr3t/DK02cU26Gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTe2e0ftmwPQyJ7zPsqZJSSQXrUwb1+2J2WDMCZ9kbmsGoqC+TLcIlqF2dkQNflH2
	 UUi6XFRu+TYak5Pc6s6/CUax1coToXZI+eGiBnH89vVci2dyzhUnftEvLMtGKxv+rd
	 M1pTBSAz91SAudFIO2NvSialoq6KXpMwhLOB2qJEXMhcDZ0rHbFW0NaaHUQl80TMmv
	 DzR6WwrTrc+YQI472Vsr5Wt9symaTQ/Zbd/e/9aowKeWswmwunJkPGqmQ8BdBzPUR5
	 Ib5YNSWva2Dl4Ug6Cy51RLXSY2LHq2uuVJQ3fK/XgT/5N40E9QmVjpgLJFRCKit08g
	 OfpGkEgGBQ83g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1toeaU-000000043RY-22Ba;
	Sun, 02 Mar 2025 09:22:14 +0100
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
Subject: [PATCH v7 01/19] tests/acpi: virt: add an empty HEST file
Date: Sun,  2 Mar 2025 09:21:48 +0100
Message-ID: <f21a8265ea34d1a6ebeac2e201b4846cd3809c23.1740903110.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740903110.git.mchehab+huawei@kernel.org>
References: <cover.1740903110.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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



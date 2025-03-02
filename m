Return-Path: <linux-kernel+bounces-540432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472DFA4B081
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282E216DD04
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D6E1DB12D;
	Sun,  2 Mar 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSS40f6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E921D5141
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903737; cv=none; b=naMupydGjCzU+oeS7NwwYs2qyWDL0OrQPibTOlAkdFnBcEmEEH4k8EyVCLFMNBK+WDsDcfwBBT12paeYKWIoYgcdnMXRQ7K8/NoIh00eTFlL0DfZSNzgnlaecGv8bxaUS09qCthyqWY/ALC8sRZvO4FipnglTKu1svtab9CS0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903737; c=relaxed/simple;
	bh=VNVwBUg9DLb/+TaZToRj4L6G17tMKOtxkr5IyNsYATU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0qGcs4qrELbRh1V9W3M36dBMaajbnvEfyZGcI0jmMgFSpsJudPPBknTaUOy8d5PQ+Ucd1iSpzF72EjA6rCHA4j3ES42A7UMAgbBRnnUkm4O8vUaP7uK+tWgB2uaWqaXkbYXcthQGT1NTddN9OIiw1Htb+BEs8eiYA9SgNcg/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSS40f6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0185EC4CEE2;
	Sun,  2 Mar 2025 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740903737;
	bh=VNVwBUg9DLb/+TaZToRj4L6G17tMKOtxkr5IyNsYATU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSS40f6RsePRcoG1/rYkVGoLkR2C7kKknBwDYui3B8sniBfETUV1lSGmrX1qJXEn4
	 FlFtlQFwEQeB1iDzeuLqZ2NQ488z5qV/nmPzOuYMni/7ainwxXv46cwUcjUI0bFI2k
	 UocUlG5Ip6J0LrDEaO6MOlNrJ6O7g8b4DynlZ8Gj/CwyhIBeTS18iAkwUUAVQKqyfL
	 z4qy166UDBfT/6uV4OsOexLfPw3Qf8da/F4Il1X2O/Ej5LCBx7ZRaazhJfkzkNlCvg
	 0MIysfcskChwwm+NcAeuegxZZCNz1raIvUBiUoqcWWI9/Wmx2+NizgeOVEFPaVcFNy
	 O1HMOYlaC4oLA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1toeaU-000000043Rg-2GEO;
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
Subject: [PATCH v7 03/19] tests/acpi: virt: update HEST file with its current data
Date: Sun,  2 Mar 2025 09:21:50 +0100
Message-ID: <fd2ca5357efb92aede7e6101b7bf7a1b46fad50d.1740903110.git.mchehab+huawei@kernel.org>
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

Now that HEST table is checked for aarch64, add the current
firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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



Return-Path: <linux-kernel+bounces-551816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39589A57154
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4710418981BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECF72571A2;
	Fri,  7 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO8+upvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA412512E1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374898; cv=none; b=Rw/6aoMoxR3Zuaw+mQ8DEG+MOKFassgY0Wqo3ePhEJh3gGsw9sFO5tcz8/4Lgu2QTRUtihqL/RxTllKpPNF+I2P/SkR/vwRHwhwH8zd8BVxamdPpPHV+SEye9puAenIKNGk3nYidiAK1zUxGjozG4ntTgmNzNMGBdjtobe0R1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374898; c=relaxed/simple;
	bh=VNVwBUg9DLb/+TaZToRj4L6G17tMKOtxkr5IyNsYATU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3Etp6a1sZQvaY8GOwyWQeTLdvTRTkdWQZTT/VxZdvopOEO7cDokrQ58SQh5bq/y9aWsqFU+URw1dWjAvxiHip7EzlVhMz9JkUQD8RdgsWF4hh0ms+Dy6NyO0dYDZLzDfj9pw7xeL18sKw63OBuiXPYlg+9XiNDw0ThKh0IyNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO8+upvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC71C4AF09;
	Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374897;
	bh=VNVwBUg9DLb/+TaZToRj4L6G17tMKOtxkr5IyNsYATU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DO8+upvKpdj1XjGnfL+q0bhszRi+bVr7lP3Q5GvjKOHK914PuHAsZ4NXRhR0vnFI8
	 tHJtphCstCxvje8hr/q9PVVDmcvhPMCTdOzi7xhEZTce0rb5zSykVIQPOmUPbbZtS/
	 JKcRvDBaZZueg6KR5V5D8c7CfBtuFESyy5Ut/jXHh5B8YONcIgkj5JXu6fxGNIsmyj
	 Ej2MwwuPdDV85kuErOaeWOQooedwRfpvoflvV3nBBpN/qZnl1W1Xg6sh6Tce9Cla99
	 plhu6FFrE7TTxhkaYxptO4d81Dt8hvQUTYBFjPGKbQmG2UvIV2yd6S0DFajxR+BxlS
	 GPUemy/LD9AsQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tqd9r-0000000BQmN-2xvP;
	Fri, 07 Mar 2025 20:14:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Gavin Shan" <gshan@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 03/20] tests/acpi: virt: update HEST file with its current data
Date: Fri,  7 Mar 2025 20:14:32 +0100
Message-ID: <d8018aae7fb35b7f7882ff590676568fbf2fb2d6.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
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



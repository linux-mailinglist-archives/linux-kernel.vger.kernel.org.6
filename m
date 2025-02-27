Return-Path: <linux-kernel+bounces-536066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C61A47B23
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0E416B401
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB222B8C6;
	Thu, 27 Feb 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2CQdGU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972322AE65
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654238; cv=none; b=qIOaQ7XB4zhmGHfzDZOsxny6j/AqQ8uiJku2yyQwZS/T4K0spAn2V3I7fy0BbCJ3M9CNMuofUX1/zl/nj1QYKj/uGUOT77w0CmLQihxaxPMWKfqVBWhsyr73vwoaBSVCq6HiE2UiAqmt1jiB4/7jPYzwZTowWEVBk1dHdkyu/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654238; c=relaxed/simple;
	bh=lEo2jNIgAk3ZjJgy5xIzg8AzQhxCgrbkVelQc/it8Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f72E4X5JFsKG2efIJ5OOc/JqSw5237BrNuxiosj+rV5YEuQ8WXzaHhvCsvqS2FWmY1YqyI5T91mooOL4cGOoGFAXshqQCrYRsE9IxqbufQV2HYZmuDAWBXQxaegl+HrQAIP6uUGKACHccVyzxlNGGysprjSavq7wKRT4eRuXHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2CQdGU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF75C4CEE7;
	Thu, 27 Feb 2025 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740654238;
	bh=lEo2jNIgAk3ZjJgy5xIzg8AzQhxCgrbkVelQc/it8Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2CQdGU7i6faoDJLGZ7crDGcRR4Bg1TsSA7iCjt44ot3hIkO+UCOju0tThQSVecdT
	 XuA95nrBN/pjZ37KUx3Kq2rAp+s0eg7ipzC9c7r2RvVv15r6eFGj6mkJF1M9Uvm5hh
	 wA2pQY5vqgV16yRYofuMeYvDOYLzFoBVkl3oT5j4wHVH1vhk9skSSa4kHB5JV1MQMs
	 8dwhpq7CEwtyiWFVAP9wzm83Hh3fibDr09zWYVljxaOEv1yMBcwBiXaaFV39uS8ooe
	 De5JRmQQvFmiAXTvLcK35NMbYpoQq3zNQP26AvaJOxboLf3ewkmIcVrLE18NB1YjgW
	 ygc7yBDdAWWnA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tnbgK-00000001mQe-0Eii;
	Thu, 27 Feb 2025 12:03:56 +0100
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
Subject: [PATCH v5 02/21] tests/qtest/bios-tables-test: extend to also check HEST table
Date: Thu, 27 Feb 2025 12:03:32 +0100
Message-ID: <3ebde58416b8be1140c569538192399feeccf412.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, aarch64 can generate a HEST table when loaded with
-machine ras=on. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/qtest/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec43536..8d41601cc9e9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2122,7 +2122,7 @@ static void test_acpi_aarch64_virt_tcg(void)
 
     data.smbios_cpu_max_speed = 2900;
     data.smbios_cpu_curr_speed = 2700;
-    test_acpi_one("-cpu cortex-a57 "
+    test_acpi_one("-cpu cortex-a57 -machine ras=on "
                   "-smbios type=4,max-speed=2900,current-speed=2700", &data);
     free_test_data(&data);
 }
-- 
2.48.1



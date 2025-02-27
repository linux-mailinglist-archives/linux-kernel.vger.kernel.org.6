Return-Path: <linux-kernel+bounces-536775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 909A0A48443
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EC0177171
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E991B042A;
	Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYKcLnKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6721A83EF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672063; cv=none; b=CPECF/f3LQMOXM+a3GY+zcf/UHfv+KBEUi1I0en0Rhx1JztkSnreUmVu6CbD1Oxfesh6JRAN9d0bayIgqSE/15Z/lKBjYCUY27gvj/7AlA/ItaFZysG32IDHQTd/RaDALmgiq+VxJayVxN9MZZlp8AGFbbJtJCryTWfMqUdIetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672063; c=relaxed/simple;
	bh=MSQW5xDS0P3/8o9sLNqQf0SlrA9+pAo9/1dnEczuABQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjdMm2JZLUhaPyGQV00NU4NbbBL6mexBEChNKc5IpWafvFuNZEHADxirfb63/OchrKqMe9EMcix9J/Ik/LV/5PE8+qCj/7HAMfDFa7awSGCAckCf8EiNM+rgcgtbjY/xDHhzba8LzUg5YISlyQVzzDLfEb9fesYwMbrJzQJX9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYKcLnKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A2C4CEDD;
	Thu, 27 Feb 2025 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672062;
	bh=MSQW5xDS0P3/8o9sLNqQf0SlrA9+pAo9/1dnEczuABQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYKcLnKMvqJVtpScjQtuyrDmMzQnDFVfjrjp4xWVVZlP0BW+owjpqnLj5+44RVs8a
	 tYK7lMvoJwhGes+Pu+chqC13Oo3BbGUBR1UIeRPteQ3PJU8VycPk6hMwNRVZYHtHsb
	 bWtt1o2c9BpfdYVGgzJhulGqu3M8HfL1lrki2348LWFjonGhU9e9n0ZirKObL2FmDe
	 Bv9Ex9ar+TNJtNbFRE9im/jKNjG0hjrWiBa3dKJ9qVnB3VbS2eQWt02+qrYI/xPSeo
	 x/0ebwGYh+AyfErf8azRmSjHV2nEqWeycDw0Qyv/f2n+9RHprvHzoq2TmMpKLp8Yc2
	 QFf3zgFTuOOOQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tngJo-000000023ap-3DRt;
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
Subject: [PATCH v6 02/19] tests/qtest/bios-tables-test: extend to also check HEST table
Date: Thu, 27 Feb 2025 17:00:40 +0100
Message-ID: <b7d89527bb3efc48fa1035beca28ee7f414d95ac.1740671863.git.mchehab+huawei@kernel.org>
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

Currently, aarch64 can generate a HEST table when loaded with
-machine ras=on. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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



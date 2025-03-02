Return-Path: <linux-kernel+bounces-540436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CAA4B08D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F057C189394A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703311E4929;
	Sun,  2 Mar 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv2dG8fu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44431D7E2F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903737; cv=none; b=lHyZ/QidA3nv7NeGqQeuY2nuT6VlwiO1aRfiSLCM6bNTYYHuzM8aPf/V8K+4OGz/doOG8Fc2FaUg37SVaEnge5yCcvkSEJlKeGyCvPkS2WTwTyqlpHfAUJYYzeRJwbvzYv34U1NxN3YZ6+3I8vXgKenUQjUYqo8Q/5cxSh/rMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903737; c=relaxed/simple;
	bh=AJ4q+ksNB/S+00rtzYs71awF+2iIilrq6aaRwUt1Pzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewnLgE+hOBFjLcCCnvaCSCuEZDALg4sml/WE3VWeJLjUlcVd6lF7q9D4GJ0ZijOeu41NgXWKMwy3EaLTQXIA6Pyl28iHikDVXJLBJXiuRzguIWl9QgZfJvyFr+rt/s8b4vRzER+hn6Uwvwb1iW9Hn/ImDs81P/0XHce0YVkgmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv2dG8fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B52DC4AF0D;
	Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740903737;
	bh=AJ4q+ksNB/S+00rtzYs71awF+2iIilrq6aaRwUt1Pzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pv2dG8fu93ct+79d/61JpiusgAq+JoLHAphAK7sZs3hmCDzIsS6x+lfj1la+Cej6c
	 bJTG2UyrKVSrPqdHeRdjhTUHw2fo1dh7rIsuTp9pvdWTkGRJ5kFTrb6sB87K2BltTY
	 4iuwWpWHkNMuEchvUnKDoxabmratY22MizJLar2+/NV29PDfy6YbbVorieEPcye6Ld
	 7EYpsUoIJsmzrw4Bknk0/U7uN6ekGix79pGh6jUzFHEnx+GUYLZznfRG2+9z6HsOlK
	 9JbmUj1vroWPCdjccqScHT+qzkXzyVPbjUxm+0Q8APxN82aDdEvUgp3gohaJPoMaC6
	 RQUTkNShgweRg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1toeaU-000000043Rc-2945;
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
Subject: [PATCH v7 02/19] tests/qtest/bios-tables-test: extend to also check HEST table
Date: Sun,  2 Mar 2025 09:21:49 +0100
Message-ID: <d0f7dcb187f4b73ce9ab88c701d802756d8dda1d.1740903110.git.mchehab+huawei@kernel.org>
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

Currently, aarch64 can generate a HEST table when loaded with
-machine ras=on. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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



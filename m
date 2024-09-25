Return-Path: <linux-kernel+bounces-337987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B953F9851DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48D21C22FEA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D4115853C;
	Wed, 25 Sep 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYfIcqzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130814E2ED
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237088; cv=none; b=Qd58tIQea6J4k1e4gOtUxJUmwgMBfG91ujJN9w52a3tp2BwiQYUPxTwkX8W6JMNkcmKpavStf3IBxwt7ww7XXwbcRXN56E977BVJVbdlervJmkjazERPM3kUcsv7G/mlmR/LyT6UH2GRjzg7ny786vXywHnQXtgEMOKva1Wwiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237088; c=relaxed/simple;
	bh=v8wm2+xdvIMDHDnfcAvH4A02Zc/d9CmE9Hcf+GpD9Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kolzk2kgaMs0+2WSK+1SiKtk+fHebUL6Hvn6h2ZnlUmMnM7kQIxRFlsXj7OKCKI8AiX+O8dNRCjPo+zNrB9Hxz/kPklbVwLZYJwaUN5xZAmXGV6h1q4PmYLDKyBQZGmzXjrh+t1Ee6OyItTgUioLKbceTlQH/CaL2Iob/OyPVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYfIcqzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6A1C4AF10;
	Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727237088;
	bh=v8wm2+xdvIMDHDnfcAvH4A02Zc/d9CmE9Hcf+GpD9Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYfIcqzp0UzZL35M6KmLaIhTwWDDmhYeLyKGKZf0S6NBRGxhw2bXRf0DzK7zFVui7
	 BocC36UvUywwEqkbEMkUZ9Mihv8btx8wvwWZzzf3e9U+HB8K4LH093mXdL2HF3K2sI
	 Xy1/is87vKOOvlzahmdVL6RozbPchWiPE3BSgDBFTafBRDAA3QxbfKLGiwVuF0IidF
	 oXgKoAAupEDhclaGsw3CYEa3G89mMSUaG5FlZjxA5ag4VzHHlxYOHa95pohplyIYHR
	 boRHKO5b2mpf+oHB+fDIvl85w1qYEhoIdP+lnrb9uomhlRakkzcUZZZ048eyZ7P665
	 mOi/y53KjakBA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1stJGg-0000000828P-1YBD;
	Wed, 25 Sep 2024 06:04:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/15] acpi/ghes: don't crash QEMU if ghes GED is not found
Date: Wed, 25 Sep 2024 06:04:17 +0200
Message-ID: <dc61673f18e44b0c169762a084b77acb6a76c738.1727236561.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Instead, produce an error and continue working

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 3af1cd16d4d7..209095f67e9a 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -418,7 +418,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
-    g_assert(acpi_ged_state);
+    if (!acpi_ged_state) {
+        error_setg(errp, "Can't find ACPI_GED object");
+        return;
+    }
     ags = &acpi_ged_state->ghes_state;
 
     get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),
-- 
2.46.1



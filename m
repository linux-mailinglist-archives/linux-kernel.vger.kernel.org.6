Return-Path: <linux-kernel+bounces-536078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE27A47B34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EAA16AF29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD222E004;
	Thu, 27 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAXPfdMC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579822B5B6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654238; cv=none; b=H4jifQY4kUqthOJJ66x2x/UVaulIt6R8orMd0iEfEztuKFwY8rsc3Xd6Op6Jcj91zyeSKWVIHP5X1RlZH3Yns+PrxUqs20xK+mDlAvJHzPOFouRtaCxReDnoJnO/eh3mX2Dye/jkKZUCVtLSh38LLunUJ7GgCyLHIO1abKj0ClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654238; c=relaxed/simple;
	bh=k5E8zYD/Vp0nYR8SBW8TZ3Ix4TuME3pXjKPF5NCHL7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqmgcEXXjCCP+vdZyTBTmyT4Wx9P6Clx05B7CsN2gakiWU/DoRavTdHaDI+WX/5YxuhEc8gwVJCRpXTUNkvsGhFBwrfkkJ1y430uwttK9FpP2ncv10WBC6cO/L5NbkYNq8q/5lWA9aMbU0znT99xt0B6ug6nyqb2cYAh687I6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAXPfdMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27009C4CEF6;
	Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740654238;
	bh=k5E8zYD/Vp0nYR8SBW8TZ3Ix4TuME3pXjKPF5NCHL7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAXPfdMCrMPBU7IgB4t5XJ/BQJkIRXb3OenmvoEGV4Kdd50m7ma1vEVvieXJZukEZ
	 A7LtOryDUG0ckFqqhJe+EOA0fYBiSIeV9OQ9RIPAUclFn4ZOAkmbGAo3P+uYdiUMgV
	 OwKAS5LOWxSd5r9Od4gSIg8P4BWp5eNVnVajF0T87Qqe/f/XO9/zeFeR7M16F4F1Gu
	 OQZ9TwjXl0GLFKR3AqMkwjmQ0Mh++ctP2xmR/7UBeO6FzLnJcvJbADB3IP/xayIA/2
	 wx/ikDbMTa7UdxI/QqDML8wIK2mJ9tnAiIIIkIJCHawV8KyElEHDbI7asWC/nLrBJu
	 HD6dQSXCxIc/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tnbgK-00000001mRA-181Y;
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
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/21] acpi/ghes: create an ancillary acpi_ghes_get_state() function
Date: Thu, 27 Feb 2025 12:03:40 +0100
Message-ID: <a84cb4567f087231991ce05980d2f331b772dab5.1740653898.git.mchehab+huawei@kernel.org>
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

Instead of having a function to check if ACPI is enabled
(acpi_ghes_present), change its logic to be more generic,
returing a pointed to AcpiGhesState.

Such change allows cleanup the ghes GED state code, avoiding
to read it multiple times, and simplifying the code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by:  Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index c3a64adfe5ed..0135ac844bcf 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -608,7 +608,7 @@ AcpiGhesState *acpi_ghes_get_state(void)
     }
     ags = &acpi_ged_state->ghes_state;
 
-    if (!ags->hw_error_le) {
+    if (!ags->hw_error_le && !ags->hest_addr_le) {
         return NULL;
     }
     return ags;
-- 
2.48.1



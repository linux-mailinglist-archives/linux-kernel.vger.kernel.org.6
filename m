Return-Path: <linux-kernel+bounces-435389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE159E76F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C178118824FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7A219EA5;
	Fri,  6 Dec 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fycifNtu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2FD203D46
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=EXJBsO0uWF4ZdZx19sQQEjxZpMu3/kcVrZbYf90iP7NlflBbxNsw9kLtQ4qU7Fvz9IUji7yL967ESkd25mZxMI2fhzf34zxiaiJGVsEClOtLvJhyB6wF2uZVwR+z9sQRGauCKAqBR3Frw205jcCwBDLd65yfjsKv9TAsbtMBQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=EZFsmHMf3WbcMSlyh1u3n8d24jrZ2fM6gqwzFgnZ1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqZCva41YHXw25+AOm1gldq2RpNJ583N4L3RC+VO0acMpFO9GtNtyU2ykodkDwAx5lKxUyWP2vC5i3TWvmPWOMle+WlBRybrL5WZHgfHSNtBt4r7gJpxHZSKkQlSxsjEtyYvm9KmERF8S/AEiAnc7fDJFu2liR67BtID5xcnwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fycifNtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D053C4CEE9;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=EZFsmHMf3WbcMSlyh1u3n8d24jrZ2fM6gqwzFgnZ1EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fycifNtuEjP/MCgBm6JPBOptAWGUXxqwpD0CxnlHGZhhvRp8hijf8XEaBY0uOepN7
	 csBVDTTb5kycySak7Mz+TOlkk1ce1/XX2JpRSA1z+7MMykODETLNtwx0/T9+XS6VE4
	 rl6J4eDIoKloPSA57yAG8l2HdF2qBJojnBGOasH+FsX7YVYgKe9karOf4oAiCa2IK1
	 KVycZuZ+8EEZ63qZn6L3JLC8QWt6wofvVsFjSEDv066GLiMEzdXrYmrCakhmmZIjXj
	 9MFux4Ha415G3zqTWXPrqMdEojGlQACqAYa5hquf0bmVYpFPYxaLxfYq0PdUUrcDsK
	 /ehphYruOdgqQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc17-00000005RKE-3DUg;
	Fri, 06 Dec 2024 18:21:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/31] acpi/ghes: don't crash QEMU if ghes GED is not found
Date: Fri,  6 Dec 2024 18:12:33 +0100
Message-ID: <de6e3d9b672d780b9fb778f6e11c6f4df43bc1a4.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Make error handling within ghes_record_cper_errors() consistent,
i.e. instead abort just print a error in case ghes GED is not found.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 414a4a1ee00e..2df5ddf68a13 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -371,7 +371,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
-    g_assert(acpi_ged_state);
+    if (!acpi_ged_state) {
+        error_setg(errp, "Can't find ACPI_GED object");
+        return;
+    }
     ags = &acpi_ged_state->ghes_state;
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
-- 
2.47.1



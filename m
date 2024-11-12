Return-Path: <linux-kernel+bounces-405572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EAE9C52FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A8C281F25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B21B2141DB;
	Tue, 12 Nov 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfJp4/p3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148F2123ED
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406510; cv=none; b=rb4nUc+nnXNyF81KUtEEX4Ta+L0vL1QlqOXM4c2F/R0+T5ZDt5LvnpFN9go6yr/RpbqlpFY5vqK9p4bvKsZ5A+m2/6ipeu5J2922I+SsBIfLBFTRflf587Dfg25CxRYy3wM3yN8KjZ/qtzh03yH9zQ2KoGVjEerkcSu7S5tqQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406510; c=relaxed/simple;
	bh=PcRTyEBS2+gRvLkAqL7u8VMaelZPeW1sVQkkas/F7JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPhKZSSFO9CqR507PCwFTb3UixWJpqBtbPShGMfaT1bhoMu1LHQtF64nEYJmR3vlXZjXLzjQ0eu1huJfNcnT7HHcsDX5li2CENFlbKzIUO0UZIq+swYvXN2ve1zvS9JgbdNjXe/PYSQEI0N9Qqt/d5S9x/TaJB2txZGU/IWO410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfJp4/p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23B6C4AF0B;
	Tue, 12 Nov 2024 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731406510;
	bh=PcRTyEBS2+gRvLkAqL7u8VMaelZPeW1sVQkkas/F7JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfJp4/p3hDEss1h1HXWd3tBq1cpFA4DvpWFUPjfLP4tMPrmNwmJ4HkX+UIAqQuS0O
	 jd2ibRVFm9c5VaVIrfM3+oK1KxXh2IBeIR7BnXw6XCtVKKC7+ZJF/+Dq61vUcGwRTq
	 BoQnDVYbgRh7VSI8y9qcWmJoelpEXpCQ7NmIRQlYqdHHCA8peMJm2/a9W6G1pp5p51
	 RmvbstP82u77Xab/C8U4a2PUgGzR0TiQI3hCcFtbER17ggZ4NCqczO92uthCAk8D6/
	 qo6FrNCRpqFBXOozQkn+lJKzs88vmQOHb/cILExZigZ9vnhqkxCTIw2lCxmHSPPTUI
	 sHQoukylxE6bw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tAnvP-00000000Jd6-0wk8;
	Tue, 12 Nov 2024 11:15:07 +0100
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
Subject: [PATCH v3 10/15] acpi/ghes: don't crash QEMU if ghes GED is not found
Date: Tue, 12 Nov 2024 11:14:54 +0100
Message-ID: <f8dcc9e65bd6a348f2448ceaf2ccbd624d388043.1731406254.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731406254.git.mchehab+huawei@kernel.org>
References: <cover.1731406254.git.mchehab+huawei@kernel.org>
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 1dbcbefbc2ee..e15a411b47e1 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -377,7 +377,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
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
2.47.0



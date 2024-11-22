Return-Path: <linux-kernel+bounces-417980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21E9D5B79
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177AF2821A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B71D79BB;
	Fri, 22 Nov 2024 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLd5FCWY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C117107F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266709; cv=none; b=QzxAzpEGOphSDw05kU/iuy80RpGvtsN6mGhT4XvTH8llS6W3VzABq4Ao+1TXHSKh1LvOXQmheXXrrokc+kw7zzNjOkl6+YIVMNSACWcK+Y5FJ/IodD0wGtnubz+f62bEpvzmhPaa08aQwR82yYVjnbtlxDXed+krK/EJhYmI/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266709; c=relaxed/simple;
	bh=0AQUDLyqeERjbSqSRvCL78HkKAIvkN74meWRt+QvhBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQIdvBh4WZMwLNF2qSzrG9tk13pA91f/H5YpMgSr2oVzSeUS1F9DM/GpgHW8mznxILN2XTMDeJA70Lq9chXtIN8bsqkWyD2WPE3Cr90tb31cR62NVyvPe5IxVx7XIdZ540MTYTupU3a3XAhahGcu1J2Za33g9GOame8W/aLdqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLd5FCWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74351C4AF09;
	Fri, 22 Nov 2024 09:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732266708;
	bh=0AQUDLyqeERjbSqSRvCL78HkKAIvkN74meWRt+QvhBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLd5FCWYYslwq3ct4I91L075lCQQTFwpn77DDvu64EA4rGJVXOea9VIZk9Ux+OIIR
	 PBlcQ2y7ZljDH2VIf3ddXwbUEHGYvbiIsyTJSzOtXTI8kYu9NEDLgUBTrmr7TQrMIr
	 T2K4TsZBL7kzLjQkUhIwRY2ne30NsRFn7k0RCgBWk/3g9m6Q6VT8KPjRkPl7IVJhY9
	 SribaSyqlgqjJFSysp9KjK4+5OydiXDKY4jGwqf89+V27b8m8psVZ9/dhBiZxrYaUB
	 M3PuRixzTIzR6sl/6HGWs2I8N73o5OSBelohgNfZ2XiXknt5zEXuExdQL7N69lqQrS
	 rx3FvdyQnFWMw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tEPhX-00000006l40-0rlY;
	Fri, 22 Nov 2024 10:11:43 +0100
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
Subject: [PATCH v4 10/15] acpi/ghes: don't crash QEMU if ghes GED is not found
Date: Fri, 22 Nov 2024 10:11:27 +0100
Message-ID: <d72d9cf99ad0169a39cd3f8028ee7c2e112edf06.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
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
---
 hw/acpi/ghes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index ad7d895def2a..25587f5fc9ab 100644
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
2.47.0



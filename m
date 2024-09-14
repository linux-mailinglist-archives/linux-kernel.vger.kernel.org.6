Return-Path: <linux-kernel+bounces-329170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA8978E44
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883621F21FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB771509A5;
	Sat, 14 Sep 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwrvhLQq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766877113
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726294434; cv=none; b=CYw33yO0RF+3WcemKRrwsy7JvbytEx0EhJBoMtSuidnMtStcU46KCITh6v/G1j06SF79B3zbbN5FFYMWbhpucjl9yeTXukGNfBlzvQ/2CIk8F6JYY6D+4izLr8uWlwaZ5Cp+VVTq2H2B8Qle2jt+wStD8POzKPK0KVh46RViChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726294434; c=relaxed/simple;
	bh=2uI2QDLTIDhBMLjSxY9c9FIQe13nqZmKUTqvJf88oSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5ZwWkDPOyZ2JJtaq/MhRypTW8uVdXjw1qcpObFMzoLddS2M/sFPhfoHhUJHlDuxXHNmStCdicy+A4UpiET8Y7DlU2/XUOvtFM84zQMQ4IopLx3CKc1rLNUSNJW+3o1kyTik/e72H82qKTUNEJmof+himxe55X7yiNqDhcvunKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwrvhLQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CACC4CED8;
	Sat, 14 Sep 2024 06:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726294434;
	bh=2uI2QDLTIDhBMLjSxY9c9FIQe13nqZmKUTqvJf88oSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwrvhLQqwPla89Q5VXWGTx2lI5ZTStEhfGPRP/Oqu7eFZ0kwKQRxgtgGvP0cWU0au
	 JRbx5yADSGSGluA+KSkpmdYf7Ep3f341sEYNNtVBzR7UQKYQUXHscQvGR7EYYEsavx
	 DlC+YaP2tDlwP7AS6pQLXLOilFEZewH3Q9+ZSzrbYvpY88hsaBesHl9fZFIO2AT/UZ
	 7KTodD+QfLX2ZyUbV8cwO0/V98S4yF9AqnmOgmN7cFGReiNQIky7pzYSDW1yq7LpF+
	 TulK3RGZp2Ql52bz8wvXTbtSJlGXsYCn8EMjqaM+iXrKRBw6CFmmR344EauCCcBCpF
	 uATro8w/tkBxw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1spM2a-00000003V67-0wHv;
	Sat, 14 Sep 2024 08:13:52 +0200
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
Subject: [PATCH v10 11/21] acpi/ghes: don't crash QEMU if ghes GED is not found
Date: Sat, 14 Sep 2024 08:13:32 +0200
Message-ID: <edb8ce211602e8fe19d76717d6457b44e8fdca96.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
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
index f54865423f69..e47c0238f3c5 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -421,7 +421,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
 
     acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
                                                        NULL));
-    g_assert(acpi_ged_state);
+    if (!acpi_ged_state) {
+        error_setg(errp, "Can't find ACPI_GED object");
+        return;
+    }
     ags = &acpi_ged_state->ghes_state;
 
     hest_addr = le64_to_cpu(ags->hest_addr_le);
-- 
2.46.0



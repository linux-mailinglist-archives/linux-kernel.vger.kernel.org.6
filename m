Return-Path: <linux-kernel+bounces-345361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6A98B52C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEA01F216E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4F01BE86C;
	Tue,  1 Oct 2024 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwvHTe6s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761481BD50C
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766252; cv=none; b=ntKSpRNf+4UpIezrHaEJ9Lkquy97CmZPa9+vsey8i/SkcDHym75/tjFVNC7qhPPgFfxHFIBdduz0uDcy9/9kI2ox23JrA5uNAXbMfh1qXmOCHRLC+KHLHnsQlYB2pko5VbTxONeX7GEgyZjPia0z1mu9X9yqE0uZKONux865Svo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766252; c=relaxed/simple;
	bh=sRsbSliw/+ZXQ/ZQ+dhrxx2M70UfTSUIKGoJ5MP3coc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGKOZ+rIXF+vrkm/3MJ/e+mVBabSG5IGdssmkBzEUYImPB2P3+4Mk5kmgctS6BXN+t+lGtxnHjijAMZMbwqZgRuXGtCtMe7ZlZWGr6NkNZ3loUM6Oi+cpPP782GHGDnMpbtTMPCL6D1KrzIoOgVQW1GLOhcLeTDGUdtnaP0RJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwvHTe6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0606BC4CED2;
	Tue,  1 Oct 2024 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727766252;
	bh=sRsbSliw/+ZXQ/ZQ+dhrxx2M70UfTSUIKGoJ5MP3coc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwvHTe6s+Vq2Bv/Ow3XuXGR2JU7N7lNKsHZj32WvdnHbN+H1IoS4hiExkhqBc9ruy
	 3kGaNbcdy89SUVAP18D9CxArlAhVD71sKgdiHBJa+hSXS6VDGZM4qswrOjal6j1ZC4
	 OJ6KKrTTsLIIsObtOOgXQIH+fB+SE4oySlWyc+t3ZWpnlVD3VUQGy9usvLqSEnYOIZ
	 MQr4bkcYrXtINiHwhnsdaYm+wmcadeIzTP/16G/rfYbpKQ8f+M8kD4hKSv4azh5+MD
	 KiuvQkPtOoXP3UBWUVBi8Y+Nme8/KeKjPUmUPNRIEosodOZF2v0R4mxLP/JksyYQtC
	 9j1M9/vZSpwhg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1svWvY-00000001V19-3Khk;
	Tue, 01 Oct 2024 09:04:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/15] acpi/ghes: don't crash QEMU if ghes GED is not found
Date: Tue,  1 Oct 2024 09:03:49 +0200
Message-ID: <18c69e8c7a6b6ac365397fe1f442f3ba0cb83be8.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

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
2.46.0



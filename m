Return-Path: <linux-kernel+bounces-430669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C79E3444
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E38DB298BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD7C1946A2;
	Wed,  4 Dec 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJb+FyFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB71818E75A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298153; cv=none; b=RKwt6h1rXj05NOIOZjbUUMZUpF0RLih1oAaD/eVtKzbFdUabwxUPLrFnSBb4PWQ+paaVPitA6xoJoPSPISOtfcya7/TseNQZru5JALMONXBBjhgIx8cWYkc2q1ZI+Xzj4KReq9ZzgxRknUnsMoTAwJGzXcY8eGuz3IFBvXuzn80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298153; c=relaxed/simple;
	bh=xKr5K1TW0pYorJXNz1Ksgf7p26nCCQVwbb66JoUnk8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHk1PlP89hzTbn0x3OsRz0nztPIWj7b06/w3gfbbKQBdNjJP0a5HMFtLQXyjxxUCzuV8QFG1RMLRupJbrAFfAxmEoVtf4iIeW+O1Jo2XMlAvtk8arK/ls5vgZYXIXPQsJqG9fuZ7FptcTEvYDhANeZHOnBPt18jzGrlgAKyigQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJb+FyFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1408BC4CEE8;
	Wed,  4 Dec 2024 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298153;
	bh=xKr5K1TW0pYorJXNz1Ksgf7p26nCCQVwbb66JoUnk8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJb+FyFMhbW4wtXckB9r/3Jrr1JZ2l2UyfBxBNzNFLE4AN118IU/Lkk7lXHo+oLT8
	 PzBexZjWcyPlYq8oTNDLBCtTtze9DEf4zsKFdJ8glRFMWEszQl426dD2pCy0Sum4BP
	 AazDt338RWog+J4kCkQm45YoFlq14mT3noEenF6fefbgG4h0G7lezRwucJLXu8/OHO
	 KMVvDFRftS8h6JX0//I/jUm8fMinNSLv4958QQY7r1vr2WD5ILKkCVIvcc8cPuprXj
	 KqJlNAX5VmdhqOy0nyjx5ijlRnbqQOSp9Qf44kTDLDfU/glPXivznc5euYpAKVxkIz
	 udDDeNfo0H8lg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIk1n-00000004KjA-0ad9;
	Wed, 04 Dec 2024 08:42:31 +0100
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
Subject: [PATCH v5 08/16] acpi/ghes: don't check if physical_address is not zero
Date: Wed,  4 Dec 2024 08:41:16 +0100
Message-ID: <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The 'physical_address' value is a faulty page. As such, 0 is
as valid as any other value.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index edc74c38bf8a..a3dffd78b012 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
-    if (!physical_address) {
-        return -1;
-    }
-
     start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
-- 
2.47.1



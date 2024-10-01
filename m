Return-Path: <linux-kernel+bounces-345351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDFB98B524
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C90C28206F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB31BD4EA;
	Tue,  1 Oct 2024 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX6vCR5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1581BC9F9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766251; cv=none; b=k0gcAuqaSXoPKrUhBRfaVTuhD52lmkn0xrp+f3xPGBJP6ZmiLou9cR6vC57J0VGq5G0Rhj01Tzbqv2iciXuns5uDf6Iom6maIOhhnD72DvXdKLj0yj+OB5pLJ+6+c/1mQ2Uq63qzYH0TRRO+YG3Tai9tyaw8fH20xpZ3AwERSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766251; c=relaxed/simple;
	bh=OPn+v+8+BveQRdEyioQUgXVoI5BFnHOQMXslK4VQRmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsYS4HqfNm9gxtEAanw38heF1g8/A53z7BWdtj4h2vBlRNurJsJcmtO2VzA3T4kxAmc1J8KIfMCX/rk+r9QJPu8RVS3gMiBKbaZxzUVrnlEHL4/8ga1ACk/swjovM1iN+5EY+kqaV/nkrH5jYmv64Qbeu+VE5Q+y1/nv9faJUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX6vCR5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3B5C4CECF;
	Tue,  1 Oct 2024 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727766251;
	bh=OPn+v+8+BveQRdEyioQUgXVoI5BFnHOQMXslK4VQRmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nX6vCR5Ry8sK/PUt1JzItEvx062H3XhEucp8Rhka53c8x/0JqWIT0p380FeK3XL4E
	 XkAKf1Blro7LrHPrnnqrsfDhhl1VNoesmb0VaT1+Eulwb1QDnrm6Ye3N7GItVRu5//
	 gnJPs2kh2+Oe62QjUNpu6TNn0n0w2HidemsIEhey2Mpwa9pMLuuoMqY7I7uRlF3jL9
	 Mg6rjW1khLrmC6kvCLrav/WgHdTIq1+ed29jDGlwAmSlw6yytDznnvYYg2e9edFoR2
	 +WgpkpdjTNYOUBh6Sj36+ZEnb8jQ/1VryyhkN3tIcIpqO0k57OSJpRdrvzA1MBipW0
	 gczzKdU5vfU8Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1svWvY-00000001V0l-2CWy;
	Tue, 01 Oct 2024 09:04:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 06/15] acpi/ghes: Remove a duplicated out of bounds check
Date: Tue,  1 Oct 2024 09:03:43 +0200
Message-ID: <ccb2123649c35e0a268b9745e9b295c8208e92bd.1727766088.git.mchehab+huawei@kernel.org>
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

acpi_ghes_record_errors() has an assert() at the beginning
to ensure that source_id will be lower than
ACPI_GHES_ERROR_SOURCE_COUNT. Remove a duplicated check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/ghes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 29cd7e4d8171..5f67322bf0f2 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -404,9 +404,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
         return -1;
     }
 
-    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
-        start_addr += source_id * sizeof(uint64_t);
-    }
+    start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
                              sizeof(error_block_addr));
-- 
2.46.0



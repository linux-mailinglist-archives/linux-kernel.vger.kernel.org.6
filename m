Return-Path: <linux-kernel+bounces-337975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251739851C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 06:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4C9281574
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41714F9FD;
	Wed, 25 Sep 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1+cvVm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E614B950
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727237088; cv=none; b=fAX9C0fYrtjWksRNIBhahA3oaEu6bEtaR2yG01pwxX4jHzxcYu5mI+FFvGKlOhyNgFQPTp4UcGwnY9EdZ108VwJhyxEwg9Y1v3/8Qvqe1+ThwIQIKMgK73lnhqnRh6SQS9UdQABU3ucyTFW57CEEpnTKNSySLVGcmIT0RhRMiig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727237088; c=relaxed/simple;
	bh=8SPGtmIk/Wiv1BG4hlHht3DlqkOVUBdSPbbEYZCXUmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqU7mk1YXtnpgSBsHOUUyvLj4nBHt53sFcvV8NfZvgXUshpTUnTYx9SgU1ZzLKgd+snZuNx60yjDNfUPWB0trF6fB52K/QztYAEBpkanUOJhQvCOV5IizXEYq3D/hU6L35O2KgDme8asJogV4rKnX1YDPBEj02l5UbuFvzdO8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1+cvVm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09544C4AF0B;
	Wed, 25 Sep 2024 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727237088;
	bh=8SPGtmIk/Wiv1BG4hlHht3DlqkOVUBdSPbbEYZCXUmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1+cvVm2GHorVtqr04U8x2CYuw225+q17Jf7hT5fnlwDXrS+VDldRYEIVirOelyKS
	 qbIYl2x7zogGlAmw+C7hHiw7rNiG3wB7Tknz3nYK3uwggh7J1E05/Ua2iPCZ/OCJBJ
	 LNbqRMXNL3F+5KYiwLA607Dp3PfMxwA2akgmdr5m4zQMF6FOkp03KKM39Galv95qEt
	 hEhMUTlJ+33Rm4wu+03RcdkJnDsrzTnDD+di/wX+a3u+B8pM7azLTu1iNiMFR9CB+K
	 vtSL79ioEU/AUIpp51lHh7hQuuwiKdM9RxA+2sErxHSlaDitx2EGgbn/qoKoP6b1Gz
	 z9x1NEsU8kjgA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1stJGg-00000008281-0sVD;
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
Subject: [PATCH 06/15] acpi/ghes: Remove a duplicated out of bounds check
Date: Wed, 25 Sep 2024 06:04:11 +0200
Message-ID: <271a2d24854e1d63c0913e5d68ac565dc0b8dd42.1727236561.git.mchehab+huawei@kernel.org>
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

acpi_ghes_record_errors() has an assert() at the beginning
to ensure that source_id will be lower than
ACPI_GHES_ERROR_SOURCE_COUNT. Remove a duplicated check.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ghes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 7460cd1a8d56..b932b6fe2c2e 100644
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
2.46.1



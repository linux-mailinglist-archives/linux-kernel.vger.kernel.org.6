Return-Path: <linux-kernel+bounces-435383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1E9E76EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9095A28776D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC3F20457F;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BemPkb2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D052D1FFC71
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505687; cv=none; b=pTQ7GzjT1CLaNUCtjHyVoVbmMGbJnoNjSmPRICIimQxldaYPST+c6ijbL7GdRWwbe41YDjzXBiFry2uw1JW6PdWoUPXRGLQOCv0NTgd/ywftbS/n2zrD/6cuiwYpcaODCdbTI4jNoqrBDnGQHql6YX7aHfbPyDaqq+lvRur686w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505687; c=relaxed/simple;
	bh=eHzu+EU4m8NcCuLnBw09R60FqjsOIt1ZAi+wk2Q1yIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trPo58nDcgZg4ix6VClbHDfipfUStvT+jEWwSKU5fHrpqFBHV10FBIJC9sgqc/q2I5Q7Vkd6y+JDAUaOERMBuYSCTzluvNaUnZp2OvjsnXV9FJTWtprPexUrwaUhbRzxArn0xoKRtda6x6cXaDVouLLKznFekHy6g+ynSKZkxFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BemPkb2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D3AC4CEE3;
	Fri,  6 Dec 2024 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505687;
	bh=eHzu+EU4m8NcCuLnBw09R60FqjsOIt1ZAi+wk2Q1yIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BemPkb2V2X7J3OCc1Cj+Vyh/4IRYSnwqsBO8lSEjpQ4q1iXP5tNR+zDuNXXNT2vJ3
	 kPO3NTiZt+vjclekyrwDy9Ef+f3PT7huxaOGCZxaX4q3f3RNJCBL/AvZcr3+W2KfzA
	 IbMoXIDAzu7XTo5/CHQEHZeBer6l6hJH8AY5ogG9uRCs2m9u/lOsZeX95Apnr8KSG+
	 mkjfqLJVO/IJkjUHshGFfU80pdCXn1KN8jz0e+Qi3NSaQ+aaFjrfn9K4cJGY+FjDiU
	 sf0h6o/z5eMaY+D7BuWAQZBHn2onvunCWTGXSLe4OvP8+0w1rrXnI1AY/bJvEdBi1C
	 55xYJbTR217+Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc17-00000005RK2-2r5a;
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
Subject: [PATCH 08/31] acpi/ghes: don't check if physical_address is not zero
Date: Fri,  6 Dec 2024 18:12:30 +0100
Message-ID: <6f9ff1f1c044fb8f40c9014cc9e40b97f1a4898d.1733504943.git.mchehab+huawei@kernel.org>
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

The 'physical_address' value is a faulty page. As such, 0 is
as valid as any other value.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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



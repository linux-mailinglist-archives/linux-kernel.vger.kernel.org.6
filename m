Return-Path: <linux-kernel+bounces-430671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B69E3446
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C30B16825C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770FA194C86;
	Wed,  4 Dec 2024 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEBd8xOG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BD18F2DD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298153; cv=none; b=XqGdzEA9CiHquKGzjvpq6ydZSujg21PPQEb8QSabKN+HUXF/BcKEJRhoOOzt1ugMlVW2abUY2qgiSumdN/wSWM8wbm+eh6JfBM/CxT/zyMGEf531oCXM5ee4mjhFcR2gXagyN3K8s/xlUJsEXyLYvRXxG/YbzIATLFXn12lqAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298153; c=relaxed/simple;
	bh=EZFsmHMf3WbcMSlyh1u3n8d24jrZ2fM6gqwzFgnZ1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0ZkK0572ZfoDZjk99Azw83mmWV5TYDxbyJWq4qmCzwWPqMqA7LKKO9yS++i6Vp0sVH38tYctFF4QY/c5uvuHAWiPB1oKBZHf1NKHarYvxbrrm6Fb/mGnNH9xqhenR9zyjdoB0sJi8qjdwD/qOlAMxicYGaZx4TeglcB1OtQqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEBd8xOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A567C4AF09;
	Wed,  4 Dec 2024 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733298153;
	bh=EZFsmHMf3WbcMSlyh1u3n8d24jrZ2fM6gqwzFgnZ1EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEBd8xOGayV49WeWOwFn8wQfRHGPP9w7sohNjZh8L6XGyDbOASMSeY41VZ/Lykev/
	 80zwdT/xzNQ4uM1dnCAECKCB452rlyAFsbdtrOMpa07mBDBuvVX52mdYummYAcrI6k
	 v4fl5Pom1Js6d4C9D5OlOiMoaFLWvI6RFwuuLn2SMppxZ2EIc+j1lyypLeSZ+ezjbT
	 zSKi7opI3jmz1EXdJNXBP+y28O4RJg0bRecMNJEMCLd+KMPYLe3yerepcK7Lm6WUZA
	 tqduL3TVjcMMMWDwoyR3svoz93JCRxP7Tg2A6tO+yQTmn3I8m5Yitx0++0SMkp7wxI
	 2Ghr0hv3IDhJg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tIk1n-00000004KjM-0vha;
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
Subject: [PATCH v5 11/16] acpi/ghes: don't crash QEMU if ghes GED is not found
Date: Wed,  4 Dec 2024 08:41:19 +0100
Message-ID: <070b31b912eae803a47ab070f1ca747bd1e69e95.1733297707.git.mchehab+huawei@kernel.org>
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



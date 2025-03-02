Return-Path: <linux-kernel+bounces-540434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6621DA4B092
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A2F3B5FB5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560D1E3DF7;
	Sun,  2 Mar 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8QyEXIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6381D79A3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740903737; cv=none; b=sArye8OQ2PVQO8J1nq1aOYizuA0IQpG2GqgwN3YOvOgPLHsqHGBDk7z1OyZXfBpp7dHRJf1JaiWFqggkoaC5sDoISIDXI36jWS2ZpmiMnxEMgHbdodVQD3QrQ3affEM9ZxeSxuZJ39PkLyomPF7DKZF7fTgMgcJQoRvlBQqgBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740903737; c=relaxed/simple;
	bh=Czz8Tt4JQ7OG2qz83DhQ/rDSfMDYdFVFtyoa2IaQ3O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2v+nXlLnf58tXSOKKSY0JKUwb51oR/XlFW161rkwxTqDHsJPfQTIQQU5CXE6t/gkDRS3qf8KRmHGru9uhF6h12IhAMbjRUFc0s8HdEORyO5pH/YVs0TUBcJNKEH1T22e7Bq+VsjZuAJ7c1yGab7JxJUB4pwZRt/r6q1Ho2BVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8QyEXIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9B3C4CEF0;
	Sun,  2 Mar 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740903737;
	bh=Czz8Tt4JQ7OG2qz83DhQ/rDSfMDYdFVFtyoa2IaQ3O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8QyEXINFTWzApmNC0FNcBLEdM321xwzt4+SgjHBTqFMKPv4bvTEOmzz1Hs6ZNC7z
	 NEDGxuGxE8a4bnEoiYeAS8OtElrI784f5uEALtTrJQSAYkq8sF7Jk5EIPTagrdi0ce
	 Tr6q58rXmwcjGAUXhRjUlSTHDYYBIcM7TLLFFk9WG9j2Fss5L/qYISd8kBfj5dps2V
	 SVu7j/24y3qvZHZr/xKLMKF39/YCWlkk4vWS7PZGDWhq+E/tB0TKjiw3TMJ/sRSf3Y
	 lyTDM4rN6lDfsCJrjcJaosRoZXgzczVG3l7od3bLLbZf2y4nPatwtivyua6YyLYYnh
	 Ig8+gOQaNXTug==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1toeaU-000000043SW-3mMR;
	Sun, 02 Mar 2025 09:22:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 16/19] acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
Date: Sun,  2 Mar 2025 09:22:03 +0100
Message-ID: <c0f383320944d8d4bac199b25370842753e2c296.1740903110.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740903110.git.mchehab+huawei@kernel.org>
References: <cover.1740903110.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that we have everything in place, enable using HEST GPA
instead of etc/hardware_errors GPA.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/generic_event_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index f029753ab709..9fe70b74bd42 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -332,7 +332,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 static const Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
     DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
-                     ghes_state.use_hest_addr, false),
+                     ghes_state.use_hest_addr, true),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
-- 
2.48.1



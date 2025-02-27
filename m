Return-Path: <linux-kernel+bounces-536784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74119A48450
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEAC177DB7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D926E164;
	Thu, 27 Feb 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u64danzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A621AF0C7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672063; cv=none; b=oVg+k4PpqB6IqFW5C+pIbJAzEx9qW0pgO6UO46LgwSSmeVe+obD3rKOEGnIVgeJ7jNJaoeJj/UwH/wT9AatrT7M19fbJGXGW2QquTaqDXo2dCdmIeT36qiF+3DLXtHcHHZnLi9tL5dOTIwA7IXWcolUonuXO2H5lCW25rj3PscE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672063; c=relaxed/simple;
	bh=5zJhfes57BAIUEr1wkVxprZJEF9UksszPvltIQNyQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uk4moBnpwIGxc2h8n4TGN5knGfVsSQhq6qiqwFRtZlz0+ZrOCBv12RgfTzFJBDGd4f8nBOgUI6K55kyWnJ3Hlr7g++J4QcOINyZ3jxVHzcNK0PgT7cOkMMTNCobixcvZ0nlQbg8S6iYmF3+g4MXNpqNWVzfk7/scSk86K7LGVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u64danzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07947C4CEE9;
	Thu, 27 Feb 2025 16:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672063;
	bh=5zJhfes57BAIUEr1wkVxprZJEF9UksszPvltIQNyQ7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u64danzuVXz/EHKksz7dnhZ96vCaejpVpcXohqXhy9nP6TFqP8ERAb5dwuFe+FBfh
	 vPPTk1hTznXXfzGk8SaM8T2LqL7JSWJqVMvAlHz688siuaSsvpqnFQbGgf5dubh0RV
	 KT1oG+x1nHFBKcIbnJ6FeXRzWhKTZRdt8hdR8Mf1mbQ6joX0ktRAapoKsR7CVecmIG
	 1kuTbOh4cVfryHtT890K/9bIGIlZMCkCRmxqlgLxggORs1mydwVcSQRn/r6AZwHz08
	 95HA299LGJqYV7+7+s4rC7McPkoHs+iFa1ZDIMLBPluxcHRtL0js9LkNWKtkIyDimJ
	 PQwP1lgm9HXSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tngJp-000000023bl-0hDb;
	Thu, 27 Feb 2025 17:01:01 +0100
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
Subject: [PATCH v6 16/19] acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
Date: Thu, 27 Feb 2025 17:00:54 +0100
Message-ID: <797c0199ef713241db145baf3860d32e0eb1d03a.1740671863.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740671863.git.mchehab+huawei@kernel.org>
References: <cover.1740671863.git.mchehab+huawei@kernel.org>
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



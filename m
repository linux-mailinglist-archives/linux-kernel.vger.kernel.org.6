Return-Path: <linux-kernel+bounces-551818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3FA57157
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E27179CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F18257444;
	Fri,  7 Mar 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9PQo93w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE8251790
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374898; cv=none; b=rds/3ymvu0FdDfg7tH8XU/CSgtw2/r+Ud5S97YANjmxZrhAJYi6YQhGi0OFmJfznSPQowimfnMU1A91/VYETbmr0DDaynO53pg1vterUHzUbrimgHdFhtAZmU1hYGM7UtWUuE1NH2tcfpqCmzfG8sEK0jNnv9aN5qiAFkMn/IqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374898; c=relaxed/simple;
	bh=Czz8Tt4JQ7OG2qz83DhQ/rDSfMDYdFVFtyoa2IaQ3O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+dQp0AAyimtc6eZQruD+zxuKFUmmukKsnGYjiha2GK1C26ihUhfLRk3e9xo9vstJdeQsouDA5U9URoVZuONjm2xJPVbQm3f+f8qK9P5DlFXhMmU/P/7oLKv9Mc5sHKFetRo6OID/UX2AlVta58ja+DZ3rYSczLXMJ2CYqhfs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9PQo93w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9754C4CEF5;
	Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374897;
	bh=Czz8Tt4JQ7OG2qz83DhQ/rDSfMDYdFVFtyoa2IaQ3O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9PQo93wTWocCkyWmbXCH4q4V9LjblhpJSUkKYNLeljPsy/sEVhzmgAtEHKVsxg52
	 TtwDuUzmdqrJ+reiFHBKLPA7nDz0iLBa4qmK1EEEeZy2ErjZaVNw+JwFg2nu6Qq3ca
	 u2CkON2612i1l7rTM0+zrq3DdY2nKV1l5po43FUef6zA2kVc4SapGLRJSfZBgtT12H
	 zUh2X1irMwffvPHXuElCxupB7cn+ORVcl5GI7AfY/ZwMr8iZPsztsrNgH/ATgyTNJU
	 ZvxrAoLnn9y6jNGOm0FvFWPykfAPE+KcuLNxzBSHImhCqP/909fnWadDOxpjvULnSv
	 0jOapOkgV4wVw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tqd9s-0000000BQnO-0IbL;
	Fri, 07 Mar 2025 20:14:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Gavin Shan" <gshan@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 17/20] acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
Date: Fri,  7 Mar 2025 20:14:46 +0100
Message-ID: <d7b493784b36bf4fd856a217ae596b59ed522dda.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
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



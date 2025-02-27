Return-Path: <linux-kernel+bounces-536086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C8A47B46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA0C3A65DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B4232367;
	Thu, 27 Feb 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGiaiqWf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096922B8AD
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654239; cv=none; b=cOdg4H/fWEMqebwr03z44mYzJdTRGjvI733EgUSC08jg4b705HZ+huVdnsGLFQ55bg7mv7F/Lm+cJzapRXtciwD976Deup+9DrALdfocnfXPuYJ4sEN4FNjw2fkLtGo0aS1WLkhrbYu153WL8FEO4zPlqGJrFbdcRw1hl4NJnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654239; c=relaxed/simple;
	bh=1mLYffQoJbEBuNex4lmNSQVJEuoCQMeyOWMvd13jMno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oa5a3iCIUcOQf7KF6ifdrZChM/ZKDKZnLFlkHG87B2KK+vI9k/224L5y3Y5GsZYkayNjX8luO2CHKl0yuDXOCY1WGRFQXYcmCBZJjGrSrxpv2Pgglri4hk5DxpwFbHyX4PuBY1HMF6uqCJ19vUfpizGXe5eQvxY2WNMnEiyBRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGiaiqWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B200C4CEFE;
	Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740654238;
	bh=1mLYffQoJbEBuNex4lmNSQVJEuoCQMeyOWMvd13jMno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGiaiqWfR/cINgq18nNdflEh94BrZ+gpLci8VNPnHj0ivFbCC/iQY7O03yqyoM/gs
	 GqZQuFciKrG+y1mVsfxlZB0nLS5vVYK4Ti4j82428NDnbcb+IhNhpt3f8hqMBkM2yE
	 PW7fhfePPyP8+ocg81S700HqXsAnO4onn1/lHPBYFnExn64sOcfsazX3oOJvqnz1l9
	 sLBxXXSRV7hUaV+EQmwFBb4l1eashTBsvnHe31LjtDHAB1ovtJ3xzGZXP0F4CvD3Cm
	 XC4Gt/1wStdX27umzXsXeZkUboPb9oDwUJzlGupg1c/gePhKuCE6c9Ak0SQ8Yeq49J
	 Fvqxcz3GeT6kw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tnbgK-00000001mRq-2FL7;
	Thu, 27 Feb 2025 12:03:56 +0100
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
Subject: [PATCH v5 20/21] acpi/generic_event_device.c: enable use_hest_addr for QEMU 10.x
Date: Thu, 27 Feb 2025 12:03:50 +0100
Message-ID: <ee9354f49a895799d59eb5ce79b322fbee561e1c.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
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
index 180eebbce1cd..f5e899155d34 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -331,7 +331,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
 
 static const Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
-    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),
+    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, true),
 };
 
 static const VMStateDescription vmstate_memhp_state = {
-- 
2.48.1



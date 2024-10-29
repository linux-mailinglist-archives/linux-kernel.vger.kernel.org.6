Return-Path: <linux-kernel+bounces-387862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EE29B56F8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016982818E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467720ADCB;
	Tue, 29 Oct 2024 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="ThSHG9Zg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DD0190665
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244752; cv=none; b=GOzAqb3Kot2YohZ3kldZoEZXU8siqZdfBAAMpzgd7yS0scdwf/KqFagJGN08LHIKR0QeW06GZyC6zz+777uQ/HwxGBucqpy7Xdu96rwjhMedF6ipPYyhm9nsxiLElYSBKZt3YrHZaZjpyJ++0rQBSnHwpKHMtDntTU+9zvVlZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244752; c=relaxed/simple;
	bh=AEeH850zcZSvtdo4z3/c8pM4b1up9yGPmYfwgdtFDCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eS5kR7HZ7dWeiA2sSDsqrdPqMrCrg9ePxtz9IrFieOcpC1Gx7cF6RoQEQrzsCCAidJ0100B9t3L+veF6W/mYwjVTnHlA8JZzLQqj0RCVhSWADJQla0movZKuN2ixdH8hUvi35gnqqSyUxdpHoVCBtH99+EHug7Xt/97rRNJugmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=ThSHG9Zg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43159c9f617so57127925e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1730244746; x=1730849546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lStBLLzkZ4IOiXePrysaFTO8S5eHIYxzOD5lofFbrsc=;
        b=ThSHG9ZgOJmoEhfhc+H2QVFHL9jB4Q3ZMjF+9xnRWmGjWz8J95s2ufGxmCwuTI/xh5
         2ypUAaUwWmLG4fSCYP3MyCwJYOk2i6AiyXmKxLNF6DwceDFe8sdRHa1TzX4+MP2dQZZr
         QI6a9hsjlGN7rmwyXoDYeVPGGYo+bxceZr9wwyQG4fPCr11iQWfJULjvH+PWyVW9tGJT
         7WVYgIEIoUemumUMW3Ck5t/QS0eZLYkP0JwHXoPrEi2sZYMzm0rmC/uwNa0WnmUJaQxn
         SW2Pn6PnKF3t1GU+9zWf4aalo31zJh9H6Enq5792jxkpUB3UbqieBy7zAXu4ZHlnYWqz
         jYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244746; x=1730849546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lStBLLzkZ4IOiXePrysaFTO8S5eHIYxzOD5lofFbrsc=;
        b=s6H6PfgJMjJ5pmaEdX4otqzsW1mppxo3NazpaO9m0BDl61G5bpRYUdLp7bE9N443VZ
         +MAC0yAI8wNSqf8uYvieja64+mUhb2R7mNTQG8www+KuC+eT6IDuLsf+/zU3oqip58Zs
         dJ+5OV76Ma2YockGHWIZyHZ7szxVUbWq9A2VsbCYA5hhR22azfSFETA6r+y/yDsrmxs7
         54a2bkNmsdpr2soXiFQV9viVCyjKGZKWyVckCDp1lInRjOJBEqD/TSpslGi6Qev/Kxu8
         bsl79Cw+yQanB9tuMe95LVDKCxiJ4C5CBLXYbg359aW5hSYQEo05PNaZZL0NgPbAdLt2
         3P1A==
X-Forwarded-Encrypted: i=1; AJvYcCXxwxbF+41sDkFJBCtl995m+RQTY3EK3uWR5I7v5Gj1Q7YQUD0xu30wT4CLPPjYX0TGJPDMV5tJt6j/33c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1HdiUH/MEqmfhENRN0DQIwUurmCSTDn2qfDDRbFdZowCgquNA
	jLLGyuovYMEKVme8j8sFb9vneC4MCmmTchtRtheyyOihqYMFdIiT2aNNVMbJQbI=
X-Google-Smtp-Source: AGHT+IFN08GgIIYQERPKFyJ+37fpuAaUFrLVX8d6AuuDSZctnK3MH0jcrfXMRdO8stPaqw7wQC8yUA==
X-Received: by 2002:a05:600c:3b9c:b0:42f:7c9e:1f96 with SMTP id 5b1f17b1804b1-4319ac6fc1cmr134931455e9.1.1730244746154;
        Tue, 29 Oct 2024 16:32:26 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c559:9886:6c0b:569f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d77dsm3515305e9.22.2024.10.29.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:32:25 -0700 (PDT)
From: Antonio Quartulli <antonio@mandelbit.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	mario.limonciello@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH] amdgpu: prevent NULL pointer dereference if ATIF is not supported
Date: Wed, 30 Oct 2024 00:32:32 +0100
Message-ID: <20241029233232.27692-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_evaluate_object() may return AE_NOT_FOUND (failure), which
would result in dereferencing buffer.pointer (obj) while being NULL.

Bail out also when status is AE_NOT_FOUND with a proper error message.

This fixes 1 FORWARD_NULL issue reported by Coverity
Report: CID 1600951:  Null pointer dereferences  (FORWARD_NULL)

Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index cce85389427f..f10c3261a4ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -172,10 +172,13 @@ static union acpi_object *amdgpu_atif_call(struct amdgpu_atif *atif,
 				      &buffer);
 	obj = (union acpi_object *)buffer.pointer;
 
-	/* Fail if calling the method fails and ATIF is supported */
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
-				 acpi_format_exception(status));
+	/* Fail if calling the method fails */
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND)
+			DRM_DEBUG_DRIVER("failed to evaluate ATIF got %s\n",
+					 acpi_format_exception(status));
+		else
+			DRM_DEBUG_DRIVER("ATIF not supported\n");
 		kfree(obj);
 		return NULL;
 	}
-- 
2.45.2



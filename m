Return-Path: <linux-kernel+bounces-559947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDBA5FB81
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC0B19C07EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F602269812;
	Thu, 13 Mar 2025 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWc/Jp1w"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417D1FBC99;
	Thu, 13 Mar 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882936; cv=none; b=Ryq2rmprZl0JlMGTObpMLuoNcFZuxvSAiVaPPOcth+GN19hDWpplF0aMIKgy/O70xljJT8LzQ7XRhRy4A1RffgcFBRIK2nmSkRQjMpL9E6vMH/o90h9WIuWmHOK9BQu3coyLmlowtCe/OGxQvZJ1MwRkueyuFGUGZ/cxRpzgXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882936; c=relaxed/simple;
	bh=g/ziCSYU/t5mOcyQ9jChz5L500++nNSbX0kxdW3nRAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8nx1CPahECljI8BjxVftwexDGRsVtPC3G3nEEVKb5Cite41fyNCGEHf1qUqd7otDTbVeAjZK4R+sJ8wa60E8Nkj862HnhOY4kc/OrFfUkOxme6f+esr7QEhZ10silHAy5GY205qnWndJ6B5gh1Nc4I/hwmMtfMcFZH0pmJAdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWc/Jp1w; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e241443e8dso2134006d6.0;
        Thu, 13 Mar 2025 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741882934; x=1742487734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfIHfaRWNP9xRngkABo8R5/139+Bl09qwSrP6E5fMS4=;
        b=MWc/Jp1wR/UrVUqdkIkhxi0LCBU4bwbZy8UYG26naRq/TjSK2Fhe36ZLlsvhCUNn47
         cpzrxaZk5GcKGMcwanLLN4It51C74FVXQARXK4/WhXhRcga3glVsnb+aR6funiR37YeU
         r1QSII3KoTOjSRphB8vu4TQmVwSZn4dNLtPPqlkcA0UIvG0JkjfDSAb8RfuLPonhyYTC
         Z348xwTNnXDYxsMLxuWjo5QmlpqP9mfCQqcJd6qxynEu4vXIdZ1JRfhq1H6gfkY6qXDh
         FATEynaj1KnhW7j+9ItXpOdI2NwMKmMMW8sz8cYuRuv2qdl3uv4LzjfWPMrUKlDd2SEE
         9uLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741882934; x=1742487734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfIHfaRWNP9xRngkABo8R5/139+Bl09qwSrP6E5fMS4=;
        b=T00oqXZ7I4WIp4VSQWrXhPi1Dls7+LB1aA33SFTmFRjPu+3CssOKlW8NnQIogjFLrJ
         TPNYOims1y0cYktkQb4ZYSYT6wzEorcX2ju3jGFHtomBv5MIecfECyQQprE8MbbScsb2
         NEVQqlNMXbipanv/thqlmi0Le98BJAQDwZ35taw6qPCYDYuFV0fSFbnCAHnI09xPJ+78
         otNtMcVPjUfQqOH/1q6rs/TZTKhEf8QhdZjXZ4hvHrkR1oAV5nqKrqvgM72BQrJbF5Mb
         v5tePbS30iSpl2JNlVk6C6tNcMWruXYcBoCkROswR+z1/s6b2Vqi0tJRhK3+vqHiZ7cN
         ykzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKRcVQtmGDl0qMUyeS5piYqWITfDasJCOIUOYN4iQLEtqyrEAuZbmRqnPC0tAzzIi+lMz/5v2RWmEJOC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs0zR5O8UIv1VTMdLyzOHvjXNLKs5LnWQ8LC8BM76IMcEPag/8
	W4er29DWRsOeAzcGLYIbliSfWWznVRwy1ImbnvUJ7VSJj6RCGF8=
X-Gm-Gg: ASbGncs8EhsY5OzvqjKXmhyDpEzJ+LISFLBv8EYYrxtoGLMpZaf8Y2D/5jf2i0tdkEj
	Ca+OGY0oQ7vGwuTxMejrPhfY91j3h+Lk37aWTYVuAK6MLprM9RN6bvmTWTy4jgAMq3FlUAgfrz3
	w25MEHtbNUjffpE3d7KEQsZXe8k4BwM5IIhVUsuto/HV4GBvFVtPS/4AUyKuCdlJl8Whq7hrE4k
	wOksttiu/MU3Qi9ykGhJW5DPyE0qdfFwRG7XKwUf01F9UCL9DVCFsuXsmJ4/Lk3eWCmKDybPHBt
	LVcKbUBLz01SAT6HgH912FEJuPyEPT8HNTwKMlDCbJs5y3QWnMwd
X-Google-Smtp-Source: AGHT+IFmv2d+8t/XrIOjXJPJhGj6EnNZatKe6KLSHcmC8CbdVIZNMlpFeQ1NwzNXZDpDFrW8TtWxzQ==
X-Received: by 2002:ad4:5c6e:0:b0:6e6:5cad:5ce8 with SMTP id 6a1803df08f44-6e908d5cd3fmr120573996d6.6.1741882934043;
        Thu, 13 Mar 2025 09:22:14 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade330cb6sm11153606d6.88.2025.03.13.09.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:22:13 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	lk@c--e.de,
	dmitry.baryshkov@linaro.org,
	u.kleine-koenig@baylibre.com,
	diogo.ivo@tecnico.ulisboa.pt,
	saranya.gopal@intel.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] usb: typec: ucsi: acpi: Add Null check for adev
Date: Thu, 13 Mar 2025 11:22:11 -0500
Message-Id: <20250313162211.3650958-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all devices have an ACPI companion fwnode, so adev might be NULL.
This is similar to the commit cd2fd6eab480
("platform/x86: int3472: Check for adev == NULL").

Add a check for adev not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in ucsi_acpi_probe().

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index ac1ebb5d9527..d517914c6439 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -189,6 +189,9 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
 	acpi_status status;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	if (adev->dep_unmet)
 		return -EPROBE_DEFER;
 
-- 
2.34.1



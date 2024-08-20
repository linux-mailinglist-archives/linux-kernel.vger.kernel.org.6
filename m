Return-Path: <linux-kernel+bounces-293583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ECC95819A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6887A1F2337E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408818B478;
	Tue, 20 Aug 2024 09:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaxB6s0c"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3302218B47E;
	Tue, 20 Aug 2024 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144567; cv=none; b=ukUAovCXFgDMXZNBYedGXgxWo7KwLGhFzeLVxPDdpPWA2zWS2c539iwLutqgd8LIPjAl/SK0QB2Gq07yR4752azYgAuES9zZg6MyrOEuApMfSclDh8J3/WXsj9X1iyVPYiLaeEnQOlI29Q1aG6qBj+DX3IQJctIQIaw4as1+fbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144567; c=relaxed/simple;
	bh=kc1/lhhdXJKrkUV8gPn04n+ZHj5RmRmRoeQ7axSbDc8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FkFFKRTbBhqbDfHhp3F9faq+2zpDA0dQK+DFemzF9TYP0tAHyGKM0f97spzrVv3Dg9piJHLnnUBFk5oZqNeGQl/GDk8rfBMMfQUIqTyNKprKApqpeLdajR7AazSd8exDLW77y4GpjoWTrJ2vSBYpqesD1GRVOyjQc36Z/pIsoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaxB6s0c; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d3d7a1e45fso3022136a91.3;
        Tue, 20 Aug 2024 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724144565; x=1724749365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uDaXJs0kG70nzZx+zy1BIzT5nzBG2vzsYhkcBOsxTU=;
        b=jaxB6s0c8zVie839hvJ8yh0J/mnqmm3vLafCMuIk/t+/bgb0BRaH7KkoQ+7B/wokyj
         LyOhOmo6YSHqjK17wpvGolrt7uRFd426SjVEcEGU6n3CGKwFrwGwB1KTwEWJXwrXWBY0
         mDntpx9hKHS71iG9v/6CkRTTkOeV6nbU/pUttjNsenwmVrfPD0JoRDL716N3zcql6C+J
         MQchYV+/71LHXCPwSt2eIZttmtGa5T38ZtodJwBGAIMDMADUf625U1sm5EEbn2xlPc0F
         4R43O/3CAuWXtYXeVJOBEoYVCLeQA5Zeo7qIoME7HDo95X+kTOjw8UuqL2WS2eRZYLfK
         jk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144565; x=1724749365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uDaXJs0kG70nzZx+zy1BIzT5nzBG2vzsYhkcBOsxTU=;
        b=Cb2G4LGlmyvbQN4PkwiXzLG5VW2lkcMUtS361A+WFh8IAkzkQD+Wn2KBretZMXxX9U
         6zelCm1UwQX+GMCTSK3eGvH/7GEAPRZImjq+HnxsIJ+M+RCxKwER+VoUyI6ASf17kKE9
         fln0bEEXjYP868SV9J8RYvRK2RWn0mDjIzR2F1i4Y/L71CIRo6clXP7z51YgUteDMZ91
         kb7CEvoeuXRipZEUiXonuL1P5g5rNi5zweT01Dd5GilD8Uclr6Nxsp3Bb/u6VPSlfdyc
         I873KOlZ/sy49ISA3KNHclP0oAmlvmd1r400MPxctbmo6XKj3IpN0lrAFud67CSo8XlI
         PKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF6NbmR/7rQp/cPU/GY08sXMvHrROLWlB8SEwoUPh4bYZjQjjagSx3H1Uc8nG3GgaOu1OMGVM11tQS5+e+NS6j3BHZ4Y32U+jhiAGghZ06PEBOiugFHpZ1GUNaY+FaLPB5DMdUYsfAYT/zZU1fFVdn6Q==
X-Gm-Message-State: AOJu0Yxp1JDvu1dxUljsNLBtHGejtueHC9E2sR+vQDmMuP0MldSVVlWc
	wdJGIuACuDr2YrzCrnUF3KuJ4wcdzLl2d/N0uQuheYaLMgzenEmP
X-Google-Smtp-Source: AGHT+IHDt3m2qtCBVACIJaTpgtIBa8/TeGGlStEjS2+POkvMvZr6tpedKLFKgkLTz/x84zahoqFd6w==
X-Received: by 2002:a17:90a:c70b:b0:2cb:4b88:2aaf with SMTP id 98e67ed59e1d1-2d3dffc5552mr12291032a91.12.1724144565109;
        Tue, 20 Aug 2024 02:02:45 -0700 (PDT)
Received: from dellserver.. ([125.220.159.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d42c193c50sm4700435a91.57.2024.08.20.02.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:02:44 -0700 (PDT)
From: Xi Huang <xuiagnh@gmail.com>
To: jeremy@system76.com,
	productdev@system76.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuiagnh@gmail.com
Subject: [PATCH] platform/x86: system76: Reducing redundant conditional judgments in system76_add()
Date: Tue, 20 Aug 2024 17:02:39 +0800
Message-Id: <20240820090239.17771-1-xuiagnh@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In case of an error, goto jumps to the “error” label,
where the if (data->has_open_ec) check is redundant in most cases.
Since the conditions for most goto statements have already
been satisfied by if (data->has_open_ec),the code has been modified to
improve execution speed.

Signed-off-by: Xi Huang <xuiagnh@gmail.com>
---
 drivers/platform/x86/system76_acpi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 3da753b3d..05b4bf18f 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -757,33 +757,34 @@ static int system76_add(struct acpi_device *acpi_dev)
 
 	err = input_register_device(data->input);
 	if (err)
-		goto error;
+		if (data->has_open_ec)
+			goto free_error;
+		else
+			return err;
 
 	if (data->has_open_ec) {
 		err = system76_get_object(data, "NFAN", &data->nfan);
 		if (err)
-			goto error;
+			goto free_error;
 
 		err = system76_get_object(data, "NTMP", &data->ntmp);
 		if (err)
-			goto error;
+			goto free_error;
 
 		data->therm = devm_hwmon_device_register_with_info(&acpi_dev->dev,
 			"system76_acpi", data, &thermal_chip_info, NULL);
 		err = PTR_ERR_OR_ZERO(data->therm);
 		if (err)
-			goto error;
+			goto free_error;
 
 		system76_battery_init();
 	}
 
 	return 0;
 
-error:
-	if (data->has_open_ec) {
-		kfree(data->ntmp);
-		kfree(data->nfan);
-	}
+free_error:
+	kfree(data->ntmp);
+	kfree(data->nfan);
 	return err;
 }
 
-- 
2.34.1



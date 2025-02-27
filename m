Return-Path: <linux-kernel+bounces-536306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454B9A47E03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0165B176B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A219233D93;
	Thu, 27 Feb 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lJ0OCCkY"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A270233D85
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659847; cv=none; b=skqVfflD/FkHqOZ5QEHMlRX3zMOKGIJxhH8UrNSlFSEf/G31n8CIuym/ph3pnbMdNL3quQtlKssMX79jIXjYgnPj9BpmhuNM67ZOu/ogjXrym+lPdNfhRx4ag5EnJV7F6crMrfwrzv1LbsMhzmTWfUYYLsUViW+hqqzEysYMdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659847; c=relaxed/simple;
	bh=Of9PqcRio9hOrtrXaK3C+7d5d06uoPfQDo/STc3oCQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkCyInq0kvnh0AT5oFn46fdvLYd5+5wBquGoBeTWh7s+YPECjKvknxYSGJJlVjMdKrw8jBFJsqGeVuGGXC5MEFYky1U8pYlbZTD8blDZ6+xzL1HO01eYYir0SHxYYuS0pzch22i8+uKs95nwGhYPH12Zeas/PtYXSxlxIVhyr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lJ0OCCkY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223594b3c6dso7038155ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659845; x=1741264645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=lJ0OCCkYqSPgtJ4dZ5CW1e4TJpEUkvQ8TruxrJkxp+sYc4S39EiAnZNewqSQbILB63
         forlY5KP6QqdDUb2i/QCV018Kf6KZDc/9RmNfZL/xnF1qeyjPRsuQntu7K4iaXuYSiWi
         /rgckz/qfXN8oAOVC3D4sTS+u0wkLMrUEyrQELnMvSqclFHk8aPKkBe33fUaSy6d8LdY
         NxctfU3nxHEAcCa+GnEoMChDPAO+omjxcXTTDegi8hEZ6AVchmfwBetA6R1ESy7x9TRR
         AuyT7nVDMfN8y6RwWEdGWQi3EUQtS9guYWx6uPBuM0gJnITHIY0VidW50RM5rXrobUun
         Mf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659845; x=1741264645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcOi1q1j+KD4L6iG3zLb6+WxKLL1t6DJV3NbpeiJXTU=;
        b=GE+JkbC5Ga4qRPQF8vrPLUYCujHQ7owwFGVPARkEiIbcws2zj2wkB+B0XISk2x9zkr
         uDaHMBnbm50+heg1f+vX7UxTRD+3TDEAMrjHGAwonn71cKxBwe4PpefzZpdVK2/bGeSs
         +e5RUZ2IDMmQ/ycMhv/Z37LCijwo9HC53DiGsORcpUmbO2B7vKA9QsB/v/zoG2f2I8Vp
         8X4mQF5vje9U7SdWUXIVBQWiCGb4xZfFkZH8d/MTslVL6AhrzObJHKFw1nbz1G7z1mki
         dhPtmKii0GgBFZCA6ahW6wwP3XUcT45uEnh4/+FTdcg2rsr8Ac3GOt0wbwDRnlC3z9s/
         gpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdtYgrcTHa7zUaO/TFqmjew54V5hDNeB32+WoasCdaipcYCS/RaMUjxDjzBxJKwocW8C8y8WE5+N1hBEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHw+CyjKGYLFBFkAShePARTHDXQISNgNEZ372gyK9T0eLuIH1
	hzUtDUPjDuE1S7eBiW3pY3Lt36PwfTop23HVIWTpBVy1TpC4b+fk2OfVy9vZoXI=
X-Gm-Gg: ASbGncuFD2dnchJS1tnk5sgn9R7UlG8Z40+zQ9vRDZDb1zc/HD19NgAmURizqb2+NXs
	XMLvdHtPLIn0/dX9Ke+Chy6WH+4zrJS2AJ50SaXpHTgmcWvJeUsVZeIVxtSRQuC75+G9pkhZsMo
	IODOKzqt3+uVYnCbiq//mdIpszFYykLwa3G5c2jkZjh09Spc3hZOSrD/OObC8dfvzDnJg7EfBeW
	o90QDvC+7qKG276P3ruOFVHWdC33zrJmFhXvScv+j2B0uKTKblAvcyZcFCF18IhzmLi1ka+pu7q
	0TxxkXWHqtdZHfMfNWP624t1ocXjr22f8ZMD
X-Google-Smtp-Source: AGHT+IFpHziUTuaJEINi+EgHoRKrGPAz4AsnUhhSqo24MLZ7IPH1ipJJRVjiescHNO1qawzm+Z45XQ==
X-Received: by 2002:a17:903:1c6:b0:223:4a10:311b with SMTP id d9443c01a7336-2234a1033camr48544315ad.1.1740659845617;
        Thu, 27 Feb 2025 04:37:25 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:24 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 09/10] riscv: Add config option to enable APEI SSE handler
Date: Thu, 27 Feb 2025 18:06:27 +0530
Message-ID: <20250227123628.2931490-10-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

APEI SSE handlers can be enabled/disabled with this config
option. When enabled, the SSE registration is done for GHES
entries having notification type set to SSE. When disabled,
registration function return not supported error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 3cfe7e7475f2..be1eaba9b093 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -45,6 +45,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
-- 
2.43.0



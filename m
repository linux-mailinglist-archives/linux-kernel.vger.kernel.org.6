Return-Path: <linux-kernel+bounces-574541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C676DA6E68E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5033173FFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779651F152A;
	Mon, 24 Mar 2025 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BunysaZu"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D141F1519;
	Mon, 24 Mar 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855249; cv=none; b=FRp1sf9tQwHFspRn8UWnDHU+ryDjjiqirB6kndc4xokGlNGYPcouQW2fpgh3zi8WYPdTluzHVCjqVoGm9bfHxiTzSMB5r6TQQCPKTnl2SYzNeepsVbfQJGhgLNnfWM+Ra9DvxWTn4f4/oeC6dSWK+lgtAoT/06kzwmrO/qE5XJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855249; c=relaxed/simple;
	bh=T+vByOK+3P0iaHmPx1a7EHUwWeg0NOlbFiNEq6+/zpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAQLPpKSGBkZyfXYerfj48h4VKH23POa+M7aOA3k7yOPjhC3Qvy4eh51W9H9bzH1Q7tD1+5ILCcpMAJ22IUdyGZqC866aUw9Y1oiZJzGpzUjSQ5KcWxsCm0TYFWaR/4UXzMDtkhJtF3DSRQeFl0WjiyypNj09BZtNrv+oVEaT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BunysaZu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30c05fd126cso44246271fa.3;
        Mon, 24 Mar 2025 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855245; x=1743460045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHTCGDbtDGGbPcirrjSW/AmHdd96eN4p8ojz5P05LJE=;
        b=BunysaZu45R1tV2fJy5gVB/BmPV/VEzjQWDuOf5pB50r/oeCIqBXRHQthyZ8h42OfR
         Hiy/J1pumFyxd+2cCZjGPJULsdUQS3wXfj9w8f3rfInmL9brO4I2uGNvvFFxee+zs6/Y
         W2M/DFE5j/emLFfCEnWlaD7yG0sDHcHBm0p3iEJyFN26RzVN6HEQhlsCeHaR84JP8wig
         stRcsAPdTqchjrDNcc3m72j1a/sJIJ8VBfsR0zQ0DzTPm6fGQ5dt0v4kPiWcLGPLMzrX
         eb0qGte26Vrr0HwMTjm696NivEaX47OckpVO0MRQOs5tPeCkPNm8sRMN605O79ASVhU/
         JCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855245; x=1743460045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHTCGDbtDGGbPcirrjSW/AmHdd96eN4p8ojz5P05LJE=;
        b=VOaTIElEDaPoMZTQGhLOLhcdw85nGPi/wM3sN5Z2JMl4THisVqNbpSHJbNOusO20Xu
         rtGnB9twr0ulWmgAbxMIrRrsnEotzPVoH0yBYMvIVhTWQZeL71bsV+DONLmrokKwKWyP
         XWmYrC64ybTFF3oJ9qFv5GXWM8yKyzfxcMDtVUFGGq0teN2NPQPuI18mfKL+KCDo0rLM
         sXlhIkYGGOgEr1mIZFdoxjCdQRLMl0Lz0GVkHNp62hMqsEnrwuANmGeOnPweKV3V7cVY
         2isTKL5B9oB0KjabujHzY58u8095ZrGOcWiFSv8CiIr622MeoFlvZdxU6mXBfC8gVtfn
         TCTw==
X-Forwarded-Encrypted: i=1; AJvYcCWu03PW+zXzPKvSSQHflHcTBTBzcUsgxoO8zjFqdsXde+MU6wYnOuAk2/0J/cqbLR9/d6WuW+kRNgFogg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwv70Fhh+lzvt/62Q0d/u4PXXjK3B7sLJEcbMMUYJdG4u20kOf
	y8XHesqXiRBvuzmXcKAqPUx/u2XgGTY0cPGsLKNQq0itrC+A/LYKXsir07N+k4I=
X-Gm-Gg: ASbGncvaKPMY2+l3weEgyy6YktuGs0rM81mHQYKrB0164llO0A+qD28d7nxRZRmn7qK
	Gchv3kXET4UuxwJGU1RraOf0H02VHCYiVnnY11K88xD1xNU5LtN3SrGG8x+TaWAGyGK7cPucCfC
	nxIzJhAnprn60zwZgWioN6CRw3eUhu31ZPISTy2PrbBcgXTH14cF46VhbtD/cCaUOawgfecn+6N
	QPrGvrf0edUGAss4la/nDLbFpNbMEZIK9PLcWSbuthB0E5ZjLKyWtBtPfhbSdS4kX7/P78ylfDE
	nas7f/6aNesJFJZxJFGDhpqljB5Njb1ap9jfKDxyqmntv8wOzZSZLsmXhzc+99jNyz1k8TIzxtL
	J+7lpdl7gAg3dQ7pqd6d+xu6pdAxekhwG
X-Google-Smtp-Source: AGHT+IEdxFKvijp0aBRxybzrEYdy1XHM2mv2xuSvhocjBufEYIlX5EcOgRDX7ddCJTkmrwidCqJ2PQ==
X-Received: by 2002:a05:651c:211f:b0:308:eb58:6591 with SMTP id 38308e7fff4ca-30d7e2a2182mr61991371fa.25.1742855245106;
        Mon, 24 Mar 2025 15:27:25 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe8b9sm15860611fa.58.2025.03.24.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:27:24 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: richard.henderson@linaro.org,
	mattst88@gmail.com,
	arnd@arndb.de,
	paulmck@kernel.org,
	glaubitz@physik.fu-berlin.de,
	macro@redhat.com,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 6/7] alpha: machine check handler for tsunami
Date: Mon, 24 Mar 2025 23:21:38 +0100
Message-ID: <20250324222643.32085-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250324222643.32085-1-linmag7@gmail.com>
References: <20250324222643.32085-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

err_tsunami.h contains error messages and mask used to
parse data from logout frames for the tsunami platform.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/err_tsunami.h | 199 ++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100644 arch/alpha/kernel/err_tsunami.h

diff --git a/arch/alpha/kernel/err_tsunami.h b/arch/alpha/kernel/err_tsunami.h
new file mode 100644
index 000000000000..c20cd72f6a53
--- /dev/null
+++ b/arch/alpha/kernel/err_tsunami.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *
+ *	Author:	Magnus Lindholm linmag7@gmail.com
+ *
+ *	Contains declarations and macros to support Alpha error handling
+ *      and error messages for the tsunami/typhoon based platforms
+ */
+
+static char *CLIPPER_EnvQW1SMIR[] = {
+"System Power Supply state change detected",
+"OCP or RMC halt detected",
+"Sys_DC_Notok failure detected",
+"",
+"System temperature over 50 degrees C failure",
+"PCI Bus #0 is in reset",
+"PCI Bus #1 is in reset",
+"System is being reset"
+};
+
+#define CLIPPER_ENV_QW1SMIR_POWER_MASK	1L
+#define CLIPPER_EVN_QW1SMIR_RMC_MASK	(1L<<1)
+#define CLIPPER_EVN_QW1SMIR_DC_MASK	(1L<<2)
+#define CLIPPER_EVN_QW1SMIR_TEMP_MASK	(1L<<4)
+#define CLIPPER_ENV_SMIR_MASK (CLIPPER_ENV_QW1SMIR_POWER_MASK |	\
+				CLIPPER_EVN_QW1SMIR_RMC_MASK |	\
+				CLIPPER_EVN_QW1SMIR_DC_MASK |	\
+				CLIPPER_EVN_QW1SMIR_TEMP_MASK)
+static char *CLIPPER_EnvQW2CPUIR[] = {
+"CPU0 regulator is enabled",
+"CPU1 regulator is enabled",
+"CPU2 regulator is enabled",
+"CPU3 regulator is enabled",
+"CPU0 regulator or configuration sequence fail",
+"CPU1 regulator or configuration sequence fail",
+"CPU2 regulator or configuration sequence fail",
+"CPU3 regulator or configuration sequence fail"
+};
+
+#define CLIPPER_ENV_QW2CPUIR_CPU0_ENA_MASK	1L
+#define CLIPPER_ENV_QW2CPUIR_CPU1_ENA_MASK	(1L<<1)
+#define CLIPPER_ENV_QW2CPUIR_CPU2_ENA_MASK	(1L<<2)
+#define CLIPPER_ENV_QW2CPUIR_CPU3_ENA_MASK	(1L<<3)
+#define CLIPPER_ENV_QW2CPUIR_CPU0_FAIL_MASK	(1L<<4)
+#define CLIPPER_ENV_QW2CPUIR_CPU1_FAIL_MASK	(1L<<5)
+#define CLIPPER_ENV_QW2CPUIR_CPU2_FAIL_MASK	(1L<<6)
+#define CLIPPER_ENV_QW2CPUIR_CPU3_FAIL_MASK	(1L<<7)
+#define CLIPPER_ENV_CPUIR_MASK	(CLIPPER_ENV_QW2CPUIR_CPU0_FAIL_MASK |	\
+				CLIPPER_ENV_QW2CPUIR_CPU1_FAIL_MASK |	\
+				CLIPPER_ENV_QW2CPUIR_CPU2_FAIL_MASK |	\
+				CLIPPER_ENV_QW2CPUIR_CPU3_FAIL_MASK)
+
+
+static char *CLIPPER_EnvQW3PSIR[] = {
+"Power Supply 0 is enabled",
+"Power Supply 1 is enabled",
+"Power Supply 2 is enabled",
+"",
+"Power Supply 0 was enabled but failed",
+"Power Supply 1 was enabled but failed",
+"Power Supply 2 was enabled but failed"
+};
+
+#define CLIPPER_PSIR_PSU0_ENA_MASK	1L
+#define CLIPPER_PSIR_PSU1_ENA_MASK	(1L<<1)
+#define CLIPPER_PSIR_PSU2_ENA_MASK	(1L<<2)
+#define CLIPPER_PSIR_PSU0_FAIL_MASK	(1L<<4)
+#define CLIPPER_PSIR_PSU1_FAIL_MASK	(1L<<5)
+#define CLIPPER_PSIR_PSU2_FAIL_MASK	(1L<<6)
+#define CLIPPER_ENV_PSIR_ENA_MASK (CLIPPER_PSIR_PSU0_ENA_MASK	|	\
+				CLIPPER_PSIR_PSU1_ENA_MASK	|	\
+				CLIPPER_PSIR_PSU2_ENA_MASK)
+#define CLIPPER_ENV_PSIR_ERR_MASK (CLIPPER_PSIR_PSU0_FAIL_MASK	|	\
+				CLIPPER_PSIR_PSU1_FAIL_MASK	|	\
+				CLIPPER_PSIR_PSU2_FAIL_MASK)
+
+static char *CLIPPER_EnvQW4LM78ISR[] = {
+"PS +3.3V out of tolerance",
+"PS +5V out of tolerance",
+"PS +12V out of tolerance",
+"VTERM out of tolerance",
+"Temperature zone 0 (PCI Backplane slots 1-3 area) over limit failure",
+"LM75 CPU0-3 Temperature over limit failure",
+"System Fan 1 failure",
+"System Fan 2 failure",
+"CTERM out of tolerance",
+"",
+"-12V out of tolerance",
+"",
+"",
+"",
+"",
+"",
+"CPU0_VCORE +2V out of tolerance",
+"CPU0_VIO +1.5V out of tolerance",
+"CPU1_VCORE +2V out of tolerance",
+"CPU1_VIO +1.5V out of tolerance",
+"Temperature zone 1 (PCI Backplane slots 7-10 area) over limit failure",
+"",
+"System Fan 4 failure",
+"System Fan 5 failure",
+"",
+"",
+"",
+"",
+"",
+"",
+"",
+"",
+"CPU2_VCORE +2V out of tolerance",
+"CPU2_VIO +1.5V out of tolerance",
+"CPU3_VCORE +2V out of tolerance",
+"CPU3_VIO +1.5V out of tolerance",
+"Temperature zone 2 (PCI Backplane slots 4-6 area) over limit failure",
+"",
+"System Fan 3 failure",
+"System Fan 6 failure",
+"",
+"",
+"Power supply 3.3V rail above high amperage warning",
+"Power supply 5.0V rail above high amperage warning",
+"Power supply 12V rail above high amperage warning",
+"Power supply high temperature warning",
+"Power supply AC input low limit warning",
+"Power supply AC input high limit warning"
+};
+
+#define CLIPPER_ENV_LM78ISR_MASK	0xFCDF00DF05FFL
+
+static char *CLIPPER_EnvQW5DOOR[] = {
+"",
+"Set = System CPU door is open",
+"Set = System Fan door is open",
+"Set = System PCI door is open",
+"",
+"Set = System CPU door is closed",
+"Set = System Fan door is closed",
+"Set = System PCI door is closed"
+};
+
+#define CLIPPER_ENV_DOORS_MASK	 0xEEL
+
+static char *CLIPPER_EnvQW6TEMP[] = {
+"CPU0 temperature warning fault has occurred",
+"CPU1 temperature warning fault has occurred",
+"CPU2 temperature warning fault has occurred",
+"CPU3 temperature warning fault has occurred",
+"System temperature zone 0 warning fault has occurred",
+"System temperature zone 1 warning fault has occurred",
+"System temperature zone 2 warning fault has occurred"
+};
+
+#define CLIPPER_ENV_TEMP_MASK	0xFFL
+
+static char *CLIPPER_EnvQW7FAN[] = {
+"System Fan 1 is not responding to RMC Commands",
+"System Fan 2 is not responding to RMC Commands",
+"System Fan 3 is not responding to RMC Commands",
+"System Fan 4 is not responding to RMC Commands",
+"System Fan 5 is not responding to RMC Commands",
+"System Fan 6 is not responding to RMC Commands",
+"",
+"",
+"CPU fans 5/6 at maximum speed",
+"CPU fans 5/6 reduced speed from maximum",
+"PCI fans 1-4 at maximum speed",
+"PCI fans 1-4 reduced speed from maximum"
+};
+
+#define CLIPPER_ENV_FAN_MASK	0xF3FL
+
+static char *CLIPPER_EnvQW8POWER[] = {
+"Power Supply 0 AC input fail",
+"Power Supply 1 AC input fail",
+"Power Supply 2 AC input fail",
+"",
+"",
+"",
+"",
+"",
+"Power Supply 0 DC fail",
+"Power Supply 1 DC fail",
+"Power Supply 2 DC fail",
+"Vterm fail",
+"CPU0 Regulator fail",
+"CPU1 Regulator fail",
+"CPU2 Regulator fail",
+"CPU3 Regulator fail",
+"",
+"No CPU in system motherboard CPU slot 0",
+"Invalid CPU SROM voltage setting or checksum",
+"TIG load initialization or sequence fail",
+"Over temperature fail",
+"CPU door open fail",
+"System fan 5 (CPU backup fan) fail",
+"Cterm fail"
+};
+
+#define CLIPPER_ENV_POWER_MASK	0xFEFF07L
-- 
2.45.3



Return-Path: <linux-kernel+bounces-420934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33039D8485
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5420F165D70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A798A191F7E;
	Mon, 25 Nov 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcurNP7D"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AB1822F8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534323; cv=none; b=JzQJPo/r06EfCBdW7lzKFXv7mPspSoV9ecM50BsM5DSnoxMrIiyBU48pJp1TvyxxJaw295WWjhxjWKwyeR4D5wF6+bqUYX4JH18Wt5mRuC7i61ZxOiwPwavTMjEUI0/1SInOyr6YGStnosVZEhP2AM0LjIpISWRGur+Z3AmnqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534323; c=relaxed/simple;
	bh=VfaoqwC3aHM1knkvNccvy7OdoduhLovRnssK9pdK4SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7U+qTjCUeLM+7u21wr9PnLCpWfZSv7ek9nry8r9/71kv6XBggSq6kD+lzLHOzAXYHFYZphZeU92hxUeB4Y7BwUGqzZAkCf4Ulpu0+e8j7KN/NRVStVGly0bfJtJceOLgdup9plc8XNleijEB9mVSAiNdns0RrPKqT02zp2aFNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcurNP7D; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3822e64b2d8so139940f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732534318; x=1733139118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8Wv19A1bT9AdcO1eIiCsoo2+HEB2gOEPf7mZ4PlWVE=;
        b=KcurNP7DT5y9A0whxQ5Q0BTnB3B+28LLOOw3YMqVl+RzWgQT7hRCjxuQUln/Z3yeFx
         m/oMF4xvefFq/Q+wuHPZWbnYntfkA67lr/Uw5G1DAgZI8PcMwdPn19g1iZixijxevE/d
         u+IVDqojT76gKpZ+9JpwhciDT1albxYUbB+PwkZTsFlaD28cFQcm/uuao+UcTYeb81Vg
         /eXV7R7kxgYi+OXZX+c5DFI2v66XJXR7kYitiYfFXjCe6tOCFjWIm+ZPqyZTapjOZvy9
         eUtqKmd87Y+bQ08pJJjss9xvII4V+Jwy49KI5RJ21gd7x1W9C66UdhtM3LDqVJ0JKJ2N
         dlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534318; x=1733139118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8Wv19A1bT9AdcO1eIiCsoo2+HEB2gOEPf7mZ4PlWVE=;
        b=IQHzUxDDw7cyqN2EQDaJct+uO/eUogc0wTd+O5VNG7lK0JP4ygII6Z2jnxK/LJ8FMh
         ejXyvUdN3GISrt1pdPhGJLgcMOIjMk3OwPyst8ZbevRK+1zfIENGmt+jXofnDKNy1BhS
         Rw6I8SCUgfQe+ySwKN1MQl+y1zpd4UDfCctmD7SFFhXuOCtTV03xjVzgvOF2wjLGNB/5
         vMLwX7Sb2kkvNlrhZ4bj7Z6aAOnYW+W0usb2oUVOXcXQf6KFaBFDLUctn4flj8VncG6L
         omiZGwmhy97LPiv9dGFpae4rSpHM1tTKtzW1VTH5Z3BNdhJ3Hzw8TcsKsqGW7qmnkUpt
         Q2EA==
X-Forwarded-Encrypted: i=1; AJvYcCVmPfAPPxOhOcTip9YnJGeli0WhVSg9qNYZOBCmGnOyaSTAW4LX4GOb9GmnKRcHIEkD3QB4JD33GwVrNoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXN0qjIpkdvXcLYMktuyeXcpbC/ysTZC6HowjGU0YPCGg+l4Nd
	lgP6s2CEAYyMIseeWTT8+VOBDldZ/9rJROFpp5qWLDMFKhehUygc34zIjFPRRNY=
X-Gm-Gg: ASbGncvbMDHverPPhWqcoWUaveQmEQXvmF3Ka6i1YhiEGreYdC1FPkZQyZcilNNPr50
	fJ8pORE5zStj/VUI8QC5fwDdlUw8ANmzSAAl91CvrpUhvpVfVQUircTKG7QCTKeOMrTxMxNJZYa
	l+pXIwfkA/B+qu7JF+RKuy89Nt9NG7Qe0tRIGX2AoirP4i3u2CBlT1HI1YFxnnt6eBtSx3hvREM
	95+MuFzFr7Nlb9O7HoBru3zgQW8c39DpJ/jLGvhZlN8qmqY89jHR4WwZP8G9bBL
X-Google-Smtp-Source: AGHT+IEuJgVQ/3kRqMUZT7ea0+HiraoHdr6/RW/HL4Dpdd6NgqSwWNAzu054OHnIqEMfQzPdBzjozw==
X-Received: by 2002:a5d:5983:0:b0:382:3c7b:9b2 with SMTP id ffacd0b85a97d-38260bf57f2mr3747908f8f.14.1732534318420;
        Mon, 25 Nov 2024 03:31:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde98988sm125091995e9.42.2024.11.25.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 03:31:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH] of: Add Google Juniper to excluded default cells list
Date: Mon, 25 Nov 2024 12:31:51 +0100
Message-ID: <20241125113151.107812-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Google Juniper platforms have a very old bootloader which populates
/firmware node without proper address/size-cells leading to warnings:

  Missing '#address-cells' in /firmware
  WARNING: CPU: 0 PID: 1 at drivers/of/base.c:106 of_bus_n_addr_cells+0x90/0xf0
  Modules linked in:
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
  Hardware name: Google juniper sku16 board (DT)
  ...
  Missing '#size-cells' in /firmware
  WARNING: CPU: 0 PID: 1 at drivers/of/base.c:133 of_bus_n_size_cells+0x90/0xf0
  Modules linked in:
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0 #1 933ab9971ff4d5dc58cb378a96f64c7f72e3454d
  Tainted: [W]=WARN
  Hardware name: Google juniper sku16 board (DT)

The platform won't receive updated bootloader/firmware so add it to
excluded platform list to silence the warning.

Reported-by: Sasha Levin <sashal@kernel.org>
Closes: https://lore.kernel.org/all/Z0NUdoG17EwuCigT@sashalap/
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Cc: Conor Dooley <conor@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/of/base.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index a8b0c42bdc8e..13f0b2877ee0 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -56,6 +56,16 @@ DEFINE_MUTEX(of_mutex);
  */
 DEFINE_RAW_SPINLOCK(devtree_lock);
 
+/*
+ * List of machines running old firmware without explicit #address-cells and
+ * #size-cells values for parent nodes, which are most likely not going get any
+ * update.
+ */
+static const char * const excluded_default_cells_compats[] = {
+	"google,juniper",
+	NULL
+};
+
 bool of_node_name_eq(const struct device_node *np, const char *name)
 {
 	const char *node_name;
@@ -91,6 +101,17 @@ static bool __of_node_is_type(const struct device_node *np, const char *type)
 	IS_ENABLED(CONFIG_SPARC) \
 )
 
+static bool excluded_default_cells_machines(void)
+{
+	/* Do not repeat the machine checks for every bus */
+	static int excluded_machine = -1;
+
+	if (excluded_machine < 0)
+		excluded_machine = of_machine_compatible_match(excluded_default_cells_compats);
+
+	return !!excluded_machine;
+}
+
 int of_bus_n_addr_cells(struct device_node *np)
 {
 	u32 cells;
@@ -103,7 +124,7 @@ int of_bus_n_addr_cells(struct device_node *np)
 		 * is deprecated. Any platforms which hit this warning should
 		 * be added to the excluded list.
 		 */
-		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS,
+		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS && !excluded_default_cells_machines(),
 			  "Missing '#address-cells' in %pOF\n", np);
 	}
 	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
@@ -125,12 +146,13 @@ int of_bus_n_size_cells(struct device_node *np)
 	for (; np; np = np->parent) {
 		if (!of_property_read_u32(np, "#size-cells", &cells))
 			return cells;
+
 		/*
 		 * Default root value and walking parent nodes for "#size-cells"
 		 * is deprecated. Any platforms which hit this warning should
 		 * be added to the excluded list.
 		 */
-		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS,
+		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS && !excluded_default_cells_machines(),
 			  "Missing '#size-cells' in %pOF\n", np);
 	}
 	return OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
-- 
2.43.0



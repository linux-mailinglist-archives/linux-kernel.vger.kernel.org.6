Return-Path: <linux-kernel+bounces-411991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256FA9D0212
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0191F21E0A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEAF208A0;
	Sun, 17 Nov 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="Vski8F5a"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F623DE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731820435; cv=none; b=D/NKW9jzuC7o+vBf3rDHVntnYauwJca3JHfcJ7cJi8dXWboQ5w+G49VYh3hBtk590EakkdF2WodBp/aDAf40+1UVi0JcEUjm79c/LvYAGPL2l+xSRDv9+z6WUwvBklEA+TmCGKHs0DusODJKoN3XpiSKgFvHHDbIkoYXgEmy+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731820435; c=relaxed/simple;
	bh=5MgNO26PZy3fPWCNlieA2b0OF/IQdElPorbCAQ8LWT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gnk4ysfg92QP+pOB+hkqoNJh7qYgRJ4dQ5df+Y2fhXU0Ny3rIJgYPznTTE5tlLSXlsCTe0Us9J3PnWJO8NwL8ZD9LSZ20SNu7naNl3lxPL+lx6sbtzxrEDzUbusAlxphjXRXd0CmvnBCQEgdEh3KshxHhZVmEI5kBae13Q/oY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=Vski8F5a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7240fa50694so1695849b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731820431; x=1732425231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYbYam3GaclUeMEBIstjEL7a3oAmPuVNtUlQikrML2I=;
        b=Vski8F5aWdpkom/cFlJBCFKpPsQtGHJ/Fwiq1ycdBJIaHxquSMnGrWklQvPfjtyIyL
         MOzZuAQhMTwBXgdII8Qrj5FWqMy93mu80k/qd4q4EsyzCzFYDuR7Z1dNoqEOKaUJ+kjc
         zz9qbJTMm2rl7KzXneHw3A65g3GPxy/ETGLwFzamH+ZyF6dSrdwKlrd8JTFjvTpSL2OY
         Fefo8IwgobR5xqqK4rTDF7qKwYaj+5rUh+oXglsVCdUbzzkPp0ZJDvuCIRB6xdX9QYz1
         EiFYxqJXDGxg4cE7QCdIWfEiCmjYFaTh8qVvrimq31ry/5Ft/2gO2tX3wiH1z6rB1BiO
         VE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731820431; x=1732425231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYbYam3GaclUeMEBIstjEL7a3oAmPuVNtUlQikrML2I=;
        b=MENJ/UL13w0bDWDdzk/ZXlEfqgXqBule7zW2o547wKtRpoM1g0HM55UFksByPuoABR
         4LI+TVto/v0JTFfdcBruUq1E34Uc6dbSYHs4jEgC0AjO25Z0nENtu+9yBDTs0NjGGIIp
         mAuvkeEvGO6JFJ1n91HDVyIWZLYsyJlfLej7+DRLZL+W2lm/+wpbO/E+P75+pUgrIuly
         /jGq5Q1WkKQyH1vvVUaY6dtLrekQ/X/r2/CWZfyuvdIJN9x8T+G/i0iwgOTWjK5EEXS1
         vEf+jxXTetX2GFyUHWybbOCUHubLPnqdL7y3LvFRfGtxkxo0ljDzg3atRlMpLJidQQfj
         0VLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1RsPoygYm36Uwk9zFOsZKUjFpcEqQp9w+0TlPkhCRM68l4IS26k8qGzhi7njGUSetnRA1UZr2fK+rTjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxOfs5/Vw29CxIwXX6dE4ZKoco9YGcjutlgf/xUv2fuTw9CfP
	h92lFfdb3kbLysMWBzwJzFpAfVPNQKZgLgDRJ58IWmDfhReip99TNLWy+BTu
X-Google-Smtp-Source: AGHT+IHVIaZxxfcGzYZ5sNqlyqvHv+eyu2dhlkMMbhBapnm5ZOp5Fd6t7RpQnvTlNaLozOTNfo2tBQ==
X-Received: by 2002:a05:6a00:14c6:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-72476b87342mr13292718b3a.8.1731820431051;
        Sat, 16 Nov 2024 21:13:51 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:96f6:cb09:e09e:fe02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e5c0csm3841693b3a.164.2024.11.16.21.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 21:13:50 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: Laxman Dewangan <ldewangan@nvidia.com>,
	Sebastian Reichel <src@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Signed-off-by : Andrew Davis" <afd@ti.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] power: reset: as3722-poweroff: Remove unnecessary return in as3722_poweroff_probe
Date: Sun, 17 Nov 2024 14:13:20 +0900
Message-ID: <20241117051320.1135900-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return is executed on the devm_register_sys_off_handler() line in
as3722_poweroff_probe, so the last return line is unnecessary. Remove it.

Fixes: 348fde771ce7 ("power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWER_OFF)")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/power/reset/as3722-poweroff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index bb26fa6fa67ca7..8075382cbc3625 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -57,8 +57,6 @@ static int as3722_poweroff_probe(struct platform_device *pdev)
 					     SYS_OFF_PRIO_DEFAULT,
 					     as3722_pm_power_off,
 					     as3722_poweroff);
-
-	return 0;
 }
 
 static struct platform_driver as3722_poweroff_driver = {
-- 
2.45.2



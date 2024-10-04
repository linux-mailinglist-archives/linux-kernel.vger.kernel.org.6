Return-Path: <linux-kernel+bounces-350031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E898FEF0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BEC4B22274
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305713D2BE;
	Fri,  4 Oct 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3ipBqfp"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42E1802E;
	Fri,  4 Oct 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030686; cv=none; b=Uqay0UeIp1T8Ce825xYQi+ZtwWkGQd3x0rj/KwqE6OGVJvHTGHASCLPy3fEaNhgoMiyv7c2c+8FPKQYt6ULQNjBlrIOynxE66FtkSMsepVh3Mi8QjbQ/E37dX0MkVbaL7eXXAeNgwef2okxcxF3KqFvmo0/EB3xQhGcNaTKuvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030686; c=relaxed/simple;
	bh=gl9YpbCSHOn4YQiJi6dPRroQK1BDuPkVG8r5ZxH/Hak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QSbQ40JECSXPOo7kgS4JNo/Z4cfsTSeLq3UivN8F1GSLSA26G2d2OhQosExadqVBymDxtiJ/deZqV/4CnbBLSwUzptc8XxNb9Mp17+4vNRQABrQ2VJz6xDpJlQUm2/PSiV6aFkISUTZMpY1JOHU16GOs0TMQaFjfK8YUi5QPM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3ipBqfp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso2104477a91.1;
        Fri, 04 Oct 2024 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728030685; x=1728635485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPFEQO564fwTGRK5Isb10xeqXfIGvDP5I6UFdrlBgGI=;
        b=R3ipBqfpzrwswbn0X8BDliwHXLApQWx8ZBY2AUOlUE2iLgOK1YtPwmxF3tpJi6/RpR
         1lFdQ3n77SKK74126SAI3edep5pBLtXrXC6u+HlADQln5EkD/CSBbDmdUllh+E+Khptd
         TUD/DLHpw2FiaLghWMdTddAJxXFGGl9kZ7pR4XKPzhsE+TX0ve84XGnRicy4TbIy0U+J
         KvPYuZLA9+9VMGowU3zt88kWL9KxSLYqM3hGl46l5+HEOYliRj0oWo/jbXczjS9+iv97
         DLVr4lxT/oKHWEbjKMOhCI9qhsihrN7tq1wuRJxXzXEeK1UVUGIJO9rOy4yndXeEtOWR
         gSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728030685; x=1728635485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aPFEQO564fwTGRK5Isb10xeqXfIGvDP5I6UFdrlBgGI=;
        b=CB8vxqum9lR48uwJ1k6soDVzljw0+T3imr9ijEVXRsuXpX4WviC4QOzR98KMNI78f9
         VykZy9yw5MqdlybZU0SrnJ86h5ywV40npfRqDxvFbTzlW7B0gQwQsJ2TapsTW0JE7W/Y
         E/siWSikXGMQsPiqNUUz45VNLGN9OoZVcrV/4G9XIcAubUqeh2dP4uq2zHfC8ALInfnF
         mphm0wCKlzAb19AArRWaGmJSMj3obP++iWZrBSYG68jQFFATd/lH3+d+VtNArS8JY/jo
         GHh3rWysxMOyqByhzaKY9tMrIXKkoaNfZmIgnhI8oT2ysaS1GlpfcqK7FnIta/DqahuF
         cvTg==
X-Forwarded-Encrypted: i=1; AJvYcCVt5uavxECxdfV51MLkO0Zzs33KvsCsVVGPBQCiCQh+9B6QSdonGTh8P4wK35ekOKiR4Qe4dBkDBc3JlHUSBplJYOT9+g==@vger.kernel.org, AJvYcCWn3BQEArvwlC26ay6qjug0oVnZeBKDjFgRbTscftUs95MjrxNemHNXJzec5mEs6QxItaIyRwUIMws=@vger.kernel.org, AJvYcCXdw3yCT8lPOny78xshma1sLaM41q8mvy8B4HNBTxhEaDqDL47BQFf/9xVIP0RRnrbnu5hOUYYaXs7sw4a0@vger.kernel.org
X-Gm-Message-State: AOJu0YwSSjyQAUHSNaMBDBXD2hMB3JaZngxqKrkhTxRjwmuHOPkz6XoF
	cQPgtO4WEUTuirbXlW0PaL6RlVeHTGqgG+unptzp+1lWhn9Xdwpwce/0M+I0ir65UA==
X-Google-Smtp-Source: AGHT+IGlJEh6M7zOjemHNyTMhyWPU8d22wr0ZdsSHNmEXUmr0BLYpC/Isk+eRDZD2q56K5D6HxQb1w==
X-Received: by 2002:a17:90a:10d0:b0:2e0:855b:9b21 with SMTP id 98e67ed59e1d1-2e1b38a3412mr8520434a91.8.1728030684732;
        Fri, 04 Oct 2024 01:31:24 -0700 (PDT)
Received: from Tua.. ([103.70.199.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83caf89sm978410a91.8.2024.10.04.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:31:24 -0700 (PDT)
From: Anaswara T Rajan <anaswaratrajan@gmail.com>
To: W_Armin@gmx.de
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anaswara T Rajan <anaswaratrajan@gmail.com>
Subject: [PATCH v2] platform/x86: dell-ddv: Fix typo in documentation
Date: Fri,  4 Oct 2024 14:01:02 +0530
Message-Id: <20241004083102.752344-1-anaswaratrajan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo in word 'diagnostics' in documentation

Signed-off-by: Anaswara T Rajan <anaswaratrajan@gmail.com>
---
Changes in v2:
  - Make the commit title and description more clearer.

 Documentation/wmi/devices/dell-wmi-ddv.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/wmi/devices/dell-wmi-ddv.rst b/Documentation/wmi/devices/dell-wmi-ddv.rst
index 2fcdfcf03327..e0c20af30948 100644
--- a/Documentation/wmi/devices/dell-wmi-ddv.rst
+++ b/Documentation/wmi/devices/dell-wmi-ddv.rst
@@ -8,7 +8,7 @@ Introduction
 ============
 
 Many Dell notebooks made after ~2020 support a WMI-based interface for
-retrieving various system data like battery temperature, ePPID, diagostic data
+retrieving various system data like battery temperature, ePPID, diagnostic data
 and fan/thermal sensor data.
 
 This interface is likely used by the `Dell Data Vault` software on Windows,
@@ -277,7 +277,7 @@ Reverse-Engineering the DDV WMI interface
 4. Try to deduce the meaning of a certain WMI method by comparing the control
    flow with other ACPI methods (_BIX or _BIF for battery related methods
    for example).
-5. Use the built-in UEFI diagostics to view sensor types/values for fan/thermal
+5. Use the built-in UEFI diagnostics to view sensor types/values for fan/thermal
    related methods (sometimes overwriting static ACPI data fields can be used
    to test different sensor type values, since on some machines this data is
    not reinitialized upon a warm reset).
-- 
2.34.1



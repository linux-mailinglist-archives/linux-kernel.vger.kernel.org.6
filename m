Return-Path: <linux-kernel+bounces-417241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB19D5117
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202361F26B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22F51C230E;
	Thu, 21 Nov 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b="OpVqZa79"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D711C07D3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208322; cv=none; b=GUkXkh1ZpcSvs+Qz+cehkDzj2oEc1OhrYKxKXSqTbednT3GuayDEgijgZuT4PYYj440Iqmd/FEIIOVpCHZyOebml2myWqMAcpbZPYRdoq3HYBL7Z9jOcDXi/F0Csiq4qWbp94B3x2SB8lvs8XatAWvr5OPIEYjYjnaVAwvW0aRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208322; c=relaxed/simple;
	bh=EbUd2+Uk9VF6AmI7jko2szQABwjudyxSbk/plvWGwiU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWuiHVaS/JjluACY5M7nPsu+3lcQaKnDGMhMqIM8FIFOc5mroeha+j9bbWZhjVb1tHi4lr3Zmr+AK75nwLg+gE7A5rEyuoGX/fwOd/dflq1E9ftaPLcS8XtXbXGgxwShMZm46ZMexLWrhyTv+P+JaBFeVpZXKZdbDZGOwsAezUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk; spf=pass smtp.mailfrom=remote-tech.co.uk; dkim=pass (2048-bit key) header.d=remote-tech-co-uk.20230601.gappssmtp.com header.i=@remote-tech-co-uk.20230601.gappssmtp.com header.b=OpVqZa79; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=remote-tech.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remote-tech.co.uk
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfe5da1251so1511680a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remote-tech-co-uk.20230601.gappssmtp.com; s=20230601; t=1732208318; x=1732813118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tI7Buy3amAiI+3eJ7b453h1BbqT5wHqViKWf67eK67g=;
        b=OpVqZa79nPRz3p+Tpj7eLXTQgS2EnbJ7qlkmnvvcOA+P5JstKBD/XhSVZGTPdylYDN
         xpgjK/EH5s1V5ZMtcRDYtyYHua3844lJWUUDNecD3wZGSgj3AKVwJaNtho5hzOwLDl04
         Uj4PIujOmkJm4um9qHcRmy0cc2/11hJMO7g27Fnpa8pcsUFwaw2p/0VxaWso9ihOvd55
         +bngMLKEy1xzsW4FzpH4IKQ93kuTxjQS4dDklEHGW9pRYGDnpZ/CpA3+MfuOHPlGtX3w
         yvFZxoGJgkENjsoYl/EgBTfUbz7At7e/KN6uOugwJa3UhVMslr3ZX2c/C1AYp8qMn8Jt
         80YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732208318; x=1732813118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI7Buy3amAiI+3eJ7b453h1BbqT5wHqViKWf67eK67g=;
        b=pmMpsT7j2GjVGl/o9kQDU5JxHQulYRhA0o1HUS8TxGFSWixKCywnFoVk0LYpKhcay2
         otfkNZ6+HLoP+cZLUse+p4hFMda3ZJIiI9DiTBK+T9rZYwq44I1FxuaI9YopWzRCbyi9
         l9hZNTA6H4sqJIdEZzrY0DgCT3CViqmyE/x8BMHlxk5EHEBskoGilhGr8K41LNFXRpOl
         vDZrA9N0NMIXzrY7U/rbWrNQouFXC9goaJCEhmrIDjUwKxji0Ww69aDQrnCd7P2AUL1V
         KGASIV3M2woXZsXwV0jXPWWZRlznP7S1OGrmhhLC4u+nYFFgOMdc56ljGpKcGOo4NlGK
         2ZPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX32xoesz8TFhbCJR6g931qClow/1j1f8bvgiZl0sktKycMt8fEGTT2FOWivapo7tJ58kdjilA8RhRNmPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymvO7KClEUVCBYE9gn0StmH3ORX1qp4iNFud0AUdtFKtdk2uI0
	FOJJiWGzF70qDjKhhyAunZWPrfJOhFL6swP+0jgWJ9xR93nBHmsTu0C0M1XABgv8Cu/vDi3d5yX
	jdxZevGG60HiOhUSav1IaGJH91QAHBiXXsZlY8jALpwKP0NQKT125Xt8vZQPH2b5TwyAAvhfsG3
	Ln7xk2EWfbi2J76WW36wBAuRIb634=
X-Gm-Gg: ASbGncsWqTU8AjZOxj3t9gkvaeqNCwfGlmWsL9aofe2quqnRtJGcepdPj+q9MrepbqD
	gX15wLE73YtIWiIpXhIkDSPUXYtvioAdkdWSx0VTtHQxQ17u4UENXQXU3vMTMpLh+BXTcvJx7Ei
	ey3kpfBsG1DFooSbOYtPGLNCW3kC+/VOnhtFs+WhSd6jjtLfG7wDKAjIcba668lH0rRoCS9U/0u
	/z+Tyhu0kp4K4KljhFyawHtZDJ/STaTMgk7XULlVq8aqeIGAWS9FtaL8nQdlVpJAKrv3DaTRXDq
	WSa5yCWcG/+PH31fzlOy
X-Google-Smtp-Source: AGHT+IEgtjBf99g6pyQ9eadqC025Lpa2cZwpMMTCVFBJS9y6rTNO+LP9Ip760P4TTb3QoAaLTe7pyA==
X-Received: by 2002:a05:6402:1e92:b0:5cf:eaf7:276c with SMTP id 4fb4d7f45d1cf-5cff4c55ef3mr4221462a12.12.1732208318582;
        Thu, 21 Nov 2024 08:58:38 -0800 (PST)
Received: from localhost.localdomain ([178.27.36.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41536d3sm101502766b.24.2024.11.21.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 08:58:38 -0800 (PST)
From: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v9 1/3] Documentation:leds: Add leds-st1202.rst
Date: Thu, 21 Nov 2024 16:58:23 +0000
Message-Id: <20241121165829.8210-2-vicentiu.galanopulo@remote-tech.co.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121165829.8210-1-vicentiu.galanopulo@remote-tech.co.uk>
References: <20241121165829.8210-1-vicentiu.galanopulo@remote-tech.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add usage for sysfs hw_pattern entry for leds-st1202

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
---
 - Changes in v3: Add leds-st1202 to index.rst
 - Changes in v2: Implement review comments

 Documentation/leds/index.rst       |  1 +
 Documentation/leds/leds-st1202.rst | 36 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/leds/leds-st1202.rst

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 3ade16c18328..0ab0a2128a11 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -28,4 +28,5 @@ LEDs
    leds-mlxcpld
    leds-mt6370-rgb
    leds-sc27xx
+   leds-st1202.rst
    leds-qcom-lpg
diff --git a/Documentation/leds/leds-st1202.rst b/Documentation/leds/leds-st1202.rst
new file mode 100644
index 000000000000..e647966e496c
--- /dev/null
+++ b/Documentation/leds/leds-st1202.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================
+Kernel driver for STMicroelectronics LED1202
+============================================
+
+/sys/class/leds/<led>/hw_pattern
+--------------------------------
+
+Specify a hardware pattern for the ST1202 LED. The LED
+controller implements 12 low-side current generators
+with independent dimming control. Internal volatile memory
+allows the user to store up to 8 different patterns.
+Each pattern is a particular output configuration in terms
+of PWM duty-cycle and duration (ms).
+
+To be compatible with the hardware pattern
+format, maximum 8 tuples of brightness (PWM) and duration must
+be written to hw_pattern.
+
+- Min pattern duration: 22 ms
+- Max pattern duration: 5660 ms
+
+The format of the hardware pattern values should be:
+"brightness duration brightness duration ..."
+
+/sys/class/leds/<led>/repeat
+----------------------------
+
+Specify a pattern repeat number, which is common for all channels.
+Default is 1; negative numbers and 0 are invalid.
+
+This file will always return the originally written repeat number.
+
+When the 255 value is written to it, all patterns will repeat
+indefinitely.
-- 
2.39.3 (Apple Git-145)



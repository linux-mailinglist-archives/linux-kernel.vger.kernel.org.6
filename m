Return-Path: <linux-kernel+bounces-293125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82D957B09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447A21F23478
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9A1B7F4;
	Tue, 20 Aug 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUZ0JzLR"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376721798F;
	Tue, 20 Aug 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117758; cv=none; b=tg0Bnf+Y+u1aPkz+TMAITlxaMfLGlmPJFgzHzwgWrJilpmnVpVif8DfTBcHat+Zn3B9aISxlEQNNKl6YdyYa4Fvih9aimxGFNxG5+d3rkE0wYZSPyrbtwPsuuzZ2isPRHq0uy3FYnwfSzcTD6fL1xarejx8EPATnhkDYwiuxaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117758; c=relaxed/simple;
	bh=mP1wkokjp7KWNuylsKg4LO7JWOKLBCHCcOWz75aBBjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvPH2vzz7KGIsFFHZXyg8bi2xUbvWu0y1+NOfwh4d7E62AQFFYDkl1CbahlbdcQ7Vh7UAKxJUKQds59v+m1h0zcFRYG7+ZA+6Dki171QJUlP4qCr3ZxobSvDh3b7D0dUi2vb9ltuqXPCkVOV7kwGoI+rk+g32dDk+IuKrd2bzbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUZ0JzLR; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f6d01961a7so1656924e0c.2;
        Mon, 19 Aug 2024 18:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724117756; x=1724722556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ciCKW+i06FL3On+8kMH5LTnmetjImaXa8fzWeLWngps=;
        b=JUZ0JzLRQnvAppz2WCkX2DwkEveHyvoVloO1U4iDAAxaqtG6zyKJ3LUWCf+DvRreai
         lG/zo7lTaGroh4OP+O311D/OYHkxgH4kmZXZTiK3mV8k2R8YlJkYdEKKAT7qjmsFKe5Z
         XuPIFf+I0bH3t5XMv8hC8zuOP40p0oq34J1bUxEKcddPvTUDLv8XikaiWZxKZkt1Bdq8
         8CmYhZxYCikHlWknI0IRj//nppOoDJgXnjnwGEnpYFV8Y5xm8idsiFm67seLHGlxY30+
         dHbrPR4H7DubeCh+c11FktcW9QeA7KHTy0X8uMv6HxyijJBRyedvmaCYxdIPBkNrHZuT
         9wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724117756; x=1724722556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciCKW+i06FL3On+8kMH5LTnmetjImaXa8fzWeLWngps=;
        b=kB3KGfwSzb5GSmN5NpnJ+mml+S71yC4SkGAwAJCUsz4jX0ujXxLHKTqCZqa2RXLr/3
         ksWY/ZC0BuiJ2O9kHRqO9WWjIiREs/rMFwXqoF/crx/mbHvR2hdImtvFdHNk49u0DlIu
         LCBdJiRtrUOwF7hBdjKBi1ImnNn3xIhD+O8VwV3+nyAj+OBdxci0BEktFOZXoJkEShJd
         TOymMFve7n5odrqxim8ubvun2IIxfDktsPiPb7q8S9TPdyix+4St5XuRWSi8MLcavQy0
         7myHZuyLWITtqPvYZLkUtZnC7/3oE3vuoQHKo/i/in5Axu79qHTmu3aWs0DY06DXVFtN
         FVgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXaXsk19wp3lRXnmrVJfWkir5qMd1/2JGkEGtcfkzdx7DIW0LmzkI8uKdzU2XwD8+gcnkAjyFP1eqLcEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG5YDsfQF38jQgsYx+kKlNJmfvNyNDv0qAnyXgik1cae6xHNNk
	eNeHSo2UtA3kw0JobwwziP4RSu6KfaBT8bbpvpp+INbBgMe7eFIM
X-Google-Smtp-Source: AGHT+IElgIAJT3TY9gaVu/dBNeWNg/egEIjK9d2FUKvG/PWa36yYJQ9zJsCy68tXRXZD/3Kd+p3pTg==
X-Received: by 2002:a05:6122:2013:b0:4ef:5744:46a with SMTP id 71dfb90a1353d-4fcd89fd752mr1190544e0c.1.1724117756031;
        Mon, 19 Aug 2024 18:35:56 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4fc5b8e2d61sm1219564e0c.15.2024.08.19.18.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:35:55 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	shuah@kernel.org,
	david.hunter.linux@gmail.com
Subject: [PATCH 1/1] Driver: clk-qoriq.c: replace of_node_put with _free improves cleanup
Date: Mon, 19 Aug 2024 21:35:49 -0400
Message-ID: <20240820013550.4906-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the _free function to have automatic clean up instead of calling
another function, of_node_put. This prevents leaking reference counts.

The following commit has information on _free(device_node):

9448e55d032d99af8e23487f51a542d51b2f1a48

The code was able to compile without errors or warnings. 

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 drivers/clk/clk-qoriq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 4dcde305944c..941a0372db4b 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1065,11 +1065,8 @@ static void __init _clockgen_init(struct device_node *np, bool legacy);
 static void __init legacy_init_clockgen(struct device_node *np)
 {
 	if (!clockgen.node) {
-		struct device_node *parent_np;
-
-		parent_np = of_get_parent(np);
+		struct device_node __free(device_node) *parent_np = of_get_parent(np);
 		_clockgen_init(parent_np, true);
-		of_node_put(parent_np);
 	}
 }
 
-- 
2.43.0



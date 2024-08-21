Return-Path: <linux-kernel+bounces-294750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39B995920A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E041C21DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A81DA26;
	Wed, 21 Aug 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWpw0YGv"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43D1E877;
	Wed, 21 Aug 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724202471; cv=none; b=aW1sBO9rZB6ArdSfi+Uig3afu7i6XwU8PCdzqk+UbSxofhs3yZjpDLd/uvc+sNCmsHRbE3IGTn5XxXfDCAz/nRl1xf8RIkjdSCAoReiQj1muv26rizJezCvhPlosaRdJSQpypzYt7jnwbhFzG0Y5++0Z/PSyKapXdGCFHBvxJas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724202471; c=relaxed/simple;
	bh=/aAQKmtIClmmsnvJpR/RajCxH09ImjeBYpd6QjR/Pxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mrny3hr9DP/YoHaZlhwqV1/csLg4yCYbIlvDs5J4TuwHfA4p6sLx0jXvanBcM/4wwcJ3xOCBX6H9wJ2Y3Vg+h8XsJr0M+nZCelznH/lTxvr+j0TuO+pVh21dca746JjCO5BBzp+JCiyFKoElZ3RDO0F0ykxKnXLkzxwcYtHVGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWpw0YGv; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e03caab48a2so249418276.1;
        Tue, 20 Aug 2024 18:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724202469; x=1724807269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irghqnwc4yxxwagA+K5ZtONQ7cFbQgDaqnqdG2BbQv8=;
        b=BWpw0YGvejHC8Ci7ijsC9BqhBRWDOEc9Uh0cIzQNoFFHi+ctvJAN2Hbhyq2ZNEzflQ
         MqEwXDqDbPz89Prwhh/ZNUyDDdEEZSfeo6Q6MxIzK0LtYgyC6vhPXUAJ2LMkSKryVpSM
         RlsiiTLbQNjnY1EOVCJj/KhDKLXNCYaZN59XBay8FKg4EkmdTM9U/kISUWe5FrQPAYax
         QJM2IaX6W/KKDjAR5ImTLD7nfAdCoV+MjHz8PsGtmBmNkYpemiRznLOoYZkCjxeYFn4V
         UBiYBoEfbI/owZEcufy9SQJtORnIfGwFXnllANBUYctSFiJhwUSRDzlcJUYv94IHmNp1
         BP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724202469; x=1724807269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irghqnwc4yxxwagA+K5ZtONQ7cFbQgDaqnqdG2BbQv8=;
        b=tnXvuVIjLSWR7LLw10DCEM3dImkvuWFiRFAZhExOGvhkgKBgUujY3kdA6TECQLQrPS
         OyGINpmqjQTkHBOtrsq4TD4HizIkeUZ4rl8W2mYpzH3Y45n2wCLBkKFQBHr3vIC+VnI4
         OPK/Ftmz0NJ3s67PLlbPNThmYNRZsxfML8jUlww0mO4GQ6R4x9cMlEPZitFARahd8XTN
         ilcyO/2sBtHVcVcj38PujZCRuL28O/7U3tCkzl1M3mZZF2EPrh7i9Y9gikSwn3eEudz3
         J8/6+iALo+JuYbgiWmRpLoD+PfAVOLulW0UsIuQ+tHsV3yz0+gID4cvphc3z1Fx48Mgd
         Yg8w==
X-Forwarded-Encrypted: i=1; AJvYcCVquKr75jT2TOMT6Ey1ohX22isqQZ7abQvorsyNW5zchhUwmEzRjHEMMGGbwFHHznS5W4Z7Thnn0Szaz6Nt@vger.kernel.org, AJvYcCWz0BeCR2YPe+9pAdLr0md9ETP2cEr7ef89hWXH8ZYIWcmlUxLDZzEOX/TBdYDvQVyfYwtGkTyUtLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDQlcV607DO0Kq2xfo2GrpHF07v72I5pQTFfTqjUUuqPmJqP7
	Rzo/HY3+FEv+IB0VQw1MlfxlV9f7LgNoHLajdUPWbnLmjqVN/lJ93CnwaA==
X-Google-Smtp-Source: AGHT+IEpgNXZOJ9wVmxgSO0yNq30uNT+1Dsbqmn1pJmIFFT/umuqzEcsvYJug3ffNdB5sPFHYb/Dcw==
X-Received: by 2002:a05:6902:140b:b0:e0b:2f9a:55b with SMTP id 3f1490d57ef6-e1666f8d2cfmr600662276.11.1724202468680;
        Tue, 20 Aug 2024 18:07:48 -0700 (PDT)
Received: from localhost ([2600:1700:6165:1c10:ba94:c53f:f611:602e])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e3f549sm2726921276.23.2024.08.20.18.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 18:07:48 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: sboyd@kernel.org
Cc: david.hunter.linux@gmail.com,
	javier.carrasco.cruz@gmail.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mturquette@baylibre.com,
	shuah@kernel.org
Subject: [PATCH 1/1 V2] Driver: clk-qoriq.c: replace of_node_put with _free improves cleanup
Date: Tue, 20 Aug 2024 21:07:39 -0400
Message-ID: <20240821010739.15293-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9b1107439ffd3fe3cf4945a500a881c8.sboyd@kernel.org>
References: <9b1107439ffd3fe3cf4945a500a881c8.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use _free() to have automatic cleanup instead of calling of_node_put()
manually.

Compiled without errors or warnings.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
The following commit has information on _free(device_node):
9448e55d032d99af8e23487f51a542d51b2f1a48  

V1 --> V2
	- Improved message body 
	- Use change log to give more information about _free()
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



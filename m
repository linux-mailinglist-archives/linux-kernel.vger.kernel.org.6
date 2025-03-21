Return-Path: <linux-kernel+bounces-571251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EDAA6BAED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146731B6029B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9722A808;
	Fri, 21 Mar 2025 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULUrhF1d"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D0227BA1;
	Fri, 21 Mar 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560883; cv=none; b=VWxtmavNRhpd9uMBzJgS1veaGGt2mvVh4UU23G1i6BWpTieBMX5fW5TF4H8x4fSYx2zuscFHDw5cEf/EzBp+w57J04UpWF9498uEpQXifDpu6U09sk6GDk+VATdige6uGEmzxVVb4TAsJC7Ba2uNeDOLoXN3MrU8lvfQtJAwjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560883; c=relaxed/simple;
	bh=eRwaIXSZeEAbgkIPXI4xktUNSHNDQa/L0wTY3I4/eVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntaIeOBnAB2KvX/2l+d7BbQthqYlvyYnu56o7qyEsBxi9a5hJUmsEnOpE9D6ydRFwxzA9oEiGsQwr4rkI1VHRDA4+DogL3f5Ih0Vgfu4kcF/AR+IvcMiER700UbHl491cRmIoiVGleGqRX3a24EA6y38beZO1Xo3F6YyhE6TkxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULUrhF1d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224100e9a5cso35830805ad.2;
        Fri, 21 Mar 2025 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560881; x=1743165681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+NiAZ9mdyZTQmFAQQ+DvuQUzdXkQ4ZbSFQA5qFBOIg=;
        b=ULUrhF1dgTTHK8zsila5yGWBsax7GLT+DCf8AmZIJgf+XNqvOHHtUi026p8wlq06XK
         XUgoXcKYsjVpY61gTLm41oRKXUiINHI4UfOUi5VG4VaNF2FnVLXx1cgz5QHHeAva7DMg
         ybs4vQ7tsOLROa1MjoR3WsR3ICBtRLs4iEuatLklKLcq1Zd9PUgVgKlp9ulLPnE4cMgo
         UreM5NW12tBQ5jwHfRf23WhieI0Vw1cKqFiNq9GLPgRQywgZvRrThuJnnH6k5Suy/nwH
         c/7Hqz8PARh+ZZ8syAYTI7MvAibyb2whh0DkyhX+gqIAXr1HUXP+Mbq2S9g39uLB0jKT
         F3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560881; x=1743165681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+NiAZ9mdyZTQmFAQQ+DvuQUzdXkQ4ZbSFQA5qFBOIg=;
        b=dPPhSPZojcIbhUFhb2OUa1FRrESRPIjlY81YnMdiS31pe0zPO9gJAcLm348jmACFYh
         QCCsvA/NSXTU6gG+kzPlWL0zT1HUcCuJQtRu/5k+ll+XHdly3CejWuVw4fU88K6JqbRl
         mE878ttAUSkxmgFksqPij2dEDdrjGO7joBvMO2TVg2FseqqciAf4EY+Qj6IXUq/vnhs8
         h3jOgnW4Umad9QGJ2VA4ez7Vdy4duf5PG15SfPHe6CE+Hfr3UGlN/0Y/WwKlmBLPP7vl
         DUNAAxxchrOhmds4tb/URomUrFAt+ATuLwHQfYotA38tmoyupJGMGX15XrQfJwSxoMN7
         PYSw==
X-Forwarded-Encrypted: i=1; AJvYcCWEKJpLjiL6MTQN8vCII8aVORrrK1H7WwW4IJYt1fsu+HB4i9CJ4wzQKazOUw57brMkWa2R6AkwjCWRTuZs@vger.kernel.org, AJvYcCWVBs1lL82mvo4Ma5LtEZvKtM6oVpa0vJTrd8/e3E5kAcqL0borf804S9l1Afq1U8+R9OzOtZZLjrPl@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9bJuZYLbGVHhZokPa4LueA6tcsJ4SMpV2X0HaRDg/s7CeOlU
	IFV5F2ZiTKyXNzT1Ap9MVOXxiarOr3kSC/EIcemNz+8M2fr7Zm63
X-Gm-Gg: ASbGnct/yn5l/GThe/twhrdCzGq0LVxgDlLmYVWSmGM98vy5kSeX70DqMmEubLgBmIv
	N7QGB6F84XPxRqis9/UzpNO+qlYX4CDPPMUgg4T6PjtTtuVYSePmR9MufyjwlKyYM7ZBHhdrZUK
	DNH3ARrwST6BUKz54zUdDkSnt9rEGRCklkumNe9K/4uFfPfkWoKOLZyuQrnpgfNL2awejZokGgr
	3AixaegmgTM5ZZ8aT8i7CbOyQRld9s8EV9XmZjMKRCUDvcYeAE6CRwlkwcqAAuNBUGpXD9vQWUY
	8kMPJxm8O8vO+VnCrU38P8VjcAaowrzcvIbkcOA4PW8SDZYSNkzp47caiyUMiuyDosil4pJ1LN0
	Jsnls9HeV1ceAFi6GTT93DIHbSydP6U/0+OrwZRjpf0TE4pVRNQ4R+M0EVeM=
X-Google-Smtp-Source: AGHT+IExgVZ4q/4fohD2pxnSiano84+Gjnet64GgoejlycI2L+z5k6c8k/m9ePdFfCzgOHfdnbckMg==
X-Received: by 2002:a05:6a20:7285:b0:1f5:6f61:a0c2 with SMTP id adf61e73a8af0-1fe4300fe40mr7650260637.34.1742560880874;
        Fri, 21 Mar 2025 05:41:20 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5c90sm1815432b3a.51.2025.03.21.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:41:20 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Fri, 21 Mar 2025 20:37:30 +0800
Message-Id: <20250321123731.1373596-2-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321123731.1373596-1-jason-hsu@quantatw.com>
References: <20250321123731.1373596-1-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on Meta Ventura.
Add subject prefix for the patch.

Signed-off-by: Jason Hsu <jason-hsu@quantatw.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..a86b411df9a5 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -87,6 +87,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
--
2.34.1



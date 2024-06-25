Return-Path: <linux-kernel+bounces-228822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A744991677A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625C228821F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B17156862;
	Tue, 25 Jun 2024 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aluLC1gF"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFB154C11;
	Tue, 25 Jun 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318043; cv=none; b=kRL5Vi+ZdJNKphKEG4aa0N/U2a4vkhu/p/+ms45hFcwOqJ2kPO+0yA5kuF6XCKM/L2AustbPdS96uHZNzM/AJ5SP0oQN6vM8KCQIaK1aLjddRAcFLZ/2psfEvJ0xq6vrXFH7FYmXGuXGz4KNg4iYPUsgEHiEAcqTh9+vYSZ6Yh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318043; c=relaxed/simple;
	bh=yNwDHGDOMYwKf3XYtOIwSI1qyvcgNeGK2320XD8Ouak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mihEro/ryRzzT8nvVMDX4B9R7WFZNzIPm3Ik2Y2FjzHSAv5ABZ+x12uocChMy04N4ZPacch9GSjK3k/oMB+F7OWUfK3/UBbdBBxzQGoV4dmuu0aoiaRfKL8/mMtBTY9qyOaSKo3PLgh+EBJP/jLLiHuTRd9DHS/hYvdpo9Wb0wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aluLC1gF; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-375daa47685so23920235ab.0;
        Tue, 25 Jun 2024 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318041; x=1719922841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyqW/YPcUcSECKMKEcpbBGmhotZwVjBgiijoMXMXMs0=;
        b=aluLC1gFn84IWuMwktv1U58V0c/RVbJUpdE4v7dGboB9L/XWBwyWavfslDMBjhjzxj
         +W6BwPladIbuVD+bl3ChwuknLqM56ntiLJvQyGeRmbH7YkWMFCZZ3byR0tgs9z46Rx5V
         /z0vC9ia+Dpv6I7K+NHbd3lI0ZxhRJHjsrZ7QxrgbCmpsSvb96S4aA0jUTl8QR4K3xpm
         y0DqocntduqGin2aCcEzlMpUZvWRvQsCFna38aN5veRQjcdpf3uiyxA09oOlDluermgI
         OSB8Q61R101D0ZVT35TlhxWYwpb9515wSPjzc+WhBRCIsG2ONdtF5Dr2n33l7aN8XYh9
         ju1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318041; x=1719922841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyqW/YPcUcSECKMKEcpbBGmhotZwVjBgiijoMXMXMs0=;
        b=NKWIDgrwPuE22uycEGEXK7k9mqzHDKFbypFvCQ6O2SvH7OScZRJIgTa3WM4j59KFJZ
         lj4AWT72DjROYPz1mBpaK110qtTZVSzOvSM+1yZTj3iLYl2JtH88yqmhR4ZhhYfoa3Fl
         dq1SRmYqD6QsvU1xPRGee2SmHX2XTT1K2J7SkJjSnFVAvcHUf/TlB5L78RbWPf/d28jz
         gzEEihZHJe+FSN8u6VwaElPMs1nCm30UkYSJ9o6H5lUEmziFNn4FNB3kqOxcAoEUPun6
         p/ZJ+ASnY45wgUEwbHRUKKV0yhFjKYz4SLzHIwZOObl1I8SsPhDvQwKtwZ935wXitIru
         EfGw==
X-Forwarded-Encrypted: i=1; AJvYcCXu/KBbhnG75iMIDq43D4QOo27TLLn6+GWQIfFynJLGEehCXc3Eww/dTkLMmYjbLuf9wtRaIqlybRR0nA9nFBLxQKutjWlutlilqdSAulFpML8R/8+WVFC+kZIEMj+0H6DQJWplVzBxiw==
X-Gm-Message-State: AOJu0YwQSaisU7oYbDs05d4PaVLY9TiJrrr8VQzxNJLj5v/ySqb1/j26
	rGPLGUB3PPV6JM2A7X4PBzSgdHynfpKT6qgVi1nBOq9Edjy9dIfo
X-Google-Smtp-Source: AGHT+IFcrX7CdhR/pMxRJq0wZkjEjwEighbr46zUZPR2+WxUgh0dszolL86yFFIF60yzvDcpdXT/9g==
X-Received: by 2002:a05:6e02:b2f:b0:375:a85c:5fbb with SMTP id e9e14a558f8ab-3763f5f1d54mr94896725ab.17.1719318041267;
        Tue, 25 Jun 2024 05:20:41 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:20:40 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH 01/17] ARM: dts: aspeed: minerva: change the address of tmp75
Date: Tue, 25 Jun 2024 20:18:19 +0800
Message-Id: <20240625121835.751013-2-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Revise the address of tmp75 on I2C bus 1 from 0x48 to 0x4f due to design
change.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 942e53d5c714..e20e31917d6c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -145,9 +145,9 @@ temperature-sensor@4b {
 		reg = <0x4b>;
 	};
 
-	temperature-sensor@48 {
+	temperature-sensor@4f {
 		compatible = "ti,tmp75";
-		reg = <0x48>;
+		reg = <0x4f>;
 	};
 
 	eeprom@54 {
-- 
2.34.1



Return-Path: <linux-kernel+bounces-203222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8858FD804
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE961C23E29
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFA115FA94;
	Wed,  5 Jun 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR0YS/59"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC415F301;
	Wed,  5 Jun 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621256; cv=none; b=qhAbGNl+VRpAY+ZIFdREuzRTWe3L3EtniZwBc30GnKLeyzTsd9HdYqqPyj5ucYbe0gW3AbxzyFvd2xL3Bh88JTmOlXQIR13OSSktyzxWEzmqHiPZRaDlx/v/ZeDWAiULimWdvbYRSKOikMjK5oTS3cKe87c26eyngKUkUYqcyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621256; c=relaxed/simple;
	bh=qj5xcBjZErFO/5M33HBTO0XOhViDdJ/QFEMyH3GL7rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7mgcdMVvuQVacGWhyO3NIGdeu9SCjj7xhcGLNZjms3GwaqEApzrViPv5E5kgdhNw2vmVat7oQmVRIria2BcnS9p4tz8zsQmdtTq+s587Ok/SmsEGpSWpsYPbGEIvLdSdZl3uPRMVuXtMbd137WepUKPRF3kEntxeLWGwBoW3FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR0YS/59; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-354b722fe81so237356f8f.3;
        Wed, 05 Jun 2024 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621253; x=1718226053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33SKSYjNACPXXw3O2oejlfq/sz5jEco/GHNmXgivYNQ=;
        b=QR0YS/59YQMcrHrOzGfZ/d0AaLAVdZfbij0P/JVcospZGgioaUpLq+wKCwNtWdR9cF
         bDQmEzZMWaylkcxRydLR1nmCzNwmZm8Yz8bEn7b27txdSmIIZtq2sHMq17Zmr/e+vlbm
         UxZfjHxHnhN+mqy8TUX3FgUFQ1Yaw0pBUrrstyXFbk/ypJOxaQhQnnSkHxZmHrJnXsoP
         6/N7LqTzB+W/Id7HrnHtdK4JOQydrkDFQxP6rpstwW7qMiQlSY7VtIiVSRddppLaOXvo
         Tbd0F5l8ESFduAjwm0ivPvtgC64ftvxl8JLW19fnJa9tOo79ZkWxelmw19eNwB2GtyO3
         /eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621253; x=1718226053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33SKSYjNACPXXw3O2oejlfq/sz5jEco/GHNmXgivYNQ=;
        b=u01VJcRG7VM2Rbz4Oj6MVcLZh8X6tged0qXSdwmHoP8JVsWQmucbGTyki7LYF/FCep
         4jRWzwuFDfhUZ+u9eD+yT1bpx2NnV3dmkKfla1OCBJiNBlGrniOFS86CYp56xWivUT8h
         ldBQ+R38llJRZ5IogaBt4xqf8/q4pC5FtcRkIn8l1FaPa/7sKGPi6/ys2llE1xiEGOq/
         R4vcfyiFsbynWZXbwz5W2PSU173aJ9Cj8jnIruQgojskjCZi1ou0lNPbov4oTFE2AzOL
         fuw/KggpMn9xk/59Zokuxl5qtJL0AosyBVdFvuSVLahlfdj8QrJ1vi6gOzCY18YxLkGE
         klTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHyOyaiv9liRYrvX/4v9hQyvwqp5cABFdG25LMEbs64pvL4jytK9dlU/vTzs/SnIyf5lKzKpwWJ3dTZui0topBYfwhk4zPNEdk1YFzcHduk4p8k6lHx2mCSLMIOFkALt7cDLtihh70mWFgpwt2D04zT+cQDegrkYn99UdTpxQzqCffcw==
X-Gm-Message-State: AOJu0YyupVAN5ub1FM2tdT8CCkXDpZuAJsrUoCOo24l2ETG13qnvAXyo
	7QT2HqMFr2dfgi7LJwcOQeWWNkn5WB5uYSNSzUk10G0KdWt/JLVpXXah
X-Google-Smtp-Source: AGHT+IFcXVzdcNVRTv2q+gnXoLiA/j0pGT6qTKLZ1gOC2fRRWKBiSTRzKhmf2QhA3zWNLo70MM+brA==
X-Received: by 2002:adf:ee50:0:b0:355:796:15ef with SMTP id ffacd0b85a97d-35e840583abmr2623083f8f.10.1717621252888;
        Wed, 05 Jun 2024 14:00:52 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d77sm15955721f8f.5.2024.06.05.14.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:00:52 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 3/5 RESEND] dt-bindings: clock: rk3128: Add HCLK_SFC
Date: Wed,  5 Jun 2024 23:00:47 +0200
Message-ID: <20240605210049.232284-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605210049.232284-1-knaerzche@gmail.com>
References: <20240605210049.232284-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a clock id for SFC's AHB clock.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - add new clock id at the end

 include/dt-bindings/clock/rk3128-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 420984fc2285..d731c3ffbe1e 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -144,6 +144,7 @@
 #define HCLK_TSP		475
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
+#define HCLK_SFC		479
 
 
 /* soft-reset indices */
-- 
2.45.2



Return-Path: <linux-kernel+bounces-351661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D435991466
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13EDE1F2374A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569C4503C;
	Sat,  5 Oct 2024 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z20VF7iT"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059F38DE9;
	Sat,  5 Oct 2024 05:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728104680; cv=none; b=Sv2HZxmpa/ewfZEAY3zc+d0bmtzBbNV4ojbEyYgaI6/4pO361K8QOx6qTzqUZk+CcU337fYcNr9111m8QweJlD5sPuT9z/1COO+i9UmeEPphJI8iO1S4GUj8c5xIF36MUrYEhWmRQlpIqrrfivEzcrFApNBSZOe9t8TpAvuPXQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728104680; c=relaxed/simple;
	bh=sY34/Zdu/wwZErBETyV6V7qB7jcUn1RwRuFNm6n7A+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP/9p/H2n3faTVMJN4FMYKrH8ZoA5nMIaM0naBekIRT62jzpvm2uUK5J0webGw630YDXSO1w37e2O/FA7vr+9UtKqCRGDgBGbGscHm3IBl7hLL4hJu9UJcxDEuj1vgbBHp7r2eH9NRnDNE7AhP9Q19cGjHqQZY8ofSpFHP3npBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z20VF7iT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e1c91fe739so1926534a91.2;
        Fri, 04 Oct 2024 22:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728104679; x=1728709479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4vQ/wHK+j/kiLmDR1amyCdiI1kzw4/23edhXgv3i5M=;
        b=Z20VF7iTq/Urmbwqs65EHy954TPAmnTMNbIHJXwX4I8gg+GtZ5SVjraqA8gi6Jqe9S
         o5lX1Rk9lG6mM25OkRflCmf5VngS7MCB+hMCwro/l8cQrE2o5okd/Mgt/+OjURR0lr6B
         CijHmC5ieM49PfeknlSZwXGyH/SsWw5tNYc0tGPizzYOnxDCrIT1xxMDJTHbis0fEZXF
         0jhMGThVNsSU5hAgReMr+RSzzVNRxAvoxZnvs2Ftf6sechSgbjJ/WXBC2OXI+hqOmcNc
         ttiMpqBnI/cPhRkvYANYTg+bpFWRZNQDyqIljTtudffUoSEJ2e3reWzXzDMHUMLIeZEN
         1u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728104679; x=1728709479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4vQ/wHK+j/kiLmDR1amyCdiI1kzw4/23edhXgv3i5M=;
        b=OWF5AJYCFnz/kINWteJvdLeWlRa0tyzIkmXGR5Bb2RU+BVw2kVOrTz59lAdz+sZaTa
         1EkX7yyeeJIJtX6R63aeDIllOTYbY+Mz9wh5rNznxtVWrl7pRFyDO5iI2bZevYTSTvXR
         2aHD8UleQ+nG0CEz+hA4fW3IJJedLx28N3g878jZDWzh7g3AkArOkjOzyOc7rZ4bGWSJ
         orSGiB21dJC5hVeR4KPQSKf+/+vttjkmkd5LY7usbxc8tbsGH0eIPQChIeD+JzCEEQUi
         +s0uWB3qCydIszi8XIOBOduHJX9aOXdMUCJR4yZK/kVdTirj95ePZYHdDd0hLvHIcIkA
         hwvA==
X-Forwarded-Encrypted: i=1; AJvYcCVkGFrtX4L1f4aR9xVa/J+u927RuJ1eeHNpdMWoCNrL+GX4oY3BucDn2CYQMOnnGUyRvMKbc9vY1p3rEADU@vger.kernel.org, AJvYcCXXEHz+jI2AYGvyAs1NP63C7cwyQjaYdUoN5TRTAF2W6cP/3lWJTXA+jQ4FDYFjR52ZGX/kD6KhMzyC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpoya4NtLE09lB+3lXko12Duw8mUm5QVUkZJdVInr54Zu/0R5A
	4apBogAj5GlHpX57Cltk6utl6k88/tvS4yUYPCHzOjv1AYBWOe7N
X-Google-Smtp-Source: AGHT+IE7UAQiHWty60M82Q5LlDvs1wEvJRo5PR3IumIPHipsvTER2MS5gD2zN0KTu2dnsqvsUQEUpg==
X-Received: by 2002:a17:90b:4f87:b0:2db:df68:52ae with SMTP id 98e67ed59e1d1-2e1e621d0a6mr5411826a91.14.1728104678705;
        Fri, 04 Oct 2024 22:04:38 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:ed3:4cda:b368:ce98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85db34fsm2625744a91.33.2024.10.04.22.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 22:04:37 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 1/2] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE stub area
Date: Fri,  4 Oct 2024 22:01:54 -0700
Message-ID: <20241005050155.61103-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241005050155.61103-1-CFSworks@gmail.com>
References: <20241005050155.61103-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CFE bootloader places a stub program in the first page of physical
memory to hold the secondary CPUs until the boot CPU writes the release
address, but does not splice a /reserved-memory node into the FDT to
protect it. If Linux overwrites this program before execution reaches
smp_prepare_cpus(), the secondary CPUs may become inaccessible.

This is only a problem with CFE, and then only until the secondary CPUs
are brought online. Ideally, there would be some hypothetical mechanism
we could use to indicate that this area of memory is sensitive only
during boot. But as there is none, and since it is such a small amount
of memory, it is easiest to reserve it unconditionally.

Therefore, add a /reserved-memory node to bcm4908.dtsi to protect the
first 4KiB of physical memory.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index 8b924812322c..c51b92387fad 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -68,6 +68,16 @@ l2: l2-cache0 {
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		cfe-stub@0 {
+			reg = <0x0 0x0 0x0 0x1000>;
+		};
+	};
+
 	axi@81000000 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.44.2



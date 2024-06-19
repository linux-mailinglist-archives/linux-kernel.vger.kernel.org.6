Return-Path: <linux-kernel+bounces-221876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFFC90F9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7930F284129
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0CC15383B;
	Wed, 19 Jun 2024 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TYBpit0h"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934AE15D5D6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718841454; cv=none; b=Ek+rvykivFLOQ77VYUUfyxQu4/jV4tUD3IT4f7gjy8XlpAKiyYVO/4bDRsamTXCT7RXNvqkaqDdk8ajLWYrBoEQHpXxsUSTc3AD0A5RSH9ibYXQe56Xw9oFNMNJetWdyPtmKRlDYNNU3hLxrIBbPgN5yeLLBEJYezjTj6GcdGuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718841454; c=relaxed/simple;
	bh=o78oKmhk86m4HILZFTFFZV1kdWoTsr3pfs9WIhJp/x4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujh1f9dovv5MEUcXSlSEc8V+z2a2dD0WpnPpD+NsdoBe/XmnXV9VP5ykt3yHCZjh0WBS1x/wlgpokltpRJEe+IY0TJrxEd6DPGzFbBcD9BrZPSNJTp3uH2CMGmEy9pBv4qrGOUTx4AETxr53ZWl/c6DGkrFXPUEBYw7aJ9HPMLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TYBpit0h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f9c2847618so2613215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718841452; x=1719446252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AQO4nqVA0DOYwAj+teZfr8s4wmd7CRI3Tiiq9xY2/I=;
        b=TYBpit0hCUHwG0FHa25prMdfws7tNzT2ErAUkpxsLBCa00h8/PCfLVn472/x++cW4R
         5OfDlkyGCIaFNvuT+6PlBAPMVDJYI5MWcNITAPygxN3bk1yQHYROKXJ5n1tcVd3gUvyW
         egXFeRiOm+SolKCmSqM9j4PwL60nKY2/V0d13yXyHOIPwk3O/2GdZhMeICwcmvBJosvY
         26d6AIhiwwZY8785m6avCjLxi3LphEqEFvuAy+1zxBM+ywbCic8q1p4o18gZd4DN6if4
         XyEd964NZt7oUdQRGjHBEn2+q2yvpx77xgobigh3Uf9zcMJgL4Ds88XmMEcS6j5HXz0T
         8Tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718841452; x=1719446252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AQO4nqVA0DOYwAj+teZfr8s4wmd7CRI3Tiiq9xY2/I=;
        b=NEOtQtc8DzkzDEnvv1ly9UzzWwBAAr1OSflk6F+ovYVeeKpWbVYNc449Yr78Q7oF8u
         8J1bPgS4UxszBTTSseIaQNU7sXBdMb/2cVN70uUOnfakC/CqAsgudhZGc8mxPVwIrwYI
         X+Kvk6az/an5uAD3N2QxmLm1n801YNfkufXbUTkz8euYVdKFAKh+/sDVNS9YpC5g7FyF
         xQQq/EnP71cpY/i4u1Gyyvp2Hxc4IDZUDB7J8hBwJgxIAh27/7H1i00n5Q7p+Mnwak8G
         33kontSW9wGD8hXDeGx2ET2gm8v/sTPBWOqsHbjX/zHHczddBORzeNinFu+WNUF2awTM
         p2DA==
X-Forwarded-Encrypted: i=1; AJvYcCWDxRQ28LWDCkUybLiM3VOQ4d9Q/3l/gIjYFP1TieTFqmDu22rbQ6rXL73KKuqbTKKMM8EUtLfHDDPHAcDWbB4FPdSBkvoLGYYPH0cF
X-Gm-Message-State: AOJu0Yw6br+wQDFTQyVsr3Xrsyhpe+wcA8kSUR5W0UP189jotjOJAj22
	FtBckKfeugTOC8FMy/6VCihr8wuaa0D0LObDgn6UQbn72exc1Itl1PH0uGuRDrA=
X-Google-Smtp-Source: AGHT+IFoXrhYhjn+/lVsgZXka4n5QsR7TR2v6CJZQsByiet3G9LS6vvYmCHK55CsnhzrqexT+bFstQ==
X-Received: by 2002:a17:902:d2ce:b0:1f7:1bf3:5850 with SMTP id d9443c01a7336-1f9aa46b6a8mr41988715ad.56.1718841451971;
        Wed, 19 Jun 2024 16:57:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e70ae6sm123620745ad.71.2024.06.19.16.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 16:57:31 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 19 Jun 2024 16:57:16 -0700
Subject: [PATCH v3 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-xtheadvector-v3-3-bff39eb9668e@rivosinc.com>
References: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
In-Reply-To: <20240619-xtheadvector-v3-0-bff39eb9668e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
 Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718841444; l=960;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=o78oKmhk86m4HILZFTFFZV1kdWoTsr3pfs9WIhJp/x4=;
 b=wyIwTx+ltoBY8XI16VYS4AKmoySM5Q8IhQ1ZFuSj7uZE8LiufHrtRxZHl+k1Rfxo5LRXUuZJT
 Dftr0frldNLC2HCpxXHdoGWEDGFCEF2DHv5yZcMjtNVrsRWLHXM0K6+
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The D1/D1s SoCs support xtheadvector so it can be included in the
devicetree. Also include vlenb for the cpu.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6cbe0..6367112e614a 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -27,7 +27,8 @@ cpu0: cpu@0 {
 			riscv,isa = "rv64imafdc";
 			riscv,isa-base = "rv64i";
 			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
-					       "zifencei", "zihpm";
+					       "zifencei", "zihpm", "xtheadvector";
+			thead,vlenb = <128>;
 			#cooling-cells = <2>;
 
 			cpu0_intc: interrupt-controller {

-- 
2.34.1



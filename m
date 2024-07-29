Return-Path: <linux-kernel+bounces-266443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B62993FFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0101C225D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F044618D4CE;
	Mon, 29 Jul 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m1UkGC9i"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38D13B295
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286814; cv=none; b=dN4XON8GYhC6xK8sNzAp+rput6yxm+o3hR2t6lmJSuByJ+YxKf04xWZ5RtMCeYP5ve1H5zWQ0Q4LtfZ5wt8hJQqxBoG1B7FwtgD9PWvyYZ/eKollSZOjSpHGbGtXOgWvzIBHWnOImSbY1Mq9KcotWiNcpRJBlKrxE5AY6a7MHi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286814; c=relaxed/simple;
	bh=/0pgqxhRJIH6MqaFTEW7nQC633eH2ip8Lz6S15hbvsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szrD7lLntc/wth/4BBkAreYKb4Cm2Arl6x4rYI5V8IL0s36ZOtnZTxxp2fTG3co64rt+sPt2LJS0I3iffFrV8w/9kdfGyOOMjO+MI/N13xzDWgZLd30KulMc36DO5czCWs+gB3lxxFt+cd/OL/4IF7Cr5Znm/eazMDG8Yt7MMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m1UkGC9i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc5549788eso27585845ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722286812; x=1722891612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dql6H2E8eMkdEWJsMLB0+FYOVGD+y9KXL3h/jt/IJY=;
        b=m1UkGC9irH8IsYhYOe394KYk1bqjNypy5nkvSdVa474R+825zM8DF6cmnhde1o2C78
         YVmQzYI7pqqEYmLRe2gAZ3v++NTpAxjQn6d8EinyOdOj23aU/7kGV9dT8r5/IeCNHjj5
         UFVNRaDcxaJP944/iPQ+Y45c7gi5AW/uDvyFDsRsk+Bg7cSiHLAW4ln5W2TXNlf/njv6
         ljlnVA+oehnU7+NBJZzjx7KYEl3mZzJ98c4v6HTEwHTxZfya86KsUoxa+u6efGaYHHT0
         qQmvYCa5GdHsKJQPs/ZcPWk9z9E2w1A+6Ki37Ed6h/blRykQcYW6pXEON3ApWNBzj9e1
         rBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286812; x=1722891612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dql6H2E8eMkdEWJsMLB0+FYOVGD+y9KXL3h/jt/IJY=;
        b=JSG5JMDQDtfynh/NTYOJVWYiqGG21t59rGamq+zRaeMOucnLIWt+jW2xW7zJgZ3H5K
         j/wvgZmgEynd6Z0BZ79JWdpjB2qBtHAu9V0aNHhHe+c4WKk3GuIP3GanwWxnjKrpL/zF
         NyYxALmCYcw8wIcJ/RRTZnSPkfo+c0azqrnu95bD4qhcWoHlb1QzSTHMPUIN4Fqag3AJ
         oJ67HmymJzHm2SL+7fDPewWpSdtnQdTsiy8N8S+PszgocomPR6rI4BQUSYUa4ZjfnR27
         2ATSoyc7EWA46hBVyTwuJvqthOAhQWo7tZSmbk3NiUWbVCtaUCmqJmsUA63601jM1P9R
         CqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaY3gDyWvj9C/AKUgfhkYArglsNLe2L1jSZ+tTaEv+q+TEZHS5xOmKm6gF/4uF0gBX5v4L6rYPnOE5J0/0CwNzqG/kv8gLUuWzUVkG
X-Gm-Message-State: AOJu0YzxWa2msQtZeIPlg/jp+9YeVNLfsiwVEjRdZjpISgddmxhfPEE7
	Gqn5uA0x7xCMr3hGPf2DVuKtcHD8R/H2l37BFGuMdttIBggfI9LdlYbIJtYzC6s=
X-Google-Smtp-Source: AGHT+IGBnR27VGfQMEe9XbukzuO+Niz0LgdSm2RCyK9hj8HK0I/R77m76o+RSPftIZuTUblDzhO5pg==
X-Received: by 2002:a17:903:22c8:b0:1fb:9627:b348 with SMTP id d9443c01a7336-1ff048e192fmr131200085ad.58.1722286811944;
        Mon, 29 Jul 2024 14:00:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f71d61sm87341745ad.225.2024.07.29.14.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:00:10 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 29 Jul 2024 14:00:03 -0700
Subject: [PATCH 2/2] riscv: Add license to vmalloc.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-riscv_fence_license-v1-2-7d5648069640@rivosinc.com>
References: <20240729-riscv_fence_license-v1-0-7d5648069640@rivosinc.com>
In-Reply-To: <20240729-riscv_fence_license-v1-0-7d5648069640@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722286807; l=521;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/0pgqxhRJIH6MqaFTEW7nQC633eH2ip8Lz6S15hbvsE=;
 b=Z4Yo9qonTo0Z9Y86xe5MtcX7IBUuz8vdmBXyvTtc0DhQBdG2eFlfeqxLpW6Kfk5ptNTvEMRCs
 xHZGWKx+7pQBX1+wFwPH5F1jALi6lm+kdm1XcH7WtpLDJTUkf3p1L12
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add a missing license to vmalloc.h.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/vmalloc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
index 51f6dfe19745..fefe94dc98e2 100644
--- a/arch/riscv/include/asm/vmalloc.h
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef _ASM_RISCV_VMALLOC_H
 #define _ASM_RISCV_VMALLOC_H
 

-- 
2.44.0



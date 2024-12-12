Return-Path: <linux-kernel+bounces-443116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A19EE784
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3D282B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35CC2139D7;
	Thu, 12 Dec 2024 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uMX+FbvC"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B21EC4C1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734009125; cv=none; b=qS2fBTwk5k2cIqbkLp569j1ZJ4tVm+SarwiF6cL+/99Fe3qvGZWKdUKZ6B6pquA5aN/RVE02cC2ivTYtm2ULFfRCogWAqd/XAORKKP4cRNrGfcmQdryncMBx9Ip+lYY5VfzNu/aqPdsZSuMUNdmP54lF54VN/1RV6W9WJC8rztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734009125; c=relaxed/simple;
	bh=6S74aXJi8bMw8xxU0Jy4W8SuEZ8pnfh8rcn0saA1TCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IgAieC3i27CvJDz8RujUgSLWqgYL/NbHW2oMjEtf2AgRiTcuE4twGL4xHBKhL7zojwsbe6Y/6Eco357RYy0V8Envd6Eq/Yg/6wGGLXYhmaO/0llx10cPpx14vT8SEywam2DmCcB8JMxi4G7oBaki3ponz7CCkqTfkda/A8NNhxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uMX+FbvC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f796586so6887495e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734009120; x=1734613920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N2YgHN1u42ft3i81AHB8yJHaifZcAL+5WACka8uiNrU=;
        b=uMX+FbvC8mS36vX4Rpj0+Yrxrm/02VdQDVYbom0ElWzgHG1SdQu8i+QihyIJWuPxzA
         IY19DQFyE1h8CKB8vZPgpXYU2n5B3vrF/gLWlss6m9DgcFHdZPgKxq7TC5k0KpjeRvBg
         tPqXzsIUgGndRlY37tRH8RzOS57NZZdZoKTmvjmQhM1AWD0yWVjQPMPtAWqutVmAF+Qm
         9HH0E7kn4IgFdLGB0Yxn0TMza5AmprwtC3raz1sQbLXxbX6fRXjzbXb8+HqOHdqahOyn
         CsYVS0y7EcRWustqtEFNq5zLmRIXVmM9CAT55+7RcOt61G0NN6/OzzrWRVSrvdNh/7RK
         Nfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734009120; x=1734613920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2YgHN1u42ft3i81AHB8yJHaifZcAL+5WACka8uiNrU=;
        b=QsM3v6pyULb6gMumBjPaS54bsdUoxNvSulVpikSLxg6ghFwqgPFVHwS9ZpKfoq6nOK
         5gSZD0hYDg6fuDWL2kRCTH/JTCW8mkrqkkj0qo7dY8G4dBBgKDSkhsc6LrpreXjtk30f
         vJ2yopc15gKsROSxSaMljXQftpxd7xW6fHew8XufcVG+Bqt53Dywl2XNvoXjWfjSF707
         mJMH8dkhY2pVt2Y1EbuOIPg/M43+uAq4dQFqZW+P0SlK9WkT/OY710FQcgG9Vq7cT95F
         HH3Fmgt1EFw5ev9Dnavw6NM0pt62Bog57Kei3HlON3WPtutAYXERfsWUSRJaVkOyxonb
         2YnA==
X-Forwarded-Encrypted: i=1; AJvYcCUlZvqflHBqZRMceaLKfaTee+9WpmJxJgkUrvW6fhVwIdLEE+wR3TLk2hraq6tjDAoy3i04yzx0sN1Kfys=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1DyI3sGzawK2C2xycz9AGPrE0yPmNgZpJDzCIs+kbPhN9UIM
	M/4UXoEui1CFfB5n2cziy4r+xcc10NJqU8RlgG1BChtxtlGVmHCKueAncljwp6cQD332dRApLLH
	2
X-Gm-Gg: ASbGncuBFtAmt0rQWGxMIPcwYcMoIUQSoJS1aphMaYwtC+LMbgfgoPiEVbBa/Qpdua/
	MnxJVK/AHz2LW+5AdhZnbYBepzsUe41yd80q8pUMXEfFhwfnioUxaKrsG7gStb9qu6VvUIIolkp
	qi+w5nl3MQBpKJuJWF02hw39geeXideIXqyMzOy6j7YfOwu/6eAw6z7Zg0YSEY+FNL8Z7cSbAZV
	GQMIRX9tmr+k3c8dWjh0prFSr69/8gGaRBYg8PtQXIuaQ5YLIdTToQdorD3V0H43c7VGlPkueXH
	JGKPfmBuqcr2278ku1FUB4xr
X-Google-Smtp-Source: AGHT+IGwIC4usqpXrWrDNnBStJNdRLcYsV/1KRF1pj5B+SiFE9zAdRezZDXrjrCfRGTU67Ud290XHg==
X-Received: by 2002:a05:600c:cc7:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-4361c43d6bfmr57259765e9.29.1734009120475;
        Thu, 12 Dec 2024 05:12:00 -0800 (PST)
Received: from alex-rivos.home (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bf187sm3996700f8f.49.2024.12.12.05.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:11:59 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] MAINTAINERS: Add myself as a riscv reviewer
Date: Thu, 12 Dec 2024 14:11:34 +0100
Message-Id: <20241212131134.288819-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal is for me to get a kernel.org account and then send pull requests
in order to relieve some pressure from Palmer and make our workflow
smoother.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..1c7838642398 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20108,6 +20108,7 @@ RISC-V ARCHITECTURE
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Albert Ou <aou@eecs.berkeley.edu>
+R:	Alexandre Ghiti <alex@ghiti.fr>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-riscv/list/
-- 
2.39.2



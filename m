Return-Path: <linux-kernel+bounces-554533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E09A5996E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A848188A30F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061822F3BD;
	Mon, 10 Mar 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fi99kbZp"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8122DFA0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619620; cv=none; b=W8Bfsnwm6kkMI/gHV/URZ12SDlwoOKOCynr8gQlbGvdOV7IJEYQnn3/Dl4QWPfA9+cc/yhliJapTA8dGyjzXHnTw4NIoUPWosIifeizVANeJsHEXsTE9kDB2eJ4BZyTfBBnJ3vZR3k+qRGT//QbiBsRycZ4Teu8CLsFnYc2psTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619620; c=relaxed/simple;
	bh=G0bMb29ZpgJV0/CkJZpzg+0z8//qkfB6ATS+lahL2BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fk0G/H6WjMyBJAYwhfzgL6THZ4rWkV0YxJzMauUiEA14NHfTkrT5PvB4Cnr+ET8SfKxH5HNt8FMyBMsxrr7EUWnN/TNKFW3bO+3LZRfAzEQlVRJL/LJyou2U4OLQ5lpQzlyn4U8riew2SOvix1/PxuZCbINZeE14JTMUmbSNUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fi99kbZp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2235189adaeso72916605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619617; x=1742224417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Radg/O1kYDcS8p0IZNGBH2Vna601zEl7dWErY3x7IKQ=;
        b=fi99kbZpHioLtGi82zxDgaCnhZ0CNWGyWwVuW/RajEZPlNGRK4ot6wphvsUusWBGFj
         iTnzUjn2YnQ5AzoepGwOY/BMI1eE/ihbWpPemAhi8g3tK8PCW7/V480KhZmvtAqXyRJW
         QDxhEoV4nMX8DtZq8+8/O3ErEDtDkKf+IbHy2V8SZ83NGd8tOesgL9o7YVJY+vhZSLq+
         YN9exj9JHUDH0I5PKAUQ69yPktuR+CuGVMTL227KLso44YD9git4DYZMdrL1lOPXiiTT
         hd4Z6y6OKDamDUF3Kdry+2LA16OF9C2/pBXDAW2Mch3d4k4ZkbNNsXLLh2tSkj5Nwn5B
         S80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619617; x=1742224417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Radg/O1kYDcS8p0IZNGBH2Vna601zEl7dWErY3x7IKQ=;
        b=gUt1gUZDA8qiJ+wsLWU+nJonzQxoslERo5aOjK9TdcODzQN8jZvg1ej9pvRPVxPU1j
         M1QWywOYP7BsJnKKZCjEunROJDGFzfURAkXqGFqfPaKD1E1XYQHsPOEbv9r3M6as4Yjd
         4Ix41x0KoxXkz2EesCa8827SFdZ3D1IMJZ3FIs580Sw7IxrApuao2xj5L5HwBLczxRxS
         YdYGBJm+bcNSI3P9av6S3B9hr5D1MmtbPGpTdwHjcGNo+5LkjRzJdKv0wHGtVrKH6yR+
         JeEYDHw+2Vz5a8ZUoUjTKpY0sdQEw9OYERrBxDk53+yAVNhn8EU1hjH6LQnCpF9f27xH
         sGoA==
X-Forwarded-Encrypted: i=1; AJvYcCUqSxph+7tJ1SXR7r9l1syk4ZN7Fwm+mrpfTQnAFYtF3YFgU009HKk5f+IuLrGAgQbHMH7Q+pEMetJVSGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykaDkCB12qxxcLUIzwlxRja9cPxTNEdx9qXbvRuSGji78HNOob
	/Bn8fdaQ17Rd1JSLx/NWE/1Ug3o//a5U4CowYAKeZSFS2uKWpNGW8WaDeDAnDW8=
X-Gm-Gg: ASbGnct5my11QboKdmqvXkwaRUyLid0Exc6O9j1J9ByxSLCP5nTiJcJ98bAymC5gwH0
	V0WOqejpI7Xb0/WBBOg3pPYe82udns9lzzuHB7ReTZMiPvcr64gk0IId8TPBplcuxIguTZmk0Cl
	ZxPlT3Tou+16CFAmx2JSU+TBOO63gOv4/KuvT3HRR0bWJgsc5ghKoKjTBJ7xq6lNx6wcAz1UdPz
	KX8XoBLHKEyMtxIoW5Wluxlaz5kMe8Wv+OI1wgN3ngWVTkdZDtBUim9ZRZlVMHQ7Q9K6hR69yNd
	7Eklcn/ZJnzWEtUItXLHYtdWWdflbrsqztACQpRS/PMlGA==
X-Google-Smtp-Source: AGHT+IFYtJx1zpZXoyRZ/KHJTP5G1HNeErNj7hP1Uj5JhhNtVjlp1IKO2nyoOwTegiQflbbotJG7Sw==
X-Received: by 2002:a17:903:2308:b0:215:58be:334e with SMTP id d9443c01a7336-224628603d2mr147459315ad.10.1741619617154;
        Mon, 10 Mar 2025 08:13:37 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:13:36 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 06/17] riscv: misaligned: use correct CONFIG_ ifdef for misaligned_access_speed
Date: Mon, 10 Mar 2025 16:12:13 +0100
Message-ID: <20250310151229.2365992-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

misaligned_access_speed is defined under CONFIG_RISCV_SCALAR_MISALIGNED
but was used under CONFIG_RISCV_PROBE_UNALIGNED_ACCESS. Fix that by
using the correct config option.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index ffac424faa88..7fe25adf2539 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -362,7 +362,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
-#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
 #endif
 
-- 
2.47.2



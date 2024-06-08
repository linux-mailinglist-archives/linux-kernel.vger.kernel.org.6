Return-Path: <linux-kernel+bounces-206924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB0D900FFB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD1E28415D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E850176AC7;
	Sat,  8 Jun 2024 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI6qxPwl"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D717BAF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831939; cv=none; b=rjZoT5V75rbUdqxwhOO34T/jXsttclR2QMgWEwTmADtByMLiQcYXcC8dRgU2eR5KEVIbfHHUvNZJhBuzvltyXzkQC7gmRSGobV0yzaaYjbVnQTiVaRkcMfOphmAx+EwB8s12xEiMLz1RUrqNykk8MHBrogGyREHBbvrg+zGIoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831939; c=relaxed/simple;
	bh=rwMiy+Ds8GGaENRlmuBExRRS//ZscoQv/UZrrNuC59A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgJD1gejs3u8QlklJO+FbgaI5Z4tik9BEkwjCwYSb3WSS7z9fV0KsKOvGmjPcHLaRtZsvUNRVcB+Myz0pTENohllt/BDer75t3kguhmi+WsXTGsbSWAxNIwqiTWvPX3qciAT/bO4kjle8am+o4CelpnWYT9S2p3xwMpj9KlkziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI6qxPwl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a691bbb7031so369458266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831936; x=1718436736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pI8EtYru5hEm3wWcZ31Y1A8dIAXFghS5t8weDUhvo0=;
        b=FI6qxPwldO915IRRhGiLTVZOadeGS4h+HeCEKQ0pyth6wofMRkfd1c19E/kw0b4GpV
         Gy8ZXa1BJVgmXtrsj0yRcBgBky8IMJpKNJsW+RvCmeId38TxPDY8VzdGdOZ0npUSDFh3
         Nw81DR4HDu2GlPom6Bv/5vQT35bH11EvplHJajpI7b6W7WeiXkA/C7X2vhf4WYk6n62T
         N2Sf7oROGMtRPmEq9j8cVLi/bLGX987JRrD11aTA9lK8g0SUzgkJ9dxRKMUkseRho/tT
         gTiR7CSL0QjPzvKhYhM3iBzKM8zlTqkrQMyLm1EOx7YNwCNOyFijS10t+FCkU88qlgxw
         CCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831936; x=1718436736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pI8EtYru5hEm3wWcZ31Y1A8dIAXFghS5t8weDUhvo0=;
        b=O3Nci8FgVJ7fRVXjxLV374Jb3gI+klWdU2HG8GgfT+X/oOk095XMWRTxcTdURonjmG
         IohSQcP3JDzXustz2nonBnqer+12ZfMkMhZXMKt+X7EKZ6yQVvnt8bIuDulgYvfFtWFe
         EkwVraL+UZ2A/amfWLqp0ZjzOT9WsGuWHAIuA2cpV950Y0JkskZuLECuJ73AKFuxzAHr
         sKSpe73pk3mvMHW72JjOKukedlmTkighgbwCMSn32+/wbBicCSjFjJ07a/4DrrfbtOJh
         2f5a4wZjGTsP+SZTVDtjI0UuBeGQ6P0me5iXGYY4or27ZpI6ko6skvYw7s/oHUp9gcsc
         3lJQ==
X-Gm-Message-State: AOJu0YwFOIscZuuk6c59d9qk3yftuENHZtdjxW/wZV6oOepF+3Qvsg0U
	57qgRq6orRkrBjCzszSfd9KRqXzhF2uDHsE5BSKIUFZtu2qwQxU6K92qusOZ
X-Google-Smtp-Source: AGHT+IGLSLsmiraG6slSjKp2kT1pAOBeQ2+lON9tG4/cw+k2+oIpmECC24jAPuwvRVh4R6pWryvQww==
X-Received: by 2002:a17:907:6d03:b0:a6e:fb3c:4b59 with SMTP id a640c23a62f3a-a6efb3c4cd6mr109071266b.77.1717831936095;
        Sat, 08 Jun 2024 00:32:16 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 1/9] x86/fpu: Introduce the x86_task_fpu() helper method
Date: Sat,  8 Jun 2024 09:31:26 +0200
Message-ID: <20240608073134.264210-2-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608073134.264210-1-mingo@kernel.org>
References: <20240608073134.264210-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The per-task FPU context/save area is allocated right
next to task_struct, currently in a variable-size
array via task_struct::thread.fpu[], but we plan to
fully hide it from the C type scope.

Introduce the x86_task_fpu() accessor that gets to the
FPU context pointer explicitly from the task pointer.

Right now this is a simple (task)->thread.fpu wrapper.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cb4f6c513c48..35aa8f652964 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -511,6 +511,8 @@ struct thread_struct {
 	 */
 };
 
+#define x86_task_fpu(task) (&(task)->thread.fpu)
+
 extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
 
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
-- 
2.43.0



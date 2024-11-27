Return-Path: <linux-kernel+bounces-423770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450F9DAC72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BEA16711D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03A201245;
	Wed, 27 Nov 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq+09duJ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572B201259
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728618; cv=none; b=I2QLZgNEKOlsKjujdcqCNrPnZIgXmmrTyxREY8Xqh/pZ1GIQ6l/kowa18evfwwrULakIHxJ+H8eW4LIVG3DqbkAKXt+CCgHhhvSUe6xdSbSWfHJ2TQ+SMRiZRWYg3rT7yhjx0FyPDseAZnipsZFULfQWkM66lg8HosjmHR2c3cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728618; c=relaxed/simple;
	bh=BoiyYNVvoi8THlJWIAZPhHww2SmScN/TxZ5YDBw3zDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHFySKAp7G5cDUWzjaNVm9K8E/JyorzVs08fKQq0miE3+xkOfLQ2iH7YB8Gu89V74MsUoomTEE6ZEoUhk81gPJBaT67Uz3iSJFI/4BqbMh140b/bPUtpVCqmd8SOG2Z4qjJg3qVqrlQwrG+ZhvNftTLUa/FlNN3IeSYoV3MJpTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq+09duJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fbd76941ccso3662169a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728616; x=1733333416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbG7sBq4g0QTtfrKwDeWenWGnth2OE1nZlbtmRTgTgY=;
        b=Mq+09duJa5GWxmxrcJEnTcErNkYPYLh1uc26zc180aoZPZes2gdkK/D4furPBoM7u+
         D87TE9tKXxq8Angd1YaJlHjhNInie62nQ4PucshMNH8gmnZbNJIDSgNC4c5DnXqxusGA
         trQGkWoNv+E3uWEzbPSbs+d8mtbrG2L3cdSyDbcX4fz17XwXykj1zjzajYi2TL/tjm/Y
         XJ02iI7WFiUAwkuZuXh5d/O47XhP3jcrRAYAFPY2liHj0jANCrv72Nfos3if6ALQopx6
         SC2OB2FKnehOk+rI3vEBryrbIkGMXBrhkiTBWIm2oMRx2A7GsE2NKx5SKZ06aCAnYqoI
         rTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728616; x=1733333416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbG7sBq4g0QTtfrKwDeWenWGnth2OE1nZlbtmRTgTgY=;
        b=MhifVlUVzkGJEU4uJiPdxX8WZ9wDuSZ9EBUB9oM9vrWEOfh0QDReMvT3gfDxSx5MSg
         hw4IOHzwUfCQP1lzkeCxn+zEQGWOP9qlurngiT2puOgpkCaBgRbhjl0ep1Kb3F/iZSmu
         XWFutNmJ5M+R94QJP9qFfai2+4+5Wqmx1aGgFo28cbwaAgv9WQq3Xszv/jPCFziXAW9Q
         aJDTZ+7d5BvxunlrRjEfDX/RUV8TpFq4q9Ms6bc7LcEu07d3JRFdUE6xnwE9mIy7eRAr
         TGregN7dfwT+oSE49+d66y0hBNtfUxRlYEdJiWoN/Kz40a2MveoYGp//WU91KgWm4Vod
         gL3A==
X-Forwarded-Encrypted: i=1; AJvYcCXwp1nVsKrwcT6tV2IwwVag2BXsa8cDpH0u/d+9IoJsMUwIf8yPkUMKwF347pPeUQzOkB4sLdeAaFChjzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGRkLTX+3jervfrJLRp6+SRVjFUOj8fnzRFjxSIpv+xGUwrui
	bJiOV3eIlJJR/IHuBmyOXm7BpugmZcDGOFL6s700aThBc3ZIp/hb
X-Gm-Gg: ASbGncv1+3IsozbGsuFm1EUTnOZ1s6OTcUC721VCGm0DrgcB5FLbprhYOEsMgO5Uc6k
	JY4JWqMZUBqqHlXpzVXJ36VjnxipP4oVOMjuQpxEmi3MujPygxmkfGg0xHBd6BofpHeLz5zBFX/
	3sAHVKXgvhbsKTCgiy3NRE085OcPuSrIcITfeDdJYjewE3kLFzIsg67RIsRecuEDsDNdE0sXTNI
	/CekGH8rHaaBJs8EmMWf16xSAaQ6C4xakwcGdl1o/yG8Cd6KWWeeWhvmwwjDvt0toc1E8/ML9co
	DU/xaiOGiN1iS+/Bm9P4hVw7c+Vb
X-Google-Smtp-Source: AGHT+IGTKYhqvbNwHQrWIr6lxxlwHTKRDAW2bOpNEEsjIU38gWo2Z6YtRqdQ+jNZ7IFsVssJEcCwIg==
X-Received: by 2002:a05:6a21:3997:b0:1e0:ce11:b0ce with SMTP id adf61e73a8af0-1e0e0b90f7bmr8440657637.35.1732728616138;
        Wed, 27 Nov 2024 09:30:16 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.30.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:30:15 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Andy Chiu <andybnac@gmail.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 6/7] riscv: add a data fence for CMODX in the kernel mode
Date: Thu, 28 Nov 2024 01:29:07 +0800
Message-Id: <20241127172908.17149-7-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V spec explicitly calls out that a local fence.i is not enough for
the code modification to be visble from a remote hart. In fact, it
states:

To make a store to instruction memory visible to all RISC-V harts, the
writing hart also has to execute a data FENCE before requesting that all
remote RISC-V harts execute a FENCE.I.

Thus, add a fence here to order data writes before making the IPI.

Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
 arch/riscv/mm/cacheflush.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index b81672729887..b2e4b81763f8 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -24,7 +24,20 @@ void flush_icache_all(void)
 
 	if (num_online_cpus() < 2)
 		return;
-	else if (riscv_use_sbi_for_rfence())
+
+	/*
+	 * Make sure all previous writes to the D$ are ordered before making
+	 * the IPI. The RISC-V spec states that a hart must execute a data fence
+	 * before triggering a remote fence.i in order to make the modification
+	 * visable for remote harts.
+	 *
+	 * IPIs on RISC-V are triggered by MMIO writes to either CLINT or
+	 * S-IMSIC, so the fence ensures previous data writes "happen before"
+	 * the MMIO.
+	 */
+	RISCV_FENCE(w, o);
+
+	if (riscv_use_sbi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
-- 
2.39.3 (Apple Git-145)



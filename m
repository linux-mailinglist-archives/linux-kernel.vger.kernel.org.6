Return-Path: <linux-kernel+bounces-558709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A60A5E9E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EEC1897897
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028207081C;
	Thu, 13 Mar 2025 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS36z7AD"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239313A258
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832405; cv=none; b=QAybXvHFadop6NIZ2AXraBukJ1yEMH4KApzVe3BjXUF++JPx6UA38zmAUrMfyFaRUd8Ss/W9SulUmXvLjqAlUq3BNxhErJDHWxOb7maz2rEiZX+tnAwr3EA5q7kM1VYxtH/2Eb9qjZrdntGM+WDAVBTzv7i93yRcVv4CsIX8C/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832405; c=relaxed/simple;
	bh=RPLcgs6LiHSA5B9TFpPC14NZ5A6TQ2jAShGjBl+sfKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQ+rE1YL3UdsMBNCqTDDcpS1dVJcojO+ShK1Z8qWqtDeBqtzFTBOQTIk3W+bu+s9j+CAbkQXhr2qjCLEq7ULVPV5YNTwMeyNs+MG2RZ1MffpI26b0TPFekOlYmA5IqsIRzb0JFu+WraQtlGBrq2q7ndJChbfz57mMOyjs7vtQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eS36z7AD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22548a28d0cso12780025ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741832403; x=1742437203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYhELuNh/H+0ZU3yo6Tx42VZD/1lCOeZE6fYEs5O9r4=;
        b=eS36z7ADpN/bL4Dtz5RJhNksm3J0ExebFISEPLumciTNC1G2EygWP0NRg/N8f+Zjni
         EG4bYK8eZYQsjsvLlW3u7yjuPp4gqUd27LPCPshrIEXjQ4dy7X1Re92NK93TL8+V0knL
         89a1ODYWD8Akc7Mv/KhfjcW+gi01Hi+yRhjAFkgWU2PBrk/Hoe3zAJV3a4XALsTCAhbk
         YHMwYXImvHJdwN4YzmZdFbZUYhAtrkRfRHVfSQwmQCUkFI/sIZgTlT3dEQuLG6NBIdOY
         i7+VquBVAA/Jpru+ReL70Brox04/CkHnBiLNp5LKvQ4X/OesgSkglHaFz0Rjd0PIz6IP
         CWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741832403; x=1742437203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYhELuNh/H+0ZU3yo6Tx42VZD/1lCOeZE6fYEs5O9r4=;
        b=q+j8bxVDARf2xT2xRawVqKtswFPzPtGYzFmIO8ELwp9xfL9xmjpjBD13WcgTEDFWOf
         KU0iI2FdJ7iuSezCyMan59G3woVH3ysoAl3b1kBkLG6nRM2rCSYuC6aL+wQW9TGZYrnh
         RduoCeMsmjtGVRVTEBSUJEp9kr9JlvhLspEq99UPaAQNCN8oNAXFhsLpv/PDkGiCe5Ga
         PBqv0oyrQ6VXfsnpLMTmowTaRvOUmGA/2yhoBVkLBxPdc940Mzg61LUrOAnMQqikugKj
         cDfC9V/9c3REfNGYtrx5iKLYmPVkSsReg/h6l334WIAqVNYs28ZzLedRvJdW6FwUN01D
         RBpw==
X-Gm-Message-State: AOJu0Yx0Z1hMd2T55XYFC7W/ls7RYHyF43f1C7LUotjiwlnq69fcGnct
	ua5YFJp006eeBeDb0okm5VhmJFBOZuUDecXB/whnvIJ+uRsLsAv8q4jCiAhl
X-Gm-Gg: ASbGncu2+mGMFCDeAEJ8H+kmgMIdOlavzwK5Pq82cY4zpP248lZ+YWH5o9e+73VDTmX
	H3b6Riw1IKTF8I67h2L2/IZ79IS6xtfIeJ3VRUMiUL50fH3xYiSDEqJbkwIOAxdAJaEzHiL/0MF
	0BTIvKXEzhVkMZlxMs/5BFK8CQJC17q+H2t3AEdtVr2XwBTsOHWsYdH1EgU6bfGvpWptjNYDdiC
	h8RWEl0/H9IAOZGtb9Rbd9ZJrfCHN21QczPtK06LS0fcj89DQ6eoxvV8HhNrEg08PrVGz59k4Wx
	yLVCvPXogJGo7hIiJJgYZ6RI0z48gpU3pgtat6ZHinqg
X-Google-Smtp-Source: AGHT+IHcxiSU+kMKPherfsGG+ddx6B45jAAx+w+XqsI7BCKH7gfYWRuQvwRSvxc64ktLopvBtjMDRg==
X-Received: by 2002:a17:902:e80a:b0:224:13a4:d61e with SMTP id d9443c01a7336-22428c0a43bmr308389355ad.51.1741832403015;
        Wed, 12 Mar 2025 19:20:03 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68887fcsm2696535ad.39.2025.03.12.19.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:20:02 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH 2/4] cpumask: add non-atomic __assign_cpu()
Date: Wed, 12 Mar 2025 22:19:50 -0400
Message-ID: <20250313021953.86035-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313021953.86035-1-yury.norov@gmail.com>
References: <20250313021953.86035-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to atomic, add a non-atomic version.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/cpumask.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 9289d4612170..f8caa025c6bb 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1074,6 +1074,9 @@ void init_cpu_possible(const struct cpumask *src);
 #define assign_cpu(cpu, mask, val)	\
 	assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
 
+#define __assign_cpu(cpu, mask, val)	\
+	__assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
+
 #define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_mask, (possible))
 #define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_enabled_mask, (enabled))
 #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
-- 
2.43.0



Return-Path: <linux-kernel+bounces-378094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B665E9ACB3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77663283F36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BB1C3021;
	Wed, 23 Oct 2024 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gxRLzL7g"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6743F1C1AA9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690174; cv=none; b=XrN4pyDJF11EPMSQ/P49nF8Re2401LKAvGadoGmxLHQWw8oxymPjjLcLeD9LOb/YhmK1zjr8FiN/yi2/jpBuhzTJBIKL5Ms84i7RsoLyECHneZbhnwSTwtJfjbYaXT0oTuhAiHH9FfIhb6JYGqTyR7/nPOqbuThyZ0HTKd8QKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690174; c=relaxed/simple;
	bh=Zyh1kxGx+805gAQRdQwvEh+ZEcu1wUX2qKohfPj8MeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pc+36hbmRYV3DMO4GAZr7Co7nFPNPVegZ+hBY6GOVoQOtvNikHMCuRVSjNJ8MKyFpT7nyoXkq3r4C3Ey1HDKtwkOlkqjx9HTm6Ib/89RCXpWZqN0gRZdp9UMYz9gkD/MtP5dC7NtNkmQoyZ7hL4rAIGOR8NVd+GFxxctsBHt0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gxRLzL7g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so63758845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690171; x=1730294971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
        b=gxRLzL7gvbgrxGBGyjsj1GgK4HRIr20MVcnXW0ji2DQFUZdHxExcKndJHP/bFpX6UF
         pxmjlZdx55s8fwA+NABG7DTr0mFKa3TPZiokZI5467VGWpYMRmk3SJcp/HGkRkxhMdlM
         4AO1Wu1Q8+umeUVXGJtreKU9Db9UPB3t2FvSuGWr54U0vdOVdK1YRdJUQa207t0xpk1L
         Cnulu6CsSG46Ntc3bcf0i2CPozIloThKRndikTn7zPB8Ej/8re9wbicAUjtEv5VVJGie
         TE5jpHxx6WeGBEztLjn9cTw7bWFEA1AjaPFRLz9o8g/w63qqkurd8bvjQpdVWnKP7PkQ
         5YyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690171; x=1730294971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
        b=WbiKlr3E7l3B46A3U8fP3TItC0gFuB1DU1PvQYfv75BfdywZYU3A3IcPIl8Yc3ASLS
         YpFEkwueWoNdThL+njAeAexQip1RQDCoOMUrKkqDRcipPg562efRQD5pBZz6qbW38U//
         zEqLhYJ+n18GIeMapHFGdjJ9qnXEHGOKXRQR+LrUJ/xUOEMz7MV1ZYNQ9nn/eDO9FIQc
         X3GOBjRlg/dU1r4tor+MNQBh5ELlNgKdt8OF6+GauM6B1QuWunqNxHr4YlP0rWPVfATx
         EN/9Cvc7NM9mcOuT8dK4MWM/lKwJwcAAXiSSS/4W34oQhE7HUcLo/MP0r7w0Kj5OXJuL
         pnyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Pyky+HOFld7j/bfZaCd/qgOJc9A1yjGNnjpgwhVVo7NTwe0jeQhA5qJwm7IyvJkTeEGuPdduP+Tnu8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYYFmH3xNUbHitxmhUJ+3OuE6YcoI0NM9yt51rcpo9LWBWnhL
	lZu3sx7k1BXms3Q2LL1Liw776xFIEfBk9vmX/hZGp/RLNX9Vu5PcZoD9RWfYMNE=
X-Google-Smtp-Source: AGHT+IGLjL+6vyLcXWbbuwanzigVPV1pSr+WMRIjbyA1L5nsp+zjh0NaqGT9d1TKcaDQH7UYJdPcmg==
X-Received: by 2002:adf:a31a:0:b0:37d:377f:da4f with SMTP id ffacd0b85a97d-37efcf1df9amr1590681f8f.27.1729690170717;
        Wed, 23 Oct 2024 06:29:30 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:30 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 32/37] arm: Implement read_mpidr on armv7
Date: Wed, 23 Oct 2024 15:20:15 +0200
Message-ID: <20241023132116.970117-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement read_mpidr() on armv7 to make use of it in generic
code that compiles on both armv7 and armv8.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/arm/include/asm/system.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 2237d7d006..9eb30c2ade 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -394,6 +394,15 @@ void switch_to_hypervisor_ret(void);
 #define wfi()
 #endif
 
+static inline unsigned long read_mpidr(void)
+{
+	unsigned long val;
+
+	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (val));
+
+	return val;
+}
+
 static inline unsigned long get_cpsr(void)
 {
 	unsigned long cpsr;
-- 
2.46.2



Return-Path: <linux-kernel+bounces-364113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1E99CB48
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEE128168F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550931B0137;
	Mon, 14 Oct 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="EYPySFQC"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E31ABEC9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911564; cv=none; b=bBvk5XRGlhDFB91YeLZvaMsffK6EkJKo3mpyo6PBZKJ8L3dLuCDGv2mZFJ2qAPHJx9CN3TRcsWOdoW/rMoO4FpsgURb4laPKPJflQ6SemDI76No51PHOQeRNbdXaI3OGcYMjppJ9KuNIFaCy0uyuRYYbkLvG0vxWokMa3zcRuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911564; c=relaxed/simple;
	bh=sAspBPW2aJDhH2ElRQqQ5ltJlXwR8eTbuD4hXdxnqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRVYJ1k0ntj7ul1pF7u/yQYxJuIIWf+Txzjw4Gz97nb2H0VGBCUZpyfI4fa//RQCDCpYlKUEwhKi2PORfBWIfA8MgsT24riApHDtFq97c3DjjfmsdAHifq92fLZCexXZLM1h0GrtYOTvmC3eE5AtewUpIYfetX8TjMb2vEeQomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=EYPySFQC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2517425f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728911561; x=1729516361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
        b=EYPySFQCzJbEFjeNP0+BnxdDPbcoiYT1IlbFfYms27IAj6NKNtmvskUmoBdwArp80t
         xySGoUDhRE150PnvILSmIdcg6wDIpY+/2RJL3JrR1jAY3aYyZ4T/g91MEQ95zEwrnKlx
         xdreG1fCXPQ/8YEJbmf17wndgJkBpfQ9FEOnMaWcFt4h+i3Iflx0bAzEy2RPT3hkydJc
         4EBgDcpmcz85BIf9dPg0vPjLXHgmaI66S3rOx7wYORoV4++LX/+8v2gHKnlSvk0OMHRp
         Jj9VExcbz/C6fcUSQhKnlp3SkuyTz7g4g36a3xO3ZUvYSoBIPkrOh3m93iAvueHlGPa0
         uq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911561; x=1729516361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
        b=NZOPX6dJjW3qUPKg3V/5VRD70Way6YW+lTxYP38Cyliyi5zA1RSZYTbUEbQUXnL2kT
         i3do0wgb+OYunfmA7tBLKjuCFE27cuxhijLz1hTWtRLoTrJ6wAE+CTBKBuZ+nvn2BEMu
         wUPjTHlj+XUb1k50slxF89u1HTx5Z+edx0uz2KhhERgy7vH9jHEQ0F/h4cccmLPHUP8f
         QQf3U4ZFlqG/DbUoH4m8VHdMWFmzjbLr9+cBxXCSEr+SRDiGyjrOupRhCtmBT7xG5Vrv
         U34hlQiVTRxNcDwoq4gVp9ttQ2/y80KUkmuajD4e49aQ2MAoolGVU6Uq7TqNPt3FKxFg
         mVvw==
X-Forwarded-Encrypted: i=1; AJvYcCUUM9mGeGYPFBimNAcNK8zL+wNyRKrEgkKqprZns0cYcacF3IRypln/fh6G+t4bKjqtyQSGzSQxeUEmj50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9EILXTj9BMoQdyI7bqcZJwH7MA75Zm2DuOr6kqpgV8NRtmvAe
	rR2eTnmlNdKoD3tmTeRd//p7Qo5vs+EnyAj0A0jj2K6yd7pp1OVFKRKrePcs6aXP4xC0qfQb9XG
	I
X-Google-Smtp-Source: AGHT+IHKr6hifCSkvsXFUJgWIjAVOn3J9Df84gca5gSHqvEfgm4wWvDJ53aO/2l1UY/IvPW0f5YH1g==
X-Received: by 2002:adf:a111:0:b0:374:bcfe:e73 with SMTP id ffacd0b85a97d-37d552cdf30mr8750775f8f.28.1728911561241;
        Mon, 14 Oct 2024 06:12:41 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:12:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 20/37] arm: gic-v3-its: Implement of_xlate
Date: Mon, 14 Oct 2024 15:10:36 +0200
Message-ID: <20241014131152.267405-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translate IRQs by implementing of_xlate() as required by
irq_get_by_index() to parse interrupt properties.

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changelog v6:
- Update header order

---
 arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..0d5545bfb2 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,6 +4,7 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
@@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 2) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count > 0)
+		irq->id = args->args[0];
+	if (args->args_count > 1)
+		irq->flags = args->args[1];
+
+	return 0;
+}
+
+static const struct irq_ops arm_gic_v3_ops = {
+	.of_xlate		=  arm_gic_v3_of_xlate,
+};
+
 U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
+	.ops		= &arm_gic_v3_ops,
 };
-- 
2.46.2



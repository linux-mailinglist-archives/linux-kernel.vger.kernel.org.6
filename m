Return-Path: <linux-kernel+bounces-367345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23E9A012A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FFE1C22761
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F631AE875;
	Wed, 16 Oct 2024 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FQbt3Yvy"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85B19A297
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059220; cv=none; b=FgDAuHuKrjDV/47l/bK9YjUolfnoYqJbJ+2yVRIzxegvv6PCTExlZv8FUvL7R8CT//MlF8IoPGjJMcddDbCfJTZZ+5Slbvy//EP+BPN+SZxz4eQFAd1XXdEPO6e1ZgGODONnAFaelcWr6n2qdwW1/X3WO4nFeSggGHZsBOzz9wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059220; c=relaxed/simple;
	bh=Zyh1kxGx+805gAQRdQwvEh+ZEcu1wUX2qKohfPj8MeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLPzWXpGSCgN0L5Jz7zy8Z+GKUdOmN0zD8MFFZIk5XOZcj5fV3yNz0a1poPtxhBpA7T1nF9VhDsBux5xCBp+V0TG0EBPE9e9CeKPKzQKEbIqJpmNll6gryAlaTmx/g5+7+oTCPbK5l27gh9Z8YeEn510CaTkP85YpwWAFFuMV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FQbt3Yvy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a14cb0147so354512866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729059216; x=1729664016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
        b=FQbt3YvyJK+AIY9oWLIRMImL/t8CuAz/pLsRybrTJAu3STjdZhS5dIFf8wnLxpmJD6
         OZJ77tLNRv4+6KVyRfF19TMrImWTiEHorGMf/HZKBtdjJ0ks9Cji3qoRUWMT4AW73TX3
         Lsg8jVv3c2B0damrvb6kbmnl8Of2U83RBy5MFVPR/Z2dFGV6p4jLC1PURRfael3zpaxM
         462y+wq/om7yBb2Hk732GshM0ITO5tLYIKs4IhCTEuqhrRAaRjgvOlaxtevhmUcyDQaw
         R166c6JYsSo6Wl6F07GNydf2X/HaheDJbeKXcjocfVnktC8h6fCijAVFpZ+0a+VzuCRK
         mlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729059216; x=1729664016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/QhmLgSgzpfvUqKRzoJ1ObwrEVKEApCz9lqhGkLy8w=;
        b=kbLkF102YXRg63TezihD2+FINgii0r6Q4H7ti9YcOpP/ttjG50TkHHXSvDIrjp3ZEG
         NeYnsRq8cNsSal2S0j2aYJIwx3WhHIkhBbc9NGhefKr5D7mfq7E0Fdxsq03SPF13uDcs
         rRy0Uh6/Umo1XMCASCy6PALjm8pl5SGmaNBwVWIA7FGA4ze+AiaCBwYJF7lVFMqx4owq
         ZlxMqfNOeawtgsUJicDmXXmzzoFMb4Rl4IVcAArEgnedE6VPVptagrrYDFa8nVHtUG2e
         uFfTJhebIDfcu24r1p9zPlY8D98E33EUZBi06Hvi+54xqb+n/uqXizbHWlexG3XBrrS2
         f0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVKvtUdyBONPBTD4sjde9cw0VCI3Jo7rfXeInNi6OkckosBKL4M9/IFQIC5W2R8j4Gr5dMtbcYQjoae0HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIPoAeQTW9+ajjjVy9ahIZROo0jsD4kMmqwcjOxWK6DfDX8Gy
	Dl80kfXk1L6nH/V1VlRVTsAleiUyV9tI7lOd1vCAqZE6Mn8JlABDcX7r/Qw609Y=
X-Google-Smtp-Source: AGHT+IFmXDRm37sAJCzhK5tUWURDIwZmaKBhYRlauxNFMFiq4Uwn2TV4U+zYrwkgk9O+873VwQvCWQ==
X-Received: by 2002:a17:907:e282:b0:a99:fc6b:44f3 with SMTP id a640c23a62f3a-a9a34dd8032mr198541966b.44.1729059216603;
        Tue, 15 Oct 2024 23:13:36 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:13:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 32/37] arm: Implement read_mpidr on armv7
Date: Wed, 16 Oct 2024 08:04:18 +0200
Message-ID: <20241016060523.888804-33-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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



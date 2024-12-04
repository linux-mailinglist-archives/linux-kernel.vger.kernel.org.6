Return-Path: <linux-kernel+bounces-431626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB29E4188
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD684B393A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98220D4F4;
	Wed,  4 Dec 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4n1WkQHH"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76E20C48F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329625; cv=none; b=a06pom/D8W8J+yZMOJG0wc08ZEjAxiMojt8iR9IY3NWU3nBTYzjZ6b8jE+CE2FI98XK1DSu/qnIMaFfTRDdzu2V08Q/FAW6VaeWG5h9FkKTVJFRUQ2dNeCXrEwcgO3CuHtpVib4a89wAE9Gvasg6OLLeeH0nNlcgWsL9oAAoAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329625; c=relaxed/simple;
	bh=fJkw2rLMTtXSXhulM8gnhffaFfLiI1f0yAZSjHGcIX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uIA5dd7/vIM5aAtIybCYwIcemSmY42BrwJ+Am1YJPI2n1YGjN2R9czbcg02m4yB30fGd/uPlO4V3cUnT46r8H69fQ7t9pgKrNdzYLer1gRi/um+J2QVweeqLcridPrZd4IBxGfe2gcIvmbCd0+Ai4M3QVxiuEnRRpmLITahr+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4n1WkQHH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4349ea54db7so61745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733329622; x=1733934422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndPjCiEchgmhN558RiQyP0Yt1FLq3iHOnb50r5toGHE=;
        b=4n1WkQHHwDnRHDoSIIEdJN67nUStmUBcHEIdSHqvKaDm5qIzzeOEW+FB99ksnz+Y4B
         sB55fX7bW42s94SZXDFZy+jX5zRFdq396No43GpqTPT2w9LMFeMMXS1UCT3UWWlRokUW
         jMHlxpY55+RCl98zk/WkZY8RF1bJgLFi5W3mn+pU8SCM2ugOa01Gj2yGiWsr9IV8C4CH
         gBaQzIYQwRUib4RlMxXX7lQkv/P+6LHHQBxt2UUzD6CNVSIchE01Sjg+HTuQH36mNaXK
         Jmke3uWfIOStAuD8Fk5cfMbH4RH/X8p4dVHTs9midILE1TrB2DpLsA9HPhOlsBmFt4ll
         ZlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733329622; x=1733934422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndPjCiEchgmhN558RiQyP0Yt1FLq3iHOnb50r5toGHE=;
        b=cOjB374ytTxU7V4ONgzTfLQZS5JTGN/Z/eR8RabVC3+dgKeKAqnvhRM2/Zs+aM1NE5
         njJGf45ZwoSSY7yFjOXj5DLt0tSWmAYsL6ihlJkmksH99xlijv4uyWftVlxBVYk3Llwl
         ssAtwV7P4cduBZaHMGY4syhCHX3x68iuTEeRG0kCMHJJ4x6Hnz2oZ7uaOVzaVqT+aUX0
         7HvFqIfNOaP1FskcEk9dXozONdVaYTB3ARG2Hg8/9bh4AxW4B+nucjcwAZTgiN9a5g5D
         R6i0Jf5lJ17wJhBPe2Sr6vkpl6VVq0MyGdf4MisK5AG/9MMHqPtXgX670Q+e8chGfcLa
         rMFg==
X-Forwarded-Encrypted: i=1; AJvYcCW+5M0w3+EkLjmXzspl85/BAOdFOrVdOpW9OkO5T1J/xrn/0XuPUWsJvIfy+WabU/3OGKKhGj2LVaIRARs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG6nXBzdHu+owFQYWuLY7MV/acy/tkSViIEi7MyTii2mfIFwWg
	XCAnRq1H+tfPkSWaMkzlunv2YOkyj8BHrMtHacB2YuOrGzUxNI18V6oZrFDemA==
X-Gm-Gg: ASbGncvI1XlKV9rMI24gpZMG0Qr5Kz84jXIRt8nqrOYoSY7FRKX5N7e1i9YDnkW6An/
	IzYLDD75nI490qLoX8hToBXvuF0DOmNAlq0r8OQKOhzUAA37/w5jeTjhBvcGWDDfIOIG6c+K2La
	/UXP/7UzE5/VLevnItPQzP1O6sHeiqiweB7tbJ1vFvXIn4K3LmCON1wdQCYRqj/zbMMwLKJv6lp
	mG9aoGrSHvkuUt6FpDMlCPWJhIR+gLO3jwUxQ==
X-Google-Smtp-Source: AGHT+IHRNnKQuL0FzYJ9sRykYWh8jH2cm3zF2nEbZZRSS5rqUEb9oxCGR02zINfXQfHQRF/jLblOew==
X-Received: by 2002:a05:600c:3ac8:b0:42c:9e35:cde6 with SMTP id 5b1f17b1804b1-434d4a5d4a4mr1384465e9.2.1733329621419;
        Wed, 04 Dec 2024 08:27:01 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:4606:5fa1:8ade:6950])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dec66e0esm16298133f8f.43.2024.12.04.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 08:27:00 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Wed, 04 Dec 2024 17:26:20 +0100
Subject: [PATCH v2 2/3] udmabuf: also check for F_SEAL_FUTURE_WRITE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-udmabuf-fixes-v2-2-23887289de1c@google.com>
References: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com>
In-Reply-To: <20241204-udmabuf-fixes-v2-0-23887289de1c@google.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, John Stultz <jstultz@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733329589; l=1031;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=fJkw2rLMTtXSXhulM8gnhffaFfLiI1f0yAZSjHGcIX0=;
 b=NhY0leWwseGXjAz22badChvpbfQCiGr6eextWw4sxPskRjjjSOJH/wPzPkPy4s/BHbCWwcM7p
 LC618vgQbjWCzsNvNI9+Z53VJP06p8zJnx97CEnj6l4JcYpay7agU4B
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

When F_SEAL_FUTURE_WRITE was introduced, it was overlooked that udmabuf
must reject memfds with this flag, just like ones with F_SEAL_WRITE.
Fix it by adding F_SEAL_FUTURE_WRITE to SEALS_DENIED.

Fixes: ab3948f58ff8 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")
Cc: stable@vger.kernel.org
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/dma-buf/udmabuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index c1d8c2766d6d36fc5fe1b3d73057f6e01ec6678f..b330b99fcc7619a05bb7dc2aeeb9c82faf9a387b 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -297,7 +297,7 @@ static const struct dma_buf_ops udmabuf_ops = {
 };
 
 #define SEALS_WANTED (F_SEAL_SHRINK)
-#define SEALS_DENIED (F_SEAL_WRITE)
+#define SEALS_DENIED (F_SEAL_WRITE|F_SEAL_FUTURE_WRITE)
 
 static int check_memfd_seals(struct file *memfd)
 {

-- 
2.47.0.338.g60cca15819-goog



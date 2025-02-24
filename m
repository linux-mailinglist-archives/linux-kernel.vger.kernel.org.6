Return-Path: <linux-kernel+bounces-528998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249E1A41EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A604C188DF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B332192FD;
	Mon, 24 Feb 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPIBvpjD"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FC221F25
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740399333; cv=none; b=S6mrBRb4Tr8/4WfyjBNebMgo0zngr2MBN/pWh6IVonoS+sZ7tdeG7fAH8oX7/IDd4bWgIfhecNvlZ/WaojAtJJl1vgQ9HPQtbmzgf+hXhdB+SufqWA/Pv7wVW06b9FrL+hhOBvPOnbp+5ji0GoReRMYr+1oxAS+g04caHCTc2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740399333; c=relaxed/simple;
	bh=F56QYlJoDZJ+5vN4/HPXUDdjBW0FdSUoL0+uYMqsb5Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZYBAErKmD9d805i9O0TPn4FJXIP3ao81xcQYcGOFAgSlacAQe6GCyvSX/SxPFPu5KOlUwnotWuc9YOLIJ5EsbNqnH+scZBFVXuwlhRg5Wo3sZ283GDOAoh1v9rDdqjU9LxTxZqJYzH2Zwi97B7nme4JffMucHGOHfjZ9Flv2GZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPIBvpjD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394b2c19ccso33627245e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 04:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740399330; x=1741004130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=boWUnC75AglyvSxymfq6WOxHhiCHfMqe3a7p6Cadurk=;
        b=ZPIBvpjDq3QtbAkreD4aitJXkXfB8D9uAJP4PtnAd3Uwsxn22rg37KW2lcKFx0nMJV
         fOy23ntqrfOQ1wO9ccYouFfVSjlUw0nRoZ0IuOqS8aAI1JgLpU2ZpCQlqu+i38Jfxjc6
         ECrGNq0Awx9zLjy6ESP0S7Z+lI28S0X19/DUSsPjm7oaqwgPg+OPYsDin0Tz+sE+rcZl
         KYGRiKtmDNKxREd2RApItS89IULkzMZuBzDyRZ8ZEkdLZuwh/NUT4OSRxmDsquRJ3qsj
         1usNdKWnU1zxzzqrqrbd/H8CivceWlX2NdF0keazKApy8LGk2iGDfU+SgA7BQdj/WIqC
         /LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740399330; x=1741004130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boWUnC75AglyvSxymfq6WOxHhiCHfMqe3a7p6Cadurk=;
        b=GvbPANCBWSGdJw2ZoLGzR0M3mxh/hdKekkgdGwzaJcLC/NK0cPcmy9PUAECpenTaiK
         DREWyfdCIWC89XVc/HYbyfjneTIovdBqzQZquNNeu3BBYpjxOq50qQSClIWUqw3U2/qL
         Szk94dJIW2DmEImbgsxUybEcozQJb6mdVIudxG0Uks789PrBwANQx2EmZzMaKfFPgb/s
         r5DaSTty+WrHk8AQnhsvuLjkRQ2G+gbH6/e/bU2v9FdZGVvo+3XklB3pt5RyFYM2O7ue
         /k6nwCvAjAt8/vgu8QT4EeF+MBFUpJTbQmQRa95xPQNWxIxKl1ySNXu+VfbwBUS5X1Gz
         Zhjw==
X-Forwarded-Encrypted: i=1; AJvYcCXDWJUGHtcOhZIL8AI5J+9TJY3hU/u/YrpDfs+Op71vOG/8gxpxsJQytZWHd5AcjxIPhskvS7fr3zhsLl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVORnW7ZRm7HeA2BlID0tJe4Cb98SSF4ap0+MI7cjfvZGROzMm
	i5EiKNRx1cHcSIqWSFccd5llTaLItq8UmJ5ZZB8ywlNot9tttq/x7t6yk/bLJz65mmaWh5p0CGU
	inivVWqWrnLpZftjakw==
X-Google-Smtp-Source: AGHT+IEZCk3oy+HQSHrsEDAqwXlupd0xHmeS8IuL0N9dhMMAdmGlo9OyR+iiK51V+OKl7+wJfLEr+VwrJuInfXQr
X-Received: from wmbjg14.prod.google.com ([2002:a05:600c:a00e:b0:439:4366:35c2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f88:b0:439:96aa:e502 with SMTP id 5b1f17b1804b1-439ae1e6a2fmr119293615e9.12.1740399330189;
 Mon, 24 Feb 2025 04:15:30 -0800 (PST)
Date: Mon, 24 Feb 2025 12:13:45 +0000
In-Reply-To: <20250224121353.98697-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224121353.98697-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224121353.98697-4-vdonnefort@google.com>
Subject: [PATCH 03/11] KVM: arm64: Support unaligned fixmap in the nVHE hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Return the fixmap VA with the page offset, instead of the page base
address.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index f41c7440b34b..720cc3b36596 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -240,7 +240,7 @@ void *hyp_fixmap_map(phys_addr_t phys)
 	WRITE_ONCE(*ptep, pte);
 	dsb(ishst);
 
-	return (void *)slot->addr;
+	return (void *)slot->addr + offset_in_page(phys);
 }
 
 static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
-- 
2.48.1.601.g30ceb7b040-goog



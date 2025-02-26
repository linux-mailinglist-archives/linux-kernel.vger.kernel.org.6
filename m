Return-Path: <linux-kernel+bounces-535152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD93A46F96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76593AF830
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E328137A;
	Wed, 26 Feb 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMnQGyMG"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423C2620E5;
	Wed, 26 Feb 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613390; cv=none; b=Yv9ldVbN2yiILc+nFNUNMJNpOOdcrVI4c63S1dO0nRUGjLwU24MCWhkEiumQLYlGbHM52jkRkcDTfU3nPlWpf2pRsec4NZ61TuIOleddGEwOViy0Sgps3aBBG8hJec5Q3TesFOSAeKVFJdTxww2EoBH/Fj2gYQ2TqZ56tK06Bjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613390; c=relaxed/simple;
	bh=dyuuxAMJmy1jUNq2vusCG8A/JEHelnf2zIDJsSHAoYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtTqLPa0Ld5d1+T19utDJS5+ysalrsJG+aVrW7o6SGIjPoyI7x8QDJG6ckpqjnuftCANKi+C3jRBY/w7ixVZ1NHi/pdyPAxIUGrQap8ccDcGvPnFrG/BjryK/TnjeUEmiKh9FCzBpcaKU2P9mCy1T7vnJbKUZ6glomT8Z7D4m8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMnQGyMG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c09a30e14dso60399485a.0;
        Wed, 26 Feb 2025 15:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740613388; x=1741218188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3ZZcc6aFlJ+Kl9Jw+kBevA1072SNgIuZeodxvN8Etc=;
        b=EMnQGyMGNkYZ+TcU12sG2xAqDHPit6I+k08GbLk9ka7sPBgbTqqgejJI2dk70GmMLH
         uHkUTLDPAJADXEzLWLkvbf8c94efuQbBqmw0sTaU5Pt2vBDVSHG42EncbCwewXmX9mwF
         f3YLoFX1IkLkCUso3P6haVCrWmd7fdjYv6nRdJxV+47W8TCbjzXejLXGgcoqF1Rv/jID
         8wOd5kSd+RFugCSu76wrV5j7KIlBKWxvAO5Maoc5AuldGicn0HOM3rYQOJELGaiE2Uc1
         g8IQ6LcPStgw+gMvd419kOU8DO4ciiWihzrDQOXbL3+4TLjMQnf5PKIjpPLCg/6S+5++
         E5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613388; x=1741218188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3ZZcc6aFlJ+Kl9Jw+kBevA1072SNgIuZeodxvN8Etc=;
        b=b8BAQFZgfIaYkOtVsn/M1sCeWUtdQOdIKdveGBcUuQrsrgT6xcfJgwY62D8ps0+uhg
         0ZEEkY//GwyV8k3KTA1SATE1CPmIP69WnXQcjmnShc/Ck9dQHzsRAiHbah5eXYEETcYv
         pFnN6pPNERB8NlYB0pbvpQeWYKfhSG9iSTBot27bY6h9Ypt8E5XFqfDqEhjpxZ5I7eWA
         kKXTwqKvx1BQG5h035sE8nq3lMaG53jBPYTrWCKW9f8EV0HiUb4G9DPLJMuz+Qmq45DO
         nnOMnUOqNx2f3CkUtoj3Ptrj0QKvzc3tgxCI7YrX42VCoLKc2PKQkTrN+D3wvkAR8NQ7
         P84Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+VG5+cnxTUUDwLCq+OwJKQtAX0dZ/xakR5QR8Nj3+P0W30Wah8Go4gCyy2I40zg1Rs6/h1fj4M+PG7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53jUzoN8bHkYvAoo1RZcLjIwwuYlcKHB8iA9vSt7a2QGSVmzZ
	t4+FKUmydqGOfYTCJtlkLKcKYMGIjLbuRjv1I1EVXLMYIdbUTdYp
X-Gm-Gg: ASbGncuRsCeURLKhH3hOHWn+z6yw7z8u7MutF/gkmJ5Ddx3AaOM+S6U8JVSV6QB5YDt
	mZo+0KsyahfqXUkwqjLUBD9dF5P2Rw1lO8bCNYN+Pv/WFK0Ra0EnFnSUznNXFCG5iSIdn3G8pIQ
	G42zSpCOF+w4nlMI060bSpcsLVuAjjFkqAGAsVWjbS28qtIu3pMKdvdcbHiEtUUVgm1qBFkTRZv
	/9DAlsSOtalyGvM8H8bczy1O3QY0gC5K94F0UC2chunn/JFkMKtYCXJdgR32w87inj+br40SvTO
	9A==
X-Google-Smtp-Source: AGHT+IGD3BiOa/Df2rVPvpy/tGOHarw9GjKQY9DsMSLrCoKOy4FTIEiF7wxb91QFop6oTXwxGEZsUA==
X-Received: by 2002:a05:620a:24c1:b0:7c0:a3bd:a779 with SMTP id af79cd13be357-7c23c04868amr1554444085a.47.1740613387864;
        Wed, 26 Feb 2025 15:43:07 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36ff0f756sm24200285a.61.2025.02.26.15.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:43:07 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Guo Ren <guoren@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 3/5] reset: simple: add support generic reset-simple device
Date: Thu, 27 Feb 2025 07:42:31 +0800
Message-ID: <20250226234234.125305-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226234234.125305-1-inochiama@gmail.com>
References: <20250226234234.125305-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for generic bit reset device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/reset/reset-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 4b08f8d70942..0681f2db7459 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -149,6 +149,7 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "brcm,bcm4908-misc-pcie-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "reset-simple" },
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },
-- 
2.48.1



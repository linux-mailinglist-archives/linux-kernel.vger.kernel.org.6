Return-Path: <linux-kernel+bounces-203221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADAF8FD801
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E6528A9CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EB15FA75;
	Wed,  5 Jun 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4x5jKrZ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0725113A40B;
	Wed,  5 Jun 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621255; cv=none; b=AQRCvhWtUDBTf2eoUMHYfjq6lpR4XdsMfmRECZl9Bqm4nTtsOUeZYEvapoHE6h8si2PV7K1G6FZyeKsTSohCyX7WjzkfCSNbJZpO79Fph0P6ohl36kbLJEgsgsWhd7ksin/07Mt/M3RBN5ABONr4ZsDkTik8EJoko1mKiF9ghlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621255; c=relaxed/simple;
	bh=oUhHL9Gh1eiLkn61h89qakuHxe3kwFPwvQ1qeKNnvTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqUnMceC4bVfN475agRS40GDjX9kOHs1jn5b0QC0+o3anhD2BstWbmCYXb5iWty74INrnA6oHd6smU1L3dFR6pz9h7Xdo41a1Qp6pIVPJWob7QwZaLL3aZ1erGn2Axr0SMMoCvd7tItWi1YedNaqAOYkhcIF3knpF5oQ3FsmL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4x5jKrZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35e5604abdcso880246f8f.0;
        Wed, 05 Jun 2024 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621252; x=1718226052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuZhauiIXe/dPit2+IYYIDdw8J65X44pe+rX+iqZzH0=;
        b=f4x5jKrZiqjjuycndzGo6ClE0pGaPRU/JgkjiWYFA50a7gHv6BM/lLNgHU+IC3ZzAv
         s/Nt0PQNZp44pB9hM0QXWdzWofqsTUaZBK9l+ybtaquH6AFZB5WLc5aS0TIwmnxFz86V
         2eqULaiAmL6mLP2MqDRAiWU1T8/uxtlrTSRpKfIYllI9npPh9G8aWORWoZutJ4p/GFJC
         tyJh9O8IVGuVbnjIrcQlgJtUkhLbHGlN1Uf4sgDnP/S5ZbXtQMM7mxrxBFAUdnT8m5sQ
         AdtPa4Igpf3vc2FRn2UbcyO8Y91HdHi5VZA2ZlAejWBIyPVel8/K6HhDEI4vmw3OOeiA
         8Kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621252; x=1718226052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuZhauiIXe/dPit2+IYYIDdw8J65X44pe+rX+iqZzH0=;
        b=oMg7sHJPhyUVVGc3Vi7IP88liti7r4lttH8B2yVJtCM7KIrNYKK5bNKkjkGYC+KMyA
         8KxHF4EV6OUJazFL95LXxCmNhY9AoA9oetY7LSYZpm1Kb+86oTXabEuKzGu7bEZ7zrpt
         HC0w5ssXqfKvg2DmILT/dnLNpLSLTH0ivsKuNLnaHVEveZ6R/OX2QCQTtsyyCUlTMwRq
         bih5D0c7fE0UC+qyyEj6E7UyyrHOamqtQuc9sZkjw6CHWo9KAlSz3DDDKJ4iJPR3TwVX
         AFcgeIGa3RtRNU7ZXJj3POc2u9JJjGg6w3p6741w4zBqSJq3Z9U5nc75zDHFtNwYPr8X
         ZotA==
X-Forwarded-Encrypted: i=1; AJvYcCUow1ABjnyHTRT3uKQgSlL+umGS9tFImDXCoWYU00InfLgnTtbPMW8TuoPptv/UKPuxSvUpHn/hgS0I0i6IVaBQV4Fll5+OZamr0zEZHdLkcs8Td1NQ2D6HI77M3uTwCNSjckucwxC9HIImK76jjwZQgesi0gu7OtuEPxs14OEBokMxOw==
X-Gm-Message-State: AOJu0YxIZG82hWwsySvi6fPBZQpReNN0WkaEcd2TqN8MlURNSq4P7+1j
	pi296hkwm+ul18EwZ68gi8Se6G6WYD6vl1qYZ8vIgXvduMv/4MY=
X-Google-Smtp-Source: AGHT+IE07M3Ayc5UVGzWAK6FK9JW9Ttxd18yCpMX1vjpRHWw1Ldtf8cyezEw5LAY1mfB5VzssLahGA==
X-Received: by 2002:a5d:6d8f:0:b0:34c:7ed4:55a with SMTP id ffacd0b85a97d-35ef0ddb092mr806043f8f.33.1717621252274;
        Wed, 05 Jun 2024 14:00:52 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d77sm15955721f8f.5.2024.06.05.14.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:00:52 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 2/5 RESEND] dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
Date: Wed,  5 Jun 2024 23:00:46 +0200
Message-ID: <20240605210049.232284-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605210049.232284-1-knaerzche@gmail.com>
References: <20240605210049.232284-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CLK_NR_CLKS should not be part of the binding. Let's drop it, since
the kernel code no longer uses it either.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - new patch

 include/dt-bindings/clock/rk3128-cru.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 1be455ba4985..420984fc2285 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -145,7 +145,6 @@
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
 
-#define CLK_NR_CLKS		(HCLK_PERI + 1)
 
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
-- 
2.45.2



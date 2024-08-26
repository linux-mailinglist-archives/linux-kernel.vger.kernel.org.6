Return-Path: <linux-kernel+bounces-300768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C32E95E817
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65241F2167C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA4378297;
	Mon, 26 Aug 2024 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiVIUoqX"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B676757F8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724651386; cv=none; b=Rt/8CizYOm9u08YcWZCvAQV6mj2M7nBRUbEkHmr5dz5y6mTxdoUixnGS6IPnh5srx7g9Ux+83NH0rPn6vN4V6Hr3y7/XHbnpOuIBBTVQHHdqHXVKamhenuWeRQ79a4aTsFW1hdS8C6ZlIeCpTklgxb+kA2UVXootudOZQ67uL3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724651386; c=relaxed/simple;
	bh=K/YPuEy3jT6U20h1SinyVF6BS7PsxSkAc3o/p/jVW/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWdiswA6KiCmAUU8cTQ02HhJ5Nd1bjh8h3tufHZgVxZ4EIKuUkN7OH209VcXV/eYkpvd0vA8wlBA6NrzP7RPXgiIAS6o+WMintZL+JbwomC2wfSzOvkRAW32JboGeKl6yoveIU+bDK7MKzs8WjPDvyYdkgOpqBOecULrnw8plcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LiVIUoqX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-371a939dab9so528419f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724651383; x=1725256183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r2i8zaE0YtzEZow2QdSxGHYtA7tYlYZ9iUN/peY1qCA=;
        b=LiVIUoqXcd56XGzgKZV1BBkI+QhBaOXF5dxCwjOMrAi8OzR2sxEan3a3KvRawqt+8c
         fM4BjZWADNaHNI2zeBnH+VNHhlZTV0vrpijaM6KSBfA5q2VOBAzj5dDlPGLxk37VhJF0
         lTHzTSLe+k1SVCpufFxSmcxGfnoM6riZY19JQxVvLBQGSpj8CmJkEe+GYD6rQnCqHC5Q
         /qP5+7P9yhdi5N2E9NWdAOn4A4P3gp4itX58A4zvGQLLQleIkC+DJVbKmh+E4Q1L2ySg
         FZUuCxgdVHC36/FXNWm6MJhgY45O9niQqeUG1SVOJuhoGXn/9E+bsZOCZCGb8RacGhvc
         cCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724651383; x=1725256183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2i8zaE0YtzEZow2QdSxGHYtA7tYlYZ9iUN/peY1qCA=;
        b=ZetUSQgQuSEXv9wxavOSOWevaVwqn+tN4DbTMES3BD2Mzlv1qVvv/1drtB5JOf9cki
         Os16+/o++5RUPj7JVd45LS45wXLtkFf8VUk2QxQT5u0TW7KIPyMCxKlZVq4Y7FqPz93S
         oK4Ne23SLD8RpW23y+NIsf4iYVgvOHrFMHHEtNpXcx9aLIHQ3Uku9f2gaTFC/Ge25DMf
         H7BLHKNto0taCHjWQ+7aOptH/TNtlRpezIOnojmCipJyKjImPbDthdabnbBfr3PkNN2x
         p2oK9x+ZS8/D8OWI5I3lpwr9IECIOfegaVZk7bH1xQgnnsLi3PsRPXU+CQ0fmgl9NZEO
         ohSg==
X-Forwarded-Encrypted: i=1; AJvYcCWXjTbzYGTTdraoGDhKu/OIuS/CGwnwiD5LmmLjwvLsR//Xyh8Yxpmgv71xDQN5LoxrNL4uNzlFd6rlKiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydSKdVeQxYScugwnbl7dpGidL1uzqwjyL8il1xJKN2gDbchdhz
	zey+sxACOplQz1G8iGDsUyKiTzHpI+ztW0hJYOXSENU0Sc4IN/D68Gu/Rq2/eAk=
X-Google-Smtp-Source: AGHT+IHE6P4oD3s3P8wsBrvk15qfQgG2eaRUaX3kBBUATpxHS5epKJAsXSqueKmZp/eKXkCcEt0ANA==
X-Received: by 2002:a5d:5f48:0:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-37311852317mr3885621f8f.2.1724651383043;
        Sun, 25 Aug 2024 22:49:43 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8d1c9sm177632025e9.23.2024.08.25.22.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 22:49:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: versatile: fix OF node leak in CPUs prepare
Date: Mon, 26 Aug 2024 07:49:33 +0200
Message-ID: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Machine code is leaking OF node reference from of_find_matching_node()
in realview_smp_prepare_cpus().

Fixes: 5420b4b15617 ("ARM: realview: add an DT SMP boot method")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not Cc-ing stable as this should have almost no impact, except code
correctness.
---
 arch/arm/mach-versatile/platsmp-realview.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-versatile/platsmp-realview.c b/arch/arm/mach-versatile/platsmp-realview.c
index 6965a1de727b..d38b2e174257 100644
--- a/arch/arm/mach-versatile/platsmp-realview.c
+++ b/arch/arm/mach-versatile/platsmp-realview.c
@@ -70,6 +70,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 		return;
 	}
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (IS_ERR(map)) {
 		pr_err("PLATSMP: No syscon regmap\n");
 		return;
-- 
2.43.0



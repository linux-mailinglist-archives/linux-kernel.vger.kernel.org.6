Return-Path: <linux-kernel+bounces-516229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2604FA36E6B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36C01716FF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63931C84C3;
	Sat, 15 Feb 2025 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="imVYqRTM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D11C701C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739625163; cv=none; b=PjUyUrr4d/EZ9h+0IY/7G1gRuixDSlGAnNse4Awmkwy9Km6rXT6Gc7Ba5cet4wBZgBTe3i9AnvFBEgkmA6r2/mp09l34O8qiiBOarQdrCpBijJZCnPr703bMs+S+hkzSYiN91TSvjpjRlVvs71ZbPOJrqgPuexQwO90unsEpj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739625163; c=relaxed/simple;
	bh=kqJhfXI+i5MZlzlpH0kJljCFi2elURZJY0oYoLVGE3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LSDvsXQ0mzYJ+7rqCBPB1t4QbnvaQvL/WMNUgHggo4zdJ2KrTAAo2Bdmx7VV8VLtmNwPT7BoihPEjkd1V+wDIkpIPybHRv6EcT+4B6zqkiYasAOl9ljDgmqjfww25wCQ50Fw9ZUQl8BkYuGQLd28L6j9O9E69xrrAtKkkREtlNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=imVYqRTM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb7aecd39fso62815766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739625158; x=1740229958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+v/olVdsNjQIMDpCltiAzjI2f/hzh2HRF4DFpt5Fqo=;
        b=imVYqRTMA0rIzrydAiNEWiefpuq22JBt/svuZKlnJ057iC2L53yfhk13g+HtQ5GPm0
         lrqghby0kM+OZZ6MRD+NcOqwwoCstcGFAj6wYfPFau820PR0b7lKI4fEYHIwqjrooltc
         iP6P23szwbsNgKNU9h0uxv7r9KIMjfnk/rcxGPKiGmn5EWeaoTHxYYOWl9JSW53p02Y9
         +XmCNfPi766DajUd097vRbrvMmjyDBfi/TbZEGBwU1Ock26A/2Epax/GZB63R5YjI53L
         xX2dZgyUP4iD0VAwxMZXAvwldWzXfbSUfBLwQwPGyfcpz0bxU77Q/7ZIGey5HEmflnqe
         T/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739625158; x=1740229958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+v/olVdsNjQIMDpCltiAzjI2f/hzh2HRF4DFpt5Fqo=;
        b=viy+GVPhkUayRLjuqKJ+UmcZOudlvKIgLPgEtLDe1FUE0lISp//kIjcUY0Q0IrDf0Q
         P8zms7WXDULaeLWfBZ0DkCAHp+ejrmxWLvmvHMxNqzoJKjGPNvO0o9QPFvNhCM2gFBUA
         k6v7o/ZiTf1lvqv2E0LzW5C6IGGJPhfDT4G07spjGnAJWsS4s/E0gq69fJW10XjhZgJF
         llVeYyFeTlIq7+vJe8Mh5MsO6/RdmsFiPliOWlYJ8cI3LvuEnLl+lpQ155/RLnveOQ/M
         tAtmejbMrqy4Tv6AWsAoPh5C7w7j19IqtQ8UWA813isMeARB3UlwAPUl1hKa32x6h5wr
         zPqg==
X-Forwarded-Encrypted: i=1; AJvYcCUdQaMXrbTPhhyTnvthwjzuJUPHRzBQra3+5hXadUJorOrpuNkdbFve4NXMVqr4KuSVw7sGQq4EKRtb7bU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jDgED6suL1j+aD07oXh4FQseBsP3wbmQhl4WA+XXijCeP0d2
	GilRcpY4eokBnemBuhbevnE64IHVYM/P1qFcR9Q/yv4JRLMJCxKwLKFDTaHGcaE=
X-Gm-Gg: ASbGncvG/npCiGHSOnBgfdDHLygjw4CpzgT9b8aXP9WmsvGKi7dPyIsgSXXY0ehMgKM
	dOWSWFn81qUxlQqAu8ssuWshr1KTuFaV7CAg2bi8wA01PVLgKCFGGNXK6AIVsv3yeuHCrBJlWG1
	UUQlwQlWdx0GlYzdlN6UgwPwDzaFzMH/vQ3wnh/iavTWULxA3VG/h7eTQ6rlBa5qRkv0pRLc9lw
	ZgS4n7szUktvEKJ3T3uBxGi4uLd9G/xyALMsa00IR4TGmWjBFwzMcweLw4L/lvk3yI1JNvyHC3S
	tngeQVEBMwdkTunu3c2idv4ONv3IKKbHo0LL0EKTXoOVVg==
X-Google-Smtp-Source: AGHT+IHGlrrgVz5JEinVT+JSgLk0BgO7y0QXdyl23G+Z1dOq1A3nA6LJrZK0R2Q+k2rxgykw6+EBqg==
X-Received: by 2002:a17:906:6a0c:b0:ab7:d34a:8f83 with SMTP id a640c23a62f3a-abb70ab8b5emr267680566b.17.1739625158403;
        Sat, 15 Feb 2025 05:12:38 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb837378e7sm39289266b.52.2025.02.15.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:12:37 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] pinctrl: renesas: rzg2l: Suppress binding attributes
Date: Sat, 15 Feb 2025 15:12:35 +0200
Message-ID: <20250215131235.228274-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Suppress binding attributes for the rzg2l pinctrl driver, as it is an
essential block for Renesas SoCs. Unbinding the driver leads to warnings
from __device_links_no_driver() and can eventually render the system
inaccessible.

Fixes: c4c4637eb57f ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index ce4a07a3df49..5f006a059d9c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -3386,6 +3386,7 @@ static struct platform_driver rzg2l_pinctrl_driver = {
 		.name = DRV_NAME,
 		.of_match_table = of_match_ptr(rzg2l_pinctrl_of_table),
 		.pm = pm_sleep_ptr(&rzg2l_pinctrl_pm_ops),
+		.suppress_bind_attrs = true,
 	},
 	.probe = rzg2l_pinctrl_probe,
 };
-- 
2.43.0



Return-Path: <linux-kernel+bounces-511856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20945A330A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CF818899A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC29201253;
	Wed, 12 Feb 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgQwU77y"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7E201015
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391587; cv=none; b=ffV4bDGoFpHmFgufZDII+ZO0edZvJWZvc9TQg/epX4jboqTHv7oiwlYJAGlBI8xbVgnD4JZGTgc8b+PvZWtiKf74Co24JaR1RNQEIIqquHZ93AO9uGJ/nhozD1V2JTurezjlRjzfhJ5rU+StmILe0u1exg/c29QjFJ1M0dXiSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391587; c=relaxed/simple;
	bh=4Z0JQhN6fp9gquUDGJ84tUXaVmHYEEGbPTsb0CbEDQc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nVfzLTr+HDLMErkZJVq92Jjg000G9neClze4ror4cNm6+6YAI8tDBznxphi3FE+29D8zvWQTwrkl4/oeJFZMySme0Ahi7WtwCfS04jQLOHmI4GaURsdB59cO7fz23JdIzvv223gTbef8219QMYD7dvJjwmQ5QRPWa/oUS5XewmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgQwU77y; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so9839a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391583; x=1739996383; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3ckrB5J2xK0c/DqMrzhF8wIxf+yknZR24r322/l5ls=;
        b=mgQwU77y4qdgHWobI2TcO/weU4yPRIz/y0P0S6FMMPOT8yhi8K4wVEgpuhNXNecHZo
         c63iY5CxmtC6h2VY9UF8OY4q8FxdCsGjXpxtUX13Kum6NQVcvbILvA8lWuodfc3fUOky
         oekMU86wqMJbezRlTyueWCayGdpkAAvB1NegpcwgWiAUIcCtHeB52vjHcbVN3B0pEFuA
         yg0PKrxqmIjuUtx1wOMaHFOC6nqYOQCpGY+5UhmZsuoZuH1asTNaehQa5kQrM8POgwRs
         P313E+u33BgS0yHTEcWZxTeV0dyxbNv6HKZDyR5gmncBJJSRzB2ve7TjefMSmr70OjXu
         ENFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391583; x=1739996383;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3ckrB5J2xK0c/DqMrzhF8wIxf+yknZR24r322/l5ls=;
        b=qeC3pphXxloGQtxlgZUZLx+KTYAFNc+jiD0FY980bRIwBJ8jkPmcv7eBuQLJadLtWA
         +IQ1JqQlWC7QmJhcctietB2RCGd/R4MJCXZ0W3dI+JiXLkx211dNhrOEGXg3OWzR88dt
         n89FPGpTDGFS8vqwhryYuLaTMGLmFKYKZ0KEsJsdozyIDWM5ztQp3TtXrT3BJLREmDFt
         I68UsNiac7XSQqTl1f5GXuzBJHr+FbhEGFW1zC8PB/RswdfPSTEoy0eZAT4Hu5MHjMXd
         HXo096U8TYXRCulnl9XPtYTcK16DnzcDyDrDhS1mhoOXO27Np0pHbYpmM1dXqJ9mBPrV
         91EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXM9BVbq3YCz5QeeIjOO5vWkyuxLj0+2gPZ+iw62Gd+A88MkMDVpGC0wEJAJy4AdMxJhtfbYgbcARmq0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTVlMT6YvqFgTATprVmqHKZhucMIA8TbKb9QKFz84OE9H89Gkv
	WMDkFZ49ZyvnDu5htXNf0QjYep8ZBq6K1bKWlWFfjbZH1wujwOMgfNLIvze5cpYpyyhBHhXqIZS
	T
X-Gm-Gg: ASbGncsnCN8OjxJd/QlSHvm0ZVcqYzav6NIdyLOmD61FP9zCATEvKHcBYakorf1y0FX
	CRuJUlVri0EHlhxs8iJM31D2wdTy7yGtIuiFKz7Wv9ullEadHTFD9zgt9krW3XRsau3joOh2S54
	7zNdlZeLLXz+laoH8BDgj2ZtvQXMMGit8xIbNz9tPX1F3diRtuqxK6RnYJBUOuZOkN17H86uhdq
	yZCJzjOLdBauopTqvwPZd0oFWzeZzsQJuQEtODfgUiQ8vzkPUJKf0xkO/ulYvCtS3XYfaK5WdD4
	BAL35P0Z/GV/U60u1zvxHsjxkJrEeqg=
X-Google-Smtp-Source: AGHT+IGWQ6Ea/hya66y48VSHflrqIGI6YnsBwXSrI5ppeQDFsXbRnz9SXM1F2dK4IQhptqcpYoEGrA==
X-Received: by 2002:a05:6402:3483:b0:5dc:740b:3cd9 with SMTP id 4fb4d7f45d1cf-5deadde0a01mr1628644a12.5.1739391583427;
        Wed, 12 Feb 2025 12:19:43 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 0/3] iommu: omap: Simplify few things
Date: Wed, 12 Feb 2025 21:19:32 +0100
Message-Id: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQCrWcC/42NsQ6CQBBEf4Vs7Rru8MBYWUhroaWhOGGFTeCO3
 CqREP7dC19gOfMybxYQCkwCp2SBQBMLexeD2iVQd9a1hNzEDDrVJlVKocxSe4djhE1PaEMryH4
 YPqjJqlw/tc7sAeJ+DPTi7+Z+wK28l9cLVLHvWN4+zNvlpDb6h31SmGJW5EVDZI7G5ueenQ1+7
 0ML1bquP1boxErLAAAA
X-Change-ID: 20250111-syscon-phandle-args-iommu-2ea162b223a4
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=762;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4Z0JQhN6fp9gquUDGJ84tUXaVmHYEEGbPTsb0CbEDQc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJZOXGqBuHcgsU8HSbp2xo3yFRm/Ms+c8j5O
 ExsuSuqtKGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CWQAKCRDBN2bmhouD
 1169EACSYDTLDH1DQKpYn2cATzfRIpbpcY5CzEC7W7IUY+ucB1/RIMc8lh8gGurqPkv8xHzhNSi
 Q6Sh3s/OOaHYyvXACeEZCADKjzyIAurionrjkAffeJWeRLAM0houZ/7UR3hWEy5FrLAppZDsgZT
 lN95xHKhBKwKRZOGE2OLljHhzj1MHs9urL1fr6vD5eivwuyn9Ule6KZ3TE27Oz2qugZayk9aAq/
 etS/IES+qFzgYthOGlL214ARm5RDABk94coQNtTAoDgs3tLPX9dlc62ewHv/6X1oOUSrWu4TmRj
 Dd1nCnNw/DOg6xAmGMRWoWNZ9htgcLzTgalNvIJNyyl3AMLR/QKsxK2l6IogpbbCFPGceCmstjn
 Y7ffxhq71utCdOclpJFH3r7k7AXFcpqinYTWkMXve5b1yaWeopMx/re20tL+JY0xuvpDg8bffya
 bOiwVJVPM0BJLe+Ri51C6wowd1Q9CU2WxNP8Vw0B1ubEylawqluyI8j586PatEmpKAt2C2OJjTX
 GHYzN1g+JdMmvNFTqJKIi9nwFmAjycWkJOkQ9cALy4JeYpGv7kBswsFNUyi5TzoQ7uPfW6jS+EH
 UV6Q7Z6uvaW1G2eR6H+hjnpb29QYjvOZ/TV5JLlpN0bNOLh+FUw9IPxSpgRQR3LF0Y/q9vWuj+3
 WOZBCG7GZSWGNXA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Resending after 1 month.

Link to v1: https://lore.kernel.org/r/20250111-syscon-phandle-args-iommu-v1-0-3767dee585a6@linaro.org

Few code simplifications without functional impact.  Not tested on
hardware.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      iommu: omap: Drop redundant check if ti,syscon-mmuconfig exists
      iommu: omap: Simplify returning syscon PTR_ERR
      iommu: omap: Use syscon_regmap_lookup_by_phandle_args

 drivers/iommu/omap-iommu.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)
---
base-commit: c674aa7c289e51659e40dda0f954886ef7f80042
change-id: 20250111-syscon-phandle-args-iommu-2ea162b223a4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



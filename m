Return-Path: <linux-kernel+bounces-545390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6EA4EC57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6480B1654CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53741F4E3B;
	Tue,  4 Mar 2025 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIPEEtSv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C718CBE1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113946; cv=none; b=cp1UgXqOYKfREkgN+xX2ptx4NjX/WHilTFG1tK4QJESpswQlvJxJ/GniP2xN5+P5oUMnvLQAokgMnwaRxOQqlK6byJfDGa9mw5NdGx4WU7o0pBQNO8p7nwjp1IilLsXtXjXxu2dgTR5oeLqCzt3lEQi6aGc9Sw38q9pjhHplWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113946; c=relaxed/simple;
	bh=XDngEG8wtWQvhvF3YrSeK4X7ZGTxQunF/E8GOiLPgSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UwXZwsimZuipwK8pGCmS3Iq7BlCERXPcRGoJmwJmg/kAu5IVjoHWIzEfuOCIe6qy2G6jd9ZtI4FWLmgtEI4Fn7Ll8N1BeBNh2oGBPLD1+spc97IvjXC9KnRmTtk6Dw9Q0at6bfHbNHkJFs3DUxqmO7FZfbDYdXu85GPOdw6ciPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OIPEEtSv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bba52bc1fso2716815e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741113941; x=1741718741; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dV66bSO3p7CPdI7VDIr32ThJ93exQDdyBO//zJP39OQ=;
        b=OIPEEtSvjEQKYEN6lP+MhnXchB3yuqvbxZuw+yyV4qZjZ6xywmlYzIWfEhreHir16N
         ZlkN8zhxQ2HYkr6GklDcABX1KSsyQZ6BcmePPSpLXrZKNIeG4m8Q0GETpaQ9Mg+ZYdYU
         kHF0KF0f1E5jWgMtaXFPA1ebyVwRXgFd0yD+w7aU+OLN/r4n/m0Q/eGHABqfnw+6zEwL
         AaodSbg513/2rY2e/Rin9VNA50P5kOClNpkP5i14cpF7wzfzICKb24nFTeuY/jCOOqPh
         YyeT8lZrWpUPF7fmJSY9Z/Egz7L1Xd3hdJXrbRyrYm7bqW7SLOXE2548DLBLDCeSrNuB
         /9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113941; x=1741718741;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dV66bSO3p7CPdI7VDIr32ThJ93exQDdyBO//zJP39OQ=;
        b=f3NlnjLrjJu/vAUkV05ZpO5cUjIjoUlxxOXfl4oUo3K7wbygrV/uvnlflqgYPrAcqB
         7lABvOeyb9YQuZSRCZCTE3Itx9Rn6Kyn6iytNjfjz/TViyck8chnEUw4wJEWRks/EmUZ
         AkO50iOO9ho6WoVeTydSy2JqaYU72ButdYd0u5Q5P/JknY8H7LdKntXpMVZN4AGAE9kG
         zmu2LVhekQsXZ3l7cw+YwfIKNBDAhzobkthremRHWVLJ87KL+oPIoRRxfWOIrB2hVtEs
         0EHf926QOfcCkEPgy8Oj6agaUNOC+hAB00QSAhYeVtx5iF/5e7cXTit5Ivx6HfChf+pk
         YUGA==
X-Forwarded-Encrypted: i=1; AJvYcCUYg3jYFAozuHoP9IsEqALTz2PLS+Mw2st3M+zzSJgUbXAF2RjSaSVbMscwaLx3Efr35o1kDpcefAv0p8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmy7d9BpeS0/uAYEAbG72cZl7mgb0iuJxPq0dQdju1sYfz8ol
	TuqFwjr9+Z/GtT5FGGyDM2s8oTihnGZ2hC+30KarPdfR+sQmiHqmXW44GvPm+0s=
X-Gm-Gg: ASbGncs67ncHotL/pI5eS83S8yyf25UrVJ+0245nG3IL7d9B/5npGRLmH0h2ogRbI/T
	e4B7K06R7+VEwff6CucaxyBIAdHzKlB3+cyoRmL5DCVFEh58imljm13KqghQVnLfdjBC0UQEJrY
	mpoBgfDzy++AGepXc4D/mEmzw63/buSqNLbAFHiDh4jF+Bru96d3zrUtG2EccIJ6U762idKXtlh
	NLtTr0hvh2JI1Kewz19XMPjEl64gtc2uWPftyFCcF5N9eVkyK3Z8KccIihXfX7LbsPUW8Cdgfea
	f7x1xso6bO2M1iozOu9SNagmTcXGfn7SrOKBWLZobJ/fEuZzb9DHJl/9brO5
X-Google-Smtp-Source: AGHT+IHswIEyCJXZp7woYZZuJpnAXAHgU63OvcCGWQJRtFTY7jo4WjlXR0PIT3yu2UR8Js69fWovDA==
X-Received: by 2002:a5d:5850:0:b0:38d:e0ee:bb8 with SMTP id ffacd0b85a97d-3911641410amr1370787f8f.11.1741113941249;
        Tue, 04 Mar 2025 10:45:41 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ceesm18229985f8f.45.2025.03.04.10.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 10:45:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/2] clk: samsung: Two header cleanups
Date: Tue, 04 Mar 2025 19:45:30 +0100
Message-Id: <20250304-clk-samsung-headers-cleanup-v1-0-81718e38246e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEpKx2cC/x2MywqDQAwAf0VybiD1TX+leFh3owbtVjYogvjvB
 o8zDHOCchJW+GQnJN5F5R8N3q8M/OTiyCjBGHLKKyqoRL/MqO6nWxxxYhc4qTl2cVvRU9O3IVh
 YE9hhTTzI8dy/3XXdYx3eU20AAAA=
X-Change-ID: 20250304-clk-samsung-headers-cleanup-c07b8dd50360
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XDngEG8wtWQvhvF3YrSeK4X7ZGTxQunF/E8GOiLPgSs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnx0pN00BqtKjo8GLAIBcX4Q9OtViT91hhZMDba
 VZfjobaseqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ8dKTQAKCRDBN2bmhouD
 14bHD/9SLqOUAS4O36jLepNIa7itVCkJE3SddDL/7+JXCH/HT/7ForYiv2Pw5ZCaP5FQHVs8rXv
 j8Wrrkh8F7rt6Io4KRK18qE84K4JC8GwEUCvG+TmryeajaUS6vg8ElbZ6zAHXeLIneWknMH6JRO
 xtciD4Om3JIXD0eWluwV7ZAbi4DYV9jhxZcY5YwXmJI+a+VLCbDSkhaJzKl/fwZO89r9FqXgpQb
 iJyp2P+UW+Wb1PyC8ZAJw/3a7V63Icadc/mzUKTiAQEqrHcPtnu2B8jwacPdrlo6bMuvT395Dq1
 odV6qdKw7WxIe5WFczs6dPRsn9HIOqMU2xKT4w9nkCBzBfTbR1Qqezp+DwcrYRTiNFUAaJeVF3h
 FwZ56GXbkyA+VtPJ+TqrLqVesOupSNLGsA9iNdxC1DI87ppon7f2/dIWNczjUhPAfsEdTCXe+j+
 GL9QRA+3ZvVi55tIjq95uk4ewxdWdALQ2L/n/7dLD1TnhazHewO1d/vOyJa3Pywp5HqBwDSKR7I
 8Kavj9bnXIyPuZUfXzn+yhFILJkyzY69PoYcXnCKIbD2WYWgMRuxKjU+o2AU/o80c4IUc2JGS/j
 Fke330DMu7cmYQ5rJV5yKYEXJhEZnVByMY16vLOw1jYACHQ62ZLsWqcXe9gH7H4iScZtUhzU4dC
 7Rdfp5W1qrpPmWA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just two cleanups, no dependencies.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      clk: samsung: Add missing mod_devicetable.h header
      clk: samsung: Drop unused clk.h and of.h headers

 drivers/clk/samsung/clk-exynos-audss.c   | 1 +
 drivers/clk/samsung/clk-exynos-clkout.c  | 1 +
 drivers/clk/samsung/clk-exynos3250.c     | 4 +---
 drivers/clk/samsung/clk-exynos4.c        | 1 -
 drivers/clk/samsung/clk-exynos4412-isp.c | 2 +-
 drivers/clk/samsung/clk-exynos5250.c     | 1 +
 drivers/clk/samsung/clk-exynos5260.c     | 3 ---
 drivers/clk/samsung/clk-exynos5410.c     | 2 --
 drivers/clk/samsung/clk-exynos5420.c     | 1 +
 drivers/clk/samsung/clk-exynos5433.c     | 4 +---
 drivers/clk/samsung/clk-exynos7.c        | 1 -
 drivers/clk/samsung/clk-exynos7885.c     | 2 +-
 drivers/clk/samsung/clk-exynos850.c      | 2 +-
 drivers/clk/samsung/clk-exynos8895.c     | 2 +-
 drivers/clk/samsung/clk-exynos990.c      | 2 +-
 drivers/clk/samsung/clk-exynosautov9.c   | 2 +-
 drivers/clk/samsung/clk-exynosautov920.c | 2 +-
 drivers/clk/samsung/clk-fsd.c            | 2 +-
 drivers/clk/samsung/clk-gs101.c          | 2 +-
 drivers/clk/samsung/clk-s3c64xx.c        | 1 -
 drivers/clk/samsung/clk-s5pv210-audss.c  | 1 +
 drivers/clk/samsung/clk-s5pv210.c        | 1 -
 drivers/clk/samsung/clk.c                | 1 -
 23 files changed, 16 insertions(+), 25 deletions(-)
---
base-commit: c0eb65494e59d9834af7cbad983629e9017b25a1
change-id: 20250304-clk-samsung-headers-cleanup-c07b8dd50360

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



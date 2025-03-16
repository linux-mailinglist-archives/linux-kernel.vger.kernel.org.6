Return-Path: <linux-kernel+bounces-563044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA7FA6361F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D3916F5A5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AC41ACEBB;
	Sun, 16 Mar 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o5f/EQsC"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883741A08B8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742136148; cv=none; b=EGOXj9ctCAffQSJi/7H2dlNbQXSpLQrxIf32SG8aU94fp+Zzhani9tziwwHYtaMRMAzarJ1wOrjmhP26/m08p3Roxm1Y15+KXXVmxG+ZAMzqOp0z1QRxg9uRBHb+rafYfkB9dHWpj4sA07ervvyR34xqsvwAkNt7dE5Jg4nf+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742136148; c=relaxed/simple;
	bh=hAwIMSzK0uCAG8yRC35L5MzxIb1ccJ6Q76LufHUuaYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOY72nCzAzFazaWimzR+rojvm3DWSZv2Yk3mQugi3JsU9aZnZzF+DL6W0XwpjQOSJ/ygb56FFGuYzL2IvMUOt7RpPUA4dZ8Feg4ABcr+o7yHwXTg+jBblPAKXDI4xSNAaDYTRmfybpOp8W4eLCsdTfsXCh3fbBuWkHgqojx6h60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o5f/EQsC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so436900f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742136145; x=1742740945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJriuSV/8IJe5ycqkpE6UDdCuNRLNCnL4O9Y8I+CLA4=;
        b=o5f/EQsCZuXcg2UKvx5lg+oPQymIxEVmp7m/tHABF2UzG5OW/Y6+K8YSMlduQL7mKE
         nWrykhyzkQ11j0xw8IqNQHXvLXK5qYTUwsTsz6Ia15qwbo3qXGn6z4h1vOZeQlYfGVtq
         qREmEUy33oeUW4IjAmHoOt1npnEwlihXM0YE+b1PtrNq0oGplkCTlgBhDr4uM19CHkVZ
         WX8WsHu1kUnTlayxXymxIC7WXCIPuudRuVOLSSP3a25rE7M91DIJ3lj1IYoRPun2No3d
         zZAHzeD/9lojSXGfUU3O4OHZVassLvrHHNy+xsVtiDstrtVFbg851kou6Chm5RjaC7tF
         zaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742136145; x=1742740945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJriuSV/8IJe5ycqkpE6UDdCuNRLNCnL4O9Y8I+CLA4=;
        b=K3o7NaniUAUm8x896TDkc6BiRDX+dsXypfIcVzDXHFq3A8zDiSHTaC7Yc34KrRMhXm
         +vhjhadt+X3CYosc5Hbh21xn8S1afnovj97dfxxbyZO53D+xpeA7WJFwrK7IxPLZL25B
         46zr2X0moX9zTMjUbeN9SLKpJfT/aMRhIVYcU2iAIY1gDNHUJh8PvOccU2w66RndTps4
         3dvp3GxJsxAkMpBAL9JlCJD16WwpSiml+i6XHMyyOZQw0BYxlMNu6J924Iv8Lnx6Fe9f
         Lyb2GvcAHyqww6hrd4CVAMHaiaodvqLNaurOYmSwOkDeHpilgxHXFvYtuGUDkWvtdWJE
         nIHg==
X-Forwarded-Encrypted: i=1; AJvYcCUkF570saZ7F5LTq6XwzBTxPmwbeGZU9rwjnHjo2cN6wjoNqQOjIS+QF+4Z1Glzbm518wGgcJlqOJyN5HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx8oxLG6oKIdvADqRkLMUKsAu+G3ZWRDHlsqq9vgBD4VFDJJDt
	yiL2kpItnVopIp9UrGiQT/w8AhqIdtnraijlUsfMtGXv84sI8PJX2uztGba8W32VfaH1e9PpPyG
	z
X-Gm-Gg: ASbGncu9gwBHu+mFZiqltBZY6oNAJaZLpwxpdkTqAkVThuggxw+qQ4uHEzzHjiU316x
	bImn8ixCKv85tsQBSyI/xaaRvp3Qh3AlqFHmSlJsZCjLTqOzbpybUZmiM+XvJA4Pz01N45p/L49
	eXWqAeSKllwaPY/yDdpwCq4zEunn+AhDhz51YijqhcDv+H4hw0KDN3w3je21m3GF9+DzIE2ghY1
	Kev2ipBAZw3W0t7LTeurF0hQI2aj0ZNHWsUjpqw7tdmTAcYWpb4a8T/UwOB4J7+Al/YUL6DQ4lD
	5s3+tnAJdCASaJGUNJpqdcpSDdx0vCgwVfFq+lBcmuP9JtFIoWMD1MMyQ6iy679jKA2+
X-Google-Smtp-Source: AGHT+IFN+HWoJ/RvheSs9Qe6ufnnQM/Id6b6C6RXmbLnvuIy+0v8jxxH3K/QTk+P9kPHsJxT6hIFLw==
X-Received: by 2002:a05:600c:4e8e:b0:439:9c0e:36e6 with SMTP id 5b1f17b1804b1-43d1ecca06cmr40418265e9.3.1742136144846;
        Sun, 16 Mar 2025 07:42:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62d7sm79591825e9.6.2025.03.16.07.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 07:42:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] dts: cleanups for v6.15
Date: Sun, 16 Mar 2025 15:42:20 +0100
Message-ID: <20250316144221.18240-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

One ARM and one Loongson cleanup. I gave half a year for Loongson to explain
the spidev, but no responses were posted, so I just applied the patch:
https://lore.kernel.org/all/20240717-preacher-sandal-2aeffa322b9f@spud/

Best regards,
Krzysztof


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-cleanup-6.15

for you to fetch changes up to 854a080f0b73ff966a813ec2dc53891831daa28d:

  loongarch: dts: remove non-existent DAC from 2k1000-ref (2025-02-12 21:48:51 +0100)

----------------------------------------------------------------
Minor improvements inDTS for v6.15

1. ARM Cirrus EP7211: Align GPIO node name to match what bindings
   expect.

2. Loongson 2K1000: Drop incorrect spidev description, by pretending to
   have there something else.  This will have impact on the users of
   DTS, because spidev will stop working, however no counter-proposals
   of fixing this or even explaining this were proposed for half a year
   after the patch was posted.  Therefore drop incorrect hardware
   description, hoping affected users will come if proper one, if needed.

----------------------------------------------------------------
Conor Dooley (1):
      loongarch: dts: remove non-existent DAC from 2k1000-ref

Krzysztof Kozlowski (1):
      ARM: dts: cirrus: ep7211: Align GPIO hog name with bindings

 arch/arm/boot/dts/cirrus/ep7211-edb7211.dts     | 2 +-
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)


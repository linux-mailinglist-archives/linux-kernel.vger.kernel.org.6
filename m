Return-Path: <linux-kernel+bounces-575052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 107F6A6ECE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382BB7A1C33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBC1DE4C2;
	Tue, 25 Mar 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z4rZA/qg"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680802E3399
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895973; cv=none; b=HE54MHands8AQrdvFs8Cjva5rONG4mgd+I3+16ym+PoeA6MuVv/5068SxArfbQhqaN8G4F7eEhqM0SdQS2JwKtXAwyW0P9FMMHiqsvvhRPZRBaZXk6HHXmkoNc2GdDD/GWyN9u0Kjca5WuiSOUGpWscZ1OiRmOCuYmg8kQE0G/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895973; c=relaxed/simple;
	bh=KxaPfmUvSFnV3Byq3QqC+CSZjErbzsYdDMoKikjwIGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X5dkceO0JPjSti1h58ruFFJUlg7bgZdCzkSXfeg2P1D2JhECbywp+tYjGEptSxWXtovxJ7bCGItO5tRKQRa91C7sC2mvOFxlOWUcnqHTl6Z/urR2UkyJ/HJrqo1WAcjJ4EBtlFAnyuPIjL3pIEmsmUOOPihC4qoVLPwMomQUFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z4rZA/qg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso9798962a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742895970; x=1743500770; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbefRUQKW2oql/88hpKv3fFad6yESLUR8BZTv5IsOP0=;
        b=z4rZA/qgUpvD2iU+efBlQ7bWMsQvXwDh2o5un+PKtQvZc8aTSsof0v2flPdwM724+O
         2JA7X8MZaBslhCKvsowbHJzXSkkRcKeM6JjTPIlKh5HPyxq1JQIpPrj12zyB1Lz4XOhV
         Wd1dFbxrDhFVMssT//qUw1XUL4jPLSjk+SL+eLNEs+Apnw0lDV8WwsXYnhg57zo/mrkI
         VUk+jAriuRX9YXG/VUez/t+mw19/G6ZPKbqPlVLHJHv2Q6TfbP/FoWriLVQno7QkpC+j
         9m+dkmX1WOwoi5//KqdxlBrv2lpZ+NU4AEOeCSVI3jZYpT0cAKR61MT+IV2Ji2ap5YFa
         p9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742895970; x=1743500770;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbefRUQKW2oql/88hpKv3fFad6yESLUR8BZTv5IsOP0=;
        b=g9z/Lby8q8LhCCiYTtcOW1l0WioWoGz5IxDJcXqHxLPow+AQULXLrzlgQ6bovNSUsa
         Va0h+i8vgLq50wEC2CVc33N61ye+Q5a2z+PbLPAOt0bBG5FzKwhuObhkebHzlSIT6jNU
         04up8esf7mav0vQcb11YR150io1VrRCZc/y/iQf8gTodOCbpXWtThRnGXVQLCrp/upxO
         +JYLFIXvuUveIKqBYleYAxgBffG5i8TfWS62X7VGVJ0U6EwaRBLzyrwlkAoYOxy9rb2M
         e7xXEmWxhoRRcKa/jn4g2CIdMjdd6roH1hKnikeXWvLgavuU2KKBlXMD7EB68JKUNjQ+
         bB/A==
X-Forwarded-Encrypted: i=1; AJvYcCU9pp0piIjWRYaAk3GJL+ySIHlopNOnhDfPHoZrpz1RmJ8nUEvZNLIiWsNJ4awtyuvcMzxlOL9NgyZsRp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUp7A64JyQZMSk1A4q57aun5GDykr8OiS0ofjj4/00rE+6Cjsx
	MT+eCsNsqh/XjBHhZH9gY+sJ7nCcgBGW6L1+Y9ls7BRyTfhcEITrtORKelQ25LpuQO61YBraWqj
	E1WI=
X-Gm-Gg: ASbGnctQe++rAP6NSn7bsLnAm/ugoGUlDAllyP1t/DNyVfd5ndAR43atcQepU/QL1Wb
	UIXiQc+1hvQvGFkav7bv0llEgzdmq+hX7cLLx6eOOG/rppEzk64ZKAsKkSZF81kzQdcM86qX5FR
	68Ymjps4IILotT7UC9gnlJ19s0fbu8cgoqmoMRXH5Yqj4L/bQA8FmyjsXrJRRYC6WrrA4u5xRn0
	j677rz7kIf/GZ2+zYGJbW/1cmd+9RWwe4L1kJ2I+WOq2xYEvT9tFuwOLi0aMkGPgviNwGAL4ZJJ
	5zaTO3hVsylWKrH/eCK9G4+3Ti/fOWX1ao3zdrLrZ4PVbLvHCHPbPieU/KV1kUV55vaHAY+Yiia
	u/nLp2AzsArEcWGXiLQGOMBH3tDKQ
X-Google-Smtp-Source: AGHT+IFYMNqZbEEZU24hSgKcW3m5RLIViDlNIgnffwEY/e9N3Ve3Ev3qTdJRHo9n8Lr2y8eJMqGUHg==
X-Received: by 2002:a17:907:972a:b0:ac3:cff:80f1 with SMTP id a640c23a62f3a-ac3f258cee9mr1765840966b.54.1742895969537;
        Tue, 25 Mar 2025 02:46:09 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e509dsm832834566b.68.2025.03.25.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:46:09 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v3 0/2] firmware: exynos-acpm: allow use during system
 shutdown
Date: Tue, 25 Mar 2025 09:46:06 +0000
Message-Id: <20250325-acpm-atomic-v3-0-c66aae7df925@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF574mcC/23MSwqDMBSF4a1Ixk3Jw3ilo+6jdBDjVS9UI4mEF
 nHvjY4qdHgOfP/KIgbCyG7FygImiuSnPPSlYG6wU4+c2ryZEsoIrSS3bh65XfxIjgutAUwjjMS
 OZTEH7Oh91B7PvAeKiw+fI57k/v7vJMkF75q6hqZFwEreXzTZ4K8+9GwPJfWLyzNWGUNbA5QVS
 qjMCW/b9gWJkyPp5AAAAA==
X-Change-ID: 20250321-acpm-atomic-033775b051ef
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

One user of this ACPM driver is a PMIC driver that needs to communicate
with the PMIC during late system shutdown [1] and at that time we are
not allowed to sleep anymore.

This series address this by switching the code to using udelay() in the
specific case of system shutdown. This approach was inspired by I2C's
i2c_in_atomic_xfer_mode(), which has to deal with a similar corner
case.

Link: https://lore.kernel.org/all/20250323-s2mpg10-v1-29-d08943702707@linaro.org/ [1]

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v3:
- switch to unconditional udelay() (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20250324-acpm-atomic-v2-0-7d87746e1765@linaro.org

Changes in v2:
- add missing ktime.h include
- switch to ktime_before() instead of !ktime_after()
- add link to user requiring this change to cover letter
- collect Tudor's Rb
- Link to v1: https://lore.kernel.org/r/20250321-acpm-atomic-v1-0-fb887bde7e61@linaro.org

---
André Draszik (2):
      firmware: exynos-acpm: use ktime APIs for timeout detection
      firmware: exynos-acpm: allow use during system shutdown

 drivers/firmware/samsung/exynos-acpm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250321-acpm-atomic-033775b051ef

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>



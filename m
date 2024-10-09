Return-Path: <linux-kernel+bounces-357931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ED39977F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9221F22D7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F811E2836;
	Wed,  9 Oct 2024 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BluAuM5s"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71AF16BE3A;
	Wed,  9 Oct 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511007; cv=none; b=fEvp0MQy3D5qnCJP4cbFWbxH2EIUZJYursMLhJCK2z8aHIuDu4RnOACbwCAnerlHolHQMBxBQ/7gOpyIJwQ9G+pFPQEVU1o6bOaABtuKF7IhG3gtFxfveFmy13OF2gHwM3gqlIFSwhwhUfKhWfbAWMsYXcOhBd7rgMw3N4ZA1VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511007; c=relaxed/simple;
	bh=b5mhwgPGC56jQ2dsa1l1tlL4g2k1Q8atpALjh2UsDwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MX+qfwejypzjFz2nn55g3B43Gaw5iGKzgEbZm5Tb87p+El5x2E0d6HSXWlP82VyZjLFMYAKh8855gnt0gWVHqbyEdJeRsvbpPzHKdjzIBvgkhh6NQRT46uLpQGAZENXDJyZbzsarwy+LWYTxAxd4Jqmp/eC5QaZX0Hao3HWidEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BluAuM5s; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso174480a12.3;
        Wed, 09 Oct 2024 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728511004; x=1729115804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K8mRHP1iHo4icZwmG9+ljTCxE1/nJeCh2StmxML6Ayo=;
        b=BluAuM5sJezs0SS5Yv1EQJvdRS0Hm6FtTodUnKeZViZ9gKRch/sohJcsYjlnH4U4+4
         z8lbnLMM7DIuV3vc2zQN8EUglu0967E4JQOUzlo30n0VQe5WbnBVk/iOqh01ARF8F919
         WzIZZ/nD3EhcrHwuB5knzUwknsJWWQGpOZ/C1I3xntncgs8ZQI8Mn8LWxamJhdKnup0S
         U4BicV+vYlXLOPygxyL2sAhybsgIYrIzd8ogdu3gX/Oh1Jczavm+dQtIp0ygmNE93cFo
         ZXedpI/QBL8OLJhz/TzyFwCyWW1WeSgU6F8Chr2V4NqqoDIxI+uEhuM+4CpXqNK+DTVz
         y5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728511004; x=1729115804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8mRHP1iHo4icZwmG9+ljTCxE1/nJeCh2StmxML6Ayo=;
        b=NFgjHCzrTxSaCTh5fDRzrJjB7Q+mZOlR8CzSLw7pL9GDH9lhGMcd38mqo3kMwBeaHr
         wKsF+KLnjuhgsJuTFbIaMRSKF5lfm4xIWWhJ+YSNcFXmySfBwz434Pgd6O1W1a9hXIDq
         la97hCxdtfv5bh6U/Ild+XfGhDfvcyP3zPgXYv08q2wxKMJsmP0AqXh+NOxyUFFyQieR
         0u1nK17yyk8Alc0qhzoZZyNDzj9+o7eZoKvaFilG8EQ2DXaFMXcwuYuhxbM2GWzj3akM
         o/fCLY4WSLq6/DiRr2BQPmb8q/lmDV86pSUM0gHFObUNJwB3IVkUxt5fceNXlPlKfCJf
         +g5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8Dh+08AhBDyhovysLiN/iItpitkSdAIMQjnPzF5h3SeOuLoRpnCbE2tlBpdU+E3Z1U3MswlgrMwoJArK4@vger.kernel.org, AJvYcCX6ET/BYYmidhCWEFIz6aMbOBUNZahty7vq3XWxxHmaWV6cYnc0f9+31D+qCWgEbAHI7AL49Jd3KIzc@vger.kernel.org
X-Gm-Message-State: AOJu0YxSq6k13UUwfUrJraDuTSXi2FZs6JjnjTX0SPX9k4Kkh3qcnhl1
	ogzdtUugSJwUWfFtXxnDEosRyhJ/uoyvahpEogFa88EIP8jkcMaS
X-Google-Smtp-Source: AGHT+IF/rCzFhDfS0zvlOCvu7wIjXmk/xlgUGFHWlO0RMIupuLNkSOr/R9rBXc/FAWwxvbujsp8jug==
X-Received: by 2002:a05:6a21:6b0a:b0:1cf:359b:1a3e with SMTP id adf61e73a8af0-1d8ad83cd67mr2270218637.32.1728511004017;
        Wed, 09 Oct 2024 14:56:44 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833ce7sm7726646a12.48.2024.10.09.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:56:43 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 0/2] Add support for Zyxel EX3510-B
Date: Wed,  9 Oct 2024 14:54:52 -0700
Message-ID: <20241009215454.1449508-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello BCMBCA maintainers,

This is a second, very minor revision of my previous series for introducing
support for the Zyxel EX3510-B "series," largely motivated by my earlier
patchset [1] that resolves validation errors in the BCMBCA DTs. If checking the
DT, please apply that other patchset first. These changes do not depend on the
other patchset to build correctly or apply cleanly; only to pass validation.

Happy spooky month,
Sam

[1]: https://lore.kernel.org/linux-devicetree/20241009215046.1449389-1-CFSworks@gmail.com/T/

Changes v1->v2:
- Rolled-in commit tags from previous version
- Stylistic change to memory: s/0/0x0
- Delete `range` property from the `nvmem-cells` node, in order to pass DT
  checks.

COMMITTER NOTE: Email being what it is, the capitalization of my email address
is apparently getting discarded. If it is important that the author email
address have identical capitalization to the Signed-off-by, please explain why
so I can investigate why this is happening and/or get these patches to you in a
desired format.

Sam Edwards (2):
  dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
  arm64: dts: broadcom: bcmbca: bcm4908: Add DT for Zyxel EX3510-B

 .../bindings/arm/bcm/brcm,bcmbca.yaml         |   1 +
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   1 +
 .../broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts | 196 ++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts

-- 
2.44.2



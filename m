Return-Path: <linux-kernel+bounces-183185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D7B8C95B3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C07B2821F9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6792051C49;
	Sun, 19 May 2024 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeU4h8OM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDC1F5FD;
	Sun, 19 May 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141574; cv=none; b=WH3PQeiAkWUXnKtQ8eaawPoZHJ6MEUrT9/uoJS5EVRrtDfAbhe8F63BTljFumArxZxCmgVe5A6GXVB1eNiNsExJaKx7CEyC6tMojtmNqm6AVSSyvOhovyUBLjOOBFp52T5o1wEFa8yB0zyEpHPmRW858KkuKt6FzqG+EdRVeBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141574; c=relaxed/simple;
	bh=4KGqkeTTjfQZEJKdmBVvXLgPXJWMhi8WIYe3xSadCxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dI/uByeDn7wIjleuPGfzgXqQRh4D2zUOrQS+NetYAoH8zyrmICPyVp8c9FziHvBOss+DeWzy3L16fswUwJXDT+Nqg6LvIdvs8vpTLkhIk13zaRcjjtng5C8i0IXQYg2NTFLqY0FJun+fcZw9rPq7cN+S5Andg119QqZyJ4qqrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeU4h8OM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ed41eb3382so55418375ad.0;
        Sun, 19 May 2024 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716141573; x=1716746373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kG64scUmDV9RZX8aGJDebzvj5lW5EFJ8Ke+u/bGx9yo=;
        b=QeU4h8OM5yJu9qtCKYsYFdpE9Czw/M9ECo1Hl8JvGw6GhOGoi8yr1jEaYWmPdaXw3N
         Ug6hODVVNnxFf2OYR3TXC1td8Kvb9ItHEpn/1svVHfy1DCUCIuVYZ1vQhPL2s8HFdsi7
         3fMUfIqsOZCnrFBupeqEvxZ1qHFYKG1yjPfjhbfjPqGWn8NwyoMPoOSOmIdNGZjvbGkS
         9zfeypBiodTCJQNSoHg29kg0xPwwzYGbjovWHBaRrfbM9oJe2OMEOmlg06HpVSl9DUEC
         FfETODY2M5A7B07OGsTf019lnEFyK+u9M1kdPov0oBqmO167JqHJ0PSHfUB8OqtOT3a6
         z23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716141573; x=1716746373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kG64scUmDV9RZX8aGJDebzvj5lW5EFJ8Ke+u/bGx9yo=;
        b=wvB9xFQVT1q7TPSQZjMsRQVHQy1lrePjJo19it2Keav2eXjESWm71njAmrDbntw3a3
         GlwQsOWWy13KpvZaG/iZk1pnj953LhcN13qLId5ePg1/ZrTaDz/02e4AhYdszEcp6aSG
         Bo43X1WHQjyN+9hwildOWAhLhiuWTSdrxfO98qajOsM6f9Ezh2VMMc3WmiN6AhpCWloT
         SdfD2OY+bZj7J4DodO6F9m86bVRPP6TBmXzLcpZdC6JZuL7vwGN2ZykCBnRQg8ce87ys
         AhBY5fsMbXizfMdd1vYluwLEp/Sdz4YRrFswbVdS5Ayd1pt5c4aIyIvens/VbGQYziQ0
         BQvg==
X-Forwarded-Encrypted: i=1; AJvYcCUPsConh/4BUZC38SsA2fA9Rn5DVN9JGSI+q5jW5p3GLAbrb9a28oETPmRAewX1KyqzGOd/1BdASvJm8DVYGHLb432UcGhZqU1AkMAHmjCzYb6q2OWE/y328u5a1kmobn6QSvoc56Eajg==
X-Gm-Message-State: AOJu0YzxCG2QmWRYnTE+V1B5gvmjzhPYCRPhBN3aECUXBx8Nsj+i2HqO
	GFcDI6gAP5W7KtyfC8kcAQjds76yTpos6ZFS3m386lT+sCmLUe6j
X-Google-Smtp-Source: AGHT+IEczpamkxmCwrga/FiYTpqpvAegXACXG9PidXpxFjPexilJ65xg+Ps4Jh7kntQymBxlaL/ZIA==
X-Received: by 2002:a17:902:b414:b0:1e8:5cf9:37fc with SMTP id d9443c01a7336-1ef43e23f6bmr330376125ad.35.1716141572825;
        Sun, 19 May 2024 10:59:32 -0700 (PDT)
Received: from localhost.localdomain ([223.178.84.79])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f2fc5a015esm9424325ad.14.2024.05.19.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 10:59:32 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc:
Date: Sun, 19 May 2024 23:29:04 +0530
Message-Id: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches converts the RISC-V CPU interrupt controller to
the newer dt-schema binding.

Patch 1:
This patch is currently at v3 as it has been previously rolled out.
Contains the bindings for the interrupt controller.

Patch 2:
Contains the reference to the above interrupt controller. Thus, making
all the RISC-V interrupt controller bindings in a centralized place.

These patches are interdependent.

Kanak Shilledar (2):
  dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
  dt-bindings: riscv: cpus: add ref to interrupt-controller

 .../interrupt-controller/riscv,cpu-intc.txt   | 52 -------------
 .../interrupt-controller/riscv,cpu-intc.yaml  | 73 +++++++++++++++++++
 .../devicetree/bindings/riscv/cpus.yaml       | 22 +-----
 3 files changed, 74 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.yaml


base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
prerequisite-patch-id: 158157d32a32e765834a0cb4fc6335f9009d9962
prerequisite-patch-id: 4007c7386e66f93b67a2631dddca08cadcee708b
-- 
2.34.1



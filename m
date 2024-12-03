Return-Path: <linux-kernel+bounces-428741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C230B9E12C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD98B22FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D70616FF4E;
	Tue,  3 Dec 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxGk9VNG"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98907817;
	Tue,  3 Dec 2024 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202728; cv=none; b=pR8efjoglNzPiV5pt4KfpOSdNbryPKx6UaQGiQ63TW8Uv7uYxD6L5yxPwXouVod/7qVTFt0TGc52nvWXzE27j9fSLdYf0dQ4nKtBWkpqTURrezNhlw0y9Sl/GMkhEMwc3/b22r/3b7KDdst4k5EY97J3457ESBMEVgU+NT/OB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202728; c=relaxed/simple;
	bh=IMlmGBUwgtv1jPmaH3aQf2iXHx+4qQUPO8/WcIT0iPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2AU7z4TerDk83UqY82Dq24bEzthBu6mrsnMBJj4abVk8/2eXIEGXjCY/Mh2Cw87ZCwFutUF3JsnIA5sl9g9J3eeH5FhRrWCkdImvLLqRnmPDfgKTQQ0P8O81J4a/oqxGnG6kt+G022UVeWzZATTdf25tL1QyzqdGNWNrz6ahBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxGk9VNG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724e14b90cfso5076293b3a.2;
        Mon, 02 Dec 2024 21:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202726; x=1733807526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8n4o1v2RJyro7eTP9OXPaLkCulfPUB3irYVBi0m5MY=;
        b=OxGk9VNGbt7megh1oa3lfOsSRkD7OGkyjHmEsv0GI2xeo7WrSQo3F6MwGe3GsqX/af
         oIHGibmZwb8kXG2wUtcw4viBNwxJKK6ZdBedlseLPZ36F6XT4hqYdUTYkHqUk5XhCRz7
         QMCLepMlqNMD/MqABWPShhKgHqwmdONktB14DjDgSUgJrLbmrfYJGWXri6NNb13KwKLp
         CQgNFiUaKzsf9EwNk19M8OFg5ml3GiObltIIwQmlkMkrXLDcu1aZwr9+Q+hSe7xivY0s
         YUHXOVgWEKVLV0Q3h+5eTAGiq+k4JtDprdWbVjPxGIe0cHbA7AY5/sJfNc7wPVIUI3P8
         Ju5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202726; x=1733807526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8n4o1v2RJyro7eTP9OXPaLkCulfPUB3irYVBi0m5MY=;
        b=Y4ugoCEuLFVZ7M8pVeSUbGfsfOflQU1DPQdfNOVzXV4pn3Lh6Qb1v1CVEUEbT3Jwvg
         ywa36c/N1LLlTOD/rYDiOCdHy/p++uG0TGLwWSKdei/kasKN5kEvv0VFwzlTBlbVBkBl
         /x8n9DKPc6xL28fjC8dWwFmCchkFAeK+c18z5f18RxMpZ9ZdkNV2ugjRm29Y1uCZghJ6
         75uk8o09VtDWwjMjS9PZUpeIRlGjXw3BYG9Gc5j9Pm/9QIoDH5wbpfnsXBHygkBGRZWB
         0gKUrZOfSTuu7RnGvS/Rx1WHdLyOd5YJBj/e3x9AowJ6B4TuOzFfr6wkNTUQJsD5h25V
         gE6A==
X-Forwarded-Encrypted: i=1; AJvYcCX2BffzatM7qC3KbEhL07Tgmjdpt8TtfxdrvkQJqnJrUonbSQB36t4f0SJJIDBw4u2Ov7QdemAenSwD@vger.kernel.org, AJvYcCXhsWRxUKfzVkt/X9IwSg0ZqolKeDZbZbjKPvhdgS5WflZXblCHXB6Z7041PHcoZU+src/IvbZ37MP9u7zr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjx4waeEA2INguf6Ec362glfaNLfvPk2mdiWC0Qq0sYU7s4Yxj
	B0MrDI0ZkAiaDiWe+TSZUO9/tPR/wYqoyI7+RlRJez7MlPaOr16i
X-Gm-Gg: ASbGncux8nIhP9s1jtLPuG3LkZOHn+c2x9b77rmcFg7QWlvenlDyWgSJBcWo0FF3JZJ
	hzvPbLjA6cLHT2RkGv42QyKj+1p4vjkcNpyh8G6Ps8nsTbzSri9m9wRiCu9LmGaWCJS1ExrWzEP
	CvzfMqs7XlHzWh0U7iQbcbMo52gx/7qZqOjXFZRY0OaEhZtVQgOTcEBLCPf9RvKkdH9UkCZjK0J
	Y4/2NwXtZ4mBlMAB+usZ/6sm6OtTr/fxa2BIr9e6PVhWQseTG0+wEd9gw5km4GGpg==
X-Google-Smtp-Source: AGHT+IGnu83UebF01ikbueB6H+BqrayrW3tr1aPcP1nMIYcEm8aOI82S07uAdTSrZ6i9cAF+koyUfw==
X-Received: by 2002:a05:6a00:2d2a:b0:71e:6c67:2ebf with SMTP id d2e1a72fcca58-7257fa67cf3mr1425111b3a.11.1733202725908;
        Mon, 02 Dec 2024 21:12:05 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72541848916sm9525047b3a.172.2024.12.02.21.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 21:12:05 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aun-Ali Zaidi <admin@kodeit.net>,
	Paul Pawlowski <paul@mrarm.io>,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/3] Device Tree for Apple T2 (T8012) SoC devices
Date: Tue,  3 Dec 2024 13:10:26 +0800
Message-ID: <20241203051147.110980-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds device trees for the Apple T2 Security Chip found on
some Intel Macs released after 2017. This SoC is based on Apple A10
(T8010) SoC and, for many hardware blocks, can share the A10 compatibles.

This series requires the PMGR power domains series for A7-A11[1] for
the "apple,t8010-pmgr-pwrstate" and "apple,t8010-pmgr" compaibles,
but otherwise can be applied cleanly.

Changes since v1:
- Use imperative mood in commit messages

Link to v1: https://lore.kernel.org/asahi/20241201161942.36027-1-towinchenmi@gmail.com/T

[1]: https://lore.kernel.org/asahi/20241201155820.29259-1-towinchenmi@gmail.com/T

Nick Chan
---

Nick Chan (3):
  dt-bindings: arm: apple: Add T2 devices
  arm64: dts: apple: Add T2 devices
  arm64: dts: apple: t8012: Add PMGR nodes

 .../devicetree/bindings/arm/apple.yaml        |  41 +
 arch/arm64/boot/dts/apple/Makefile            |  16 +
 arch/arm64/boot/dts/apple/t8012-j132.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j137.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j140a.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j140k.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j152f.dts     |  15 +
 arch/arm64/boot/dts/apple/t8012-j160.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j174.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j185.dts      |  14 +
 arch/arm64/boot/dts/apple/t8012-j185f.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j213.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j214k.dts     |  15 +
 arch/arm64/boot/dts/apple/t8012-j215.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j223.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j230k.dts     |  14 +
 arch/arm64/boot/dts/apple/t8012-j680.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-j780.dts      |  15 +
 arch/arm64/boot/dts/apple/t8012-jxxx.dtsi     |  44 +
 arch/arm64/boot/dts/apple/t8012-pmgr.dtsi     | 837 ++++++++++++++++++
 arch/arm64/boot/dts/apple/t8012-touchbar.dtsi |  20 +
 arch/arm64/boot/dts/apple/t8012.dtsi          | 198 +++++
 22 files changed, 1387 insertions(+)
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j132.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j137.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j140a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j140k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j152f.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j160.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j174.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j185.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j185f.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j213.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j214k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j215.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j223.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j230k.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j680.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-j780.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8012-jxxx.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012-pmgr.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012-touchbar.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8012.dtsi


base-commit: bcdb59aa6d1f196ec853235957aba5852d6697cc
-- 
2.47.1



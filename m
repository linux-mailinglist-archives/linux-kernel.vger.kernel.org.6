Return-Path: <linux-kernel+bounces-512175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC68A33522
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBF167D56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A462B146013;
	Thu, 13 Feb 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRYDdrIC"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D335967;
	Thu, 13 Feb 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412553; cv=none; b=BGpF8cdfcBa300eYqc6pCecgtB/9DxEeL1DMrYuXf0GvkMVfDv4+WgkZZOvLA7S9agDtnl88kywAOWR4ul7djydPDG0E032xgt04m6IYayQpz4+b5Whil1oPbdnBG79rfV7D8MKJ2Qw8DfMTX8NKYGURlrUq8SW5TMZq7ussFWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412553; c=relaxed/simple;
	bh=r0linYsDVsAM0SiTnYEO5XVZWWBiYzYQ6MR5dJ/4NrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTxtInfQuihZbFQ6HdvwL72O4o6pej6k2bS8QbEN9k0kBNHEhf6+bb6gDL244OlcF9rbWr8qVCFijLwk+9HsaE/d3tJXh3/ut7r6qO9LAsJNMQD+qjph/Xjev+oQV5gSogjha9avyf9yeWY7KzvyTMrgrlPY8dAI4Jq1ACF1p5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRYDdrIC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be6fdeee35so71130985a.1;
        Wed, 12 Feb 2025 18:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739412550; x=1740017350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URu48V2H4PNPhJaMKw0EYRbAFViym7qaTk/OUPZaI/s=;
        b=KRYDdrICZ1S120uefEned3oaIisBwM1p+O2wXY9/1NTRzT0SS3KoIp2g0N3roQHBUk
         j+8AQwV2B35akRSe+5ZsIEEdE5XLwW+bwNaneJkRCYpwWcCdR6lgQE1LNjpj+XiIgIHy
         0ZRISvQLURIKCbVMp2Ih6Xw1Ud9p1YJBPb0M0gyB1LDNz+yG5D8N0zre2za3ZiFvUZbC
         0aZkx5/PJRf97kV3ZDmyX0Wsc5uCTRgO9u1HE+7bbXtmcDnK/7Y3YxiAKBdO1fJL7yRn
         CU5QNmPPXDYHCrXZ4Yr96roGfd5digiEoms0iQHKyBnMY5kqxm/YtFWQacAtQGt2kcDX
         Dzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412550; x=1740017350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URu48V2H4PNPhJaMKw0EYRbAFViym7qaTk/OUPZaI/s=;
        b=itYd0EXaDZMivCXa4qbTuwr0edJYpfh4/UnoVx21QLc+SHdYZUzuP8/HmXE2btM0+l
         T3EHgYStyFhcvbToDPvQREOyTfj8Gdtwt6/TC0jHbzOfFK0GdIyj/ZaqNqUEEz7qJ1YB
         QxS/CUHU5fL6mQVjs3WKTvx0Fy93/ggArl77F/6B9ng4wGLkZSaYxhYeDrVtcwZipuhR
         ZZwpF+fVdWNMHe/1aD2c7mPTjzUEhShKjSyMG4/UvsEGe2P+HMmoKQ3gq+GIpxA9yyPD
         QtjalDcCe4JMynafYvaJt9ZDCIEdqjnEtbRtHv8a2oDjliT5AVhxt61dSDCFIZ3VK9yC
         lzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKfGEPntM9dh0wbuLQ4Xg8acCgDQ4PoPgJa07M9khtgbBOjZJyS4Tusx8p0ORhxHja4Pk2FJSKAZ2tm/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJnKTwEstPn+mmHkdbY9pWb79Cp85AvjHyc08yuwU3bPIHGERs
	fYDUmfWCCbgvRO91t34XAhHVG3/T/MRy5MKBlfdlSbDPBu/nno5C
X-Gm-Gg: ASbGnct9K2m/QMINWIkg4ShCGwnogOHs3UPMbyECbO2/GQFkwE8fhExz3xq8EzqimWe
	gUyW22rEnL2mlZVBlYQyXTyLe3IvZYUHQwlxQx7KBqJlwMh/wIJ6viMJ2w5KVzItXClmsPFylBx
	7ALMAj8Go0eHq9QC7tUqhpwFfPAYl6w4lstJ7bRvKdpoSsTj9upZXKoECg+P7OQ+x9af/XgwqNp
	Ezd8Y9zISd6gJt9seHQ9K11ZbpRrVhqUcOVjfv6ozahmmfYYP87Os57ctfbxJkSVts=
X-Google-Smtp-Source: AGHT+IH7YLtKs3/ajC+qpgE3wdkNhgU+qso0fMS2oyCZoq3c2WmsR86YSkwyQWYRtESSNpuvD15H9w==
X-Received: by 2002:a05:620a:45ab:b0:7c0:724a:c4dc with SMTP id af79cd13be357-7c07a1ed35fmr341178985a.48.1739412550545;
        Wed, 12 Feb 2025 18:09:10 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c07c5f35b2sm21730485a.11.2025.02.12.18.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 18:09:10 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/4] reset: introduct generic bit reset controller
Date: Thu, 13 Feb 2025 10:08:53 +0800
Message-ID: <20250213020900.745551-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many SoC have a simple reset controller with toggling bit to perform
assert/deassert. It is annoyed to add compatiable for each device when
coming a new SoC. It is necessary to introduct a generic device to
simplify these things.

Add a simple generic bit reset controller, and migrate the Sophgo
SG2042 reset controller as an example.

Inochi Amaoto (4):
  dt-bindings: reset: add generic bit reset controller
  reset: simple: add support generic reset-simple device
  dt-bindings: reset: simple: migrate sophgo sg2042 reset controller
  riscv: dts: sg2042: Adapt reset generator for new binding

 .../bindings/reset/reset-simple.yaml          | 46 +++++++++++++++++++
 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 --------------
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  2 +-
 drivers/reset/reset-simple.c                  |  3 ++
 4 files changed, 50 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/reset-simple.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml

--
2.48.1



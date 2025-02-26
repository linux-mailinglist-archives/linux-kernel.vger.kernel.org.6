Return-Path: <linux-kernel+bounces-535149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7EA46F90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A91D3AEE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A7F2620E3;
	Wed, 26 Feb 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYMfxdHm"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509962620D6;
	Wed, 26 Feb 2025 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613379; cv=none; b=V14nPFgpA9dZk5KmJhDmOz6NLo+2jQ5wMirDKjOEmTQanJGZbtMmkaZoUHQFTGE26jDBWyPQPuxkOcKH0E6Z7RoNx/7/OYMGLohzCzj2xriknFy82vOGHSwlvaoX7S/F7AnKq82SQlqkvnpaXqvyvcqb33xeM+WwxZxNPr77gfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613379; c=relaxed/simple;
	bh=zKs69zuJTCMuJZx3kqjoXzCIAA1mJhuLMYaLs5UHP2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4Ly+ifgs0EwmrothfWByA5JjxioEd22yMgbQp4rBEyu3PCbJkHpMA5cOrhq/oLFsCFNlci0JLYhqSd8TTPIsofUXzAJZ9ByaNnaFrzNU5OMp6BukofOs2lK9E28IOz3ZaMmQt57bEcPLrIuKTG6jrkDbMwxN8Znq36nFkQsKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYMfxdHm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0a26b1c67so35913685a.3;
        Wed, 26 Feb 2025 15:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740613377; x=1741218177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YCkbkcOBVmYiyCJMExAY8OQtnZbeodmQmHyD6JqPePI=;
        b=bYMfxdHm5qKBtOZ2gHcfkcUJoKrhABz6nEspZZUeMBkEGuPmoeEOCOW9HkMF7XGT45
         pshKOXvrVKG5lnT4AXA2QrYcejMZqyoxJtkmoAhAq1UD5T+rAnANDHW2IStYDglRZcdW
         dvbkyJpZKT5/ucle9ogfeUPkTU9v7fAsgi8qB+PWxA19nkIFvehddniu7ydWn2xCZC/H
         Vcdsg3LMvYsn5zPeJhEBH+SplW2NeUo9u54nhW1zTL+XZj+HqlXK/xLRsCYqbxiutX0x
         jPUfnw/NkwADsT4f3Mjdm6ceaSYFNlE6Q8wSG8O+NcXuNr3vT6MCdajd3h9xusFS3chT
         7Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613377; x=1741218177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCkbkcOBVmYiyCJMExAY8OQtnZbeodmQmHyD6JqPePI=;
        b=NT6fD+fRC0beO+VCvWlqgknTkQFOgOS/JBpY7SqfbuF1GI9ldJgUanxomnyRwf1Ysk
         jJksMw/dvNWPHUerxrnEEQoK9sXdmE9F72Q1+uv3TFXlGFajVJ4RxjHu3ergL4D+NFBH
         P/jtZ9bVrGNgLNLGBTXqvtt7lnBYSVyULiMYU33ky4pAT/4bHIF+NxJOcnM6RgT0vlyF
         l2iDy7c3sy6ekF3nfhTqAkN3VUTnxZAmOEl/Z8Rx+WHh4U/P8w5wY7/mLvUV61vnYw7R
         CC3qEGKW9m4mFDzSzQxU3EB/H8M1I5fxhlVNBn3BpCZ9HnLoWprow7xpJ8euZHuUF6A+
         mElw==
X-Forwarded-Encrypted: i=1; AJvYcCVHWT9MwXW83w6hZQissxJ9kuVG9FdZbY38vPYelxzeBhh/JM4o45dbze1Uaxr0QDCH/x/ftipwNRmBIu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjY9/VpU/XKTftIzUscLszG6ThnYwaAqpq0Ym+hIij/WNmyzVK
	qvCcVpzmm/vB8oouzF66V+kQ+cWrRazii2skuhGcnjtS3RyDjn/q
X-Gm-Gg: ASbGncuZgWmjY2DoHkm+3zsIRP8CZ+2DoMDC4WZ3ARM2Nl6w48jl1zl3cuH6Wa4bUMV
	XQtAwmkivwYKf1R+n2+sPo1ZasU3kFDqh2EezqiHaVgWf90KP+3qPu6MkI/jdBI/Q4MsW0UN8IX
	fSTWWGLIY1gy29Y9WrQVwOkPv/vyK2CJ4foGV2JRn1BrnwfXIXA09TIA5pF939ihWCbi96ddhd6
	rNpv7Ypc2gfeQfK/nkdvutolCQsq5I2d0VcW9YhM4xC0a71ZOLkTq3BJ/yWF+Vo9iwtfq1nCEDP
	OQ==
X-Google-Smtp-Source: AGHT+IEE0yZnL/j3TfydHcx27TvYZq4HNVlRTjBaZb6s+lcBJ8etFGkpoweqrr6ivN/gIINJcC1idA==
X-Received: by 2002:a05:620a:2914:b0:7c0:a46d:fa92 with SMTP id af79cd13be357-7c23be11a85mr1282129485a.19.1740613377053;
        Wed, 26 Feb 2025 15:42:57 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c36ff0f1e0sm24115785a.52.2025.02.26.15.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 15:42:56 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Guo Ren <guoren@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/5] reset: introduce generic reset-simple controller
Date: Thu, 27 Feb 2025 07:42:28 +0800
Message-ID: <20250226234234.125305-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many SoC have a simple reset controller with toggling bit to perform
assert/deassert. It is annoyed to add device id to the reset-simple
driver for each device when coming a new SoC.

This patch series introduce a generic binding to collect devices
match the following requirement:
- There is a single, contiguous range of 32-bit registers.
- All bits in each register directly control a reset line.
   - There are no self-deasserting resets.
   - There are no timing requirements.
   - The bits are exclusively resets, nothing else.
- All bits behave the same, so all reset bits are either
  active-high or all are active-low.
- The bits can be read back, but the read status may
  be active-low independently from the writes.

If the device follows the requirement, it can set the compatiable
and reuse the provided "reset-simple" as base compatiable without
changing the reset-simple driver with unnecessary new device id.

Add a generic reset-simple controller, and migrate the Sophgo
SG2042 reset controller as an example.

Change from v1:
- https://lore.kernel.org/all/20250213020900.745551-1-inochiama@gmail.com/
1. fix title to mark it introduce new generic device for
   reset-simple driver
2. add "active-low" property support for the generic reset-simple
   device.
3. patch 1: update the binding description to illustrate the
   suitable scenarios to use this binding.

Inochi Amaoto (5):
  dt-bindings: reset: add generic bit reset controller
  reset: simple: Add active-low property support.
  reset: simple: add support generic reset-simple device
  dt-bindings: reset: simple: migrate sophgo sg2042 reset controller
  riscv: dts: sg2042: Adapt reset generator for new binding

 .../bindings/reset/reset-simple.yaml          | 66 +++++++++++++++++++
 .../bindings/reset/sophgo,sg2042-reset.yaml   | 35 ----------
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  3 +-
 drivers/reset/reset-simple.c                  |  7 ++
 4 files changed, 75 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/reset-simple.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/sophgo,sg2042-reset.yaml

--
2.48.1



Return-Path: <linux-kernel+bounces-310075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80496747D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD62B21A47
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13E2C190;
	Sun,  1 Sep 2024 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsPXTDtQ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF5249ED;
	Sun,  1 Sep 2024 03:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725162138; cv=none; b=PmP/JpKTrA1hUyGLarOdafhsUkobM+LpkV5maJIz48rYkv5bJJEq0YILP2pcUOdZjPp4b1VaGJdzauPh6JCxZ8ZzCdoCaaMV1UPBpIqDglFvlTZKh9lqn5OQScUbb7nCYkK5BS4r3BX2ee2U5IlNFvy3ERvT38bL/UItqTFh1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725162138; c=relaxed/simple;
	bh=yZ/CVVYjtuS64DONtMZBty84ukZc3qILy66xVEON1SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGeep0dN0NzNkkabG4DfqrzhGY6iGzXzC9fHZh6sV9LC7rBTNw5cW0YLPEhnek8FgeHRpcyr/MX1SujPYM3Z8xvQxfGWg+tF/NFTz7Q0H12dDpETlyUImgYHTdiShcbc1v+qnbVk36TGRl7tAjqP8KxU0mOVCKBbKTkb6UQWUBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsPXTDtQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71423704ef3so2371390b3a.3;
        Sat, 31 Aug 2024 20:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725162137; x=1725766937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gYVZX9F0tsvEizawck6Gs6K9CkXboSi1RjrBxnHjqQ=;
        b=EsPXTDtQkQTazBC/wHIbFIzApAbXUZWnwi5paifXlPvPZdhWbXstHrfYgJZLhBsD2y
         oTh3PaymzkXZlZ/cZLlM/3rjpeFTR5IZRrJsCimqmJj5tPf2NOkE/FvmVOKlLbaFy2sB
         zD8KRnG87SQadShtABVhKRxn+TucuL9V3RgxjTkPfBeSsgk1jdXOwyvRv30shagYpQfP
         U5Zn96/CRyulPYe6C9QJxpOOzKx32pH3k/da+sYIH75oxKWi47XNFk0dZZw+pUH+5W5J
         zjY4kssKnrMLlD25ee0aXfmn7AqD0SnkOBF7lDs9NSv15W1y2mWMkh1643ehKsjv8XfD
         JcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725162137; x=1725766937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gYVZX9F0tsvEizawck6Gs6K9CkXboSi1RjrBxnHjqQ=;
        b=WZwjs7NwfJEvDfapGldc45UsoaZaVYbH/PaUZptP5d61TcBGh/nq/jIa2mlAu6ERMK
         FJz6x6cZU3AgAYybRSeyo5LpQnnV4SjtgWyH5y/JKxVK6GAoIaXnLqUqIHAOTBcc2Eky
         gfOKm3WuBC1JbyrFlVEpfR/8MJr5937giH+IYvoMMT0qquBlQaavCP7SzCpcKwmI2G64
         jZ2OzbH7pIi0vk8/FeJgpUBWXYdlNl5tr5DXniqGrrJT7snd3NNZTVP9R1ofJ3I/fb6N
         4FlTCemhcJZsHcLbNCPkXAqDnDuqe9wS1Qs5v5fkv2JdaB4f4hqAxw4TmOhDNJTO9lav
         VNhg==
X-Forwarded-Encrypted: i=1; AJvYcCUtR9EvlDc0qEvLsq1CK3AJvk3xsEc6XeuDvTS6CEAMxAZvFUa13WVCoac+aoDvnn0IUimMzc2jXe1Mf3FB@vger.kernel.org, AJvYcCXu1PYvtk2YMTPchXTN7Ml3BgXdBBbXYDJ67Z74VQ68inQNUH9fAWIJ7SAW6M+BhBXz0Bfn8Y/f2sT8@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLXcl2C2LWXXtbCpkrjvmlPslHXD96XaXSNYgEsqRs6h1ZpQD
	7RdqW14VKgtuydeY1mo/pt7wXNCptl8NHoT10aLgS64gVk4M+j/y
X-Google-Smtp-Source: AGHT+IFPTZn+Qx6Y7uy1KDmqweQR1DLiZyvrq+mdNBFj8DsOiSWLbxltzHOIzgIY1JSGFgGkZe/9gw==
X-Received: by 2002:a05:6a00:813:b0:714:389d:6e6e with SMTP id d2e1a72fcca58-7173b690c10mr5859132b3a.21.1725162136682;
        Sat, 31 Aug 2024 20:42:16 -0700 (PDT)
Received: from localhost.localdomain ([49.130.72.113])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e55771ccsm4826767b3a.43.2024.08.31.20.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 20:42:16 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	konrad.dybcio@somainline.org,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 0/4] Add support for A7-A11 AIC
Date: Sun,  1 Sep 2024 11:40:03 +0800
Message-ID: <20240901034143.12731-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series introduce support for A7-A11 SoCs into the AIC driver by
if'ing out some features unavailable on them. For background information
about these SoCs, see v1.

Changes since v2:
- Removed mention of the IPI-always-ack code path in aic_handle_fiq(). The
patch to enable A7-A10 SoC to work is a bug fix to avoid accessing sysregs
on configurations that do not provide them, and the rest of the message
already explains what's going on.

Changes since v1:

- Corrected dt-binding issues pointed out by Rob, all of A7-M1 gets its own
SoC compat, as well as the "apple,aic" generic fallback.

- Order the AIC dt-bindings of the SoCs by release dates instead of alphabetical
order: 's5l8960x' (A7) -> 't7000' (A8) -> 's8000' (A9) -> 't8010' (A10)
-> 't8015' (A11) -> 't8103' (M1)

- The patch to disallow local fast IPI on A11 now comes before the patch
that enables to AIC driver to work on slow IPI systems. This ensures all
IPI-always-ack code path in aic_handle_fiq() is removed by the slow IPI
patch.

- Keep local fast IPI enabled on AIC2, mistake in V1
- Describe the feature levels in the description of AIC.
- Add new patch to remove unneccessary enablement of use_fast_ipi.
- Do not try to enable use_local_fast_ipi, because it is enabled by default.

In theory M1 can also get the apple,t8015-aic (A11) compatible. However, I
do not see a point in doing that.

Previous versions:
v1: https://lore.kernel.org/asahi/20240829092610.89731-1-towinchenmi@gmail.com
v2: https://lore.kernel.org/asahi/20240831055605.3542-1-towinchenmi@gmail.com

Nick Chan

Konrad Dybcio (1):
  irqchip/apple-aic: Only access system registers on SoCs which provide
    them

Nick Chan (3):
  dt-bindings: apple,aic: Document A7-A11 compatibles
  irqchip/apple-aic: Skip unnecessary setting of use_fast_ipi
  irqchip/apple-aic: Add a new "Global fast IPIs only" feature level

 .../interrupt-controller/apple,aic.yaml       | 14 ++++-
 drivers/irqchip/irq-apple-aic.c               | 53 +++++++++++++------
 2 files changed, 49 insertions(+), 18 deletions(-)


base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
-- 
2.46.0



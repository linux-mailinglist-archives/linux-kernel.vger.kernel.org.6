Return-Path: <linux-kernel+bounces-309711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD4966F8D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF481F237FD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953EF1514E2;
	Sat, 31 Aug 2024 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV5w5qrI"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853288528F;
	Sat, 31 Aug 2024 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083825; cv=none; b=e5fRVgd2sjqfPVbi5DK1SPZBHrwF0VA8/8Wcp33I0X5fXSVmR3w6wIgMjfjsGbV2hRIenrHVDaAh+TBpsMERQ+EJiIhWN+Tiqk6vyZUpfMY0qrG0+pPNppDfuwLOH/qpI09g5koDIYegyvMC3ef/O59ttGfu9a7eg6qcOADUJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083825; c=relaxed/simple;
	bh=6jRipSmZB7tBHL26nPToxzqlMWECJ6w6dEGLoIX4iV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDz97OujC5mwN7k/j2IuV5zC3dg4NWg7BD+gm35GpKvYfbVsEKNJ1C2+t6pG4U4z+TTp2tM0aiERAbmQUewMUB5D2KDG0sS+44i3zS4zK1NFi0puJC8Zu7CAgANvAuzVnHOYeMnZyLiaoLmoSyXP6s7vOnmouV6lSqK64ua27kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV5w5qrI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202146e93f6so25178615ad.3;
        Fri, 30 Aug 2024 22:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725083824; x=1725688624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByuhC/KjucY4J7CupyjYySbESElTD8OlxoVh31r/Quw=;
        b=FV5w5qrIM78MvK+AJvOHOEKW9AEQZFJ3nTjtRPj6RIfe1WVBDdIxn1zkOaiaQTlAok
         uzSurnVmU3nCQETQMxmAf2BOFk7Gpd4xElkswAHzayB5PNrPKOzP7ASHr5nbm96Rgo8q
         sLoQi2rmIsk6QA9TyBDeJrcYpisxOFcX8LCc8fsRfRqEzTMGtDeXamCGT+gFx2mq+vPE
         zCde9hwi1ytRBWyUbdW+O4BZNxfKdm92riNsjr7DvjAr64+r/Yp8bhZARNF+z6lwso51
         vn1nwloU/c/Dvc3h9XZAPRdVvMZulHod5tKPligeU7HLVcXdBPeUDoDP0txO54x/b9UP
         kY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725083824; x=1725688624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ByuhC/KjucY4J7CupyjYySbESElTD8OlxoVh31r/Quw=;
        b=MbZqXMcZfGOFbTHn8mHfW4IORPnFSgxExQ7ijm3OmI93bsguKPytV4OWG1YjQOSzdW
         7wBVl9YIvWcEEhvKk+jLcQoPUm4xJw90D6XSUoWsuOEAJXh3ZZndkYtjVrt9OjHJsWWN
         gckAjXDn849j5pRx7QsCGrBZVivF+09zYk1sXUqwdF9aNPpCDnmSE5PeJ1QDmgITAvok
         iR3Zbh2pFsOAQPxUTksOJqzArWoByB6NYMlplTyr1OdEo3UuAMnPNUfmdjBuX/RhQ8ju
         5y2SuzqIWaArlTuebsIb6ocWUiXf1B/ziUALleW0RdnmrMNMooCZHt2L41rUyubsT8ek
         Zj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1jEXLbPp1lF4v2J+Va8CONYmE1cy7k5lro5VRTpNUcGrKqt+iOWHnqQwOrPJxHgua2BybHg4V2FZE@vger.kernel.org, AJvYcCUf73UZlZ3brD7hJHM/da4QZdHxkrNRz+RAfCFeAZKtvvl5ivI9xQYjqmLTsMW671Z3iEA9sMt+d80QnM+3@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7fSmRqNYvj5oLk61Mt+bStqFwuBQhmwjg765p5Nxvmws3K+L
	DbJlOeYZfrzUoI22yZvwfAXPZiDfkkkJHauf4QlhI0c8Rxu2oQKu
X-Google-Smtp-Source: AGHT+IGh3vEuCKsQf/q7EZsGAaz8dCUKLiYZWUd0LMKY0xL83ycYMtjPR5YYsNp8yxn9ikg9CmVGwg==
X-Received: by 2002:a17:902:e742:b0:202:162c:1f29 with SMTP id d9443c01a7336-2050c46deb5mr78384205ad.47.1725083823654;
        Fri, 30 Aug 2024 22:57:03 -0700 (PDT)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2053aa8cb4asm12027045ad.271.2024.08.30.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 22:57:03 -0700 (PDT)
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
	devicetree@vger.kernel.org,
	konrad.dybcio@somainline.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/4] Add support for A7-A11 AIC
Date: Sat, 31 Aug 2024 13:48:15 +0800
Message-ID: <20240831055605.3542-1-towinchenmi@gmail.com>
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

Changes since v1:

- Corrected dt-binding issues pointed out by Rob, all of A7-M1 gets its own
SoC compat, as well as the "apple,aic" generic fallback.

- Order the AIC dt-bindings of the SoCs by release dates instead of 
alphabetical order: 's5l8960x' (A7) -> 't7000' (A8) -> 's8000' (A9) ->
't8010' (A10) -> 't8015' (A11) -> 't8103' (M1)

- The patch to disallow local fast IPI on A11 now comes before the patch 
that enables to AIC driver to work on slow IPI systems. This ensures all
fast IPI capable systems can use one of the IPI capable compatibles before
the IPI-always-ack code path in aic_handle_fiq() is removed by the slow IPI
patch.

- Keep local fast IPI enabled on AIC2, mistake in V1
- Describe the feature levels in the description of AIC.
- Added new patch to remove unneccessary enablement of use_fast_ipi.
- Do not try to enable use_local_fast_ipi, because it is enabled by default.

In theory M1 can also get the apple,t8015-aic (A11) compatible. However, I
do not see a point in doing that.

Previous version:
v1: https://lore.kernel.org/asahi/20240829092610.89731-1-towinchenmi@gmail.com

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



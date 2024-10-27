Return-Path: <linux-kernel+bounces-383651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A96999B1EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD9F1C211FE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F22616DEA9;
	Sun, 27 Oct 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiSeWl7T"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94136156960;
	Sun, 27 Oct 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039821; cv=none; b=Uuv2o08UgPjvCg0GEVGzCwm9wrozRS915m3cHLTqw239RFjIXrrEsl+VbGJIzEre1Ct0RJ81eRdJY6tUY/w3ceXN+BzEsXtSVr9BXpV3BvYpZ+yziKTXuwDtKr2j+LDRGG62XsGXTKVFUWk3L5cC3iEvv42QBZVhac44wp7f2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039821; c=relaxed/simple;
	bh=Ex8CaFl67w1VtC2hc/lcNDnGnJtDLlBtJT/wSUiYmBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6oSrHDm2s5XA/q4tvXa9OLZKcRyDDn52ZOWVUU6WsVWHwdPVKocY4reIMELFQ12qaxFy54x6Gj9ABMaw4PWtXPWwswf/HJNeyvjEUwQ8etggbgw3kyFnVOJ+ngYAeFveHMpveFOMUzhC1UXVDtNwxSh/XesyvyIt59VQU/ilyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiSeWl7T; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9ff17eddbso678166a12.3;
        Sun, 27 Oct 2024 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039818; x=1730644618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rm8BK0uAln/RMAZHBbXqzd3kfEXu0sK1tEB93lCjSg=;
        b=LiSeWl7TUz2QOkPTuO55fKQ2Q3/DbqmYQooZdu0JUCkVEZp9N76MB7R57t5RR2pp0S
         edXRDvXWZypfboppT36MFCdOGbs+pLID4VaJMGQXYjeY6eAkxfdJcF9RDwsQOUWReTTq
         ivk2x0Q2QH7hSIQdl8RWruH7TXzibo9YEKR9rMUUxYHUBhCaCkdiHmwu3bg5a0T40ccm
         xKjwqKJ/zl4bN05InZw4BCMbPtPMy8F31tfx944KDev6jg0Dv1nPQ+MHonjhwZSXY/yE
         6vF07J14yGOW+M2tx/ceIGb5ch9Iqbj/1PXl9casJmprmqzay26a//RguO+vZs2hYIAn
         UMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039818; x=1730644618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rm8BK0uAln/RMAZHBbXqzd3kfEXu0sK1tEB93lCjSg=;
        b=oDzHQr7TSxnw6/hBU8Mdbk9rWBcUMNKk/E+fFcVW/TN9QwyYoQfQ4ctb8vHA9ST2xL
         j288pbL41X6xwmw2oQt25OY7RiovboUIi7m9SdVfPXgIi5+4dk8PuM+/JThiva3kyd+T
         jHkssh3yVf5UY/pRnw5NxeK104UmO9obpTPMuxqNv/qpLTY+mNhsKPtZKDF0PjGyiiGx
         N7TvdTeHBRSmDjdwMgmDIy3j0p0SyfHKjTxoDT5dqHOqsiSDHp4eZZXIkP4JnPZL7Ot/
         RvOE5VHpy+6M87gss7v2AnYjX8jLvj1YIz93M3FPWBsYNj9vZwGIJyD+equ1h/6gEKEV
         Pw6g==
X-Forwarded-Encrypted: i=1; AJvYcCWFnAEWqQ4KM20g/5XF2HDNJ10fP9nI5hRZL/0JxD/jMeX9mxxgG5ZrI+Mnf6JLJ255kYbTjBtUoOIF4a7L@vger.kernel.org, AJvYcCWZz5tNed0Tz1t0Kj1sDldScZFv9FfR7rKtWeT9vcUZDi4uJQ+ogml8VBYAJyWrq5a06lmbaYNJOWHc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1A5WLVa4KzRTe2Glz/uSW+9hWiXJH7Y+nsxEUG0XAN2rJsTf/
	qHBVkq2ZPOipkF9gcxdK7hq7VBj2swxG3VwCACNgpFGL6NJWInZg
X-Google-Smtp-Source: AGHT+IFdtnq0l6pO5Mr+nGsKf4YZrMkkoTgcCHBPwe+6MmBmaUi8IJjdBdnuUZ5kLtYmHxLfMA6F6w==
X-Received: by 2002:a17:907:9288:b0:a9a:3dc0:efec with SMTP id a640c23a62f3a-a9de5f23f99mr207621966b.7.1730039817775;
        Sun, 27 Oct 2024 07:36:57 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:36:57 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 01/22] ARM: dts: socfpga: fix typo
Date: Sun, 27 Oct 2024 14:36:33 +0000
Message-Id: <20241027143654.28474-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A semicolon was fallen off the wall.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 6b6e77596..7113fe5b5 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -169,8 +169,7 @@ main_gpio_db_clk: main_gpio_db_clk@74 {
 
 						main_sdmmc_clk: main_sdmmc_clk@78 {
 							#clock-cells = <0>;
-							compatible = "altr,socfpga-a10-perip-clk"
-;
+							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x78>;
 						};
-- 
2.25.1



Return-Path: <linux-kernel+bounces-271553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D865944FF7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF881C21D18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53F01B142A;
	Thu,  1 Aug 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiSG5MU1"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16151B4C5F;
	Thu,  1 Aug 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528230; cv=none; b=Qxd0LY4vHpKasXjs6U8bHyxS5jMsBEfSzZxWGyjLX6JlyOjdCRnRctCeQTjSrCYdMk/rwVDEYk3p/j/0hYl4rKpY+SmRZjcrUFdPSgojjLyDnijOesMVvRhq3IN/mhOw9j1gUPKnFyKiMxIHvN/RD2wcNmME/Vxrq/1CAhw2x6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528230; c=relaxed/simple;
	bh=cRSCItG3u0/0B9Sy49+1YFsNwk8YK7pT+XKN22ApIS8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pafG6RGMWw+cHjIMVJeMAtz0OChrrw2eN7LGjxZoyvEZIKq4Fwq9ryqfxkvPOSs094n5gii1IqDcBxYHHzNAKDqyUk1zVEDrE6e5Ct7w/3CgqbPrAyO3EALnoIhcV/4vKs597X1hPwyJAmGg42UhNOzSjBijx24NB96F2idUBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiSG5MU1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cd5e3c27c5so4920646a91.3;
        Thu, 01 Aug 2024 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722528228; x=1723133028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOmTqjVkRHQxfRmStHQPSM5D9RFozJWPKk5wjb7WZYo=;
        b=fiSG5MU1It482aeSaBtL84ONcs7cTP7MjtbWkVO8N1/Y5Z20SzKLUlCUeEDvPExNLS
         Y6k2dhAvlVX6lq29M9/xMsgxL7Ka6a8L298gkysUFfSglmqEW8qTQeoEQGHvYk6ys1Bo
         N0hbu+RAJvhBdYnvB4EX+TscAOLa5qvno7I9N6Mdc+4u2tfihoNy1u2l2CNKBqBe6fXz
         hHlfMok37H+MiuaAFydaM55RyHPji8iMQr4zoBvKOh+LW4hWSIU9W6wV06mzKgBq59px
         oV2tNbkuduUyjDLfmssaLTmBw83NvW83y4W1fOuuPxnYrM1tj3uq8YJMuKdiutundu/f
         ONNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722528228; x=1723133028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOmTqjVkRHQxfRmStHQPSM5D9RFozJWPKk5wjb7WZYo=;
        b=h19cMxvzKAMCgOmZsJD1kGdTwhk61UeNBQiZClbuO52kcu9fclwyCSgq6sg5LEHKZr
         VFvZqyRijWOmgIJ5WfXWY0YRj3qZN6iPf7b/tRAfjUV8es5+o11dPERO8ZVNwY8HcmdY
         tc9axjxYzUX3bvi6zHdLvX6ofjIHrXoWMQ8OJFoCRqaaoLUZzcGw4CGt5FHhmt+/V4gg
         hOIuPV0biQd4Gn2ekr9HVJHWa92eAYky78DbIklj77KHKRgMIZil3X1IxGHtpd8QGJHh
         ZgNxnh8LfIlZFYxVTVoEgS2iGezyk8Y87hdxvaEeaMFHKPwz20etZrF7IMSXP05llLL5
         OXvg==
X-Forwarded-Encrypted: i=1; AJvYcCU9rB+/n/nTFAn3t9IMPgtT95ttecajabiAH72KLTruQxOWDIK5LbjoHgr3levW0xVjVJr4YxAn5LYYhnw5eT1rlIz7Z2AB9M+0DP4C7cuZBotCaYMJ6+UvTuE/0SENQbNO1XV78gebMQ==
X-Gm-Message-State: AOJu0YwK6HbNAcIpJQ6ESeFfRkqbLVdPzHdYT2c7oncWu3jtCAHUv65F
	h0rc+3cqx0HrkXROV6luQw3jo/QG3FTbCjkFUCdBm7dQSdOC87t/
X-Google-Smtp-Source: AGHT+IGu/QE6FSqPxWJP1pk6Fr6YnPMd+a/LbHhX+IELdNYtdMoUdbIVX7IKtor7Cm7rJEKbppJlCw==
X-Received: by 2002:a17:90b:1e04:b0:2c9:8b33:318f with SMTP id 98e67ed59e1d1-2cff94143damr808215a91.11.1722528228133;
        Thu, 01 Aug 2024 09:03:48 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf181sm3535268a91.37.2024.08.01.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:03:47 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/11] ARM: dts: aspeed: Harma: add sgpio name
Date: Fri,  2 Aug 2024 00:01:27 +0800
Message-Id: <20240801160136.1281291-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power-chassis-control and power-chassis-power
for phosphor-power

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 8fb30029e46c..0c4bf165d0b0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -520,13 +520,14 @@ &gpio0 {
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"power-button","power-host-control",
 			"reset-button","","led-power","","","",
-	/*Q0-Q7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","led-identify-gate","",
 	/*V0-V7*/	"","","","",
-			"rtc-battery-voltage-read-enable","","","",
+			"rtc-battery-voltage-read-enable","",
+			"power-chassis-good","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-- 
2.25.1



Return-Path: <linux-kernel+bounces-443128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BECB9EE7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFAF1661F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70E2156FF;
	Thu, 12 Dec 2024 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aawc+2ND"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AD2153DF;
	Thu, 12 Dec 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010483; cv=none; b=Ghi4ZkDRm4irqnIuaVtwXTLIJygUOKWmqQzfdFkUIfWo3MOa7kBIw3oCGJUAd1h9Dq3dmQ9sIj0dSZ7csd3nIfMgG+8gAgZtB/DwvvGz44NUVlIOLUP6DXb6W5ErtE11vV6nlqYPuEQjJ8LwKTAPeChuKfp5pgsRpNAXAl7s7Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010483; c=relaxed/simple;
	bh=/d4vfpu/U/HMN8WJs97o1xq/2F4WnPVYBuljYRlwy7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qF2TW+A+nHGW7npRK28bJl6SgvivFhq5VUC6tblhfp46SY184V33sQ4u9QObF8TZupG8EVr88N86hUEj0RDerTcx2QcnA5wTX+/qR3ZxP44W++tUU0+G4rAToB4AvZz1Wrv+Ld2tHFn3+dmMUpO8zhx8HRtQ/zFvaXqckTsPbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aawc+2ND; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2156e078563so4601205ad.2;
        Thu, 12 Dec 2024 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010481; x=1734615281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+9a62ZNb/EWT2KZraUPUvnwvMhSxc9YsoXJSC42SEw=;
        b=aawc+2NDEHt4xxzj4J8Mz2TQazuXCLK2EGMANKTOwStzaVIvykYv5gIdbAjRoi6Zuq
         yyj6ScvWTeg4RWfweKgYsfol7Hmmz4U3Y/q8Ei0OG0SXEmPJS5w2QVqgk7Toy4/flDPU
         abldpOKfKgYrnR5lyfK6yuF7r8P4JOxyy0PArK5S4peOckgxIUmEkrMxGLpdRl/vrnJh
         1doCq6XalZExHM5kKWB9Q1QCHipKbh7o2oMPwuUPGsEPTcHI3EfybFOy/HPpJ6V7bSkc
         AuHuxwj+oWU7Lasxc/ObRweoHHEZOzGsJ01Ng6kh4jC7HXZSfWah4MIb9nQh5ZkkC1YZ
         RPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010481; x=1734615281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+9a62ZNb/EWT2KZraUPUvnwvMhSxc9YsoXJSC42SEw=;
        b=S8fc3XtU88KjSt0uq8VlwATo3UAqa87AMot/US4x0YEeycmiMu7EMRbKMj/HgYjJDL
         TA4ajFtljSVqqk8Uc5cMaRH4sFgPGSBDtm1Itovr673rcfi1l7g91j74GJhnD34LsM1C
         7NzCPSeRK0lTBY1LdvBuDu1fNQYGgVUcmYBueNZqeXqdhT7Jb/MQPDKX8vHmJ0YKznSo
         C2nEwTjPmvkmgl7qzVmZ4o7yCT4eR0rEb+Yl5Q95ahKSrc8uOE8pj2DYujy/BAZocUzq
         Yk+qvLGMH/VLxDBqhfTKca3AvZ+Fx1Qy/Ahax4Tn2KZrq7G4COeocPH6vzOswGh513Fq
         dMGg==
X-Forwarded-Encrypted: i=1; AJvYcCVQfncU/Ixe2MmFuj9aMFOUpf0L898wwwsa0LNVwFfh09o/JCejrp0wOtXHfLSoenW1HzgDv/cRXfGdkcCa@vger.kernel.org, AJvYcCWo6cWlePdcaaw5jaIEWXLN4ajmk18IMHffoIV9vxhjwSwI7QBCUdwSixBK4IRMq7c3y0gC4M0QHFMU@vger.kernel.org
X-Gm-Message-State: AOJu0YzASVz1MdgBQvC4vbSc06RdXfjFYWNbDCqmIs2wSVMNJY7j6pBg
	Vzthsxy4WyujTxH4BWAM7nYWaGo2A2P/Z6dg8qX1aFtg89/qbqgR
X-Gm-Gg: ASbGncvyMsnNeZunvdpeYcmGt4xXKAF1R/8fD5oETejs+AALaFgq5vGNGKp8IdgN31o
	Tw+8IGwcl27fC0UTCdJCOBOyyCy7D7YMjU8LwQJy8I2ixpmZcY3GRfPKSZSxjT9JVVcinQMq0xs
	JbVLm7/FlYCSuIcwrAkDWLoXK7Gc/cZnEm7yULbcSC1Vh4OdZrwYIyosuOZMDPY2W12PNo76XTN
	Kkd3/yu6jlAbdk9t6wg7x6a9WLiB3l2hvT/hqH2Ss573oLoTZ8JIOrq+IZ6KmYSr5vPN1Sn0H+Y
	jCRA8jiF9M24Kt1tI2LINWrfIsluf1YBAxZGKbf7YdOFxptQICN/iWYQ7z2ZX0JM3lOFIcWvtxw
	rDzXs
X-Google-Smtp-Source: AGHT+IHy1BSLKHF/ez/arq9rOsDz9L+2JIM6hHhlvZ3suOhtFcy4XDdXZnNQNlk3OKOkub/hn6NdTQ==
X-Received: by 2002:a17:902:cec4:b0:216:5e6e:68b4 with SMTP id d9443c01a7336-2178aeed4c4mr63751705ad.46.1734010481565;
        Thu, 12 Dec 2024 05:34:41 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:41 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 4/4] ARM: dts: aspeed: minerva: add second source RTC
Date: Thu, 12 Dec 2024 21:32:26 +0800
Message-Id: <20241212133226.342937-5-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add second source RTC on i2c bus 9.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 7fddbe833cc2..ef96b17becb2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -1292,6 +1292,11 @@ rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
+
+	rtc@68 {
+		compatible = "dallas,ds1339";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.34.1



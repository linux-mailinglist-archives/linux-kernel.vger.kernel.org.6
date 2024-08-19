Return-Path: <linux-kernel+bounces-291411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC9995623D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346801F214A7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5B14C58C;
	Mon, 19 Aug 2024 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhXJtE3C"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCF14A4DD;
	Mon, 19 Aug 2024 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039816; cv=none; b=Ax89QAiyEUyBgJf4Se9xbfPfIAMNfnqrrPT63Z6Cu5hrj9NWgH8FolJ9PePcbWEuhp7CfhA+s7T6lHTT1XS3Z+mDiTjP4acphtf8fPkUq/XZ4WMo2h6VQveB9vil7RyPH28i5bcs0caWFB77RIExkreIIeL4pKA3wmwroXgEuug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039816; c=relaxed/simple;
	bh=dHF0Dci0tW6p0juExj6i/pnT77mPeGssho6khUDDIWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vv4brBVFtIYo+z3aU50BON+CaFcMtbewhh6J//h6S2IfrDo043DOfcfivMOJYHb26V5RSiUBpoGqklJqyMosMBwWm2gZg9jzmwLL3CECc3et7ADMDKhM/ORq4aPhCNS85QXPkWU9SGrI8XQMteO+aV7a8U0kXOUuKRGWPc3k2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhXJtE3C; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20230059241so4078375ad.3;
        Sun, 18 Aug 2024 20:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724039814; x=1724644614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD34vQIo66dqv4PnmDSmrEVQgpwvd9jgM7mrU60RqYs=;
        b=JhXJtE3ClDZci22cJXbSioHxhWPwM9LnHRTZ3jfdOZNsqvW5GeTlLx/qnP0AGifhXe
         HEZkgJxbxg61E6LzOzHQWvEGKKCFWoqwSEkx9/9+e5czYyNueNeWsx9IRm7Ul2YLvOcj
         Cf/XJHDVXJmWivFGIMglWsU05QImifSDd003qvGO+/mS6KOVtmwZq04y73+I48LrV3D6
         YA6C5gpAgAif+ltWiSu2Kd+czBTeWOsXxQn3DmsP8PpDxmKjISSQJCy4C3sTQsjvb0YK
         8Ra0/kiwFLMSggAFdL6LZ8caPeBpVtWzdxyXJBWb+BeGdIbKoFi6Nx1OkFgyXHGUVivn
         /7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039814; x=1724644614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD34vQIo66dqv4PnmDSmrEVQgpwvd9jgM7mrU60RqYs=;
        b=KxTh/8DoNUbXIYSOcnKE3N50WiGzGSi4FLZZ5YvZ8MGIgQZiwM3XpFuANioPUoFtkZ
         mvhwlhlEznZOQLnIXBKNB6ARdnj92N3jX4Wm/TG57gmd+9iCDonoetJC/EdtYh9yfQGf
         bj1iOyg9QK5Ftq9fzaaAhbLW6NwVyzpr8J5khxnAKWJR0o7Fl4wgUyijas/Bg8xXY/+x
         rixH/9bbnrB3/YSp4G0i7KAceqDjCsi/ZmrFqnjDBphrVju15O3HAy3RSKhsZQ9nTaSS
         4jAkxaPARsKigioqRTtUc9CHV3G0nUFYgPE76x3R05Hi8ZFTEON4GzdBt90HjEhWqmNl
         igSA==
X-Forwarded-Encrypted: i=1; AJvYcCVnbbx/csBBBbd743IhCvaomdy8Wb/iYkfhFYBivP8zFFWnwnni7RMO2wigfZXMyaAEeVNtvG3khNkVMNHeFgHKUB/PLEJ4yonT60WIpJOjnJpVsiZQoENpfkYloo3tzAAm7Zhro7cjqw==
X-Gm-Message-State: AOJu0Ywc4Bz76B3IxTvV7gMMcNGk8xTw1W65EDH4iRqg6zvVaX28DCPz
	xOc/cEf213uqNypgNkFVvNePB0GDBegiZd7c7RcidG0naRHnsCi3
X-Google-Smtp-Source: AGHT+IFjBqP72MqkABZPQbwq5C54vt5eP10TWJUf+V6mIGbU756Wry/HOS140AR6rnx2vQw5Yruiwg==
X-Received: by 2002:a17:903:360e:b0:201:dc7b:a8b9 with SMTP id d9443c01a7336-20203eab02amr85082785ad.25.1724039814359;
        Sun, 18 Aug 2024 20:56:54 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375649sm55784435ad.124.2024.08.18.20.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:56:54 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	soc@kernel.org,
	schung@nuvoton.com,
	ychuang3@nuvoton.com
Subject: [PATCH 1/3] arm64: dts: nuvoton: Add syscon to the system-management node
Date: Mon, 19 Aug 2024 03:56:45 +0000
Message-Id: <20240819035647.306-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819035647.306-1-ychuang570808@gmail.com>
References: <20240819035647.306-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

According to the binding document, add the "syscon" compatible to the
system-management node.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 781cdae566a0..a6b34e3e8b10 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -83,7 +83,7 @@ soc {
 		ranges;
 
 		sys: system-management@40460000 {
-			compatible = "nuvoton,ma35d1-reset";
+			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
 			#reset-cells = <1>;
 		};
-- 
2.34.1



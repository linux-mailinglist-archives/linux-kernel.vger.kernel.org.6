Return-Path: <linux-kernel+bounces-434607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6709E68E3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB00284F1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3721EF0B7;
	Fri,  6 Dec 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4EBie0n"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A331DF260;
	Fri,  6 Dec 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473716; cv=none; b=hg89uotRXY2fXW5taAV7DrQa64gm2w+UX9l1DPxKd2aT+wbJ7SpBuiqlHcOWhTA8qqQ+va+R1uKTmSk/Y8+hChqQPFID9u4j1duLKP4ff76g/kFQte11P9h9NJ9rwqYIFeSK170RJRjCu0T62O9Sm0U0iHQIYLLrhXzQpXMBAzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473716; c=relaxed/simple;
	bh=FfyeoJNgTrTmOeMh91E4RFrKOdHb5pGtpb4dWSqUlgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rdCkmgka7vXz6yDmCtfjjYlFUmuSDRiR2WqqlljLnJaQ8VxLcaJQ7J4t7Ko0Ku7/h2Ak1kgG3jSNI9RFmPm8p9e6yh3eJZZgF6nDcKsOh81XftBRf6jOkj+Ev++MUi9eSipaUwhIPrsZE9y4EFwTuJkOUhphboJs3cofYhMoGCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4EBie0n; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d1265ba5a8so2008896a12.3;
        Fri, 06 Dec 2024 00:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733473712; x=1734078512; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3c+NwdtE8SA8o6912MKBXAECHKLDvXUOKv+nZ7Jhjw=;
        b=X4EBie0nTIZb9v7LxjzktREn9PgNztZiosVtMhKkfZLmoxe3lpB9AALGwdhBZ3aiXV
         I2KBCKP7Pz/dzqJKi69QYz93g5Edg8M4huWvaQzFBhkYyfFLvq6OC1zASpAaJxkEhjcD
         WpDrct2BSrePETel7gB8y0nz5BafIdK9bnA4/0SfSS9zhCTBVMIu50h+ZnDEwed70F0Y
         71ByDPTc6zW6BjjpNZ8td+QThNQfGSXAzerZjHD/q08PJZVztg32YIbLjhmBLwzoYuDE
         wLDPxH7DXv0dPJn64R3oPoCsXPhReYQtTgMkO60DN9DoVMeeKoOx4dpUgShZPzGytw9C
         FlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733473712; x=1734078512;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3c+NwdtE8SA8o6912MKBXAECHKLDvXUOKv+nZ7Jhjw=;
        b=OObBVt2+NqXweB2QOO9K2yKZ6Gh6Kc98SRXjD8+gDPP28jhZxhRfAzyDnOe7gy3ZHB
         txLLiOWjWPuwxTYnveolr4H1PHCc/aITJxBq+NhroKwiJy48gM2tUoN7HkUIKyv++mgb
         16cmgsMyG6diQ6rMxNMieVk/i6PWraBuvIZ71vjx5INXC7h5gCJbNWsQmnmsXm54FXqf
         w4EdhQJxY9u/FBIdtlPfjPyjBVwl+B81/KYKzb9Sm0LdeL76qje4zKOqqYG0Vgn7Ge8h
         t8fsapaTz8hMiDbWaxNl5yrb+lk5j22icXozWAGNfoCBG0T/cjvYI6UMP8FVm9HyCfPe
         7K8A==
X-Forwarded-Encrypted: i=1; AJvYcCVKJHUN32871Xxmk3orf/9/bVKAInUKud+p1iuZ3fRW/zaHB72YRWG4a1bIo5xMP65lCMAQL+7fswN4eFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ImrMINKuXF9YmqVnb3a9btAmHGbIAo3mMCKSmPrZUfP+Dq+F
	QHSVgdzQiEPNFTtNRdXi6BYN3yAC1bJqP/1u4gDjk2lh9w2rLrbjkMcygw==
X-Gm-Gg: ASbGncsC9PogFcgww2D82bzBrXCmFH9pA1qO/34VVeyRdI+jqa2UDSWHt9SPF/2a5iL
	ezXJOcG7ZVlTXIwLCsLglz9YQTX5MmEq6S9hEl2qn2KxhYtL1abk+m3GXJ5JA912nxrmysPzyAh
	G99PePNTM9WIFz6pTMgo8vcI29ZWEhhQQz2hQFICfnkYmxw9KhGXe60U8jmZzrCVoHReWP5RdMr
	2IFLK8IKBz/jUs8KXOIC60MWr8TbaM+3U4Gz9cK7C2cbhXc+ZqbuqIOU8UnG8MX0C6nPGQxjlcs
	9S883XtKvB/GPA==
X-Google-Smtp-Source: AGHT+IHF7rsOS0I0cqZbTM/3fjPlhaZ5sKOk0PVgSo6h/3XcIbKV8dspiYniLcWDZDMH5jrLawdKaQ==
X-Received: by 2002:a05:6402:5386:b0:5d0:e73c:b7f2 with SMTP id 4fb4d7f45d1cf-5d3be660913mr1559713a12.7.1733473712276;
        Fri, 06 Dec 2024 00:28:32 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a25f09sm1908085a12.1.2024.12.06.00.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:28:31 -0800 (PST)
Date: Fri, 6 Dec 2024 09:28:30 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: sprd: Fix battery-detect-gpios property
Message-ID: <Z1K1rnndKGIFdgfj@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

According to DT bindings, the property is called 'battery-detect-gpios',
not 'bat-detect-gpio'. Update the property as such.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Krzysztof could you pick this one up as well?

Changes in V3:
- rebase on next-20241205
- drop already applied patches
- drop cover letter, as it's now just a single patch

Changes in V2:
- actually fix the property, as per bindings
- drop Baolin's R-b as the original patch was incorrect

Link to V2: https://lore.kernel.org/lkml/cover.1730720720.git.stano.jakubek@gmail.com/

 arch/arm64/boot/dts/sprd/sc2731.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 2d27427c41a2..458685b82462 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -97,7 +97,7 @@ pmic_adc: adc@480 {
 		pmic_fgu: fuel-gauge@a00 {
 			compatible = "sprd,sc2731-fgu";
 			reg = <0xa00>;
-			bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+			battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
 			io-channels = <&pmic_adc 3>, <&pmic_adc 6>;
 			io-channel-names = "bat-temp", "charge-vol";
 			nvmem-cell-names = "fgu_calib";
-- 
2.43.0



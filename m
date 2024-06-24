Return-Path: <linux-kernel+bounces-227671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E9A915554
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EF41F243EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8719D8AD;
	Mon, 24 Jun 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGyKtQ1P"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD415179AA;
	Mon, 24 Jun 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250013; cv=none; b=Ij+EuGZYeS4QP0Gvdfj472iqja/uxCI0XvrZfP/rWFLq/peEjOOcnZmUNu8zURmGAa9WX/7V8vRVAqYamB/riMRspMjeU8Dmbn2ziKqmKP3cGfY8wcqaL3tMVR45dU5Qu95VZkyXiNeaQvU1MG6CfZd4gdHC9noa8v9RdVwgYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250013; c=relaxed/simple;
	bh=tBTQ0v2IoMRb5rIRExjb9uXh2xJJ+R5x5qFbzWKLB8o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=nZb8WpM7uP6b4D/12MBHLqTIHHfiPFeDdOR+qP6RhdGwA2K2sUs1NHe7yanhsKJly3AtZ0zZHSFU+ziDAYFBVoviImWhSw+C8I5UN2cWK+n7MXxiHbH9D714BFMgRKgBBj8sg70cGuSSTdAoM11I9nYLOpjHRc9QyS/Dy/8Q8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGyKtQ1P; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso4479228a12.1;
        Mon, 24 Jun 2024 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719250010; x=1719854810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMhCaw3FpByMJNvnQY01X2wp+sz/RDm+M0TSHAnlKH4=;
        b=SGyKtQ1PiOwe5QwjvUWZOh6910HmUD0+3jOns6jXcVn3tHsRJXmBETyvRsodnWFcl3
         UjCF8Hlyew1atRK81gdWPB9Zb4pTOc7PJeLaa8QM+zPltg64uDZnaKpgjJ44miAzEEFL
         /CBZ7y2LNWNZLrDzLN6vNeFY1fZJEsmXA/HbSHhw7UaMT9pMj0WNIC9w22skmproMneD
         B0vf8FVTgCPk8Dwryn6AFOLNprhONIcw0MmFVZxp1b1V83fawUMaM8WJ1NduF8c+KqM4
         Hyg1hOc/wCimq8OGjQaRF4cjOSdkSacMOOBslQwgKmXpai/Df2waae3QbnVBn7PNcxww
         l0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250010; x=1719854810;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fMhCaw3FpByMJNvnQY01X2wp+sz/RDm+M0TSHAnlKH4=;
        b=uLrZSYB5yXgF5At6XCYS5i21fE/JJCMacGgplV9INdtQw6l5Z1bTlxfCgyvbpolSD3
         vREZBLQ3DHU5CnWCrmpEX2gBW8FvRZSZpyAky3807n32VHgJKFbLN9W2BpCTRg2fSrl0
         Ci1knwq1MpmqvPIk2yY05JKwuKdIM1LhBKRDTY/jYabopH3fgeWBBvSTDTiqUsJNfqZh
         zmTMa0h40KwuWlVp4tP4dbFq2ZIIiuSbjGUS6eXixcCvkD4aQblo2JgrmN4Eqy/JlrvW
         usIVZ/8YpwNeaxMuOD8QxZ11phaErF6dUbMqTo/JLwU+rb8bZByD5PCR7wISPyGKBDFt
         5BXw==
X-Forwarded-Encrypted: i=1; AJvYcCU1CJkpD0RnKV4ltt19MT8/hi2+QAK4MDT4u3gtuCyedRzj2PD6Wks5CznTtDq9Uvm1jqgOPthFd75iqTimPXDt6dP/21pSiIH/FPihWJWe9k9CcxH7uKCtv0Orj3jiOXCG12FNfE3p7g==
X-Gm-Message-State: AOJu0YwB0tDO8B/BhzGZ5rQfjOcmq8NwGwmS0ByLMjFiUv09SQCFXa6p
	cP4GXigDeJ2tX9eDByZcE5Qr9CxinlRaOUnsy0gaeag07pmYNb3B
X-Google-Smtp-Source: AGHT+IEctqdpyD/6asugdeUtrjUcC7fGFEroCRUJjXXqW/q+2UnnPdeJVSdtfws/qsJO8AUPr+WWYg==
X-Received: by 2002:a50:8e52:0:b0:57c:ff70:5429 with SMTP id 4fb4d7f45d1cf-57d4bd56495mr3207759a12.8.1719250009867;
        Mon, 24 Jun 2024 10:26:49 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048b923sm5064209a12.55.2024.06.24.10.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 10:26:49 -0700 (PDT)
Message-ID: <9d0fabb0-70b0-4b4b-ac7c-389b1c7afe20@gmail.com>
Date: Mon, 24 Jun 2024 19:26:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: rk3128: add #sound-dai-cells to hdmi
 node
To: heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to the 'hdmi' node for 'rk3128.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 41feb121bd84..e956c9cdd02b 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -566,6 +566,7 @@ hdmi: hdmi@20034000 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmii2c_xfer &hdmi_hpd &hdmi_cec>;
 		power-domains = <&power RK3128_PD_VIO>;
+		#sound-dai-cells = <0>;
 		status = "disabled";

 		ports {
--
2.39.2



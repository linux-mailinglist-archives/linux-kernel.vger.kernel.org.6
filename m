Return-Path: <linux-kernel+bounces-219188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80090CB14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC9B1F26915
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1C143C7D;
	Tue, 18 Jun 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFEmSqTN"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137811419B3;
	Tue, 18 Jun 2024 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712149; cv=none; b=SiS3wEmj3c4aBOVFYehAf1/EKZ0RY5Dfnq3iNPphLt5L1J9e+XCK8F2EW+5vUx70tZojJQkQ9uWXjBAjjYxCWecvjD1kjFz+dk9oV/CUBZPn47QlRtxsPOEv/DrSiMZ54/Z/aPT5sHd9RGNf08oWpldMCYsFtlEL2GphdLApKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712149; c=relaxed/simple;
	bh=Azw9nBD4IpzwBhn8+guBqG5REwUaoC05CshDNFNlHkw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Rt3oUMfTSZAubiZQix7Hu6Buof7fw2rXzP05zvdSD6+LmLTS3Wroh6pyncv9GrKWbxKoCSwTNW0PUY2VyysjhtqbH5fivXktOsIsEmYWwl+yuTu+shHTzAIcMRSWEhj18c705r2PkiUfHQp4JEoJsrz2myQis43pgBXhpBCWw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFEmSqTN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so6374578a12.2;
        Tue, 18 Jun 2024 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718712146; x=1719316946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haMm9kUElw9QALa2HCVGPI09+V35cG0nxwVmSkEijp8=;
        b=IFEmSqTNQyXuf4nFMUlJJpxnRwn2hWrjqbQryKAM5Q2gPCB+QqhINMinhkryokO7Dx
         5QV1tU6qhDYSYaEsBuWsdnSf4MZgefg1dbQzRixPvkl8iWrjCmsegQHMyRCEonXvp3gv
         AP3Syf17OvtIuBVtL2oR6y/H1hx7QFxgE8JnUyljwaSxpjPI7eq1X6NojTxJGGEAA+Bs
         4oHDeHz4E4cqFyIKkgW4quCcz5zHpi2jCGpU0zqekOfgnmZw4FPc1NqRqLFcxP59EisN
         H/ddfWA/DvFxlyhACm2w0xHyZRPKqa4mSbbOm1OeTguLOXWDB9VNO/h4/e3/cdrln8Hz
         dpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718712146; x=1719316946;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=haMm9kUElw9QALa2HCVGPI09+V35cG0nxwVmSkEijp8=;
        b=TgvyM++f1pmx/TTrHZcyjz7lMM9tCS8Tzn1B4qIA+yFN6MyEZtlBpQwWAQCnaO8ogN
         Ibs76K/7F5lthUpVfxo59EBSRaKCsLNj++dsad9tBggsyYiGCwwV/idgEeD/AkyPxKgP
         kOPP5FDhwlyF9HJN7n/cV3ssf1IL4DBtOiZuZ5PpcDfVXrK0Hmu4JufGR+e+hjRbnUZO
         sxUyITlbzHOss38V+s/XhcQysux5OkJW9/92eua023/qPZacX/rcj8M9xTkXd4Vpd+GZ
         fmUl/gmrfU5kKoZeyH5plaHDRXCddh2oEmfSy0Z/fhdHP5FGvf7SVpOhbdD/zeHa6EHk
         xG1g==
X-Forwarded-Encrypted: i=1; AJvYcCXGQ3HJDjhk44muUSErmNt/Wn9lEZ1xEP2u4Wkld1G9d7M3f93bEhdKta3fml6pwRHvIJkwuAotLlZ5bSUpOEhhcMPH2EQjUJvcF5NoUvLooAjeqDAIjbqT6rv1HCe57KgDOYEXpl6W8A==
X-Gm-Message-State: AOJu0Yyy0A3Is7/2PO5aAga6dix3U+VcQe+Unr9/kWSMmJEEUWcFLbO/
	zVB1rM+M5oqtpewlb7qumheopI1BguzSItySAG63elV3sG1UxpCC
X-Google-Smtp-Source: AGHT+IEceX/tQXoH5/SOBLcKdjQJKVpeYOaE9SIl3OdqZW7F80RU9A4QwG1PRrACW34ftqCmyh+acg==
X-Received: by 2002:a17:907:7849:b0:a6a:6ed0:fbdc with SMTP id a640c23a62f3a-a6f60d6063bmr1038360866b.38.1718712146152;
        Tue, 18 Jun 2024 05:02:26 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd1fsm608496266b.102.2024.06.18.05.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 05:02:25 -0700 (PDT)
Message-ID: <5fe7c2fe-4a38-436a-8017-66989959329a@gmail.com>
Date: Tue, 18 Jun 2024 14:02:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: add hdmi-sound node to rk3066a.dtsi
To: heiko@sntech.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add hdmi-sound node to rk3066a.dtsi, so that it
can be reused by boards with HDMI support.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3066a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
index 15cbd94d7ec0..5e0750547ab5 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
@@ -53,6 +53,22 @@ display-subsystem {
 		ports = <&vop0_out>, <&vop1_out>;
 	};

+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0>;
+		};
+	};
+
 	sram: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x10000>;
--
2.39.2



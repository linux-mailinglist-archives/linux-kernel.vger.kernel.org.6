Return-Path: <linux-kernel+bounces-227698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621AF9155A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C6C1C22B33
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54019F465;
	Mon, 24 Jun 2024 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyIPANmI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB919EEC6;
	Mon, 24 Jun 2024 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251013; cv=none; b=ljTeVs/L1tSM6K8ETpUmDiPh623wUknlSeFjwN/aaOFojJtpWpXWsKe64YV1bZoXByi7WVhfJ0I/4zIk0lej91lA6IDqOWQdzolhuiiPnUh7LCD8LhsxB1+Kq6KBK09LPY47G5p2JbJGPDmTK9+Vg935Yu40sM7GVMh3XuPNOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251013; c=relaxed/simple;
	bh=IfldlGFHsAMQVMoyS6SUigsG7AKmsKv1tHCFvAVq7Z4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=rrBngAjFa0Z8Z3hyEw0x1AmbPUZeI6380jBzPXqdnwxVSHDLtEDPWKEUSQFG9Lsu2Zh/Z4oTFP+GwDU+qkNKOrIZgXARRt+aom0UKlrXjzeZStnWsR677+R5/DZpiVF+gGpPOc7UXQxwszoquv1ILF1pAHaHLOlLRgRG7gwiDiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyIPANmI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so4374811a12.0;
        Mon, 24 Jun 2024 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719251010; x=1719855810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+lSKICwKIdtSkK9lQl+OJqVa8pdF3gRpXCDKOHiiJ8=;
        b=DyIPANmIsDq8zzZDRbj+V907ZFKeRiVySatr86djumi2zvPd0zzjaJTKzJilOvWGT/
         7rYUCEV6Du/pyUhPe+waEpkq1sDDFdUfLxqes39neMBQafq5+ZKnimKd6z0I21XfosUd
         0qruixkOSef2GcC5afv/Jb0dDrqyKu0F5LBSNEte9nQTzO1P4zYG0rGC3akarbkFWkVf
         FD9QNAsOlNJ28LYaLSpJ9QnH+brN/bZCYZN4N3yKVN/VOKAiD2t/GE/ikOlG5xl4cMXJ
         ENzSxjYOFE+PPG7Wtoh77ZV37tTN2rAsmZh2CuqSVfrOdA+u6V0Q/3BzczEpARBsFnOS
         +0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251010; x=1719855810;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+lSKICwKIdtSkK9lQl+OJqVa8pdF3gRpXCDKOHiiJ8=;
        b=oRYnxh7GPZuUty7uOKZEgIu78YQZrKajiAnT5YMFPwM5KN+lQ3GGf3ayKcmBJuYe6n
         yhOwIbOyjHb1XD+rpM4ssBrp3vBlG1AxNyHS2ehNi8tTZA3Ioyri9DLchgQSJlvf3Rvs
         mnDCLaAUejG5GhDL1ED/CqmJrdrb5PlU1MIwX2JYkZhfXPpAu19GS7QSSrGBKd0AgfXB
         QHajGsexzsA1LtjZ1I1Hya9MnxcFXrbQQe0IQFtTf4vXfMCmaWDZzCreuB9wVFQF6jBP
         OvUb3elBBRUd1+8vXdgGkNF4EUbFsW8OG2hgIAfeHKzL+OEb39zY0v80NcqV3v2xl0Fi
         NMcA==
X-Forwarded-Encrypted: i=1; AJvYcCXL5Emt58v8B1bqWbX1i4DnUVCNtNabPs3Relze+iuAsgDR52RPjbD34UbbQqvtBPXkguNY8puf2EjHkbHGG/k3gq6x7B7tMWgypdRtMvMV4CssoqHEta4Lnw5x9vVzvxZIjMeuzGwXSg==
X-Gm-Message-State: AOJu0YzjYQYSavaQa6mFu9Ko8plLWzOwSSMxj/rAu6xWifor9kMrgmw/
	dWvBKUH53cOxaSbLno3E64mNxMliV7yVnBbQ+z2U1KrZ/+8MMfAx
X-Google-Smtp-Source: AGHT+IFRm8WW9olx0Eld72eMp/pkrAuCiI9962yug8FqjUKRgG78eHmwQkGVhlbFo3Exv938w+Aofw==
X-Received: by 2002:a05:6402:270c:b0:57d:6079:3916 with SMTP id 4fb4d7f45d1cf-57d607939edmr2112010a12.26.1719251010277;
        Mon, 24 Jun 2024 10:43:30 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? (2a02-a449-4071-1-32d0-42ff-fe10-6983.fixed6.kpn.net. [2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3040f003sm4944936a12.29.2024.06.24.10.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 10:43:30 -0700 (PDT)
Message-ID: <55d302e5-c018-4b93-84c1-8cf75162e939@gmail.com>
Date: Mon, 24 Jun 2024 19:43:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: rk3036: add #sound-dai-cells to hdmi
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
so add them to the 'hdmi' node for 'rk3036.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3036.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 04af224005f8..96279d1e02fe 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -402,6 +402,7 @@ hdmi: hdmi@20034000 {
 		rockchip,grf = <&grf>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_ctl>;
+		#sound-dai-cells = <0>;
 		status = "disabled";

 		ports {
--
2.39.2



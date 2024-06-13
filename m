Return-Path: <linux-kernel+bounces-213792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34E907A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774771F23445
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AF14A629;
	Thu, 13 Jun 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjhf9Gjc"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B51448ED;
	Thu, 13 Jun 2024 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302095; cv=none; b=JyCZFlhqRkDHNPmhpGq42N3utlOwSTKZF7AujC7hLB3tMkNdz8Yd3YwcpKgC2IwZg93CgIkMGLVG4g4/8zsJbYEzMOa7Vvh0EBCYC6WkYp00aYMkJYMosKb5t+KLjP1+aqnM1XTUin1YyfrPY10GM5fOnSQDMt4alfpWZWxHWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302095; c=relaxed/simple;
	bh=uYStk50JjyKynerLaGefB4sb4G9+Y0ANSK/4qYLoRi4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=u5CAPpWPkjmPXeC4izMrDE/RweMSDhwzLc/MxcNDL5jc9GF7px/ykBaSD/HVPWfcjJIf6Pn1vbc7yjCZGCxmnm9r+Bp2TUjAhk0qdg+aqJVozB5Mniw/5x/nOHJBQsvfmYqEJQ5/JLX8DdNhj9mo/pHz6vvNK79zJ6i/nXL4nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjhf9Gjc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6267778b3aso133433166b.3;
        Thu, 13 Jun 2024 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718302092; x=1718906892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gw4HbQqanrMYHqUcy6MXoBus6RlMuEHtMxxTOpqIgc=;
        b=fjhf9GjcQsvu4CAsORLuYGdKODA+D6cJz5BbKdSA1obFUg1qGe4ggt29UHKWVPUJbw
         L9d9aeGRliSi92N96xLSYIVXVw1oCZmKfcfStbmec/BEedcDmgOnSBbBNRmeIEUxPNqh
         oPN4RRuonqqNNaSs2+IBAWghIYTAvF4gpgg2seZ480JWbubmahq8bdhFNazt5IL9iD+k
         a1Icd07ceDaNk9x1+d3FC75bzJdCRdCVRkM06b2Jx2T372Tv6HLm7FbIbkcSMnqI6dns
         obxQLw32ZRQ3Vz4K4jkZwmvSpBHHmm+xuKUEjNsBNN6G6SVo3dY5TSYnWFoySnAHNmCO
         EyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718302092; x=1718906892;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/gw4HbQqanrMYHqUcy6MXoBus6RlMuEHtMxxTOpqIgc=;
        b=Abb0oKePm9Es9YlxXOCvDjkMkriW2OhYOOY6AYBtL43rn5dFFrl4vvzeyQdd9ZukQ4
         Uwp8VdxWhiu9WcZqUCS6O170S6BZkhfWiE0tprCrE9oGmVQbzQfTpqOd9/3tosgv1qbM
         JkQV0lyA7EIO+k4cbyfJOLbAY13U5+eH6mlhLJdzDnyAqLqFxOpg1MiIaF5FslynqfDd
         1BCDigi1BLVh3nfsiF4jlEXoZJs92X2/nlG5PJGzQT9vX+WnshlY7kFqERYHYWHDyAhe
         Fty9RpXYTHxEaRXnjd6QToIHIp9NMBGg7vHfWlMpr7osrr/bf/CH+cNfEGa5ZrrxiA8I
         w3yA==
X-Forwarded-Encrypted: i=1; AJvYcCWMqfRB/uXe9qVcEKQOqNNhz7DOavUvzbP903GydS9zBAxdL+JzlwxpEHh6uJKskt0UpGLMVWtVkROsluwfI9CdB7aQCcIcO3TRuBEdvHm+R8Y8Gh4FSKxnTVAe+W7yxjJ2kb5RjdcNWg==
X-Gm-Message-State: AOJu0YyljUhtmA+iXgHTES1llPKMJ7GYTFszwkLQ4FR5ZW14Y05k6YDW
	g9k7gO+s1kApR/hpi+krhsKt17BWCGKk5IVn1/0ozut8GhxABkgkRJbtzA==
X-Google-Smtp-Source: AGHT+IEvunQmyXvYIiGNYWK0NZ+Ni4qDh+QbUz7eebrHHd/Em6fFl6x6N5uU1JUQd83Vytuvl1621A==
X-Received: by 2002:a17:906:16ca:b0:a6f:1b5b:2acb with SMTP id a640c23a62f3a-a6f60dc1f3bmr31784866b.59.1718302091633;
        Thu, 13 Jun 2024 11:08:11 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6182sm96247466b.51.2024.06.13.11.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 11:08:11 -0700 (PDT)
Message-ID: <8b229dcc-94e4-4bbc-9efc-9d5ddd694532@gmail.com>
Date: Thu, 13 Jun 2024 20:08:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi
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
so add them to the 'hdmi' node for 'rk3066a.dtsi'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3066a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
index 30139f21de64..15cbd94d7ec0 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
@@ -128,6 +128,7 @@ hdmi: hdmi@10116000 {
 		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
 		power-domains = <&power RK3066_PD_VIO>;
 		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";

 		ports {
--
2.39.2



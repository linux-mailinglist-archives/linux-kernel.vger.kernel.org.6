Return-Path: <linux-kernel+bounces-237965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCED924150
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B9F284404
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF0C1BA88D;
	Tue,  2 Jul 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDU1dIHi"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F13B1BA88C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931868; cv=none; b=WPfcEySHjUfI5NaogRrt+XUOdK5NHP0PqpvNn/eXE0PJOyPp1uoEzbyCHR2L97sKBASTeMXsGDdkNYv3eR0qWMjKR4Aui7EuCOdAXZaKftpD2/PlTv6l8IOTlQsWGzZVjnqadpv5ohbWVzPXyq5COCkse5t/N7rAJMzeeluVP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931868; c=relaxed/simple;
	bh=3JzNfaMqpt1sI3Gin4Nr4nWUwffo/L8DtpcGAkFzLxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQepWpibV7JAaEPrN4wNhSf8cvwnfkfX+N6LzYvxFOu+/+3yyTAFkT3XF18Qaj6OFoEVr9UmCc9UKRz/Ze1bstmocmr84CZ1RGRsMiREgiVKtoxt5g8G16X+6ZVNDZA/loQ2zruajtGb9xxltqCmGgoHcCf3h2IOSa05k1beQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDU1dIHi; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36743a79dceso3106085f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719931865; x=1720536665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKlUNbymqJaT0kOcCn3vFHLPBM9nCKu+xgIgCZM/a5U=;
        b=WDU1dIHiUSGryP68NIF1iM1v1P7tN6x7X8/bc8SA5U6YdtcQ9h84NcFshcxZta9pkw
         dnuKMvDXGU6VmzHw01yLmqOW7Zt7M6PSrKfXlMZJZ/X6HqxFYz8u6EDmzWtw/v0cjc5h
         yEI1Qu0V1H+e/nu/C4T7tQqrnxOPC9aAMjZsThMN9Pch06vry3kNJECLjkVnKFxhpDAm
         HP7F0fA7JXjA+2eUv71ZTBkpRmE5sKTqdSaqgtBsJqZTnvz62wLdoRN6e/6j/syBirai
         cTW+0ZV9NHbKI6u8Z0XAbnngJp57MC62jtdpF8HaBl7UuKrZgM0cl/kqqz16+Paeiy+a
         Cx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931865; x=1720536665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eKlUNbymqJaT0kOcCn3vFHLPBM9nCKu+xgIgCZM/a5U=;
        b=Y6ZJtIHLultzcCjklTtQMOZlDkqL0plm8Bm1YwvoJGHnU0dMIoB8Cs6EyY4h0pap7l
         tuZ1qozjND2kq2bWxmQG67Yc2AaelE1Ct/hb0KOKskr2NM7gpjabmgVrFvDMqirTHsJX
         o40uCFN5Pl162boIJNyEmxPydjlP4JA0bEkHZYP6YkJ8n5QOJfIwn1CNWB0YPFzVatF6
         jfAfEE4lekNgrAjUO+IYMUgGI6Yis4uOx6KBww25YyH6tLf2Yfdf4Vx1YN8t3P+lWXBF
         eZRoQs+dDtCWUn/tZnVwcrA0S5aBO1cTXKyH6awOKahE9Am5J6GXJGAhPpEgQeOPos4c
         fQBg==
X-Forwarded-Encrypted: i=1; AJvYcCU4/I7gGiLBK+mXXefC537+JPk0zep7rzRi9oBQKcOnm0zJrimvuXOjjpZSvpAq/8MWT1Xkt/QiYy2wvtbwl+t1010syjKACi9Zcb69
X-Gm-Message-State: AOJu0YxYd3oW22gWcLYAwKnbiRUucdADndrkcNZjPMHy/ugA3HSoh+ZO
	AIJ7DQQ5ud6Ft39d7FNffhCnJzS1mwxvuvAWqkLlu0qjFLWYs3x1s3V5CUldV/Y=
X-Google-Smtp-Source: AGHT+IE92eVX4dmFvFo8dRtaK3wOWUlw/jSZDiMOkwzi1Kl0xeslgoHpkVbmw79Rots/plOCZ/47Rg==
X-Received: by 2002:a5d:6d8c:0:b0:363:337a:3e0 with SMTP id ffacd0b85a97d-36760a62ecemr12678404f8f.1.1719931865524;
        Tue, 02 Jul 2024 07:51:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3cf90sm199618855e9.5.2024.07.02.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:51:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: mediatek: mt8183-kukui: align thermal node names with bindings
Date: Tue,  2 Jul 2024 16:51:02 +0200
Message-ID: <20240702145102.46953-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings expect thermal zones node name to follow certain pattern.
This fixes dtbs_check warning:

  mt8183-kukui-jacuzzi-burnet.dtb: thermal-zones: 'tboard1', 'tboard2'
    do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6345e969efae..3aea2643f21c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -974,13 +974,13 @@ &ssusb {
 };
 
 &thermal_zones {
-	tboard1 {
+	tboard1-thermal {
 		polling-delay = <1000>; /* milliseconds */
 		polling-delay-passive = <0>; /* milliseconds */
 		thermal-sensors = <&tboard_thermistor1>;
 	};
 
-	tboard2 {
+	tboard2-thermal {
 		polling-delay = <1000>; /* milliseconds */
 		polling-delay-passive = <0>; /* milliseconds */
 		thermal-sensors = <&tboard_thermistor2>;
-- 
2.43.0



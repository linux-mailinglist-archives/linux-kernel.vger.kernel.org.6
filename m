Return-Path: <linux-kernel+bounces-437365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D5D9E9249
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05948164365
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46B321E086;
	Mon,  9 Dec 2024 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyoGv5+T"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2D21B8EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743770; cv=none; b=Vc5izNFymzK1YkpgisBA8yR4YGmLutyFiur/6JeJNFSA2VdM3ZxBjYwStxXU5cC/K6WbOu3TD9mWptI0SbZQN+kOtHnNYro7yyvNkoghTCyPEBM5MbEjypIrFpUd+SrgrxVTfSLf1C+Ob2wDV3saP27ElT6XDdwzja0JKtDuZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743770; c=relaxed/simple;
	bh=q9UzK737UNSpv0in/GRb9dREm01JbWxa3EvvcBVr0OU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJPa5+APzI1XzLCoZRVPpCkUAKkdcGtqShnR6gilbtmBipIdW/kceFM7HQAR6XHABpQiQcxjq+mw9hWMNGHck8Uli35MCX8fMr5dcSnNQPJKIALEP+WV3oJdToeyxijHsnWcd/fM25i0Y0kVckzaDrwOQ9ZRpMttzK9mfB2RYuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PyoGv5+T; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3cfa1da14so209295a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733743764; x=1734348564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaKRkQ++zE9MSO9ISV6gYj3UsACoYvIwFoqWZLd5Wt8=;
        b=PyoGv5+TK6C/rNw2t5XT2pf9d5fCDBPUZnKSg5j4N6uyZgH2AAwxpKOzV6St+QjkLT
         yamVmz7VPGhB6vVJxKjjz6uc8o4J0Zh96l7Axf2Ahx/q8TmLf0/jK2Wqgy+mDKexHLZc
         AznXAUcxfiiCITaEh8zvBoeRft5jdatQSAqJTRgMhBl+rH1v3PO5mnew3P6zvtQzQEvM
         hu51yrjOCMR1SPnJASiUz3vUh+Eh3iTQIJYqnfeHywU8H4B+h8EslftFnh6AS3yWKsLg
         iITwjQ3MOKAzqanoVswmbmiYfW07HThdhTsF7DwM8EeKpezoGsYINLri/uBPrlEHN7+4
         wxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743764; x=1734348564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaKRkQ++zE9MSO9ISV6gYj3UsACoYvIwFoqWZLd5Wt8=;
        b=k8cIW1MeIE8WgaEYyAVLTxrV3EDhlmyYmfr4hDQ4KPZAgUe5keCTOXknPXjtSj6r2p
         ziy6denXoxUetogW57/kjHGyr9eQfnxG6hJ18fzrQziL43VA+AAcmBF9NgVXNDkx8y7K
         ebxnwn3DEnvKYFURCVQ3DDfWRLP49/fiWN3x2QDppBjlHWehMj/tXSBGQ4oUlKP797HG
         xEzjGyAdyBuAkAkBt+L2ISXhWcJqdrn6eV+J5a9p/OF0sG8Yuj3RtZKHfQuhGfrse6/B
         cROaI4ebiItpJEldffaxsQrjmYmCgjhPDYfSacdZmZSn0rcrNf+kFwDD1LJKsGelfePe
         ocOg==
X-Forwarded-Encrypted: i=1; AJvYcCWIlWKLgAS41yQgfv3i3vajUNCiSkPBX7hm0UjbpV8k78YBs5aVeye5QvthxSM0e4nQ8mr23C78+Uur2qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6YAnVNF4OGv1koLzlQ6CKGTdPQa4mm3AFai2LqHx2l3cM55g
	KbQ0EuVKKnyi/1Pl8pj4pCyBOjpxWhmBWmI68Hq7SDsWPu6ccU0ztHmwWG20NJ0=
X-Gm-Gg: ASbGncsYB5Kg7KEwVujBaagTYMD4SwkBC2ZruSmYvPW8DQV8GcOn5xtvwMFmUc+SEiS
	7YYTPizZKoSETyLrw4xnZojq+iWP36QpBnzsaB74dX+V6fQxHhbmIlNVE1Khr5N1ThwAzenfR74
	tjUJAz44HM4IuVcNEpovBy5SIcYrkQ9aPDqC86nBC+i87wsxiM5IvHeR2rpCoB5SZ734f03DkKr
	97hMJqNk8DzIkwxlPwLyrcWwKTELZTCMZOe1B0ZOdfqPE0AORCViHtu4t1EZigc91SX
X-Google-Smtp-Source: AGHT+IEnfZKzpVPLUq5YoVunalUaONsSympM3QhF2go/NVblXkK0DCFFX68Kg5WtSW1gpOjQLKqhQA==
X-Received: by 2002:a05:6402:43cc:b0:5d3:efcf:f163 with SMTP id 4fb4d7f45d1cf-5d3efcff680mr1894926a12.11.1733743764583;
        Mon, 09 Dec 2024 03:29:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c7aaa09sm5976741a12.80.2024.12.09.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:29:23 -0800 (PST)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [RESEND PATCH] arm64: dts: mediatek: mt8183-kukui: align thermal node names with bindings
Date: Mon,  9 Dec 2024 12:29:20 +0100
Message-ID: <20241209112920.70060-1-krzysztof.kozlowski@linaro.org>
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

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Sent in July, then Chen-Yu pinged in October. Can you apply it?
https://lore.kernel.org/all/CAGXv+5HSZfr14K1sGky4g9Sik987DAisH7KTZn9v_svOwF+y6A@mail.gmail.com/
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 4b974bb781b1..2828f34949ae 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -944,13 +944,13 @@ &ssusb {
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



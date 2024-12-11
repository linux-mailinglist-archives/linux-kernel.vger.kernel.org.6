Return-Path: <linux-kernel+bounces-440790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF369EC443
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045F6188B24E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536171C3034;
	Wed, 11 Dec 2024 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IhdDvf8Q"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F11C5F10
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894695; cv=none; b=jKd/uhNSg7KOVg7p+N9QNRQ7DVRTbtpWwiPYb95VLIPQraRghcZYO/wdZ+tW/OPSKRCY47tEXL1CsKMtnDoMI9iiRrpIGtSjjCi6IYOmb2JVt8bZQ1lJMNKFMq2JR1UVDpkU0iG78QvNx7BMc2PMDbaDQOZh+ooseya4/698MgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894695; c=relaxed/simple;
	bh=OTrtEBMh6OCD9cHCDcG1ayyCh76uO5tXuzJHSXzWcs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bW3W5pnyGctg1rKJBAR4d4lvIi88HyDdxDyuFPy6YKlaesxTuIyLM2/OwZ/N38NQzU6HmM9K5RnLp+UrxhMZR37hWz18ickVsxXQg3DI//O4cA8khi5mSllnnB7gfkGSF5h6TztHMssSKEcRKnDcREEa4FNXRj7vaNgw5vYY+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IhdDvf8Q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so4926198a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733894693; x=1734499493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToTdfUFmfxqqBVuM594sv5/lAPTiIQZKFHPkEQ17A1c=;
        b=IhdDvf8QRliKFAfdbP4v9OLzZ9IU6+0u4glF2byqcUwykAeGoR0J9NGLqWfuIFtOwp
         4qcF3P8FZa+1RXRUQTUpwLHUnJKYT0yT6jXx2SiOJjhVm8PjX/0U+caPVlalJPqn4enW
         S7UuH+tnBEsS99im193J/Bt0i4L/TGauW4AOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733894693; x=1734499493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ToTdfUFmfxqqBVuM594sv5/lAPTiIQZKFHPkEQ17A1c=;
        b=Px+VUzayv20gaYbLxifzDFNW24aeRQ99oNLySdBi+ibNEKPTEbUJuKrH0e+x704UV8
         KCjAZYobw8oXWmcgqLG/VsPqwq8yu0clhTu+FlnRbgKrp5vOdCnj3JoU2FBmQhVP3O86
         PVoRSy2Hmy2LGqzJY7UyisEGfsYI5xC9xXUxCV1Tj6JZgMDjs+qLhIPtTWCI5Bwvx5N9
         N82o9JNUw9eBbK+eF58xXyC3l9ojDUqSOUszF7hYg8wktJEJA8UsNUcfXSbxh94OP0zV
         uyELiX0v457/FgSjIbzrzJ/wUhLZJWhXfuJIszz6ja5u9K8FBX1YEWpRZHGWcysouAqV
         k9lg==
X-Forwarded-Encrypted: i=1; AJvYcCVKqkXyw6KnIDCNDzef/DFZA4xYPSTnma+EIJjHenUG1gFdbrum7iHs8mPTYHBAvdVQuVCdpdvGYOeZoe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4Z69HogzSgBu89ieqsXbwijmgF8OdJe4V2C7C1Z5+jMdDwbq
	U52UgIkBAmpT38Gc0xTr/1XikS5uC3N6f011RyYFc3243+Hp82nTKA0tcRljmQ==
X-Gm-Gg: ASbGnctfaUrlZLXt83C72+fvMU383WP/lVHjMC+zt+zLoLWgcV+vmYx1+WmUc2Gfk/q
	D1Lng9dWya09YpZBHYqp7ak6mYucT+8KdA7F3heSKrACkQxkFp6jzOotktfHO6rXJ8Ks9QuBpUL
	9+DnCKlTR0lzYK7r+0Ynp17xTsS06MbMd6uohHe/98glQsnSyBRu6vzI5He8dve5K2lkBXnwMhI
	XPZHEpH4T6wW6DrrApt9CLmYTG6F3YfB5lMO/Pbvc8lYqaSnoa5skZdk2F7+Q2fvq5J/j3f
X-Google-Smtp-Source: AGHT+IGlSrx9j4anjyHnvyNo1U+TCm1tsOqFjYIOo+mjUoxzwUz0kLYufreA4nXpiCewnzAxgBLNnA==
X-Received: by 2002:a05:6a21:99a0:b0:1e1:a06b:375a with SMTP id adf61e73a8af0-1e1c1380cd4mr2924903637.35.1733894692966;
        Tue, 10 Dec 2024 21:24:52 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:4dfb:c0ae:6c93:d01e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e66801e2sm5397702b3a.160.2024.12.10.21.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 21:24:52 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: medaitek: mt8395-nio-12l: Drop regulator-compatible property
Date: Wed, 11 Dec 2024 13:24:25 +0800
Message-ID: <20241211052427.4178367-8-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241211052427.4178367-1-wenst@chromium.org>
References: <20241211052427.4178367-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "regulator-compatible" property has been deprecated since 2012 in
commit 13511def87b9 ("regulator: deprecate regulator-compatible DT
property"), which is so old it's not even mentioned in the converted
regulator bindings YAML file. It should not have been used for new
submissions such as the MT6315.

Drop the "regulator-compatible" property from the board dts. The
property values are the same as the node name, so everything should
continue to work.

Fixes: 96564b1e2ea4 ("arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
index 14ec970c4e49..41dc34837b02 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts
@@ -812,7 +812,6 @@ mt6315_6: pmic@6 {
 
 		regulators {
 			mt6315_6_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vbcpu";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1193750>;
@@ -829,7 +828,6 @@ mt6315_7: pmic@7 {
 
 		regulators {
 			mt6315_7_vbuck1: vbuck1 {
-				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1193750>;
-- 
2.47.0.338.g60cca15819-goog



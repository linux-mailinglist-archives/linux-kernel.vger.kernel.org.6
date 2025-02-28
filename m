Return-Path: <linux-kernel+bounces-537762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2553A4904E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E503188D73A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8D1A840D;
	Fri, 28 Feb 2025 04:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQO+5uUx"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB21B040E;
	Fri, 28 Feb 2025 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716773; cv=none; b=exPlJelk0YaWLesW8/ly8okLgWXP4/zCvAorghaptoC+JyuJh8sHVL8pBUZ4/3A0Os55Sb2PSaj+DSW0MIUpXiL9BDK8H9urR9J0Oh9TScR49o/eVPhgttQWxj0Waf2SNVwMDkC3/c9r08aoArWN2DVG2BQ4qxr5pKDEH/p/DCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716773; c=relaxed/simple;
	bh=3G32KGPWtAlTMVeEh2nFd9QMJAqTbBI6LKbnc/7mszk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwdMh9nFVZ11VXcf4HUP9Ue09jjZzxG7dD/OYMqOK/mB9daDqFFdA+sVIt+50pjX+6GNgtwuk/zZ2wBVg/6BUzEhPk9YETdMTtDXa157B3y8DFryY9uGweHE+fH9a1ZZD68Wb0gcp72Py0zIiksnROGU4i0LDMOOmHQHR1uK5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQO+5uUx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22334203781so41628015ad.0;
        Thu, 27 Feb 2025 20:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740716771; x=1741321571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unB38tK/OXEn7+tTxdPa8sEeBESGQmaxRAo5u3OkTcU=;
        b=jQO+5uUxcj3bsAEg5B8XFTbGaSftdo2onUHUEcbgPY4AWegDq0sjspbQJVi6te7HeF
         lXl7l3jHgBjMbOcbLgYe07esW0pVvn+9gkuyB3i3+gLLNgM0x4F5o8mMPUus9hlf4iHj
         EQjCyEmndie9u0ZfIPvViCez5KklNVQ1CtURU5DMo/Qg32rRqX76/GUoIwvTBRIbJwcB
         XvcRq6alqyANo2AV1eExmo0sF2wseCU7f9cY73EfuQvxzm3RLKi9m1mOZ8ZvXUwrav99
         5pKWkd+OxrK1IIFpIwpeWnJXmy1kmNjRBwZc3wPEkMYAoO5gFwhmRKujGMweO8JYxPYp
         Bz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716771; x=1741321571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unB38tK/OXEn7+tTxdPa8sEeBESGQmaxRAo5u3OkTcU=;
        b=uB1jA6grVaWLxcsjMf4ASQDqr9TGgk9cYOb2Er+x+X8JH1pU9Yv6JzrEG0+8B6KPnY
         ffLy1Rmq0ZUGs66wnKbw9S0KLv3DCXN02mbDclQkOzz+vVlU+EOP7XM7MwjUyPrcbD3m
         2rlONmNyzFDy8l5fsbkqgfVZ3shdXEwcINd+QhIHrQ85t6Z5Rsc//hbBmkYJkfBW+/d0
         dCKfhYmwd56JVVcIXflIu40xRosrwDidXatREtH6oGxI1uM85Dxd7pqCvbIlAUoKxJgj
         rlPVi/iwuORA+mOyu/YtVaopqxOnahCjEzkmt47WpBgJ6C43Ga7M5P9x4WNa9/thbvqF
         YIEw==
X-Forwarded-Encrypted: i=1; AJvYcCVUEhD1A2kuFVzk65Uk3J/9D0HGP7hZi/1LR9l6x8xFDPMWYtDqf6UwdTnc4mVmuexRZS1dn+O7PjZw40p8@vger.kernel.org, AJvYcCXlOraeWczf1/Sxcpx5S4KniVNhWOAcgJcEU9omUkq5OU+8IEID7y+iAzpOPnoqwOjYgVcwOSTL0NRS@vger.kernel.org
X-Gm-Message-State: AOJu0YxABFaColYQdIwfZCXdiK3ydwYo5bdzQRR8UNaOzj5ZaRqAvTz8
	ME74yK8f9gMEdudtN+0IbQXFuMABnTvFjas7+UG5UGhW7hQXy/4V
X-Gm-Gg: ASbGncupGWQ4uvb9DC2MacCPq/PkDfySiwvT37j+Z4n6SmCWNe8Z+cm2+NbJsCwLuyu
	yhr/uMDpqLQWv/AdhqeO43a0hF8PWzXMuaKf3SUAPfVhjxtQowsIfzU3En56eOc6EdgjZ2WVsD4
	ISvqNeAnbcdN+ilHGg/AAtpykimFx1A7ER2FdPpJ8KGiyVMipottYIXs626WFi3EI8iTfgYAFdp
	ajPL9KBEc/WwCB7u6PBA5bLqf+zX9LD8qUKYeedRhgXIIqU+0YY9SzzJIfXHDMakMcR7F7x97Tc
	csw2nCVttjxgxqK4MNlU65a4qQ==
X-Google-Smtp-Source: AGHT+IGtmQbdyfEwfeBhk6WSmYrLAOp0IoV4HAJOcN/bRjv63mAj9b0G7a2Jab/56/ebMWJ1KgLJIA==
X-Received: by 2002:a05:6a00:4c8e:b0:725:f1e9:5334 with SMTP id d2e1a72fcca58-7349d2f3d9emr11980732b3a.8.1740716771005;
        Thu, 27 Feb 2025 20:26:11 -0800 (PST)
Received: from [127.0.1.1] ([49.130.82.63])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dd19sm2738318b3a.131.2025.02.27.20.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:26:10 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Fri, 28 Feb 2025 12:25:34 +0800
Subject: [PATCH v2 3/5] arm64: dts: apple: s800-0-3: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-dwi-dt-v2-3-4243fe8647a4@gmail.com>
References: <20250228-dwi-dt-v2-0-4243fe8647a4@gmail.com>
In-Reply-To: <20250228-dwi-dt-v2-0-4243fe8647a4@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=3G32KGPWtAlTMVeEh2nFd9QMJAqTbBI6LKbnc/7mszk=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTrQ6B830j95Oaa2PfNNLQHTfwWsbYuH9Ingq
 4BzjP+wPs2JAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E60AAKCRABygi3psUI
 JAoiD/99DcQPTKCtLKCyntFf0CEhJfzKeDiiSPEmtdNYXNQnTApnskUoUjwDGyT34wShAW/Jfm6
 4OyKEdK+a2SpFyR7zMBI8Js8fTTDTuUvvLG+m+g4iYDohNXqW/iB725Bjqc0IHN0Pt8xk08fHu8
 lDP9PQKDq3NRj4cleRUkgCOr5ZTJ+c47xNGjNJ33weHToGdEVHH51bqVQClb+G5+o9q4ndiCm6q
 4DdtI6xZy/493Gka3iw78EJ+xS9r2JT+FvGG9b8N9auFwM1sPx64fLUMoSF5JbBlBdO1m2HYxJk
 +KIDaJCWL/ayODMRVBTGiVXgMoXM7uGgkh3gR3QsIOu+NiHufd9yAhxA9k3ABgSqBCg64cCTp76
 IDzLSMYDRQYMUfd1N9Fa7MyVXBRIwEfdyNs3EAFpkl8BJZjsVpmg41zL7ET0SDzh4B5G4uByrhZ
 L5EesJUN4Egr9qLQtqKTWuiK11rutpzzgHbOo4RTNY5ZoHkG4iNaIqEBjF3Mshklhv60k7YUrIb
 ILvINDBoWzm9BiO/Gdk7mCIu0i01lQK01J5JktmLFNBgho2ZRnNmbb6dvMEW9sPnPRCQjQ0Xwj2
 daSoOrUSOkzJwKIvleRg29x/gZhGZZRsPVirdFRDgMKcYM1ZQEc3XUPb23A2NHQq6p8UbgUja9p
 fGgeEniyD6GmLDw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A9 SoC, and enable it for:

- iPhone 6
- iPhone 6s
- iPhone SE
- iPad 5

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi b/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
index 4276bd890e81b16f19b04e1716a55f32f9a371d9..cb42c5f2c1b6caed4ae04ca0b6173e23bbda47f0 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
@@ -43,6 +43,10 @@ reserved-memory {
 	};
 };
 
+&dwi_bl {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index 2aec49f0da6467519aeb2561d00b14f46fe216fb..c0e9ae45627c8150bc0ddcdc1e6ab65d52fa7219 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -91,6 +91,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200080 {
+			compatible = "apple,s8000-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x0e200080 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl_ap: pinctrl@20f100000 {
 			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0f100000 0x0 0x100000>;

-- 
2.48.1



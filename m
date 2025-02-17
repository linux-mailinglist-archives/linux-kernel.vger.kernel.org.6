Return-Path: <linux-kernel+bounces-517037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59025A37B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122F67A25BE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293818F2EA;
	Mon, 17 Feb 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXSCRwtG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200214A4C6;
	Mon, 17 Feb 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772630; cv=none; b=i/e2D1oFMu+5fodtNtsqM2kCbRlgG1bgm73HEWs+Ssibjh+Vdvf5P6Car/M50kXKetmyK6MkslklbTt+o9pmY1pIrgewIegyRayLt0T0Pz233b8VvbEk5ADsBMKgiSrGlt4b3C2jHRiafl+5tx0DeOolq/Jt4BsTT8iaEEqGnK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772630; c=relaxed/simple;
	bh=CrIuLPMpgJln1b65h2U3ovn7OZsssqG71Lr6yC+n20s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NKRKT3z2RNEHzPC3PED0ZXTwVrc/eSiaZRglaBR66Mi/vaYfft86vMLhClaEhQ3ix7VNgF2RIDq0kfUbjSDxgzBmybeAn1fRDRy4WfRsPig9UavFF3mGvcK9X0tqNpaDrR4KZ9ybfgWSsOHyNs01fZXg4QFlEyVznSD8jIAP4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXSCRwtG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso100505965ad.0;
        Sun, 16 Feb 2025 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739772628; x=1740377428; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pUbnlIaFpXwj2FnC9KQKdRLGokSGMi945pdWEyQAOU=;
        b=QXSCRwtGNj1LOhGIQJCHjoFQIRb5KvUyT4XKbC5d2uU8RnSJsjaxWiY5A/Ay4qTkqs
         /CED0WQZ9Gz8XdNnSYp/FbiCi43gj70LqJgmzXftXiVFowRJ4SU6E8wsXRo6oOiyWKNP
         13NxSxBuSqCIOSmSEtP8NSxNmj+ucwlDC2ZtqoJAtX2E+sJDgqhZE5cTCN76lMXJPusM
         qEW6vsms4wM/KLmss86v7m48pMiEyOPv92UYS5rt42QrIOmLOsG2fSY6awXpv64t1s9l
         1OfrtyqZ9h0J4D0oTrQ2JbCzumGsnK9TDRqW5DV0HmiiMGvGAGwPdzk6n6oT8hvHmN49
         jG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739772628; x=1740377428;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pUbnlIaFpXwj2FnC9KQKdRLGokSGMi945pdWEyQAOU=;
        b=Y7/q+t0sPb4OlDAIFGR6kehzDxtlT9624MbHrb4EXgX5tgbBJXzxBMwi4SgB3XLoff
         suKJdUxRFTbeln3OLQP6sicO9mfZG0CRZuo0YLt7VopEFPpBXsdycdKe+2SKYuaUu+Dz
         Vi7Io5saCJyT44lzOd/Q9d1+89DPLPxze/ORui1+72UiDixyF/vMmL/yU7RzHNec/xjZ
         oaBe9ujKcozTJMHvTN/yn7f9aVHeZTD2l0mTRiZqxoK7lH6Fi3JCePl3jbwhaTHcVtqu
         7ia46tVJ9XXuS0JjNQTkRHe/3M0r5a8tCixukiEJB2/t7uHf4QpEqxm+y4ErPePaQ0Ic
         oS/g==
X-Forwarded-Encrypted: i=1; AJvYcCU5XR8rdjYeH/KNti6yL660N2Gq5nI7OCpEYCHojyNKbaRzVe4oux0jeWDMStQ+p760jogQNmuAQtXuTmcN@vger.kernel.org, AJvYcCU8JkEz+V+6JJC5oeU7jY19fr6s5o/SR28J3zUUHDFs+mhqV0kdt9BHJFOvD5aV9Q8VhelZ+3as8T17@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwa4seCD3wwbAK1XTcMA7W5ZyEdSf+vcV8Fa/mMP7T71lEU9x3
	tBwE9NFwAo8F7LSw71pnqZkHc1sW2yrtMR+49oAttsLQ9dCRfjY0
X-Gm-Gg: ASbGnctEkGabofdSXi1Sy6p668UflvAJHlNZLmLqI0qXibDnsT0WrDb8SB4hRihqvIY
	0c2JFGGcErjJ2uYeIDC+IZyFUnE0t6IYSli2CI8e9ox2LNAamM2E2yOKkQhrRuY8LuD7hs5JrFt
	zeZvPo1G9/Bj/Hhjtl+/NoVZRieCSymqcJZ5Mg9fHYbSy3m4B8K1ZwVLitN8L+3CWSCIck5ozPf
	4MCsbzqk0/j01OwTmppRoTMNh100uCI+kwWzWGa9usiEHZbgv56ydVVRqzSmShR8jxO6pfVhbSz
	p14U5WOQU9eQLlWnvQ==
X-Google-Smtp-Source: AGHT+IEP/BxIfU7rsnxdSBvVts0xAblW8C+YTQavZsFPW0gEu8GetnOdrXN3b4iJF+M3Wd3LdxRhGw==
X-Received: by 2002:a17:903:240b:b0:216:3c36:69a7 with SMTP id d9443c01a7336-221040bdbefmr126914955ad.45.1739772628094;
        Sun, 16 Feb 2025 22:10:28 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d559614dsm64411795ad.256.2025.02.16.22.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:10:27 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 17 Feb 2025 14:10:05 +0800
Subject: [PATCH asahi-soc/dt] arm64: dts: apple: t7000: Add missing CPU
 p-state 7 for J96 and J97
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mini4-cpufreq-v1-1-8974e90dd806@gmail.com>
X-B4-Tracking: v=1; b=H4sIALzSsmcC/x3MOw6EMAwA0asg12tBwmdZroIoosQBFxsgBoSEu
 DsR5StmLhCKTAJddkGkg4XnkKA+GdjJhJGQXTLoQteFVl/8c+AK7bL7SCt611j1K6umVi2kZon
 k+Xx/PRgxE6PMNncbDPf9ABnQ8cJtAAAA
X-Change-ID: 20250217-mini4-cpufreq-fd6c19346518
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=CrIuLPMpgJln1b65h2U3ovn7OZsssqG71Lr6yC+n20s=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnstLQi0lqAMVlCeQaVyeJCczo/BDvZTB7TtJJL
 U0OzcAix9GJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7LS0AAKCRABygi3psUI
 JK6LD/wLOjw9QUSMfzkPdvScw4BayFO1s3XlFg9mn7p2X3CgI+q65LpwMpolEcUK+tGk5PI80fU
 5qzO3YX2nj5octVIGyiZOGlu4WFugsfVqC625tzy4PjSAG7kriuVdkG6dE583nlIRGvECaTyB3U
 UP1je8BCtMVGA05El+/mAdq5n9ZYpmlJz6to+OeWWq+230qovTrKYnreAYjgV2l5zLqQb8lUH+1
 8ljoCwi54eqgOzY7qvs3xlx34VNIxmxx8SBDOWRbuu4oGEJsxlTP41edIGxL82vgjTnmEFVVMTH
 lBNF5ZDc5DlFle5WaaPbkqEUqSdRS57zv6FB6mexeuWXPVd/Q9eR6/Rf/omxdZCob6lKaIz5agT
 6cQKeu0amy3Mawww1G8mZtiU659aIZHJH3wtpjpi3Ckl3kaM/nktXeIS+z3z6vuAmIacGQzdWvB
 r+NDps/RepRzW/3SCT41riRHDIVWLsAH6C+IfVun4C6fo09ypMAwxSNKnf+MDITvDke/P4RKhrq
 MVIAnUjLsBHZAF5tlK/j1Emomp0Gw/MZUc1Fed5gaaPfey1MGUfK98C4vz7lN8JvsyQa4njF8sq
 7a4UaCWlDytYMXrZ0MSzDC+UsicQXbF3V2GGWtBhT8k8ukWFTHWRblZ0ezOW9E4pZdyU8HXAS/l
 6HsT7FIpygtDj7w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add missing CPU p-state 7 @ 1512 MHz for iPad mini 4.

Fixes: e97323994f4a ("arm64: dts: apple: t7000: Add cpufreq nodes")
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Note, some sources state that Apple TV HD has 1512 MHz A8 too, but that
is incorrect, the maximum frequency on Apple TV HD as configured by iBoot
is 1392 MHz.
---
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/t7000.dtsi       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t7000-mini4.dtsi b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
index 6da15d15601bcd553d6d0e3fda93df4685b57ee1..cc235c5a0c438f3f07ce5318a75dd928615b7818 100644
--- a/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000-mini4.dtsi
@@ -57,3 +57,7 @@ &framebuffer0 {
 &typhoon_opp06 {
 	status = "okay";
 };
+
+&typhoon_opp07 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t7000.dtsi b/arch/arm64/boot/dts/apple/t7000.dtsi
index d4b479ccfe8c9309b8de6c23f1e90000ad287992..32cac8c30e62d657079dbf32aece8af0fd9cef38 100644
--- a/arch/arm64/boot/dts/apple/t7000.dtsi
+++ b/arch/arm64/boot/dts/apple/t7000.dtsi
@@ -84,6 +84,12 @@ typhoon_opp06: opp06 {
 			clock-latency-ns = <42000>;
 			status = "disabled"; /* Not available on N102 */
 		};
+		typhoon_opp07: opp07 {
+			opp-hz = /bits/ 64 <1512000000>;
+			opp-level = <7>;
+			clock-latency-ns = <49000>;
+			status = "disabled"; /* J96 and J97 only */
+		};
 	};
 
 	soc {

---
base-commit: ca96d759d8d24d90b1726c2cc7c568ff4728bb42
change-id: 20250217-mini4-cpufreq-fd6c19346518

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>



Return-Path: <linux-kernel+bounces-560938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13514A60B39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A107167580
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077461C8605;
	Fri, 14 Mar 2025 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ABVU3d7P"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C51C84C5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940490; cv=none; b=YOY1DP20F/roWekNvQKdudzyCkmUeLmHZGUd+FnKCA+ymfwzCuaBIsVZf9cE6EbCkBmcqf3o1S5M8nYhRrK3uVjlb741LvO6LRqm/34AA6mf6+zIbLHwKoAPSzA/eBZ+NV8ATv/j1EfRmAXm28PLtcB31NXzbejoxErAWHCINq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940490; c=relaxed/simple;
	bh=mppd4LmheDALrusB9T4PJj9qjgXGvLPRSBiVOVkjTwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n0ouqw2KN/LqVF5ywUdimYzRli+ftIQVDRCPOy4h2LVMU46x2+0f0I/aivUcAApaibsIGkijCpJdB6UQmvMRcS5h1v/+tjUn9H4KbRlwWauS8lxFUxSIZG/WMQ/Xti9FvJkwHdq+udgAvsBqYh2I5Uqlv5zWnCRbpb8OHtR8SZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ABVU3d7P; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so2802971a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741940487; x=1742545287; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+NVtuVU2ISJtStqxHLi/aMeg5kRvIk3MtAqB/jXcng=;
        b=ABVU3d7P8JpvvrdxbtwdJZqVgs18QiWje9f/moFUNBBMp8qXej9XFyb+bJIfhWcRuV
         Ni4LyhVUYt6O062qf3Wa+d3iDLh3AAsGhBSb9hEJHi8GtykfW2MzuRREe3t86+PzwrSF
         sBdQl+5p/E/owPbn9ds+F8JMpbqS0vG1C4SzfB/ppDB0+wqro8hJ1I6PuFYG7Ib2DLWB
         xbuT4w4C5XXhobcT4jTpNaZ/MdCa6cf1XgK/V1gxCHKddIldcJU2tyFFywKR21PLADyG
         U72WgOxx8q7cziSLU3R/LL/pQmf6H36fUy67Ajw9m7nA8yUwHGgbnh+t78AuY8S/wEAi
         PeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940487; x=1742545287;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+NVtuVU2ISJtStqxHLi/aMeg5kRvIk3MtAqB/jXcng=;
        b=fMB/AGLbBr8ELHy9svbGLKlBBcbPA2Y2tRABNQYCkQau7uYHz5tJzNl2Ib94xiDdEA
         R9f0tMixqHCpBLhZX5QxcoS+NH9a8D+BKrYbd+pfkY5AEweUDHn0y+TjEhmOGW8iOpJJ
         eIKTh8xlX0UZIefxwSL6+SgQ/w/ByF4y9HA86NGeZinlMXZJ5g/0KqgIgKmhqcw4/c8z
         1Ioa8ilXOUtIfQl4jEukkT5VO/uvoLYO8P2DfXzzK9mz9qhrs+M06W75GllHcKLzjExY
         MR2tk3X1uOEdeVhxho55DkabxL9RxTGI4121iyznk4uZx2T5t9vzWW7L5D3+97VTjDLq
         T0oA==
X-Forwarded-Encrypted: i=1; AJvYcCXREzKIcNthXdjBiH7r9sF3FDyFzTVIgSZzdAzDexntMbRZgnXOhEameiExi60GdLJcuJFm33IyN3ejh6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBfxeG3R7Twa52ER6iOfsC9euzIYX6ruph9fwy8pryoD37XGyI
	i4h6I7G9aOPmOlHR6Tlr2joaPKtpaRcTy8gXm4/r6mOf/+UQhM7dU5x+OcnV2vs=
X-Gm-Gg: ASbGncvmSTxQVuvIMVz4v8RF7xSNjyRmco9VCn0Fir8r9xf5rclE4dwpJV+cAs5dZGT
	8L0FTxt1/R/HUAwcCbbVqkKukeskqA1BgcbNkijiuJ/jkcWDM003+UCS2o4S3N11LE2j3djUceH
	KmGMxkZX/bbO9KWaTNR+AcfEuqM62UnsrkFuEd4IzkK6MKnr7zI00ZbFJLMg5EZc75MPd2g4VBD
	P5xl2YQHopqNxMKFW60VG3hgFcRCjinWY5SkLt6eM7wa7MahsSPkDT/KYV5kU10/HK+EdAEMsfK
	q2CXSDaSdHeKPZYbc4PNb5v6bMqd/DMyVBH3svljyVegOV0hOAU9hrX0qUqDN7erkMUYecRoTsJ
	swwyyJKCdyv+wSL1UVA==
X-Google-Smtp-Source: AGHT+IE6U7GmQ58fz7zI6ECFfeW+9X4eiOa30l8vgfN5EOFVNew13LY0sJrmHqQgR2MvZBZ6zRu3qg==
X-Received: by 2002:a05:6402:1d53:b0:5e6:6407:3b23 with SMTP id 4fb4d7f45d1cf-5e8a0422028mr1472473a12.21.1741940486720;
        Fri, 14 Mar 2025 01:21:26 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad38fesm1643387a12.57.2025.03.14.01.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:21:26 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Mar 2025 09:21:16 +0100
Subject: [PATCH] arm64: dts: qcom: sm8650: Fix domain-idle-state for CPU2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sm8650-cpu2-sleep-v1-1-31d5c7c87a5d@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAPvm02cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MT3eJcCzNTA93kglIj3eKc1NQCXQNTi+SkVGMLkzTzVCWgvoKi1LT
 MCrCZ0bG1tQABYppDYwAAAA==
X-Change-ID: 20250314-sm8650-cpu2-sleep-058cbe384f7e
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

On SM8650 the CPUs 0-1 are "silver" (Cortex-A520), CPU 2-6 are "gold"
(Cortex-A720) and CPU 7 is "gold-plus" (Cortex-X4).

So reference the correct "gold" idle-state for CPU core 2.

Fixes: d2350377997f ("arm64: dts: qcom: add initial SM8650 dtsi")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 719ad437756a499cee4170abccc83f2047f0f747..5844d7d0d0e6b31c08de3391f5cae3f8d823b2cd 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -1449,7 +1449,7 @@ cpu_pd1: power-domain-cpu1 {
 		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
 			power-domains = <&cluster_pd>;
-			domain-idle-states = <&silver_cpu_sleep_0>;
+			domain-idle-states = <&gold_cpu_sleep_0>;
 		};
 
 		cpu_pd3: power-domain-cpu3 {

---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20250314-sm8650-cpu2-sleep-058cbe384f7e

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>



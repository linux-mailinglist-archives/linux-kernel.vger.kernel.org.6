Return-Path: <linux-kernel+bounces-383370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C49B1ABD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A191F21351
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84CC1D63EF;
	Sat, 26 Oct 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjP0uJwT"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403920326;
	Sat, 26 Oct 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729974513; cv=none; b=u5Uk2TLXzcJKCkBqCOpWXzY0Agc2vXmAWKRGR5e/GbPb+0PUShG4B8p3UegMZGBPgyK85rm/8xNK/FtF0z/vLWWEgvJPDlORw80uXhY1G/6D2oo58FOaV3Ixwmx8augT9L0IpJz4L4d169V54bZVkm/Js7n08IjrV8PfH6vstjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729974513; c=relaxed/simple;
	bh=Ctuv+X/u4Q3Y6JaiCMyXRkwH6JLPkazQ4p5Gw8ErVTs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HNp60tLGp2BA5m8KaAlxA866I5I0miv9Hl7JNvTMCR+Ondu+Alqz1bSMlTrt0kBdi6EQeiPV2meRy8rBVumuZtCOvvNZt2trO47mqtnEdwUzh+UpeFltJCEF9moPwL3uYzKhAdJhk458CPN3zWpxo7230Crc+QgPOuEdtl4wkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjP0uJwT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb51f39394so30727041fa.2;
        Sat, 26 Oct 2024 13:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729974509; x=1730579309; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNNg7zzXFJSGsARqfxEpGo4FAbXgJfDgVsYkeL3nKao=;
        b=IjP0uJwTbz1cRLMcdrlVM8aKv1aFKkUQUkVJG5hnT5N56pTKFXTAgRXc0IMlCBt0Fp
         VkSqW8Eo9Af86BvAcd/YsJaUZEDTRqLAlGXsP1jc2FEc6QFUY94tfi5PeeLNlkQH3+ko
         MqAo/kZmZZG4ZBsR+misedPx2pxK9rx459i1DCYkPTpICHd4WL8NBT7xX5q8BoVAd3JV
         RQYXFL3WVP96z8EAX0LZQW1MXKj3F361WhOWJcjuGRlvZI3uLNwJUP3fLv1lI9H8KPwF
         M5culvCzDLFSCfZlQ0Yed0ztMy/GiSHZ/v184FXnUxDEerrtFcXsJJPxIhZwUiKEEdTH
         FSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729974509; x=1730579309;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNNg7zzXFJSGsARqfxEpGo4FAbXgJfDgVsYkeL3nKao=;
        b=ovmwZi8H3aIvSMhoqQkmjZm5rlKWOkRJ+ShbzO4YgV3LL5jWmUEEA27SNgR1LFdHDG
         mYaYFYCWdHbUyo6DOxXjD61mw9Kziub+E8BVQ5XHtlZU3xgY4zw78qzQEhujCyKCo4BA
         Ux4x8mWlXjMqRZSrP9ojyZRExT4MzGgYMtPBvb2CxLNVnGcnzryXUq0okwDDVzR3Nnf+
         hC7Jh3u4k6/5IKNW6yGQGu/80rtcfuENtOpHpkiPdMEk3uYx7DhZHxVpe07r4im66B3S
         QEdl4WYEdjg5eILMMGQ2vDO/bSN7qxgllx24FpigEr59LjNrJlTn1gyP/YiWx/3gcJIM
         q4Hw==
X-Forwarded-Encrypted: i=1; AJvYcCWNbTgl3yje2Vt7rM7R5BWd3kywOnm24MyMW8WB621laTa5GXTj0Y+VxmUDirbCIEXTKOcfuUPinFMKQQ2S@vger.kernel.org, AJvYcCX/gueDhtbh5Qi6qQ3E4sqoOzlu4LLPXgsKTiUWq2w+IOCKDyQMV8sK8AMkjsr9kzp5OfJCd6+Vb0Qt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm08O7J8/sWg0r1sqT/Wbqqzd5oN6yPIC/7/2HKUfQH0b63Wfm
	qz2GaQyQmJeN1j/RDLhzPxLHZbv1OhLk9dE8YcrAFJngWF8sUsIP
X-Google-Smtp-Source: AGHT+IESiuS1iKzvuE8ZzZM3tstDBPTHvi4LpV62cM6BsC9Kiz7nGmLch+PHppJzR77qJwttX7SpNQ==
X-Received: by 2002:a05:651c:4ca:b0:2fa:cc86:f217 with SMTP id 38308e7fff4ca-2fcc940c73cmr351921fa.35.1729974509067;
        Sat, 26 Oct 2024 13:28:29 -0700 (PDT)
Received: from [192.168.1.105] ([178.136.36.129])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb451a494sm6370421fa.39.2024.10.26.13.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 13:28:28 -0700 (PDT)
From: Markuss Broks <markuss.broks@gmail.com>
Subject: [PATCH 0/2] arm_pmuv3: Add support for Samsung Mongoose PMU
Date: Sat, 26 Oct 2024 23:28:07 +0300
Message-Id: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdQHWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAyMz3dz8vPT8/OJU3YLcUl1TIyMTg9QUY0OD5BQloJaCotS0zAqwcdG
 xtbUAi74RGF4AAAA=
X-Change-ID: 20241026-mongoose-pmu-52240ed310cd
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Maksym Holovach <nergzd@nergzd723.xyz>, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729974508; l=905;
 i=markuss.broks@gmail.com; s=20241024; h=from:subject:message-id;
 bh=Ctuv+X/u4Q3Y6JaiCMyXRkwH6JLPkazQ4p5Gw8ErVTs=;
 b=oALoBWszqZ6dy47IJH8/aQnv86LTjr2f8ij5r5Ykxk6QX21A4nGEyqhUcqrf7qHphoKCrU9fu
 AOx5ZzTBuslCdM9DDf04cbscGyCksv8DAbrc2uU4IDI2XP5PGKZN/bR
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=p3Bh4oPpeCrTpffJvGch5WsWNikteWHJ+4LBICPbZg0=

Hello,

This series adds support to performance monitoring unit of
the Samsung Mongoose CPU cores. They were released between
2016 and 2020, and they were used in Samsung Exynos SoCs,
such as Exynos 8890, 8895, 9810, 9820 and 990 (9830).
They implement ARMv8.2-A ISA and they are used as a fast
cluster (big in the big.little scheme).

This series consists of a patch adding the support and
a patch for the dt-bindings.

---
Markuss Broks (2):
      dt-bindings: arm: pmu: Add Samsung Mongoose core compatible
      perf: arm_pmuv3: Add support for Samsung Mongoose PMU

 Documentation/devicetree/bindings/arm/pmu.yaml | 1 +
 drivers/perf/arm_pmuv3.c                       | 3 +++
 2 files changed, 4 insertions(+)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20241026-mongoose-pmu-52240ed310cd

Best regards,
-- 
Markuss Broks <markuss.broks@gmail.com>



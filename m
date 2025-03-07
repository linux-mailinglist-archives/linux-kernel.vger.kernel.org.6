Return-Path: <linux-kernel+bounces-551713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83261A56FCC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792B67A3018
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A423E242;
	Fri,  7 Mar 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mauge80a"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C01D1607A4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370271; cv=none; b=chuRvrt6eWECObSiXqKlXLzQR+IYs2FYJ/mfNrMbzFHqFxI5+JOQDjBDqjx0IEiaqcwe1r61iUQwgfOIad8QDNulv7zu+8rZGFnV9d20GQpXBHWIflrLEjyaxvw2w7vEHTszdg+lIPJdcvHHF4ORBa7vg3PyZui9GtC/7YoNWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370271; c=relaxed/simple;
	bh=/AIlgjfEQo/ZCKVr4eKd6HCmiwSDPzXiPw/NVofdWAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TJSEl/dhuRPuAPgBwFEOyHYklHZSqFJYzgFitSPcawHgp4Ck9YBtWbCoB4o/tLKYbAulnAYcfP+DmRAC8SrgG5A/7GZLxfrOCZgUnoLj7FwWjuKrSZs0cdwyEhOoILIwjp+37vfWW82e62h43pVmKNUG8LIcHWj9K/McZWutDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mauge80a; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so2998272a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370267; x=1741975067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzaxxOZCx9p4Ig7FyYiPGjW79DbnDm9kRQyDomzt74Y=;
        b=mauge80aDc+aBfQf7uyPJi7o+aZ9nhx8m+PHQm173S8QBnB4sWGUnqEzwzcjd2hIN1
         niw39fwJpDl/H9vE8nVGouWFs83YVDZmroVcYfTm8FJRjOX5X9kUuyY2i3QgH9UczJw0
         kdDa2csYMSiUbM2JvmPFAMU1duTvVTL+6ljte0kD9ocSr1r/Ina2rNaLmHc4QMVyGLWR
         CkTJ73h9GR9rPY/C6bU/ZP5obAbNWThL9mBYnEXWMvPjipF/MJ0+qnyj2EYyEC0jG0Vy
         2NymdBtQvRR+bEljX4YWeGk8ROsB2COuVxb0CiRLJFxCR3/ob7umigOqSsgveDA5mFHe
         yT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370267; x=1741975067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzaxxOZCx9p4Ig7FyYiPGjW79DbnDm9kRQyDomzt74Y=;
        b=a51hR8H0t+QZlE8qQpjgiXcG35c/YRt1Hyq29Kym8/7FrJ+JYnHpI0EX7iNMWcyBAi
         WYuSRhcFR+X5Gum3tbvfMh4Bpf4D3VQ5kgKyPzDbrIkgxKwX79RbfAUundVo7aBztfT1
         jZG9cicmy8OfZmu5gh7meAUEwg025Vav05qQ+bqoVWDdpz2xcp7ds7Q65KYE0q/uBdgj
         J2aPeMfgkC2jwnm1FjWlL7xJT+72q/3pwLXSIYqjOqBpf8kp4znIc2vPgS45o/Q3wJ6A
         STwFGT+Fmb5KrLkc6c3N4CIObblfuX+3/+b4zT9LQzPkH35z1DqQyrTvCauK8svzrcue
         u2yg==
X-Gm-Message-State: AOJu0YzN0GSHZrT9u0ddNF/4VOxNMnu3+Ck3hXDj+pdoe3ipx7Du2In2
	s+lA7cMy4oZQuuFteB4zlXZXoCzm+GU0pXTy2V0tN4/ceqch9ye7XdkRwjlV9wE00jT3KywPUc5
	n
X-Gm-Gg: ASbGnct8ALDpfbMuriZVeKTX/CI6ysbpsCgNG6xkifhlztvwuHlQWi/fqeWYCaoIkEF
	OpbV+hjQHNwgapU6pHA/y2s4obyrIoGPq/DeyV6J+9DPKwj1n66K9Uj/XzxM0iwDj+jQBsO1VDa
	IYAnYE5k1QcdGtdwFIUACSKPoOb15kzjAAbg1jidbf5bzIDQN7HiLLx/cHhux+qY3BzozxAx7EN
	DpnhYwc6JnLan8pJxu05w9bpDdISNNYcB+5z1xbxSeUqWzaMbIbt3WWRUIlQsl4noHPzG1reys3
	NPndoVDCrzdcQPZK7U0huOXZT368pFovRa3BCpIPw9wEuEBa/3hCLdIMJ+y5yrqTwgNtDw==
X-Google-Smtp-Source: AGHT+IE3XTihKjmOlk4XoPHji49aFBixkWMicdPVcAoVOmOZbCW2lqqxadI65EN4NOXoBVVSZL1/Bg==
X-Received: by 2002:a05:6402:1e93:b0:5e0:984c:3cca with SMTP id 4fb4d7f45d1cf-5e5e22da681mr5623697a12.19.1741370267449;
        Fri, 07 Mar 2025 09:57:47 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:46 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/14] nvmem: patches (set 1) for 6.15
Date: Fri,  7 Mar 2025 17:57:10 +0000
Message-Id: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=YS52QKEpGoL1Dpl04Ty/oZ41CAE0JZPfu3XK1vJPBgg=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN8c0vRUa9X3c9zcAqW5WcR197wLFxYKyL04 1Z+vSifEPCJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfAAKCRB6of1ZxzRV N8esB/48EbOVcEyBuWuqc9L4r02TD0qYwNbNEuJUEm5Iaj4H29nG7yDvLBm1mI6fVWksI5mSCG2 nikM5DetR6XA+28eZCs4UsFauAYFdwM39Ov1j44bPDLjDNsH4Y5V37A6k4Gcz3/MYernIOhAtrl 8Q6UNYAP/lMtANfkmSIaBXuP8jN+7QF0ZMfNH3rSQqdlsmSY64a7jzZEDRLOWVMucHwc+NU8mWX HqdNBaQ1Bj3S0hO/dPObyWsIZgsBggldctTvVkj3D1aeskY3/zHZHQ8Xhzm0acpaepr6VBD/2/s XuPrllLG4Tm0augouF+MJpJOw2aGJYMOEVc78KpdgKD6Uuv2
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are few nvmem patches for 6.15, Could you queue
these for 6.15.

patche include
	- updates to bindings to include MSM8960, X1E80100, MS8937,
	  IPQ5018
	- add support to bit offsets for register strides exceeding
	  single byte
	- add rockchip-otp variants.
	- Few enhancements in qfprom and rochchip nvmem providers.

Thanks,
Srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Akhil P Oommen (1):
  dt-bindings: nvmem: qfprom: Add X1E80100 compatible

Barnabás Czémán (1):
  dt-bindings: nvmem: Add compatible for MS8937

Dmitry Baryshkov (6):
  dt-bindings: nvmem: fixed-cell: increase bits start value to 31
  nvmem: core: fix bit offsets of more than one byte
  nvmem: core: verify cell's raw_len
  nvmem: core: update raw_len if the bit reading is required
  nvmem: qfprom: switch to 4-byte aligned reads
  nvmem: make the misaligned raw_len non-fatal

Heiko Stuebner (4):
  nvmem: rockchip-otp: Move read-offset into variant-data
  dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
  dt-bindings: nvmem: rockchip,otp: Add compatible for RK3576
  nvmem: rockchip-otp: add rk3576 variant data

Rudraksha Gupta (1):
  dt-bindings: nvmem: Add compatible for MSM8960

Sricharan Ramabadhran (1):
  dt-bindings: nvmem: Add compatible for IPQ5018

 .../bindings/nvmem/layouts/fixed-cell.yaml    |  2 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |  4 ++
 .../bindings/nvmem/rockchip,otp.yaml          | 25 ++++++++++++
 drivers/nvmem/core.c                          | 40 +++++++++++++++----
 drivers/nvmem/qfprom.c                        | 26 +++++++++---
 drivers/nvmem/rockchip-otp.c                  | 17 +++++++-
 6 files changed, 97 insertions(+), 17 deletions(-)

-- 
2.25.1



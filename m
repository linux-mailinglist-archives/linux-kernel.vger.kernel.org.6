Return-Path: <linux-kernel+bounces-332821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDF97BF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4792A1F21AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812391C9878;
	Wed, 18 Sep 2024 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATMU7Vqs"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B52210EC;
	Wed, 18 Sep 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678221; cv=none; b=IMF90IOC2uYeB5+4a+J2vatCClpTI047vSVEN3U/oY6AiIX18zIW6EtmquKai8aaknVR2Rjv4JOFjLVoDWivwjuYFQydVQ1Xy7lfZZiSl+OGl9yzcf6HdEqqST41AUnmfMn4TKbjbuf7vaO5zppQr1mZmOTZoXbUkzpT3g0ggEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678221; c=relaxed/simple;
	bh=f36VaoJOpr/5/J1Y8DjXOVWrtbBy+HJD7/1d0GoLTWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEM8gHenSQJQ9Br6yiS8LoMCZdnycVk/NPLwmcRcywugMwxi4I4DXxtNFoyxYhj9VMoN+RSWBBFBpgdHYyEAJqY2iZrnMN15/9zj/0J6qYVZU8GOUu3hObiiKOK60tbG35CzdksGZ02thq1r6GzCGznV+UQAHFy1sAo5buGlpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATMU7Vqs; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7191f1875d3so726364b3a.0;
        Wed, 18 Sep 2024 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726678220; x=1727283020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=foIJI8m+Md961phTBzLPLyTlV1/r1hCpOS6+31+P9Rg=;
        b=ATMU7VqsoRZVXju4U8IOJ4MfDp48T47qg0/3lF5LBebFNjACa1KmVVeNs6sbS0h9tB
         YzqMxOrWvLuryuLNRWnvhQKJuF9wB2ZPToOIT9oRTQvoew+crmM+cUL6SNt6MV3vFWsm
         HkNhxZNraaVLCGO+pJdAXXITLP5L42LG1kmOYNecIOqVCbEQ3gLI0z51WAeBl/tnZSBJ
         rm1NB66lUkrIpLJ5Ge1YVfLpn/Afl70EnqNPbTKAyLAy0QYgMIlvbVZG/lH4FiLfYjWM
         AJAMxsIJKfWWLlSl1uSSd31dM0NUurFe30K4kpxRWzRyClREtAt5UvYSaHCSyf4pGs09
         IiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726678220; x=1727283020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=foIJI8m+Md961phTBzLPLyTlV1/r1hCpOS6+31+P9Rg=;
        b=essiRQordFNjeInYTXXLGuyu6++GQHxYB/rb55/jk1eYVOhS3ueQ0QwdIDej/c/1V1
         +uFuQlei+f1yeoknPE/vnfQfpylwsXdK0ZSNzJrFDm0gGaeayKzEA80BCgbEYyIei7Tf
         dOyxiGr4z7j4Y4I5zoUteLs0ZzLQ11GWPkCCReBCIfmFw18+j18S4kagiuHhwA65E9TJ
         eDoro6IqIY8Eby0Tw+V/iKQ5lRZxpK2iX0FSOaquelaX45VtgP8ipaz8AQCCEE2jW/wQ
         o/1eX/yolh960CwquggTsC5lI9y6cORndK6VSf9xWMnQ1+YyjG/HZENCgc+DJsAUEl2K
         2lpg==
X-Forwarded-Encrypted: i=1; AJvYcCUvLgvomC2XujLOJzs/e1ZjjeWCjgLBa81Q/yw8Ng7MyvEghn+OPW7TjYcRlZQpYs9N+IqsjbZlzfLDfL3f@vger.kernel.org, AJvYcCX4/r/TljWDFfQiPfHTnLpw4XUZKzbHgKIG5JIpBf/aAkgtqRzLymSzUikCLi/HSIg0EUUR2nYICrWL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7iFJR9Ja/X+UFRFEToW19qXIrMuCbH4O1NY67XZA3ikeVk8Sk
	VYJDUqLpPqbjb+8cATZU8zrPVEbU0CbHG7tcJTWn4PxuaQ8VPhIM
X-Google-Smtp-Source: AGHT+IHPYZss8BHhBt40yfIOL9hvTxkQqgXTDrf5SFcWPvTwbBBn0ATKCdqzb/MW3VFWMnJevPfUrA==
X-Received: by 2002:a05:6a00:3e26:b0:717:8b4e:98ad with SMTP id d2e1a72fcca58-71925f9b27amr13948182b3a.0.1726678219684;
        Wed, 18 Sep 2024 09:50:19 -0700 (PDT)
Received: from localhost.localdomain ([221.220.134.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498f9eb2sm6696123a12.23.2024.09.18.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 09:50:19 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH 0/3] Add support for ArmSoM LM7 SoM
Date: Thu, 19 Sep 2024 00:50:05 +0800
Message-Id: <20240918165008.169917-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add support for ArmSoM RK3588 based SoM and carrier board.
Devicetree is split into .dtsi (LM7 SoM) and .dts (W3 Board).

Info of SoM and carrier board can be found at:
https://docs.armsom.org/armsom-lm7
https://docs.armsom.org/armsom-w3


Jianfeng Liu (3):
  dt-bindings: arm: rockchip: Add ArmSoM LM7 SoM
  arm64: dts: rockchip: Add ArmSoM LM7 SoM
  arm64: dts: rockchip: Add ArmSoM W3 board

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-armsom-lm7.dtsi  | 459 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588-armsom-w3.dts    | 408 ++++++++++++++++
 4 files changed, 875 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-lm7.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-w3.dts

-- 
2.34.1



Return-Path: <linux-kernel+bounces-301869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215CF95F6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2BD1F2288E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A341953BA;
	Mon, 26 Aug 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="comEaW6d"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C802191F78;
	Mon, 26 Aug 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690205; cv=none; b=XYUQiV2vqh6hw37CIKqAhklHnDMkOIr+LP9mB4ezTD6WMsUHgk92NJ7MVIRca51oDS2aI2nlk22/mxtRE6TTaywqxViNmGhZbsHeMIZ+F06iuq7+YrOF0UhlhmqCTNsPfKrmZoDGN3oAzTKMxJc88fjTJdUOBkjlLL4YJ/+p5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690205; c=relaxed/simple;
	bh=s2S9rPIqhbOq6bi/DMd1X1vpVCczh+GaYXKcvD0HWAo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RnPhkgE98wwWowMqXVMRNxDYSyKzxg05HgYKH5BNZCSD+pN4rlTiVfIY3PMVCRQHXeFES4IZ3TVuSxyeZz1bAMjeDJ13Vz8J80unnx+E+857IUeZQjokSLFgvcWry7tpe+4cvkGwZ2JFcNkgl+d9CVc6e6q5n7OHGvPu0ZCqakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=comEaW6d; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5befecad20eso715207a12.2;
        Mon, 26 Aug 2024 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724690202; x=1725295002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8jfPnZyc0O8niMh513DMmM26/MRMyoDXUuhx6J0cuE=;
        b=comEaW6dagpVhXjVF4VasFnnAGJXnA2j9LnS2cqBLhQDGz2RafnML9jvch9lBwlUkI
         mqqj8x1rJRB4zhU2/iIbBqk9wSzXaFVXed8dY4rqoyAezKtUNfieZJeTddnLmx4wMeB0
         i29nJJq1QzTEb/yOJCJoO9YjlRVOjvbGSxrExzB3JBgAtGG+eW99wlDoCMoudEaH6t1t
         JCJ3LHIlO2omIRwoq2SOQQ51Qglkdquj6jS7uUN2Sdz6fFvnjIRky7lNFfejNoi6M+p/
         fALAhjVRT6tgFMEEb8/mKBoUNew8OMShbbseOYpkG9V4AAQxDPrR90OpSzGeHSoVoGBR
         Nlgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690202; x=1725295002;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s8jfPnZyc0O8niMh513DMmM26/MRMyoDXUuhx6J0cuE=;
        b=UrAkP5Uz8Yechxtm8FhTsiS3Kj58eJyr2nx7mc1kHcwkPZ2aaBv/9+LCzzVjNCEYTT
         8f0c+LIsLdUFGwBvcACgXSx62uaNVQL+AWVIXF7FvTVFACfrWVU2yjSBi0P5louCaIXG
         hCDVWBlgtHR8qjQu/Ma93KhisdM8v0VRGS0QNb/PK1l4ziwlw3K0G7vamr+5GFhsfpqM
         cCG3rn2z3KJti3qfiMHYZh1ZwzRyoDIsbUHMgLQTO9K/FVn+2SQ0BQdkFVSKVTzjafYQ
         V0ead2UHLQTB6HnDFgpTeby0sewDIHkzXm/JOcRGDsnO11jpWIiJ07MGFMBdYZvmLkDK
         VQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9husflc2H1OZ5fLQ/kHiP1az4Vf0yFCFAE7cMKVSrW6aEDCE/iWcD9qMrHgvDg3fcFXehaS3PyQ2j@vger.kernel.org, AJvYcCWiio11UJteobPlAKVzjwfMsFwH5XI8mtM0yOqWS+T4o++2P0pW2iM5edM922/tjtsJ+6JDEH19pjBlKm5G@vger.kernel.org, AJvYcCX8+VG3dj2Do9WGTRUoxaftQGNgUyIUUlhb3nDVxz51u56nA4UDW3Zmbbhkv64TUZZ2GBYIjVPJY1cN@vger.kernel.org
X-Gm-Message-State: AOJu0YzMipuaseZr5cFZM7swVa83WkTpM1bQyV4fPIn1YschtU0ESrFl
	ReVEzNSzHPtqRUKo8Cw7oVm+3fhUBsQDK+ny3Jg2SwRqo8Hfu4b6
X-Google-Smtp-Source: AGHT+IEyVJmDWU0qXTpMNJK9aJPg/tpDtVwnAkXmB9dgmBEieQ4hk3J9h9FQdOCZo5n/3rriGsMFww==
X-Received: by 2002:a05:6402:2549:b0:5af:85fc:1a98 with SMTP id 4fb4d7f45d1cf-5c08910db40mr4200614a12.0.1724690201809;
        Mon, 26 Aug 2024 09:36:41 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:1:32d0:42ff:fe10:6983? ([2a02:a449:4071:1:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3e9540sm5819415a12.41.2024.08.26.09.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 09:36:41 -0700 (PDT)
Message-ID: <416cdaf2-fef2-471d-a03a-837775d6e7dc@gmail.com>
Date: Mon, 26 Aug 2024 18:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 0/9] clk: rockchip: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In order to get rid of CLK_NR_CLKS and CLKPMU_NR_CLKS
and be able to drop it from the bindings, use
rockchip_clk_find_max_clk_id helper to find the
highest clock id.

Johan Jonker (9):
  clk: rockchip: px30: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
  clk: rockchip: rk3036: Drop CLK_NR_CLKS usage
  clk: rockchip: rk3228: Drop CLK_NR_CLKS usage
  clk: rockchip: rk3288: Drop CLK_NR_CLKS usage
  clk: rockchip: rk3308: Drop CLK_NR_CLKS usage
  clk: rockchip: rk3328: Drop CLK_NR_CLKS usage
  clk: rockchip: rk3368: Drop CLK_NR_CLKS usage
  clk: rockchip: rk3399: Drop CLK_NR_CLKS CLKPMU_NR_CLKS usage
  dt-bindings: clock: rockchip: remove CLK_NR_CLKS and CLKPMU_NR_CLKS

 drivers/clk/rockchip/clk-px30.c        | 10 ++++++++--
 drivers/clk/rockchip/clk-rk3036.c      |  5 ++++-
 drivers/clk/rockchip/clk-rk3228.c      |  5 ++++-
 drivers/clk/rockchip/clk-rk3288.c      |  5 ++++-
 drivers/clk/rockchip/clk-rk3308.c      |  5 ++++-
 drivers/clk/rockchip/clk-rk3328.c      |  5 ++++-
 drivers/clk/rockchip/clk-rk3368.c      |  5 ++++-
 drivers/clk/rockchip/clk-rk3399.c      | 10 ++++++++--
 include/dt-bindings/clock/px30-cru.h   |  4 ----
 include/dt-bindings/clock/rk3036-cru.h |  2 --
 include/dt-bindings/clock/rk3228-cru.h |  2 --
 include/dt-bindings/clock/rk3288-cru.h |  2 --
 include/dt-bindings/clock/rk3308-cru.h |  2 --
 include/dt-bindings/clock/rk3328-cru.h |  2 --
 include/dt-bindings/clock/rk3368-cru.h |  2 --
 include/dt-bindings/clock/rk3399-cru.h |  4 ----
 16 files changed, 40 insertions(+), 30 deletions(-)

--
2.39.2



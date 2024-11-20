Return-Path: <linux-kernel+bounces-415500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671F69D3723
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02C46B25FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC66618A6A8;
	Wed, 20 Nov 2024 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="CmFhOhld"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49D18870C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095451; cv=none; b=Uo7OyP1IPiTVlu6nyuNFdmhsoNg7a3JU9W5mwbXYxezwBAfAsAVGCWUYreeOlW88NOzO/WjozkcO1scN1x65deojENzvxGVUqSAep3EGem9qYp45nu+vbOPmuB0ZoPoJmRaofRG8tnJD/jhFV1AIX4covtNbRr4TUZIe8ag1FwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095451; c=relaxed/simple;
	bh=RYFxe0lqU+sUNDWO143WCfYxDJhMdEb9ZEFl/vv+Pas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgqKtAUHvSWrnUfQ2VfUTkSodSkxENyKgjmJyVL5cf25vDhvEc8oRqGX087VQPeGpwcaGQqFefsUta0FDL1R+EX4YvfLBNc0CQn30pv42NQ8OvCqGMIKXSnmkwj8CbCGodvleOS8Bj1VMg4p5+buF7EoEtiO6s0lJs8HjnjzUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=CmFhOhld; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382423e1f7aso2329755f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1732095447; x=1732700247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4fsqGfyvQJKmn8zoPFdQOQX2dN/AEtzDhH6yM067EA=;
        b=CmFhOhldudFXay2r1f4PLHrgwNyecwC/T/uxibmvRLxqyZz1MUscVFlQQc92Kx/dAO
         hS65at/kXKupfAOGtcGUYZMHX7Df3x49ruQYHcCTIg3O5trLRqOzsrlm8Um3+hLLP5Hv
         5D5c35jJBpOnrCZniW+8tkg8n94rPf7GnjkcBHIHVZlogM+T9Zhol84ioAJ4x+Qcry2E
         U5eLpb8xs7M5csP9FudS53mN0DyG08KPC4L5drXhpbTIH+j1fTW293id1E98stIiwuN6
         pMaBiffMuy4IaqagZNRSME/bCy2pamnLbnm2bqsPfCfR/K4FLvU8cLZuTumCFmttOPZn
         iejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732095447; x=1732700247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4fsqGfyvQJKmn8zoPFdQOQX2dN/AEtzDhH6yM067EA=;
        b=xTbdIbhMnx+4DchQ+g4hKvrm21jqZorWseWb6NoomPRbJ3PHaTpgWkBuJfmyKekjGm
         iKupkNILWPCKiP/tRJkXNSchs0g2YDauPdmCtn2t/ITrDaMFButMRKRhd/vTz9K4JCfo
         WPhi+S/AC2nPokIB69/BuPhrhj7a4lhJpo1g9CJelcNqcagmRoN1aEJrveMKRsJ7uZmB
         1gScXorHe4GIbqUXib9a2JbzvHF2z9MFo02TSjMbJ6geveM6J/hj2hTjzzSVdcgbKWlG
         Ac9yKoaoIP/33XIGDRCeS+pOIdiQzxZNGR95luFOwmX6m1bFz17ZqNXd0kFPcKfPZjIf
         RwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMC1zn6P3ZwPPrJUn2sHuw5sdufRw3q1G+E2dYmq8D+UkBpptvUgJuRrA35U705/z+TWamTA+CLgUQQNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5MrFu7yWNCJw3s0nzsGFoG+lFyP/HMW2gc65zF9f/NYz5sLjv
	ez3Xc8aVriHOlNDfmR0u8UcmPYycnp1CUPv0Q7bod+B6J8E7O0phTsEg3Z9RYSs=
X-Google-Smtp-Source: AGHT+IERdcVQmp8I/UOWOPIWa5oeyrgUNsR/Mbrq7h+WHYexcjQUaJAOdjbwnyqP/omN2/s+hyZreg==
X-Received: by 2002:a5d:47aa:0:b0:382:6f2:df7b with SMTP id ffacd0b85a97d-38254adf3camr1373292f8f.12.1732095447599;
        Wed, 20 Nov 2024 01:37:27 -0800 (PST)
Received: from fedora.. ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254933c32sm1555709f8f.70.2024.11.20.01.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 01:37:27 -0800 (PST)
From: Daniel Semkowicz <dse@thaumatec.com>
To: heiko@sntech.de
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	vkoul@kernel.org,
	Daniel Semkowicz <dse@thaumatec.com>
Subject: Re: [PATCH v3 0/2] MIPI DSI phy for rk3588
Date: Wed, 20 Nov 2024 10:36:38 +0100
Message-ID: <20241120093702.9018-1-dse@thaumatec.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113221018.62150-1-heiko@sntech.de>
References: <20241113221018.62150-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Heiko,

> This adds the phy driver need for DSI output on rk3588.
> 
> The phy itself is used for both DSI output and CSI input, though the
> CSI part for the whole chain needs a lot more work, so is left out for
> now and only the DSI part implemented.
> 
> This allows the rk3588 with its current VOP support to drive a DSI display
> using the DSI2 controller driver I'll submit in a next step.
> 
> Only generic phy interfaces are used, so the DSI part is pretty straight
> forward.
> 
> changes in v3:
> - add Krzysztof review tag to the binding
> - address Sebastian's review comments
>   - better error handling
>   - dropping empty function
>   - headers
>   - not using of_match_ptr - this should also make the
>     test-robot happier
> 
> changes in v2:
> - fix error in dt-binding example
> - drop unused frequency table
> - pull in some more recent improvements from the vendor-kernel
>   which includes a lot less magic values
> - already include the support for rk3576
> - use dev_err_probe
> 
> Heiko Stuebner (2):
>   dt-bindings: phy: Add Rockchip MIPI CSI/DSI PHY schema
>   phy: rockchip: Add Samsung CSI/DSI Combo DCPHY driver
> 
>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       |   82 +
>  drivers/phy/rockchip/Kconfig                  |   12 +
>  drivers/phy/rockchip/Makefile                 |    1 +
>  .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1647 +++++++++++++++++
>  4 files changed, 1742 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c
> 
> -- 
> 2.45.2

Thank you very much for these patches!

I tested this series on top of v6.12 with DSI/LVDS bridge
in the following configuration:

RK3588 Tiger SoM (dsi0) --> TC358775 DSI/LVDS bridge --> LVDS display

I did not observe any undesirable artifacts on the display.
Display blank/unblank works correctly.

Tested-by: Daniel Semkowicz <dse@thaumatec.com>

Kind regards
Daniel



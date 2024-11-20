Return-Path: <linux-kernel+bounces-415531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27059D379A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88B071F22C25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4E119E980;
	Wed, 20 Nov 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="xFQyGeCq"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20C18A6B2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096427; cv=none; b=TL8ZUpAsFzN4QMgz66koSUUi7vCAHCo5yOp7l2hziG/d53E6dJl/0sDI2ZV/UwhvUT4yP/NsDhS+wJlAmCsfZKUq4UsF5zPog+uR6G73TvkfBgo4meptlK6WPYl7E8ul2LKYCYMEbXxeCisFm7VfyjEGhlLReSbOvYhMmbpS7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096427; c=relaxed/simple;
	bh=cQZTRBqxjhEgwS3LQIWpQ8z/rhpoUKg43ZSv/kyHHkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG1MHCbrYH62ZyGVMCQIw52VtocAZrZ8xqNpGG3hTpJnCrOgQaJkiZNqvCXOWhTVmKiF7v7LblN/iOcvfNDLYogcJMocV0qDvAeB87dURYjPh71g/chzXp/C6hGQI3BtBrmLWia7y2hfj9G6ejCTfnKRC3bGXdpZXR/vJZJ3tLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=xFQyGeCq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so45060775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1732096423; x=1732701223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJLDnW4xgZ8CURNC2nEQvItuWPLm2zclX2H1mWV132I=;
        b=xFQyGeCqZdiM+ozc7/7218xtm+5/7zvZwleSMatyW9jgTEO662miANnmyfagDR3rUC
         xFLgmktOYp2dCMvu8WKoDKXT+hzWjxOsxIYwjKORm2y0J+CwM7LJ8bKhvrHHxfaY22M+
         +86gunhNWeQL5VDP8ANIe44j2yA7JoUk/e8RoPQNDzdW421aoYkqayxyDAUnFTiZTrgL
         VtGY1/zcUKX3xrAgBL8pI8nuDf6PbCrjVathn44Dv3kiLn7p4zcW9YiWF3Axaj4HRrgv
         dk2zjvQBRvPAZTZmik8aZVZoz6A6sxAbqTdHcCq1Rxac80+FEffvw4JLyglm9skvkFhy
         oATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096423; x=1732701223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJLDnW4xgZ8CURNC2nEQvItuWPLm2zclX2H1mWV132I=;
        b=Fp+HoLpK/RALDoo0AjO3M2zArgYq5XK1jiKvnD4L9oZrdlm8bFOJYC1aIzfm2IeF5r
         u+HbWinzdHz04DtzRWN/8jK3q3qghDhUlzoHHIt0lufMjjmQOoTmS1sRCNp/Pry225eI
         ufbT21GERY+q3Pxe/bRy0Nz1SACBO15Tx5aN/E+nAggSsI4+MlKWBxYazXJGCLKceOi6
         yIDi+WUZ4WFU2Ozae3WW4Fc8ZmEdvuf1ghNRJLMA4Bm722xN8qVVuruf4/QDHBCuhiYW
         OgEaKQLPwUnFoPvQ3zTPrMjbj65dndBX/jDOuCZuDe9xFZ7LSspe/6pFPa2lAw52TfKd
         QB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXz8vrJ4oehP9arhbBoABidhCZpFl0TGXMXR0IB5nu6TQFz2Oe+JlgmDqhFljtBYBLWTaI4ImIXFpCO2HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXBq6XGLRbielC85+au1USjabGng+gU+S+Za+QtJ1R5vSCMW+
	4JqxjSqgzpizJWatsQDpzJxicUc6z6LQzoCeZC+MbRNrjDS5hbWym3I+KqlPiq4=
X-Google-Smtp-Source: AGHT+IFGYjEIekWosK3N1x9ZAj53wDHPjVwwCvrEQHprGAlHK6CAfM14PoWKCxOAsPnnpRIJDBdzbg==
X-Received: by 2002:a05:600c:1d83:b0:431:5bf2:2d4 with SMTP id 5b1f17b1804b1-4334f02c7c6mr16575515e9.29.1732096422784;
        Wed, 20 Nov 2024 01:53:42 -0800 (PST)
Received: from fedora.. ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4288sm13108335e9.23.2024.11.20.01.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 01:53:42 -0800 (PST)
From: Daniel Semkowicz <dse@thaumatec.com>
To: heiko@sntech.de
Cc: Laurent.pinchart@ideasonboard.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	quentin.schulz@cherry.de,
	rfoss@kernel.org,
	robh@kernel.org,
	tzimmermann@suse.de,
	Daniel Semkowicz <dse@thaumatec.com>
Subject: Re: [PATCH 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Wed, 20 Nov 2024 10:52:58 +0100
Message-ID: <20241120095326.9854-1-dse@thaumatec.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106123304.422854-1-heiko@sntech.de>
References: <20241106123304.422854-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Heiko,

> This series adds a bridge and glue driver for the DSI2 controller found
> in the rk3588 soc from Rockchip, that is based on a Synopsis IP block.
> 
> As the manual states:
> The Display Serial Interface 2 (DSI-2) is part of a group of communication
> protocols defined by the MIPI Alliance. The MIPI DSI-2 Host Controller is
> a digital core that implements all protocol functions defined in the
> MIPI DSI-2 Specification.
> 
> 
> While the driver structure is very similar to the previous DSI controller,
> the programming model of the core is quite different, with a completely
> new register set.
> 
> Another notable difference is that the phy interface is variable now too
> in its width and some other settings.
> 
> 
> Heiko Stuebner (3):
>   drm/bridge/synopsys: Add MIPI DSI2 host controller bridge
>   dt-bindings: display: rockchip: Add schema for RK3588 DW DSI2
>     controller
>   drm/rockchip: Add MIPI DSI2 glue driver for RK3588
> 
>  .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   |  119 ++
>  drivers/gpu/drm/bridge/synopsys/Kconfig       |    6 +
>  drivers/gpu/drm/bridge/synopsys/Makefile      |    1 +
>  .../gpu/drm/bridge/synopsys/dw-mipi-dsi2.c    | 1034 +++++++++++++++++
>  drivers/gpu/drm/rockchip/Kconfig              |   10 +
>  drivers/gpu/drm/rockchip/Makefile             |    1 +
>  .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  524 +++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    2 +
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    1 +
>  include/drm/bridge/dw_mipi_dsi2.h             |   94 ++
>  10 files changed, 1792 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
>  create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
>  create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
>  create mode 100644 include/drm/bridge/dw_mipi_dsi2.h
> 
> -- 
> 2.45.2

Thank you for this work!

Sucessfuly tested this series with DSI/LVDS bridge.

Test configuration was described in the thread "[PATCH v3 0/2] MIPI DSI
phy for rk3588":
https://lore.kernel.org/all/20241120093702.9018-1-dse@thaumatec.com/

Tested-by: Daniel Semkowicz <dse@thaumatec.com>

Kind regards
Daniel



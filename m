Return-Path: <linux-kernel+bounces-437878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05829E9A06
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D21162E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C211B425D;
	Mon,  9 Dec 2024 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="k7A4mgnu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC031B4245
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756784; cv=none; b=YjDk3vsbCZwplNL0dRTrS9N3D9mNOqUvcng8PCcJ/3ecXFeev0QVWLA6TiwXgyrHo3LYWLh0eAXOnmKlVP7d1O9R2/KS12jd/oFAUiPr/aQEHoMjVs/cvySy7mxPDSL9hyRE9TqbWZ35qxGVgy1VtVQDVrbXc6EczsOhzH4K4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756784; c=relaxed/simple;
	bh=/BnRrLDy2CQ0qFCGoHbR12w83vjFee5OUi3nbgjO2n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6tAJ3mRIJQmoKvIUlKjhSB3u4UlpCodtAkiqmq3Ft6f8qlE+HltF9D1hjoRS7b0KRTXJRcnFIy9qly5bKjKq4smPTaVK8KjDZoM3iNdrc66OLjQ0Wkf4zX846faiVGuEHzZhzhv1ZHvJcXdIaP09PEDQEx8iAqbSWKWYqLIPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=k7A4mgnu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a2033562so42793045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1733756781; x=1734361581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBemlKVePg1M8JMVZCDuH/Kc392eD263a2QapCaGV9U=;
        b=k7A4mgnu2Y6vlRYS/Owj8pDfwxG7HBC5LS+cUoMZU4LzIj3i80XBUGt5lzMDbd5q5N
         Xj6WudIEdYwyQpxPIDU1U/TOPbm2otGEj4ceVK0e/ACh05fuNHxW/08khY7W9l7MNHgS
         UYGwD+kE+/VnRusnWkpKTtDhg04+VGW6S0goHZVtgt8DlWiJ1n5M7ME5DyFw+vVJFFiy
         BjmBlJwtfhKr7ItUyRkQPh/PpYiqEJpB0GumuJtdbv1Z+1mroaRbTcwrqI8ElO/4jnvK
         HE3cDkXO6Ft/tSSbYtijACWnYTr8JbO7Tk+3aB0x2wEtRTh9nIVDgWK3SG3rirl+Aa0p
         LVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733756781; x=1734361581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBemlKVePg1M8JMVZCDuH/Kc392eD263a2QapCaGV9U=;
        b=kSGUso7Fe7hCzXtWKE0OnAMIXCfsF3Cri2FTQ5+RFsZpp79WLn4lG27Lc2y6vjGZsc
         Q9dBKvqiQB7Aj46PLTxwzx7RR+PwZ0Punk4jp+KxFZ7Ibuv1VXnZifP7df9OrbhNcdvH
         LZ4RDf984Y2gIf5c2GSfde0qWJMOisHSjSCn5Zec6vWiuyNoCjl0J5RDx20+escx6qFT
         uammLDFER18Dt6SE0kfZL7/cSEgoxkUyQLwgrHYPBWyjJCKl7N6dFZJmlESVa1UWVW26
         5mJFKQWw+9s/mE36LhJshA61u8SwATagenq1Mi5EDpyUibjJm6xEKJGJPTr+TtcA4aoP
         G+uA==
X-Forwarded-Encrypted: i=1; AJvYcCXNkZBOGJ+T/Ava1xnbpcwbDnAE023yu1TL7J2LR2g1tLtjrOhohldqkJTGO40M63MYrOKBCqXtw0fxeOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9QgEe7JAvGwHjUq1Kokhq7HW+b6ZFM+BdFhPqRKR0iCPz4Ax
	gjVaAzrD7gxIuWnOk135VX8+O3ITmfighNiHrIZg1u1O9XlDdEJiJKD36mk9yGE=
X-Gm-Gg: ASbGncuFqLSr3ehsTbpzQHOCivbDT1/pzb/4Y/kKtuajMLs91BzHLcZzjO2HI+i/WmJ
	nRPeCRQUUHkUFlD8yToXAWRgYBK6FehjRi6KTYPQVOSBERlePDL5eLwebqktv/xarNhjiABEn/o
	gswIYJc6zMANIbZJ2b53OOwwSpsJtd1xZrZ/XpyFhCLI6+JuCMIZ7wzVN2NxFKqknCvujyuhD3H
	k2EJrYSC6EOM2cpcNa0Rk+Fq3Zx6OQIl/x/CDxh
X-Google-Smtp-Source: AGHT+IEaMojRUAQLLwed4/ER+OeZapLgzpX/2UyzkziLJwq8W59lZWRdfU3Peh7xaUCEk69zEFgm5A==
X-Received: by 2002:a05:600c:a09:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-434fb65ecb9mr25947035e9.17.1733756781170;
        Mon, 09 Dec 2024 07:06:21 -0800 (PST)
Received: from fedora.. ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d43809fdsm103296665e9.1.2024.12.09.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:06:20 -0800 (PST)
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
	tzimmermann@suse.de
Subject: Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Mon,  9 Dec 2024 16:06:08 +0100
Message-ID: <20241209150619.33998-1-dse@thaumatec.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203165450.1501219-1-heiko@sntech.de>
References: <20241203165450.1501219-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Heiko,

On 03.12.24 21:54, Heiko Stuebner wrote:
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

I did more tests with different LVDS displays. I tested following
configurations with DSI/LVDS bridge:
- 1024x600@60.01
- 1024x768@60.02
- 1280x800@60.07
- 1366x768@60.06

All of them worked without issues, except 1366x768.
With this resolution, video is blurry, and offset incorrectly
to the left. There are also repeating errors on the console:

  rockchip-drm display-subsystem: [drm] *ERROR* POST_BUF_EMPTY irq err at vp3

In correct operation with other resolutions, there is no error.
I am not sure if this is a problem in your series or rather in VOP2
driver.

I tried to track down the problem, and it seems to be a generic issue
when horizontal line width is not divisible by 4.
Lowering line width to 1364px fixes the issue, but of course I have two
vertical lines of black pixels on the right.
I also made some tests with 720x1280 DSI display. Lowering horizontal
line to 718px shows the same problem. With 720px and 716px it works
correctly.

Kind regards
Daniel



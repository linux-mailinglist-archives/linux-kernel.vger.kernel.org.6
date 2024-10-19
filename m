Return-Path: <linux-kernel+bounces-372895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5DE9A4EEE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A1E1F23E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95518B492;
	Sat, 19 Oct 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhuEICra"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B217DE36
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349840; cv=none; b=it8yvE0z7d06A4w3Evo5unwIeVgduoeLDoemqIy/dBOJvPT26hQVSK8oTP3p30mAdq/1j8UWEZaxRjBng0gB90DYkguR3ftq4RqL20Jasn80lIXIL5THQ4zjWMvn1+b8X7ERuGelsliiCLgXGhPy+GaAbiVNGfWZoGBmqN+4gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349840; c=relaxed/simple;
	bh=2cydqb91QLDOvV4lZqUIXcD8rsM3uJwPE0KkXTFjsZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgJz9BemW2Oe+eD0527p77yku//c8qcfQweiOVy76v8gt0dnC12/+Yr9Nw0JiLNw2DHZxsEY8qbSDj6WIFJE9NyQAOeJOPUkbZGSHl26OzBtbUXIMHqOXfaqJPjkQ2os5lRi3y5ao/64J/QYQ6Sb543yXTTXE/u0faRWVfKuekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FhuEICra; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so3296811e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729349837; x=1729954637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ2iC8uZMY1HDwTJfNJvqqDE19WyrllRJxma9ymbAuk=;
        b=FhuEICraxrrL0mfl9bQcDhqpMFJtQAvPi2RwjA0SP0QBS050VaTin2hctYX9HirlcL
         tFe8tWULne068Y2xZ7kkRY6ssLKmKvWzClN+orPihGyaD4/mt6xOSxnHAHkh9CTltUFW
         0YDroRuSnkfrcCal/2mZ05GUzGI6Mc4TgDK/zFz+0SL1WisFDJGQyEmC+DB3pAxUer4M
         T0oMaibZd+4mSaA581SRciynBnJBCNgU8tlD/cycTGIVESNDaqUbF//ObvHHe9klnMSX
         0dKXvi51USxnmbLXBaksmCM9xm7OyfBRpuXFfWD9US2jI/09uniflx2pChyanvWgZ+Tn
         eV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349837; x=1729954637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJ2iC8uZMY1HDwTJfNJvqqDE19WyrllRJxma9ymbAuk=;
        b=ONGff5t8ys2yQGCqYF2puddXRPkqZ6WbDeOhnBRydxMdHKccN6uvl1GIYlWGpL0uFh
         lsKwYMvhD0lDq4MSt87OOwU8GBgvnm19xWk1PrHF272Z8gY8xfyVLV7wMgcnynw571nH
         mz25y8ASh6owKKYfpcf6S5A5kosH3P4An4nRL8BYpz02eb5l3jXExM6/R6vN5Iopmmow
         CObdJuvbsNafqdPRgHyMtE3/M6YPtlhZ2JHmoeT8THzpyNPzv4Pb9wpy5MaAC8bQgcTO
         0YzswWhiHOG9zBLFStvb53uWqeAhNR90ZuCcF9wGgxoijTnxJ4bzi4Aj3heNGYeRUIim
         xdPg==
X-Forwarded-Encrypted: i=1; AJvYcCWt+PoK9LkxyXwlVhuxuUcN8MOaiBanJIwtRQyYyPCBuYZnmLQVqLqmoeKQT9XFGwVu7TsuFXavRNfdvgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMsZwWV3gDdabFhRm4wHDC2cWKJpz/vledQSwJkPGU0m9bn4Rv
	FRmiUNRTRHYC2K2SOE7ZGeeWqfIIkQey4mIHznqipB9bdfuvGMGZ20rKWtS8/lE=
X-Google-Smtp-Source: AGHT+IF6ehd6MLp512Lxr54GRgB7UYFGZIxVNuSpnrJfaKq2A1UKU3UCX71O7OvXFYc4vFiSmROqfw==
X-Received: by 2002:a05:6512:3095:b0:53a:3a:f4f4 with SMTP id 2adb3069b0e04-53a154adea6mr2769371e87.31.1729349836657;
        Sat, 19 Oct 2024 07:57:16 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15214f1dsm551788e87.288.2024.10.19.07.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:57:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com,
	sam@ravnborg.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel-simple: Document support for Microchip AC69T88A
Date: Sat, 19 Oct 2024 17:57:08 +0300
Message-ID: <172934981949.2755496.5766136954108736976.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240919091548.430285-1-manikandan.m@microchip.com>
References: <20240919091548.430285-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Sep 2024 14:45:47 +0530, Manikandan Muralidharan wrote:
> Add Microchip AC69T88A 5" LVDS interface (800x480) TFT LCD panel
> compatible string
> 
> 

Applied to drm-misc-next, thanks!

[1/2] dt-bindings: display: panel-simple: Document support for Microchip AC69T88A
      commit: c3f0b90f6ffc178bf158aeccae268276363d6945
[2/2] drm/panel: simple: Add Microchip AC69T88A LVDS Display panel
      commit: 40da1463cd6879f542238b36c1148f517927c595

Best regards,
-- 
With best wishes
Dmitry



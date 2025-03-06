Return-Path: <linux-kernel+bounces-549113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D51A54D8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8E97A272E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386E1624FA;
	Thu,  6 Mar 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nrfZaU4I"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836C44C94
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270941; cv=none; b=IQv91I2GxascisirWf/1CdDWP2NhGwm1idiwfObIENe6FB76PsEYGUEI7qSowhm3FhqMgDA0tQ/EAYUI/hzlSzsTeRrHlhp6VCfvH/WQ1CPbXLm4wYIcTMW7/vtk0MycwXQgC2xIpFZrJFugUcwSZaJt1Dr4cCpQnQ8YRxGoFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270941; c=relaxed/simple;
	bh=VFbNjEz2+/wlUB7vGFfTzUXZhcULzXWdvo9/ByZBeMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tq/Vr2wpqqfdb2VbOwS4p5KItLQLaOEuezT3Qx765Co3hSk1roWMxNt7NkUAvm32dYilrpwIA6Izl8fXStgbFJLggHBUzWc4WguRM2krsQ6BDCNlaqIAvxFixo4YjCgZVqUtpJ7AI0tZx5a4tSHWueD06PdxxiV7TqdJ32SyniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nrfZaU4I; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390eebcc331so478298f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741270938; x=1741875738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxWPSzHzc/Gn35u8MiTD5Axzok0afEcoR/THf4/r/lU=;
        b=nrfZaU4IkHjsa3NAaXfdf0UPDhMBHJVIxY2nfxvfAZrHgcCkWVuJDZV7nFJ1KVtmgE
         3MsE/btBochEru7zx8e1OLUjnJ685A1F3PvocidmbRqwGjvNF76rG1lQdujpsBn+MRqD
         lMc+3wK4hyPcUInz7qzt3JbfTAkMgvavWvI629Trhtsq7BwspSdHLS0k4JJoE7vR/aIP
         JuxWTXvGjAUyeyzwIPmzElSQwWjxMb0+SXZ9rsn3SfsOqVUIG8h0xFLx4nBzyPZRmyj4
         ZPzdqybnpv6eQZxCtOJuvxpFj2lAbS7Daha2jftQII1LL06CkInfmjm2xSXJp/iOBd4v
         wAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270938; x=1741875738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxWPSzHzc/Gn35u8MiTD5Axzok0afEcoR/THf4/r/lU=;
        b=Ey872EOxe+QpzZs+CDJbWTHAPD4iu8huMYuSSgggHG0UskGJXJITx9o8/LWfejuYMh
         YdjEuJ/A9wN+x3sCNddZbsEDJ6unJ+/rie/9/lgRaZ5ZbjZiKC1h6aGed1Kf5FxJQ7nf
         L2grBZuqXBpklaOU0w4t5RvVx57tAEipFOeAcizG9zA6XjtRyfp4JBJgx+Z9GvGes83y
         kPyTF7bqp0igaB5dLgGvpuVDzJONH9OpCtvztHZR+WyhnYdhEbP8/kz7eItPC2UKjuPD
         Ohy5ZXusde/ZLrLmP+GDxutZRGZXGVNQNFDnL+woX/cj2xCGhNuPKmjxvjcnVniTecbL
         SzlA==
X-Forwarded-Encrypted: i=1; AJvYcCURsNiEi0iY4J3/4yfjkFli/Vutv7UIdUCVutfTqcDgdfvoiSyq/RStkl8qzrG3nOgUhm+esIZzLUYDAgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+/g6e3bd6KR0yyb8R88LSGpfGEDanqX+ddg4mUofweM4wmSUF
	btRd87aQ6HpCozDPXgdmIRhDYZcliOQiTEApfr0eur7W9cG5Ff0BPiv/pFZEP+k=
X-Gm-Gg: ASbGncvFesQTdQPlh7+i535siE0fZE6F3LfGwrmUjPXp27bqAZtOezTr1ghE71BvLQF
	9IGY1OF3cfT4iRx2oTncQuQTD0iUYUOOU3VS0vv1PNNJaFuL5wg9h8hy8ba5r3mt7Bdz7ys5s46
	lzWoHHXDlyvozbtSLV9SZJLKoStrQMibST+twgcHpSWNmbpnA8Cclu0rYLjkSsB9kJUfHFtxgvi
	rESsoT7DINMBeyArtloWXR9hJKtR9wMUQjBzqfb/hJ4TrO5Tvf1kYzereVVd7ablKcQulo9+oFg
	jJ/mBBu9zZe37M0ACgJoKpHgNZf3FZduHLCSDLrDHo8=
X-Google-Smtp-Source: AGHT+IFChfeAEV2PHdYq8EIIGSzRRpBIfJ68YMIUl/Po8biGKN3BXhslg6JIN0LNeFsPkfFqsFEoHw==
X-Received: by 2002:a05:6000:1f84:b0:390:e535:8740 with SMTP id ffacd0b85a97d-391297dc61dmr2919324f8f.14.1741270937604;
        Thu, 06 Mar 2025 06:22:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:ce13:b3e4:d0d:c6a2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c01bsm52206175e9.2.2025.03.06.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:22:17 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Simon Horman <horms+renesas@verge.net.au>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Brandt <chris.brandt@renesas.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: (subset) [PATCH 0/4] Fix missing of_node_put() calls
Date: Thu,  6 Mar 2025 15:22:15 +0100
Message-ID: <174127093376.41843.17930645720992126922.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305163753.34913-1-fabrizio.castro.jz@renesas.com>
References: <20250305163753.34913-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 05 Mar 2025 16:37:49 +0000, Fabrizio Castro wrote:
> This series is to fix a missing call to of_node_put() from
> some of Renesas pinctrl/gpio drivers.
> 
> Cheers,
> Fab
> 
> Fabrizio Castro (4):
>   gpio: rcar: Fix missing of_node_put() call
>   pinctrl: renesas: rzg2l: Fix missing of_node_put() call
>   pinctrl: renesas: rzv2m: Fix missing of_node_put() call
>   pinctrl: renesas: rza2: Fix missing of_node_put() call
> 
> [...]

Applied, thanks!

[1/4] gpio: rcar: Fix missing of_node_put() call
      commit: f5aae815b5f7e79460a724af4debfc9abcac0cc3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


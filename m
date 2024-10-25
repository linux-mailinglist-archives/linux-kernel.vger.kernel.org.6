Return-Path: <linux-kernel+bounces-381872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8519B05B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20516284A38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2131FB8B5;
	Fri, 25 Oct 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FsmLrS0p"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D27083B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866311; cv=none; b=FbsZ4HNd2VLf8RP1VKDKlm/hlyYY6F6zaJYygIYZx4uNzQCOMVernA/Ypc0p/TS3ysUm5PvUBoXLs2yXS0Oj9QHU6TCMhLAqtj9Y0OmjbjGAxS762v9i2fkEb2VPx5oSOtI4qHSdSoUTOG4KCcb4kw4oHqk3oNa1w2WzR4YrQVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866311; c=relaxed/simple;
	bh=7uwT+o57UvM7J/FQzp0V9fqdfYC2UNIOdQJe6Bj47XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HH+Q2pezq24tfH5U0XHwzOOJ/eOcgFONZ4ks4235hYao6LiMU+ZmI9mE+posBkHBhcU+Kvlv5KAlBicz2ytO3KCnoYmAIuxOeaFp3iGHuWWCJ9UTEl7DLZVEE8bEt07m69C6un8yJJp/RGRAuI6cAXDnDygZwVy29rcQXThbfn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FsmLrS0p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43163667f0eso20697155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729866307; x=1730471107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKxWRQVkB4WdUkX8OjK707c8TKcovo6NqREhGPLhdkM=;
        b=FsmLrS0pc4A03oRNLGEhnANmPKK3SCwKJwoOqyf+OnTgIpuxZRChwRrlBL71pMKlcn
         u0kcx6hHayAyky3HZjDxt8CosI3YTQ4GEtE5Uy/fC28xE3Or5MGRpeLbtUNVXcxAYili
         r/ECNhy45yp2KukjsOTUTmeUyN1G2c3CHa2ftUJuZvgT07bx5jSdaDKOurqBxIXdGlrR
         LQ73RxpFlbLtXbBKUlMKBjxaJfcxUm/PrBPQIMmFOzk6iElFdOU4WPkEFs5D3xYHX5uL
         wEdgmBvdTqWlNhW0KJbomVwJm/607+PR5UdzBnmVdb/jZFTw/O+jEI77jn+wJoNqTt1A
         +wvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866307; x=1730471107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKxWRQVkB4WdUkX8OjK707c8TKcovo6NqREhGPLhdkM=;
        b=e7xb0TWb2CaP77986wF1ykCVb6oLQuLnv45k0MFIe59xoaMIjNW8MO/464cM/n9tRw
         LIqRAF294h0oCz9i5tbnNAbz+O/x6ls2ed5czcTb8EApJn7WTJ7JnEUVLshhbwPBnOXH
         W4XMm5MGULGLQAkmTOsCZ8d9oiDqdUX0vm+YQfI8bK27vblID2aDuimV4QeCo/imWFR2
         vhrh9Pd1JMrfSl/KTThqSFRDrfhleDlhxZGcXtIhIOYkI4oaGWrYdXhRvUFXnsGuB0Q7
         vwKfwYiky0A5ZX0vuclR40NzRij6C/sm1bAA246cKFV2Nr7T0ObGsvqWH4NYT3486uwH
         2H4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX98V+Wa9Yxoh3Adl/OJnZNO9iD4J6gZ0aJBhpC15YqIfmNOBCrHx0rRjsO+94ggXVZl0ucI+UOPIczKcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj68HNbbUdnmVMnHsH4+yPnYx1/XJsYfYQPr/Xi2V3jcbjuuju
	QNi1ZVhH0QZdkEvCE17W1MjW/z4LBpnx/LiWAzep2e1xUgqzLcE51CAIHuGalg4=
X-Google-Smtp-Source: AGHT+IFW/HyHRVy6ctVsiYJPu+tooWLvDcmC1BLHr+e9gfbJhkAvwQ4pQy86lpbSCZbeQ9157khFyg==
X-Received: by 2002:a05:600c:3b90:b0:431:5ba1:a513 with SMTP id 5b1f17b1804b1-431841fdca7mr92227775e9.10.1729866307323;
        Fri, 25 Oct 2024 07:25:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a207:5d17:c81:613b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360ca31sm19121445e9.42.2024.10.25.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:25:07 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.12-rc5
Date: Fri, 25 Oct 2024 16:25:04 +0200
Message-ID: <20241025142504.44267-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following MAINTAINERS update that adds a keyword pattern
to the GPIO entry the goal of which is to alert us to anyone trying to
use the deprecated, legacy API (this happens almost every release).

Thanks,
Bartosz

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.12-rc5

for you to fetch changes up to 7e336a6c15ec7675adc1b376ca176ab013642098:

  MAINTAINERS: add a keyword entry for the GPIO subsystem (2024-10-22 09:13:10 +0200)

----------------------------------------------------------------
gpio fixes for v6.12-rc5

- update MAINTAINERS with a keyword pattern for legacy GPIO API

----------------------------------------------------------------
Bartosz Golaszewski (1):
      MAINTAINERS: add a keyword entry for the GPIO subsystem

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)


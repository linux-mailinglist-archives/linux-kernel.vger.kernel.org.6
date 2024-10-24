Return-Path: <linux-kernel+bounces-380531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDA79AF054
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA802834FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F622170B1;
	Thu, 24 Oct 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cbUhuSnP"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438F0200B82
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796662; cv=none; b=JIMQKl6aluFQ/kHob6BA0qOhdtLlf5m3X5Stjk6pMcTAhhc+4Zw9q2zKkt3h7qVYS9YkUqh/Q9436IAeHcKr1fBaVzAFmm+9AasMQN1e4kRPlgg2DyvSs7UAZJfp7rKSsNWAI0sFMsrTYMIvW2pjno5eDFUhwRtIi9JSAtBctMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796662; c=relaxed/simple;
	bh=2J2Yj2NOa6oOjGZM73x/zLQanFb8Ii+YDrcmRuwRtSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFv/kRhyePIY+IjW0gJ/sF4p7frKLWJWKddmROm0vAmIJa/frfo98CmbFO/WtY/QSldhNt246CKYxnllusGhlZWO97QNXtPygTlfbdyje1IrWgKih7gh9R6DlgkUCrIUs8oDVG4AVFcxociytz3A36AKVyacwOS6QzKFNSOc3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cbUhuSnP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431481433bdso12865365e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729796658; x=1730401458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLJF3aIecRErbpZ2bVrOXhmtA0VmB7KUrZ7YjkGYIig=;
        b=cbUhuSnPYxmlh325/woMdLZQ6a0vW437+BTWhgJ64YNki3RZzP8MTpR2y5wU0Orzk2
         uAExq3EnJtpmZN7ltePfScGj+14iS6Ua3odsmPvWJpjuELGhmXWNgQ8WtmVFuq0Gr+b3
         k5zcDg9Bjasi04pH9P9oXmy7e6+KtItRf/OfGfNFAtPZYvYgL2RTvX5Tg7LWDLGXGkPw
         Rw0pxHQucrDlolC+a7Hi4ofthJB5XiEc+pMX4kLPr0rmO7zIW8l9cDiXw75ox3L8DQgL
         eaXHVGmXsZS/lzkDinvSLaTtIjcmNnmSp8MxAw0JDt019HHIgrG5cOzdB5svRYCg2wXI
         divA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729796658; x=1730401458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLJF3aIecRErbpZ2bVrOXhmtA0VmB7KUrZ7YjkGYIig=;
        b=w8nLitwjxaBBOlAdY+MTX3ee0T3Xq6ErmKdvUoLoWiCuu9jeOGc0sgoUA5blGsMuYM
         OVn7S5JaJT21mMcavfB+RTNAmQmwZ+N57MDvR1lBxTgDUwTAgSL6J5cDsBxkWXR2uqX2
         HCD8pQ+pVdXdrU6sIVReqAqcmvlCqJifYN++hYKwlt7IDJCKBCAz/o1Qoj+7NkRRmNHQ
         BJDm0XkqixDLqryhUJC22kTb4SXDptfmTpHGUZPlsLW6ESn4WJCUwh5zOqrL8ngQc/bV
         1xBd1gVeXtoxObDfOMiV27/HH7g2iVuPiBygehxarwRhc3lI+cFx++/A3mCwEE4bLQjV
         YvXA==
X-Forwarded-Encrypted: i=1; AJvYcCXqcrzEfT7HgQawXXnr12BOS/S9mhoTcgR5gyJYczGeG/khl+vFqze0JVgK6QQmUITX0DTuaY5UuFmzees=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7dMq1hOnaarF6hkNHNLH/iAA/IK86L6dn1m3AhbqdGsWL12h
	0D0qzlCWIq2BMz+RdtRnOjPuBCbQZ+QTzmqdKiYkIU5PrIF3OlybKvy3piUBCm4=
X-Google-Smtp-Source: AGHT+IFCnaX/c0lMd0V6SDI/A27X0TVS9VKiXa7YuZhYWoUQgwhnSkjLqX2ryTpdgF1x9ooXB5PuZg==
X-Received: by 2002:a05:600c:45cb:b0:42f:8515:e490 with SMTP id 5b1f17b1804b1-431841341e2mr60270955e9.5.1729796658245;
        Thu, 24 Oct 2024 12:04:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:17a2:e679:56a4:a25a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b567838sm27112365e9.23.2024.10.24.12.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:04:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Klara Modin <klarasmodin@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: fix a NULL-pointer dereference when setting direction
Date: Thu, 24 Oct 2024 21:04:14 +0200
Message-ID: <172979664791.66034.4461804157130165429.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024133834.47395-1-brgl@bgdev.pl>
References: <20241024133834.47395-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 24 Oct 2024 15:38:34 +0200, Bartosz Golaszewski wrote:
> For optional GPIOs we may pass NULL to gpiod_direction_(input|output)().
> With the call to the notifier chain added by commit 07c61d4da43f
> ("gpiolib: notify user-space about in-kernel line state changes") we
> will now dereference a NULL pointer in this case. The reason for that is
> the fact that the expansion of the VALIDATE_DESC() macro (which returns
> 0 for NULL descriptors) was moved into the nonotify variants of the
> direction setters.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: fix a NULL-pointer dereference when setting direction
      commit: 1f4a640e9ac7f450752365541ad9c064b13ef8bf

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


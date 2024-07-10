Return-Path: <linux-kernel+bounces-247594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B8092D1AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC14F1F219C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3D119149B;
	Wed, 10 Jul 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ke7Huj3t"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF161E488
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614784; cv=none; b=DbQc/+bRXqo6LPGWanExwn23E0bQnJFTz5HZulJPXOb1B0k8eIixe7AiJ5gOwUMwm2HG8O5Ob9J49FA1juc36q2tbQ6XKAWpUG18Za2dsoV9izJfgvSnH5x4GzP6MwJ1BBADXpw+TPkpY7GUqEufiJ5aFWffF5jJEuvSo3jTAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614784; c=relaxed/simple;
	bh=dIIo+DM5L7Mul8SE0Zhy9qKTM/yeDzVXSaC1IfgMUbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxL8LXS0YUIokOq0xmduaCXvhWtZbSX6/tByEAwSwftcstZecKd8OqycFXVCYVbWAuDoRVjtNBUwpA06F2kkHLI/BRFJdc2tQwd3c3K0tF2HC96azjgxAk51keQ6bpj9XplyN5MnhmDn1+WJ9//sSSCPDPyIaPUauwgNWIdV1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ke7Huj3t; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42679f33fefso11209165e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720614781; x=1721219581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omAOzhzF+5hjuGOZq+DFkIky+4Nl9NLvEEwWei7tQTg=;
        b=ke7Huj3tz4CIBKGfnpiwFlANsjJK868mgb6cmkGgysITX5HlNYwcGEnJenaLJImIbC
         gTEJk0aVzjTH7gav8Q32Kb/IKskrPWsPCTMa81cf+sSQPu5UpHE9uee2D0gU9Z7r3Q0n
         z+T66M56n4alSSwAE2KffCa0Evn7h0gRtpxKihMd6DA/TmOCrAyO2h27ZIzfUZ6L9sep
         XzmZhZD12INR0NRwBcGpg/+JMiUtazOsMbyOA2HRj1K9BVa9zh1VwUFdOsQyTLlXwjFN
         oi2xkwNmpmm26JPR14aVeWMUrSDdLcIQKunPvK9M3j2wswTwoBvknPNydv1TcHTcrL7s
         7Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614781; x=1721219581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omAOzhzF+5hjuGOZq+DFkIky+4Nl9NLvEEwWei7tQTg=;
        b=sPKXnrlN3+d1qR0xRJispmnGNOkY73lGq0oru3XtCkaqtDBj+Jl+xRB61bsWD1xofy
         f8cxtO106Y1Vz4/3CUcmDttTL6GhYqUQRoBEK0z0UEJ8BqT6DPpZhwvhLOY3iK6TVxo7
         ZygkxBSbEoE4x5fsh5qM4BDFY1l/4fSNPbJe96E1q9ZxNxZ31f64TsA3NOFWyUTpVmxB
         cf0ao3DaE5uAcG/o9uMViTdC1QpkV5FoVwaWjIetuVDEq8pQdCxDZceFS+R9gxXK1W3P
         JaciuSsBAb2WEUmZ8KHy/HUjXT7UPkHvGSMwMhKtqz7QlwzbAoglAzWmw6VRn80Pq2wg
         z6yw==
X-Forwarded-Encrypted: i=1; AJvYcCUbUWu8o3zU8GMVnU09LVZNQCLNTIX2uhCRcCtOV8GDqnsXy+4kFKD2HWczCAM7ijHIXJ4joyMMwRS2KrcHKp8+F1a3rtPIVqjCz80P
X-Gm-Message-State: AOJu0YyFONbPgDkUMtxOFFZLi/t8cpZG8q2PSTXE8V2OGKBbPawW6dGy
	4Y6CG6HlhriWz4IhQMH1c4q5U/eyH+feV6wc5VQ1WSu4qW33MuZ9VhPEhHNpEr4=
X-Google-Smtp-Source: AGHT+IGm0BNtklBkwGnNQeIKpkLcx7sWGRESJuSFhHj/Iw2YtA2cK830W6VnyYne51T2Td0PAaIhWw==
X-Received: by 2002:a05:600c:4a05:b0:426:6618:146a with SMTP id 5b1f17b1804b1-426707cf1c8mr33838065e9.2.1720614781170;
        Wed, 10 Jul 2024 05:33:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5d33:75a6:b07c:5579])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e9666sm79376185e9.9.2024.07.10.05.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:33:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	grant.likely@secretlab.ca,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: mc33880: Convert comma to semicolon
Date: Wed, 10 Jul 2024 14:32:58 +0200
Message-ID: <172061477527.26988.2068284231038760044.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710082813.2287329-1-nichen@iscas.ac.cn>
References: <20240710082813.2287329-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 10 Jul 2024 16:28:13 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied, thanks!

[1/1] gpio: mc33880: Convert comma to semicolon
      commit: dfda97e37de4c2fa4a079ae77737c6b9ed021f79

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


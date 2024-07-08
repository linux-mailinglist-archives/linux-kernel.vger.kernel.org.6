Return-Path: <linux-kernel+bounces-244505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D892A52E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EAB28212C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E81420D0;
	Mon,  8 Jul 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XL1CqNZw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E413F45F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450430; cv=none; b=d2EVMpIgB40vjodliygrn1AeWdL7YEnwQ73lRXxmPOL+NxyQKjTHRndVK7jhV1GmdY4mvaZrqgo3IqZNbnvwkrhRAFwTEGh6jGcyYrptleKM3LvZFYHoWddUD6/T6S2PGOxBLDbvd8nmAofTVV1HkenEds4XDQ0X1eHGWYRPndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450430; c=relaxed/simple;
	bh=oS/9j3dsYpP59idtGgIC4uuWK33USwlviNFf2Yb9edY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbBYsw0BztKTzR0w5PWK95UQrgXZEohx0zgzhT3jgDKFDDraM/x3h6d6fLAA00RDqYA+r/WkbYtlIvcPzRt630Vm6FVC8B24IjKAvFzQe/Upy7JAKeIvk9iZw6iLsfaXgPJQ+GbM8kGh0q5/NosmF8rQLUzQ0vXyf2SbFepEaBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XL1CqNZw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so34622225e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720450427; x=1721055227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyqFib4M3rqlBFw/ZGzz1LaByQHFqZPSGdvyPY+IPB0=;
        b=XL1CqNZwkkWELRYJEe9haeA07ZsDwWWm3PbUZF6DzOWI9yTLS72PRr5QecEoUmuh8J
         0GfgCfxRnSi6ULMkKakl8H2DB0negyPnLI8hfGTZvLI3lSBGAkWJZBgKhItFFd6FxT6U
         tiqxTPMdbygQQGo7b8KysReMrE0+rAWzf8LiS65c59/lIRE0p38E8ug9RD/XlqCysSzO
         KkeNopZ0pVr3RHd4LKMrZ6SaMdohrnT1BaxughNmfw4DP3+5Xlq/lw+ybwLZIYiB3xk4
         sX3yM4vAQYNhJjAeivmQL1nxKvH4oghdPG2rng5EehQHriKFJe0dFTyL/RRV7Oi8KShr
         HNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720450427; x=1721055227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyqFib4M3rqlBFw/ZGzz1LaByQHFqZPSGdvyPY+IPB0=;
        b=a3ihCGRdTQHIzs1nrBkSFzoGyAUiTB3LM+cqldJ9xZmhbVlzH1TwEXz4d2UFGn1LCZ
         z8Eluk3ycKd6CcmhIhuDJWqPbZZoWCzptEDlfvrdplgHYrh7a5kV/UvLboG42VzCY92D
         DLY2W42u8HCJowzQRcWdUkGArOEKy2ssF++hN3XvDeymHyaKzHE4AK5ENvSs14Srof69
         JeqiZE2Y6wm8jBLVqrkuDzrMYiW8ktvXP/OfxbRFq7enKHn6ai7EZYzpsOwiV7p6g8nS
         38rRyGEH0021AVRuUKeC1iAxfNkms2d4Z0hTSbzZ3PtSiNLIZy0b80FBprQAAZlwCYzF
         cwng==
X-Forwarded-Encrypted: i=1; AJvYcCVE3Mqww9exGLnJ8AyyvAp+67uQDrDI23f8d/ncWyaZWBme6e0sFtnMxk+P7yDUcrU6lRYYkXvM1Mv+CChBZws9hmtl9msQGjdKY6s7
X-Gm-Message-State: AOJu0YzYTx4+sK2gbDtfW3JyJ0gKc7hpnVYoiL0fK7iKFGHUrGi2CE4F
	zeg0TcbbLSJw61x6Og0ukdiywpHd0LuRmA3htWaMdnIo3RPKuCojc52+AT6D6ZM=
X-Google-Smtp-Source: AGHT+IEBuhdhAHUYp56NAUgYnKaRIraX3CZBvDDbgKXiz0kpyc8NLn1O5Tq1/i1agiHJxKvs5l9b7Q==
X-Received: by 2002:a05:600c:378b:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-4266f876712mr488425e9.17.1720450427358;
        Mon, 08 Jul 2024 07:53:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a2a3:9ebc:2cb5:a86a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09fcsm1933645e9.4.2024.07.08.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 07:53:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Stefan Agner <stefan@agner.ch>,
	Frieder Schrempf <frieder@fris.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: gpio: vf610: Allow gpio-line-names to be set
Date: Mon,  8 Jul 2024 16:53:45 +0200
Message-ID: <172045041379.123415.15663684790489482699.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240708084107.38986-2-frieder@fris.de>
References: <20240708084107.38986-1-frieder@fris.de> <20240708084107.38986-2-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 08 Jul 2024 10:40:31 +0200, Frieder Schrempf wrote:
> Describe common "gpio-line-names" property to allow DTs to
> specify names for GPIO lines.
> 
> 

Applied, thanks!

[1/5] dt-bindings: gpio: vf610: Allow gpio-line-names to be set
      commit: 8060be2489f9bfa0c603373fa71cc2f93e46e462

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Return-Path: <linux-kernel+bounces-517183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581CA37D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A8D165BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8D1A2564;
	Mon, 17 Feb 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iX7aPyVh"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2069168B1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782049; cv=none; b=f52G0XBdmK7L1iU/Qmau/1xFiCU4FKQjZWNmW55CqBU9+4WX0Z72nlikX/oi459+hXfKMcQP1Xd/WMMoW78SZOaIxPiWlgTnSqjTUCPTXALjcyolP5txUQA3XGCaYng+VCi1djX7hHUEj8LSPWBJszMOQsmjWe/g0gQOBb320i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782049; c=relaxed/simple;
	bh=Ue4Ul6Y05UncZ32MPE2fSbcYWky4wxO0AMGYilnHknY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uG5pgG4isymwMstx30L+9rLe5OtPXArXAO83OJfZwqT0voz7eHEOUYYVm18VWCHRANniKG3EtFDMUx5fFo9OzxjATk09SvEwe8kYUKZJFeIioPn07PeOWK0F2EUpUdqBUkScRKd9Hn8VcJcugH2i09Ag2xFRDLA5vIhuMyRIFLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iX7aPyVh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439714a799aso15434235e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739782046; x=1740386846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bb3lhINEgDY+UoXToETIm0EmKe9d2I5IoG0cLpEt09A=;
        b=iX7aPyVh7SDwG8IIbYyY5pw8Lq6883K0paGK83O1vRV6iCOLRQn9ggHdBPD3K0hDJs
         qJs0JTnkO+NnTZyBLniSevmx/Y+cZBejdJpY3IWH3xjmS0+gSfEK5Je8oX0XYjzF+vEH
         2hfpHHDHd3WBEMsPcnv1LTmAbLarJF2BbYvrspJu4Moy1rPnkl+RXbOtW2vSlc9mw9r5
         MoYOqfkdNenccUiL6WwtfUpe2zq6lWbyssQM8u/AMNzYG5ivKHCx2iv8dMfBjXJL/x+I
         PB65AerbS7Jlh36x4IjI6y3V+NHQr758DQ+SYT2hQp6rnxGKzlzVCIw3TKYtvIeG4BY7
         pq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782046; x=1740386846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bb3lhINEgDY+UoXToETIm0EmKe9d2I5IoG0cLpEt09A=;
        b=KVwuej0onRqgkEy6RIhw5djKGB5HTjNGOK24vePIk4qDR+GJUZK3zHbIuyNmo9TW6w
         tWdrQuI1Kak0jXEV4zLX5Lgu/q5ozPKBDnJoyCimWtdlaopQmTpm0HMtzJ3KXk/I/w/x
         1Q0k3tlQmEhTaB65xAmV9BZrVTcd8Re1LXGJXBhTcxdJxbnCDsm5919jnm6JwYVOfql0
         Bogi4jgxzBJVIRdTaUvqtzyOIOG95/RAoQ0GW6XMVFHwjTDVvDHC7mdd9Oyq5oMjsrYp
         j6k6D0LTnGSEtol2Pr5Y7YH94U/SVvvCchOcztHBHIqGxgKAab2LWSlG2Wax0Ap4XJQm
         JODg==
X-Forwarded-Encrypted: i=1; AJvYcCWrhDbmXeDd3p5k7yexlrTwtn6v5iYg1JDDbE5gs3l2Ol9kSMDuM7K4DYuJFysl+BijWE80F2phj32iCjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1Qr0pOxMhikbjBZz0TroV1w4bcrQae8q47t9xQgU1tMH8j1E
	kJ/uJe6+ffNXPRM0maTZOhEhzRHMfdSkm6XJbAad/WoysqwaE6B9hpbd4+CA2hc=
X-Gm-Gg: ASbGnctp3hM2Tva7c/XciiXv1zGJx4r38h98PwUvo+nZIo0b1UayQjdUfDHf0yRfkiZ
	O2HfQZ4qwzSEiLx1c6uImPnkO9en5Oe1ZxLDyOF8K7f+NKTpq1/Edk8RQER+ck7znfhhmUIKzeY
	gtA1uSBLrtFUU0K3123T/bQw86TAskPebFZY/gq+K6wYz3GsE6jN6CABZ/nGLE+HLduCncozU+e
	4i4o19mvXl1bcgIJx36AbQjY5SvEOKtZR50mqlE/OS5Ap9iIUWuM+eY6iXw1eSE6iImKqKfKfdy
	BPwBZRbzciOv
X-Google-Smtp-Source: AGHT+IFT+lMKOU/deB2J2ddGkT3HluOwPLwaMtnkgEjYGq7pMKOAsYx3SgC5Rv9p/UAiTeKw5JF2Bw==
X-Received: by 2002:a05:600c:3b1c:b0:439:64eb:67cf with SMTP id 5b1f17b1804b1-4396e6c18d4mr79637545e9.13.1739782046008;
        Mon, 17 Feb 2025 00:47:26 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8707:ccd:3679:187])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987396d3dsm13992455e9.36.2025.02.17.00.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:47:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: latch: use generic device properties
Date: Mon, 17 Feb 2025 09:47:24 +0100
Message-ID: <173978204242.97470.9398094804481647954.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250211120847.42437-1-brgl@bgdev.pl>
References: <20250211120847.42437-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 11 Feb 2025 13:08:46 +0100, Bartosz Golaszewski wrote:
> Replace calls to OF-specific interface with generic device property
> getters. This is good practice and also drops implicit run-time
> dependency on CONFIG_OF.
> 
> 

Applied, thanks!

[1/2] gpio: latch: use generic device properties
      commit: 3c998af7ceae2c86b4b0e128d5e47b3c1e1f8f05
[2/2] gpio: latch: store the address of pdev->dev in a helper variable
      commit: 80bcee25b592b018203be1ddb20ede8d207a552a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


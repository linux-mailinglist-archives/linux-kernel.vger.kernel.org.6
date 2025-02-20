Return-Path: <linux-kernel+bounces-523764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B13A3DAE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D93B163974
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF01F891F;
	Thu, 20 Feb 2025 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WvQEJBM5"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DCF433BE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056964; cv=none; b=Dxub19+qq/E7G1xGa2nCSF79zXQuHObOUuFIN3ecWvXnOpT9RojJZPFPufkTAuVPR/KiS0fKL2HN4lz0OgDn713ML/nhBT9x3rVMMW7zSbnd9eN9EoBZC4hfs1yrZiO/KkN7+EQ8Kte0IlS5hiir9ymVw3QCdlni5O7bI9wqgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056964; c=relaxed/simple;
	bh=EMGp+waGDautIwmgUrw6ZO1fNBDQkmfgSGqUyA8y5PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLrMD6PeHulbebXqneEDitrKHnReNDSccMCxEnWTOztsNonWH1WDxqPRJWLhYxCYqMgTn5NaRxrrafzfqRA9KfAy+aqc0H8gXlzyMMtVcOTqxjH3sJWtWnPlyEgdszeG+Gie8l8c5Zgluyfe7O7wAvuxE0PZfZayQkzcfo3aZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WvQEJBM5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f5fc33602so510029f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740056961; x=1740661761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmtqWvOt9IGhgCN8MYbu66ivp1lZ7PoGeZdQgNdj5Ek=;
        b=WvQEJBM5pJzH1Zzs8Z5+60jY3Cmt4+u7FkLc4wfSixkXKdN63Ir0RLey3wX4NQBmPR
         1cfNcnFMxujVMWYMVbrK8ZnhlvimOXB9iOH/N+V7u63yZOfJmzXQPixgibp0ZLJ2lUCt
         FOox3NGIP31NEeVHUqecbauyYzOP6CR2t5Vh3cNSwOqBM1Jky6FsxmnENElB5LYzN0kj
         LYigL7HZHQjWfQ17/qCu+BAtj+DlTC9yjTQ4+T/Cp45FNsqqqM1+s73lb3iMMHDVqSsl
         E9K02Yybg5X8VAUbrgzsE3koezBxi+P6G2kmZ4HVdNlGCtfYAqiesUeiAx/jpbazI+cj
         oanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740056961; x=1740661761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmtqWvOt9IGhgCN8MYbu66ivp1lZ7PoGeZdQgNdj5Ek=;
        b=DLzEmGEPZX10miXODB+v1G8+4xp2sFPilwdmKg5c6vf9t5Ne5suy0Secfj/balTT36
         WiS/twDQBUGC7W+XqE5YRh+67/CWCWjfxmmzK3mqnbHGL/IbiNGzPiDcL9g66LXNA6kP
         Yd/CvDkpW/zB3YvpVpdBDKNrBQfTQag+q4YRidh1ZK9oJWcAjVtpgrAAmWp4Axm/u8Mo
         gbdWU42wpJ9ajSmqDMmYD6QbB/Z8FrnzCmB2N/rxcCDH6t0CGSUwq/AatIKaI1qHQ3tA
         llSDx4lVej2ZFJEY7xdMWeNJN79mb1nUNAUwPZASHrL18bdNfCMZHoCrXfZ/VXvQJdQ6
         6jSg==
X-Forwarded-Encrypted: i=1; AJvYcCXnczpk4ICNmdWZOijUVGlNn7+qj3Y+YrRF2+Hm5N+9eVRwMt1w4mbA8m270QtlaKSOpQ9DzipHNryZmrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iG3FplYAMY5gGzvIYnjmne3FrMkXHL60Kk+70nKAiogj3sxD
	XdmoiHjwQQ7UHvA63YUVLXMVIwySDWyjXM+cPG8X4Apy07mXjJJESbxRVhq/GI4=
X-Gm-Gg: ASbGncscl2vWi9v71/TJPFPLCZfJzYhkyZvdya/WTfBXT/GL0KFEJDBh0w2lQP2ILHR
	p16V2GeqD4dw7KQf9QXt99BM+BTs2u/cR6rqRyXb1bSz5VhHKZO9Y+YuCXXz5NywbnRqzQeTJ8D
	ueg/qFqTBYxWzlX1Ps8yalg7lVBJkKrV/unPIjqweOdu2C+Zoh3klXv5h+2X+M7KB45FIdUF/7m
	0Q7IKlOyrskznel1B2o/5CPrdM7nZpUv5VGBN/7q9qnQVMmeFT5hzHoJ5DXr+2gY7kbOWYsy4F5
	xFu0R1OqqQ8nGA==
X-Google-Smtp-Source: AGHT+IGbIfdv9XOdYL2F63zJDoBS3KeglPP1iXZ2SnLsZHSe0oSYlpnW6eY7wK10PTAW2BxL87BbAg==
X-Received: by 2002:a5d:5f4d:0:b0:38c:5da8:5f88 with SMTP id ffacd0b85a97d-38f61609df3mr3636052f8f.28.1740056960879;
        Thu, 20 Feb 2025 05:09:20 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:e2e4:418d:7462:9cf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd2csm21129660f8f.30.2025.02.20.05.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 05:09:20 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpiolib: don't bail out if get_direction() fails in gpiochip_add_data()
Date: Thu, 20 Feb 2025 14:09:19 +0100
Message-ID: <174005695734.63211.7320786041973824393.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250219144356.258635-1-brgl@bgdev.pl>
References: <20250219144356.258635-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 19 Feb 2025 15:43:56 +0100, Bartosz Golaszewski wrote:
> Since commit 9d846b1aebbe ("gpiolib: check the return value of
> gpio_chip::get_direction()") we check the return value of the
> get_direction() callback as per its API contract. Some drivers have been
> observed to fail to register now as they may call get_direction() in
> gpiochip_add_data() in contexts where it has always silently failed.
> Until we audit all drivers, replace the bail-out to a kernel log
> warning.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: don't bail out if get_direction() fails in gpiochip_add_data()
      commit: 96fa9ec477ff60bed87e1441fd43e003179f3253

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


Return-Path: <linux-kernel+bounces-297360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D4195B6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF7FB22093
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239ED1CB158;
	Thu, 22 Aug 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F1B7hyyy"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB50E1CB121
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333422; cv=none; b=ee3Ccf5nppBr/5YO3k/5lOi0qRY2d8rtCAP2VhalU+18pprDnm/sYe1UVP4aSdm/+ONhVMB8T7IDQ9cG6bN6yJYYElHeNtJKU0CvwVnRTDsR5Apd9jdlpV3PlCTfyIp7IIBuK0CDKbzSX6WDGws6GTpyHVsdvX+FsCaYSYbkJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333422; c=relaxed/simple;
	bh=6uixaA1bOPbEnG+jiXt7A8JornGFwFdjfUFAjLRH2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZBsBuZR2l5sGGtqvhXbabLnq0EpJN2KS5FJFnP0+RTh+J7xQ4bIcP0LLU7PT0A+YCGSzM7ci3nKJ+BjykiYOBLfpWh43pRASwl5UpAPVtsZ5pcpL0i3DwRICErSlzZybZON7E4O9vIgEDkYk65/HRJTGXri441cw3IgRzOs8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F1B7hyyy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso461549f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724333419; x=1724938219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sow4oJ1Jg0NDdR25xAMQ/COQ7rWcnilFzdDGv7rWYss=;
        b=F1B7hyyyQHMitx5K0P5zu5z7pN0wcPyTuQyj3pk0nae4aKv0xf4Pj+gVt864LagolK
         PH+LB/cyZn3rFTkWUm+R74Tl4DUhEjP0uAyuzuqwrPmEEEFKSN9l61NPMQ4luqpObrfY
         mYBpcswcP8K2Q/VJhfMOFOqvJ+0smtlx2FnNJWEaQESdpTBXfwCD/gFK0J9GNQ4mS6k6
         4aEpjMuar/pXWx53uyJshumRJUj89PhlFwdnxwetA2wv2tpyrUHe01nEBwn5cozIRXu1
         drV+IejapoUrKQ8raiknh8nSko7llbxOdOmK74aly878HGi0YQs5ZmxYTU4xfvj4KZlw
         EupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333419; x=1724938219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sow4oJ1Jg0NDdR25xAMQ/COQ7rWcnilFzdDGv7rWYss=;
        b=smavxG7U8WT4oruwvampMhRMeozaZ8/Gm3yFOHo4sc5xl4NQgzPNy+WF8u0wOgU/Oy
         SrMPry8IdSJxl2czd2vC/11xHxT5lDxVav/xMBeUbSo7JdQK4/c8GJrjwq44lu5Rs98M
         vTXrkwgwedJtbAU4WFbMNxH+0lGvAIM3jAXh/2BSEgIMik4U5dYvpY1SvpdzLQS5OP1E
         OMx8Ls3kjQ2BoyvSvh/m9xlOT6e2/gV5de/AO3SI1ve+rrccWpFBVKYjeRzJ/LA53rx2
         a7mAvK254Ibnflm/ZAIOHa/xnYZFmpVqRT6Y/hTnW/jRwTAOtQlSajL+CTroDujss6r1
         5qUw==
X-Forwarded-Encrypted: i=1; AJvYcCXr/JeTVHUZloDvH26QKF6UA6yjRcC+2lZz3bAK37yE/XllpunW4+aWFd7NNCnxcoghK94I9yodrznt41k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnhba9qlh3G0gp6/5xX3KrPBx8gd4C/EW3o/KWcx0Jg1F6J5W+
	truVVHPJk+CucomX2DYhCYI1668ScHHp4f15frSKhHALFuoDyAIxkfvVB6p8DIM=
X-Google-Smtp-Source: AGHT+IGUf6uLXVvibGKBn18YUjYGGvG9tobdZE/ovA1c/SHbPaxXsAPGDRGyV+P+LRK9TkEArUVlsg==
X-Received: by 2002:a05:6000:124e:b0:371:8277:6649 with SMTP id ffacd0b85a97d-372fd5bb0e7mr3605771f8f.2.1724333418430;
        Thu, 22 Aug 2024 06:30:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1e6:1bb3:7777:498e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff633sm1699552f8f.77.2024.08.22.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:30:18 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jonathan Corbet <corbet@lwn.net>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: add a driver API doc for the power sequencing subsystem
Date: Thu, 22 Aug 2024 15:30:16 +0200
Message-ID: <172433341423.27429.12007142599226863583.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821100818.13763-1-brgl@bgdev.pl>
References: <20240821100818.13763-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 21 Aug 2024 12:08:18 +0200, Bartosz Golaszewski wrote:
> Describe what the subsystem does, how the consumers and providers work
> and add API reference generated from kerneldocs.
> 
> 

Applied, thanks!

[1/1] Documentation: add a driver API doc for the power sequencing subsystem
      commit: 8b7e0a6c443e855374a426dcdfd0a19912d70df3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


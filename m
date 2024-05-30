Return-Path: <linux-kernel+bounces-195172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D88D4878
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749B11F2369E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A726F313;
	Thu, 30 May 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i6ouBkYa"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC76F301
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061370; cv=none; b=FlIJev4nW00xgTnCGf00LNXyuKTZ9L5BJEHXi1PGsNnGU7R1xitB8g7CCQRYPEMODcbWZtM3/G+jReg5tN2+r/fUA4L4JyLC3ioXZgaWV8aGKKpqJOeM/3fcARU3OlI+B1Yhxu8o4N3o4Q4keFPQ/qMbsumrJiJXjXot2E+KPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061370; c=relaxed/simple;
	bh=Mzwpc9HSOPfDS9J1k9xeAWmoD+azW6P9PFcyGQzLf1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uH5tJoeYl8mO6Lt1F1luYCHZIfADr2IEAUVK6fGz9/J3uW8ksR+xRuxa//GUsz0N8H8C5wG3vY4HOSWUcV9YetgtRl3/Xbazox6nYU+JlNAU9WQMbzpo4Zvd4KIS655EKAY1WpmS6UIyU2/lP4qZPrSsSluLxwpm/nxpTeDi85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i6ouBkYa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42121d28664so7063845e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717061366; x=1717666166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma+zkUDMFmRGmAdFFiltA3V8CcE1ips8EycBhVAAsJk=;
        b=i6ouBkYaspgGtfIfk9V8EzysRUqBkF7Tze4Ln7E81PyZ2euksDTMy7lgltvNfT76S4
         LSYhCEllVMqjhOC5QKGRNLcb9rur5xEBaU7xXYiuzm1Jm0YSpqivutwqu65/gYm2koM9
         pIlmvJ0ekR+jwEuj1SHCjZkLmZM5MFiDLizJtRcB6hU27+HX6ZwHA4xumMy0WfjEAeNk
         i80zmMnmEwZg1e7mesbDXWW2aTIea8AKujRMn8KjeMuhUaH+y701PqkKDaZ5geo/huiN
         FP8EHkMighRauxgEZqLYP5uAg3wa9uSdO3NhLKrFsunfWWvNmVqnSjH/WIdAbnJOr6Ii
         r7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061366; x=1717666166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma+zkUDMFmRGmAdFFiltA3V8CcE1ips8EycBhVAAsJk=;
        b=efA8yzxBZSWmxCvNvOiJBHr9rmYabAn16NUmPb6gXt8iVpkVxNGkMk4NPFTaTHBj/t
         1BMyZ9FendRgCNL/yc+whStPWfZ86h/0D8BKN0pnnFJwES4qGuTJtM2RRh86MxJ7VFed
         z6tf/8xn3ET+mvoeb+1lKj2Y3ewUfm427UppDobc09ggHfZS1HVqf1WNFrM3tFfrYAmG
         guR786IdEexotkumDfGlNh+KwlN3JXVmOuxiGHHbO14W2WB50vVNFdXTdYPbeSh6HgA/
         /oN7ACDm9LYswu+zPzA3BTs8f6PhwIxjK8pM5Blq+0vRTQ338jXqVSVnbs/TqFLI0zjR
         WdwQ==
X-Gm-Message-State: AOJu0YwjKji7Mqo1UsY+Yoe/namDZPMr1BLQXdjVYqLQqFsbplpOaYxP
	4NNGQKvuSPIc73xiWx8++vnJJ/39xwxUxxUrTDAEIgcvLCJZfTHIOpd0mGXPALgoY2Vox/dlIoc
	U
X-Google-Smtp-Source: AGHT+IF/nthLELANpgmLRmO6xyVsD7IA/WH2LIwNU2QgfY56qcIKeDpZWXMGEctQ+ahsgnu6FOq7dA==
X-Received: by 2002:a05:600c:45c4:b0:421:c8a:424e with SMTP id 5b1f17b1804b1-4212781ac4emr19165455e9.10.1717061366464;
        Thu, 30 May 2024 02:29:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:aae:8a32:91fa:6bf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127059901sm19369075e9.3.2024.05.30.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:29:26 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 0/3] gpiolib: cdev: tidy up kfifo handling
Date: Thu, 30 May 2024 11:29:25 +0200
Message-ID: <171706136138.33273.12296733431611345251.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529131953.195777-1-warthog618@gmail.com>
References: <20240529131953.195777-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 29 May 2024 21:19:50 +0800, Kent Gibson wrote:
> This series is a follow up to my recent kfifo initialisation fix[1].
> 
> Patch 1 adds calling INIT_KFIFO() on the event kfifo in order to induce
> an oops if the kfifo is accessed prior to being allocated.  Not calling
> INIT_KFIFO() could be considered an abuse of the kfifo API. I don't
> recall, but it is possible that it was not being called as we also make
> use of kfifo_initialized(), and the assumption was that it would return
> true after the INIT_KFIFO() call. In fact it only returns true once
> the kfifo has been allocated.
> 
> [...]

Applied, thanks!

[1/3] gpiolib: cdev: Add INIT_KFIFO() for linereq events
      commit: 35d848e7a1cbba2649ed98cf58e0cdc7ee560c7a
[2/3] gpiolib: cdev: Refactor allocation of linereq events kfifo
      commit: 4ce5ca654a761462a222164e96b8ab953b8cacab
[3/3] gpiolib: cdev: Cleanup kfifo_out() error handling
      commit: 2ba4746b418dcffadb3b135657fea8d3e62b4c30

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


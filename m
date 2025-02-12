Return-Path: <linux-kernel+bounces-510863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B82CA322FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E946C161EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF52207A04;
	Wed, 12 Feb 2025 09:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EhzYAVWi"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D090207650
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354307; cv=none; b=iL2arZBBUANApFwQFRaCzJTh2FsEzmV+4Vo8Ko0SURDe2Evh6DIu4N8tS5MR2F1pFM9JXr4xczmtVPXIjzYYFtHUtd1Uz4nlJ8a4wSng27zJSwiBtkn7C+9QMZp88UJVoa20a/KFHOy6ovLfvlrCfcLGqWNwpU38/lkizm1/ez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354307; c=relaxed/simple;
	bh=S15E8A+hHFoDG1C4WcwtVn82iNSvGavQW2XFU/NyIIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QM/g9/IWVagUr9E1iFrvooOZCh7KqqlYqfbJE20EFOuMxn9WnAMXCgD6zJ4Eu0J5+1ecwh7eis1b/RSLnYa/lG7NH4KevlNXeFnn8Qmp577MicMK30W7esTA+eeyBlbsdBYjNZXGO/rCUsP5nPtbay1GELAIE2qJh0ivMOBUkPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EhzYAVWi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so45881785e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739354304; x=1739959104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXCdN+0JkkY18KL8OSU6hHNRFl6UAgJHQfjogbVCiA4=;
        b=EhzYAVWijvCdbsSuuprWmAysDztwNljyO42mkb4vw85NF2y6faxwbwq7sU16hZ+26I
         Kbw5k4wcK8gZEy+/zSqFFipoD7gAjRovbPPNZBZE1r12820nX5M4NoSZozjpbCXjVaYN
         p/62bJeMZMTPVrBxEnYel4FRzr9DBGzvjwhodcWH4L1d2R5wGz/BbxjK8yBI1tI3xqyT
         oYzDJAxptsxnqtRZ9FgtVe8nygtL4KRIQb6JrcBnfjvYxFelSG+lCZLbDvWw5HV3NFLk
         kiDZkHOstIlM+I1FaJlc+rYp+um7HWelWrvjnjYuHSQ0m0qCOdAOJ2E9EA+rNyfhyb6x
         gxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739354304; x=1739959104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXCdN+0JkkY18KL8OSU6hHNRFl6UAgJHQfjogbVCiA4=;
        b=VDMKtA7Og6h4K3Q0qaox8ia7yey+EZZdUGO26SYgW6NUJsxJ7wnzVG2prgsjt8ahic
         2gMzI02OThqXpFaaUWXWj0xq2mhwenSOsHps762tJiG6w1ai9yZ5aD6YaeeDP8jP/E4y
         Z2V0piP88yjxX/Mk0Sgc3HK32ZMLZocXm1BChu6qogbIdr81ChdLM+MGO00NsAS5yMbx
         gvXqHxeEwbNEO9kgQHoVlQFu4PlnM/0gWHMl5sZVjysnoQTnGVto1B3z/fBYNdsQ66ea
         2eHeQ8wTrB11CqUxWLQP2ipLk8ABJ/rm7Sy82V1ApsgO7Z/znWIHYD7DcZEsz2r2RB0R
         TfJg==
X-Forwarded-Encrypted: i=1; AJvYcCUT/d4GQ9hKfojZSGPee1myUXq45uu5HCLzjjlrzvw8edcpkhz1aDr9x0zySfVN6tlQp4tInHk4hniCx5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51CW21306bYc/iPMb3sQCOAdIjfp4zzNrvANGRqfioMTQPXsm
	oKSV02Jg2m9zvPFtmXF/JFF90uxk0dZm3JT6OiJ4U9jMWYT/5MQOih+/3O9c3PU=
X-Gm-Gg: ASbGncuVgrTbku0icvbRBZQV7YZGsyTk6fX8qfwPOSKrC9LM/Tiq0og06Y65WlfTVJM
	ACviBFOrf8yBQkCaX8sSBnfoOQelI7U27X5HYBEs4EaLLnPFjulE7D8j/DQzPzscODXGcZnmoCi
	W45fPaJpi9FFssQt/QwXHxDwEeCiqG7RukHlXTHzbn+ebEfcMTw9DSTqS+BcEOSzz4f81vWuUyo
	ZPhhSYB2+PtHH8b4eAnXsiva/aBZXnG0p1c8y1aWojJXLRp8YQOH2fjmy5YuUXF+ZfwxC9PPubg
	33186tHxbxCrbYQ=
X-Google-Smtp-Source: AGHT+IEC+Gn+QY0QYIabf+Hl3KXlYWU8d1F0mJV1sCSbwbfbBxRgth+shDbPFtARl1s9kroKk18pjA==
X-Received: by 2002:a05:600c:444c:b0:439:477c:cf73 with SMTP id 5b1f17b1804b1-43958176299mr29395355e9.11.1739354303696;
        Wed, 12 Feb 2025 01:58:23 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:521c:13af:4882:344c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dc5e6f027sm15055093f8f.4.2025.02.12.01.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:58:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 0/2] gpio: xilinx: Replace custom bitmap APIs
Date: Wed, 12 Feb 2025 10:58:22 +0100
Message-ID: <173935429949.14007.9294735731624784387.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250205093200.373709-1-andriy.shevchenko@linux.intel.com>
References: <20250205093200.373709-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 05 Feb 2025 11:31:09 +0200, Andy Shevchenko wrote:
> Relatively recently bitmap APIs gain a few new calls which may help
> to convert the GPIO Xilinx driver to use them and become shorter and
> nicer. This mini-series does exactly that.
> 
> Changelog v2:
> - fixed a regression in patch 2
> 
> [...]

Applied, thanks!

[1/2] gpio: xilinx: Use better bitmap APIs where appropriate
      commit: 2af1f667532013eb354c783514839f89d9923240
[2/2] gpio: xilinx: Replace custom variants of bitmap_read()/bitmap_write()
      commit: c11708e2b66b56f102bac83980a52661996c2a21

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


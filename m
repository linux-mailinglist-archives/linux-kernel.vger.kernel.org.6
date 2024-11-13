Return-Path: <linux-kernel+bounces-407911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49EE9C7763
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADD3281262
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7F020127A;
	Wed, 13 Nov 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I7Lg5x0w"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3902986AE3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511868; cv=none; b=q0E5DD5ICO5JRRi80vT0hm1cJ6iptzy0Pu7PQ4GIUw7VGy7F5ltdvQmCVQiX5SweAjw9hhgcLZPxNIYxIp0TspjvEuri/WTpjOHzDMU3UuRZ73za6f0VTToKfDjpHI8PlHTpFulos+lNCGnxgcHnqbfTtziocJnjzETau5esh0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511868; c=relaxed/simple;
	bh=dmowvGERgY4TYV5qsSHxo4jiVBehH9D2sEsbcb5smtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+dsw79rzJaQxHsOVa9etI+rtvvUsbbLTBdsxHFeWcTop05esKGPrS7clpInD9FlhHrM6VOu+b1bhTp4U9WVhjIneiXZat1ROf5tTOakfQmEPDyveAqRaXdC2WaKy9cajaeUCv88FxHtm+G3H5o11aG5aD20Kc9Wb5l0kl+Ldsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I7Lg5x0w; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so6402979f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731511865; x=1732116665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMJNZTmLIe3MG5xvr6+46zIRhs+qHa4NnfrYnjzTAzM=;
        b=I7Lg5x0wIAHcZ6dci58l/8hs1ZjAyZES5bgQROVuj2KBw9F73RbyhCZgDi4Kl5BlJc
         lFg3g2qCnf8Md+5J8IfbU4hawLo1cwp/Dv5ArfQ7dpBjKM/AgqIkntwbr7NJUsh/m6WR
         GeLQmdNscg8S2stTx6Ccz7Cl5mvtAvPsazjIysYcH2IVCFwIp+ojMxW7LbKgiP1qNsTm
         76WszN3j5wodKCpNt/nSlR/MYidMzPNe1LlwvBzejRJRs5px7U3DVsvtYDW6hULlfxhf
         7sbkeY55Le10Z9x/4kkzTKKXc5GPxdr8WdRtkD5cTkeAWl2J4ugvWobSIOzVNQiE3020
         ++RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511865; x=1732116665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMJNZTmLIe3MG5xvr6+46zIRhs+qHa4NnfrYnjzTAzM=;
        b=RjnrOx+W/hHI+vhAKb6NrGFvhRaQ/K65KRLWCz/NPauJbwNvwx+MIMdo+vVBOC3QFN
         5iFk6cxvYvsnPNn0C0tMAeyX/Tcwig0CExAxq07uxrnnZZjp4MsXtXn7rWyHYe8xdTAf
         LFYH94tt0e/xl8HS36SPjmB4RojQgMsnbCO7eCcprrNjRfbH8Yaqm7sJxgA4J1Fw0VFm
         nAbF9fhLBuk5PzupDprpGuqGFF4KCG0ZsPC2OhDrdbjB34wNSNgfx0Rq5oEX8V9qGU3A
         u72Q7RYO8cqcprMwuORPGt5WM+fAyzwIrz2yCmYglAT8beSuJNHPBQuGr3PJr3i2KutP
         JLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7az0SinJq/Mslq8rVLAVWMTUUiBHB9cDJnsh2TnVChTLFet3CYqg5tmDs7VP+uLeY4Ah42Cs/j5xqUV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmjL5CiJ6vXNVI19VcjOnZEpE/7d3KjTfimwEobEovHA01XtAw
	OJ19gaEDxcf8j9WYOO0x3HoBRciB+OYbOvHpiOGDCMgHa4gN3BfQi+Judw8F460=
X-Google-Smtp-Source: AGHT+IFop4B2M15TV4M/Ojfn9D+ufIi+QinReamX3IaIZlM1Ga0KQ2kP7PRAqEQj2HL2z7tEAYjZAA==
X-Received: by 2002:a5d:648b:0:b0:374:c1c5:43ca with SMTP id ffacd0b85a97d-381f18724admr22414229f8f.32.1731511865627;
        Wed, 13 Nov 2024 07:31:05 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1b75:191:f7eb:da75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d555908bsm27731205e9.44.2024.11.13.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:31:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: gpio-exar: replace division condition with direct comparison
Date: Wed, 13 Nov 2024 16:31:01 +0100
Message-ID: <173151185740.90976.5826366364572229214.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112201659.16785-1-surajsonawane0215@gmail.com>
References: <20241112201659.16785-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 13 Nov 2024 01:46:59 +0530, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:
> 
> drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn:
> replace divide condition 'pin / 8' with 'pin >= 8'
> drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn:
> replace divide condition 'pin / 8' with 'pin >= 8'
> 
> [...]

Applied, thanks!

[1/1] gpio: gpio-exar: replace division condition with direct comparison
      commit: 8f0aa162bcf818631e845c2e6c090c7b3c64fd9d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


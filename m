Return-Path: <linux-kernel+bounces-565542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F91A66A57
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077027A83B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B021DE3D8;
	Tue, 18 Mar 2025 06:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMxSZCas"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B6B1B4121
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278869; cv=none; b=o9SyaHbgFbNkgA3bgzf8wCOrgtmuWg1UkZiNFGV3aooFC5DrfX5OfK/ZN2PYtCyWjo4x5gB2ONzH2L41NFuXPvwu7HWzFZg4VpjOCjxV4NE44KXvCiLWEjF5ANfY67ITryQ8VrjCvbcA37CSi32KAAG/U++ATaN8OXEf5UXscr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278869; c=relaxed/simple;
	bh=TxPeX3DrmOPHchgmjyP95Od7k+hLM/Gr7X7C5WTr+A4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=PK6JvuTK8VE2wOZb51jX19OotTfba9ojevvcTSOzVlOsR7dawdOrtyKEAZ2QvoQSDkYjTvhlAM6XS7b+o2eK/yDiGJZSEdihtwPa60tueooSM6/h7BTi1JCN5ClnVHDugBQa6H9ZNZmgqrcdk/Zt2GCbAv3tFY9opGaBLgtt+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DMxSZCas; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39727fe912cso1244616f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742278865; x=1742883665; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpu53nh42i5pf5ZgjwfUkqGTj0+7zcXw8ix0nx7M47Y=;
        b=DMxSZCask5cMfLqviRlkoKiCA6xheFUkEuqiZVHAR/rOKwJhhuP3HZCFFxJf77jHCv
         STS2sioYMphmA3fJaJwKZNQ116aqIGwbwyqD0ddSknHuUrHwSQtg57akW9XTKsU73+iK
         qMZRPEz+wFwM8S2VzQ0QeOSuQNp4E70te8TcpB2SZNOjzdOC7AacgjZVTxUbA7mbj1d6
         vPWcWnaX5p9/EaWxQXHTVHnZr9Y5jFDfT716FAD1ntrKGH/VSmT+iksCmg0QbQtQFvZD
         rRZYK28Nn/eacbksjYlvUzcIWAinSsGxISojo2NXABzrNX267nZEef7lNcAYwU4oAZqH
         Ljng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742278865; x=1742883665;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vpu53nh42i5pf5ZgjwfUkqGTj0+7zcXw8ix0nx7M47Y=;
        b=SLDfsIMOjgsHUqzt342wLTWlGzIijvI04UCFma/tPrTvRJwzofVy7RAmEmqGKum9+R
         0ES7HKJq+pJdlm8+3txdYJW+tFgeDPnDC1ggqgbNucXCXiVfQslx//VVFn2G7gXUAgmK
         FjKj5IZGnA0YGlaW8M60Y1Ju9HHOuI2Cw4BnDHj3sgKOVTiNL0DhUKMwBH9tFZeihgeb
         rAZquBqYPXeikil3Lti8rrxINwMqfoWIUfndYBHYdz0uugKdm8xLztqE+HqvnJ6+71m7
         rGecyM4w95CDdv8/l5yb3TjkmT0qjmX+wBl0iywoxTXpfbO+vp+DBjLIKayUMcf392wL
         yxTw==
X-Forwarded-Encrypted: i=1; AJvYcCUgukU8SiIlQhUZEUUlO9K8NAgH2OPA6i4RypTwbptRtfCRadaaWYHBGsnr3BDY5ziEdeRKFIc7is4KkV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8V+h02FuDZFhdWqGctC4ccfN7VjC8InfX4vGkedSBi0XW4fe
	UeUJQKrZVcbuPFvpgusKzAqHahBeYe8NR9S78TmOdV/eR811Wyg96Xrznw3jpOY=
X-Gm-Gg: ASbGncue1PLX1KSYanXx3CCUCFDck4QCFm5JO7sh6ztp8nbCTKM9uuscHi/Es+aRKcx
	A5zUno+Ul52HMrVkeBi03heHL91sE2SGlA7IbWqsJMy5UXfIRljHWyYY9GeuyrVexoEQMbo4wMr
	XtpAzdxYO5VGJ8J1gim0Tg7quCwRgWF56EGL1JOJlFuUMfJDeBW9RY48buerWlieHQQHOVGEIKq
	udc2dnN3qfclq9YnQqqBRGWPtw2KFN5bMO1iArcUQTfepvfTbxEgI4j206IlOEnMMXE+56XdpRQ
	Tfd0rr5VbUgQPaMfteNyc4HCab86IPrDrpuSiWG/JZNXCiAdTZWbZQ==
X-Google-Smtp-Source: AGHT+IFmV8ri8McgD8SuHy1n7IpZVLiiv0FTWkc+zIL91pEGCeh4L4Esr7mc76X51YGKfSvE+jVJpg==
X-Received: by 2002:a5d:47cf:0:b0:391:42f2:5c82 with SMTP id ffacd0b85a97d-3996b446d67mr1853456f8f.21.1742278864982;
        Mon, 17 Mar 2025 23:21:04 -0700 (PDT)
Received: from [192.168.0.62] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda30esm127226495e9.5.2025.03.17.23.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 23:21:03 -0700 (PDT)
Message-ID: <b4a5c030-e8af-4724-a0aa-b53f7e08f365@linaro.org>
Date: Tue, 18 Mar 2025 08:21:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>
Cc: "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] mtd: spi-nor: changes for v6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Miquel,

Here is the SPI NOR PR for v6.15. We'll try to have it a week earlier
next time.

Thanks,
ta

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
tags/spi-nor/for-6.15

for you to fetch changes up to eec373688d91f7f8988702e36d4a0e07b8e782b2:

  mtd: spi-nor: drop unused <linux/of_platform.h> (2025-03-18 07:59:43
+0200)

----------------------------------------------------------------
SPI NOR adds support for few flashes. Few cleanup patches for the core
driver, where we touched the headers inclusion list and we start using
the scope based mutex cleanup helpers.

----------------------------------------------------------------
Cheng Ming Lin (2):
      mtd: spi-nor: macronix: Add post_sfdp fixups for Quad Input Page
Program
      mtd: spi-nor: macronix: add support for mx66{l2, u1}g45g

Miquel Raynal (2):
      mtd: spi-nor: winbond: Add support for w25q01jv
      mtd: spi-nor: winbond: Add support for w25q02jv

Tudor Ambarus (5):
      mtd: spi-nor: sort headers alphabetically
      mtd: spi-nor: use scope-based mutex cleanup helpers
      mtd: spi-nor: explicitly include <linux/math64.h>
      mtd: spi-nor: explicitly include <linux/of.h>
      mtd: spi-nor: drop unused <linux/of_platform.h>

 drivers/mtd/spi-nor/core.c     | 77
++++++++++++++++++++---------------------------------------
 drivers/mtd/spi-nor/macronix.c | 31 ++++++++++++++++++++++++
 drivers/mtd/spi-nor/otp.c      |  1 +
 drivers/mtd/spi-nor/swp.c      |  1 +
 drivers/mtd/spi-nor/winbond.c  | 88
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 52 deletions(-)


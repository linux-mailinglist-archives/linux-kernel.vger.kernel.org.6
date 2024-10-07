Return-Path: <linux-kernel+bounces-354129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694B993822
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204221F223FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072251DE885;
	Mon,  7 Oct 2024 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L6KryEch"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965A91DE4E0
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332557; cv=none; b=Hu82lZNiB/PUuesyxiWq6YKmiDHi+fy7QdVf0S7RqlpD+n03chYRiPbKHoSey4Q0ryDKOHQqWVvr9e+uEfi9PtGsuq188BWFhNFKB6S8Ktsyc+pj5YmbDKnhQBrEW9Eicdu1tpHAc4aU7CrjkhH2zdKTOtf6c6V47JHV46eW9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332557; c=relaxed/simple;
	bh=+JurRkojZY4EtF+xRmXEH88+oNqlfaBMDd8Nb4X/7hQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c3oej/vBneuY3KsVdzjHcmEJTvUhofu0Yvl9RmbEes4jXCkgtBb70Od/YBtXS4hyJULaXaDCk8HUXmESzi261CGmIjXOl7Z8DQj+RORw6+tPVWRsmJEyub2SiBBOLN78dPR6hyimj972WAOzQsoyYINBxkv5pHRFofeZ5GaQeJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L6KryEch; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso205424039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728332554; x=1728937354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QefVMDm8hBjPT+1JwbSaVFa7IKUqqLaGgXLC/P+/zW0=;
        b=L6KryEchvj6hS292mMNLvBuKS6scDoEQpsWzujALkWKGRh4Qnqj2JKhFbvAQWWl/mw
         VCmsc1KUaHgn/gZq3oLsq348QdMAfMB969zABGRZqI+ZBIJZkdVXCLY3yfLmghf+FTdq
         YWgjgikwcXddrprcM/P3vvQzaMqwENYgCJvtmz2Um48+TrrPurslUjW3ldWrOp/LFt9W
         nrhYzaTMQIl9Ft5LZykTnZjJ2FLLY82v/Q4b1r4PIL0TXsr0IYvvw2Zjej8i1TUUyXC2
         DtZsiZqAaiLEYgj/DvMDrhaTxjfteH9XHRZS1X1KFTFQrg9/aRHVqMxRJ129IadhXVyt
         bBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332554; x=1728937354;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QefVMDm8hBjPT+1JwbSaVFa7IKUqqLaGgXLC/P+/zW0=;
        b=Qx6sgSAT11LCXwe0Vq0EK/ji0e6DZUU/6jFjdK4gPEMOSbV5YfbUVh2vCt8iqq1Dg3
         nRYX18QD1SAt5ypjy6XERUGIsqs9n9/Ehy57AkQLDEQfH6bkSyW0mmsFAKiiLa1w9LUZ
         /DrGvHILURJ8A8ezf5eGwEPiTsW+D3MF7iFR+R5fiUCewO7H5Uf3girmvo8gLe2kQYtx
         5P4LHIJUBSK6zghsiqx51amK3Ajgt9Nq0D0CI23xm2Rspy8qaPnBjXVVh9c4nWMuNGGf
         5LuKlV5lSTaexyPAbjFSwVwLhEZkovhByRL8z0eC3+oDiDbbNDbfQM/zWklhvpBCQseU
         G9pA==
X-Forwarded-Encrypted: i=1; AJvYcCWbV8vFte1P5M9961W1ez2UfDFN9tm0AniaqcH9UUVDERWt8/LRLipX4uqtJDPYQJzwAp2RR4/loN7P4gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbckf5/JIWRWJc0EDrrijyqkxMBz2DkxrwzXp8v9mpeImLgvGD
	0DjBrDKU+T8bfKZ0OKXdmRW/jlDuXenXLKRcOV3tuwxDLoZtFLIPhAPCCLPfK/g=
X-Google-Smtp-Source: AGHT+IF2W3KnYL3GA1TILGogvaha8pYup4+NHEwZvTPOaV7yC6EWbx9hu3M/fgNeyIQEycR1C6cK/Q==
X-Received: by 2002:a05:6e02:1fc8:b0:3a3:44b2:acb2 with SMTP id e9e14a558f8ab-3a375be2a9dmr113900705ab.25.1728332554520;
        Mon, 07 Oct 2024 13:22:34 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db86e86898sm605463173.61.2024.10.07.13.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:22:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jonathan Corbet <corbet@lwn.net>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Daniel Golle <daniel@makrotopia.org>, 
 INAGAKI Hiroshi <musashino.open@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Ming Lei <ming.lei@redhat.com>, Li Lingfeng <lilingfeng3@huawei.com>, 
 Christian Heusel <christian@heusel.eu>, Avri Altman <avri.altman@wdc.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Riyan Dhiman <riyandhiman14@gmail.com>, 
 Mikko Rapeli <mikko.rapeli@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, 
 Li Zhijian <lizhijian@fujitsu.com>, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, upstream@airoha.com, 
 Christoph Hellwig <hch@infradead.org>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20241002221306.4403-1-ansuelsmth@gmail.com>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v6 0/6] block: partition table OF support
Message-Id: <172833255295.162249.16483920948700467749.b4-ty@kernel.dk>
Date: Mon, 07 Oct 2024 14:22:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 03 Oct 2024 00:11:40 +0200, Christian Marangi wrote:
> this is an initial proposal to complete support for manually defining
> partition table.
> 
> Some background on this. Many OEM on embedded device (modem, router...)
> are starting to migrate from NOR/NAND flash to eMMC. The reason for this
> is that OEM are starting to require more and more space for the firmware
> and price difference is becoming so little that using eMMC is only benefits
> and no cons.
> 
> [...]

Applied, thanks!

[1/6] block: add support for defining read-only partitions
      commit: 03cb793b26834ddca170ba87057c8f883772dd45
[2/6] docs: block: Document support for read-only partition in cmdline part
      commit: 62adb971e515d1bb0e9e555f3dd1d5dc948cf6a1
[3/6] block: introduce add_disk_fwnode()
      commit: e5f587242b6072ffab4f4a084a459a59f3035873
[4/6] mmc: block: attach partitions fwnode if found in mmc-card
      commit: 45ff6c340ddfc2dade74d5b7a8962c778ab7042c
[5/6] block: add support for partition table defined in OF
      commit: 884555b557e5e6d41c866e2cd8d7b32f50ec974b
[6/6] dt-bindings: mmc: Document support for partition table in mmc-card
      commit: 06f39701d0666d89dd3c86ff0b163c7139b7ba2d

Best regards,
-- 
Jens Axboe





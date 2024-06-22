Return-Path: <linux-kernel+bounces-225631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45542913317
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE012285680
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF914F121;
	Sat, 22 Jun 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="il2DHusE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB14A20
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719053765; cv=none; b=TPc1iQ54KBaT+Zwe1dK0l2R5tyfpxl3gWBfcaU9dMe7IZIYugRv+1tqHv4y6FGUARC4j2bc5c/Zwj+jzHEloXC+0FtXkaZb4R6LPnniXD5SS0VqDaxo5sQFC4Hu0UiRFDg7NfDDe6se6zFXmR0xay2M3dNZUqAQRRp2MZ4BQOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719053765; c=relaxed/simple;
	bh=1Y9HPEMcJ1iknaJTXV/+AMvmBjcveTDRVuINDy+1WDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hwbE97WqEmRLvuNrT+xh3acxpR7DbLQzUpyGQyGGj+NXNDCMgSJ8niLm2C0StrjbDXiEIor4TcvP45l0AdWMhgjjNI6QdKDZYnVaVGcn8VBZy9fRPhbXfinvayhov8TgybjRF29v/Y/bDqsP0rgWAa/U/pK0NOai9YMEZLRsfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=il2DHusE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-362b32fbb3bso1950750f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719053762; x=1719658562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzETEzkS1Fm2zJRno4hPag8+EngUbtNwZKOXH+RkQms=;
        b=il2DHusER/+bt3n31gb/fGh8ChcTzBq0d7vRbeoQRTh6U+yPGdBnW/lMXaDcoBhNyO
         Oo0dgipooj7iWPixMAIqWi41w1Clv0JnHB+pyXdIXF1wpHJ5DjdteISUetomZ+EzJw3W
         /H16Mubcx9GAu03lp9B9PyE/xlhdehSR5oMDyHEKkHCQe89V3qkOvuc5Mz9Aweduf9g1
         x7uoyBThOP2Pwe2b9WV/gXkTC1juWD3uX+z3STnnqge6wYLg2NOaVEK4xerRZnNyBAiX
         HkUgIUnWb4xvO0L2t+QmaZ7T3G/0UOd8swXBMK0wfagZU3wuEIx74wFUhRDOdfr/HyvH
         34nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719053762; x=1719658562;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzETEzkS1Fm2zJRno4hPag8+EngUbtNwZKOXH+RkQms=;
        b=jQwfsb4jpdTH6V787hHx8/pWC8cftCSgyFx+mJjsS7Yr4mr4SrvDsaKlZjyl3/h3cz
         66o/O7OQ/9PWzLzM/XoNm5ufFNQhShfHLhqeH2s9cQ67nqxf1fmau0nA1b2AfRMCq4/m
         piFFD8NV52n7r4Pmu9Wb93SF+XVla1Uv3ENHtBgAmVj6ZARBuLbVNwlH3AuUhZG94AOr
         y2+hLK7almAsGYgi6ASYOEaXk3XtoPhH4vJxrz4T180JKNYX82SVk75o+e7Y/yAhXp3h
         I7mzaUv7kUy664GQ/84UUMgC1bXOlyEGi1W50bgaa6iQmT6focU5/CClzDm2XD02fhD8
         J9WA==
X-Forwarded-Encrypted: i=1; AJvYcCU0DVB9rNnd2OsTOlarIJRNUA1jqjMTIjOzDCP8sd7yapokYOFtCgDGrHq5pc5377q75Yu4vn7YCJE1Hr/R1Xou4NspT5CspSmdv/i2
X-Gm-Message-State: AOJu0YxjP7BcbgyDfr0my4CYXzhfKOBoXv2TTRcBQrSIOy1lQ6d5L6cy
	mbQsB+ZGzDkpIRHpIhTJd9xeZTxj2ByQ9NkIpOxrbAU25CG6Wa6L3J9MubJMa4I=
X-Google-Smtp-Source: AGHT+IHnwj2xpZgweRvve1ZfwhHIVzDJ4mKsbzab2gI+BouwZgRbYq1HCA8LZtyuc1svC3odngOtOg==
X-Received: by 2002:adf:db4c:0:b0:362:8e0a:337a with SMTP id ffacd0b85a97d-366e7a5692bmr183107f8f.53.1719053762291;
        Sat, 22 Jun 2024 03:56:02 -0700 (PDT)
Received: from [172.20.10.4] (82-132-215-235.dab.02.net. [82.132.215.235])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f6ac2sm4205701f8f.76.2024.06.22.03.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 03:56:00 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Marco Felsch <m.felsch@pengutronix.de>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net>
References: <20240619-nvmem-cell-sysfs-perm-v1-1-e5b7882fdfa8@weissschuh.net>
Subject: Re: [PATCH] nvmem: core: limit cell sysfs permissions to main
 attribute ones
Message-Id: <171905375974.245384.16472026896696063319.b4-ty@linaro.org>
Date: Sat, 22 Jun 2024 11:55:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2


On Wed, 19 Jun 2024 20:09:00 +0200, Thomas Weißschuh wrote:
> The cell sysfs attribute should not provide more access to the nvmem
> data than the main attribute itself.
> For example if nvme_config::root_only was set, the cell attribute
> would still provide read access to everybody.
> 
> Mask out permissions not available on the main attribute.
> 
> [...]

Applied, thanks!

[1/1] nvmem: core: limit cell sysfs permissions to main attribute ones
      commit: 4eeb1d829b54d16ee5bbe9188e6013d424c6e859

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>



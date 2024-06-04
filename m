Return-Path: <linux-kernel+bounces-200498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF38FB0DC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104081F228ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29BB145FFF;
	Tue,  4 Jun 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPjRcIWD"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70919145B30
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499662; cv=none; b=MxEBsxUDKvovUMEZKvYTiAexV18VQKlFr4Zn6ZDl5hJdEMLVppkakL1+o8/ERlzncC+vyquiCREP4PPdz0mqlAIP+nzFQWxnRgfu6H4HTn2bpilvp/Ss3eJl1LwtOPwJVkUNQThIcAXjzUWo3zLD5rR68jkNntSuRm4hwWGtuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499662; c=relaxed/simple;
	bh=haMbgaVIsEsyr/UPAVi4Bnxb+AK3DC7n/7prdPRNVm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcHEdC3fDM3s/DjFR+bMC0bU7YZBKbt/v5wphX2gmlQaYxgFVLuWUK6eFtFGhYohu+1vs2OZwwJWMLGXkzH6j8577ZlMlzNxG0P8ulW79UxP7PJBsH0U6pMkqL7GRn7h7RQ1NYx+NivPtzABc0BsXxh+uCXl7IuJxW7M9rI4ZPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CPjRcIWD; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa629b4e0eso4870472276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499660; x=1718104460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPnqJm8iFqpoLsOaTzcZDLycrj8bZIRNRvSny5a6E1Q=;
        b=CPjRcIWDImq0Wd0V3gBJthySYXZO0mxqkciAZhCjadmgyGF3uAXfS3DzKbhLI132xI
         xmslIcpN7BUherZvdJKCbItHW18fzRO5lRnCf4P815P+uXi4WTRJKNZSoNA9XuAmRE2T
         kJssEmjkGbctWhPJo25mJ6hRYNuax3yBg99pwkt+tWzlPe9TOMV/4Sr6TXzptpPBQ2C2
         Iomd+HTOgzYpcBDriYXMIy7JQWyoJU3UCEZg9bzayVnnlsNN86BOGZl+l1DKrhAO3Q7L
         ssWRnJy8c9BhCTwReKAbg35vWK6kNaM2aHYjUeRdCkg02RFJVc8Oitj+/p8mctAf1Neu
         l4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499660; x=1718104460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPnqJm8iFqpoLsOaTzcZDLycrj8bZIRNRvSny5a6E1Q=;
        b=c68+7STs0H33Slva0hcHPg7ayzHMnFiiDPUQjJAV+BJPg7/WKLxUrmM8PuUDI5h58v
         wyMzPK3Lp5Twtu92RwOc1WeAXwE61CXmSnthYdN1lcV64PrSbX6dfsrANpEVmpb6uEDl
         X9QPeb+/2GOA/qMaGvwaxS1qJH2Jgpz8kRcWvcKaHxOujkW6DNG8ZdiqUjtGJ5Q/qUIa
         OeYl6jUOhogloqVXsfS+F+Odt/dYDTX41GuEHHnL1Fcp8KSvCWaM5+oI9rS5aqhrZ/+C
         c/cpmWgEvq/BQuuLfraAd9Db9jmxL8oucwO7btFIp7V/TZo7mi1lH+zhaawTJovh3tJO
         5Z5A==
X-Forwarded-Encrypted: i=1; AJvYcCX/UJDZioNkA0JyKsD9oJiD31VH0LzKI2HDM1wnKOr37A/ZQUEOCWn8m2UpcB63+F9OGtM8K2/zj4mjmMbsVTGi/JrpEZD/75V/yw0p
X-Gm-Message-State: AOJu0YzRIz/sNg1fhqlDgHdLzC7Ws+rsTZgWAuFRs3YH+9LEje84KD+s
	XWrk1NcfI++xDYhNI73ktL5oxj9fPUhqLnYN1KT0WhtsgQ+USy0fZcDcjkZCsNU6geA36hgIcxN
	EEMgv5l5C33Zer/NwdxqGwpz0/QKJi+2fD7RT+Q==
X-Google-Smtp-Source: AGHT+IHqiscP8khp5ZULf56iF+jRX5n/wA8/slPcj3pgkTkvRBD2pn5Q/QGyzDKGpr00CwDLyjPhF76bBw/18dRyrXM=
X-Received: by 2002:a25:b310:0:b0:df7:9681:39b9 with SMTP id
 3f1490d57ef6-dfa73be850cmr12727981276.18.1717499660432; Tue, 04 Jun 2024
 04:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717061147.git.andrea.porta@suse.com>
In-Reply-To: <cover.1717061147.git.andrea.porta@suse.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:44 +0200
Message-ID: <CAPDyKFqtV6-XYfDSLd_2S31zXZc4ayvuVHWOpic7iXNuj0r7YA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add minimal boot support for Raspberry Pi 5
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 12:11, Andrea della Porta <andrea.porta@suse.com> wrote:
>
> Hi,
>
> This patchset adds minimal support for the Broadcom BCM2712 SoC and for
> the on-board SDHCI controller on Broadcom BCM2712 in order to make it
> possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
> console through uart.
> Changes to arm64/defconfig are not needed since the actual options work
> as they are.
> This work is heavily based on downstream contributions.
>
> Tested on Tumbleweed substituting the stock kernel with upstream one,
> either chainloading uboot+grub+kernel or directly booting the kernel
> from 1st stage bootloader. Steps to reproduce:
> - prepare an SD card from a Raspberry enabled raw image, mount the first
>   FAT partition.
> - make sure the FAT partition is big enough to contain the kernel,
>   anything bigger than 64Mb is usually enough, depending on your kernel
>   config options.
> - build the kernel and dtbs making sure that the support for your root
>   fs type is compiled as builtin.
> - copy the kernel image in your FAT partition overwriting the older one
>   (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
> - copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
> - make sure you have a cmdline.txt file in FAT partition with the
>   following content:
>   # cat /boot/efi/cmdline.txt
>   root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon
>   console=ttyAMA10,115200
> - if you experience random SD issues during boot, try to set
>   initial_turbo=0 in config.txt.
>
>
> Changes in V5:
>
> DTS:
> - axi node merged into soc node
> - redefined the mapping ranges of the soc node to have proper translation,
>   and a narrower address and size cell number for child nodes.Child nodes
>   reg properties adjusted accordingly
> - augemented the comment in 'gio_aon' node
>
> sdhci-brcmstb.c:
> - removed unused 'base_clk_mhz' variable

Patch 1 ->3 from v5 applied for next, thanks!

[...]

Kind regards
Uffe


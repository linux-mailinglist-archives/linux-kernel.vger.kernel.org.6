Return-Path: <linux-kernel+bounces-427881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC38B9E0741
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BF31606C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB0220C00D;
	Mon,  2 Dec 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAXxGGHG"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3520B1FF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153078; cv=none; b=efbXLbo6//TgO6vnwX6JfkXW4jofvnoUL/J5L6UcqB67MXDtC1h5+8eZ2n+Yf8/95ShE1pT0dFeBx5aGs4xrzM1NhyWU6SyC7B+X4SCKNMeufyaDrWw5f6B83MhEnUQskW1jTfxbBdaqKjg3vUq3P9kkwFmQxPYwq6UOtrc4KWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153078; c=relaxed/simple;
	bh=AbvmyFF8iykoSM/f6TneHmi2O0lZAKUhiodIOq/hruA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWD8XOxdLi3PA8xVcbLF2VP5LHJ7iH3oPm0pjQNnU7aQNwml29KV84q+3dPdVr2eH4ig26DRuk09PKNXxWzuH6u7G/n7Qqy8E5XnNkc2ao7lkmwucCOmisEpTICGITpLzmxFTQNiHE0THllr87oH03Hw8b1ySJ2TyxOCq2ednVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAXxGGHG; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e396cc8c9a1so3345398276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153076; x=1733757876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cI2UHD0+iG63sk9WQguvFbtnOatRFiHDDSI6F2s+sic=;
        b=JAXxGGHGsuc01Aj0jXxfWP3IExpkpjjWnviWdPBffjIAQoOh6/hTPQxXq1PNBFQsbQ
         9LuR/ADWNK220IhAw0D37MaXEWcRdMtCvIddDNNM/PF7mr95UYDaErclL3O9VGZDPjDM
         fYy1a17+gjL7jzTGf86eyt3PWI9bWoLncK5L5wSniTk/1odKMfTzzqAj0Am62rMIGr2+
         xhr4BcrFFJaYawmblp62P7Eu8So3DzGcN/LKKJI9FlxyszcJI5wR1Lke0FH1lxnvXQB1
         FA1GKOtSp1yU08q9owlA7IjkhxspxNcB6wYzcNdAXjxsVbsxN12hVpulnWEvL0dlaUw9
         215A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153076; x=1733757876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI2UHD0+iG63sk9WQguvFbtnOatRFiHDDSI6F2s+sic=;
        b=byai5qeZEb4sYMQgc5PY3P9iK3qzQJLHLRvpcXg/biTsxBfOOCCyQWGssk5h4P9xZO
         Xwh0Ne8xQffsONuziPXtoXS7+JODBmcyoBZsUxVQI1eptI4zn0a7EVZnv8Bcr+LQpqhS
         Syg5A1Cn30+HBBR95auWFuMIBa1hRfdcjJMxGYUI7VGoEAWgJ+OcIOw02Tsjd39Mk9oI
         bHC8wyDHTxn2IdMgSGRCPfmNFV7reS6rCqABXWIHET3xign8X43GvePNWae/ahUhyNMU
         DS6fXG/rMk+xOJVRKgstb7HPzLbdEUbVO+jX5kYyRJE7RruHka955zwXXUy++SgCm+L3
         c8pg==
X-Forwarded-Encrypted: i=1; AJvYcCUWthpn32gp0KGwP1LVErDbM+6kemBum7jvbCuvfGxBZoysvAXqg5GpOf3WR4sIbsaE1s/g/J/IoWdVbms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45oylZZMUbDthhb+GV6qYT0Q6nD1U0ewfaUOKBHQSMTo0YBnH
	kbACwC4vgSgSx+IUbPUuFpCaVNB9pTsa3C397B6CtzHi9dInZpMYK8y1XruvoocE7pYM0ZGOKMc
	guGncVglFaH6Kj1r+30gpjNalSW+66NRdEOTE+Q==
X-Gm-Gg: ASbGnct1XJc2eg5da6oHNCB/dyxBYouTkxR8Mm7IImwQjxRz7/DMPXaVLS5Kke03tgF
	JoSSnH9Hi32HsGOa7KTZZ4/w8ob/P7onp
X-Google-Smtp-Source: AGHT+IGyxw199x8a/NjiG9xXny4LctKmTAbUkVdDlG8lJAJId3wfy0XNCoiRv0MlIrGKEJpAZbdNecDuMiCwsnC9has=
X-Received: by 2002:a25:d690:0:b0:e38:2b99:7f2d with SMTP id
 3f1490d57ef6-e3971966a52mr17352002276.12.1733153076156; Mon, 02 Dec 2024
 07:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241101101441.3518612-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:24:00 +0100
Message-ID: <CAPDyKFqNKXRPT_QonnJ8frY_OvA6FkEMyj09Ywiqhtu0ZL34Xg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mmc: sdhci-acpi: A few cleanups
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A few almost independent cleanups for the driver because of
> new available APIs.
>
> In v2:
> - added patch 1 to solve compilation error (LKP)
> - split patch 3 out of (previous version of) patch 4 (Christophe)
> - added patches 5 and 6
>
> Andy Shevchenko (6):
>   mmc: sdhci: Use EXPORT_PM_FN_NS_GPL() for exporting PM functions
>   mmc: sdhci-acpi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and
>     pm_ptr()
>   mmc: sdhci-acpi: Remove not so useful error message
>   mmc: sdhci-acpi: Use devm_platform_ioremap_resource()
>   mmc: sdhci-acpi: Tidy up ACPI ID table
>   mmc: sdhci-acpi: Don't use "proxy" headers
>
>  drivers/mmc/host/sdhci-acpi.c | 92 ++++++++++++++---------------------
>  drivers/mmc/host/sdhci.c      | 14 ++----
>  drivers/mmc/host/sdhci.h      |  2 -
>  3 files changed, 40 insertions(+), 68 deletions(-)
>
> --

This looks good to me, but deferring to apply it a few more days to
allow Adrian to share his opinion.

Kind regards
Uffe


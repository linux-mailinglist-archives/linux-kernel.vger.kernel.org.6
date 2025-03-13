Return-Path: <linux-kernel+bounces-558975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF6A5EDD6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C1317BB5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2675F22FF31;
	Thu, 13 Mar 2025 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="kE5HyMZX"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D78259CB4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853972; cv=none; b=KO/EVFK09M4wMuvPgsmKy9JyuJuVLMAK/dhx7uSNdrygaxqyhJ8QkwuY1glT/WsVjksWt6vWgLAJea6nsEpOLLTG8bag1AvrYKxNMmVqou/33T2zRQ6zMNbMQop/1Yoc694/KDy8j2gQVOHeYRObY3pxlsnQfkrQBEVrb31a+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853972; c=relaxed/simple;
	bh=KoEEv/IQr2Nh7rqjmNfTP2da2uHnnyRE8EbB3JuJLT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5ZsOlxutNTXVuUIbhDIZ0dj55p6vYtgg1aSRp0xxqAHiKwF+dyyilKUSn9rdxR99PHIJf69O1zG5sK0q6xvUILppfNRJHnAoDyqIfxHUAHSfnUQ4DEXTy/hjJ2jr3EMXuHOpQbLshYrtoLMwHHDbWOYGp7UhmaWtzCoNl9XIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=kE5HyMZX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2254e0b4b79so17268285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1741853970; x=1742458770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWEt0i+2shFRFdfbZiPgVihU5WzfabKYy6Z4Ak51Ze4=;
        b=kE5HyMZXx7dXAQGAGkl7HAvH1gsMoLM6R3W0gZpLuut8lxc5hS3f3DJNtAWIXR1fCi
         j5fqdQouyghvkog/+75mrCDmb4euBa9DTx+yrMPgZdBx5+4m44Z1lfuwhUcQymQGBD5K
         fPamU0PH22XUL2fT2CUi9fBlzdCq4Dd8jgpivMxAidSyy7wHAeg9lph49AcF5gHNwrTA
         BLb2m4z9eV1h3i+pgtbGQsPKJTH61ixBWfxG3Kxm6Pznv3nlHdxhNDuzY4Co59CoGvLx
         SB7p1dIFAjUdWSMOVWEUkY5PnbCyeIRVJKQ/VcsIep9IVeWcI9TfBYtS41yisDCpweUl
         qZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741853970; x=1742458770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWEt0i+2shFRFdfbZiPgVihU5WzfabKYy6Z4Ak51Ze4=;
        b=D01PCRZltbInm8zMhWXEPUGGFbbl0+6oVe74kFB3ngCqxa+GzAmK99DnHsrSSns5XY
         660D8AdoQ19MMlmWql0b8I55EpBgbqdXwwRqM4xFjKrjpt3ESbAZ8djOfHl1KRJvLVV4
         EqzY7PKAEUiKjEMA7a/GIARkDwFGB4x+KX1vxiQEtxGXJFnjXa0S/aScVZdwoei2Kwpu
         4HwV9d2BKAn9U3a+vscj/TW9Za2Y19Z4iqujFvfcQAyMmwYjVDRte0GuD8ZJFdq+SAtI
         spKrvreVJo50BfryFruQqyb/Eyvk/Fv02B+BuriimQyj59VeDTWt8xpga5Jx2nw4iWxZ
         QIxw==
X-Forwarded-Encrypted: i=1; AJvYcCUdd6pnPckWnsXS9ZgWlSFLysvATjKS/9epOEly1LFFT3naulFQyI+ESvfCvvI7khiPh4tJJLjkJu+/avg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86p6YLk5jyn3KFdm/hA2tD8rniHtlI3y7K06XnP5p8if31DOB
	/A6dUVuee+NYqQXkdef3LG6kfCOlXXxlU0mBTpIH/IgoUj64P3xup/6+vSqrOgQ=
X-Gm-Gg: ASbGnctVhpIyw6jFxCPBJvu5HbvXsasuKNaX1rUcfYpyy7bbe7hb9rtDfSO2R76Ra8m
	2A8y6zRVINywCKz/cHL011zozE17Opwh6J5c4UbTw9OMI+hMynEBG1sTsUAeJOoZzOb29RnaAHF
	g1X5/wvYeUvPelBmnoU9+QSX43B6OCqjr5zMSa+zBIYt9vqRWbTMj3uJixMYKa/YA6HEkwoFqcO
	Wup3feSzyB7XCCSpSRCERYXeVcAI3ls/2XIaGq5i91+weNKUAisXiL1aBVqGYbMMLkNQjz4foDI
	19uS0dsSK/fUuc83Z4ae2b0s+A==
X-Google-Smtp-Source: AGHT+IGvY/QZ39O2R90TZNOtRAufIJfxJ4YdpteHqgXktgzR2lShse5uenWthjfQWslvwJsLPVd98A==
X-Received: by 2002:a17:902:ec92:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-22428896a74mr388719455ad.19.1741853969936;
        Thu, 13 Mar 2025 01:19:29 -0700 (PDT)
Received: from x1 ([97.115.231.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3c59sm7843595ad.218.2025.03.13.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 01:19:29 -0700 (PDT)
Date: Thu, 13 Mar 2025 01:19:27 -0700
From: Drew Fustini <drew@pdp7.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>, guoren@kernel.org,
	wefu@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 0/5] TH1520 SoC: Add AON firmware & power-domain
 support
Message-ID: <Z9KVD1GKGKPwMR+9@x1>
References: <CGME20250311172030eucas1p12dda42760f751174e774b8d1a3d3f4cd@eucas1p1.samsung.com>
 <20250311171900.1549916-1-m.wilczynski@samsung.com>
 <CAPDyKFqeaq5xVNA=0CpMWSt_78qXJsY6+mpE1CSmLrVMQazAjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqeaq5xVNA=0CpMWSt_78qXJsY6+mpE1CSmLrVMQazAjg@mail.gmail.com>

On Wed, Mar 12, 2025 at 02:40:05PM +0100, Ulf Hansson wrote:
> On Tue, 11 Mar 2025 at 18:20, Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
> >
> > This patch series introduces and documents power management (PM) support and
> > the AON firmware driver for the T-Head TH1520 SoC, as used on the LicheePi 4A
> > board. While part of a larger effort to enable the Imagination BXM-4-64 GPU
> > upstream, these patches can merge independently.
> >
> > Bigger series cover letter:
> > https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/
> >
> > This series is versioned to maintain continuity with the bigger patchset it is
> > a subseries of. Please find below a changelog for the AON & power-domain:
> 
> I can pick up patch1 -> patch4 via my pmdomain tree, assuming I can
> get an ack from some of the thead-SoC maintainers.
> 
> Patch5 is probably better to be routed through the SoC maintainers
> tree, but let me know if you prefer me to take this one too.
> 
> Kind regards
> Uffe

Conor - would you be able to take the arch/riscv/Kconfig.socs patch?

Thanks,
Drew


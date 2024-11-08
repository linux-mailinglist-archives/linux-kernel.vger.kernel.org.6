Return-Path: <linux-kernel+bounces-401796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50A9C1F4D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A1280F51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C341EBA00;
	Fri,  8 Nov 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlFzGX/G"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985C194A68;
	Fri,  8 Nov 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731076394; cv=none; b=dz8WCaJeHQLSQzHTCZJsLidZElwhrKI3ahDkOwGyHX3Oqu5OgevynpTcQff6D95i7LxQ+CmJIgGz+GGOdH51OqW32p0lKbw40bo4b1HwvpcP7/hD6LBO1QzZXIUz30bo1idRIxBS+YCfQiopN+i4PYhv5iVL7AEz/DTBzIc14vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731076394; c=relaxed/simple;
	bh=QzIANtt6MFJtAm9Fyh2xfcDFCSxf058tE3VX25yTCg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2RoZj1MNGACC0OnEtsRwYZlJFi2KlvY2i5qAljCrYHfcZ3Ym2n800jKKR/JUGKAe+TjFjSMNOpoSubnTrx+kfHRgIYgbdF53bhwy1P88xjk4HF+6k4MlSHYuBgdUnMtJVuMeqJgRh4Hf5w8IGpMpBkHKfiw1HIzNc9gf6PoZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlFzGX/G; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so1609944a12.2;
        Fri, 08 Nov 2024 06:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731076392; x=1731681192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzIGKe4I0gwdT6IhaF7t/XIcwROf+ySP8Indd98HhXI=;
        b=FlFzGX/Gdljrq8MqFf6o5h6zgjCpwKNpNUvltG2eeN9cKk42GzRfboMK6day3iB+E4
         NHk62Z3jp/oVhDPkyoRnDRQvvVFg+BuoGy9OdH7Lm7GWHMQroSLVGYeunD0i74YcsXph
         WxudL8Mm1n4XlTtLzZtzowE+GlhOES4F3Nk9SqSZLCSYQf62ospGMnu7o62qMskfzRTe
         a1NwbCDtzU/H12i3jX3KzhjfcvHCskSEUzp1YnVcY+6DrEK7aNbvlMtXchn6HyqSHNrz
         BVV88IJ9Yk7PIyS6OWtCL92j3zVRvESc4U3LipXxkv8KlDjKycsnovi9ZqdvEZnk9Vyg
         djzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731076392; x=1731681192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzIGKe4I0gwdT6IhaF7t/XIcwROf+ySP8Indd98HhXI=;
        b=tG6fuYv27kUtzHDplH8OeCQEqG8pnpB9usavqN+KUmLvs7RZ76pfl+zEOSOgqDye/8
         wgvUR8+SclkN7J8DseUG6UkK2Jm3e7z9zZkwip3TxoxUVA7x1gCvHdnxp3XYdko5S+R2
         ZDr1N9zBzci4+ajGYsBNjAqAJ4Gp5695eNxO22nuls8tTj4AIiQhf+Ha385NNckZaXLv
         H2L1Feg4E00etaK1mgTYMrelFFf8hdn5v19UfV2dMetTdErlgADwTO8QL10DA1oyVAV2
         9d/JJPLA9rjL3uKMOs4oeS+miUmbiwSC+DjA7k88q4vy08IynrC+ISPfa+SsefzAOiA8
         LKhw==
X-Forwarded-Encrypted: i=1; AJvYcCUdFIeCcLsVuwhZR6/0ZFr1ntreLicgyhzbBlGeQC3j1iqENHe/HNXs+tnEsR1DxJchOewqbFqp8ERS3AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrJCF52lA47b6zz6Y6XQV4UFteBNY/xHeKWLxyHlaxAD9vJ7K
	xxC3PBda7ykdf/c2wiktGETKYmkpTc6PfVctsVvb05bo1f6LXAQn
X-Google-Smtp-Source: AGHT+IE4pSclE+22SOn4t5zbOxg10aUFH7ys0Z9wC98xMjNdq8MkT5NJI+24WBS8nBC9UV7IQg0TKQ==
X-Received: by 2002:a17:90b:3cc5:b0:2e2:eacc:3227 with SMTP id 98e67ed59e1d1-2e9b172b02fmr3662512a91.23.1731076392220;
        Fri, 08 Nov 2024 06:33:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f90bafsm3565906a91.28.2024.11.08.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:33:11 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 8 Nov 2024 06:33:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>, Florian Eckert <fe@dev.tdt.de>,
	Konstantin Aladyshev <aladyshev22@gmail.com>
Subject: Re: [PATCH v1 1/1] hwmon: (jc42) Drop of_match_ptr() protection
Message-ID: <a1504a6c-a3b7-4540-ba08-f1dfb648b8ba@roeck-us.net>
References: <20241108124348.1392473-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108124348.1392473-1-andriy.shevchenko@linux.intel.com>

On Fri, Nov 08, 2024 at 02:43:48PM +0200, Andy Shevchenko wrote:
> This prevents use of this driver with ACPI via PRP0001 and
> is an example of an anti pattern I'm trying to remove from
> the kernel. Hence drop from this driver.
> 
> Also switch of.h for mod_devicetable.h include given use of
> struct of_device_id which is defined in that header.
> 
> Reported-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> Closes: https://lore.kernel.org/r/CACSj6VW7WKv5tiAkLCvSujENJvXq1Mc7_7vtkQsRSz3JGY0i3Q@mail.gmail.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter


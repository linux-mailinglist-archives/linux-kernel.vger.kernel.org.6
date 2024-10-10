Return-Path: <linux-kernel+bounces-358440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0A997F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C12AB24818
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A3F1E8855;
	Thu, 10 Oct 2024 07:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VZaX7XK9"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DC1E7C35
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728545176; cv=none; b=DY9LxG7C9K9iWF02HjDUkI2D4ErFoPg57Ie/qF1kAy60jIcqHFp91vjUuLulhsaFaHK4jfqGldtZdBVRXey3yXXTTaTg5oCHeL88Fj2dbVweSEWXpBK38nvVidcqfK1uMvuc/xm4WWPWQC08Epk/MYHP559OSvubOGpbBj3jkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728545176; c=relaxed/simple;
	bh=Ybyjz5wLM3aHT8F6ATfkr4+lUHihxrdhi5y3HEe8Rf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcIISZ0AGNI64UrJzBr/2XZwbcxPkw6jvPE//Ju3j479toJY1Au/rwMkQ+cEKzyzTwJUQeDwzatqgTnVofVbQ4rKoBgt3VE+c/hopcKvX82QV4WivdpCOOAVFOb5NKrgDdTBdRhwPfixeMELs98upxxPWiVeabffF1uEl82fvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VZaX7XK9; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso514523a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728545175; x=1729149975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xn2CpKlZpFw1JRm5bw+GBM6CWvyGFQrA2wcnRi6mHVc=;
        b=VZaX7XK9hEMAEuhwMwp+J++wgdGB2ZjqYPjUs9+h4SZ9IVng5KX0dlnhwcFzUoF0qk
         IUR6LE2J854ELhUS7bdCPbinPmSfUQFbJxTK34UInsceiBKt1jGUBeWBhcj50AhrB+bz
         wnOZSWXwF0+QfHjMwPYqtnpcFJBvedDRU+FbIXCrwS1A7KGWShLtarNEzUtbmIMvmPfA
         NA7Cs89Nu3CZrWSLrNt+spH1VNCp9RKIMwIeiwtz/h9PZZF6Li/3eiL/oi+/VlDkDlOI
         PiG5S22U344jSz114JaZuN2CAJwBWy5PhiwjL++VG1fQTDcB3ZU4PUwMYi71BEa78dtY
         pZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728545175; x=1729149975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn2CpKlZpFw1JRm5bw+GBM6CWvyGFQrA2wcnRi6mHVc=;
        b=AofyR4CKG83r/cXTqnlEQXDtyIMdQKgA6ktVocJZmKUDe8jgmDkntEMRjOez2edPa3
         5QQbRUu9gJM69X6C1WRr9Bxa1BA4bFPTJHPRxBnIlwpPDZFQTViP7RDqleYlP/nLJw7x
         hzs66KZs/6Qx07FQpcykQG6CxOZltK9ST0V2F1JLrnv7Tb8oyb0JroZvqUDxf6Mk8dwd
         3SXNoaSPLkMsGdrwqjdOnelfwwB7P0VWURAFXOt+/cAj48VGc61edT86pFdlkNJfbHCr
         ZnIhc5wCxnStO1aHJzuF0bQNPou465aBVTw8Yt8Ci2TegtGNHH5LRZZSwiICc3h/X26b
         gApw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2S10UP5O49eKss+tq+AtsWaAZFk9nke7eC1OB/7qb7AFygvGqKyvOlCKyOvaaD4NmLTSN87pxUHIrD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoxbvisdqrtljCy1FObrX9rs/BZvGvNWvcOVJa1y94KQugiEZ
	xXOgapK5uEM8xwMDpY7oyyyAYGdHJFM3v0FezJCY6AvkOiwxwodBbzD64rTt410=
X-Google-Smtp-Source: AGHT+IFiZBkiSEtr5BZMJYQw0D6nBM1UrBhV66yt3kBIZCsjkzkw2a8Xy80d3TuxRDf5FdXMq5NK9A==
X-Received: by 2002:a17:90b:198e:b0:2e2:af57:37eb with SMTP id 98e67ed59e1d1-2e2af5748ffmr4687096a91.41.1728545174723;
        Thu, 10 Oct 2024 00:26:14 -0700 (PDT)
Received: from localhost ([122.172.84.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2b9483328sm2086035a91.44.2024.10.10.00.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 00:26:14 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:56:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH 0/2] ti-cpufreq: AM62: Backward compatibility for syscon
 and update offsets
Message-ID: <20241010072611.5zpp2tmf6jidko5d@vireshk-i7>
References: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-b4-ti-cpufreq-am62-quirk-v1-0-b5e04f0f899b@ti.com>

On 30-09-24, 15:02, Dhruva Gole wrote:
> With the Silicon revision being taken directly from socinfo, there's no
> longer any need for reading any SOC register for revision from this driver.
> Hence, we do not require any rev_offset for AM62 family of devices.
> 
> Also, maintain the backward compatibility with old devicetree, and hence
> add condition to handle the case where we have the zero offset such that we
> don't end up reading the wrong register offset in new AM625 DTs whenever we fix
> them up.
> 
> These patches have been in discussion as part of another series, which is now
> being split up as per discussions with Nishanth. Ref. the following link for
> more context on the same:
> https://lore.kernel.org/all/20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com/
> 
> **DEPENDS ON:**
> "mfd: syscon: Use regmap max_register_is_0 as needed"
> https://lore.kernel.org/linux-arm-kernel/20240903184710.1552067-1-nm@ti.com/

Applied. Thanks.

-- 
viresh


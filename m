Return-Path: <linux-kernel+bounces-448230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BD29F3D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5304E188C864
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573B1D47AD;
	Mon, 16 Dec 2024 22:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sgemc3+g"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6B861FDF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734386948; cv=none; b=B0VECWSi5xqnRaGlnJua8sjJE90TrwdAtzTVO0yvfGkcG5v1Y/iGnWMzBTixwKYzYTEViIJDAMpQhFM3BmcIclEVVBXaz4ukgQ2UylKAVSmDq85HN2o7BJC1DZG50M2aRRxIUr+RYMBDV+lGebY+XvxLzdkkhxbcG4ntV9+cFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734386948; c=relaxed/simple;
	bh=yQCX6UcMnDUp/ebrXSxVTtMu3+RTnTHd4uQij3XT5Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyh6JtpISW/8vkA+A7MLRs8/MyZzflczvxd0RTOHrAQ0cPPxXYDXYW8D8IgfDx0MBjof75MXylisdhTuy7lhHr2OKHo5gjwEgb4TQZ+MOkUH7ALNjQD181Me6LUS3O8UfWyrUIq2yyTaq5faXPf6fDxPLSdziFC0MQVQyVe8oMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sgemc3+g; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2161eb95317so42579975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734386946; x=1734991746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yQCX6UcMnDUp/ebrXSxVTtMu3+RTnTHd4uQij3XT5Fw=;
        b=Sgemc3+gA0yJazRkz8vKVuKLUzrjJrUwxqNkOgsv0kLB4QYSTMAb2ka1ZpT7B2fryV
         kElwhJATlKlj887EPOxGvLdanJbJ9OEPeDJodGBHY/6+Q8WlUPTZKHD4B5Bb1OjwAY06
         70GPgy5xD9/Kz685auKakv0kwTSYforOxCO3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734386946; x=1734991746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQCX6UcMnDUp/ebrXSxVTtMu3+RTnTHd4uQij3XT5Fw=;
        b=TILR0Z+p5Di8nkctlHUer5LsuNRLbIWODkBqZdvVIf2aOHn7Olgfd0sFS847X3YcfJ
         FpHHpD+OHPMZsHTRoRg/I82GebIzGS9moh+yFd/r+vOpiJLvDWT/IuITuKVDy1XjofaK
         WywB171X7tYiSz9DLI3FHkDjtFF2bv2o4KvSHVPofZR39mwc89B61JzUEAbd7AoNLWni
         +Oju607eC/xAKtPaD1zyWh1mVvp64t7KL6I76B2TFyw/Mv81vpA/yPvE/OwxL1VJ+/43
         zqomhnEWI8PH4CxHHNuzLGmWNx6jeyGYhKNaekN4rAD3H8KVoDUVUy4zQ5VyflasLVvy
         t3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU60r0Ih+cRXvqc4ewEtdxv6hZEzJJdNoN80HBTtEKe0971zzwaMVW4/kbqFBA+S/7N0FE57lXPhVvdtVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZMPVJT1bVxf71i3b9W1ctlkyEoxsTRn4RfaH78ZvMBSdCXjtZ
	zoOJSlN4qYETXVczLOIbWLoQu1Q4p8ELuL9NERurQ/yb7SQ6vMqc9AOZs0FyUw==
X-Gm-Gg: ASbGncte/pUbridankXt4vaR4Z4/nRUzZBVeJH6XBUTDyGdyElsXAAtUt4B2JEbzE/p
	FD5EoEv3SLOL9bhDoDG+Wp2giQ5aofGG70X6J0lmTVevqSBFuscjidKcsFt5dOvmqlt5sqkDySN
	lAm9t5vgeHbD1EX78UokbGBKksGYUXKA92z1y9I2siYcZNpE2UkbyPF24LtsEFqdU10bvcK/ucd
	mIXUA3R1p4W2NCCc2DGS7CkRyXPbfZffikY9ynyZiGyPNAt6SFutQ8xJ0H6qPWc7r5FQSQG5ajl
	zlG0jyE/TkAOlecfbQ==
X-Google-Smtp-Source: AGHT+IF0qnHFTodFMN4c/RNBWrM8LsGEcXlK4lpCa1SOJvQ51xusdNhWmW+BhonT5mL6jRMgbb0K1w==
X-Received: by 2002:a17:902:db05:b0:216:431b:e577 with SMTP id d9443c01a7336-21892a5bd14mr183701945ad.51.1734386946608;
        Mon, 16 Dec 2024 14:09:06 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:953:5b91:a52c:e817])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1e502c2sm46192815ad.128.2024.12.16.14.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 14:09:06 -0800 (PST)
Date: Mon, 16 Dec 2024 14:09:04 -0800
From: Brian Norris <briannorris@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] firmware: google: Constify 'struct bin_attribute'
Message-ID: <Z2ClAB6qY5LaMuHQ@google.com>
References: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>

On Sun, Dec 15, 2024 at 03:49:08PM +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.

I'm not in love with all these "_new" transformations that need a second
round of cleanup, but I'm not aware of any better way to do it.

For the series:

Acked-by: Brian Norris <briannorris@chromium.org>

> Please also note the remark at the end of the vpd patch.

I don't have much opinion on the options there. It seems like it's the
difference between an extra cleanup patch or two if we go with the
current series, vs. extra work for you with possible conflicts if we go
with your alternative.

Brian


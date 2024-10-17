Return-Path: <linux-kernel+bounces-369277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436669A1B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED57F289F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCCD1C1ABD;
	Thu, 17 Oct 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="w0pDHzmL"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2591925B2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148281; cv=none; b=qweFO377qHsXO3UsfyUsVokf9vvm7AyOwlciWOLczIqtADs+bQYv3W6uwZlmUpTuetqy7tdHVHgXAGmy3spbLxNOFyiJ16VZZDaYjQcVE8MLCRLtUtUrkx6tNyjlG2tdwpL9NBJtpwc06yvu/v6e7QLU5EfbJdmO3JKAucKuPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148281; c=relaxed/simple;
	bh=r8HBRYigN/+XvbW+oTD8AXO0DQD1lVTQq5dKYuD+x6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I87lxVROelHDkDPWzGJOVG7MmSL251W6ctzI0FDiCVpfmAWyoSUSBVLdOuvOSXSSkqlSTER1wpnKxgdIw+tfDDkk5gYhhr6yOZXReGMztErmQ+g/yj20sho/2yHp0bQ/lLAAcDy772p962i8xvxIn+X/SZGyEkh6EFRTHZqFPHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=w0pDHzmL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so5227075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729148276; x=1729753076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckFKos3k1VltrSwOBak8XGHIDoRaTtfm66p0HKqbknM=;
        b=w0pDHzmLtASL72aoQrXmSDbofOQScT5C+9d6nUL+PNQYbUTDfWknsHaSZhicjtd60Y
         N+JGiEPlU9/0RIskBheWFfU1DFAb7CKZYZvR8ggfEtpQK7QJR5lapFn0Ikw9tFz9OUQx
         iU4bDhK8aKO2mL5/6OxcS+CH0zOSmilLEbPNNnOENjGH7/pME+3vI4WrXhXMY4ZqOcEs
         aoO1+D5q7Kq/+QoKV/QOWGfJONTpgPEPtw/NXZ0bSwRX8uM0/hYWg5GA9wcAoxPSo8Oh
         q3f3BJM91O2OgH8MXhJ9ObsLleegSH4lQ/Z01nB5ZUNbxsA0Z4Rb9dl58qNmy6Ek4fo2
         KmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148276; x=1729753076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckFKos3k1VltrSwOBak8XGHIDoRaTtfm66p0HKqbknM=;
        b=I8AuhA5CypeBu0e5K5H68FlRDi2PYpkYxILdHHyVM0bBMEziiNuya6Vr4XTZ9ajNIc
         QCv0hURfnKPh8dXtHTx3Zf8VjBoJGPUcjjOeJXIJyWtpKg6B54N1Cx/ol18ultKsNzXm
         wZTuM1InFpSTz2RX+FqLvFsUTAtEFUdiipw1G4ZGNj9N6p1UYT7MEWWRqHbglf61Zs5J
         MHzoY1inSdiBOI58xftBD+3c55lgU/K/18KT9qLCQY986FhuAyI56/zFHCNj1bbmOzY4
         JDa5sOqL02GpuE+ZM1pBiGNChAtjnk+hBiTrEuK0MDBDJs6DMR8ZIuXQbkALT6h9+WW5
         TCaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPZBZok7XB18/EZQpqCSisOIQV7KHE+ZwJDYi3nLKcrDm+2Cz8pW//Zk+2FZZodjTsv4aFFD4zMXawhHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHJNpPM1/f8iG2x9XX+KmcUfe6/lAnwSECO/YRIraE1ehalSg6
	kjAzfGawNk4ZetRn+3bExFBSUSiQXP39lftidNq6OsuAXvvJRhb6w4ozeiGvOT1PwWBVtxSRTWA
	R
X-Google-Smtp-Source: AGHT+IF5smZC8b0wY4inas9AaPOtU7Yrj9ZRKnkfn7nVxxAqqq11LfJ7fYy7cHx8Px/CGhevjvbWTQ==
X-Received: by 2002:a5d:4947:0:b0:37d:4afe:8c9b with SMTP id ffacd0b85a97d-37d86d5fec1mr3741945f8f.54.1729148276457;
        Wed, 16 Oct 2024 23:57:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87adasm6260026f8f.29.2024.10.16.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 23:57:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: amdpt: remove remove()
Date: Thu, 17 Oct 2024 08:57:49 +0200
Message-ID: <172914826142.5858.17899543810767806657.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014092909.90607-1-brgl@bgdev.pl>
References: <20241014092909.90607-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Oct 2024 11:29:09 +0200, Bartosz Golaszewski wrote:
> Use the managed variant of gpiochip_add_data() and remove the remove()
> callback.
> 
> 

Applied, thanks!

[1/1] gpio: amdpt: remove remove()
      commit: 9a94580120bff8040e84e2d500f8f462f8704dc5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


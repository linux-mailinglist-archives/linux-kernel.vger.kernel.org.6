Return-Path: <linux-kernel+bounces-390514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950509B7ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63601C21E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32A819EED6;
	Thu, 31 Oct 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jri/CprH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1856519D07A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378307; cv=none; b=OV/j0xMrJAAFa4Ys3BxBMdtHIYGmB/6IYlC9rCvnd/TVGXZohy8I9iICZB6I+MwZbFm1CPlViuoNVc2mcktsXQ/CUNsE0RLSogJ4kdVjeMN3hSPi7bm3t55ES2iw4fldtiXKpOUScImfcTlxBWWLa6FcSaw6oCP93pDCJ2254mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378307; c=relaxed/simple;
	bh=1cJTeyzn7vDLqCc8PIINomXm7QXgOrkmmDCiJ2+ovRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbOLgR9n9Z5RTGGC5+YgykhwDMcNP6N6Lz/JhVLCDMO8WtoIQ++bpk5xASKGD2qU7+vyZNjTFjVNhHc++d7hiGWlo0Av55WaFFWA7DrrXSbYxj6igi61kSF+0Hy7tRthLaOipTEvzWC3nccGcuptNtn+mTHFWUeH7ZdPCCIePSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jri/CprH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158625112so7166085e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730378303; x=1730983103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmBF5h/TWefDrRULij++C6U7yHFjsi/cLL82N9hFyCw=;
        b=jri/CprHhv++bxYADekYZ/5DOINN/mphtP+neVuQyCIDIkGxaq1Wks1xVaICPyskbs
         +ZyGyHCXaxsAZRDoW+dSxO9Rrafj9STcw9CIHRZ/faDpTROc6Ss+ddy8aX5uDmKGmXVH
         NCPtiy/l2RVVS7QxvBeuNXz5oWfnmCRqvZyh0u72l0P/xx/Hdo6rh1HYMXQA9jGjuNb5
         Rsd4AdLn/bOUYJFqL+9o/pUN/xN5fY+3g2CeNS5V3D+FaZooRPQH+MXrqkziajaVzn3T
         4noBKFf71Vx1PKGor+BXhbJg35f/3n4Tf/nAtNZv5QID1Nxdwzunk1qBpuaRSsZ1iska
         bh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378303; x=1730983103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmBF5h/TWefDrRULij++C6U7yHFjsi/cLL82N9hFyCw=;
        b=TPN3MtZru3w/nJCxzPQobfaTzeJRNxBApQnIjcQBvstB6VymOwKMK9nLtkpQu8p9R3
         TDVz/9VWdFxrbIHbE9wmGdf+rRm41QCGEjuJYGmYf4t/cZ8RA4dibBASO9vPAL1AnbkO
         5O+rWuPfYVhVwdnL/UcSxSEyUtPZm5Ce0YOWFikzyO0ApL9tpf7161orl4L92DVA0pK1
         5zFBWSF+bPbdXqS903nFLqZn8DGeDKz0lGJUcsejgEFgBXOpdym8LwDiTNk8Y20pN64X
         Qt5pY4XuUzYQu17AbGy3ZtAq1i5/lNEX8/y/aP51rSahsK0A2lV4Acc+SIYHSJVWsoVR
         Tm9w==
X-Forwarded-Encrypted: i=1; AJvYcCUrWg/UyW+LMJofkwoiXNwTEezS7PHsesxJqt0ARrToXv5RKXhAJo4re0nDGY+0dgN1WvKSnM/aP8f3Ny4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/SDC+cLdL/gDNMpheUvMPkfNzpToDQ4mVXfH6Ztzmetgqwf0a
	GjKskMM7pGHtkNWrL37/qnN7ga8U12bf3x82O+5VDgY7ncHXFzT5bqICEkEMm/g=
X-Google-Smtp-Source: AGHT+IEQ2s2Wn1EUmBJ4pYgNUgAtY8LV8iDEw8uwuEQMEgFeh5e058Ixt31/ZtENFYdEnTHUT3w/Qw==
X-Received: by 2002:a05:600c:3c9a:b0:431:518a:683b with SMTP id 5b1f17b1804b1-4319acacb3cmr148709535e9.18.1730378303342;
        Thu, 31 Oct 2024 05:38:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a6bc:32f9:21fc:be97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bb78b809sm67432055e9.1.2024.10.31.05.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:38:22 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: dwapb: Add ACPI HID for DWAPB GPIO controller on Fujitsu MONAKA
Date: Thu, 31 Oct 2024 13:38:21 +0100
Message-ID: <173037828242.6687.4733700709962580211.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018015640.2924794-1-fj5100bi@fujitsu.com>
References: <20241018015640.2924794-1-fj5100bi@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Fri, 18 Oct 2024 01:56:40 +0000, Yoshihiro Furudera wrote:
> This patch enables DWAPB GPIO controller support on Fujitsu MONAKA.
> 
> 

No objections from DWAPB maintainer so applied, thanks!

[1/1] gpio: dwapb: Add ACPI HID for DWAPB GPIO controller on Fujitsu MONAKA
      commit: 4f61d7fdcbc422f82acddf33cc966a13de577ce1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


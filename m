Return-Path: <linux-kernel+bounces-300078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C63C95DE81
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98ED1F22390
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2A176AAB;
	Sat, 24 Aug 2024 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCvKE3Kw"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED65C8F62
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510623; cv=none; b=ena24/w+PXXrlQb0D4Bgia1ug06xt9Xn6XtK85+wlJX+5oEUesBnPbOQ5UfMW6lG94+cfaxWb40oCvG03Jw4f7SU8w7Qgay4AMsvas6kilVCTUDHNBK0Z3p9/uGlWwp79ZP5ngq4Xm/CKhs2jEvOsNBPCA01wALudWD27O8nBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510623; c=relaxed/simple;
	bh=TG/Q635uFGX6ibz3TtyerVGS3vHIeINHxFOb8QYWcCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaKJ1VgAh9F3A17R0n5uZpLRQo71xq+JCVrBzj/mg2RoqVadCE6WtG/4YQXUWpIPXuJy/YIp9lkmKv+SKEg16chlOlqdurkwQKwqQVGFDTw7/9ItOGZTzH9JcIxvlhiqypWB1wpc8AUDNCpvl6UTyDxJNjoS5Gu7mZ5MENnsv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RCvKE3Kw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53351642021so3176496e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724510620; x=1725115420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG/Q635uFGX6ibz3TtyerVGS3vHIeINHxFOb8QYWcCg=;
        b=RCvKE3KwgPp+3R2Y5oyMruspdUzBEqtT1uyl4YorwiWu1H/kaGpX0FSc8+LbySgNfq
         eVyFMSmIOUmQ5QVJt1Wt46AgfFSgWajs8mRDQaNr4AcWJax5KseAdzBd5uUCC6659EA+
         GHWGEhl8LNoDIV48zIdNaYfm2HzahTKZhUrEhJSM4JR50yXGUM/1oFP7tjr5X4/Jr8J7
         K2OdnHByzsfo/Mw1MhwzyR/fj/KqhUSKU5oOIAsuK16C1Kns+5urqajgWraxZmrNE1t9
         Qw+kb4IeVBJ9lPU7YZ0X1FA5iFIUP8WTE9QTQS+Mm/Konm+WwqxNXQ+eyvZZhBdlTTOs
         BRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510620; x=1725115420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG/Q635uFGX6ibz3TtyerVGS3vHIeINHxFOb8QYWcCg=;
        b=SCH9hAjb76OoTdtCN3CuNZkobLJm6prjvjTosaOl+iN+MV2Bn7vsjILW3mOH+47y4P
         KlUWEw5NxfFe+e17TVfsiZOpumAhBZG4HTS8iM3w5hSN5b1eDwb78J63Pq9siRCuo8e+
         9iZ6YfEXLhPlfzFFg16xEk7/tz6ngtA5melQ8FUdoMF9Dna6PI2CTiXOPEdUYgUdMttn
         tEHU8gHZqp87OJybbO9TH0tWhGQzhwKgcWi6/HJgSCtcB0enrStnP5492t6QEGtBmZIz
         KbAbZp0stwEEpOP7Txia9cgOaPVOY3kiI0wRmj5YIXSwTADGLC6PSa+K8uESgmptkbFY
         Le3A==
X-Forwarded-Encrypted: i=1; AJvYcCUgLzVm9H4umNwXuxQ/G0mwwlKAzjJIr+cCMrW2HteRpIq76XkcRGl/rrskZ2z41BgpL6IHwnBi9Rt2C64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiT3VDc75BFS8w0iE/wrPsSYnpbwn2mfaV4Aga9Lul//eJRKhu
	iEK+28rjsrnz5s+V6LNmwhvpg/Lj8IC5N69gMA404DGl8R9G2zR7vIirz93baHrnJrVkqx8OR0R
	cJP97ifKXt/CgZV2tNOIAKCL5tIXGFmLxiWcGKg==
X-Google-Smtp-Source: AGHT+IF1Lb1IYekbSwByfy+rWqqhhcaUglxVrpppACcE9AnsPrA9/GqTgMiYryV6a1z6VO0NT+wvEAYG/Ss8+fd6IzM=
X-Received: by 2002:a05:6512:b1c:b0:52e:987f:cfe4 with SMTP id
 2adb3069b0e04-5343878551bmr3688925e87.30.1724510619375; Sat, 24 Aug 2024
 07:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240819142945.327808-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:43:28 +0200
Message-ID: <CACRpkdZosbVKr9nY91oMTQUcn2zrm2t6ZjxQiyQbwQx-kt71Pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] gpiolib: Add and utilise for_each_gpio_property_name()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 4:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There are a few of duplication of the same for-loop against GPIO
> suffixes. This series addresses that along with proposal to eliminate
> the exported gpio_suffix_count by converting the array to be
> NULL-terminated.

Too late to the show, but excellent patches Andy!

Yours,
Linus Walleij


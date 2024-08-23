Return-Path: <linux-kernel+bounces-298342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2395C600
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E720B2309F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B74CDE0;
	Fri, 23 Aug 2024 07:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="q8MVZkYs"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B517984
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396617; cv=none; b=ZQpO53jPuDLMmWzBmaYW2C6OZAGD1ABCVTnSd4J5wJie/kSmFfVqrZu0y2vjTwXJlwEt7JvRdum9+aABwGvRi1mopYweRXwN+OeLar3bq9kSY3LSb5vxjn3GQqQ1WH59WJw2cIL53GiiF1G3Ou7SGSOS84aaltAqokx7Cdm/AZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396617; c=relaxed/simple;
	bh=ZJjEvnc2xFf03BS3XNIITQW4HsX6QFf0Qk0nXkaJIHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T74CptCb3pxYgzn6LCdOc5qx2MGC83lodeLg8X+mQ2TJldzUIzhHNEx3C3MMImR2mMutwK23Lp1P2Qg8SEOeyswBsfF/5QslNE0B3okKQ4sLIKvVBU87L9hT4az8oB4b3XGVSdxAEHGeio87xfPHivxC2+L8KJy/Myl4vlwBSeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=q8MVZkYs; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53349ee42a9so2022150e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724396613; x=1725001413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=631IyQQFrTSi5qSS+uAt8xZOc4toTWziEe/GEentgL4=;
        b=q8MVZkYsge2fls15BrxqKrDWVwicSZ9Rm0s5Nje7zkymQpTkbbL1d5Sx+3t4rDIxVh
         XeTzZNSitI/jN9riawzEHZS4lgVAHnbnn0QA70pFHI+YsJpor24Jz0R+mb9XZL4bjUtE
         Fk31S/9uvCUcmGFXhrTtgpS/O38rqUmv6sdU9QzYQSJvTnd74eBoSgBQEHDgL5CdOOmx
         2gRiQSoE/6COk+FXwqdlfBql8lsPQmcz9hYzLLCtQIu4Rsf7aFjRMgAEHe/rWz87CsdR
         mtNIvC1sZfFQt/yv7rEA/RyB9GhX7SdDUNQJHL/bpbJkA7+XPzz5pqe4gq83MD5u+wX3
         0jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396613; x=1725001413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=631IyQQFrTSi5qSS+uAt8xZOc4toTWziEe/GEentgL4=;
        b=IszxcKHcwoS/5lR0BzGJsr1NNrNmf6F4M3cCOo3E/XfucsmEhhKT975VX8o2PGO8BU
         NUNXOOVtbe5jzqyJIhhcO96mwwvONDCL1r3Y2y4t+Kymq5578FP6AlWVnEwDC/zFjSb+
         bj9MxlYBZeRuTR/X6sXOrGXiPVkVnWDbiQyzCE63uqD+GS6bwWMWrOBZ54XF7ZAo4OiX
         5UO5Xgltnyf020tryoy1dy+wli3Hlijal53s2MDf1yWOOXycMX+iMiOc/YYK4BOseVzV
         CZzJGCU/duBPyMvmilCw24ypdyUE7+b/CxMs2va7z98yjzFOGd1LKaQre4qxRERiK6/U
         1lKg==
X-Forwarded-Encrypted: i=1; AJvYcCVM7sgAXrpoVv8NIdDJLLt3B7I3kyvlAGFlZSzefvRowCV79fmt9j/0g5ICJSRJ+7fh2OOMNZhRxBPCYiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB1c/VxwMOEv6jk+9IbWdhKSCCRTcrQWzzDCSXXtUnEFe5+1v
	18SI6yiMpGrSenK6CQEee1E1eVzb2ndwQwFv4sjAGNz/pXi4tRE/zNV4guhDrcd1GUcR+9XDHb+
	RJAbef43GoD/vGpFSFYFmzlDDfX6Xgm4LJJA1WA==
X-Google-Smtp-Source: AGHT+IHY49T3oJIuQgQ/+y4wG4KjjwuaGjX4iUjBSV6dFDznjIAjomIHYM3UH7bhzmqjoQsvR5HkDstbYmlY4IRkH+8=
X-Received: by 2002:a05:6512:3ba3:b0:530:ad9f:8757 with SMTP id
 2adb3069b0e04-534387be3f9mr814471e87.45.1724396612600; Fri, 23 Aug 2024
 00:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823034314.62305-1-ye.zhang@rock-chips.com>
In-Reply-To: <20240823034314.62305-1-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Aug 2024 09:03:21 +0200
Message-ID: <CAMRc=MfsSXXu5uJE3FjvpTeEJEkLYwsKbiQdCO=d7L50cXREzg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: rockchip: Update the GPIO driver
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:45=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> GPIO driver support acpi and new version, set input direction in
> irq_request_resources, fix division error and debounce config error.
>
> Changes since v1:
> - Split commits with multiple changes into separate commits.
> - Adjust backportable fix to the forefront.
> - Modify messages of some commits.
>
> Ye Zhang (11):
>   gpio: rockchip: avoid division by zero
>   gpio: rockchip: release reference to device node
>   gpio: rockchip: resolve overflow issues
>   gpio: rockchip: resolve underflow issue
>   gpio: rockchip: fix debounce calculate
>   gpio: rockchip: Update debounce config function
>   gpio: rockchip: support 'clock-names' from dt nodes
>   gpio: rockchip: support new version gpio
>   gpio: rockchip: Set input direction when request irq
>   gpio: rockchip: support ACPI
>   gpio: rockchip: driver works without pinctrl device
>
>  drivers/gpio/gpio-rockchip.c | 297 +++++++++++++++++++++--------------
>  1 file changed, 181 insertions(+), 116 deletions(-)
>
> --
> 2.34.1
>

I think something went wrong here, the patches are not numbered like
they should.

Bart


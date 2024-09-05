Return-Path: <linux-kernel+bounces-316941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A9996D74D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CE9287ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E2199FD2;
	Thu,  5 Sep 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzZztii4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C25199FC5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536171; cv=none; b=UFT5EtcQGeNEDLZ2ydSGn9tgTKycjkMJZYB4TyZg0LhTI7bebLxzJf4L2sdq2VS0XdGuLplDFySlS5zWM/7trBVn9+CAQwlHHpBjlA1VASwMICVuZLbmpkKUgpb6f+WqgEYs1/hYi1dLHhlBk+J23nG1tAOo+3N8t7nkXl7QUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536171; c=relaxed/simple;
	bh=NqeRDA78MQ3vDbts7pFKQh7mMRZQyPlxwYc8d3EH1Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgBk4kE4Ko+q1oGAtoXxzMD3Nd4j2E4QUDPvvpo8VDnphK494MCKgNjS9HZ7tnZ8xcuIF1pMWnATvQ/UauiGK5oyOJzj+o/8p0WpW5j+ZKtLblQFYTxSlWwDMa6OmDJp43gz8yo+aVQuhismu9M6UYWBjY65rl1L4wgK73Wbwr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LzZztii4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53436e04447so587635e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725536167; x=1726140967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqeRDA78MQ3vDbts7pFKQh7mMRZQyPlxwYc8d3EH1Jw=;
        b=LzZztii4Inen9KQe2sPVFZHoGMFK5CwZ4gLyZkum8HoS/EYvYcngwkle+RAll3iBLb
         PcJmUXLsoPhV+XIDJpoV0wuELaVFRkLLBMluFx5Rh3hmH3quy8vNN0sp5/C9ykhtocW8
         mtVyma8urQMODwzs/n/v4ULPAIMN+nb4tHqXKLrCl6olmKbX44AVIGn+ymN6NFzeAB/D
         BRWRaHgIy1sjixE5We2l1F+4Cf1mOSngX+Lg+Eik7KnsReIgDZlzH8LLovPM/t3Y5uHA
         ptxHSaLIS/YaF+0LbBXzk0YAPJraK/UbUlozTtUSjohGzTDYhxFo0KreFe3ffyjB2r5T
         KbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725536167; x=1726140967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqeRDA78MQ3vDbts7pFKQh7mMRZQyPlxwYc8d3EH1Jw=;
        b=ayxCYZm+6IrmJSZxcx+YlptJn2QWA6AxtkMEJ6OVG0lKIIjN3Xe6FLZ3vbkvEZB4Ic
         d9mxx81c8F/l81iRlegU4OdmWQfQRRcDcBPaaFtp7Jvu97PStPZLkCPPH9a/7k2nGVMG
         I+MP7yEc9xqqsboXKDqMug6L/IanlQ4ee/HC5M12FF7lPWe0XWE1oSOAfyaxu2ikvkVz
         tjTAKduwuvX4PRLpPibjdGJa8zGJXKZnmK9XY0hhWJ4XuTO8Et9Agj0Pv5C9DWF+EMD2
         H2Xu5vH0YGkTDYYU5kFihH9k8nR8S7kg3/3XkDfTgZeVtD/AmabvguWX3Dva/cEZgDAG
         jKrA==
X-Forwarded-Encrypted: i=1; AJvYcCWGxhZZD+0xalj/8+JaPk8upKHPT3ef5kFqb+ZyHioBeqQw968k40xCuN8CSnxuRZfX819UQB6cWWBU7iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg5ipuw+yIwfp/JkAJ2Ma5fuxdLb4bb8+NV9a7JvF0LjLGKDgf
	oGu90gWHjGXkOUUAxrFUUNVPu/YF+uztcVWafLLrzboYOa11Jj1jn+dPBCCrsclZp/kb3OI7o4W
	mRXFfyzxcehFu0C91J4SbwZAVGppw8/C4+NXFM0p6gZHy+FoLh/Y=
X-Google-Smtp-Source: AGHT+IH6BAyVUQLsDBUDRzOGArnxNvle63qAlyD9+MRHG/ncJc96g6GOqqfS74OGvIepzVBwxVMAFqSF0JP9xCZokxI=
X-Received: by 2002:a05:6512:33d0:b0:52b:aae0:2d41 with SMTP id
 2adb3069b0e04-53567798531mr1471780e87.28.1725536167312; Thu, 05 Sep 2024
 04:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902133148.2569486-1-andriy.shevchenko@linux.intel.com> <20240902133148.2569486-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240902133148.2569486-6-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 5 Sep 2024 13:35:55 +0200
Message-ID: <CACRpkdZWhWHjghg4NP2O0Jh6=gh30yt6EL9fz2nkCuHSQ+A8eg@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] gpio: stmpe: Sort headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Sort the headers in alphabetic order in order to ease
> the maintenance for this part.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

